import 'config.dart';
import 'package:dio/dio.dart';

class HttpRequest {
  static final BaseOptions baseOptions = BaseOptions(
      baseUrl: HttpConfig.baseURL,
      connectTimeout: Duration(milliseconds: HttpConfig.timeout));
  static final Dio dio = Dio();

  static Future request(String url,
                      {String method = 'get', 
                      Map<String, dynamic>? params,
                      Interceptor? inter}
      ) async {
    
    final options = Options(method: method);
    
    Interceptor inter = InterceptorsWrapper(
      onRequest: (options, handle){
        print("Block Request");
        handle.next(options);
        
      },
      onResponse: (response, handle){
        print("Block Response");
        handle.next(response);
      },
      onError: (error, handle){
        print("Block Error");
        handle.next(error);
        
      }
    );
  List<Interceptor> inters = [inter];

  if(inter != null){
    inters.add(inter);
  }
    dio.interceptors.addAll(inters);




    try{
    Response response =
        await dio.request(url, queryParameters: params, options: options);
        return response.data;
    } on DioException catch(e){
      return Future.error(e);
    }
    
  }
}
