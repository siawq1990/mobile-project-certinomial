import 'package:certinomial/interfces/home.dart';
import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';

import 'home.dart';

class FirstPage extends StatefulWidget {
  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  final LocalAuthentication localAuth = LocalAuthentication();

  bool isAuthenticated = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: GestureDetector(
          onTap: () async {
            bool biometricStatus = await localAuth.canCheckBiometrics;
            if (biometricStatus) {
              bool authenticated = await localAuth.authenticate(
                  stickyAuth: true,
                  useErrorDialogs: true,
                  localizedReason: "Authenticate to enter");
              if (authenticated) {
                setState(() {
                  authenticated = isAuthenticated;
                });
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => home(),
                  ),
                );
              }
            }
          },
          child: Column(
            children: [
              Padding(padding: EdgeInsets.fromLTRB(0.00, 150.0, 0.00, 50.0)),
              Center(
                child: Image(image: AssetImage("assets/fingerprint.jpg")),
              ),
              Center(
                child: Text(
                  "biometric verification",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 27.0),
                ),
              ),
            ],
          ),
        ));
  }
}
