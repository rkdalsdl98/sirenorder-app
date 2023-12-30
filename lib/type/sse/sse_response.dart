import 'dart:async';

import 'package:dio/dio.dart';

class SSEResponse {
  late final Dio conn;
  late final Response<ResponseBody> rs;
  SSEResponse(
    this.conn,
    this.rs,
  );
}

class SSEConnection {
  late final StreamSubscription<String> stream;
  late final Dio conn;

  SSEConnection(
    this.conn,
    this.stream,
  );
}
