import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';
import 'dart:async';

class GrlOtp7View extends StatefulWidget {
  @override
  State<GrlOtp7View> createState() => _GrlOtp7ViewState();
}

class _GrlOtp7ViewState extends State<GrlOtp7View> {
  String userEmail = "sarah.johnson@example.com";
  String backupEmail = "";
  String otpCode = "";
  String selectedMethod = "email";
  
  bool isCodeSent = false;
  bool isVerifying = false;
  bool isVerified = false;
  int resendTimer = 0;
  
  Timer? _timer;

  List<Map<String, dynamic>> verificationMethods = [
    {
      "id": "email",
      "title": "Primary Email",
      "subtitle": "sarah.johnson@example.com",
      "icon": Icons.email,
      "description": "Send code to your registered email address",
      "enabled": true,
    },
    {
      "id": "backup_email",
      "title": "Backup Email",
      "subtitle": "Enter backup email address",
      "icon": Icons.alternate_email,
      "description": "Send code to an alternate email address",
      "enabled": false,
    },
    {
      "id": "support",
      "title": "Contact Support",
      "subtitle": "Get help from our team",
      "icon": Icons.support_agent,
      "description": "Manual verification via support team",
      "enabled": true,
    },
  ];

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _startResendTimer() {
    resendTimer = 180; // 3 minutes
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (resendTimer > 0) {
        resendTimer--;
        setState(() {});
      } else {
        timer.cancel();
        setState(() {});
      }
    });
  }

  String get resendTimerDisplay {
    int minutes = resendTimer ~/ 60;
    int seconds = resendTimer % 60;
    return "${minutes}:${seconds.toString().padLeft(2, '0')}";
  }

  void _selectMethod(String methodId) {
    selectedMethod = methodId;
    isCodeSent = false;
    otpCode = "";
    _timer?.cancel();
    setState(() {});
  }

  void _sendVerificationCode() async {
    if (selectedMethod == "backup_email" && backupEmail.isEmpty) {
      se("Please enter your backup email address");
      return;
    }

    if (selectedMethod == "support") {
      si("Support ticket created. Our team will contact you within 24 hours.");
      return;
    }

    showLoading();
    await Future.delayed(Duration(seconds: 2));
    hideLoading();

    isCodeSent = true;
    setState(() {});
    _startResendTimer();

    String target = selectedMethod == "email" ? userEmail : backupEmail;
    si("Verification code sent to ${target}");
  }

  void _verifyCode() async {
    if (otpCode.length < 6) {
      se("Please enter the complete 6-digit code");
      return;
    }

    isVerifying = true;
    setState(() {});

    await Future.delayed(Duration(seconds: 3));

    isVerifying = false;
    setState(() {});

    if (otpCode == "123456") {
      isVerified = true;
      _timer?.cancel();
      setState(() {});
      ss("Account recovery verified successfully!");
    } else {
      se("Invalid verification code. Please check and try again.");
      otpCode = "";
      setState(() {});
    }
  }

  void _resendCode() {
    if (resendTimer > 0) {
      sw("Please wait ${resendTimerDisplay} before requesting a new code");
      return;
    }
    
    _sendVerificationCode();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Account Recovery"),
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
                    isVerified 
                        ? successColor.withAlpha(15)
                        : warningColor.withAlpha(15),
                    isVerified 
                        ? successColor.withAlpha(5)
                        : warningColor.withAlpha(5),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(radiusLg),
                border: Border.all(
                  color: isVerified 
                      ? successColor.withAlpha(30)
                      : warningColor.withAlpha(30),
                  width: 1,
                ),
              ),
              child: Column(
                spacing: spMd,
                children: [
                  Container(
                    height: 80,
                    width: 80,
                    decoration: BoxDecoration(
                      color: isVerified ? successColor : warningColor,
                      borderRadius: BorderRadius.circular(radiusXl),
                      boxShadow: [shadowMd],
                    ),
                    child: Icon(
                      isVerified ? Icons.verified_user : Icons.lock_reset,
                      size: 40,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    isVerified 
                        ? "Recovery Successful!" 
                        : "Account Recovery",
                    style: TextStyle(
                      fontSize: fsH3,
                      fontWeight: FontWeight.bold,
                      color: isVerified ? successColor : warningColor,
                    ),
                  ),
                  Text(
                    isVerified 
                        ? "Your account access has been restored"
                        : "Let's help you regain access to your account",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ),
            ),

            // Verification Methods (Step 1)
            if (!isCodeSent && !isVerified)
              Container(
                width: double.infinity,
                child: Column(
                  spacing: spMd,
                  children: [
                    Text(
                      "Choose Recovery Method",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    ...verificationMethods.map((method) {
                      bool isSelected = selectedMethod == method["id"];
                      bool isEnabled = method["enabled"];
                      
                      return GestureDetector(
                        onTap: isEnabled ? () => _selectMethod(method["id"]) : null,
                        child: Container(
                          width: double.infinity,
                          padding: EdgeInsets.all(spMd),
                          decoration: BoxDecoration(
                            color: isEnabled 
                                ? isSelected 
                                    ? primaryColor.withAlpha(10)
                                    : Colors.white
                                : Colors.grey[100],
                            borderRadius: BorderRadius.circular(radiusSm),
                            border: Border.all(
                              color: isEnabled 
                                  ? isSelected 
                                      ? primaryColor 
                                      : disabledOutlineBorderColor
                                  : disabledColor,
                              width: isSelected ? 2 : 1,
                            ),
                          ),
                          child: Row(
                            children: [
                              Container(
                                height: 50,
                                width: 50,
                                decoration: BoxDecoration(
                                  color: isEnabled 
                                      ? isSelected 
                                          ? primaryColor 
                                          : disabledBoldColor
                                      : disabledColor,
                                  borderRadius: BorderRadius.circular(radiusSm),
                                ),
                                child: Icon(
                                  method["icon"],
                                  size: 24,
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(width: spMd),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      method["title"],
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: isEnabled ? primaryColor : disabledColor,
                                      ),
                                    ),
                                    Text(
                                      method["subtitle"],
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                    SizedBox(height: spXs),
                                    Text(
                                      method["description"],
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: disabledColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              if (isSelected)
                                Icon(
                                  Icons.check_circle,
                                  size: 24,
                                  color: primaryColor,
                                ),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  ],
                ),
              ),

            // Backup Email Input
            if (!isCodeSent && selectedMethod == "backup_email" && !isVerified)
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusSm),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  spacing: spSm,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.alternate_email,
                          size: 18,
                          color: primaryColor,
                        ),
                        SizedBox(width: spXs),
                        Text(
                          "Backup Email Address",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                    QTextField(
                      label: "Enter backup email",
                      value: backupEmail,
                      hint: "backup@example.com",
                      onChanged: (value) {
                        backupEmail = value;
                        setState(() {});
                      },
                    ),
                  ],
                ),
              ),

            // Send Code Button
            if (!isCodeSent && !isVerified)
              Container(
                width: double.infinity,
                child: QButton(
                  label: selectedMethod == "support" 
                      ? "Contact Support Team" 
                      : "Send Verification Code",
                  size: bs.md,
                  onPressed: _sendVerificationCode,
                ),
              ),

            // Code Input Section (Step 2)
            if (isCodeSent && !isVerified)
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
                              Icons.mark_email_read,
                              size: 20,
                              color: primaryColor,
                            ),
                            SizedBox(width: spXs),
                            Text(
                              "Enter Recovery Code",
                              style: TextStyle(
                                fontSize: fsH6,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                          ],
                        ),
                        if (resendTimer > 0)
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: spSm,
                              vertical: spXs,
                            ),
                            decoration: BoxDecoration(
                              color: infoColor.withAlpha(10),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Text(
                              resendTimerDisplay,
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: infoColor,
                              ),
                            ),
                          ),
                      ],
                    ),
                    Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: primaryColor.withAlpha(10),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.info_outline,
                            size: 16,
                            color: primaryColor,
                          ),
                          SizedBox(width: spXs),
                          Expanded(
                            child: Text(
                              "Code sent to: ${selectedMethod == "email" ? userEmail : backupEmail}",
                              style: TextStyle(
                                fontSize: 12,
                                color: primaryColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    QTextField(
                      label: "Recovery Code",
                      value: otpCode,
                      hint: "Enter 6-digit code",
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
                            label: isVerifying ? "Verifying..." : "Verify Code",
                            size: bs.md,
                            onPressed: isVerifying ? null : _verifyCode,
                          ),
                        ),
                        QButton(
                          label: resendTimer > 0 ? "Resend" : "Resend Code",
                          size: bs.md,
                          color: resendTimer > 0 ? disabledColor : secondaryColor,
                          onPressed: _resendCode,
                        ),
                      ],
                    ),
                  ],
                ),
              ),

            // Success Section
            if (isVerified)
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
                      children: [
                        Icon(
                          Icons.check_circle,
                          size: 24,
                          color: successColor,
                        ),
                        SizedBox(width: spSm),
                        Text(
                          "Account Recovered Successfully",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: successColor,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      "Your account access has been restored. You can now reset your password or continue with your account.",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                    Row(
                      spacing: spSm,
                      children: [
                        Expanded(
                          child: QButton(
                            label: "Reset Password",
                            size: bs.md,
                            color: successColor,
                            onPressed: () {
                              // Navigate to password reset
                            },
                          ),
                        ),
                        QButton(
                          label: "Continue",
                          size: bs.md,
                          color: primaryColor,
                          onPressed: () {
                            // Navigate to dashboard
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
                color: warningColor.withAlpha(10),
                borderRadius: BorderRadius.circular(radiusSm),
                border: Border.all(
                  color: warningColor.withAlpha(30),
                  width: 1,
                ),
              ),
              child: Column(
                spacing: spSm,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.security,
                        size: 18,
                        color: warningColor,
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "Security Reminder",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: warningColor,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    "After recovering your account, we recommend updating your password and reviewing your security settings to ensure your account remains secure.",
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
