import 'dart:html';
import 'package:angular/src/core/metadata.dart';
import 'package:angular_forms/src/directives.dart';
import 'package:angelangular/src/validators/validators.dart';
import '../../services/auth.dart';

@Component(selector: 'log-in', templateUrl: 'log_in.html', directives: const [NgModel, formDirectives])
class LogInComponent {
  final AuthService _auth;
  String username, password;

  LogInComponent(this._auth);

  void handleSubmit() {
    var data = {'username': username, 'password': password};

    if (CREATE_USER.check(data).errors.isNotEmpty)
      window.alert('Invalid data!');
    else
      _auth.login(username, password);
  }
}
