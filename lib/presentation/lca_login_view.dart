import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class LcaLoginView extends StatefulWidget {
  const LcaLoginView({super.key});

  @override
  State<LcaLoginView> createState() => _LcaLoginViewState();
}

class _LcaLoginViewState extends State<LcaLoginView> {
  final formKey = GlobalKey<FormState>();
  String email = "";
  String password = "";
  bool rememberMe = false;
  bool obscurePassword = true;
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              primaryColor.withAlpha(25),
              Colors.white,
              Colors.white,
            ],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(spMd),
            child: Column(
              children: [
                SizedBox(height: spLg),
                
                // Logo and App Name
                Column(
                  children: [
                    Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        color: primaryColor,
                        borderRadius: BorderRadius.circular(radius2xl),
                        boxShadow: [shadowMd],
                      ),
                      child: Icon(
                        Icons.savings,
                        size: 40,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: spMd),
                    Text(
                      "LCA",
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                        letterSpacing: 2,
                      ),
                    ),
                    Text(
                      "Life Credit Assistant",
                      style: TextStyle(
                        fontSize: 16,
                        color: disabledBoldColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                
                SizedBox(height: spXl),
                
                // Welcome Text
                Column(
                  children: [
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
                      "Sign in to continue managing your finances",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
                
                SizedBox(height: sp2xl),
                
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
                                  fontSize: 14,
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
                            child: Row(
                              children: [
                                Checkbox(
                                  value: rememberMe,
                                  onChanged: (value) {
                                    rememberMe = value ?? false;
                                    setState(() {});
                                  },
                                  activeColor: primaryColor,
                                ),
                                Text(
                                  "Remember me",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              _showForgotPasswordDialog();
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
                    ],
                  ),
                ),
                
                SizedBox(height: sp2xl),
                
                // Login Button
                if (loading)
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(spMd),
                    child: Center(
                      child: CircularProgressIndicator(color: primaryColor),
                    ),
                  )
                else
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
                    Expanded(child: Divider(color: disabledColor)),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: spSm),
                      child: Text(
                        "or continue with",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),
                    ),
                    Expanded(child: Divider(color: disabledColor)),
                  ],
                ),
                
                SizedBox(height: spLg),
                
                // Social Login Buttons
                Row(
                  spacing: spSm,
                  children: [
                    Expanded(
                      child: _buildSocialLoginButton(
                        "Google",
                        Icons.login,
                        Colors.red,
                        () {
                          si("Google login integration");
                        },
                      ),
                    ),
                    Expanded(
                      child: _buildSocialLoginButton(
                        "Apple",
                        Icons.apple,
                        Colors.black,
                        () {
                          si("Apple login integration");
                        },
                      ),
                    ),
                  ],
                ),
                
                SizedBox(height: spLg),
                
                // Biometric Login Option
                Container(
                  width: double.infinity,
                  child: QButton(
                    label: "Use Biometric Login",
                    icon: Icons.fingerprint,
                    color: infoColor,
                    size: bs.md,
                    onPressed: () {
                      _handleBiometricLogin();
                    },
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
                        fontSize: 16,
                        color: disabledBoldColor,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        //navigateTo(LcaRegisterView());
                      },
                      child: Text(
                        "Sign Up",
                        style: TextStyle(
                          fontSize: 16,
                          color: primaryColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                
                SizedBox(height: spLg),
                
                // Security Notice
                Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: successColor.withAlpha(25),
                    borderRadius: BorderRadius.circular(radiusSm),
                    border: Border.all(color: successColor.withAlpha(80)),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.security, color: successColor, size: 16),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Text(
                          "Your data is protected with bank-level encryption",
                          style: TextStyle(
                            fontSize: 12,
                            color: successColor,
                            fontWeight: FontWeight.w500,
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
      ),
    );
  }

  Widget _buildSocialLoginButton(String label, IconData icon, Color color, VoidCallback onPressed) {
    return Container(
      child: QButton(
        label: label,
        icon: icon,
        color: color,
        size: bs.md,
        onPressed: onPressed,
      ),
    );
  }

  void _handleLogin() {
    if (formKey.currentState!.validate()) {
      loading = true;
      setState(() {});
      
      // Simulate login process
      Future.delayed(Duration(seconds: 2), () {
        loading = false;
        setState(() {});
        
        if (email.isNotEmpty && password.isNotEmpty) {
          ss("Login successful! Welcome back.");
          // Navigate to main app
          //navigateTo(MainDashboardView());
        } else {
          se("Invalid credentials. Please try again.");
        }
      });
    }
  }

  void _handleBiometricLogin() {
    loading = true;
    setState(() {});
    
    Future.delayed(Duration(seconds: 1), () {
      loading = false;
      setState(() {});
      ss("Biometric authentication successful");
      // Navigate to main app
      //navigateTo(MainDashboardView());
    });
  }

  void _showForgotPasswordDialog() {
    String resetEmail = "";
    
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Reset Password"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Enter your email address and we'll send you instructions to reset your password.",
                style: TextStyle(fontSize: 14, color: disabledBoldColor),
              ),
              SizedBox(height: spMd),
              QTextField(
                label: "Email Address",
                value: resetEmail,
                onChanged: (value) {
                  resetEmail = value;
                },
              ),
            ],
          ),
          actions: [
            QButton(
              label: "Cancel",
              color: disabledBoldColor,
              size: bs.sm,
              onPressed: () {
                back();
              },
            ),
            QButton(
              label: "Send Reset Link",
              size: bs.sm,
              onPressed: () {
                back();
                si("Password reset instructions sent to $resetEmail");
              },
            ),
          ],
        );
      },
    );
  }
}
