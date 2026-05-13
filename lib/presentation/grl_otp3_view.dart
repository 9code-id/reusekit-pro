import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlOtp3View extends StatefulWidget {
  @override
  State<GrlOtp3View> createState() => _GrlOtp3ViewState();
}

class _GrlOtp3ViewState extends State<GrlOtp3View> {
  String phoneNumber = "+1 (555) 123-4567";
  String enteredOtp = "";
  int attempts = 0;
  int maxAttempts = 3;
  int cooldownTime = 0;
  bool isBlocked = false;
  bool isVerifying = false;

  List<String> otpDigits = ["", "", "", "", "", ""];
  List<FocusNode> focusNodes = [];

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < 6; i++) {
      focusNodes.add(FocusNode());
    }
  }

  @override
  void dispose() {
    for (var node in focusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  void _startCooldown() {
    cooldownTime = 300; // 5 minutes
    isBlocked = true;
    setState(() {});
    
    Timer.periodic(Duration(seconds: 1), (timer) {
      if (cooldownTime > 0) {
        cooldownTime--;
        setState(() {});
      } else {
        isBlocked = false;
        attempts = 0;
        timer.cancel();
        setState(() {});
      }
    });
  }

  String get cooldownDisplay {
    int minutes = cooldownTime ~/ 60;
    int seconds = cooldownTime % 60;
    return "${minutes}:${seconds.toString().padLeft(2, '0')}";
  }

  void _verifyOtp() async {
    if (isBlocked) {
      se("Too many failed attempts. Please wait ${cooldownDisplay}");
      return;
    }

    enteredOtp = otpDigits.join();
    if (enteredOtp.length != 6) {
      se("Please enter all 6 digits");
      return;
    }

    isVerifying = true;
    setState(() {});

    await Future.delayed(Duration(seconds: 2));

    isVerifying = false;
    setState(() {});

    if (enteredOtp == "123456") {
      ss("Phone number verified successfully!");
      // Navigate to success screen
    } else {
      attempts++;
      se("Invalid OTP. ${maxAttempts - attempts} attempts remaining");
      
      if (attempts >= maxAttempts) {
        _startCooldown();
      }
      
      // Clear OTP fields
      for (int i = 0; i < otpDigits.length; i++) {
        otpDigits[i] = "";
      }
      setState(() {});
      
      // Focus on first field
      if (focusNodes.isNotEmpty) {
        focusNodes[0].requestFocus();
      }
    }
  }

  void _resendOtp() async {
    if (isBlocked) {
      se("Please wait ${cooldownDisplay} before requesting new code");
      return;
    }

    showLoading();
    await Future.delayed(Duration(seconds: 2));
    hideLoading();
    
    si("New verification code sent to ${phoneNumber}");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Phone Verification"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spLg,
          children: [
            // Header with Phone Icon
            Container(
              width: double.infinity,
              child: Column(
                spacing: spMd,
                children: [
                  Container(
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [primaryColor, secondaryColor],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(radiusXl),
                      boxShadow: [shadowMd],
                    ),
                    child: Icon(
                      Icons.phone_android,
                      size: 50,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    "Enter Verification Code",
                    style: TextStyle(
                      fontSize: fsH3,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: spMd,
                      vertical: spSm,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.phone,
                          size: 16,
                          color: primaryColor,
                        ),
                        SizedBox(width: spXs),
                        Text(
                          phoneNumber,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Status Card
            if (isBlocked)
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: dangerColor.withAlpha(10),
                  borderRadius: BorderRadius.circular(radiusSm),
                  border: Border.all(
                    color: dangerColor.withAlpha(50),
                    width: 1,
                  ),
                ),
                child: Column(
                  spacing: spSm,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.block,
                          size: 20,
                          color: dangerColor,
                        ),
                        SizedBox(width: spXs),
                        Text(
                          "Account Temporarily Blocked",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: dangerColor,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      "Too many failed attempts. Please wait ${cooldownDisplay} before trying again.",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              )
            else if (attempts > 0)
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: warningColor.withAlpha(10),
                  borderRadius: BorderRadius.circular(radiusSm),
                  border: Border.all(
                    color: warningColor.withAlpha(50),
                    width: 1,
                  ),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.warning_amber,
                      size: 20,
                      color: warningColor,
                    ),
                    SizedBox(width: spXs),
                    Text(
                      "${maxAttempts - attempts} attempts remaining",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: warningColor,
                      ),
                    ),
                  ],
                ),
              ),

            // OTP Input Fields
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
                  Text(
                    "Enter 6-digit code",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Row(
                    spacing: spSm,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: List.generate(6, (index) {
                      return Container(
                        width: 50,
                        height: 60,
                        decoration: BoxDecoration(
                          color: Colors.grey[50],
                          borderRadius: BorderRadius.circular(radiusSm),
                          border: Border.all(
                            color: otpDigits[index].isNotEmpty 
                                ? primaryColor 
                                : isBlocked 
                                    ? dangerColor.withAlpha(50)
                                    : disabledOutlineBorderColor,
                            width: otpDigits[index].isNotEmpty ? 2 : 1,
                          ),
                        ),
                        child: TextField(
                          focusNode: focusNodes[index],
                          textAlign: TextAlign.center,
                          keyboardType: TextInputType.number,
                          maxLength: 1,
                          enabled: !isBlocked,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                          decoration: InputDecoration(
                            counterText: "",
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.zero,
                          ),
                          onChanged: (value) {
                            if (value.length <= 1) {
                              otpDigits[index] = value;
                              setState(() {});
                              
                              if (value.length == 1 && index < 5) {
                                focusNodes[index + 1].requestFocus();
                              }
                              
                              if (value.isEmpty && index > 0) {
                                focusNodes[index - 1].requestFocus();
                              }
                            }
                          },
                        ),
                      );
                    }),
                  ),
                  Container(
                    width: double.infinity,
                    child: QButton(
                      label: isVerifying ? "Verifying..." : "Verify Code",
                      size: bs.md,
                      color: isBlocked ? disabledColor : primaryColor,
                      onPressed: isBlocked || isVerifying ? null : _verifyOtp,
                    ),
                  ),
                ],
              ),
            ),

            // Resend Section
            if (!isBlocked)
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
                      "Didn't receive the code?",
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
                          label: "Resend SMS",
                          size: bs.sm,
                          onPressed: _resendOtp,
                        ),
                        QButton(
                          label: "Call Me",
                          size: bs.sm,
                          color: secondaryColor,
                          onPressed: () {
                            si("Voice call initiated to ${phoneNumber}");
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),

            // Security Notice
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
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.security,
                    size: 18,
                    color: infoColor,
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: spXs,
                      children: [
                        Text(
                          "Security Notice",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: infoColor,
                          ),
                        ),
                        Text(
                          "For your security, this code will expire in 10 minutes. Never share this code with anyone.",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
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
