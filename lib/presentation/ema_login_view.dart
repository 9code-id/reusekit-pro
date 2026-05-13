import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class EmaLoginView extends StatefulWidget {
  const EmaLoginView({super.key});

  @override
  State<EmaLoginView> createState() => _EmaLoginViewState();
}

class _EmaLoginViewState extends State<EmaLoginView> {
  final formKey = GlobalKey<FormState>();
  String email = "";
  String password = "";
  bool rememberMe = false;
  bool isLoading = false;
  bool obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header Section
              SizedBox(height: sp2xl),
              Center(
                child: Column(
                  children: [
                    // App Logo
                    Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [primaryColor, primaryColor.withAlpha(180)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(radius2xl),
                        boxShadow: [shadowMd],
                      ),
                      child: Icon(
                        Icons.email,
                        size: 40,
                        color: Colors.white,
                      ),
                    ),
                    
                    SizedBox(height: spLg),
                    
                    // Welcome Text
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
                      "Sign in to manage your emails efficiently",
                      style: TextStyle(
                        fontSize: 16,
                        color: disabledBoldColor,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              
              SizedBox(height: sp2xl),
              
              // Login Form
              Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Email Field
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
                    
                    SizedBox(height: spMd),
                    
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
                        SizedBox(height: spSm),
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
                              rememberMe = values.isNotEmpty;
                              setState(() {});
                            },
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            ss("Navigate to forgot password");
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
                    
                    SizedBox(height: sp2xl),
                    
                    // Login Button
                    Container(
                      width: double.infinity,
                      child: QButton(
                        label: "Sign In",
                        size: bs.md,
                        onPressed: isLoading ? null : _handleLogin,
                      ),
                    ),
                    
                    SizedBox(height: spLg),
                    
                    // Divider
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            height: 1,
                            color: disabledOutlineBorderColor,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: spMd),
                          child: Text(
                            "Or continue with",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            height: 1,
                            color: disabledOutlineBorderColor,
                          ),
                        ),
                      ],
                    ),
                    
                    SizedBox(height: spLg),
                    
                    // Social Login Buttons
                    Row(
                      children: [
                        Expanded(
                          child: _buildSocialButton(
                            "Google",
                            Icons.g_mobiledata,
                            () => _handleSocialLogin("Google"),
                          ),
                        ),
                        SizedBox(width: spMd),
                        Expanded(
                          child: _buildSocialButton(
                            "Microsoft",
                            Icons.business,
                            () => _handleSocialLogin("Microsoft"),
                          ),
                        ),
                      ],
                    ),
                    
                    SizedBox(height: spMd),
                    
                    // Apple Login (Full Width)
                    Container(
                      width: double.infinity,
                      child: _buildSocialButton(
                        "Continue with Apple",
                        Icons.apple,
                        () => _handleSocialLogin("Apple"),
                        isFullWidth: true,
                      ),
                    ),
                  ],
                ),
              ),
              
              SizedBox(height: sp2xl),
              
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
                      ss("Navigate to register screen");
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
              
              SizedBox(height: spLg),
              
              // App Info
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: infoColor.withAlpha(25),
                  borderRadius: BorderRadius.circular(radiusMd),
                  border: Border.all(color: infoColor.withAlpha(100)),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.info,
                      color: infoColor,
                      size: 20,
                    ),
                    SizedBox(width: spMd),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Secure Login",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: infoColor,
                            ),
                          ),
                          Text(
                            "Your login is protected with enterprise-grade security",
                            style: TextStyle(
                              fontSize: 12,
                              color: infoColor,
                            ),
                          ),
                        ],
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
  
  Widget _buildSocialButton(String label, IconData icon, VoidCallback onPressed, {bool isFullWidth = false}) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: spMd, horizontal: spMd),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(radiusMd),
          border: Border.all(color: disabledOutlineBorderColor),
          boxShadow: [shadowSm],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: primaryColor,
              size: 20,
            ),
            if (isFullWidth) ...[
              SizedBox(width: spMd),
              Text(
                label,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: primaryColor,
                ),
              ),
            ] else if (label != "Google" && label != "Microsoft") ...[
              SizedBox(width: spSm),
              Expanded(
                child: Text(
                  label,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
  
  void _handleLogin() async {
    if (!formKey.currentState!.validate()) return;
    
    isLoading = true;
    setState(() {});
    
    // Simulate login process
    await Future.delayed(Duration(seconds: 2));
    
    isLoading = false;
    setState(() {});
    
    ss("Login successful! Welcome back.");
  }
  
  void _handleSocialLogin(String provider) {
    ss("Signing in with $provider");
  }
}
