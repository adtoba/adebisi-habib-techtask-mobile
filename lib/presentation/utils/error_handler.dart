import 'package:dio/dio.dart';

class CustomErrorHandler {
  static String handleException(DioException ex) {
    String message = '';

    if (ex.type == DioExceptionType.connectionError) {
      message = "Ensure you're connected to the internet and try again!";
    } else if(ex.type == DioExceptionType.sendTimeout) {
      message = "Your connection has timed out, try again!";
    } else if(ex.type == DioExceptionType.sendTimeout){
      message = "Your connection has timed out, try again!";
    } else {
      message = "Oops, an error has occured, Please try again";
    }

    return message;
  }
}