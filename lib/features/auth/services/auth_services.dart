import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'package:amazon_clone/constants/utils.dart';
import 'package:amazon_clone/models/user_model.dart';
import 'package:amazon_clone/providers/user_provider.dart';
import 'package:amazon_clone/constants/error_handling.dart';
import 'package:amazon_clone/constants/global_variables.dart';
import 'package:amazon_clone/features/home/screens/home_screen.dart';

class AuthServices {
  // SingUp User
  void singUpUser({
    required BuildContext context,
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      UserModel userModel = UserModel(
        id: '',
        name: name,
        email: email,
        password: password,
        address: '',
        type: '',
        token: '',
      );

      http.Response res = await http.post(
        Uri.parse("$uri/api/singup"),
        body: userModel.toJson(),
        headers: <String, String>{
          "Content-Type": "application/json; charset=UTF-8",
        },
      );

      httpErrorHandling(
        response: res,
        context: context,
        onSuccess: () {
          showSnackBar(
            context,
            "Account Created! Login with the same credentials!",
          );
        },
      );

      // print("res.statusCode: ${res.statusCode}");
      // print("res.body: ${res.body}");
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  // SingIn User
  void signInUser({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    try {
      http.Response res = await http.post(
        Uri.parse("$uri/api/singin"),
        body: jsonEncode({
          'email': email,
          'password': password,
        }),
        headers: <String, String>{
          "Content-Type": "application/json; charset=UTF-8",
        },
      );

      // print("res.body: ${res.body}");

      httpErrorHandling(
        response: res,
        context: context,
        onSuccess: () async {
          // with shared_preferences -> we will store token in our app memory
          // with provider -> we will store the user data (res.body data)
          // that we can access it in our application (help us not to use constructor each time we need the data)

          // Obtain shared preferences.
          SharedPreferences prefs = await SharedPreferences.getInstance();

          /// ** Every time we are outside the build function we are going to set listen to false
          Provider.of<UserProvider>(context, listen: false).setUser(res.body);

          // Save an String value to 'action' key.
          await prefs.setString('x-auth-token', jsonDecode(res.body)['token']);

          Navigator.pushNamedAndRemoveUntil(
            context,
            HomeScreen.routName,
            (route) => false,
          );
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  // get user data
  void getUserData(BuildContext context) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('x-auth-token');

      if (token == null) {
        prefs.setString('x-auth-token', '');
      }

      var tokenRes = await http.post(
        Uri.parse('$uri/tokenIsValid'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': token!
        },
      );

      var response = jsonDecode(tokenRes.body);
      if (response == true) {
        http.Response userRes = await http.get(
          Uri.parse('$uri/'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'x-auth-token': token
          },
        );

        var userProvider = Provider.of<UserProvider>(context, listen: false);
        userProvider.setUser(userRes.body);
      }
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
}
