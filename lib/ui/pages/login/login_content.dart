import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project/ui/pages/home/home.dart';
import 'package:project/ui/pages/main/main.dart';
import 'package:project/ui/pages/register/register.dart';
import 'package:project/ui/shared/size_fit.dart';

class HYLoginContent extends StatefulWidget {
  HYLoginContent({super.key});

  @override
  State<HYLoginContent> createState() => _HYLoginContentState();
}

class _HYLoginContentState extends State<HYLoginContent> {
  bool pwdVissible = false;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

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
                buildLoginTitle(context),
                SizedBox(height: 50.px),
                buildContent(),
                SizedBox(height: 10.px),
                buildArrow(context),
                SizedBox(height: 20.px),
                buildSubmitButton(context),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget buildLoginTitle(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(left: 20.px),
      child: Text(
        "Login",
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
        ],
      ),
    );
  }

  Widget buildArrow(BuildContext ctx) {
    return GestureDetector(
      onTap: () {
        print("Navigating to Register Page");

        // Navigating to Register screen
        Navigator.pushNamed(ctx, HYRegister.routeName);
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            "Register new account?",
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

  Widget buildSubmitButton(BuildContext ctx) {
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
          print("Email: ${emailController.text}");
          print("Password: ${passwordController.text}");

          // After login, navigate back to the main screen with bottom navigation
          Navigator.pushNamed(ctx, HYMainScreen.routeName);
        },
      ),
    );
  }
}
