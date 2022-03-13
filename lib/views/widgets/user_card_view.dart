import 'package:ceiba/models/user_model.dart';
import 'package:ceiba/views/posts_view.dart';
import 'package:flutter/material.dart';

class UserCard extends StatelessWidget {
  const UserCard(this.users,{
    Key? key,
  }) : super(key: key);
  final List<User> users;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: users.length,
      itemBuilder: (context, index) {
        return Card(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(users[index].name,style: TextStyle(color: Colors.green.shade700,fontWeight: FontWeight.bold,fontSize: 18),),
                const SizedBox(height: 10,),
                Row(
                  children: [
                    Icon(Icons.phone,color: Colors.green.shade700,size: 20,),
                    const SizedBox(width: 10,),
                    Text(users[index].phone,style: const TextStyle(fontSize: 15),)
                  ],
                ),
                const SizedBox(height: 10,),
                Row(
                  children: [
                    Icon(Icons.email,color: Colors.green.shade700,size: 20,),
                    const SizedBox(width: 10,),
                    Text(users[index].email,style: const TextStyle(fontSize: 15),)
                  ],
                ),
                const SizedBox(height: 30,),
                GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => PostsView(users[index]),));
                }
                ,child: Text('VER PUBLICACIONES',style: TextStyle(color: Colors.green.shade700,fontWeight: FontWeight.bold),textAlign: TextAlign.end,)),
              ],
            ),
          ),
        );
      },);
  }
}
