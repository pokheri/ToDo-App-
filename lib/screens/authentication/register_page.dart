import 'package:flutter/material.dart';
import 'package:todo/routes/routes_name.dart';
import 'package:todo/styles/button_style.dart';
import 'package:todo/utils/theme.dart';
import 'package:todo/widgets/login_page_widgets.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  String? email;
  String? password;
  String? confirmPassword;
  bool isSecure = true;
  bool isSecure2 = true;
  final passwordTextEditingController = TextEditingController();
  final confirmPasswordTextEditingController = TextEditingController();

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
                  "Create Account",

                  style: TextStyle(
                    color: MyCustomTheme.textLabeldColor,
                    fontSize: 25,
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 10),
                Text(
                  "Create account so you can manage all your task's safely",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
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
                            if (value == null || value.isEmpty) {
                              return "Field is required";
                            } else if (value.endsWith('@gmail.com')) {
                              return null;
                            }
                            return "Enter valid email ";
                          },
                          onSaved: (newValue) {
                            email = newValue;
                          },
                          decoration: InputDecoration(
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                            focusedBorder: outlinedBorderStyle,
                            disabledBorder: outlinedBorderStyle,
                            enabledBorder: outlinedBorderStyle,

                            hintText: "Email",
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: TextFormField(
                          controller: passwordTextEditingController,
                          obscureText: isSecure,
                          validator: (value) {
                            debugPrint('called password validators ');
                            if (value == null || value.isEmpty) {
                              return "Field is required";
                            }
                            return null;
                          },
                          onSaved: (newValue) {
                            password = newValue;
                          },

                          decoration: InputDecoration(
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
                      Padding(
                        padding: const EdgeInsets.only(bottom: 15),
                        child: TextFormField(
                          controller: confirmPasswordTextEditingController,
                          obscureText: isSecure2,
                          validator: (value) {
                            debugPrint('called password validators ');
                            if (value == null || value.isEmpty) {
                              return "Field is required";
                            } else if (value != passwordTextEditingController.text) {
                              return "Password did't match";
                            }
                            return null;
                          },
                          onSaved: (newValue) {
                            confirmPassword = newValue;
                          },

                          decoration: InputDecoration(
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                            focusedBorder: outlinedBorderStyle,
                            disabledBorder: outlinedBorderStyle,
                            enabledBorder: outlinedBorderStyle,
                            suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  isSecure2 = isSecure2 == true ? false : true;
                                });
                              },
                              icon: Icon(
                                size: 23,
                                isSecure2 == true
                                    ? Icons.remove_red_eye_sharp
                                    : Icons.remove_red_eye_outlined,
                              ),
                            ),
                            hintText: "Confirm Password",
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 25),
                SizedBox(
                  height: 50,
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        debugPrint(email);
                        debugPrint(password);
                        debugPrint(confirmPassword);
                      } else {
                        debugPrint('got an erorr ');
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      // backgroundColor: MyCustomTheme.buttonBackgroundColor,
                      // textStyle: TextStyle(color: Colors.white),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    ),
                    child: Text('Signup', style: TextStyle(color: Colors.white, fontSize: 16)),
                  ),
                ),
                SizedBox(height: 20),
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, Routes.login);
                  },
                  child: Text(
                    "Already have an account?",
                    style: TextStyle(
                      fontSize: 14.5,
                      fontWeight: FontWeight.w400,
                      color: Colors.black,
                    ),
                  ),
                ),
                SizedBox(height: 25),
                BottomButtonNavigation(), // bottom navigation buttons
              ],
            ),
          ),
        ),
      ),
    );
  }
}
