import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:news_app_again/api/authentication_api.dart';
import 'package:news_app_again/screens/home_screen.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  AuthenticationAPI authenticationAPI = AuthenticationAPI();

  bool isLoading = false;
  bool loginError = false;

  TextEditingController _userNameController;
  TextEditingController _passwordController;

  String username;
  String password;

  @override
  void initState() {
    super.initState();
    _userNameController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _userNameController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('LOGIN'),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: (isLoading) ? _drawLoading() : _drawLoginForm(),
      ),
    );
  }

  Widget _drawLoginForm() {
    if (loginError) {
      return Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('Login Error'),
              RaisedButton(
                onPressed: () {
                  setState(() {
                    loginError = false;
                  });
                },
                child: Text(
                  'try again',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          TextFormField(
            controller: _userNameController,
            decoration: InputDecoration(labelText: "Username"),
            validator: (value) {
              if (value.isEmpty) {
                return "Please enter your username";
              }
              return null;
            },
          ),
          SizedBox(
            height: 30,
          ),
          TextFormField(
            controller: _passwordController,
            decoration: InputDecoration(
              labelText: "Password",
            ),
            validator: (value) {
              if (value.isEmpty) {
                return "Please enter your password";
              }
              return null;
            },
          ),
          SizedBox(
            height: 30,
          ),
          SizedBox(
            width: double.infinity,
            child: RaisedButton(
              child: Text(
                'Login',
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () async {
                if (_formKey.currentState.validate()) {
                  //TODO: connect with api
                  setState(() {
                    isLoading = true;
                  });

                  username = _userNameController.text;
                  password = _passwordController.text;

                  var response =
                      await authenticationAPI.login(username, password);

                  if (response) {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return HomeScreen();
                    }));
                  } else {
                    loginError = true;
                  }
                  setState(() {
                    isLoading = false;
                  });
                } else {
                  setState(() {
                    isLoading = false;
                  });
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _drawLoading() {
    return Container(
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
