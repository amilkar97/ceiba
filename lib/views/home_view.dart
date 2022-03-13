
import 'package:ceiba/models/user_model.dart';
import 'package:ceiba/providers/jsonplaceholder_provider.dart';
import 'package:ceiba/views/widgets/user_card_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final TextEditingController _filter = TextEditingController();
  List<User> tempList = [];
  String _searchText = "";

  @override
  void initState() {
    super.initState();
    _loadData();
    _filter.addListener(() {
      if (_filter.text.isEmpty) {
        setState(() {
          _searchText = "";
        });
      } else {
        setState(() {
          _searchText = _filter.text;
        });
      }
    });
  }

  _loadData() async{
    await Provider.of<JsonPlaceholderProvider>(context,listen: false).getUsers();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: const Text('Prueba de Ingreso'),),
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: Colors.black45)
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: TextFormField(
                    controller: _filter,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      icon: Icon(Icons.search),
                      hintText: 'Search user',
                      iconColor: Colors.black
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Consumer<JsonPlaceholderProvider>(builder: (context, value, child) {
                  if(value.isUserLoading) return const Center(child: CircularProgressIndicator(),);
                  return _buildList(value.users);
                },),
              )
            ],
          ),
        ),
      ),
    );
  }

  _buildList(List<User> users){
    List<User> userResults = users;
    if (_searchText.isNotEmpty) {
      List<User> tempList = [];
      for (int i = 0; i < users.length; i++) {
        if (users[i].name.toLowerCase().contains(_searchText.toLowerCase())) {
          tempList.add(users[i]);
        }
      }
      if(tempList.isEmpty) return const Center(child: Text('List is empty',style: TextStyle(fontSize: 17),));
      userResults = tempList;
    }
    return   UserCard(userResults);
  }
}

