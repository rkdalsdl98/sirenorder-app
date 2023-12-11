import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

final base = dotenv.env['BASE_URL'];

enum RequestRoute {
  tokenlogin,
  login,
  order,
  coupon,
  regist,
  publishcode,
  code,
  menu,
  orderstate,
  notify,
}

const Map<RequestRoute, String> routes = {
  RequestRoute.tokenlogin: "/user/login/token",
  RequestRoute.login: "/user/login",
  RequestRoute.coupon: "/user/coupon",
  RequestRoute.regist: "/user/regist",
  RequestRoute.publishcode: "/user/regist/publish",
  RequestRoute.code: "/user/regist/verify",
  RequestRoute.order: "/store/order/send",
  RequestRoute.menu: "/menu",
  RequestRoute.orderstate: "/store/order/state",
  RequestRoute.notify: "/sse/push",
};

Future<Response> fetchGet(
  RequestRoute route, {
  Map<String, dynamic>? queryParams,
  Map<String, dynamic>? headers,
}) async {
  final url = "$base${routes[route]}";
  final BaseOptions options = BaseOptions(
    baseUrl: url,
    connectTimeout: const Duration(seconds: 60),
    sendTimeout: const Duration(seconds: 120),
    receiveTimeout: const Duration(seconds: 120),
    maxRedirects: 0,
    headers: {
      "Content-Type": "application/json;charset=UTF=8",
      ...?headers,
    },
    queryParameters: queryParams,
  );

  final Dio dio = Dio(options);
  return await dio.get(url);
}

Future<Response> fetchPost(
  RequestRoute route, {
  Map<String, dynamic>? body,
  Map<String, dynamic>? queryParams,
  Map<String, dynamic>? headers,
}) async {
  final url = "$base${routes[route]}";
  final BaseOptions options = BaseOptions(
    baseUrl: url,
    connectTimeout: const Duration(seconds: 60),
    sendTimeout: const Duration(seconds: 120),
    receiveTimeout: const Duration(seconds: 120),
    maxRedirects: 0,
    headers: {
      "Content-Type": "application/json;charset=UTF=8",
      ...?headers,
    },
    queryParameters: queryParams,
  );

  final Dio dio = Dio(options);
  return await dio.post(url, data: body);
}

Future<Response<ResponseBody>> sse({
  Map<String, dynamic>? queryParams,
  Map<String, dynamic>? headers,
}) async {
  final url = "$base/sse/listen";
  final BaseOptions options = BaseOptions(
    baseUrl: url,
    connectTimeout: const Duration(seconds: 60),
    sendTimeout: const Duration(seconds: 120),
    receiveTimeout: const Duration(seconds: 120),
    maxRedirects: 0,
    headers: {
      "Accept": "text/event-stream",
      "Cache-Control": "no-cache",
      ...?headers,
    },
    responseType: ResponseType.stream,
    queryParameters: queryParams,
  );

  final Dio dio = Dio(options);
  return await dio.get<ResponseBody>(url);
}
