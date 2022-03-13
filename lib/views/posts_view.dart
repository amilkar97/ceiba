

import 'package:ceiba/models/user_model.dart';
import 'package:ceiba/providers/jsonplaceholder_provider.dart';
import 'package:ceiba/services/jsonplaceholder_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PostsView extends StatefulWidget {
  final User user;
  const PostsView(this.user, {Key? key}) : super(key: key);

  @override
  State<PostsView> createState() => _PostsViewState();
}

class _PostsViewState extends State<PostsView> {
  @override
  void initState() {
    super.initState();
    _loadPosts();
  }
  _loadPosts() async{
    await Provider.of<JsonPlaceholderProvider>(context,listen: false).getPostsByUsers(widget.user.id);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Posts'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 20),
            child: Column(
              children: [
                Text(widget.user.name,style: TextStyle(color: Colors.green.shade700,fontWeight: FontWeight.bold,fontSize: 25),),
                const SizedBox(height: 10,),
                Row(
                  children: [
                    Icon(Icons.phone,color: Colors.green.shade700,size: 20,),
                    const SizedBox(width: 10,),
                    Text(widget.user.phone,style: const TextStyle(fontSize: 15),)
                  ],
                ),
                const SizedBox(height: 10,),
                Row(
                  children: [
                    Icon(Icons.email,color: Colors.green.shade700,size: 20,),
                    const SizedBox(width: 10,),
                    Text(widget.user.email,style: const TextStyle(fontSize: 15),)
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text('Posts',style: TextStyle(color: Colors.green.shade700,fontWeight: FontWeight.bold,fontSize: 20),),
          ),
          Expanded(child: Consumer<JsonPlaceholderProvider>(builder: (context, value, child) {
            if(value.isPostsLoading) return const Center(child: CircularProgressIndicator(),);
            return ListView.builder(itemCount: value.posts.length,itemBuilder: (context, index) {
                return Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        ListTile(title: Text(value.posts[index].title),subtitle: Text(value.posts[index].body),)
                      ],
                    ),
                  ),
                );
            },);
          },))
        ],
      ),
    );
  }
}
