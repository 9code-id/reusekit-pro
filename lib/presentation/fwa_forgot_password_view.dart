import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class FwaForgotPasswordView extends StatefulWidget {
  const FwaForgotPasswordView({super.key});

  @override
  State<FwaForgotPasswordView> createState() => _FwaForgotPasswordViewState();
}

class _FwaForgotPasswordViewState extends State<FwaForgotPasswordView> {
  final formKey = GlobalKey<FormState>();
  String email = "";
  bool loading = false;
  bool emailSent = false;

  Future<void> _handleSendResetLink() async {
    if (!formKey.currentState!.validate()) {
      return;
    }

    loading = true;
    setState(() {});

    // Simulate API call
    await Future.delayed(Duration(seconds: 2));

    loading = false;
    emailSent = true;
    setState(() {});

    ss("Password reset link sent to your email!");
  }

  Future<void> _handleResendEmail() async {
    loading = true;
    setState(() {});

    await Future.delayed(Duration(seconds: 1));

    loading = false;
    setState(() {});

    ss("Reset link resent successfully!");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Back Button
              GestureDetector(
                onTap: () {
                  back();
                },
                child: Icon(
                  Icons.arrow_back,
                  color: primaryColor,
                  size: 24,
                ),
              ),

              SizedBox(height: spXl),

              // Header Section
              Container(
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Illustration
                    Container(
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                        color: primaryColor.withAlpha(25),
                        borderRadius: BorderRadius.circular(radiusXl),
                      ),
                      child: Icon(
                        Icons.lock_reset,
                        color: primaryColor,
                        size: 60,
                      ),
                    ),

                    SizedBox(height: spMd),

                    Text(
                      emailSent ? "Check Your Email" : "Forgot Password?",
                      style: TextStyle(
                        fontSize: fsH2,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),

                    SizedBox(height: spSm),

                    Text(
                      emailSent 
                          ? "We've sent a password reset link to $email"
                          : "Don't worry! Enter your email and we'll send you a reset link",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        color: disabledBoldColor,
                        height: 1.5,
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: spXl),

              if (!emailSent) ...[
                // Reset Form
                Form(
                  key: formKey,
                  child: Column(
                    spacing: spMd,
                    children: [
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

                      SizedBox(height: spMd),

                      // Send Reset Link Button
                      Container(
                        width: double.infinity,
                        child: loading
                            ? Container(
                                height: 50,
                                child: Center(
                                  child: CircularProgressIndicator(),
                                ),
                              )
                            : QButton(
                                label: "Send Reset Link",
                                size: bs.md,
                                onPressed: _handleSendResetLink,
                              ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: spLg),

                // Alternative Methods
                Container(
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusSm),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    children: [
                      Text(
                        "Other Recovery Options",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      
                      SizedBox(height: spMd),
                      
                      // Phone Recovery
                      GestureDetector(
                        onTap: () {
                          si("Phone recovery option coming soon");
                        },
                        child: Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: infoColor.withAlpha(25),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.phone,
                                color: infoColor,
                                size: 20,
                              ),
                              SizedBox(width: spSm),
                              Expanded(
                                child: Text(
                                  "Reset via SMS",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: primaryColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              Icon(
                                Icons.arrow_forward_ios,
                                color: disabledBoldColor,
                                size: 16,
                              ),
                            ],
                          ),
                        ),
                      ),
                      
                      SizedBox(height: spSm),
                      
                      // Security Questions
                      GestureDetector(
                        onTap: () {
                          si("Security questions coming soon");
                        },
                        child: Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: warningColor.withAlpha(25),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.help_outline,
                                color: warningColor,
                                size: 20,
                              ),
                              SizedBox(width: spSm),
                              Expanded(
                                child: Text(
                                  "Security Questions",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: primaryColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              Icon(
                                Icons.arrow_forward_ios,
                                color: disabledBoldColor,
                                size: 16,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ] else ...[
                // Email Sent State
                Column(
                  children: [
                    // Email Sent Illustration
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(spLg),
                      decoration: BoxDecoration(
                        color: successColor.withAlpha(25),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Column(
                        children: [
                          Icon(
                            Icons.email,
                            color: successColor,
                            size: 48,
                          ),
                          SizedBox(height: spMd),
                          Text(
                            "Reset link sent!",
                            style: TextStyle(
                              fontSize: fsH5,
                              fontWeight: FontWeight.bold,
                              color: successColor,
                            ),
                          ),
                          SizedBox(height: spSm),
                          Text(
                            "Please check your email inbox and follow the instructions to reset your password.",
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

                    // Action Buttons
                    Column(
                      spacing: spSm,
                      children: [
                        // Resend Email Button
                        Container(
                          width: double.infinity,
                          child: loading
                              ? Container(
                                  height: 50,
                                  child: Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                )
                              : QButton(
                                  label: "Resend Email",
                                  size: bs.md,
                                  onPressed: _handleResendEmail,
                                ),
                        ),

                        // Back to Login
                        Container(
                          width: double.infinity,
                          child: GestureDetector(
                            onTap: () {
                              // navigateTo(FwaLoginView());
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(vertical: spMd),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(radiusSm),
                                border: Border.all(color: primaryColor),
                              ),
                              child: Text(
                                "Back to Sign In",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: primaryColor,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: spLg),

                    // Help Section
                    Container(
                      padding: EdgeInsets.all(spMd),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(radiusSm),
                        boxShadow: [shadowSm],
                      ),
                      child: Column(
                        children: [
                          Text(
                            "Didn't receive the email?",
                            style: TextStyle(
                              fontSize: fsH6,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          SizedBox(height: spSm),
                          Text(
                            "• Check your spam or junk folder\n• Make sure you entered the correct email\n• Try adding our email to your contacts",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                              height: 1.5,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],

              SizedBox(height: spXl),

              // Back to Login Link
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
                      // navigateTo(FwaLoginView());
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
      ),
    );
  }
}
