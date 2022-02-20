import 'package:flutter/material.dart';
import 'package:certinomial/services/auth.dart';
import 'biometriclogin.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  Map? _userData;
  Authentication auth = Authentication();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text(
          'Log In',
          textAlign: TextAlign.center,
        ),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Center(
              child: FlatButton(
                  onPressed: () async {
                    auth.signInWithFacebook();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => FirstPage(),
                      ),
                    );
                  },
                  child: Text('Login with Facebook')),
            ),
            Center(
              child: FlatButton(
                  onPressed: () {
                    Authentication.signInWithGoogle();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => FirstPage(),
                      ),
                    );
                  },
                  child: Text('Login with Google')),
            )
          ],
        ),
      ),
    );
  }
}
