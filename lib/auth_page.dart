import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:socialLogin/app_sharedpreferences.dart';
import 'package:socialLogin/my_home_page.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as JSON;

class AuthPage extends StatefulWidget {
  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  ProgressDialog _progressDialog;
  //AppSharedPreferences _appSharedPreferences;
  GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [
      'email',
      'https://www.googleapis.com/auth/contacts.readonly',
    ],
  );

  Future<void> _handleGoogleSignIn() async {
    try {
      await _googleSignIn.signIn();
      await _progressDialog.show();
      setState(() {
        _isloggedIn = true;
      });
    } catch (error) {
      print(error);
    }
  }

  bool _isloggedIn = false;
  Map user;
  final facebooklogin = FacebookLogin();

  Future<Null> _loginWithFacebook() async {
    final result = await facebooklogin.logIn(['email']);
    await _progressDialog.show();
    switch (result.status) {
      case FacebookLoginStatus.loggedIn:
        final token = result.accessToken.token;
        final graphResponse = await http.get(
            'https://graph.facebook.com/v2.12/me?fields=name,first_name,last_name,picture,email&access_token=$token');
        final profile = JSON.jsonDecode(graphResponse.body);
        print(profile);
        setState(() {
          user = profile;
          _isloggedIn = true;
        });
        break;

      case FacebookLoginStatus.cancelledByUser:
        setState(() {
          _isloggedIn = false;
        });
        await _progressDialog.hide();
        break;
      case FacebookLoginStatus.error:
        setState(() {
          _isloggedIn = false;
        });
        await _progressDialog.hide();
    }
  }

  @override
  Widget build(BuildContext context) {
    _progressDialog = ProgressDialog(context, type: ProgressDialogType.Normal);
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        backgroundColor: Colors.grey[100],
        body: SingleChildScrollView(
          physics: ClampingScrollPhysics(),
          scrollDirection: Axis.vertical,
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height - 100,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Social Login',
                  style: TextStyle(
                      color: Colors.indigo,
                      fontWeight: FontWeight.bold,
                      fontSize: 40),
                ),
                SizedBox(
                  height: 200,
                ),
                SignInButton(
                  Buttons.GoogleDark,
                  onPressed: () async {
                    await _handleGoogleSignIn();
                    if (_isloggedIn == true) {
                      setState(() {
                        _isloggedIn = false;
                      });
                      await AppSharedPreferences.setProfileName(
                          _googleSignIn.currentUser.displayName);
                      await AppSharedPreferences.setEmail(
                          _googleSignIn.currentUser.email);
                      await AppSharedPreferences.setProfilePhoto(
                          _googleSignIn.currentUser.photoUrl);

                      await _progressDialog.hide();
                      Navigator.of(context).push(CupertinoPageRoute(
                          builder: (context) => MyHomePage()));
                    }
                  },
                  elevation: 0,
                  padding: EdgeInsets.all(0),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(1)),
                ),
                SizedBox(
                  height: 20,
                ),
                SignInButton(
                  Buttons.FacebookNew,
                  onPressed: () async {
                    await _loginWithFacebook();
                    if (_isloggedIn == true) {
                      setState(() {
                        _isloggedIn = false;
                      });

                      await AppSharedPreferences.setProfileName(user['name']);
                      await AppSharedPreferences.setFirstName(
                          user['first_name']);
                      await AppSharedPreferences.setLastName(user['last_name']);
                      await AppSharedPreferences.setEmail(user['email']);
                      await AppSharedPreferences.setProfilePhoto(
                          user["picture"]["data"]["url"]);

                      await _progressDialog.hide();
                      Navigator.of(context).push(CupertinoPageRoute(
                          builder: (context) => MyHomePage()));
                    }
                  },
                  elevation: 0,
                  padding: EdgeInsets.all(0),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(1)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
