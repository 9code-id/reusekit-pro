import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class ComaLoginView extends StatefulWidget {
  const ComaLoginView({super.key});

  @override
  State<ComaLoginView> createState() => _ComaLoginViewState();
}

class _ComaLoginViewState extends State<ComaLoginView> {
  final formKey = GlobalKey<FormState>();
  String email = "";
  String password = "";
  bool obscurePassword = true;
  bool rememberMe = false;
  bool isLoading = false;

  void _togglePasswordVisibility() {
    obscurePassword = !obscurePassword;
    setState(() {});
  }

  void _login() async {
    if (formKey.currentState!.validate()) {
      isLoading = true;
      setState(() {});
      
      // Simulate login process
      await Future.delayed(Duration(seconds: 2));
      
      isLoading = false;
      setState(() {});
      
      // Navigate to main app
      ss("Login successful! Welcome to COMA.");
      // ss('Next page'));
    }
  }

  void _loginWithGoogle() {
    ss("Google login functionality will be implemented");
  }

  void _loginWithApple() {
    ss("Apple login functionality will be implemented");
  }

  void _forgotPassword() {
    // Navigate to forgot password
    ss("Forgot password functionality will be implemented");
  }

  void _register() {
    // Navigate to registration
    ss("Registration functionality will be implemented");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              primaryColor.withAlpha(240),
              primaryColor,
              secondaryColor.withAlpha(200),
            ],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(spLg),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  SizedBox(height: spXl),
                  
                  // Logo and welcome text
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withAlpha(20),
                          blurRadius: 20,
                          offset: Offset(0, 10),
                        ),
                      ],
                    ),
                    child: Icon(
                      Icons.medical_services,
                      size: 50,
                      color: primaryColor,
                    ),
                  ),
                  
                  SizedBox(height: spLg),
                  
                  Text(
                    "Welcome Back",
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "Sign in to continue with COMA",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white.withAlpha(180),
                    ),
                  ),
                  
                  SizedBox(height: spXl),
                  
                  // Login form
                  Container(
                    padding: EdgeInsets.all(spLg),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusLg),
                      boxShadow: [shadowMd],
                    ),
                    child: Column(
                      spacing: spMd,
                      children: [
                        // Email field
                        QTextField(
                          label: "Email Address",
                          value: email,
                          validator: Validator.email,
                          onChanged: (value) {
                            email = value;
                            setState(() {});
                          },
                        ),
                        
                        // Password field with visibility toggle
                        Column(
                          spacing: spXs,
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
                            Align(
                              alignment: Alignment.centerRight,
                              child: GestureDetector(
                                onTap: _togglePasswordVisibility,
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
                        
                        // Remember me and forgot password
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
                              onTap: _forgotPassword,
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
                        
                        // Login button
                        Container(
                          width: double.infinity,
                          child: isLoading
                              ? Container(
                                  height: 48,
                                  child: Center(
                                    child: CircularProgressIndicator(
                                      valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
                                    ),
                                  ),
                                )
                              : QButton(
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
                      Expanded(
                        child: Container(
                          height: 1,
                          color: Colors.white.withAlpha(50),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: spMd),
                        child: Text(
                          "OR",
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.white.withAlpha(180),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          height: 1,
                          color: Colors.white.withAlpha(50),
                        ),
                      ),
                    ],
                  ),
                  
                  SizedBox(height: spLg),
                  
                  // Social login buttons
                  Column(
                    spacing: spMd,
                    children: [
                      Container(
                        width: double.infinity,
                        child: QButton(
                          label: "Continue with Google",
                          icon: Icons.g_mobiledata,
                          size: bs.md,
                          onPressed: _loginWithGoogle,
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        child: QButton(
                          label: "Continue with Apple",
                          icon: Icons.apple,
                          size: bs.md,
                          onPressed: _loginWithApple,
                        ),
                      ),
                    ],
                  ),
                  
                  SizedBox(height: spXl),
                  
                  // Sign up link
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don't have an account? ",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white.withAlpha(180),
                        ),
                      ),
                      GestureDetector(
                        onTap: _register,
                        child: Text(
                          "Sign Up",
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  
                  SizedBox(height: spLg),
                  
                  // Medical emergency notice
                  Container(
                    padding: EdgeInsets.all(spMd),
                    decoration: BoxDecoration(
                      color: dangerColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusMd),
                      border: Border.all(
                        color: dangerColor.withAlpha(50),
                      ),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.emergency,
                          color: dangerColor,
                          size: 20,
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Medical Emergency?",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: dangerColor,
                                ),
                              ),
                              Text(
                                "Call emergency services immediately",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: dangerColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  
                  SizedBox(height: spMd),
                  
                  // Footer
                  Text(
                    "By signing in, you agree to our Terms of Service and Privacy Policy",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.white.withAlpha(120),
                    ),
                  ),
                  
                  SizedBox(height: spSm),
                  
                  Text(
                    "COMA v1.0.0 - AI Medical Assistant",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.white.withAlpha(100),
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
}
