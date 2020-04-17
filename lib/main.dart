import 'package:do_you_flutter/models/item_model.dart';
import 'package:do_you_flutter/services/database_services/database_provider.dart';
import 'package:do_you_flutter/ui/pages/add.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './ui/pages/home.dart';

/* 
Please complete the tasks listed in TODOs in different files
  
  In this app user should be able to Save a list of items
  with image (should be able to take a picture or select existing one from gallery), 
  title and description in firestore database, with image being uploaded to firebase storage.

  TODO 1. Integrate a firebase firestore and storage
  TODO 2. Integrate a state management solution you know best

  (optional) -> Theme and style as you prefer to show quality work

  Checkout home.dart and add.dart for TODOs.

 */

void main() => runApp(IRememberApp());

class IRememberApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<Item>>.value(
      value: DatabaseProvider().listOfItems,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'IRemember',
        theme: ThemeData(primaryColor: Colors.deepOrange),
        routes: {
          "/": (_) => HomePage(),
          "/add": (_) => AddPage(),
        },
      ),
    );
  }
}
