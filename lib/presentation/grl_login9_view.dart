import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlLogin9View extends StatefulWidget {
  const GrlLogin9View({super.key});

  @override
  State<GrlLogin9View> createState() => _GrlLogin9ViewState();
}

class _GrlLogin9ViewState extends State<GrlLogin9View> {
  String email = "";
  String password = "";
  bool acceptTerms = false;
  bool enableNotifications = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.white,
              primaryColor.withAlpha(20),
              secondaryColor.withAlpha(30),
            ],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(spMd),
            child: Column(
              children: [
                SizedBox(height: spMd),
                
                // Animated Header
                Column(
                  children: [
                    Stack(
                      children: [
                        Container(
                          width: 140,
                          height: 140,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                primaryColor.withAlpha(50),
                                secondaryColor.withAlpha(50),
                              ],
                            ),
                            shape: BoxShape.circle,
                          ),
                        ),
                        Positioned(
                          top: 20,
                          left: 20,
                          child: Container(
                            width: 100,
                            height: 100,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [primaryColor, secondaryColor],
                              ),
                              shape: BoxShape.circle,
                              boxShadow: [shadowLg],
                            ),
                            child: Icon(
                              Icons.rocket_launch,
                              size: 50,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                    
                    SizedBox(height: spMd),
                    
                    Text(
                      "LaunchPad",
                      style: TextStyle(
                        fontSize: fsH1,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    
                    Text(
                      "Your gateway to innovation",
                      style: TextStyle(
                        fontSize: 16,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
                
                SizedBox(height: spXl),
                
                // Modern Login Card
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(spLg),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radius3xl),
                    boxShadow: [shadowXl],
                  ),
                  child: Column(
                    spacing: spMd,
                    children: [
                      Text(
                        "Welcome Back!",
                        style: TextStyle(
                          fontSize: fsH2,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      
                      Text(
                        "Sign in to continue your journey",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),
                      
                      SizedBox(height: spSm),
                      
                      // Social Login Buttons First
                      Column(
                        spacing: spSm,
                        children: [
                          Container(
                            width: double.infinity,
                            padding: EdgeInsets.symmetric(vertical: spSm),
                            decoration: BoxDecoration(
                              color: dangerColor,
                              borderRadius: BorderRadius.circular(radiusLg),
                              boxShadow: [shadowSm],
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.g_mobiledata, size: 24, color: Colors.white),
                                SizedBox(width: spXs),
                                Text(
                                  "Continue with Google",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          
                          Row(
                            spacing: spSm,
                            children: [
                              Expanded(
                                child: Container(
                                  padding: EdgeInsets.symmetric(vertical: spSm),
                                  decoration: BoxDecoration(
                                    color: infoColor,
                                    borderRadius: BorderRadius.circular(radiusLg),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(Icons.facebook, size: 20, color: Colors.white),
                                      SizedBox(width: spXs),
                                      Text(
                                        "Facebook",
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  padding: EdgeInsets.symmetric(vertical: spSm),
                                  decoration: BoxDecoration(
                                    color: primaryColor,
                                    borderRadius: BorderRadius.circular(radiusLg),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(Icons.apple, size: 20, color: Colors.white),
                                      SizedBox(width: spXs),
                                      Text(
                                        "Apple",
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.white,
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
                      
                      Row(
                        children: [
                          Expanded(child: Divider(color: disabledOutlineBorderColor)),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: spSm),
                            child: Text(
                              "or",
                              style: TextStyle(
                                color: disabledBoldColor,
                                fontSize: 14,
                              ),
                            ),
                          ),
                          Expanded(child: Divider(color: disabledOutlineBorderColor)),
                        ],
                      ),
                      
                      // Email/Password Form
                      QTextField(
                        label: "Email",
                        value: email,
                        hint: "your.email@example.com",
                        onChanged: (value) {
                          email = value;
                          setState(() {});
                        },
                      ),
                      
                      QTextField(
                        label: "Password",
                        value: password,
                        obscureText: true,
                        hint: "Enter your password",
                        onChanged: (value) {
                          password = value;
                          setState(() {});
                        },
                      ),
                      
                      // Advanced Options
                      Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: primaryColor.withAlpha(30),
                          borderRadius: BorderRadius.circular(radiusLg),
                        ),
                        child: Column(
                          spacing: spXs,
                          children: [
                            Row(
                              children: [
                                Container(
                                  width: 20,
                                  height: 20,
                                  decoration: BoxDecoration(
                                    color: acceptTerms ? primaryColor : Colors.transparent,
                                    border: Border.all(
                                      color: acceptTerms ? primaryColor : disabledOutlineBorderColor,
                                    ),
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                  child: acceptTerms
                                    ? Icon(Icons.check, size: 14, color: Colors.white)
                                    : null,
                                ),
                                SizedBox(width: spXs),
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () {
                                      acceptTerms = !acceptTerms;
                                      setState(() {});
                                    },
                                    child: Text(
                                      "I accept the Terms & Conditions and Privacy Policy",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            
                            Row(
                              children: [
                                Container(
                                  width: 20,
                                  height: 20,
                                  decoration: BoxDecoration(
                                    color: enableNotifications ? primaryColor : Colors.transparent,
                                    border: Border.all(
                                      color: enableNotifications ? primaryColor : disabledOutlineBorderColor,
                                    ),
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                  child: enableNotifications
                                    ? Icon(Icons.check, size: 14, color: Colors.white)
                                    : null,
                                ),
                                SizedBox(width: spXs),
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () {
                                      enableNotifications = !enableNotifications;
                                      setState(() {});
                                    },
                                    child: Text(
                                      "Enable push notifications for updates",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      
                      Container(
                        width: double.infinity,
                        child: QButton(
                          label: "Launch Experience",
                          size: bs.md,
                          onPressed: () {
                            // Handle login
                          },
                        ),
                      ),
                      
                      GestureDetector(
                        onTap: () {
                          // Navigate to forgot password
                        },
                        child: Text(
                          "Forgot your password?",
                          style: TextStyle(
                            fontSize: 14,
                            color: primaryColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                
                SizedBox(height: spLg),
                
                // Feature Highlights
                Container(
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: secondaryColor.withAlpha(50),
                    borderRadius: BorderRadius.circular(radiusLg),
                  ),
                  child: Column(
                    children: [
                      Text(
                        "Why choose LaunchPad?",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: secondaryColor,
                        ),
                      ),
                      
                      SizedBox(height: spSm),
                      
                      Row(
                        spacing: spMd,
                        children: [
                          Expanded(
                            child: Column(
                              children: [
                                Icon(Icons.speed, size: 30, color: secondaryColor),
                                SizedBox(height: spXs),
                                Text(
                                  "Lightning Fast",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: secondaryColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              children: [
                                Icon(Icons.security, size: 30, color: secondaryColor),
                                SizedBox(height: spXs),
                                Text(
                                  "Secure",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: secondaryColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              children: [
                                Icon(Icons.cloud_sync, size: 30, color: secondaryColor),
                                SizedBox(height: spXs),
                                Text(
                                  "Cloud Sync",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: secondaryColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                
                SizedBox(height: spMd),
                
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
                        // Navigate to sign up
                      },
                      child: Text(
                        "Join LaunchPad",
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
        ),
      ),
    );
  }
}
