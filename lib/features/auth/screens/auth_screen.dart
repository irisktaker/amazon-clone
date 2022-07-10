import 'package:amazon_clone/common/widgets/custom_button.dart';
import 'package:amazon_clone/common/widgets/custom_text_field.dart';
import 'package:amazon_clone/constants/global_variables.dart';
import 'package:amazon_clone/features/auth/services/auth_services.dart';
import 'package:flutter/material.dart';

enum Auth {
  singIn,
  singUp,
}

class AuthScreen extends StatefulWidget {
  static const String routName = '/auth-screen';
  const AuthScreen({Key? key}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  // groupValue
  Auth _auth = Auth.singUp; // as a default value

  // global key
  final _singUpFormKey = GlobalKey<FormState>();
  final _singInFormKey = GlobalKey<FormState>();

  // services
  final AuthServices authServices = AuthServices();

  // controllers
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  // clear from memory
  @override
  void dispose() {
    _nameController.clear();
    _emailController.clear();
    _passwordController.clear();

    super.dispose();
  }

  void singUpUser() {
    authServices.singUpUser(
      context: context,
      name: _nameController.text,
      email: _emailController.text,
      password: _passwordController.text,
    );
  }

  void singInUser() {
    authServices.signInUser(
      context: context,
      email: _emailController.text,
      password: _passwordController.text,
    );
  }

  // methods
  ListTile _radioTile({required Auth value, required String title}) {
    return ListTile(
      tileColor: _auth == value
          ? GlobalVariables.backgroundColor
          : GlobalVariables.greyBackgroundColor,
      leading: Radio(
          activeColor: GlobalVariables.secondaryColor,
          value: value,
          groupValue: _auth,
          onChanged: (Auth? val) => setState(() => _auth = val!)),
      title: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.w600),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: GlobalVariables.greyBackgroundColor,
        body: SafeArea(
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 10.0, vertical: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Welcome",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
                ),

                // SIGN UP
                _radioTile(
                  value: Auth.singUp,
                  title: "Create Account.",
                ),
                if (Auth.singUp == _auth)
                  Container(
                    color: GlobalVariables.backgroundColor,
                    padding: const EdgeInsets.all(8.0),
                    child: Form(
                      key: _singUpFormKey,
                      child: Column(
                        children: [
                          CustomTextField(
                              controller: _nameController, hintText: "Name"),
                          const SizedBox(height: 10),
                          CustomTextField(
                              controller: _emailController, hintText: "Email"),
                          const SizedBox(height: 10),
                          CustomTextField(
                            controller: _passwordController,
                            hintText: "Password",
                            obscureText: true,
                          ),
                          const SizedBox(height: 10),
                          CustomButton(
                            text: "Sing Up",
                            onPressed: () {
                              if (_singUpFormKey.currentState!.validate()) {
                                singUpUser();
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  ),

                // SIGN IN
                _radioTile(
                  value: Auth.singIn,
                  title: "Sign-In.",
                ),
                if (Auth.singIn == _auth)
                  Container(
                    color: GlobalVariables.backgroundColor,
                    padding: const EdgeInsets.all(8.0),
                    child: Form(
                      key: _singInFormKey,
                      child: Column(
                        children: [
                          CustomTextField(
                              controller: _emailController, hintText: "Email"),
                          const SizedBox(height: 10),
                          CustomTextField(
                            controller: _passwordController,
                            hintText: "Password",
                            obscureText: true,
                          ),
                          const SizedBox(height: 10),
                          CustomButton(
                            text: "Sing In",
                            onPressed: () {
                              if (_singInFormKey.currentState!.validate()) {
                                singInUser();
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
