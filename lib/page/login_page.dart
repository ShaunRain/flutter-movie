import 'package:flutter/material.dart';
import 'package:flutter_movie/movie_app.dart';
import 'package:local_auth/local_auth.dart';
import 'dart:async';
import 'dart:io';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _remember = false;
  GlobalKey _formKey = new GlobalKey<FormState>();
  var _scaffoldKey = new GlobalKey<ScaffoldState>();
  TextEditingController _unameController =
      new TextEditingController(text: "Jeff Green");
  FocusNode _unameFocus = new FocusNode();
  TextEditingController _pwdController = new TextEditingController();
  FocusNode _pwdFocus = new FocusNode();

  bool _isLoging = false;

  final LocalAuthentication auth = LocalAuthentication();
  bool _canCheckBio = false;

  bool _authorized = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 1000), () => _checkBio());
  }

  _checkBio() async {
    _canCheckBio = await auth.canCheckBiometrics;

    if (_canCheckBio) {
      List<BiometricType> availableBiometrics =
          await auth.getAvailableBiometrics();

      if (Platform.isIOS) {
        if (availableBiometrics.contains(BiometricType.face)) {
        } else if (availableBiometrics.contains(BiometricType.fingerprint)) {}
        _authenticate(reason: 'iOS');
      } else {
        _authenticate(reason: 'Android');
      }
    }
  }

  _authenticate({reason: 'Scan your finger to authenticate'}) async {
    bool authenticated = await auth.authenticateWithBiometrics(
        localizedReason: reason, useErrorDialogs: true, stickyAuth: false);

    if (!mounted) {
      return;
    }

    if (authenticated) {
      loginSuccess();
    }
  }

  loginSuccess () {
    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => new MovieApp())
        , (route) => route == null);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      resizeToAvoidBottomPadding: true,
      body: SafeArea(
          child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text("Welcome back!",
                      style: TextStyle(fontSize: 30, color: Colors.black54)),
                ),
                SizedBox(
                  height: 50,
                ),
                TextFormField(
                  focusNode: _unameFocus,
                  controller: _unameController,
                  decoration: InputDecoration(
                      labelText: "Username", hintText: "E-Mail or Nickname"),
                  validator: (value) =>
                      value.trim().length > 0 ? null : "Username not valid!",
                ),
                SizedBox(height: 60),
                TextFormField(
                  focusNode: _pwdFocus,
                  controller: _pwdController,
                  decoration: InputDecoration(
                    labelText: "Password",
                  ),
                  obscureText: true,
                  validator: (value) =>
                      value.trim().length > 5 ? null : "Too short!",
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(children: <Widget>[
                      Switch(
                        value: _remember,
                        onChanged: (value) {
                          setState(() => _remember = value);
                        },
                      ),
                      Text("Remember me",
                          style: TextStyle(color: Colors.black38, fontSize: 12))
                    ]),
                    Text("Forgot Password?",
                        style: TextStyle(
                            color: Color.fromRGBO(58, 210, 159, 1.0),
                            fontSize: 12)),
                  ],
                ),
                SizedBox(height: 20),
                Hero(
                    tag: "login_button",
                    child: RaisedButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6.0)),
                      onPressed: () {
                        if ((_formKey.currentState as FormState).validate()) {
                          setState(() {
                            _isLoging = true;
                          });

                          Future.delayed(Duration(milliseconds: 1500), () {
                            setState(() {
                              _isLoging = false;

                              _scaffoldKey.currentState.showSnackBar(SnackBar(
                                content: Text("Login success!"),
                                duration: Duration(milliseconds: 1000),
                              ));
                            });
                          }).then((result) {
                            Future.delayed(
                                Duration(milliseconds: 1000),
                                loginSuccess);
                          });
                        }
//                        _unameFocus.unfocus();
//                        _pwdFocus.unfocus();
                      },
                      textColor: Colors.white,
                      child: Container(
                        alignment: Alignment.center,
                        constraints: BoxConstraints.expand(
                            width: double.infinity, height: 40),
                        child: _isLoging
                            ? Container(
                                width: 25,
                                height: 25,
                                child: CircularProgressIndicator(
                                    valueColor:
                                        AlwaysStoppedAnimation(Colors.white)))
                            : Text(
                                'LOGIN',
                                style: TextStyle(fontSize: 18),
                              ),
                      ),
                      color: Color.fromRGBO(58, 210, 159, 1.0),
                    ))
              ],
            )),
      )),
    );
  }
}
