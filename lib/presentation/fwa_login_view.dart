import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class FwaLoginView extends StatefulWidget {
  const FwaLoginView({super.key});

  @override
  State<FwaLoginView> createState() => _FwaLoginViewState();
}

class _FwaLoginViewState extends State<FwaLoginView> {
  final formKey = GlobalKey<FormState>();
  String email = "";
  String password = "";
  bool rememberMe = false;
  bool obscurePassword = true;
  bool loading = false;

  Future<void> _handleLogin() async {
    if (!formKey.currentState!.validate()) {
      return;
    }

    loading = true;
    setState(() {});

    // Simulate API call
    await Future.delayed(Duration(seconds: 2));

    loading = false;
    setState(() {});

    ss("Login successful! Welcome back!");
    // navigateTo(FwaHomeView());
  }

  Future<void> _handleSocialLogin(String provider) async {
    loading = true;
    setState(() {});

    await Future.delayed(Duration(seconds: 1));

    loading = false;
    setState(() {});

    ss("$provider login successful!");
    // navigateTo(FwaHomeView());
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
                // Back Button
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        back();
                      },
                      child: Icon(
                        Icons.arrow_back,
                        color: primaryColor,
                        size: 24,
                      ),
                    ),
                    Spacer(),
                    GestureDetector(
                      onTap: () {
                        // navigateTo(FwaRegisterView());
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

                SizedBox(height: spXl),

                // Header Section
                Container(
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // App Logo
                      Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          color: primaryColor,
                          borderRadius: BorderRadius.circular(radiusLg),
                          boxShadow: [shadowMd],
                        ),
                        child: Icon(
                          Icons.fitness_center,
                          color: Colors.white,
                          size: 40,
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
                        "Sign in to continue your fitness journey",
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
                Column(
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
                            // navigateTo(FwaForgotPasswordView());
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
                    Container(
                      width: double.infinity,
                      child: loading
                          ? Container(
                              height: 50,
                              child: Center(
                                child: CircularProgressIndicator(),
                              ),
                            )
                          : QButton(
                              label: "Sign In",
                              size: bs.md,
                              onPressed: _handleLogin,
                            ),
                    ),
                  ],
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
                        "or continue with",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
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

                // Social Login Buttons
                Column(
                  spacing: spSm,
                  children: [
                    // Google Login
                    Container(
                      width: double.infinity,
                      child: GestureDetector(
                        onTap: () => _handleSocialLogin("Google"),
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: spMd),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(radiusSm),
                            border: Border.all(color: disabledOutlineBorderColor),
                            boxShadow: [shadowSm],
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
                                  color: primaryColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                    // Apple Login
                    Container(
                      width: double.infinity,
                      child: GestureDetector(
                        onTap: () => _handleSocialLogin("Apple"),
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: spMd),
                          decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(radiusSm),
                            boxShadow: [shadowSm],
                          ),
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

                    // Facebook Login
                    Container(
                      width: double.infinity,
                      child: GestureDetector(
                        onTap: () => _handleSocialLogin("Facebook"),
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: spMd),
                          decoration: BoxDecoration(
                            color: infoColor,
                            borderRadius: BorderRadius.circular(radiusSm),
                            boxShadow: [shadowSm],
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.facebook,
                                color: Colors.white,
                                size: 24,
                              ),
                              SizedBox(width: spSm),
                              Text(
                                "Continue with Facebook",
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
                        // navigateTo(FwaRegisterView());
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

                SizedBox(height: spMd),

                // Terms and Privacy
                Text(
                  "By signing in, you agree to our Terms of Service and Privacy Policy",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                    height: 1.4,
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
