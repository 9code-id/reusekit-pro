import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class DlaForgotPasswordView extends StatefulWidget {
  const DlaForgotPasswordView({super.key});

  @override
  State<DlaForgotPasswordView> createState() => _DlaForgotPasswordViewState();
}

class _DlaForgotPasswordViewState extends State<DlaForgotPasswordView> {
  final formKey = GlobalKey<FormState>();
  
  String email = "";
  bool isEmailSent = false;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Forgot Password"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            SizedBox(height: sp3xl),
            
            // Icon and Header
            Column(
              spacing: spMd,
              children: [
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    color: primaryColor.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusXl),
                  ),
                  child: Icon(
                    isEmailSent ? Icons.mark_email_read : Icons.lock_reset,
                    size: 50,
                    color: primaryColor,
                  ),
                ),
                
                Text(
                  isEmailSent ? "Check Your Email" : "Reset Password",
                  style: TextStyle(
                    fontSize: fsH2,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                
                Text(
                  isEmailSent 
                    ? "We've sent a password reset link to your email address. Please check your inbox and follow the instructions."
                    : "Enter your email address and we'll send you a link to reset your password.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: disabledBoldColor,
                    height: 1.5,
                  ),
                ),
              ],
            ),
            
            if (!isEmailSent) ...[
              SizedBox(height: sp2xl),
              
              // Email Input Form
              Form(
                key: formKey,
                child: Column(
                  spacing: spMd,
                  children: [
                    QTextField(
                      label: "Email Address",
                      value: email,
                      hint: "Enter your registered email",
                      validator: Validator.email,
                      onChanged: (value) {
                        email = value;
                        setState(() {});
                      },
                    ),
                    
                    SizedBox(height: spLg),
                    
                    // Send Reset Link Button
                    Container(
                      width: double.infinity,
                      child: QButton(
                        label: "Send Reset Link",
                        size: bs.md,
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            // Handle password reset
                            isEmailSent = true;
                            setState(() {});
                            ss("Password reset link sent to your email");
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ] else ...[
              SizedBox(height: sp2xl),
              
              // Email Sent Actions
              Column(
                spacing: spSm,
                children: [
                  Container(
                    width: double.infinity,
                    child: QButton(
                      label: "Open Email App",
                      size: bs.md,
                      onPressed: () {
                        // Open email app
                      },
                    ),
                  ),
                  
                  Container(
                    width: double.infinity,
                    child: OutlinedButton(
                      onPressed: () {
                        // Resend email
                        ss("Reset link sent again");
                      },
                      style: OutlinedButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: spMd),
                        side: BorderSide(color: primaryColor),
                      ),
                      child: Text(
                        "Resend Email",
                        style: TextStyle(
                          color: primaryColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
            
            SizedBox(height: sp3xl),
            
            // Help Section
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: infoColor.withAlpha(10),
                borderRadius: BorderRadius.circular(radiusMd),
                border: Border.all(color: infoColor.withAlpha(30)),
              ),
              child: Column(
                spacing: spSm,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.help_outline,
                        color: infoColor,
                        size: 20,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "Need Help?",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: infoColor,
                        ),
                      ),
                    ],
                  ),
                  
                  Text(
                    "If you don't receive the email within a few minutes, check your spam folder or contact our support team.",
                    style: TextStyle(
                      fontSize: 14,
                      color: disabledBoldColor,
                      height: 1.4,
                    ),
                  ),
                  
                  SizedBox(height: spSm),
                  
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: () {
                            // Contact support
                          },
                          icon: Icon(Icons.support_agent, size: 16),
                          label: Text("Contact Support"),
                          style: OutlinedButton.styleFrom(
                            foregroundColor: infoColor,
                            side: BorderSide(color: infoColor),
                            padding: EdgeInsets.symmetric(vertical: spSm),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            
            SizedBox(height: spXl),
            
            // Back to Login
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Remember your password? ",
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    back();
                  },
                  child: Text(
                    "Sign In",
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
    );
  }
}
