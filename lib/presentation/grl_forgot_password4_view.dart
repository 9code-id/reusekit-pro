import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlForgotPassword4View extends StatefulWidget {
  @override
  State<GrlForgotPassword4View> createState() => _GrlForgotPassword4ViewState();
}

class _GrlForgotPassword4ViewState extends State<GrlForgotPassword4View> {
  final formKey = GlobalKey<FormState>();
  String verificationCode = "";
  String newPassword = "";
  String confirmPassword = "";
  bool obscureNewPassword = true;
  bool obscureConfirmPassword = true;
  bool loading = false;
  int step = 1; // 1: verification, 2: new password

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(step == 1 ? "Verify Code" : "Reset Password"),
      ),
      body: loading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: EdgeInsets.all(spMd),
              child: Form(
                key: formKey,
                child: Column(
                  spacing: spMd,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: spMd),
                    
                    // Progress Indicator
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            height: 4,
                            decoration: BoxDecoration(
                              color: primaryColor,
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                          ),
                        ),
                        SizedBox(width: spXs),
                        Expanded(
                          child: Container(
                            height: 4,
                            decoration: BoxDecoration(
                              color: step == 2 ? primaryColor : disabledColor,
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                          ),
                        ),
                      ],
                    ),
                    
                    SizedBox(height: spLg),
                    
                    if (step == 1) ...[
                      // Step 1: Verification Code
                      
                      // Header
                      Center(
                        child: Column(
                          spacing: spSm,
                          children: [
                            Container(
                              width: 80,
                              height: 80,
                              decoration: BoxDecoration(
                                color: successColor.withAlpha(10),
                                borderRadius: BorderRadius.circular(radiusLg),
                              ),
                              child: Icon(
                                Icons.mark_email_unread,
                                size: 40,
                                color: successColor,
                              ),
                            ),
                            Text(
                              "Check Your Email",
                              style: TextStyle(
                                fontSize: fsH3,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              "We've sent a 6-digit verification code to your email address. Please enter the code below.",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 14,
                                color: disabledBoldColor,
                                height: 1.4,
                              ),
                            ),
                          ],
                        ),
                      ),
                      
                      SizedBox(height: sp2xl),
                      
                      // Verification Code Input
                      QTextField(
                        label: "Verification Code",
                        value: verificationCode,
                        hint: "Enter 6-digit code",
                        validator: Validator.required,
                        onChanged: (value) {
                          verificationCode = value;
                          setState(() {});
                        },
                      ),
                      
                      SizedBox(height: spMd),
                      
                      // Resend Code
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Didn't receive the code?",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              ss("Verification code resent!");
                            },
                            child: Text(
                              "Resend",
                              style: TextStyle(
                                fontSize: 14,
                                color: primaryColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                      
                      SizedBox(height: spXl),
                      
                      // Verify Button
                      Container(
                        width: double.infinity,
                        child: QButton(
                          label: "Verify Code",
                          size: bs.md,
                          onPressed: () async {
                            if (formKey.currentState!.validate()) {
                              loading = true;
                              setState(() {});
                              
                              // Simulate verification
                              await Future.delayed(Duration(seconds: 2));
                              
                              loading = false;
                              step = 2;
                              setState(() {});
                              
                              ss("Code verified successfully!");
                            }
                          },
                        ),
                      ),
                    ] else ...[
                      // Step 2: New Password
                      
                      // Header
                      Center(
                        child: Column(
                          spacing: spSm,
                          children: [
                            Container(
                              width: 80,
                              height: 80,
                              decoration: BoxDecoration(
                                color: primaryColor.withAlpha(10),
                                borderRadius: BorderRadius.circular(radiusLg),
                              ),
                              child: Icon(
                                Icons.lock_reset,
                                size: 40,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              "Create New Password",
                              style: TextStyle(
                                fontSize: fsH3,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              "Your identity has been verified. Set your new password below.",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 14,
                                color: disabledBoldColor,
                                height: 1.4,
                              ),
                            ),
                          ],
                        ),
                      ),
                      
                      SizedBox(height: sp2xl),
                      
                      // New Password
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          QTextField(
                            label: "New Password",
                            value: newPassword,
                            obscureText: obscureNewPassword,
                            hint: "Enter new password",
                            validator: Validator.required,
                            onChanged: (value) {
                              newPassword = value;
                              setState(() {});
                            },
                          ),
                          SizedBox(height: spXs),
                          Align(
                            alignment: Alignment.centerRight,
                            child: GestureDetector(
                              onTap: () {
                                obscureNewPassword = !obscureNewPassword;
                                setState(() {});
                              },
                              child: Text(
                                obscureNewPassword ? "Show" : "Hide",
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
                      
                      // Confirm Password
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          QTextField(
                            label: "Confirm Password",
                            value: confirmPassword,
                            obscureText: obscureConfirmPassword,
                            hint: "Confirm new password",
                            validator: Validator.required,
                            onChanged: (value) {
                              confirmPassword = value;
                              setState(() {});
                            },
                          ),
                          SizedBox(height: spXs),
                          Align(
                            alignment: Alignment.centerRight,
                            child: GestureDetector(
                              onTap: () {
                                obscureConfirmPassword = !obscureConfirmPassword;
                                setState(() {});
                              },
                              child: Text(
                                obscureConfirmPassword ? "Show" : "Hide",
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
                      
                      // Password Requirements
                      Container(
                        padding: EdgeInsets.all(spMd),
                        decoration: BoxDecoration(
                          color: infoColor.withAlpha(5),
                          borderRadius: BorderRadius.circular(radiusLg),
                          border: Border.all(
                            color: infoColor.withAlpha(20),
                            width: 1,
                          ),
                        ),
                        child: Column(
                          spacing: spSm,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Password Requirements:",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: infoColor,
                              ),
                            ),
                            Text(
                              "• At least 8 characters long\n• Contains uppercase and lowercase letters\n• Contains at least one number\n• Contains at least one special character",
                              style: TextStyle(
                                fontSize: 11,
                                color: disabledBoldColor,
                                height: 1.4,
                              ),
                            ),
                          ],
                        ),
                      ),
                      
                      SizedBox(height: spXl),
                      
                      // Reset Password Button
                      Container(
                        width: double.infinity,
                        child: QButton(
                          label: "Reset Password",
                          size: bs.md,
                          onPressed: () async {
                            if (formKey.currentState!.validate()) {
                              if (newPassword != confirmPassword) {
                                se("Passwords do not match!");
                                return;
                              }
                              
                              loading = true;
                              setState(() {});
                              
                              // Simulate password reset
                              await Future.delayed(Duration(seconds: 2));
                              
                              loading = false;
                              setState(() {});
                              
                              ss("Password reset successfully!");
                              // navigateTo(LoginView());
                            }
                          },
                        ),
                      ),
                    ],
                    
                    SizedBox(height: spMd),
                    
                    // Back to Login
                    Center(
                      child: GestureDetector(
                        onTap: () {
                          back();
                        },
                        child: Text(
                          "Back to Login",
                          style: TextStyle(
                            fontSize: 14,
                            color: primaryColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
