import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class ImaLoginView extends StatefulWidget {
  const ImaLoginView({super.key});

  @override
  State<ImaLoginView> createState() => _ImaLoginViewState();
}

class _ImaLoginViewState extends State<ImaLoginView> {
  final formKey = GlobalKey<FormState>();
  
  String email = "";
  String password = "";
  bool rememberMe = false;
  bool obscurePassword = true;
  bool loading = false;

  void _login() async {
    if (formKey.currentState!.validate()) {
      loading = true;
      setState(() {});
      
      // Simulate login process
      await Future.delayed(Duration(seconds: 2));
      
      loading = false;
      setState(() {});
      
      ss("Login successful! Welcome back.");
      // Navigate to main app
    }
  }

  void _loginWithGoogle() async {
    loading = true;
    setState(() {});
    
    await Future.delayed(Duration(seconds: 1));
    
    loading = false;
    setState(() {});
    
    ss("Google login successful!");
    // Navigate to main app
  }

  void _loginWithApple() async {
    loading = true;
    setState(() {});
    
    await Future.delayed(Duration(seconds: 1));
    
    loading = false;
    setState(() {});
    
    ss("Apple login successful!");
    // Navigate to main app
  }

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(
                color: primaryColor,
              ),
              SizedBox(height: spSm),
              Text(
                "Signing you in...",
                style: TextStyle(
                  fontSize: 16,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              primaryColor.withAlpha(30),
              Colors.white,
            ],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(spMd),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: spXl),
                
                // Logo and title
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
                          Icons.photo_camera,
                          size: 40,
                          color: Colors.white,
                        ),
                      ),
                      
                      SizedBox(height: spMd),
                      
                      Text(
                        "Welcome Back",
                        style: TextStyle(
                          fontSize: fsH1,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      
                      SizedBox(height: spXs),
                      
                      Text(
                        "Sign in to your ImageMaster account",
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

                // Login form
                Form(
                  key: formKey,
                  child: Column(
                    spacing: spSm,
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
                                rememberMe = values.isNotEmpty;
                                setState(() {});
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

                      SizedBox(height: spMd),

                      Container(
                        width: double.infinity,
                        child: QButton(
                          label: "Sign In",
                          size: bs.md,
                          onPressed: _login,
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: spLg),

                // Divider
                Row(
                  children: [
                    Expanded(child: Divider()),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: spSm),
                      child: Text(
                        "Or continue with",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),
                    ),
                    Expanded(child: Divider()),
                  ],
                ),

                SizedBox(height: spLg),

                // Social login buttons
                Column(
                  spacing: spSm,
                  children: [
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(vertical: spSm),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(radiusMd),
                        border: Border.all(color: disabledOutlineBorderColor),
                        boxShadow: [shadowSm],
                      ),
                      child: InkWell(
                        onTap: _loginWithGoogle,
                        borderRadius: BorderRadius.circular(radiusMd),
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: spSm),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.g_mobiledata,
                                color: Colors.red,
                                size: 24,
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
                      ),
                    ),

                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(vertical: spSm),
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(radiusMd),
                        boxShadow: [shadowSm],
                      ),
                      child: InkWell(
                        onTap: _loginWithApple,
                        borderRadius: BorderRadius.circular(radiusMd),
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: spSm),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.apple,
                                color: Colors.white,
                                size: 24,
                              ),
                              SizedBox(width: spSm),
                              Text(
                                "Continue with Apple",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: spXl),

                // Sign up link
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
                          // Navigate to register
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

                // Bottom disclaimer
                Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: primaryColor.withAlpha(30),
                    borderRadius: BorderRadius.circular(radiusMd),
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.security,
                            color: primaryColor,
                            size: 20,
                          ),
                          SizedBox(width: spSm),
                          Expanded(
                            child: Text(
                              "Your account is secured with enterprise-grade encryption",
                              style: TextStyle(
                                fontSize: 12,
                                color: primaryColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                      
                      SizedBox(height: spXs),
                      
                      Text(
                        "By signing in, you agree to our Terms of Service and Privacy Policy",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 11,
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
