import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project/core/model/UserModel.dart';
import 'package:project/ui/pages/register/register.dart';
import 'package:project/ui/pages/main/main.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:project/ui/widgets/errorMsg.dart';
import 'package:provider/provider.dart';
import 'package:project/core/viewmodel/user_view_model.dart';

class HYLoginContent extends StatefulWidget {
  HYLoginContent({super.key});

  @override
  State<HYLoginContent> createState() => _HYLoginContentState();
}

final TextEditingController emailController = TextEditingController();
final TextEditingController passwordController = TextEditingController();
bool pwdVissible = false;

class _HYLoginContentState extends State<HYLoginContent> {
  @override
  Widget build(BuildContext context) {
    return Consumer<UserViewModel>(
      builder: (context, viewModel, child) {
        return LayoutBuilder(
          builder: (context, constraints) {
            return ListView(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              children: [
                SizedBox(height: constraints.maxHeight * 0.10),
                buildLoginTitle(context),
                SizedBox(height: 50.h),
                buildContent(),
                SizedBox(height: 10.h),
                buildArrow(context),
                SizedBox(height: 20.h),
                viewModel.isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : buildSubmitButton(context, viewModel),
              ],
            );
          },
        );
      },
    );
  }

  Widget buildLoginTitle(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(left: 20.w),
      child: Text(
        "Login",
        style: TextStyle(
          fontSize: 50.sp,
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
            padding: EdgeInsets.symmetric(horizontal: 10.w),
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
          SizedBox(height: 30.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w),
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


        // Navigating to Register screen
        Navigator.pushNamedAndRemoveUntil(ctx, HYRegister.routeName, (route)=>false);
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            "Register new account?",
            style: TextStyle(
              fontFamily: GoogleFonts.tapestry().fontFamily,
              fontSize: 20.sp,
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

  Widget buildSubmitButton(BuildContext ctx, UserViewModel viewModel) {
    final double buttonHeight = MediaQuery.of(context).size.height * 0.06;
    return Container(
      width: double.infinity,
      height: buttonHeight,
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Colors.red),
        ),
        child: Text(
          "Submit",
          style: TextStyle(
              color: Colors.white,
              fontFamily: GoogleFonts.tapestry().fontFamily,
              fontSize: buttonHeight * 0.5),
        ),
        onPressed: () {
          _login(viewModel);
        },
      ),
    );
  }

  Future<void> _login(UserViewModel viewModel) async {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();

    try {
      UserModel? user = await viewModel.login(email: email, password: password);

      if (user != null) {
        // print("User Logged In: ${user.toMap()}");

        // Navigate to the main page
        Navigator.pushNamedAndRemoveUntil(context, HYMainScreen.routeName, (route)=>false);
      }
    } catch (e) {
      SnackbarUtils.showErrorMessage(context, "Invalid Email or Passwod");
    }
  }
}
