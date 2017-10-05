import 'package:angular/src/core/metadata.dart';
import 'package:angular/src/common/directives/ng_if.dart';
import 'package:angular_router/src/directives/router_link.dart';
import '../../services/auth.dart';

@Component(
    selector: 'app-menu',
    templateUrl: 'app_menu.html',
    directives: const [RouterLink, NgIf])
class AppMenuComponent {
  final AuthService auth;

  AppMenuComponent(this.auth);
}
