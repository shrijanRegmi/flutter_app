import 'dart:io';

import 'package:do_you_flutter/models/item_model.dart';
import 'package:do_you_flutter/services/database_services/database_provider.dart';
import 'package:do_you_flutter/services/functions/show_dialogs.dart';
import 'package:do_you_flutter/services/storage_services/storage_provider.dart';
import 'package:do_you_flutter/ui/widgets/my_button.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

//TODO allow user to pick image and display the preview in UI
//TODO save new data to firestore (upload image to storage)
class AddPage extends StatefulWidget {
  @override
  _AddPageState createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {

  TextEditingController _title = TextEditingController();
  TextEditingController _description = TextEditingController();

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  File _image;

  Future<void> _getImage(final _source) async {
    var _temp = await ImagePicker.pickImage(source: _source);
    setState(() {
      _image = _temp;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text("Add item"),
        backgroundColor: Color(0xff3E3E3E),
      ),
      body: ListView(
        padding: EdgeInsets.all(10),
        children: <Widget>[
          _image != null ? _displayImg() : Container(),
          _buildTitleField(),
          SizedBox(
            height: 20,
          ),
          _buildDescriptionField(),
          SizedBox(
            height: 20,
          ),
          _buildImgSelectButton(),
          SizedBox(
            height: 20,
          ),
          _buildSaveButton(context)
        ],
      ),
    );
  }

  Widget _displayImg() {
    return Column(
      children: <Widget>[
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height / 3,
          child: Image.file(_image, fit: BoxFit.cover),
        ),
        SizedBox(
          height: 20.0,
        )
      ],
    );
  }

  TextField _buildTitleField() {
    return TextField(
      controller: _title,
      decoration: InputDecoration(
          border: OutlineInputBorder(),
          hintText: "title",
          prefixIcon: Icon(Icons.title)),
    );
  }

  TextField _buildDescriptionField() {
    return TextField(
      controller: _description,
      maxLines: 4,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        hintText: "Description",
      ),
    );
  }

  SizedBox _buildImgSelectButton() {
    return SizedBox(
        height: 50,
        width: double.infinity,
        child: MyButton("Add Image", Icons.camera, 50.0, () {
          ShowDialog(context).showSourcePickerDialog((_source) {
            _getImage(_source);
          });
        }));
  }

  SizedBox _buildSaveButton(BuildContext context) {
    return SizedBox(
        height: 50,
        width: 20.0,
        child: MyButton("Save", Icons.cloud_upload, 50.0, () async {
          if (_title.text != "" && _description.text != "") {
            var title = _title.text.trim();
            var description = _description.text.trim();

            FocusScope.of(context).unfocus();
            ShowDialog(context).showCircularProgressIndication(true);
            if (_image != null) {
              await StorageProvider().uploadImg(_image, (url) async {
                final _result = await DatabaseProvider().sendDataToFirebase(
                    title, description, url, DateTime.now().toString());
                ShowDialog(context).showCircularProgressIndication(false);
                ShowDialog(context).showResultAlert(_result);
              });
            } else {
              final _result = await DatabaseProvider().sendDataToFirebase(
                  title, description, "", DateTime.now().toString());
              ShowDialog(context).showCircularProgressIndication(false);
              ShowDialog(context).showResultAlert(_result);
            }
          } else {
            _scaffoldKey.currentState.showSnackBar(SnackBar(
              content: Text("Please fill the the fields to add an item !"),
            ));
          }

          setState(() {
            _title.clear();
            _description.clear();
            _image = null;
          });
        }));
  }
}
