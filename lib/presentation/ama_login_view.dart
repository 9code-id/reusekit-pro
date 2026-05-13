import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class AmaLoginView extends StatefulWidget {
  const AmaLoginView({super.key});

  @override
  State<AmaLoginView> createState() => _AmaLoginViewState();
}

class _AmaLoginViewState extends State<AmaLoginView> {
  final formKey = GlobalKey<FormState>();
  
  String email = "";
  String password = "";
  bool rememberMe = false;
  bool obscurePassword = true;
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: loading 
        ? Center(child: CircularProgressIndicator())
        : SingleChildScrollView(
            padding: EdgeInsets.all(spMd),
            child: Column(
              children: [
                SizedBox(height: MediaQuery.of(context).padding.top + spXl),

                // Logo and Branding
                Container(
                  padding: EdgeInsets.all(spLg),
                  decoration: BoxDecoration(
                    color: successColor.withAlpha(10),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.agriculture,
                    size: 64,
                    color: successColor,
                  ),
                ),

                SizedBox(height: spLg),

                // Welcome Text
                Text(
                  "Welcome Back",
                  style: TextStyle(
                    fontSize: fsH2,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),

                SizedBox(height: spSm),

                Text(
                  "Sign in to continue managing your farm",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: disabledBoldColor,
                  ),
                ),

                SizedBox(height: spXl),

                // Login Form
                Form(
                  key: formKey,
                  child: Column(
                    spacing: spMd,
                    children: [
                      // Email Field
                      QTextField(
                        label: "Email Address",
                        value: email,
                        hint: "Enter your email",
                        validator: Validator.email,
                        onChanged: (value) {
                          email = value;
                          setState(() {});
                        },
                      ),

                      // Password Field
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
                                rememberMe = values.isNotEmpty;
                                setState(() {});
                              },
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              _forgotPassword();
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
                            _handleLogin();
                          },
                        ),
                      ),

                      // Divider
                      Row(
                        children: [
                          Expanded(child: Divider()),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: spMd),
                            child: Text(
                              "Or continue with",
                              style: TextStyle(
                                color: disabledBoldColor,
                                fontSize: 14,
                              ),
                            ),
                          ),
                          Expanded(child: Divider()),
                        ],
                      ),

                      // Social Login Options
                      Row(
                        spacing: spMd,
                        children: [
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.symmetric(vertical: spMd),
                              decoration: BoxDecoration(
                                border: Border.all(color: disabledOutlineBorderColor),
                                borderRadius: BorderRadius.circular(radiusMd),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.g_mobiledata,
                                    color: dangerColor,
                                    size: 24,
                                  ),
                                  SizedBox(width: spSm),
                                  Text(
                                    "Google",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: primaryColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.symmetric(vertical: spMd),
                              decoration: BoxDecoration(
                                border: Border.all(color: disabledOutlineBorderColor),
                                borderRadius: BorderRadius.circular(radiusMd),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.apple,
                                    color: primaryColor,
                                    size: 24,
                                  ),
                                  SizedBox(width: spSm),
                                  Text(
                                    "Apple",
                                    style: TextStyle(
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
                ),

                SizedBox(height: spXl),

                // Demo Account Info
                Container(
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: infoColor.withAlpha(10),
                    borderRadius: BorderRadius.circular(radiusMd),
                    border: Border.all(color: infoColor.withAlpha(30)),
                  ),
                  child: Column(
                    children: [
                      Text(
                        "Demo Account",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: infoColor,
                        ),
                      ),
                      SizedBox(height: spSm),
                      Text(
                        "Email: farmer@demo.com\nPassword: demo123",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14,
                          color: infoColor,
                          fontFamily: 'monospace',
                        ),
                      ),
                      SizedBox(height: spSm),
                      GestureDetector(
                        onTap: () {
                          _useDemoAccount();
                        },
                        child: Text(
                          "Use Demo Account",
                          style: TextStyle(
                            fontSize: 14,
                            color: infoColor,
                            fontWeight: FontWeight.w600,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: spXl),

                // Sign Up Link
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have an account? ",
                      style: TextStyle(
                        color: disabledBoldColor,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        _navigateToRegister();
                      },
                      child: Text(
                        "Sign Up",
                        style: TextStyle(
                          color: primaryColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: spMd),
              ],
            ),
          ),
    );
  }

  void _handleLogin() async {
    if (formKey.currentState!.validate()) {
      loading = true;
      setState(() {});

      // Simulate API call
      await Future.delayed(Duration(seconds: 2));

      loading = false;
      setState(() {});

      // Simulate successful login
      if (email.isNotEmpty && password.isNotEmpty) {
        ss("Login successful! Welcome to AgriManage");
        // Navigate to dashboard
      } else {
        se("Invalid email or password");
      }
    }
  }

  void _forgotPassword() {
    // Navigate to forgot password
    si("Forgot password functionality");
  }

  void _useDemoAccount() {
    email = "farmer@demo.com";
    password = "demo123";
    setState(() {});
    ss("Demo account credentials filled");
  }

  void _navigateToRegister() {
    // Navigate to register page
    si("Navigate to registration");
  }
}
