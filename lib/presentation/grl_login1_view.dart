import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlLogin1View extends StatefulWidget {
  const GrlLogin1View({super.key});

  @override
  State<GrlLogin1View> createState() => _GrlLogin1ViewState();
}

class _GrlLogin1ViewState extends State<GrlLogin1View> {
  String email = "";
  String password = "";
  bool rememberMe = false;
  bool isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            SizedBox(height: spXl),
            
            // Logo Section
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                color: primaryColor,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowMd],
              ),
              child: Icon(
                Icons.security,
                size: 60,
                color: Colors.white,
              ),
            ),
            
            SizedBox(height: spLg),
            
            // Welcome Text
            Text(
              "Welcome Back",
              style: TextStyle(
                fontSize: fsH1,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            
            Text(
              "Sign in to your account to continue",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: disabledBoldColor,
              ),
            ),
            
            SizedBox(height: spXl),
            
            // Login Form
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowMd],
              ),
              child: Column(
                spacing: spMd,
                children: [
                  QTextField(
                    label: "Email Address",
                    value: email,
                    hint: "Enter your email",
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
                        obscureText: !isPasswordVisible,
                        hint: "Enter your password",
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
                            isPasswordVisible = !isPasswordVisible;
                            setState(() {});
                          },
                          child: Text(
                            isPasswordVisible ? "Hide" : "Show",
                            style: TextStyle(
                              color: primaryColor,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  
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
                          // Navigate to forgot password
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
                  
                  SizedBox(height: spSm),
                  
                  Container(
                    width: double.infinity,
                    child: QButton(
                      label: "Sign In",
                      size: bs.md,
                      onPressed: () {
                        // Handle login
                      },
                    ),
                  ),
                ],
              ),
            ),
            
            SizedBox(height: spLg),
            
            // Divider
            Row(
              children: [
                Expanded(child: Divider(color: disabledOutlineBorderColor)),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: spSm),
                  child: Text(
                    "Or continue with",
                    style: TextStyle(
                      color: disabledBoldColor,
                      fontSize: 14,
                    ),
                  ),
                ),
                Expanded(child: Divider(color: disabledOutlineBorderColor)),
              ],
            ),
            
            SizedBox(height: spMd),
            
            // Social Login Buttons
            Row(
              spacing: spSm,
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: spSm),
                    decoration: BoxDecoration(
                      border: Border.all(color: disabledOutlineBorderColor),
                      borderRadius: BorderRadius.circular(radiusLg),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.g_mobiledata, size: 24, color: dangerColor),
                        SizedBox(width: spXs),
                        Text(
                          "Google",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: spSm),
                    decoration: BoxDecoration(
                      border: Border.all(color: disabledOutlineBorderColor),
                      borderRadius: BorderRadius.circular(radiusLg),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.facebook, size: 24, color: infoColor),
                        SizedBox(width: spXs),
                        Text(
                          "Facebook",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            
            SizedBox(height: spXl),
            
            // Sign Up Link
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Don't have an account? ",
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    // Navigate to sign up
                  },
                  child: Text(
                    "Sign Up",
                    style: TextStyle(
                      fontSize: 14,
                      color: primaryColor,
                      fontWeight: FontWeight.w600,
                    ),
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
