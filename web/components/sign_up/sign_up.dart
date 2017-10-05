import 'dart:html';
import 'package:angelangular/src/validators/validators.dart';
import 'package:angular/src/core/metadata.dart';
import 'package:angular_forms/src/directives.dart';
import 'package:angular_forms/angular_forms.dart';
import '../../services/auth.dart';

@Component(
    selector: 'sign-up',
    templateUrl: 'sign_up.html',

    // TODO: optimize imports for 'formDirectives'
    // Important: The 'formDirectives' access functions to readout inputs
    directives: const [NgModel, formDirectives])
class SignUpComponent {
  final AuthService _auth;
  String username, password;

  SignUpComponent(this._auth);

  void handleSubmit() {
    var data = {'username': username, 'password': password};

    if (CREATE_USER.check(data).errors.isNotEmpty)
      window.alert('Invalid data!');
    else
      _auth.signup(username, password);
  }
}
