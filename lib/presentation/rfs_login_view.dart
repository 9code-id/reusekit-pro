import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class RfsLoginView extends StatefulWidget {
  const RfsLoginView({super.key});

  @override
  State<RfsLoginView> createState() => _RfsLoginViewState();
}

class _RfsLoginViewState extends State<RfsLoginView> {
  final formKey = GlobalKey<FormState>();
  String email = "";
  String password = "";
  bool rememberMe = false;
  bool obscurePassword = true;
  bool loading = false;

  void _handleLogin() async {
    if (formKey.currentState!.validate()) {
      loading = true;
      setState(() {});
      
      // Simulate login API call
      await Future.delayed(Duration(seconds: 2));
      
      loading = false;
      setState(() {});
      
      ss("Login successful! Welcome back.");
      // Navigate to dashboard
      //navigateTo(RfsDashboardView());
    }
  }

  void _handleForgotPassword() {
    // Show forgot password dialog or navigate to forgot password view
    ss("Password reset link sent to your email");
  }

  void _handleSocialLogin(String provider) {
    ss("Signing in with $provider...");
    // Handle social login
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: spXl),
                
                // Logo and Branding
                Center(
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.all(spLg),
                        decoration: BoxDecoration(
                          color: primaryColor,
                          borderRadius: BorderRadius.circular(radiusLg),
                          boxShadow: [shadowLg],
                        ),
                        child: Icon(
                          Icons.restaurant,
                          color: Colors.white,
                          size: 48,
                        ),
                      ),
                      SizedBox(height: spMd),
                      Text(
                        "RestaurantFlow",
                        style: TextStyle(
                          fontSize: fsH3,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "Restaurant Management System",
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
                  "Welcome Back!",
                  style: TextStyle(
                    fontSize: fsH4,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spXs),
                Text(
                  "Sign in to access your restaurant dashboard",
                  style: TextStyle(
                    fontSize: 16,
                    color: disabledBoldColor,
                  ),
                ),
                
                SizedBox(height: spLg),
                
                // Login Form
                Column(
                  spacing: spMd,
                  children: [
                    QTextField(
                      label: "Email Address",
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
                              obscurePassword ? "Show Password" : "Hide Password",
                              style: TextStyle(
                                fontSize: 12,
                                color: primaryColor,
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
                      onTap: _handleForgotPassword,
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
                  child: loading
                      ? Center(
                          child: CircularProgressIndicator(
                            color: primaryColor,
                          ),
                        )
                      : QButton(
                          label: "Sign In",
                          size: bs.md,
                          onPressed: _handleLogin,
                        ),
                ),
                
                SizedBox(height: spLg),
                
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
                          fontWeight: FontWeight.w500,
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
                
                SizedBox(height: spLg),
                
                // Social Login Options
                Column(
                  spacing: spSm,
                  children: [
                    Container(
                      width: double.infinity,
                      child: OutlinedButton(
                        onPressed: () => _handleSocialLogin("Google"),
                        style: OutlinedButton.styleFrom(
                          padding: EdgeInsets.all(spMd),
                          side: BorderSide(color: disabledColor),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(radiusMd),
                          ),
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
                              "Continue with Google",
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
                    
                    Container(
                      width: double.infinity,
                      child: OutlinedButton(
                        onPressed: () => _handleSocialLogin("Apple"),
                        style: OutlinedButton.styleFrom(
                          padding: EdgeInsets.all(spMd),
                          side: BorderSide(color: disabledColor),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(radiusMd),
                          ),
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
                              "Continue with Apple",
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
                  ],
                ),
                
                SizedBox(height: spXl),
                
                // Sign Up Option
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
                        // Navigate to registration
                        //navigateTo(RfsRegisterView());
                      },
                      child: Text(
                        "Sign Up",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: primaryColor,
                        ),
                      ),
                    ),
                  ],
                ),
                
                SizedBox(height: spMd),
                
                // Demo Access
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: infoColor.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusMd),
                    border: Border.all(
                      color: infoColor.withAlpha(30),
                      width: 1,
                    ),
                  ),
                  child: Column(
                    children: [
                      Icon(
                        Icons.info,
                        color: infoColor,
                        size: 20,
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "Demo Access",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: infoColor,
                        ),
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "Email: demo@restaurant.com\nPassword: demo123",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
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
}
