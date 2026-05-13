import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';
import 'dart:async';

class GrlOtp5View extends StatefulWidget {
  @override
  State<GrlOtp5View> createState() => _GrlOtp5ViewState();
}

class _GrlOtp5ViewState extends State<GrlOtp5View> {
  String otpCode = "";
  bool isLoading = false;
  bool showSuccess = false;
  bool showError = false;
  String errorMessage = "";
  int stepIndex = 0;

  List<Map<String, dynamic>> verificationSteps = [
    {
      "title": "Sending Code",
      "description": "We're sending a verification code to your device",
      "icon": Icons.send,
      "completed": false,
    },
    {
      "title": "Code Sent",
      "description": "Check your messages for the verification code",
      "icon": Icons.message,
      "completed": false,
    },
    {
      "title": "Enter Code",
      "description": "Enter the 6-digit code you received",
      "icon": Icons.dialpad,
      "completed": false,
    },
    {
      "title": "Verification",
      "description": "We're verifying your code",
      "icon": Icons.verified_user,
      "completed": false,
    },
  ];

  @override
  void initState() {
    super.initState();
    _startVerificationProcess();
  }

  void _startVerificationProcess() async {
    // Step 1: Sending Code
    stepIndex = 0;
    setState(() {});
    await Future.delayed(Duration(seconds: 2));
    
    verificationSteps[0]["completed"] = true;
    stepIndex = 1;
    setState(() {});
    await Future.delayed(Duration(seconds: 1));
    
    // Step 2: Code Sent
    verificationSteps[1]["completed"] = true;
    stepIndex = 2;
    setState(() {});
  }

  void _verifyCode() async {
    if (otpCode.length < 6) {
      _showError("Please enter the complete 6-digit code");
      return;
    }

    // Step 3: Enter Code completed
    verificationSteps[2]["completed"] = true;
    stepIndex = 3;
    isLoading = true;
    setState(() {});

    await Future.delayed(Duration(seconds: 3));

    if (otpCode == "123456") {
      // Step 4: Verification completed
      verificationSteps[3]["completed"] = true;
      isLoading = false;
      showSuccess = true;
      setState(() {});
      
      await Future.delayed(Duration(seconds: 2));
      // Navigate to next screen
      ss("Account verified successfully!");
    } else {
      isLoading = false;
      stepIndex = 2;
      _showError("Invalid verification code. Please try again.");
    }
  }

  void _showError(String message) {
    errorMessage = message;
    showError = true;
    setState(() {});
    
    Future.delayed(Duration(seconds: 3), () {
      showError = false;
      setState(() {});
    });
  }

