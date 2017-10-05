import 'dart:html';
import 'package:angel_client/browser.dart';
import 'package:angular/core.dart';

@Injectable()
class BackendService {
  final Map<String, Service> _services = {};

  final Angel app = new Rest('http://localhost:3000');

  Service service(String path) =>
      _services.putIfAbsent(path, () => app.service(path));
}
