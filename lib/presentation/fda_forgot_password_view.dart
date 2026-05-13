import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class FdaForgotPasswordView extends StatefulWidget {
  const FdaForgotPasswordView({super.key});

  @override
  State<FdaForgotPasswordView> createState() => _FdaForgotPasswordViewState();
}

class _FdaForgotPasswordViewState extends State<FdaForgotPasswordView> {
  final formKey = GlobalKey<FormState>();
  String email = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Forgot Password"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              SizedBox(height: spXl),
              
              // Forgot Password Icon
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  color: warningColor.withAlpha(30),
                  borderRadius: BorderRadius.circular(radiusXl),
                ),
                child: Icon(
                  Icons.lock_reset,
                  size: 50,
                  color: warningColor,
                ),
              ),
              
              SizedBox(height: spXl),
              
              // Title
              Text(
                "Reset Password",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: fsH2,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              
              SizedBox(height: spMd),
              
              // Description
              Text(
                "Enter your email address and we'll send you a link to reset your password.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: disabledBoldColor,
                  height: 1.5,
                ),
              ),
              
              SizedBox(height: spXl),
              
              // Email Field
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
              
              SizedBox(height: spXl),
              
              // Send Reset Link Button
              QButton(
                label: "Send Reset Link",
                size: bs.md,
                icon: Icons.send,
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    _sendResetLink();
                  }
                },
              ),
              
              SizedBox(height: spMd),
              
              // Back to Login
              GestureDetector(
                onTap: () {
                  back();
                },
                child: Text(
                  "Back to Sign In",
                  style: TextStyle(
                    fontSize: 16,
                    color: primaryColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              
              SizedBox(height: spXl),
              
              // Help Section
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: infoColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusMd),
                  border: Border.all(color: infoColor.withAlpha(100)),
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Icon(Icons.info, color: infoColor, size: 20),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Text(
                            "Need Help?",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: infoColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "If you don't receive the email within a few minutes, please check your spam folder or contact our support team.",
                      style: TextStyle(
                        fontSize: 14,
                        color: infoColor,
                        height: 1.4,
                      ),
                    ),
                    SizedBox(height: spSm),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: spXs),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(radiusSm),
                              border: Border.all(color: infoColor),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.support_agent, color: infoColor, size: 16),
                                SizedBox(width: spXs),
                                Text(
                                  "Contact Support",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: infoColor,
                                    fontWeight: FontWeight.w600,
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
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _sendResetLink() async {
    showLoading();
    await Future.delayed(Duration(seconds: 2));
    hideLoading();
    
    ss("Reset link sent to your email");
    
    // Show success dialog
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Row(
          children: [
            Icon(Icons.check_circle, color: successColor),
            SizedBox(width: spSm),
            Text("Email Sent"),
          ],
        ),
        content: Text(
          "We've sent a password reset link to $email. Please check your inbox and follow the instructions.",
        ),
        actions: [
          QButton(
            label: "OK",
            size: bs.sm,
            onPressed: () {
              Navigator.of(context).pop();
              back();
            },
          ),
        ],
      ),
    );
  }
}
