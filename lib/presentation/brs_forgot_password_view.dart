import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class BrsForgotPasswordView extends StatefulWidget {
  const BrsForgotPasswordView({super.key});

  @override
  State<BrsForgotPasswordView> createState() => _BrsForgotPasswordViewState();
}

class _BrsForgotPasswordViewState extends State<BrsForgotPasswordView> {
  final formKey = GlobalKey<FormState>();
  String email = "";
  bool isSubmitted = false;

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
            Container(
              width: double.infinity,
              child: Column(
                children: [
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      color: warningColor.withAlpha(30),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.lock_reset,
                      size: 50,
                      color: warningColor,
                    ),
                  ),
                  SizedBox(height: spLg),
                  Text(
                    isSubmitted ? "Check Your Email" : "Reset Password",
                    style: TextStyle(
                      fontSize: fsH3,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spSm),
                  Text(
                    isSubmitted
                        ? "We've sent a password reset link to your email address. Please check your inbox and follow the instructions."
                        : "Enter your email address and we'll send you a link to reset your password.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: disabledBoldColor,
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),
            if (!isSubmitted) ...[
              Form(
                key: formKey,
                child: Column(
                  spacing: spMd,
                  children: [
                    QTextField(
                      label: "Email Address",
                      value: email,
                      validator: Validator.email,
                      hint: "Enter your registered email",
                      onChanged: (value) {
                        email = value;
                        setState(() {});
                      },
                    ),
                    Container(
                      width: double.infinity,
                      child: QButton(
                        label: "Send Reset Link",
                        size: bs.md,
                        onPressed: () async {
                          if (formKey.currentState!.validate()) {
                            showLoading();
                            await Future.delayed(Duration(seconds: 2));
                            hideLoading();
                            setState(() {
                              isSubmitted = true;
                            });
                            ss("Reset link sent to your email!");
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ] else ...[
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: successColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusMd),
                  border: Border.all(color: successColor.withAlpha(50)),
                ),
                child: Column(
                  children: [
                    Icon(
                      Icons.email,
                      color: successColor,
                      size: 32,
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "Email Sent Successfully",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: successColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "Check your spam folder if you don't see the email in your inbox.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: double.infinity,
                child: QButton(
                  label: "Resend Email",
                  size: bs.md,
                  onPressed: () async {
                    showLoading();
                    await Future.delayed(Duration(seconds: 2));
                    hideLoading();
                    ss("Reset link sent again!");
                  },
                ),
              ),
            ],
            Container(
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Remember your password? ",
                    style: TextStyle(
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
                        color: primaryColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            if (isSubmitted) ...[
              Container(
                width: double.infinity,
                child: Column(
                  children: [
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: infoColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusSm),
                        border: Border.all(color: infoColor.withAlpha(50)),
                      ),
                      child: Column(
                        children: [
                          Icon(
                            Icons.info,
                            color: infoColor,
                            size: 20,
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "Didn't receive the email?",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: infoColor,
                              fontSize: 12,
                            ),
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "• Check your spam/junk folder\n• Make sure the email address is correct\n• Try again in a few minutes",
                            style: TextStyle(
                              fontSize: 11,
                              color: disabledBoldColor,
                              height: 1.5,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
