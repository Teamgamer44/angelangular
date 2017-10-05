import 'dart:convert';
import 'package:angel_configuration/angel_configuration.dart';
import 'package:angel_framework/src/http/server.dart';
import 'package:mongo_dart/mongo_dart.dart';
import 'package:angel_mongo/angel_mongo.dart';
import 'package:angel_auth/src/plugin.dart';
import 'package:angel_auth/src/strategies/local.dart';
import 'package:angel_validate/server.dart';
import 'package:angel_framework/src/http/request_context.dart';
import 'package:angel_framework/src/http/service.dart';

import 'package:angelangular/src/models/user.dart';
import 'package:angelangular/src/validators/validators.dart';

configureServer(Angel app) async {
  await app.configure(loadConfigurationFile());
  app.lazyParseBodies = true;
  app.injectSerializer(JSON.encode);
  var db = new Db(app.properties['mongo_db']);
  await db.open();

  app.use('/api/users', new MongoService(db.collection('users')));
  app.use('/api/notes', new MongoService(db.collection('notes')));

  var auth = new AngelAuth(jwtKey: app.jwt_key, allowCookie: false);
  auth.strategies
      .add(new LocalAuthStrategy(localAuthVerifier(app.service('api/users'))));

  auth.serializer = (User user) async => user.id;
  auth.deserializer =
      (String id) => app.service('api/users').read(id).then(User.parse);
  await app.configure(auth);
  app.post('/auth/local', auth.authenticate('local'));
  app.chain(validate(CREATE_USER)).post('/api/signup',
      (RequestContext req, res) async {
    var body = await req.lazyBody();
    return await app.service('api/users').create(body);
  });
}

LocalAuthVerifier localAuthVerifier(Service service) {
  return (String username, String password) async {
    Iterable<Map> users = await service.index({
      'query': {'username': username}
    });
    if (users.isEmpty)
      return false;
    else {
      var user = User.parse(users.first);
      if (user.password == password) return user;
    }
  };
}
