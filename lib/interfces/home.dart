import 'package:certinomial/interfces/pdfCoverter.dart';
import 'package:certinomial/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:certinomial/services/database.dart';

enum WidgetMarker { documents, folders }

class home extends StatefulWidget {
  const home({Key? key}) : super(key: key);

  @override
  _homeState createState() => _homeState();
}

class _homeState extends State<home> {
  WidgetMarker selectedWidgetMarker = WidgetMarker.documents;
  Authentication auth = Authentication();
  dbservices db = dbservices();
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
                Navigator.popUntil(context, ModalRoute.withName('/Login'));
              },
              child: Text('Logout', textAlign: TextAlign.center))
        ],
      ),
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              //username
              Text(
                "Sia Handsome",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
              //user role
              Text(
                "Student",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
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
                      style: TextStyle(color: Colors.black54),
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
                      style: TextStyle(color: Colors.black54),
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
      child: Column(
        children: <Widget>[
          Center(
            child: Expanded(
              child: Container(
                  height: 300,
                  margin: EdgeInsets.all(10),
                  color: Colors.red,
                  child: FutureBuilder(
                    future: db.listExample(),
                    builder: (BuildContext context,
                        AsyncSnapshot<dynamic> snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        return ListView.builder(
                            itemCount: snapshot.data?.length ?? 0,
                            itemBuilder: (context, index) {
                              return Column(
                                children: <Widget>[
                                  Container(
                                    child: Text(snapshot.data[index]),
                                  )
                                ],
                              );
                            });
                      }
                      return Container(child: Text('no data'));
                    },
                  )),
            ),
          ),
        ],
      ),
    );
  }

  Widget getFoldersWidget() {
    return Container(
      child: Column(
        children: <Widget>[
          Center(
            child: Expanded(
              child: Container(
                height: 300,
                margin: EdgeInsets.all(10),
                child: ListView.builder(
                    itemCount: 3,
                    itemBuilder: (BuildContext context, int index) {
                      return Column(
                        children: <Widget>[
                          Container(
                            child: Text(
                              'academic',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          )
                        ],
                      );
                    }),
              ),
            ),
          ),
          FlatButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => pdfConverter(),
                    ));
              },
              child: Text('Create new folders'))
        ],
      ),
    );
  }
}
