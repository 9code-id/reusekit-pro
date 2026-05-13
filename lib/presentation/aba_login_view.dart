import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class AbaLoginView extends StatefulWidget {
  const AbaLoginView({super.key});

  @override
  State<AbaLoginView> createState() => _AbaLoginViewState();
}

class _AbaLoginViewState extends State<AbaLoginView> {
  final formKey = GlobalKey<FormState>();
  String email = "";
  String password = "";
  bool rememberMe = false;
  bool obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: spXl * 2),
            
            // Logo and Title
            Center(
              child: Column(
                children: [
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      color: primaryColor,
                      borderRadius: BorderRadius.circular(radiusLg),
                    ),
                    child: Icon(
                      Icons.account_balance,
                      color: Colors.white,
                      size: 40,
                    ),
                  ),
                  SizedBox(height: spMd),
                  Text(
                    "ABA Business",
                    style: TextStyle(
                      fontSize: fsH1,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spXs),
                  Text(
                    "Your Accounting & Business Solution",
                    style: TextStyle(
                      fontSize: 16,
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ),
            ),
            
            SizedBox(height: spXl),
            
            // Welcome Text
            Text(
              "Welcome Back",
              style: TextStyle(
                fontSize: fsH3,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spXs),
            Text(
              "Sign in to continue to your account",
              style: TextStyle(
                fontSize: 16,
                color: disabledBoldColor,
              ),
            ),
            
            SizedBox(height: spLg),
            
            // Login Form
            Form(
              key: formKey,
              child: Column(
                spacing: spMd,
                children: [
                  QTextField(
                    label: "Email Address",
                    value: email,
                    hint: "Enter your email address",
                    validator: Validator.email,
                    onChanged: (value) {
                      email = value;
                      setState(() {});
                    },
                  ),
                  
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      QTextField(
                        label: "Password",
                        value: password,
                        hint: "Enter your password",
                        obscureText: obscurePassword,
                        validator: Validator.required,
                        onChanged: (value) {
                          password = value;
                          setState(() {});
                        },
                      ),
                      SizedBox(height: spXs),
                      Align(
                        alignment: Alignment.centerRight,
                        child: GestureDetector(
                          onTap: () {
                            obscurePassword = !obscurePassword;
                            setState(() {});
                          },
                          child: Text(
                            obscurePassword ? "Show Password" : "Hide Password",
                            style: TextStyle(
                              color: primaryColor,
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            
            SizedBox(height: spMd),
            
            // Remember Me & Forgot Password
            Row(
              children: [
                Expanded(
                  child: QSwitch(
                    items: [
                      {
                        "label": "Remember me",
                        "value": true,
                        "checked": rememberMe,
                      }
                    ],
                    value: [
                      if (rememberMe)
                        {
                          "label": "Remember me",
                          "value": true,
                          "checked": true
                        }
                    ],
                    onChanged: (values, ids) {
                      setState(() {
                        rememberMe = values.isNotEmpty;
                      });
                    },
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    //navigateTo('AbaForgotPasswordView')
                  },
                  child: Text(
                    "Forgot Password?",
                    style: TextStyle(
                      fontSize: 14,
                      color: primaryColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            
            SizedBox(height: spLg),
            
            // Login Button
            Container(
              width: double.infinity,
              child: QButton(
                label: "Sign In",
                size: bs.md,
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    //navigateTo('AbaHomeView')
                  }
                },
              ),
            ),
            
            SizedBox(height: spLg),
            
            // Divider
            Row(
              children: [
                Expanded(child: Divider(color: disabledColor)),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: spSm),
                  child: Text(
                    "OR",
                    style: TextStyle(
                      color: disabledBoldColor,
                      fontSize: 14,
                    ),
                  ),
                ),
                Expanded(child: Divider(color: disabledColor)),
              ],
            ),
            
            SizedBox(height: spLg),
            
            // Social Login Options
            Column(
              spacing: spSm,
              children: [
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    border: Border.all(color: disabledOutlineBorderColor),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.g_mobiledata,
                        size: 24,
                        color: dangerColor,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "Continue with Google",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
                
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    border: Border.all(color: disabledOutlineBorderColor),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.apple,
                        size: 24,
                        color: primaryColor,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "Continue with Apple",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            
            SizedBox(height: spXl),
            
            // Sign Up Link
            Center(
              child: GestureDetector(
                onTap: () {
                  //navigateTo('AbaRegisterView')
                },
                child: RichText(
                  text: TextSpan(
                    style: TextStyle(
                      fontSize: 16,
                      color: disabledBoldColor,
                    ),
                    children: [
                      TextSpan(text: "Don't have an account? "),
                      TextSpan(
                        text: "Sign Up",
                        style: TextStyle(
                          color: primaryColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            
            SizedBox(height: spMd),
          ],
        ),
      ),
    );
  }
}
