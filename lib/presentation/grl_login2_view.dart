import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlLogin2View extends StatefulWidget {
  const GrlLogin2View({super.key});

  @override
  State<GrlLogin2View> createState() => _GrlLogin2ViewState();
}

class _GrlLogin2ViewState extends State<GrlLogin2View> {
  String email = "";
  String password = "";
  bool isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              primaryColor,
              primaryColor.withAlpha(200),
            ],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(spMd),
            child: Column(
              children: [
                SizedBox(height: spXl),
                
                // App Logo
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    color: Colors.white.withAlpha(240),
                    shape: BoxShape.circle,
                    boxShadow: [shadowLg],
                  ),
                  child: Icon(
                    Icons.lock_person,
                    size: 50,
                    color: primaryColor,
                  ),
                ),
                
                SizedBox(height: spLg),
                
                Text(
                  "SecureLogin",
                  style: TextStyle(
                    fontSize: fsH1,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                
                Text(
                  "Your gateway to security",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white.withAlpha(220),
                  ),
                ),
                
                SizedBox(height: spXl * 2),
                
                // Login Card
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(spLg),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radius2xl),
                    boxShadow: [shadowXl],
                  ),
                  child: Column(
                    spacing: spMd,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Login",
                        style: TextStyle(
                          fontSize: fsH2,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      
                      Text(
                        "Welcome back! Please enter your details.",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),
                      
                      SizedBox(height: spSm),
                      
                      QTextField(
                        label: "Email",
                        value: email,
                        hint: "Enter your email",
                        onChanged: (value) {
                          email = value;
                          setState(() {});
                        },
                      ),
                      
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          QTextField(
                            label: "Password",
                            value: password,
                            obscureText: !isPasswordVisible,
                            hint: "••••••••",
                            onChanged: (value) {
                              password = value;
                              setState(() {});
                            },
                          ),
                          SizedBox(height: spXs),
                          GestureDetector(
                            onTap: () {
                              isPasswordVisible = !isPasswordVisible;
                              setState(() {});
                            },
                            child: Text(
                              isPasswordVisible ? "Hide Password" : "Show Password",
                              style: TextStyle(
                                color: primaryColor,
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                      
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Container(
                                width: 20,
                                height: 20,
                                decoration: BoxDecoration(
                                  border: Border.all(color: disabledOutlineBorderColor),
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: Icon(
                                  Icons.check,
                                  size: 14,
                                  color: primaryColor,
                                ),
                              ),
                              SizedBox(width: spXs),
                              Text(
                                "Remember me",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                          GestureDetector(
                            onTap: () {
                              // Navigate to forgot password
                            },
                            child: Text(
                              "Forgot password?",
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
                      
                      Container(
                        width: double.infinity,
                        child: QButton(
                          label: "Sign in",
                          size: bs.md,
                          onPressed: () {
                            // Handle login
                          },
                        ),
                      ),
                      
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(vertical: spSm),
                        decoration: BoxDecoration(
                          border: Border.all(color: disabledOutlineBorderColor),
                          borderRadius: BorderRadius.circular(radiusLg),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.g_mobiledata, size: 20, color: dangerColor),
                            SizedBox(width: spXs),
                            Text(
                              "Sign in with Google",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      
                      SizedBox(height: spSm),
                      
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
                              // Navigate to sign up
                            },
                            child: Text(
                              "Sign up",
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
                
                SizedBox(height: spMd),
                
                Text(
                  "By continuing, you agree to our Terms of Service and Privacy Policy",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.white.withAlpha(180),
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
