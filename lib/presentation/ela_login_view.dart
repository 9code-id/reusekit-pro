import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class ElaLoginView extends StatefulWidget {
  const ElaLoginView({super.key});

  @override
  State<ElaLoginView> createState() => _ElaLoginViewState();
}

class _ElaLoginViewState extends State<ElaLoginView> {
  final formKey = GlobalKey<FormState>();
  String email = "";
  String password = "";
  bool obscurePassword = true;
  bool rememberMe = false;

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
              SizedBox(height: spXl * 2),
              // Header Section
              Center(
                child: Column(
                  children: [
                    Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        color: primaryColor.withAlpha(20),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.school,
                        size: 40,
                        color: primaryColor,
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
                      "Sign in to continue your learning journey",
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

              // Login Form
              Text(
                "Login",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              SizedBox(height: spMd),
              
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
                      // navigateTo(ElaForgotPasswordView())
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
                    _handleLogin();
                  },
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
                      color: disabledOutlineBorderColor,
                    ),
                  ),
                ],
              ),
              SizedBox(height: spLg),

              // Social Login Options
              Container(
                width: double.infinity,
                child: QButton(
                  label: "Continue with Google",
                  icon: Icons.g_mobiledata,
                  color: dangerColor,
                  size: bs.md,
                  onPressed: () {
                    _handleGoogleLogin();
                  },
                ),
              ),
              SizedBox(height: spMd),
              
              Container(
                width: double.infinity,
                child: QButton(
                  label: "Continue with Microsoft",
                  icon: Icons.business,
                  color: infoColor,
                  size: bs.md,
                  onPressed: () {
                    _handleMicrosoftLogin();
                  },
                ),
              ),
              SizedBox(height: spXl),

              // Register Link
              Center(
                child: Column(
                  children: [
                    Text(
                      "Don't have an account?",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    GestureDetector(
                      onTap: () {
                        // navigateTo(ElaRegisterView())
                      },
                      child: Text(
                        "Create Account",
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
              SizedBox(height: spLg),
            ],
          ),
        ),
      ),
    );
  }

  void _handleLogin() async {
    if (formKey.currentState!.validate()) {
      showLoading();
      await Future.delayed(Duration(seconds: 2));
      hideLoading();
      
      // navigateTo(ElaRoleSelectionView())
      ss("Login successful");
    }
  }

  void _handleGoogleLogin() async {
    showLoading();
    await Future.delayed(Duration(seconds: 2));
    hideLoading();
    
    // navigateTo(ElaRoleSelectionView())
    ss("Google login successful");
  }

  void _handleMicrosoftLogin() async {
    showLoading();
    await Future.delayed(Duration(seconds: 2));
    hideLoading();
    
    // navigateTo(ElaRoleSelectionView())
    ss("Microsoft login successful");
  }
}
