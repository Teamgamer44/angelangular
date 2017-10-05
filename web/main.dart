import 'package:angular/src/platform/bootstrap.dart';
import 'package:angular_router/angular_router.dart';
import 'components/note_app/note_app.dart';
import 'services/services.dart';

main() {
  bootstrap(NoteAppComponent, [ROUTER_PROVIDERS, NOTE_PROVIDERS]);
}
