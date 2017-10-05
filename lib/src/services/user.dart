import 'package:angel_framework/src/http/server.dart';
import 'package:angel_framework/src/http/hooked_service.dart';
import 'package:angel_framework/hooks.dart' as hooks;
import 'package:angel_security/hooks.dart' as auth;
import 'package:angel_validate/server.dart';
import 'package:angelangular/src/validators/validators.dart';
import 'package:random_string/random_string.dart' as rs;
import 'package:crypto/crypto.dart' show sha256;
import 'package:crypto/crypto.dart';

var jwt_secret;

configureService(Angel app) {
  jwt_secret = app.properties['jwt_secret'];

  var service = app.service('api/users') as HookedService;
  service.before([
    HookedServiceEvent.indexed,
    HookedServiceEvent.created,
    HookedServiceEvent.modified,
    HookedServiceEvent.updated,
    HookedServiceEvent.removed
  ], hooks.disable());
  service.beforeCreated.listen(hooks.chainListeners([
    validateEvent(CREATE_USER),
    hooks.addCreatedAt(),
    hooks.addUpdatedAt(),
    cryptData()
  ]));

  service.beforeRead.listen(auth.restrictToOwner(ownerField: 'id'));
  service.afterAll(hooks.remove(['password', 'salt']));
}

HookedServiceEventListener cryptData() {
  return (HookedServiceEvent e) async {
    var salt = rs.randomAlphaNumeric(12);
    e.data
      ..['password'] =
      hashString(e.data['password'], salt, jwt_secret)
      ..['salt'] = salt;
  };
}

/// SHA-256 hash any string, particularly a password.
String hashString(String password, String salt, String pepper) =>
    sha256.convert(('$salt:$password:$pepper').codeUnits).toString();
