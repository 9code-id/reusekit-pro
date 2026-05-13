import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';
import 'dart:async';

class GrlOtp4View extends StatefulWidget {
  @override
  State<GrlOtp4View> createState() => _GrlOtp4ViewState();
}

class _GrlOtp4ViewState extends State<GrlOtp4View> {
  String verificationMethod = "sms";
  String phoneNumber = "+1 (555) 123-4567";
  String email = "john.doe@example.com";
  String otpCode = "";
  int timeLeft = 120; // 2 minutes
  bool isCodeSent = false;
  bool isVerifying = false;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _startTimer() {
    _timer?.cancel();
    timeLeft = 120;
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (timeLeft > 0) {
        timeLeft--;
        setState(() {});
      } else {
        timer.cancel();
        setState(() {});
      }
    });
  }

  String get timerDisplay {
    int minutes = timeLeft ~/ 60;
    int seconds = timeLeft % 60;
    return "${minutes}:${seconds.toString().padLeft(2, '0')}";
  }

  void _sendVerificationCode() async {
    showLoading();
    await Future.delayed(Duration(seconds: 2));
    hideLoading();
    
    isCodeSent = true;
    setState(() {});
    _startTimer();
    
    String method = verificationMethod == "sms" ? "SMS" : "Email";
    String target = verificationMethod == "sms" ? phoneNumber : email;
    si("Verification code sent via ${method} to ${target}");
  }

  void _changeMethod(String method) {
    verificationMethod = method;
    isCodeSent = false;
    otpCode = "";
    _timer?.cancel();
    setState(() {});
  }

  void _verifyCode() async {
    if (otpCode.length < 4) {
      se("Please enter the 4-digit verification code");
      return;
    }

    isVerifying = true;
    setState(() {});

    await Future.delayed(Duration(seconds: 2));

    isVerifying = false;
    setState(() {});

    if (otpCode == "1234") {
      ss("Verification successful!");
      _timer?.cancel();
      // Navigate to next screen
    } else {
      se("Invalid code. Please try again.");
      otpCode = "";
      setState(() {});
    }
  }

  void _resendCode() {
    if (timeLeft > 0) {
      sw("Please wait ${timerDisplay} before requesting a new code");
      return;
    }
    
    _sendVerificationCode();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Two-Factor Authentication"),
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
                    primaryColor.withAlpha(15),
                    primaryColor.withAlpha(5),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
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
                    height: 80,
                    width: 80,
                    decoration: BoxDecoration(
                      color: primaryColor,
                      borderRadius: BorderRadius.circular(radiusLg),
                      boxShadow: [shadowMd],
                    ),
                    child: Icon(
                      Icons.verified_user,
                      size: 40,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    "Secure Your Account",
                    style: TextStyle(
                      fontSize: fsH4,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Text(
                    "Choose your preferred verification method",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ),
            ),

            // Method Selection
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Column(
                spacing: spMd,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.touch_app,
                        size: 20,
                        color: primaryColor,
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "Verification Method",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    spacing: spSm,
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () => _changeMethod("sms"),
                          child: Container(
                            padding: EdgeInsets.all(spMd),
                            decoration: BoxDecoration(
                              color: verificationMethod == "sms" 
                                  ? primaryColor.withAlpha(10) 
                                  : Colors.grey[50],
                              borderRadius: BorderRadius.circular(radiusSm),
                              border: Border.all(
                                color: verificationMethod == "sms" 
                                    ? primaryColor 
                                    : disabledOutlineBorderColor,
                                width: verificationMethod == "sms" ? 2 : 1,
                              ),
                            ),
                            child: Column(
                              spacing: spXs,
                              children: [
                                Icon(
                                  Icons.sms,
                                  size: 24,
                                  color: verificationMethod == "sms" 
                                      ? primaryColor 
                                      : disabledBoldColor,
                                ),
                                Text(
                                  "SMS",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: verificationMethod == "sms" 
                                        ? primaryColor 
                                        : disabledBoldColor,
                                  ),
                                ),
                                Text(
                                  phoneNumber,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: disabledColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: () => _changeMethod("email"),
                          child: Container(
                            padding: EdgeInsets.all(spMd),
                            decoration: BoxDecoration(
                              color: verificationMethod == "email" 
                                  ? primaryColor.withAlpha(10) 
                                  : Colors.grey[50],
                              borderRadius: BorderRadius.circular(radiusSm),
                              border: Border.all(
                                color: verificationMethod == "email" 
                                    ? primaryColor 
                                    : disabledOutlineBorderColor,
                                width: verificationMethod == "email" ? 2 : 1,
                              ),
                            ),
                            child: Column(
                              spacing: spXs,
                              children: [
                                Icon(
                                  Icons.email,
                                  size: 24,
                                  color: verificationMethod == "email" 
                                      ? primaryColor 
                                      : disabledBoldColor,
                                ),
                                Text(
                                  "Email",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: verificationMethod == "email" 
                                        ? primaryColor 
                                        : disabledBoldColor,
                                  ),
                                ),
                                Text(
                                  email,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: disabledColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  if (!isCodeSent)
                    Container(
                      width: double.infinity,
                      child: QButton(
                        label: "Send Verification Code",
                        size: bs.md,
                        onPressed: _sendVerificationCode,
                      ),
                    ),
                ],
              ),
            ),

            // OTP Input Section
            if (isCodeSent)
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
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.lock_clock,
                              size: 20,
                              color: timeLeft > 60 ? successColor : warningColor,
                            ),
                            SizedBox(width: spXs),
                            Text(
                              "Enter Code",
                              style: TextStyle(
                                fontSize: fsH6,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                          ],
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: spSm,
                            vertical: spXs,
                          ),
                          decoration: BoxDecoration(
                            color: timeLeft > 60 
                                ? successColor.withAlpha(10) 
                                : warningColor.withAlpha(10),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Text(
                            timerDisplay,
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: timeLeft > 60 ? successColor : warningColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                    QTextField(
                      label: "4-digit verification code",
                      value: otpCode,
                      hint: "Enter code received",
                      onChanged: (value) {
                        otpCode = value;
                        setState(() {});
                      },
                    ),
                    Row(
                      spacing: spSm,
                      children: [
                        Expanded(
                          child: QButton(
                            label: isVerifying ? "Verifying..." : "Verify",
                            size: bs.md,
                            onPressed: isVerifying ? null : _verifyCode,
                          ),
                        ),
                        QButton(
                          label: timeLeft > 0 ? "Resend (${timerDisplay})" : "Resend",
                          size: bs.md,
                          color: timeLeft > 0 ? disabledColor : secondaryColor,
                          onPressed: _resendCode,
                        ),
                      ],
                    ),
                  ],
                ),
              ),

            // Security Tips
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
                        Icons.lightbulb_outline,
                        size: 18,
                        color: infoColor,
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "Security Tips",
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
                        "• Never share your verification code with anyone",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                      Text(
                        "• Code expires in 2 minutes for security",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                      Text(
                        "• Use SMS for faster delivery, Email for backup",
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
