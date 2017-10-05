import 'dart:async';
import 'dart:io';
import 'package:angel_common/angel_common.dart';

import 'package:angelangular/src/config/config.dart' as config;
import 'package:angelangular/src/services/services.dart' as services;

Future<Angel> createServer() async {
  var app = new Angel();

  await app.configure(config.configureServer);
  await app.configure(services.configureServer);
  app.before.add(cors());

  await app.configure(new PubServeLayer());

  var vDir = new VirtualDirectory();
  await app.configure(vDir);

  var indexFile = new File.fromUri(vDir.source.uri.resolve('index.html'));
  app.after.add((req, ResponseContext res) => res.sendFile(indexFile));
  app.responseFinalizers.add(gzip());
  await app.configure(logRequests());
  return app;
}