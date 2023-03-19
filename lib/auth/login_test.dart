import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:voyageur_app/planning/planning_test.dart';
//import 'package:voyageur_app/planning/planning_screen.dart'; // Import the planning screen

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [
      'email',
    ],
  );
  bool _isSignedIn = false;

  @override
  void initState() {
    super.initState();
    _googleSignIn.onCurrentUserChanged.listen((GoogleSignInAccount? account) {
      setState(() {
        _isSignedIn = account != null;
      });
      if (_isSignedIn) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => PlanningScreen()),
        );
      }
    });
    _googleSignIn.signInSilently();
  }

  Future<void> _handleSignIn() async {
    try {
      await _googleSignIn.signIn();
    } catch (error) {
      print(error);
    }
  }

  Future<void> _handleSignOut() async {
    try {
      await _googleSignIn.signOut();
    } catch (error) {
      print(error);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Color(0xFFF9FAFB),
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Image.asset(
                'assets/images/logo.jpeg',
                width: 150,
                height: 150,
              ),
              SizedBox(height: 16.0),
              Text(
                'Welcome to Zenify app!',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Form(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (!_isSignedIn)
                      ElevatedButton(
                        onPressed: _handleSignIn,
                        child: Text('Sign in with Google'),
                      )
                    else
                      Column(
                        children: [
                          Text('Signed in with Google'),
                          SizedBox(height: 20),
                          ElevatedButton(
                            onPressed: _handleSignOut,
                            child: Text('Sign out'),
                          ),
                        ],
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
