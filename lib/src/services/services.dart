import 'package:angel_common/angel_common.dart';

import 'package:angelangular/src/services/user.dart' as user;
import 'package:angelangular/src/services/note.dart' as note;

configureServer(Angel app) async {
  await app.configure(user.configureService);
  await app.configure(note.configureService);
}