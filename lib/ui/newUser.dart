

import 'dart:ffi';
import 'package:drift/drift.dart' as dr;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/database/database.dart';
import 'package:provider/provider.dart';

class newUser extends StatefulWidget {
  const newUser({super.key});

  @override
  State<newUser> createState() => _newUserState();
}

class _newUserState extends State<newUser> {
  late AppDatabase appDatabase;
  late TextEditingController txtNombre;
  late TextEditingController txtEmail;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    txtNombre = TextEditingController();
    txtEmail = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {

    appDatabase = Provider.of<AppDatabase>(context);


    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.chevron_left),
        ),
        title: Text("Nuevo usuario"),
      ),
      body: Column(
        children: [
          TextFormField(
            controller: txtNombre,
            decoration: InputDecoration(
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
              hintText: "Ingrese su nombre"
            ),
      
          ),
          SizedBox(height: 30),
          TextFormField(
            controller: txtEmail,
            decoration: InputDecoration(
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
              hintText: "Ingrese su email"
            ),
      
          ),
          SizedBox(height: 30),
          ElevatedButton(
            onPressed: (){
              appDatabase.insertUser(UserCompanion(
                name: dr.Value(txtNombre.text),
                email: dr.Value(txtEmail.text)

              )).then((value) {
                Navigator.pop(context, true);
              });
            },
            child: Text("Guardar usuario"))
        ],
      ),
    );
  }
}