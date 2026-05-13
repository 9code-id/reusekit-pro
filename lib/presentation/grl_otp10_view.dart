import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';
import 'dart:async';

class GrlOtp10View extends StatefulWidget {
  @override
  State<GrlOtp10View> createState() => _GrlOtp10ViewState();
}

class _GrlOtp10ViewState extends State<GrlOtp10View> {
  String currentOtp = "";
  String newOtp = "";
  String confirmOtp = "";
  
  bool isCurrentOtpVerified = false;
  bool isNewOtpSet = false;
  bool isVerifying = false;
  int attemptsLeft = 3;
  int cooldownSeconds = 0;
  
  Timer? _cooldownTimer;

  List<Map<String, dynamic>> securityTips = [
    {
      "icon": Icons.lock_outline,
      "title": "Use Strong Codes",
      "description": "Choose a 6-digit code that's hard to guess",
    },
    {
      "icon": Icons.visibility_off,
      "title": "Keep It Private",
      "description": "Never share your verification code with anyone",
    },
    {
      "icon": Icons.update,
      "title": "Regular Updates",
      "description": "Change your verification code periodically",
    },
    {
      "icon": Icons.smartphone,
      "title": "Secure Device",
      "description": "Make sure your device is protected with a lock",
    },
  ];

  @override
  void dispose() {
    _cooldownTimer?.cancel();
    super.dispose();
  }

