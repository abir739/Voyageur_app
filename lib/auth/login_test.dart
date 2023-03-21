import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

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
      appBar: AppBar(
        title: Text('Login Screen'),
      ),
      body: Center(
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
    );
  }
}
