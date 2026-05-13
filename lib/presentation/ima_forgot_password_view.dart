import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class ImaForgotPasswordView extends StatefulWidget {
  const ImaForgotPasswordView({super.key});

  @override
  State<ImaForgotPasswordView> createState() => _ImaForgotPasswordViewState();
}

class _ImaForgotPasswordViewState extends State<ImaForgotPasswordView> {
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
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: spXl),
            
            // Logo/Icon
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: primaryColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusLg),
              ),
              child: Icon(
                Icons.lock_reset,
                size: 50,
                color: primaryColor,
              ),
            ),
            
            SizedBox(height: spLg),
            
            if (!isEmailSent) ...[
              // Title and Description
              Text(
                "Reset Your Password",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: fsH3,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              
              SizedBox(height: spSm),
              
              Text(
                "Enter your email address and we'll send you a link to reset your password.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  color: disabledBoldColor,
                ),
              ),
              
              SizedBox(height: spLg),
              
              // Email Form
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  spacing: spSm,
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
                    
                    SizedBox(height: spSm),
                    
                    Container(
                      width: double.infinity,
                      child: QButton(
                        label: "Send Reset Link",
                        size: bs.md,
                        onPressed: () {
                          isEmailSent = true;
                          setState(() {});
                        },
                      ),
                    ),
                  ],
                ),
              ),
              
              SizedBox(height: spMd),
              
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
                      //navigateTo LoginView
                    },
                    child: Text(
                      "Sign In",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                  ),
                ],
              ),
            ] else ...[
              // Email Sent Success
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: successColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusMd),
                  border: Border.all(color: successColor.withAlpha(50)),
                ),
                child: Column(
                  children: [
                    Icon(
                      Icons.mark_email_read,
                      size: 60,
                      color: successColor,
                    ),
                    
                    SizedBox(height: spSm),
                    
                    Text(
                      "Email Sent Successfully!",
                      style: TextStyle(
                        fontSize: fsH5,
                        fontWeight: FontWeight.bold,
                        color: successColor,
                      ),
                    ),
                    
                    SizedBox(height: spSm),
                    
                    Text(
                      "We've sent a password reset link to:",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                    
                    SizedBox(height: spXs),
                    
                    Text(
                      email,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                    
                    SizedBox(height: spSm),
                    
                    Text(
                      "Please check your inbox and follow the instructions to reset your password.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              
              SizedBox(height: spMd),
              
              // Resend Email
              Container(
                width: double.infinity,
                child: QButton(
                  label: "Resend Email",
                  size: bs.md,
                  onPressed: () {
                    ss("Password reset email resent successfully");
                  },
                ),
              ),
              
              SizedBox(height: spSm),
              
              // Back to Login
              Container(
                width: double.infinity,
                child: QButton(
                  label: "Back to Sign In",
                  size: bs.md,
                  onPressed: () {
                    //navigateTo LoginView
                  },
                ),
              ),
            ],
            
            SizedBox(height: spXl),
            
            // Help Text
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: infoColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.info_outline,
                    color: infoColor,
                    size: 20,
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Text(
                      "Didn't receive the email? Check your spam folder or contact support for assistance.",
                      style: TextStyle(
                        fontSize: 12,
                        color: infoColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
