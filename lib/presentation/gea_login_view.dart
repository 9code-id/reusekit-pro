import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GeaLoginView extends StatefulWidget {
  const GeaLoginView({super.key});

  @override
  State<GeaLoginView> createState() => _GeaLoginViewState();
}

class _GeaLoginViewState extends State<GeaLoginView> {
  final formKey = GlobalKey<FormState>();
  String email = "";
  String password = "";
  bool rememberMe = false;
  bool obscurePassword = true;

  List<Map<String, dynamic>> socialLoginOptions = [
    {
      "name": "Google",
      "icon": Icons.g_mobiledata,
      "color": Colors.red,
    },
    {
      "name": "Apple",
      "icon": Icons.apple,
      "color": Colors.black,
    },
    {
      "name": "Facebook",
      "icon": Icons.facebook,
      "color": Colors.blue,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              primaryColor.withAlpha(20),
              Colors.white,
            ],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(spMd),
            child: Form(
              key: formKey,
              child: Column(
                spacing: spMd,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header
                  Center(
                    child: Column(
                      children: [
                        Container(
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(
                            color: primaryColor,
                            borderRadius: BorderRadius.circular(radiusXl),
                            boxShadow: [shadowMd],
                          ),
                          child: Icon(
                            Icons.games,
                            size: 40,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: spMd),
                        Text(
                          "Welcome Back!",
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        SizedBox(height: spSm),
                        Text(
                          "Sign in to continue your gaming journey",
                          style: TextStyle(
                            fontSize: 16,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: spXl),

                  // Login Form
                  QTextField(
                    label: "Email",
                    value: email,
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
                          //navigateTo('GeaForgotPasswordView')
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

                  // Login Button
                  QButton(
                    label: "Sign In",
                    size: bs.md,
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        //navigateTo('GeaHomeView')
                      }
                    },
                  ),

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
                            fontSize: 14,
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

                  // Social Login Options
                  Column(
                    spacing: spSm,
                    children: socialLoginOptions.map((option) {
                      return Container(
                        width: double.infinity,
                        child: GestureDetector(
                          onTap: () {
                            //socialLogin(option["name"])
                          },
                          child: Container(
                            padding: EdgeInsets.all(spSm),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(radiusMd),
                              border: Border.all(color: disabledColor),
                              boxShadow: [shadowSm],
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  option["icon"],
                                  color: option["color"],
                                  size: 24,
                                ),
                                SizedBox(width: spSm),
                                Text(
                                  "Continue with ${option["name"]}",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: primaryColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),

                  // Guest Mode
                  Container(
                    width: double.infinity,
                    child: GestureDetector(
                      onTap: () {
                        //navigateTo('GeaGuestModeView')
                      },
                      child: Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: disabledColor.withAlpha(30),
                          borderRadius: BorderRadius.circular(radiusMd),
                          border: Border.all(color: disabledColor),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.person_outline,
                              color: disabledBoldColor,
                              size: 24,
                            ),
                            SizedBox(width: spSm),
                            Text(
                              "Continue as Guest",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: spMd),

                  // Sign Up Link
                  Center(
                    child: Row(
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
                            //navigateTo('GeaRegisterView')
                          },
                          child: Text(
                            "Sign Up",
                            style: TextStyle(
                              fontSize: 14,
                              color: primaryColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Gaming Stats Preview
                  Container(
                    margin: EdgeInsets.only(top: spLg),
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: primaryColor.withAlpha(10),
                      borderRadius: BorderRadius.circular(radiusMd),
                    ),
                    child: Column(
                      children: [
                        Text(
                          "Join Our Gaming Community",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        SizedBox(height: spSm),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            _buildStatItem("1M+", "Active Players"),
                            _buildStatItem("10K+", "Games Available"),
                            _buildStatItem("500+", "Daily Tournaments"),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStatItem(String value, String label) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: disabledBoldColor,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
