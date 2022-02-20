import 'package:certinomial/services/auth.dart';
import 'package:flutter/material.dart';

enum WidgetMarker { documents, folders }

class home extends StatefulWidget {
  const home({Key? key}) : super(key: key);

  @override
  _homeState createState() => _homeState();
}

class _homeState extends State<home> {
  WidgetMarker selectedWidgetMarker = WidgetMarker.documents;
  Authentication auth = Authentication();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Profile'),
        backgroundColor: Colors.green,
        actions: <Widget>[
          FlatButton(
              onPressed: () {
                Authentication.signOutFacebook();
                Authentication.signOutGoogle();
              },
              child: Text('Logout', textAlign: TextAlign.center))
        ],
      ),
      body: Container(
        child: Center(
          child: Column(
            children: <Widget>[
              //username
              Text(
                "Sia Handsome",
                textAlign: TextAlign.center,
              ),
              //user role
              Text(
                "Student",
                textAlign: TextAlign.center,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  FlatButton(
                    onPressed: () {
                      setState(() {
                        selectedWidgetMarker = WidgetMarker.documents;
                      });
                    },
                    child: Text(
                      "Documents",
                      style: TextStyle(color: Colors.black12),
                    ),
                  ),
                  FlatButton(
                    onPressed: () {
                      setState(() {
                        selectedWidgetMarker = WidgetMarker.folders;
                      });
                    },
                    child: Text(
                      "Folders",
                      style: TextStyle(color: Colors.black12),
                    ),
                  ),
                ],
              ),
              Container(
                child: getCustomContainer(),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget getCustomContainer() {
    switch (selectedWidgetMarker) {
      case WidgetMarker.documents:
        return getDocumentWidget();
      case WidgetMarker.folders:
        return getFoldersWidget();
    }

    return getDocumentWidget();
  }

  Widget getDocumentWidget() {
    return Container(
      child: Expanded(
          child: Container(
        height: 200,
        color: Colors.red,
      )),
    );
  }

  Widget getFoldersWidget() {
    return Container(
      child: Expanded(
          child: Container(
        height: 300,
        color: Colors.green,
      )),
    );
  }
}
