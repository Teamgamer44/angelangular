import 'dart:io';

import 'package:angel_hot/angel_hot.dart';
import 'package:angelangular/main.dart';

main() async {

  var hot = new HotReloader(createServer, [
    new Directory('config'),
    new Directory('lib'),
    new Directory('web'),
  ]);

  var server = await hot.startServer(InternetAddress.LOOPBACK_IP_V4, 3000);
  print('Hot Server Listening at http://${server.address.address}:${server.port}');
}
