import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class RhaOtpVerificationView extends StatefulWidget {
  const RhaOtpVerificationView({super.key});

  @override
  State<RhaOtpVerificationView> createState() => _RhaOtpVerificationViewState();
}

class _RhaOtpVerificationViewState extends State<RhaOtpVerificationView> {
  final formKey = GlobalKey<FormState>();
  String otpCode = "";
  bool loading = false;
  bool resending = false;
  int countdown = 60;
  String email = "john.doe@company.com";

  @override
  void initState() {
    super.initState();
    _startCountdown();
  }

  void _startCountdown() {
    Future.delayed(Duration(seconds: 1), () {
      if (mounted && countdown > 0) {
        countdown--;
        setState(() {});
        _startCountdown();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Verify Code"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Section
            Center(
              child: Column(
                spacing: spSm,
                children: [
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      color: primaryColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusLg),
                    ),
                    child: Icon(
                      Icons.verified_user,
                      size: 40,
                      color: primaryColor,
                    ),
                  ),
                  Text(
                    "Verification Code",
                    style: TextStyle(
                      fontSize: fsH4,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Text(
                    "We've sent a 6-digit verification code to",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      color: disabledBoldColor,
                    ),
                  ),
                  Text(
                    email,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: primaryColor,
                    ),
                  ),
                ],
              ),
            ),

            // OTP Input
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Form(
                key: formKey,
                child: Column(
                  spacing: spMd,
                  children: [
                    QTextField(
                      label: "Verification Code",
                      value: otpCode,
                      hint: "Enter 6-digit code",
                      validator: Validator.required,
                      onChanged: (value) {
                        otpCode = value;
                        setState(() {});
                      },
                    ),
                    Container(
                      width: double.infinity,
                      child: QButton(
                        label: loading ? "Verifying..." : "Verify Code",
                        size: bs.md,
                        onPressed: loading ? null : _verifyCode,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Resend Code
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.grey.withAlpha(10),
                borderRadius: BorderRadius.circular(radiusMd),
              ),
              child: Column(
                spacing: spSm,
                children: [
                  Text(
                    "Didn't receive the code?",
                    style: TextStyle(
                      fontSize: 14,
                      color: disabledBoldColor,
                    ),
                  ),
                  if (countdown > 0) ...[
                    Text(
                      "Resend code in ${countdown}s",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ] else ...[
                    GestureDetector(
                      onTap: resending ? null : _resendCode,
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: spMd,
                          vertical: spSm,
                        ),
                        decoration: BoxDecoration(
                          color: primaryColor.withAlpha(10),
                          borderRadius: BorderRadius.circular(radiusSm),
                          border: Border.all(
                            color: primaryColor.withAlpha(30),
                            width: 1,
                          ),
                        ),
                        child: Text(
                          resending ? "Sending..." : "Resend Code",
                          style: TextStyle(
                            fontSize: 14,
                            color: primaryColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),

            // Security Notice
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: warningColor.withAlpha(10),
                borderRadius: BorderRadius.circular(radiusMd),
                border: Border.all(
                  color: warningColor.withAlpha(30),
                  width: 1,
                ),
              ),
              child: Column(
                spacing: spSm,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.security,
                        color: warningColor,
                        size: 20,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "Security Notice",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: warningColor,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    "• Never share your verification code with anyone\n• This code will expire in 10 minutes\n• Use this code only for password reset",
                    style: TextStyle(
                      fontSize: 13,
                      color: disabledBoldColor,
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),

            // Back Button
            Center(
              child: GestureDetector(
                onTap: () {
                  back();
                },
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: spMd,
                    vertical: spSm,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.arrow_back,
                        color: primaryColor,
                        size: 16,
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "Back to Reset Password",
                        style: TextStyle(
                          fontSize: 14,
                          color: primaryColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _verifyCode() async {
    if (!formKey.currentState!.validate()) return;

    if (otpCode.length != 6) {
      se("Please enter a valid 6-digit code");
      return;
    }

    loading = true;
    setState(() {});

    // Simulate API call
    await Future.delayed(Duration(seconds: 2));

    loading = false;
    setState(() {});

    ss("Code verified successfully!");
    // ss('Next page'));
  }

  void _resendCode() async {
    resending = true;
    setState(() {});

    // Simulate API call
    await Future.delayed(Duration(seconds: 1));

    resending = false;
    countdown = 60;
    setState(() {});
    _startCountdown();

    ss("Verification code sent to $email");
  }
}
