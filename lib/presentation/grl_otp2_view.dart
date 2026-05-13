import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlOtp2View extends StatefulWidget {
  @override
  State<GrlOtp2View> createState() => _GrlOtp2ViewState();
}

class _GrlOtp2ViewState extends State<GrlOtp2View> {
  String otpCode = "";
  String email = "john.doe@example.com";
  int timeRemaining = 300; // 5 minutes
  bool isVerifying = false;
  
  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    Future.delayed(Duration(seconds: 1), () {
      if (mounted && timeRemaining > 0) {
        timeRemaining--;
        setState(() {});
        _startTimer();
      }
    });
  }

  String get formattedTime {
    int minutes = (timeRemaining ~/ 60);
    int seconds = timeRemaining % 60;
    return "${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}";
  }

  void _verifyCode() async {
    if (otpCode.length < 6) {
      se("Please enter the complete verification code");
      return;
    }

    isVerifying = true;
    setState(() {});

    // Simulate API call
    await Future.delayed(Duration(seconds: 2));

    isVerifying = false;
    setState(() {});

    if (otpCode == "123456") {
      ss("Email verified successfully");
      // Navigate to next screen
    } else {
      se("Invalid verification code. Please try again.");
      otpCode = "";
      setState(() {});
    }
  }

  void _resendCode() async {
    showLoading();
    await Future.delayed(Duration(seconds: 1));
    hideLoading();
    
    timeRemaining = 300;
    setState(() {});
    _startTimer();
    si("Verification code sent to your email");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Email Verification"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spLg,
          children: [
            // Header Section
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spLg),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    primaryColor.withAlpha(10),
                    primaryColor.withAlpha(5),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(radiusLg),
                border: Border.all(
                  color: primaryColor.withAlpha(30),
                  width: 1,
                ),
              ),
              child: Column(
                spacing: spSm,
                children: [
                  Container(
                    height: 60,
                    width: 60,
                    decoration: BoxDecoration(
                      color: primaryColor,
                      borderRadius: BorderRadius.circular(radiusLg),
                    ),
                    child: Icon(
                      Icons.email_outlined,
                      size: 30,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    "Check Your Email",
                    style: TextStyle(
                      fontSize: fsH4,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Text(
                    "We've sent a verification code to:",
                    style: TextStyle(
                      fontSize: 14,
                      color: disabledBoldColor,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: spSm,
                      vertical: spXs,
                    ),
                    decoration: BoxDecoration(
                      color: primaryColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Text(
                      email,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Timer Section
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: timeRemaining > 60 ? successColor.withAlpha(10) : warningColor.withAlpha(10),
                borderRadius: BorderRadius.circular(radiusSm),
                border: Border.all(
                  color: timeRemaining > 60 ? successColor.withAlpha(50) : warningColor.withAlpha(50),
                  width: 1,
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.timer_outlined,
                    size: 20,
                    color: timeRemaining > 60 ? successColor : warningColor,
                  ),
                  SizedBox(width: spXs),
                  Text(
                    "Code expires in: ",
                    style: TextStyle(
                      fontSize: 14,
                      color: disabledBoldColor,
                    ),
                  ),
                  Text(
                    formattedTime,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: timeRemaining > 60 ? successColor : warningColor,
                    ),
                  ),
                ],
              ),
            ),

            // OTP Input Section
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spLg),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowMd],
              ),
              child: Column(
                spacing: spMd,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.lock_outline,
                        size: 20,
                        color: primaryColor,
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "Enter Verification Code",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  QTextField(
                    label: "6-digit code",
                    value: otpCode,
                    hint: "Enter the code from email",
                    onChanged: (value) {
                      otpCode = value;
                      setState(() {});
                    },
                  ),
                  Container(
                    width: double.infinity,
                    child: QButton(
                      label: isVerifying ? "Verifying..." : "Verify Email",
                      size: bs.md,
                      onPressed: isVerifying ? null : _verifyCode,
                    ),
                  ),
                ],
              ),
            ),

            // Resend Section
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.grey[50],
                borderRadius: BorderRadius.circular(radiusSm),
                border: Border.all(
                  color: disabledOutlineBorderColor,
                  width: 1,
                ),
              ),
              child: Column(
                spacing: spSm,
                children: [
                  Text(
                    "Didn't receive the email?",
                    style: TextStyle(
                      fontSize: 14,
                      color: disabledBoldColor,
                    ),
                  ),
                  Row(
                    spacing: spSm,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      QButton(
                        label: "Resend Code",
                        size: bs.sm,
                        onPressed: _resendCode,
                      ),
                      QButton(
                        label: "Change Email",
                        size: bs.sm,
                        color: disabledBoldColor,
                        onPressed: () {
                          // Navigate back to change email
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Help Section
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: infoColor.withAlpha(10),
                borderRadius: BorderRadius.circular(radiusSm),
                border: Border.all(
                  color: infoColor.withAlpha(30),
                  width: 1,
                ),
              ),
              child: Column(
                spacing: spSm,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.help_outline,
                        size: 18,
                        color: infoColor,
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "Troubleshooting Tips",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: infoColor,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: spXs,
                    children: [
                      Text(
                        "• Check your spam/junk folder",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                      Text(
                        "• Ensure ${email} is correct",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                      Text(
                        "• Wait a few minutes for delivery",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
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
    );
  }
}
