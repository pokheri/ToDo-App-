import 'package:flutter/material.dart';
import 'package:todo/resources/auth_service.dart';
import 'package:todo/routes/routes_name.dart';
import 'package:todo/styles/button_style.dart';
import 'package:todo/utils/theme.dart';
import 'package:todo/widgets/login_page_widgets.dart';

Map<String, dynamic> errorlist = {'email': null, 'password': null};

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  bool isSecure = true;
  String? email;
  String? password;
  bool isLoadinSpinner = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 40, 20, 45),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Login here ",
                  style: TextStyle(
                    color: MyCustomTheme.textLabeldColor,
                    fontSize: 25,
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 23),
                Text(
                  "Welcome back you've \n been missed!",
                  style: TextStyle(fontSize: 23, fontWeight: FontWeight.w500),
                  textAlign: TextAlign.center,
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      SizedBox(height: 23),
                      Padding(
                        padding: const EdgeInsets.only(top: 20, bottom: 20),
                        child: TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            if (value?.endsWith('@gmail.com') ?? false) {
                              return null;
                            }
                            return "Enter valid email ";
                          },
                          onSaved: (newValue) {
                            email = newValue;
                          },
                          decoration: InputDecoration(
                            errorText: null,
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                            focusedBorder: outlinedBorderStyle,
                            disabledBorder: outlinedBorderStyle,
                            enabledBorder: outlinedBorderStyle,
                            hintText: "Email",
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 15),
                        child: TextFormField(
                          obscureText: isSecure,
                          validator: (value) {
                            debugPrint('called password validators ');
                            if ((value?.length ?? 0) < 6) {
                              return "Password length must be greater than 6 digits ";
                            }
                            return null;
                          },
                          onSaved: (newValue) {
                            password = newValue;
                          },

                          decoration: InputDecoration(
                            errorText: null,
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                            focusedBorder: outlinedBorderStyle,
                            disabledBorder: outlinedBorderStyle,
                            enabledBorder: outlinedBorderStyle,

                            suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  isSecure = isSecure == true ? false : true;
                                });
                              },
                              icon: Icon(
                                size: 23,
                                isSecure == true
                                    ? Icons.remove_red_eye_sharp
                                    : Icons.remove_red_eye_outlined,
                              ),
                            ),
                            hintText: "Password",
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, Routes.resetEmail);
                    },
                    child: Text(
                      "Reset your password?",
                      style: TextStyle(color: Color(0xffE43636), fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
                SizedBox(height: 30),
                SizedBox(
                  height: 50,
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: isLoadinSpinner == false
                        ? () async {
                            setState(() {
                              isLoadinSpinner = true;
                            });
                            try {
                              if (_formKey.currentState!.validate()) {
                                _formKey.currentState!.save();
                                await authenticateUser(email!, password!, context);
                              } else {
                                debugPrint('got an erorr ');
                              }
                            } finally {
                              setState(() {
                                isLoadinSpinner = false;
                              });
                            }
                          }
                        : null,
                    style: ElevatedButton.styleFrom(
                      // backgroundColor: MyCustomTheme.buttonBackgroundColor,
                      // textStyle: TextStyle(color: Colors.white),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    ),
                    child: isLoadinSpinner == false
                        ? Text('Sign in', style: TextStyle(color: Colors.white, fontSize: 16))
                        : CircularProgressIndicator(),
                  ),
                ),
                SizedBox(height: 20),
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, Routes.singup);
                  },
                  child: Text(
                    "Create new account",
                    style: TextStyle(
                      fontSize: 14.5,
                      fontWeight: FontWeight.w400,
                      color: Colors.black,
                    ),
                  ),
                ),
                SizedBox(height: 25),
                BottomButtonNavigation(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
