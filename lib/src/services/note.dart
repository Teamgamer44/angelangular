import 'package:angel_framework/src/http/server.dart';
import 'package:angel_framework/src/http/hooked_service.dart';
import 'package:angel_framework/hooks.dart' as hooks;
import 'package:angel_security/hooks.dart' as auth;
import 'package:angel_validate/server.dart';
import 'package:angelangular/src/validators/validators.dart';

configureService(Angel app) {
  var service = app.service('api/notes') as HookedService;
  service.before([
    HookedServiceEvent.read,
    HookedServiceEvent.modified,
    HookedServiceEvent.updated,
    HookedServiceEvent.removed
  ], auth.restrictToOwner());
  service.beforeIndexed.listen(auth.queryWithCurrentUser());

  service.beforeCreated.listen(hooks.chainListeners([
    validateEvent(CREATE_NOTE),
    auth.associateCurrentUser(),
    hooks.addCreatedAt()
  ]));

  service.beforeModify(hooks.addUpdatedAt());
}