import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class FdaLoginView extends StatefulWidget {
  const FdaLoginView({super.key});

  @override
  State<FdaLoginView> createState() => _FdaLoginViewState();
}

class _FdaLoginViewState extends State<FdaLoginView> {
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
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: spXl),
              
              // Logo Section
              Center(
                child: Column(
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
                        Icons.restaurant,
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
                    SizedBox(height: spSm),
                    Text(
                      "Sign in to continue ordering delicious food",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              
              SizedBox(height: spXl),
              
              // Form Fields
              Column(
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
                            obscurePassword ? "Show" : "Hide",
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
                      // 
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
              
              SizedBox(height: spXl),
              
              // Login Button
              QButton(
                label: "Sign In",
                size: bs.md,
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    _login();
                  }
                },
              ),
              
              SizedBox(height: spMd),
              
              // Social Login Section
              Column(
                children: [
                  Text(
                    "Or continue with",
                    style: TextStyle(
                      fontSize: 14,
                      color: disabledBoldColor,
                    ),
                  ),
                  SizedBox(height: spMd),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: spSm),
                          decoration: BoxDecoration(
                            border: Border.all(color: disabledColor),
                            borderRadius: BorderRadius.circular(radiusMd),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.g_mobiledata, color: dangerColor, size: 24),
                              SizedBox(width: spSm),
                              Text(
                                "Google",
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
                      SizedBox(width: spSm),
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: spSm),
                          decoration: BoxDecoration(
                            border: Border.all(color: disabledColor),
                            borderRadius: BorderRadius.circular(radiusMd),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.facebook, color: infoColor, size: 24),
                              SizedBox(width: spSm),
                              Text(
                                "Facebook",
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
                    ],
                  ),
                ],
              ),
              
              SizedBox(height: spXl),
              
              // Sign Up Link
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have an account? ",
                      style: TextStyle(
                        fontSize: 16,
                        color: disabledBoldColor,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        // --
                      },
                      child: Text(
                        "Sign Up",
                        style: TextStyle(
                          fontSize: 16,
                          color: primaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _login() async {
    showLoading();
    await Future.delayed(Duration(seconds: 2));
    hideLoading();
    
    ss("Login successful");
    await offAll(FdaHomeView());
  }
}
