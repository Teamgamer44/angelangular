import 'package:angelangular/src/models/models.dart';
import 'package:angular/src/core/metadata.dart';
import 'package:angular/src/common/directives/ng_if.dart';
import 'package:angular/src/common/directives/ng_for.dart';
import 'package:angular_router/src/directives/router_link.dart';
import 'package:angular_router/src/interfaces.dart';
import 'package:angular_router/src/instruction.dart';
import '../../services/auth.dart';
import '../../services/note.dart';

@Component(
    selector: 'note-list',
    templateUrl: 'note_list.html',
    directives: const [RouterLink, NgIf, NgFor])
class NoteListComponent implements OnActivate, OnInit {
  final AuthService auth;
  final NoteService _noteService;

  NoteListComponent(this.auth, this._noteService);

  List<Note> get notes => _noteService.notes;

  @override
  routerOnActivate(ComponentInstruction nextInstruction,
      ComponentInstruction prevInstruction) {
    if (auth.user != null)
      _noteService.fetchNotes();
  }

  @override
  ngOnInit() {
    auth.onLogin.listen((_) {
      _noteService.fetchNotes();
    });
  }
}
