import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project/ui/pages/login/login.dart';
import 'package:project/ui/pages/register/register.dart';
import 'package:project/ui/shared/size_fit.dart';

class HYRegisterContent extends StatefulWidget {
  HYRegisterContent({super.key});

  @override
  State<HYRegisterContent> createState() => _HYRegisterContentState();
}

class _HYRegisterContentState extends State<HYRegisterContent> {
  bool pwdVissible = false;
  bool repwdVissible = false;
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController repasswordController = TextEditingController();

  bool comparedPassword(String p1, String p2) {
    if (p1 == p2) {
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    // Ensure HYSizeFit is initialized for responsive scaling
    HYSizeFit.initialize();

    return LayoutBuilder(
      builder: (context, constraints) {
        return SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.px),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: constraints.maxHeight * 0.15),
                buildRegisterTitle(context),
                SizedBox(height: 50.px),
                buildContent(),
                SizedBox(height: 10.px),
                buildArrow(context),
                SizedBox(height: 20.px),
                buildSubmitButton(),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget buildRegisterTitle(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(left: 20.px),
      child: Text(
        "Register",
        style: TextStyle(
          fontSize: 50.px,
          fontFamily: GoogleFonts.tapestry().fontFamily,
        ),
      ),
    );
  }

  Widget buildContent() {
    return Container(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.px),
            child: TextFormField(
              controller: nameController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Please enter your name",
                label: Text(
                  "Name",
                  style: TextStyle(
                    fontFamily: GoogleFonts.tapestry().fontFamily,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 50.px),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.px),
            child: TextFormField(
              controller: emailController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Please enter your email",
                label: Text(
                  "Email",
                  style: TextStyle(
                    fontFamily: GoogleFonts.tapestry().fontFamily,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 50.px),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.px),
            child: TextFormField(
              obscureText: !pwdVissible,
              controller: passwordController,
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                hintText: "Please enter your password",
                label: Text(
                  "Password",
                  style: TextStyle(
                    fontFamily: GoogleFonts.tapestry().fontFamily,
                  ),
                ),
                suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      pwdVissible = !pwdVissible;
                    });
                  },
                  icon: Icon(
                      pwdVissible ? Icons.visibility : Icons.visibility_off),
                ),
              ),
            ),
          ),
          SizedBox(height: 50.px),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.px),
            child: TextFormField(
              obscureText: !repwdVissible,
              controller: repasswordController,
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                hintText: "Please re-enter your password",
                label: Text(
                  "Re-enter Password",
                  style: TextStyle(
                    fontFamily: GoogleFonts.tapestry().fontFamily,
                  ),
                ),
                suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      repwdVissible = !repwdVissible;
                    });
                  },
                  icon: Icon(
                      repwdVissible ? Icons.visibility : Icons.visibility_off),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildArrow(BuildContext ctx) {
    return GestureDetector(
      onTap: () {
        print("Navigating to Login Page");

        Navigator.pushNamed(ctx, HYLogin.routeName);
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            "Login your account?",
            style: TextStyle(
              fontFamily: GoogleFonts.tapestry().fontFamily,
              fontSize: 20.px,
            ),
          ),
          const Icon(
            Icons.arrow_right_alt,
            color: Colors.red,
            size: 40.0,
          ),
        ],
      ),
    );
  }

  Widget buildSubmitButton() {
    return Container(
      width: double.infinity,
      height: 60.px,
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Colors.red),
        ),
        child: Text(
          "Submit",
          style: TextStyle(
            color: Colors.white,
            fontFamily: GoogleFonts.tapestry().fontFamily,
          ),
        ),
        onPressed: () {
          if (comparedPassword(
              passwordController.text, repasswordController.text)) {
            print("Name: ${nameController.text}");
            print("Email: ${emailController.text}");
            print("Password: ${passwordController.text}");
            print("Re-Password: ${repasswordController.text}");
          } else {
            print(
                "Password 1 is ${passwordController.text} and password 2 is ${repasswordController.text}");
            print("Please ensure two password are same");
          }
        },
      ),
    );
  }
}
