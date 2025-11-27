import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:todo/routes/routes_name.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 350,
              padding: EdgeInsets.only(left: 12, right: 12),
              margin: EdgeInsets.only(top: 100, bottom: 0),

              child: SvgPicture.asset("assets/images/welcome.svg"),
            ),
            Text(
              "Let’s Conquer Your Day!",
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,

                color: const Color.fromARGB(255, 108, 99, 255),
              ),
              textAlign: TextAlign.center,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
              child: Text(
                "Track your to-dos and win your day, one task at a time.",
                style: TextStyle(fontSize: 16),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 50),
            OverflowBar(
              alignment: MainAxisAlignment.spaceAround,
              spacing: 23,
              children: [
                SizedBox(
                  height: 50,
                  width: 130,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, Routes.login);
                    },

                    // style: ElevatedButton.styleFrom(
                    //   backgroundColor: const Color.fromARGB(255, 108, 99, 255),
                    //   foregroundColor: Colors.white,
                    //   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                    // ),
                    child: Text("Login"),
                  ),
                ),
                SizedBox(
                  height: 50,
                  width: 130,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, Routes.singup);
                    },

                    // style: ElevatedButton.styleFrom(
                    //   backgroundColor: const Color.fromARGB(255, 108, 99, 255),
                    //   foregroundColor: Colors.white,
                    //   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                    // ),
                    child: Text("Register"),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
