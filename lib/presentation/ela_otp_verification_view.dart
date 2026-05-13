import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class ElaOtpVerificationView extends StatefulWidget {
  const ElaOtpVerificationView({super.key});

  @override
  State<ElaOtpVerificationView> createState() => _ElaOtpVerificationViewState();
}

class _ElaOtpVerificationViewState extends State<ElaOtpVerificationView> {
  List<String> otpCode = ["", "", "", "", "", ""];
  List<FocusNode> focusNodes = List.generate(6, (index) => FocusNode());
  String email = "user@example.com";
  int resendTimer = 60;
  bool canResend = false;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  void dispose() {
    for (var node in focusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  void _startTimer() {
    Future.delayed(Duration(seconds: 1), () {
      if (mounted) {
        if (resendTimer > 0) {
          resendTimer--;
          setState(() {});
          _startTimer();
        } else {
          canResend = true;
          setState(() {});
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Verify Email"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
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
                      color: primaryColor.withAlpha(20),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.mark_email_unread,
                      size: 50,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spMd),
                  Text(
                    "Verify Your Email",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "We've sent a 6-digit verification code to",
                    textAlign: TextAlign.center,
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
            SizedBox(height: spXl),

            // OTP Input
            Text(
              "Enter Verification Code",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spMd),
            
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(6, (index) {
                return Container(
                  width: 50,
                  height: 60,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: otpCode[index].isNotEmpty 
                        ? primaryColor 
                        : disabledOutlineBorderColor,
                      width: otpCode[index].isNotEmpty ? 2 : 1,
                    ),
                    borderRadius: BorderRadius.circular(radiusMd),
                    color: otpCode[index].isNotEmpty 
                      ? primaryColor.withAlpha(10) 
                      : Colors.white,
                  ),
                  child: TextField(
                    focusNode: focusNodes[index],
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.number,
                    maxLength: 1,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      counterText: "",
                    ),
                    onChanged: (value) {
                      otpCode[index] = value;
                      setState(() {});
                      
                      if (value.isNotEmpty && index < 5) {
                        focusNodes[index + 1].requestFocus();
                      } else if (value.isEmpty && index > 0) {
                        focusNodes[index - 1].requestFocus();
                      }
                      
                      if (otpCode.every((code) => code.isNotEmpty)) {
                        _verifyOtp();
                      }
                    },
                  ),
                );
              }),
            ),
            SizedBox(height: spLg),

            // Verify Button
            Container(
              width: double.infinity,
              child: QButton(
                label: "Verify Code",
                size: bs.md,
                onPressed: otpCode.every((code) => code.isNotEmpty) 
                  ? () {
                      _verifyOtp();
                    }
                  : null,
              ),
            ),
            SizedBox(height: spLg),

            // Resend Section
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.grey.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusMd),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Didn't receive the code?",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),
                      SizedBox(width: spSm),
                      GestureDetector(
                        onTap: canResend ? () {
                          _resendOtp();
                        } : null,
                        child: Text(
                          "Resend Code",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: canResend ? primaryColor : disabledBoldColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  if (!canResend) ...[
                    SizedBox(height: spSm),
                    Text(
                      "You can resend the code in $resendTimer seconds",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ],
              ),
            ),
            SizedBox(height: spLg),

            // Tips
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
                        "Verification Tips",
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
                    "• Check your spam/junk folder\n• Make sure you have a stable internet connection\n• The code expires in 10 minutes\n• Contact support if you continue having issues",
                    style: TextStyle(
                      fontSize: 12,
                      color: primaryColor,
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: spLg),

            // Change Email
            Center(
              child: Column(
                children: [
                  Text(
                    "Wrong email address?",
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
                      "Change Email Address",
                      style: TextStyle(
                        fontSize: 14,
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
    );
  }

  void _verifyOtp() async {
    String code = otpCode.join("");
    
    if (code.length != 6) {
      se("Please enter the complete 6-digit code");
      return;
    }

    showLoading();
    await Future.delayed(Duration(seconds: 2));
    hideLoading();

    if (code == "123456") {
      ss("Email verified successfully!");
      // navigateTo(ElaRoleSelectionView())
    } else {
      se("Invalid verification code. Please try again.");
      // Clear the OTP fields
      for (int i = 0; i < otpCode.length; i++) {
        otpCode[i] = "";
      }
      focusNodes[0].requestFocus();
      setState(() {});
    }
  }

  void _resendOtp() async {
    showLoading();
    await Future.delayed(Duration(seconds: 1));
    hideLoading();

    canResend = false;
    resendTimer = 60;
    setState(() {});
    _startTimer();

    ss("Verification code resent successfully");
  }
}
