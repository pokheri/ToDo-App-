import 'package:flutter/material.dart';
import 'package:todo/styles/button_style.dart';
import 'package:todo/utils/theme.dart';

class ResetEmailPage extends StatefulWidget {
  const ResetEmailPage({super.key});

  @override
  State<ResetEmailPage> createState() => _ResetEmailPageState();
}

class _ResetEmailPageState extends State<ResetEmailPage> {
  String? email;
  String? password;
  final _formKey = GlobalKey<FormState>();
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
                  "Forget your password",
                  style: TextStyle(
                    color: MyCustomTheme.textLabeldColor,
                    fontSize: 25,
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 23),
                Text(
                  "Provide your registered email to receive  a secure one-time password (OTP).",
                  style: TextStyle(fontSize: 19, fontWeight: FontWeight.w400),
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
                    ],
                  ),
                ),

                SizedBox(
                  height: 50,
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        debugPrint(email);
                        debugPrint(password);
                      } else {
                        debugPrint('got an erorr ');
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      // backgroundColor: MyCustomTheme.buttonBackgroundColor,
                      // textStyle: TextStyle(color: Colors.white),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    ),
                    child: Text('Send OTP', style: TextStyle(color: Colors.white, fontSize: 16)),
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
