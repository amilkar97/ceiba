


import 'dart:io';

import 'package:ceiba/models/post_model.dart';
import 'package:ceiba/models/user_model.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';
part 'jsonplaceholder_service.g.dart';


@RestApi(baseUrl: "https://jsonplaceholder.typicode.com")
abstract class JsonPlaceHolderService {
  factory JsonPlaceHolderService(Dio dio, {String baseUrl}) = _JsonPlaceHolderService;

  @GET("/users")
  Future<List<User>> getUsers();

  @GET('/posts')
  Future<List<Post>> getPostsByUser(@Query('userId') String userId);

  static JsonPlaceHolderService create(){
    final dio = Dio();
    dio.options.headers[HttpHeaders.acceptHeader] = 'application/json';
    return JsonPlaceHolderService(dio);
  }
}