  void _resendCode() async {
    showLoading();
    await Future.delayed(Duration(seconds: 2));
    hideLoading();
    
    otpCode = "";
    showError = false;
    
    // Reset steps
    for (var step in verificationSteps) {
      step["completed"] = false;
    }
    
    setState(() {});
    _startVerificationProcess();
    si("New verification code has been sent");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Account Verification"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spLg,
          children: [
            // Progress Header
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
              ),
              child: Column(
                spacing: spMd,
                children: [
                  if (showSuccess)
                    Container(
                      height: 80,
                      width: 80,
                      decoration: BoxDecoration(
                        color: successColor,
                        borderRadius: BorderRadius.circular(radiusXl),
                        boxShadow: [shadowMd],
                      ),
                      child: Icon(
                        Icons.check_circle,
                        size: 40,
                        color: Colors.white,
                      ),
                    )
                  else
                    Container(
                      height: 80,
                      width: 80,
                      decoration: BoxDecoration(
                        color: primaryColor,
                        borderRadius: BorderRadius.circular(radiusXl),
                        boxShadow: [shadowMd],
                      ),
                      child: Icon(
                        Icons.shield,
                        size: 40,
                        color: Colors.white,
                      ),
                    ),
                  Text(
                    showSuccess ? "Verification Complete!" : "Verification in Progress",
                    style: TextStyle(
                      fontSize: fsH4,
                      fontWeight: FontWeight.bold,
                      color: showSuccess ? successColor : primaryColor,
                    ),
                  ),
                  if (!showSuccess)
                    Text(
                      "Step ${stepIndex + 1} of ${verificationSteps.length}",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                ],
              ),
            ),

            // Verification Steps
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Column(
                spacing: spSm,
                children: verificationSteps.asMap().entries.map((entry) {
                  int index = entry.key;
                  Map<String, dynamic> step = entry.value;
                  bool isActive = index == stepIndex;
                  bool isCompleted = step["completed"];
                  bool isUpcoming = index > stepIndex;

                  return Container(
                    padding: EdgeInsets.all(spMd),
                    decoration: BoxDecoration(
                      color: isActive 
                          ? primaryColor.withAlpha(10)
                          : isCompleted 
                              ? successColor.withAlpha(10)
                              : Colors.grey[50],
                      borderRadius: BorderRadius.circular(radiusSm),
                      border: Border.all(
                        color: isActive 
                            ? primaryColor.withAlpha(50)
                            : isCompleted 
                                ? successColor.withAlpha(50)
                                : disabledOutlineBorderColor,
                        width: 1,
                      ),
                    ),
                    child: Row(
                      children: [
                        Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                            color: isCompleted 
                                ? successColor 
                                : isActive 
                                    ? primaryColor 
                                    : disabledColor,
                            borderRadius: BorderRadius.circular(radiusLg),
                          ),
                          child: Icon(
                            isCompleted 
                                ? Icons.check 
                                : isActive && isLoading
                                    ? Icons.hourglass_empty
                                    : step["icon"],
                            size: 20,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(width: spMd),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                step["title"],
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: isCompleted 
                                      ? successColor 
                                      : isActive 
                                          ? primaryColor 
                                          : disabledBoldColor,
                                ),
                              ),
                              Text(
                                step["description"],
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        if (isActive && isLoading)
                          Container(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
                            ),
                          ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),

            // Error Message
            if (showError)
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
                child: Row(
                  children: [
                    Icon(
                      Icons.error_outline,
                      size: 20,
                      color: dangerColor,
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: Text(
                        errorMessage,
                        style: TextStyle(
                          fontSize: 14,
                          color: dangerColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

            // OTP Input (Show only at step 2)
            if (stepIndex >= 2 && !showSuccess)
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
                          Icons.pin,
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
                      label: "6-digit verification code",
                      value: otpCode,
                      hint: "123456",
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
                            label: isLoading ? "Verifying..." : "Verify Code",
                            size: bs.md,
                            onPressed: isLoading ? null : _verifyCode,
                          ),
                        ),
                        QButton(
                          label: "Resend",
                          size: bs.md,
                          color: secondaryColor,
                          onPressed: stepIndex == 2 ? _resendCode : null,
                        ),
                      ],
                    ),
                  ],
                ),
              ),

            // Success Message
            if (showSuccess)
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(spLg),
                decoration: BoxDecoration(
                  color: successColor.withAlpha(10),
                  borderRadius: BorderRadius.circular(radiusLg),
                  border: Border.all(
                    color: successColor.withAlpha(50),
                    width: 1,
                  ),
                ),
                child: Column(
                  spacing: spMd,
                  children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.celebration,
                        size: 24,
                        color: successColor,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "Account Successfully Verified!",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: successColor,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    "Your account has been verified and is now active. You can now access all features.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      color: disabledBoldColor,
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    child: QButton(
                      label: "Continue to Dashboard",
                      size: bs.md,
                      color: successColor,
                      onPressed: () {
                        // Navigate to dashboard
                      },
                    ),
                  ),
                ],
              ),
            ),

            // Help Section
            if (!showSuccess)
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
                          "Need Help?",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: infoColor,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      "If you don't receive the code within 5 minutes, check your spam folder or contact our support team.",
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
    );
  }
}
