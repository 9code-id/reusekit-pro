import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class ElaForgotPasswordView extends StatefulWidget {
  const ElaForgotPasswordView({super.key});

  @override
  State<ElaForgotPasswordView> createState() => _ElaForgotPasswordViewState();
}

class _ElaForgotPasswordViewState extends State<ElaForgotPasswordView> {
  final formKey = GlobalKey<FormState>();
  String email = "";
  bool isEmailSent = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Reset Password"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: spLg),
              
              // Header
              Center(
                child: Column(
                  children: [
                    Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        color: isEmailSent ? successColor.withAlpha(20) : primaryColor.withAlpha(20),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        isEmailSent ? Icons.mark_email_read : Icons.lock_reset,
                        size: 50,
                        color: isEmailSent ? successColor : primaryColor,
                      ),
                    ),
                    SizedBox(height: spMd),
                    Text(
                      isEmailSent ? "Check Your Email" : "Forgot Password?",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spSm),
                    Text(
                      isEmailSent 
                        ? "We've sent password reset instructions to your email address"
                        : "Don't worry! Enter your email and we'll send you reset instructions",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                        height: 1.5,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: spXl),

              if (!isEmailSent) ...[
                // Email Input
                Text(
                  "Email Address",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spMd),
                
                QTextField(
                  label: "Email Address",
                  value: email,
                  hint: "Enter your registered email address",
                  validator: Validator.email,
                  onChanged: (value) {
                    email = value;
                    setState(() {});
                  },
                ),
                SizedBox(height: spLg),

                // Send Reset Button
                Container(
                  width: double.infinity,
                  child: QButton(
                    label: "Send Reset Instructions",
                    icon: Icons.send,
                    size: bs.md,
                    onPressed: () {
                      _handleSendReset();
                    },
                  ),
                ),
                SizedBox(height: spLg),

                // Additional Help
                Container(
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: infoColor.withAlpha(10),
                    borderRadius: BorderRadius.circular(radiusMd),
                    border: Border.all(
                      color: infoColor.withAlpha(40),
                      width: 1,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.info,
                            size: 20,
                            color: infoColor,
                          ),
                          SizedBox(width: spSm),
                          Text(
                            "Need Help?",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: infoColor,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spSm),
                      Text(
                        "• Make sure you enter the email address associated with your account\n• Check your spam/junk folder if you don't receive the email\n• Reset link will expire in 15 minutes",
                        style: TextStyle(
                          fontSize: 12,
                          color: primaryColor,
                          height: 1.5,
                        ),
                      ),
                    ],
                  ),
                ),
              ] else ...[
                // Email Sent Success
                Container(
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: successColor.withAlpha(10),
                    borderRadius: BorderRadius.circular(radiusMd),
                    border: Border.all(
                      color: successColor.withAlpha(40),
                      width: 1,
                    ),
                  ),
                  child: Column(
                    children: [
                      Icon(
                        Icons.check_circle,
                        size: 48,
                        color: successColor,
                      ),
                      SizedBox(height: spMd),
                      Text(
                        "Email Sent Successfully!",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: successColor,
                        ),
                      ),
                      SizedBox(height: spSm),
                      Text(
                        "Password reset instructions have been sent to:",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14,
                          color: primaryColor,
                        ),
                      ),
                      SizedBox(height: spXs),
                      Text(
                        email,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: spLg),

                // Action Buttons
                Container(
                  width: double.infinity,
                  child: QButton(
                    label: "Open Email App",
                    icon: Icons.email,
                    size: bs.md,
                    onPressed: () {
                      _openEmailApp();
                    },
                  ),
                ),
                SizedBox(height: spMd),
                
                Container(
                  width: double.infinity,
                  child: QButton(
                    label: "Resend Email",
                    icon: Icons.refresh,
                    color: secondaryColor,
                    size: bs.md,
                    onPressed: () {
                      _resendEmail();
                    },
                  ),
                ),
                SizedBox(height: spLg),

                // Timer for resend
                Center(
                  child: Text(
                    "Didn't receive the email? You can resend it in 60 seconds",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
                ),
              ],
              
              SizedBox(height: spXl),

              // Back to Login
              Center(
                child: Column(
                  children: [
                    Text(
                      "Remember your password?",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    GestureDetector(
                      onTap: () {
                        back();
                      },
                      child: Text(
                        "Back to Sign In",
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
            ],
          ),
        ),
      ),
    );
  }

  void _handleSendReset() async {
    if (formKey.currentState!.validate()) {
      showLoading();
      await Future.delayed(Duration(seconds: 2));
      hideLoading();
      
      isEmailSent = true;
      setState(() {});
      ss("Reset instructions sent successfully");
    }
  }

  void _openEmailApp() {
    // Open email app
    ss("Opening email app");
  }

  void _resendEmail() async {
    showLoading();
    await Future.delayed(Duration(seconds: 1));
    hideLoading();
    
    ss("Email resent successfully");
  }
}
