

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/database/database.dart';
import 'package:flutter_application_1/ui/newUser.dart';
import 'package:provider/provider.dart';


class listUser extends StatefulWidget {
  const listUser({super.key});

  @override
  State<listUser> createState() => _listUserState();
}

class _listUserState extends State<listUser> {

  late AppDatabase database;

  @override
  Widget build(BuildContext context) {

    database = Provider.of<AppDatabase>(context);


    return Scaffold(
      appBar: AppBar(
        title: const Text("User List ..."),
      ),
      body: FutureBuilder<List<UserData>>(
        future: database.getListUsers(),
        builder: (context, snapshot){
          if (snapshot.hasData) {
            List<UserData>? userList = snapshot.data;
            return ListView.builder(
              itemCount: userList!.length,
              itemBuilder: (context, index) {
                UserData userData = userList[index];
                return ListTile(
                  title: Text(userData.name),
                  subtitle: Text(userData.email),
                );
              }
            );
          }
          else {
            return Center(
              child: Text(""),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          addUser();
        },
        backgroundColor: Colors.red,
        child: const Icon(Icons.add),
      ),
    );
  }
  
  void addUser() async {
    var res = await Navigator.push(context, MaterialPageRoute(builder: (context) => newUser()),
    );

    if (res != null && res == true) {
      setState(() {
        
      });
    }
  }
}