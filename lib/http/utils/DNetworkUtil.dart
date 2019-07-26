/* Created by Sahil Bharti on 13/4/19.
 *
*/
import 'package:dio/dio.dart';
import 'package:employee/http/Api.dart';
import 'package:employee/http/utils/LogInterceptor.dart';


class NetworkUtil {
  Dio _dio;
  NetworkUtil() {
    ///Create Dio Object using baseOptions set receiveTimeout,connectTimeout
    BaseOptions options =
        BaseOptions(receiveTimeout: 5000, connectTimeout: 5000);
    options.baseUrl = Api.BaseURL;
    _dio = Dio(options);
    _dio.interceptors.add(LogInterceptors());
  }
  //动态URl

  NetworkUtil.URL(String Url){
    BaseOptions options =
    BaseOptions(receiveTimeout: 5000, connectTimeout: 5000);
    options.baseUrl = Url;
    _dio = Dio(options);
    _dio.interceptors.add(LogInterceptors());
  }
  ///used for calling Get Request
  Future<Response> get(String url, params) async {
    Response response = await _dio.get(url,
        queryParameters: params,
        options: Options(responseType: ResponseType.json));
    return response;
  }

  ///used for calling post Request
  Future<Response> post(String url,  params) async {
    Response response = await _dio.post(url,
        data: params, options: Options(responseType: ResponseType.json));
    return response;
  }
}
