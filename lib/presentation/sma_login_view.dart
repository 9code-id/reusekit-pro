import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class SmaLoginView extends StatefulWidget {
  const SmaLoginView({super.key});

  @override
  State<SmaLoginView> createState() => _SmaLoginViewState();
}

class _SmaLoginViewState extends State<SmaLoginView> {
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
          spacing: spMd,
          children: [
            SizedBox(height: spXl),

            // Logo and Title
            Column(
              children: [
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    color: primaryColor,
                    borderRadius: BorderRadius.circular(radiusLg),
                    boxShadow: [shadowMd],
                  ),
                  child: Icon(
                    Icons.share,
                    size: 40,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: spMd),
                Text(
                  "Welcome Back!",
                  style: TextStyle(
                    fontSize: fsH2,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spXs),
                Text(
                  "Sign in to continue to SocieLink",
                  style: TextStyle(
                    fontSize: 16,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),

            SizedBox(height: spXl),

            // Login Form
            Form(
              key: formKey,
              child: Column(
                spacing: spMd,
                children: [
                  QTextField(
                    label: "Email",
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
                            obscurePassword ? "Show" : "Hide",
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

                  // Remember Me and Forgot Password
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
                      Spacer(),
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

                  SizedBox(height: spMd),

                  // Login Button
                  Container(
                    width: double.infinity,
                    child: QButton(
                      label: "Sign In",
                      size: bs.md,
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          // Handle login
                          // ss('Next page'));
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: spXl),

            // Divider
            Row(
              children: [
                Expanded(
                  child: Container(
                    height: 1,
                    color: disabledColor,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: spMd),
                  child: Text(
                    "OR",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    height: 1,
                    color: disabledColor,
                  ),
                ),
              ],
            ),

            SizedBox(height: spMd),

            // Social Login Buttons
            Column(
              spacing: spSm,
              children: [
                Container(
                  width: double.infinity,
                  child: QButton(
                    label: "Continue with Google",
                    icon: Icons.g_mobiledata,
                    size: bs.md,
                    onPressed: () {
                      // Handle Google login
                    },
                  ),
                ),
                Container(
                  width: double.infinity,
                  child: QButton(
                    label: "Continue with Facebook",
                    icon: Icons.facebook,
                    size: bs.md,
                    onPressed: () {
                      // Handle Facebook login
                    },
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
                    // Navigate to register
                    // ss('Next page'));
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
