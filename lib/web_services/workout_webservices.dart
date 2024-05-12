import 'package:dio/dio.dart';
import 'package:exercise_app/constants.dart';
class WorkoutWebServices {
  late Dio dio;

  var headers = {
    'X-RapidAPI-Key': '21f93f2c44mshcae1f5d4812badep165c80jsnfc5da8e94c89'
  };

  WorkoutWebServices () {
    BaseOptions options = BaseOptions(
      baseUrl: baseUrl,
      receiveDataWhenStatusError: true,
      headers: headers,
      //connectTimeout: 60 * 1000, //60 sec
      //receiveTimeout: 60 * 1000, //60 sec
    );

    dio = Dio(options);
  }

  Future<List<dynamic>> getAllWorkouts() async {
    try{
      Response response = await dio.get(
        "search",
        /*options: Options(
          method: "GET",
          headers: headers,
        ),*/
      );
      print(response.data.toString());
      return response.data;
    } catch(e){
      print(e.toString());
      return [];
    }

  }
}