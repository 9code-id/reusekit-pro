import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlLogin5View extends StatefulWidget {
  const GrlLogin5View({super.key});

  @override
  State<GrlLogin5View> createState() => _GrlLogin5ViewState();
}

class _GrlLogin5ViewState extends State<GrlLogin5View> {
  String email = "";
  String password = "";
  bool biometricEnabled = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              primaryColor.withAlpha(30),
              Colors.white,
              secondaryColor.withAlpha(50),
            ],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(spMd),
            child: Column(
              children: [
                SizedBox(height: spLg),
                
                // Floating Login Card
                Container(
                  width: double.infinity,
                  margin: EdgeInsets.symmetric(horizontal: spSm),
                  padding: EdgeInsets.all(spLg),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radius3xl),
                    boxShadow: [shadowXl],
                  ),
                  child: Column(
                    children: [
                      // Logo and Title
                      Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [primaryColor, secondaryColor],
                          ),
                          shape: BoxShape.circle,
                          boxShadow: [shadowMd],
                        ),
                        child: Icon(
                          Icons.fingerprint,
                          size: 40,
                          color: Colors.white,
                        ),
                      ),
                      
                      SizedBox(height: spMd),
                      
                      Text(
                        "BiometricAuth",
                        style: TextStyle(
                          fontSize: fsH2,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      
                      Text(
                        "Secure login with advanced biometrics",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),
                      
                      SizedBox(height: spXl),
                      
                      // Biometric Login Section
                      if (biometricEnabled) ...[
                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.all(spLg),
                          decoration: BoxDecoration(
                            color: primaryColor.withAlpha(30),
                            borderRadius: BorderRadius.circular(radiusXl),
                            border: Border.all(
                              color: primaryColor.withAlpha(100),
                            ),
                          ),
                          child: Column(
                            children: [
                              Icon(
                                Icons.fingerprint,
                                size: 60,
                                color: primaryColor,
                              ),
                              SizedBox(height: spSm),
                              Text(
                                "Touch ID",
                                style: TextStyle(
                                  fontSize: fsH5,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                              Text(
                                "Place your finger on the sensor",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: disabledBoldColor,
                                ),
                              ),
                              SizedBox(height: spMd),
                              Container(
                                width: double.infinity,
                                child: QButton(
                                  label: "Authenticate with Touch ID",
                                  size: bs.md,
                                  onPressed: () {
                                    // Handle biometric authentication
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        
                        SizedBox(height: spMd),
                        
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
                        
                        SizedBox(height: spMd),
                      ],
                      
                      // Email/Password Login
                      Column(
                        spacing: spMd,
                        children: [
                          QTextField(
                            label: "Email",
                            value: email,
                            hint: "Enter your email",
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
                          
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.shield_outlined,
                                    size: 16,
                                    color: successColor,
                                  ),
                                  SizedBox(width: spXs),
                                  Text(
                                    "Secure connection",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: successColor,
                                      fontWeight: FontWeight.w500,
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
                          
                          Container(
                            width: double.infinity,
                            child: QButton(
                              label: "Sign In with Password",
                              size: bs.md,
                              onPressed: () {
                                // Handle password login
                              },
                            ),
                          ),
                        ],
                      ),
                      
                      SizedBox(height: spMd),
                      
                      // Alternative Authentication Methods
                      Text(
                        "Quick login options",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      
                      SizedBox(height: spSm),
                      
                      Row(
                        spacing: spSm,
                        children: [
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.symmetric(vertical: spSm),
                              decoration: BoxDecoration(
                                border: Border.all(color: disabledOutlineBorderColor),
                                borderRadius: BorderRadius.circular(radiusLg),
                              ),
                              child: Column(
                                children: [
                                  Icon(Icons.face, size: 24, color: primaryColor),
                                  SizedBox(height: spXxs),
                                  Text(
                                    "Face ID",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
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
                                border: Border.all(color: disabledOutlineBorderColor),
                                borderRadius: BorderRadius.circular(radiusLg),
                              ),
                              child: Column(
                                children: [
                                  Icon(Icons.qr_code_scanner, size: 24, color: primaryColor),
                                  SizedBox(height: spXxs),
                                  Text(
                                    "QR Code",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
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
                                border: Border.all(color: disabledOutlineBorderColor),
                                borderRadius: BorderRadius.circular(radiusLg),
                              ),
                              child: Column(
                                children: [
                                  Icon(Icons.sms, size: 24, color: primaryColor),
                                  SizedBox(height: spXxs),
                                  Text(
                                    "SMS",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
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
                
                SizedBox(height: spLg),
                
                // Bottom Links
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "New user? ",
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
                        "Create account",
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
                
                GestureDetector(
                  onTap: () {
                    biometricEnabled = !biometricEnabled;
                    setState(() {});
                  },
                  child: Text(
                    biometricEnabled ? "Disable biometric login" : "Enable biometric login",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                      decoration: TextDecoration.underline,
                    ),
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
