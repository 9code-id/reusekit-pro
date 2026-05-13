import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class FdaOtpVerificationView extends StatefulWidget {
  const FdaOtpVerificationView({super.key});

  @override
  State<FdaOtpVerificationView> createState() => _FdaOtpVerificationViewState();
}

class _FdaOtpVerificationViewState extends State<FdaOtpVerificationView> {
  String otpCode = "";
  String phoneNumber = "+1 (555) 123-4567";
  bool isVerifying = false;
  int countdown = 30;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Verify Phone Number"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            // Header Section
            Container(
              padding: EdgeInsets.all(spLg),
              decoration: BoxDecoration(
                color: primaryColor.withAlpha(10),
                borderRadius: BorderRadius.circular(radiusLg),
              ),
              child: Column(
                spacing: spSm,
                children: [
                  Icon(
                    Icons.sms,
                    size: 64,
                    color: primaryColor,
                  ),
                  Text(
                    "Enter Verification Code",
                    style: TextStyle(
                      fontSize: fsH4,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Text(
                    "We've sent a 6-digit code to $phoneNumber",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: disabledBoldColor,
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
              child: Column(
                spacing: spSm,
                children: [
                  Text(
                    "Enter 6-digit code",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: List.generate(6, (index) {
                      return Container(
                        width: 45,
                        height: 50,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: index < otpCode.length ? primaryColor : disabledBoldColor,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(radiusSm),
                          color: index < otpCode.length ? primaryColor.withAlpha(5) : Colors.white,
                        ),
                        child: Center(
                          child: Text(
                            index < otpCode.length ? otpCode[index] : "",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                        ),
                      );
                    }),
                  ),
                ],
              ),
            ),

            // Keypad
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                spacing: spSm,
                children: [
                  // Numbers 1-3
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildNumberButton("1"),
                      _buildNumberButton("2"),
                      _buildNumberButton("3"),
                    ],
                  ),
                  // Numbers 4-6
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildNumberButton("4"),
                      _buildNumberButton("5"),
                      _buildNumberButton("6"),
                    ],
                  ),
                  // Numbers 7-9
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildNumberButton("7"),
                      _buildNumberButton("8"),
                      _buildNumberButton("9"),
                    ],
                  ),
                  // Clear, 0, Delete
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildActionButton("Clear", Icons.clear),
                      _buildNumberButton("0"),
                      _buildActionButton("Delete", Icons.backspace),
                    ],
                  ),
                ],
              ),
            ),

            // Resend Section
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                spacing: spSm,
                children: [
                  Text(
                    "Didn't receive the code?",
                    style: TextStyle(
                      color: disabledBoldColor,
                    ),
                  ),
                  if (countdown > 0) ...[
                    Text(
                      "Resend code in ${countdown}s",
                      style: TextStyle(
                        color: primaryColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ] else ...[
                    GestureDetector(
                      onTap: _resendCode,
                      child: Text(
                        "Resend Code",
                        style: TextStyle(
                          color: primaryColor,
                          fontWeight: FontWeight.w600,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),

            // Verify Button
            Container(
              width: double.infinity,
              child: QButton(
                label: isVerifying ? "Verifying..." : "Verify & Continue",
                size: bs.md,
                onPressed: otpCode.length == 6 && !isVerifying ? _verifyOTP : null,
              ),
            ),

            // Help Section
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: infoColor.withAlpha(10),
                borderRadius: BorderRadius.circular(radiusMd),
                border: Border.all(color: infoColor.withAlpha(30)),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.info,
                    color: infoColor,
                    size: 20,
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Text(
                      "Having trouble? Contact our support team for assistance.",
                      style: TextStyle(
                        color: infoColor,
                        fontSize: 12,
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

  Widget _buildNumberButton(String number) {
    return GestureDetector(
      onTap: () => _addNumber(number),
      child: Container(
        width: 60,
        height: 60,
        decoration: BoxDecoration(
          color: primaryColor.withAlpha(5),
          borderRadius: BorderRadius.circular(radiusLg),
          border: Border.all(color: primaryColor.withAlpha(30)),
        ),
        child: Center(
          child: Text(
            number,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildActionButton(String action, IconData icon) {
    return GestureDetector(
      onTap: () {
        if (action == "Clear") {
          _clearOTP();
        } else if (action == "Delete") {
          _deleteLastDigit();
        }
      },
      child: Container(
        width: 60,
        height: 60,
        decoration: BoxDecoration(
          color: disabledColor.withAlpha(10),
          borderRadius: BorderRadius.circular(radiusLg),
          border: Border.all(color: disabledBoldColor.withAlpha(30)),
        ),
        child: Center(
          child: Icon(
            icon,
            color: disabledBoldColor,
            size: 20,
          ),
        ),
      ),
    );
  }

  void _addNumber(String number) {
    if (otpCode.length < 6) {
      otpCode += number;
      setState(() {});
    }
  }

  void _deleteLastDigit() {
    if (otpCode.isNotEmpty) {
      otpCode = otpCode.substring(0, otpCode.length - 1);
      setState(() {});
    }
  }

  void _clearOTP() {
    otpCode = "";
    setState(() {});
  }

  void _verifyOTP() async {
    isVerifying = true;
    setState(() {});

    // Simulate verification
    await Future.delayed(Duration(seconds: 2));

    isVerifying = false;
    setState(() {});

    ss("Phone number verified successfully!");
    //navigateTo FdaHomeView
  }

  void _resendCode() {
    countdown = 30;
    setState(() {});
    
    // Start countdown
    _startCountdown();
    
    ss("Verification code sent!");
  }

  void _startCountdown() {
    Future.delayed(Duration(seconds: 1), () {
      if (countdown > 0) {
        countdown--;
        setState(() {});
        _startCountdown();
      }
    });
  }
}
