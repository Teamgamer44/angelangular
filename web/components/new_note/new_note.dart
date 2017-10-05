import 'package:angelangular/src/models/models.dart';
import 'package:angular/src/core/metadata.dart';
import '../../services/note.dart';
import '../note_form/note_form.dart';

@Component(
    selector: 'new-note',
    templateUrl: 'new_note.html',
    directives: const [NoteFormComponent])
class NewNoteComponent {
  final NoteService _service;

  Note note = new Note();

  NewNoteComponent(this._service);

  void handleSubmit() {
    _service.createNote(note);
  }
}
