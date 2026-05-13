import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class EcsForgotPasswordView extends StatefulWidget {
  const EcsForgotPasswordView({super.key});

  @override
  State<EcsForgotPasswordView> createState() => _EcsForgotPasswordViewState();
}

class _EcsForgotPasswordViewState extends State<EcsForgotPasswordView> {
  final formKey = GlobalKey<FormState>();
  String email = "";
  bool loading = false;
  bool emailSent = false;

  void _sendResetLink() async {
    if (formKey.currentState!.validate()) {
      loading = true;
      setState(() {});
      
      await Future.delayed(Duration(seconds: 2));
      
      loading = false;
      emailSent = true;
      setState(() {});
      
      ss("Password reset link sent to your email!");
    }
  }

  void _resendEmail() async {
    showLoading();
    await Future.delayed(Duration(seconds: 2));
    hideLoading();
    ss("Reset link sent again!");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Forgot Password"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: spLg),
            Center(
              child: Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  color: warningColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(radiusLg),
                ),
                child: Icon(
                  Icons.lock_reset,
                  size: 50,
                  color: warningColor,
                ),
              ),
            ),
            SizedBox(height: spLg),
            if (!emailSent) ...[
              Center(
                child: Text(
                  "Reset Your Password",
                  style: TextStyle(
                    fontSize: fsH3,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
              ),
              SizedBox(height: spSm),
              Center(
                child: Text(
                  "Enter your email address and we'll send you a link to reset your password",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                    height: 1.5,
                  ),
                ),
              ),
              SizedBox(height: spXl),
              Form(
                key: formKey,
                child: QTextField(
                  label: "Email Address",
                  value: email,
                  hint: "Enter your email",
                  validator: Validator.email,
                  onChanged: (value) {
                    email = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(height: spXl),
              Container(
                width: double.infinity,
                child: loading
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : QButton(
                        label: "Send Reset Link",
                        size: bs.md,
                        onPressed: _sendResetLink,
                      ),
              ),
            ] else ...[
              Center(
                child: Text(
                  "Check Your Email",
                  style: TextStyle(
                    fontSize: fsH3,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
              ),
              SizedBox(height: spSm),
              Center(
                child: Text(
                  "We've sent a password reset link to",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                  ),
                ),
              ),
              SizedBox(height: spXs),
              Center(
                child: Text(
                  "$email",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
              ),
              SizedBox(height: spLg),
              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: infoColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(radiusSm),
                  border: Border.all(
                    color: infoColor.withValues(alpha: 0.3),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.info,
                          color: infoColor,
                          size: 20,
                        ),
                        SizedBox(width: spSm),
                        Text(
                          "Instructions",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: infoColor,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "• Check your inbox and spam folder\n• Click the reset link in the email\n• Follow the instructions to create a new password\n• The link will expire in 24 hours",
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
              Container(
                width: double.infinity,
                child: QButton(
                  label: "Resend Email",
                  size: bs.md,
                  onPressed: _resendEmail,
                ),
              ),
              SizedBox(height: spMd),
              Container(
                width: double.infinity,
                child: QButton(
                  label: "Try Different Email",
                  color: disabledBoldColor,
                  size: bs.md,
                  onPressed: () {
                    emailSent = false;
                    email = "";
                    setState(() {});
                  },
                ),
              ),
            ],
            SizedBox(height: spXl),
            Center(
              child: Row(
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
            ),
          ],
        ),
      ),
    );
  }
}
