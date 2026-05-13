import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class CmaForgotPasswordView extends StatefulWidget {
  const CmaForgotPasswordView({super.key});

  @override
  State<CmaForgotPasswordView> createState() => _CmaForgotPasswordViewState();
}

class _CmaForgotPasswordViewState extends State<CmaForgotPasswordView> {
  final formKey = GlobalKey<FormState>();
  String email = "";
  bool emailSent = false;
  int resendCountdown = 0;

  void _sendResetEmail() async {
    if (formKey.currentState!.validate()) {
      showLoading();
      
      // Simulate sending reset email
      await Future.delayed(Duration(seconds: 2));
      
      hideLoading();
      
      setState(() {
        emailSent = true;
        resendCountdown = 60;
      });
      
      _startCountdown();
      ss("Password reset instructions sent to $email");
    }
  }

  void _startCountdown() {
    Future.doWhile(() async {
      await Future.delayed(Duration(seconds: 1));
      if (mounted) {
        setState(() {
          resendCountdown--;
        });
        return resendCountdown > 0;
      }
      return false;
    });
  }

  void _resendEmail() {
    if (resendCountdown == 0) {
      _sendResetEmail();
    }
  }

  void _backToLogin() {
    back();
  }

  void _openEmailApp() {
    ss("Opening email application");
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
          spacing: spMd,
          children: [
            SizedBox(height: spLg),

            // Icon and Title
            Center(
              child: Column(
                children: [
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      color: emailSent ? successColor.withAlpha(20) : warningColor.withAlpha(20),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      emailSent ? Icons.email : Icons.lock_reset,
                      size: 50,
                      color: emailSent ? successColor : warningColor,
                    ),
                  ),
                  SizedBox(height: spMd),
                  Text(
                    emailSent ? "Check Your Email" : "Reset Password",
                    style: TextStyle(
                      fontSize: fsH3,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spSm),
                  Text(
                    emailSent 
                      ? "We've sent password reset instructions to your email address."
                      : "Enter your email address and we'll send you instructions to reset your password.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: spLg),

            if (!emailSent) ...[
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

                    Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: infoColor.withAlpha(10),
                        borderRadius: BorderRadius.circular(radiusXs),
                        border: Border.all(color: infoColor.withAlpha(30)),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.info_outline, color: infoColor, size: 20),
                          SizedBox(width: spSm),
                          Expanded(
                            child: Text(
                              "Make sure to enter the email address you used to register your CMA Business account.",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: spMd),

                    Container(
                      width: double.infinity,
                      child: QButton(
                        label: "Send Reset Instructions",
                        size: bs.md,
                        onPressed: _sendResetEmail,
                      ),
                    ),
                  ],
                ),
              ),
            ] else ...[
              // Email Sent Success State
              Column(
                spacing: spMd,
                children: [
                  Container(
                    padding: EdgeInsets.all(spMd),
                    decoration: BoxDecoration(
                      color: successColor.withAlpha(10),
                      borderRadius: BorderRadius.circular(radiusSm),
                      border: Border.all(color: successColor.withAlpha(30)),
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Icon(Icons.check_circle, color: successColor, size: 24),
                            SizedBox(width: spSm),
                            Expanded(
                              child: Text(
                                "Email sent successfully!",
                                style: TextStyle(
                                  fontSize: fsH6,
                                  fontWeight: FontWeight.bold,
                                  color: successColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: spSm),
                        Text(
                          "We've sent password reset instructions to:",
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
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Instructions
                  Container(
                    padding: EdgeInsets.all(spMd),
                    decoration: BoxDecoration(
                      color: Colors.grey[50],
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Next Steps:",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        SizedBox(height: spSm),
                        _buildInstructionStep("1", "Check your email inbox"),
                        _buildInstructionStep("2", "Look for an email from CMA Business"),
                        _buildInstructionStep("3", "Click the reset link in the email"),
                        _buildInstructionStep("4", "Create your new password"),
                        SizedBox(height: spSm),
                        Text(
                          "If you don't see the email, check your spam or junk folder.",
                          style: TextStyle(
                            fontSize: 12,
                            color: warningColor,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Action Buttons
                  Container(
                    width: double.infinity,
                    child: QButton(
                      label: "Open Email App",
                      size: bs.md,
                      onPressed: _openEmailApp,
                    ),
                  ),

                  // Resend Option
                  Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      border: Border.all(color: disabledColor),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: InkWell(
                      onTap: resendCountdown == 0 ? _resendEmail : null,
                      borderRadius: BorderRadius.circular(radiusSm),
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.refresh,
                              color: resendCountdown == 0 ? primaryColor : disabledColor,
                              size: 20,
                            ),
                            SizedBox(width: spSm),
                            Text(
                              resendCountdown > 0 
                                ? "Resend in ${resendCountdown}s"
                                : "Resend Email",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: resendCountdown == 0 ? primaryColor : disabledColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],

            SizedBox(height: spLg),

            // Additional Help
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.grey[50],
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Column(
                children: [
                  Text(
                    "Need Help?",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "If you're still having trouble accessing your account, please contact our support team.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      color: disabledBoldColor,
                    ),
                  ),
                  SizedBox(height: spSm),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          ss("Support chat opened");
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                          decoration: BoxDecoration(
                            color: primaryColor.withAlpha(10),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.chat, color: primaryColor, size: 16),
                              SizedBox(width: spXs),
                              Text(
                                "Chat Support",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: primaryColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(width: spSm),
                      GestureDetector(
                        onTap: () {
                          ss("Support email opened");
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                          decoration: BoxDecoration(
                            color: primaryColor.withAlpha(10),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.email, color: primaryColor, size: 16),
                              SizedBox(width: spXs),
                              Text(
                                "Email Support",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: primaryColor,
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

            SizedBox(height: spMd),

            // Back to Login
            Center(
              child: GestureDetector(
                onTap: _backToLogin,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.arrow_back, color: primaryColor, size: 20),
                    SizedBox(width: spXs),
                    Text(
                      "Back to Sign In",
                      style: TextStyle(
                        fontSize: 16,
                        color: primaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: spMd),
          ],
        ),
      ),
    );
  }

  Widget _buildInstructionStep(String number, String text) {
    return Padding(
      padding: EdgeInsets.only(bottom: spXs),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 20,
            height: 20,
            decoration: BoxDecoration(
              color: primaryColor,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                number,
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 14,
                color: disabledBoldColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
