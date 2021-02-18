import 'package:best_starter_architecture/models/custom_user.dart';
import 'package:best_starter_architecture/services/auth_service.dart';
import 'package:best_starter_architecture/shared/constants.dart';
import 'package:best_starter_architecture/shared/size_config.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignInForm extends StatefulWidget {
  @override
  _SignInFormState createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  final _formKey = GlobalKey<FormState>();
  final RegExp emailValidatorRegExp =
      RegExp(r"^[a-zA-Z0-9.-_]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
  final String kInvalidEmailError = "Please Enter Valid email";

  String _email;

  String _password;

  bool isLoading = false;

  Future<void> _signInAnonymously(BuildContext context) async {
    try {
      final auth = Provider.of<AuthService>(context, listen: false);
      await auth.signInAnon();
    } catch (e) {
      print(e);
    }
  }

  Future<CustomUser> _signInEmailPassword(
      BuildContext context, String email, String password) async {
    try {
      final auth = Provider.of<AuthService>(context, listen: false);
      final usr = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      print(usr);
      return usr;
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    print('rebuilding-sign form');
    SizeConfig().init(context);
    return isLoading
        ? CircularProgressIndicator()
        : Form(
            key: _formKey,
            child: Column(
              children: [
                SizedBox(
                  width: SizeConfig.screenWidth * 0.79,
                  child: buildEmailFormField(),
                ),
                SizedBox(height: getProportionateScreenHeight(30)),
                SizedBox(
                  width: SizeConfig.screenWidth * 0.79,
                  child: buildPasswordFormField(),
                ),
                SizedBox(height: getProportionateScreenHeight(30)),
                FlatButton(
                  color: kSecondaryColor,
                  shape: RoundedRectangleBorder(
                    side: BorderSide(color: kPrimaryColor, width: 1.5),
                  ),
                  child: Text('Sign in'),
                  onPressed: () async {
                    if (_formKey.currentState.validate()) {
                      setState(() {
                        isLoading = true;
                      });
                      // final _authService =
                      //     Provider.of<AuthService>(context, listen: false);
                      // final dynamic user =
                      //     await _authService.signInWithEmailAndPassword(
                      //   email: this._email,
                      //   password: this._password,
                      // );
                      // print(user);
                      final dynamic user = await _signInEmailPassword(
                          context, _email, _password);
                      if (user == null) {
                        setState(() {
                          isLoading = false;
                        });
                      }
                      //}
                    }
                  },
                ),
              ],
            ),
          );
  }

  TextFormField buildEmailFormField() {
    return TextFormField(
      onSaved: (newValue) => _email = newValue,
      onChanged: (value) {
        setState(() {
          _email = value;
        });
      },
      onFieldSubmitted: (value) {
        setState(() {
          _email = value;
        });
      },
      validator: (value) {
        if (value.isEmpty) {
          return 'Email is empty';
        }
        if (!emailValidatorRegExp.hasMatch(value)) {
          return kInvalidEmailError;
        }
        return null;
      },
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        hintText: 'Enter your email',
        labelText: "Email",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: Icon(Icons.email),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: kPrimaryColor, width: 1.4),
        ),
      ),
    );
  }

  TextFormField buildPasswordFormField() {
    return TextFormField(
      obscureText: true,
      onSaved: (newValue) => _password = newValue,
      onChanged: (value) {
        setState(() {
          _password = value;
        });
      },
      onFieldSubmitted: (value) {
        setState(() {
          _password = value;
        });
      },
      validator: (value) {
        if (value.length < 8) return 'Password too short';
        return null;
      },
      decoration: InputDecoration(
        hintText: 'Enter your password',
        labelText: "Password",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: Icon(Icons.lock_outline),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: kPrimaryColor, width: 1.4),
        ),
      ),
    );
  }
}
