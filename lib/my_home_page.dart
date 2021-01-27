import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:socialLogin/app_sharedpreferences.dart';
import 'package:socialLogin/auth_page.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final facebooklogin = FacebookLogin();
  //AppSharedPreferences _appSharedPreferences;
  GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [
      'email',
      'https://www.googleapis.com/auth/contacts.readonly',
    ],
  );

  Future<Null> _logout() async {
    await facebooklogin.logOut();
    await _googleSignIn.signOut();
  }

  String _name;
  String _firstname;
  String _lastname;
  String _email;
  String _photo;

  Future<Null> getSharedPreferencesValue() async {
    String name = await AppSharedPreferences.getProfileName();
    String email = await AppSharedPreferences.getEmail();
    String photo = await AppSharedPreferences.getProfilePhoto();
    String firstname = await AppSharedPreferences.getFirstName();
    String lastname = await AppSharedPreferences.getLastName();
    setState(() {
      _name = name;
      _firstname = firstname;
      _lastname = lastname;
      _email = email;
      _photo = photo;
    });
  }

  @override
  void initState() {
    super.initState();
    this.getSharedPreferencesValue();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        backgroundColor: Colors.grey[100],
        appBar: AppBar(
          title: Text('Social Login'),
          centerTitle: true,
          elevation: 0,
        ),
        drawer: Drawer(
          child: Container(
            child: Column(
              children: [
                Container(
                    alignment: Alignment.center,
                    height: 200,
                    width: double.infinity,
                    color: Colors.indigo,
                    child: Column(
                      children: [
                        SizedBox(
                          height: 50,
                        ),
                        CircleAvatar(
                          backgroundImage: _photo == null
                              ? AssetImage('assets/images/user_photo.png')
                              : NetworkImage(_photo),
                          radius: 40,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: Text(
                            _name ?? 'name',
                            style: TextStyle(color: Colors.white, fontSize: 25),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: Text(
                            _email ?? 'email',
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                        ),
                      ],
                    )),
                Container(
                  height: 50,
                  alignment: Alignment.centerLeft,
                  child: Text(
                    _firstname ?? 'first_name',
                    style: TextStyle(color: Colors.indigo, fontSize: 20),
                  ),
                ),
                Container(
                  height: 50,
                  alignment: Alignment.centerLeft,
                  child: Text(
                    _lastname ?? 'last_name',
                    style: TextStyle(color: Colors.indigo, fontSize: 20),
                  ),
                ),
              ],
            ),
          ),
        ),
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
                  'Congratulations !',
                  style: TextStyle(color: Colors.indigo, fontSize: 40),
                ),
                SizedBox(
                  height: 100,
                ),
                MaterialButton(
                    child: Text(
                      'Logout',
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                    color: Colors.indigo,
                    elevation: 0,
                    minWidth: 300,
                    height: 40,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)
                    ),
                    onPressed: () async {
                      await _logout();
                      Navigator.of(context).push(
                          CupertinoPageRoute(builder: (context) => AuthPage())
                      );
                    }
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
