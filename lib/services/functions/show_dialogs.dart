import 'package:do_you_flutter/ui/widgets/my_button.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ShowDialog {
  BuildContext context;
  ShowDialog(this.context);

  Future showResultAlert(bool _successful) async {
    return await showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) {
          return AlertDialog(
            title: Text(
                _successful ? "Adding item successful" : "Failed adding item"),
            content: Text(_successful
                ? "Great! Your item has been successfully added to the database"
                : "Sorry! an unexpected error occured, Please try again later"),
            actions: <Widget>[
              FlatButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                textColor: Colors.black,
                color: Colors.transparent,
                child: Text(
                  "Close",
                ),
              ),
              FlatButton(
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pop(context);
                },
                textColor: Colors.black,
                color: Colors.transparent,
                child: Text(
                  "Go Home",
                ),
              ),
            ],
          );
        });
  }

  Future showCircularProgressIndication(bool _result) async {
    if (_result) {
      return await showDialog(
          context: context,
          barrierDismissible: false,
          builder: (_) => Center(
                child: CircularProgressIndicator(),
              ));
    } else {
      Navigator.pop(context);
    }
  }

  Future showSourcePickerDialog(final Function _onPressed) async {
    return await showDialog(
        context: context,
        builder: (_) => AlertDialog(
              title: Text("Select source"),
              actions: <Widget>[
                MyButton("Camera", Icons.photo_camera, 10.0, () {
                  Navigator.pop(context);
                  return _onPressed(ImageSource.camera);
                }),
                MyButton("Gallery", Icons.image, 10.0, () {
                  Navigator.pop(context);
                  return _onPressed(ImageSource.gallery);
                }),
              ],
            ));
  }

  Future showDetailsDialog(final _title, final _img, final _description) async {
    return await showDialog(
        context: context,
        barrierDismissible: true,
        builder: (_) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              AlertDialog(
                title: Text(_title),
                content: Column(
                  crossAxisAlignment: _img != ""
                      ? CrossAxisAlignment.center
                      : CrossAxisAlignment.start,
                  children: <Widget>[
                    _img != ""
                        ? Container(
                            height: 200.0,
                            child: Image.network(_img, fit: BoxFit.cover),
                          )
                        : Container(),
                    SizedBox(
                      height: 10.0,
                    ),
                    Text(_description),
                  ],
                ),
              ),
            ],
          );
        });
  }
}