  void _startCooldown() {
    cooldownSeconds = 300; // 5 minutes
    _cooldownTimer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (cooldownSeconds > 0) {
        cooldownSeconds--;
        setState(() {});
      } else {
        attemptsLeft = 3;
        timer.cancel();
        setState(() {});
      }
    });
  }

  String get cooldownDisplay {
    int minutes = cooldownSeconds ~/ 60;
    int seconds = cooldownSeconds % 60;
    return "${minutes}:${seconds.toString().padLeft(2, '0')}";
  }

  void _verifyCurrentOtp() async {
    if (cooldownSeconds > 0) {
      se("Too many failed attempts. Please wait ${cooldownDisplay}");
      return;
    }

    if (currentOtp.length < 6) {
      se("Please enter your current 6-digit code");
      return;
    }

    isVerifying = true;
    setState(() {});

    await Future.delayed(Duration(seconds: 2));

    isVerifying = false;
    setState(() {});

    if (currentOtp == "123456") {
      isCurrentOtpVerified = true;
      setState(() {});
      ss("Current code verified successfully!");
    } else {
      attemptsLeft--;
      if (attemptsLeft <= 0) {
        _startCooldown();
        se("Too many failed attempts. Account temporarily locked.");
      } else {
        se("Invalid code. ${attemptsLeft} attempts remaining.");
      }
      currentOtp = "";
      setState(() {});
    }
  }

  void _setNewOtp() {
    if (newOtp.length < 6) {
      se("Please enter a 6-digit code");
      return;
    }

    if (confirmOtp.length < 6) {
      se("Please confirm your new code");
      return;
    }

    if (newOtp != confirmOtp) {
      se("Codes don't match. Please try again.");
      return;
    }

    if (newOtp == "123456") {
      se("Please choose a different code for security");
      return;
    }

    isNewOtpSet = true;
    setState(() {});
    ss("Verification code updated successfully!");
  }

  void _resetProcess() {
    isCurrentOtpVerified = false;
    isNewOtpSet = false;
    currentOtp = "";
    newOtp = "";
    confirmOtp = "";
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Change Verification Code"),
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
                    isNewOtpSet 
                        ? successColor.withAlpha(15)
                        : primaryColor.withAlpha(15),
                    isNewOtpSet 
                        ? successColor.withAlpha(5)
                        : primaryColor.withAlpha(5),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(radiusLg),
                border: Border.all(
                  color: isNewOtpSet 
                      ? successColor.withAlpha(30)
                      : primaryColor.withAlpha(30),
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
                      color: isNewOtpSet ? successColor : primaryColor,
                      borderRadius: BorderRadius.circular(radiusXl),
                      boxShadow: [shadowMd],
                    ),
                    child: Icon(
                      isNewOtpSet ? Icons.check_circle : Icons.lock_reset,
                      size: 40,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    isNewOtpSet 
                        ? "Code Updated Successfully!" 
                        : "Change Verification Code",
                    style: TextStyle(
                      fontSize: fsH3,
                      fontWeight: FontWeight.bold,
                      color: isNewOtpSet ? successColor : primaryColor,
                    ),
                  ),
                  Text(
                    isNewOtpSet 
                        ? "Your verification code has been changed successfully"
                        : "Update your verification code for enhanced security",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ),
            ),

            // Security Alert
            if (attemptsLeft < 3 && cooldownSeconds <= 0)
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
                    SizedBox(width: spSm),
                    Expanded(
                      child: Text(
                        "${attemptsLeft} verification attempts remaining",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: warningColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

            // Cooldown Alert
            if (cooldownSeconds > 0)
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
                          Icons.timer_off,
                          size: 20,
                          color: dangerColor,
                        ),
                        SizedBox(width: spSm),
                        Text(
                          "Account Temporarily Locked",
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
              ),

            // Step 1: Verify Current Code
            if (!isCurrentOtpVerified && !isNewOtpSet)
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(spLg),
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
                        Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                            color: primaryColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Center(
                            child: Text(
                              "1",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: spSm),
                        Text(
                          "Verify Current Code",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                    Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: infoColor.withAlpha(10),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.info_outline,
                            size: 16,
                            color: infoColor,
                          ),
                          SizedBox(width: spXs),
                          Expanded(
                            child: Text(
                              "Enter your current verification code for security",
                              style: TextStyle(
                                fontSize: 12,
                                color: infoColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    QTextField(
                      label: "Current Verification Code",
                      value: currentOtp,
                      hint: "Enter your current 6-digit code",
                      onChanged: (value) {
                        currentOtp = value;
                        setState(() {});
                      },
                    ),
                    Container(
                      width: double.infinity,
                      child: QButton(
                        label: isVerifying ? "Verifying..." : "Verify Current Code",
                        size: bs.md,
                        color: cooldownSeconds > 0 ? disabledColor : primaryColor,
                        onPressed: (isVerifying || cooldownSeconds > 0) ? null : _verifyCurrentOtp,
                      ),
                    ),
                  ],
                ),
              ),

            // Step 2: Set New Code
            if (isCurrentOtpVerified && !isNewOtpSet)
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
                        Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                            color: primaryColor,
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Icon(
                            Icons.check,
                            size: 20,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(width: spSm),
                        Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                            color: primaryColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Center(
                            child: Text(
                              "2",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: spSm),
                        Text(
                          "Set New Code",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                    QTextField(
                      label: "New Verification Code",
                      value: newOtp,
                      hint: "Enter new 6-digit code",
                      onChanged: (value) {
                        newOtp = value;
                        setState(() {});
                      },
                    ),
                    QTextField(
                      label: "Confirm New Code",
                      value: confirmOtp,
                      hint: "Re-enter new code",
                      onChanged: (value) {
                        confirmOtp = value;
                        setState(() {});
                      },
                    ),
                    if (newOtp.isNotEmpty && confirmOtp.isNotEmpty)
                      Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: newOtp == confirmOtp 
                              ? successColor.withAlpha(10)
                              : dangerColor.withAlpha(10),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              newOtp == confirmOtp ? Icons.check_circle : Icons.error,
                              size: 16,
                              color: newOtp == confirmOtp ? successColor : dangerColor,
                            ),
                            SizedBox(width: spXs),
                            Text(
                              newOtp == confirmOtp ? "Codes match" : "Codes don't match",
                              style: TextStyle(
                                fontSize: 12,
                                color: newOtp == confirmOtp ? successColor : dangerColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    Container(
                      width: double.infinity,
                      child: QButton(
                        label: "Update Verification Code",
                        size: bs.md,
                        onPressed: _setNewOtp,
                      ),
                    ),
                  ],
                ),
              ),

            // Success State
            if (isNewOtpSet)
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
                          Icons.celebration,
                          size: 24,
                          color: successColor,
                        ),
                        SizedBox(width: spSm),
                        Text(
                          "Code Updated Successfully!",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: successColor,
                          ),
                        ),
                      ],
                    ),
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(spMd),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(radiusSm),
                        border: Border.all(
                          color: successColor.withAlpha(30),
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
                                color: successColor,
                              ),
                              SizedBox(width: spXs),
                              Text(
                                "Security Enhanced",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: successColor,
                                ),
                              ),
                            ],
                          ),
                          Text(
                            "Your account security has been enhanced with the new verification code. Keep it safe and secure.",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      spacing: spSm,
                      children: [
                        Expanded(
                          child: QButton(
                            label: "Back to Settings",
                            size: bs.md,
                            color: successColor,
                            onPressed: () {
                              // Navigate back
                            },
                          ),
                        ),
                        QButton(
                          label: "Change Again",
                          size: bs.md,
                          color: disabledBoldColor,
                          onPressed: _resetProcess,
                        ),
                      ],
                    ),
                  ],
                ),
              ),

            // Security Tips
            Container(
              width: double.infinity,
              child: Column(
                spacing: spMd,
                children: [
                  Text(
                    "Security Best Practices",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  ResponsiveGridView(
                    padding: EdgeInsets.zero,
                    minItemWidth: 160,
                    children: securityTips.map((tip) {
                      return Container(
                        padding: EdgeInsets.all(spMd),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(radiusSm),
                          border: Border.all(
                            color: disabledOutlineBorderColor,
                            width: 1,
                          ),
                          boxShadow: [shadowSm],
                        ),
                        child: Column(
                          spacing: spSm,
                          children: [
                            Container(
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                color: infoColor.withAlpha(20),
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Icon(
                                tip["icon"],
                                size: 20,
                                color: infoColor,
                              ),
                            ),
                            Text(
                              tip["title"],
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              tip["description"],
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),

            // Additional Security Options
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
                        Icons.shield_outlined,
                        size: 18,
                        color: warningColor,
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "Additional Security",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: warningColor,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    "Consider enabling two-factor authentication and biometric verification for maximum security.",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
                  Row(
                    spacing: spSm,
                    children: [
                      Expanded(
                        child: QButton(
                          label: "Enable 2FA",
                          size: bs.sm,
                          color: warningColor,
                          onPressed: () {
                            // Navigate to 2FA setup
                          },
                        ),
                      ),
                      Expanded(
                        child: QButton(
                          label: "Biometric Setup",
                          size: bs.sm,
                          color: infoColor,
                          onPressed: () {
                            // Navigate to biometric setup
                          },
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
