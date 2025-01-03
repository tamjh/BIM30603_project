import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:project/core/model/UserModel.dart';
import 'package:project/core/viewmodel/user_view_model.dart';
import 'package:project/ui/pages/login/login.dart';
import 'package:project/ui/pages/main/main.dart';
import 'package:provider/provider.dart';

class HYRegisterContent extends StatefulWidget {
  HYRegisterContent({super.key});

  @override
  State<HYRegisterContent> createState() => _HYRegisterContentState();
}

class _HYRegisterContentState extends State<HYRegisterContent> {
  final TextEditingController nameController = TextEditingController();

  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  final TextEditingController repasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Consumer<UserViewModel>(
      builder: (context, viewModel, child) {
        return LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: constraints.maxHeight * 0.15),
                    buildRegisterTitle(context),
                    SizedBox(height: 50.h),
                    buildContent(),
                    SizedBox(height: 10.h),
                    buildArrow(context),
                    SizedBox(height: 20.h),
                    viewModel.isLoading
                        ? Center(child: CircularProgressIndicator())
                        : buildSubmitButton(viewModel, context),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget buildRegisterTitle(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(left: 20.sp),
      child: Text(
        "Register",
        style: TextStyle(
          fontSize: 50.sp,
          fontFamily: GoogleFonts.tapestry().fontFamily,
        ),
      ),
    );
  }

  Widget buildContent() {
    return Column(
      children: [
        buildTextField(nameController, "Name", "Please enter your name"),
        SizedBox(height: 30.h),
        buildTextField(emailController, "Email", "Please enter your email"),
        SizedBox(height: 30.h),
        buildPasswordField(passwordController, "Password", "Please enter your password"),
        SizedBox(height: 30.h),
        buildPasswordField(repasswordController, "Re-enter Password", "Please re-enter your password"),
      ],
    );
  }

  Widget buildTextField(TextEditingController controller, String label, String hint) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          hintText: hint,
          label: Text(label, style: TextStyle(fontFamily: GoogleFonts.tapestry().fontFamily)),
        ),
      ),
    );
  }

  //the display password have problem (cannot toggle / cannot display)
  Widget buildPasswordField(TextEditingController controller, String label, String hint) {
    bool passwordVisible = false;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      child: TextFormField(
        obscureText: !passwordVisible,
        controller: controller,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          hintText: hint,
          label: Text(label, style: TextStyle(fontFamily: GoogleFonts.tapestry().fontFamily)),
          suffixIcon: IconButton(
            onPressed: () {
              setState(() {
                passwordVisible = !passwordVisible;
              });
            },
            icon: Icon(passwordVisible ? Icons.visibility : Icons.visibility_off),
          ),
        ),
      ),
    );
  }

  Widget buildArrow(BuildContext ctx) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(ctx, HYLogin.routeName);
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            "Login your account?",
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

  Widget buildSubmitButton(UserViewModel viewModel, BuildContext context) {
        final double buttonHeight = MediaQuery.of(context).size.height * 0.06;

    return Container(
      width: double.infinity,
      height: buttonHeight,
      child: ElevatedButton(
        style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.red)),
        child: Text(
          "Submit",
          style: TextStyle(
            color: Colors.white,
            fontFamily: GoogleFonts.tapestry().fontFamily,
          ),
        ),
        onPressed: () async {
          String email = emailController.text.trim();
          String password = passwordController.text.trim();
          String name = nameController.text.trim();

          try {
            UserModel? user = await viewModel.register(
              email: email,
              password: password,
              name: name,
            );

            if (user != null) {
              Navigator.pushNamed(context, HYMainScreen.routeName);
            }
          } catch (e) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
          }
        },
      ),
    );
  }
}
