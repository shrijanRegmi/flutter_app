import 'package:do_you_flutter/models/item_model.dart';
import 'package:do_you_flutter/services/database_services/database_provider.dart';
import 'package:do_you_flutter/services/functions/manage_date_time.dart';
import 'package:do_you_flutter/services/functions/show_dialogs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';

//TODO List out items from Firestore with image using the state management solution you have integrated
class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xff3E3E3E),
        appBar: AppBar(
          title: Text("Home"),
          leading: Icon(Icons.home),
          backgroundColor: Color(0xff3E3E3E),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.deepOrange,
          onPressed: () {
            Navigator.pushNamed(context, "/add");
          },
          child: Icon(Icons.add),
        ),
        body: Container(
          child: ListView(
            children: <Widget>[
              Container(
                color: Colors.blue[100],
                child: Column(
                  children: <Widget>[
                    Container(
                      width: MediaQuery.of(context).size.width - 50,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 10.0, bottom: 20.0, left: 10.0, right: 10.0),
                        child: Text("Let's save something to firebase !",
                            style: TextStyle(
                              color: Color(0xff3E3E3E),
                              fontSize: 40.0,
                              fontWeight: FontWeight.w300,
                            )),
                      ),
                    ),
                    _myList(context),
                  ],
                ),
              ),
            ],
          ),
        ));
  }

  Widget _myList(BuildContext context) {
    final _items = Provider.of<List<Item>>(context);
    return Container(
        decoration: BoxDecoration(
            color: Color(0xff3E3E3E),
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25.0),
                topRight: Radius.circular(25.0))),
        child: Column(
          children: <Widget>[
            Padding(
              padding:
                  const EdgeInsets.only(left: 30.0, top: 30.0, bottom: 20.0),
              child: Row(
                children: <Widget>[
                  Text(
                    "Items",
                    style: TextStyle(color: Colors.white, fontSize: 16.0),
                  ),
                ],
              ),
            ),
            _items == null
                ? Text(
                    "Loading...",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  )
                : _items.length == 0
                    ? Container(
                        constraints: BoxConstraints(
                            maxWidth: MediaQuery.of(context).size.width - 100),
                        child: Text(
                          "You don't have any items added. Please press the action button on the bottom right side to add items.",
                          style: TextStyle(
                            color: Colors.white,
                            fontStyle: FontStyle.italic,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      )
                    : ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: _items.length,
                        itemBuilder: (context, index) {
                          if (index.isEven) {
                            return _getListItem(
                                context, _items[index], Color(0xff1492E6));
                          } else {
                            return _getListItem(
                                context, _items[index], Color(0xff262626));
                          }
                        }),
          ],
        ));
  }

  Widget _getListItem(BuildContext context, Item _item, Color _color) {
    return GestureDetector(
      onTap: () {
        ShowDialog(context)
            .showDetailsDialog(_item.title, _item.imgPath, _item.description);
      },
      child: Padding(
        padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
        child: Slidable(
          actionPane: SlidableScrollActionPane(),
          actionExtentRatio: 0.25,
          secondaryActions: <Widget>[
            IconSlideAction(
              caption: 'Delete',
              color: Colors.red,
              icon: Icons.delete,
              onTap: () async {
                DatabaseProvider().deleteItem(_item.docId);
              },
            ),
          ],
          child: Stack(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 50.0),
                child: Container(
                  color: Color(0xff3E3E3E),
                  child: Container(
                    decoration: BoxDecoration(
                        color: _color,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(15.0),
                            bottomLeft: Radius.circular(15.0)),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black,
                              offset: Offset(3.0, 3.0),
                              blurRadius: 5.0)
                        ]),
                    padding: const EdgeInsets.only(
                        top: 20.0, bottom: 20.0, left: 60.0, right: 20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              _item.title.length > 15
                                  ? "${_item.title.substring(0, 15)}..."
                                  : _item.title,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16.0,
                              ),
                            ),
                            Text(
                              _item.description.length > 15
                                  ? "${_item.description.substring(0, 15)}..."
                                  : _item.description,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14.0,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: <Widget>[
                            Text(
                              ManageDateTime(_item.date).getDay() != "Today" &&
                                      ManageDateTime(_item.date).getDay() !=
                                          "Yesterday"
                                  ? "On ${ManageDateTime(_item.date).getMonth()} ${ManageDateTime(_item.date).getSingleDay()}"
                                  : ManageDateTime(_item.date).getDay(),
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 10.0,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                            Text(
                              ManageDateTime(_item.date).getTime(),
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 10.0,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Positioned.fill(
                left: 20.0,
                child: Row(
                  children: <Widget>[
                    ClipOval(
                      child: Container(
                        width: 60.0,
                        height: 60.0,
                        decoration: BoxDecoration(
                            color: _color == Color(0xff1492E6)
                                ? Color(0xff262626)
                                : Color(0xff1492E6),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black,
                                  offset: Offset(3.0, 3.0),
                                  blurRadius: 5.0)
                            ]),
                        child: _item.imgPath != null && _item.imgPath != ""
                            ? Image.network(_item.imgPath, fit: BoxFit.cover)
                            : Center(
                                child: Text(
                                    _item.title.substring(0, 1).toUpperCase(),
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 18.0))),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
