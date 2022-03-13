


import 'package:ceiba/models/post_model.dart';
import 'package:ceiba/models/user_model.dart';
import 'package:ceiba/services/jsonplaceholder_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';

class JsonPlaceholderProvider extends ChangeNotifier{
  List<User> users = [];
  List<Post> posts = [];
  bool isPostsLoading = false;
  bool isUserLoading = false;
  String? errorUser;
  final JsonPlaceHolderService service = JsonPlaceHolderService.create();

  Future getUsers() async{
    try{
      isUserLoading = true;
      users.clear();
      var box = await Hive.openBox('hive');
      if(box.get('users') == null){
        users = await service.getUsers();
        box.put('users', users);
      }else{
        List list = box.get('users') ;
        for (var element in list) {
          users.add(element);
        }
      }
      isUserLoading = false;
      notifyListeners();
    }catch(error){
      isUserLoading = false;
      errorUser = "Algo ocurrio";
      notifyListeners();
    }
  }

  Future getPostsByUsers(userId) async{
    try{
      isPostsLoading = true;
      posts = await service.getPostsByUser(userId.toString());
      isPostsLoading = false;
      notifyListeners();
    }catch(error){
      isPostsLoading = false;
      errorUser = "Algo ocurrio";
      notifyListeners();
    }
  }
}