import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class ReaForgotPasswordView extends StatefulWidget {
  const ReaForgotPasswordView({super.key});

  @override
  State<ReaForgotPasswordView> createState() => _ReaForgotPasswordViewState();
}

class _ReaForgotPasswordViewState extends State<ReaForgotPasswordView> {
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
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: spLg),
              Center(
                child: Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    color: primaryColor.withAlpha(50),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    isEmailSent ? Icons.check_circle : Icons.lock_reset,
                    size: 50,
                    color: primaryColor,
                  ),
                ),
              ),
              SizedBox(height: spLg),
              Text(
                isEmailSent ? "Check Your Email" : "Reset Your Password",
                style: TextStyle(
                  fontSize: fsH2,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: spMd),
              Text(
                isEmailSent
                    ? "We've sent a password reset link to your email address. Please check your inbox and follow the instructions."
                    : "Enter your email address and we'll send you a link to reset your password.",
                style: TextStyle(
                  fontSize: fsH6,
                  color: disabledBoldColor,
                  height: 1.5,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: spXl),
              if (!isEmailSent) ...[
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
                QButton(
                  label: "Send Reset Link",
                  size: bs.md,
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      isEmailSent = true;
                      setState(() {});
                      ss("Password reset link sent successfully");
                    }
                  },
                ),
              ] else ...[
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: successColor.withAlpha(30),
                    borderRadius: BorderRadius.circular(radiusSm),
                    border: Border.all(color: successColor.withAlpha(100)),
                  ),
                  child: Column(
                    children: [
                      Icon(
                        Icons.email,
                        color: successColor,
                        size: 40,
                      ),
                      SizedBox(height: spSm),
                      Text(
                        "Email sent to:",
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
                    ],
                  ),
                ),
                SizedBox(height: spLg),
                QButton(
                  label: "Resend Email",
                  size: bs.md,
                  color: disabledBoldColor,
                  onPressed: () {
                    ss("Reset link sent again");
                  },
                ),
                SizedBox(height: spMd),
                QButton(
                  label: "Back to Login",
                  size: bs.md,
                  onPressed: () {
                    back();
                  },
                ),
              ],
              SizedBox(height: spXl),
              if (!isEmailSent) ...[
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
              SizedBox(height: spLg),
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: infoColor.withAlpha(30),
                  borderRadius: BorderRadius.circular(radiusSm),
                  border: Border.all(color: infoColor.withAlpha(100)),
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
                          "Need Help?",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "• Check your spam/junk folder\n• Make sure you entered the correct email\n• Contact support if you don't receive the email",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                        height: 1.4,
                      ),
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
}
