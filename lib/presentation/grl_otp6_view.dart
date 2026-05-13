import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';
import 'dart:async';

class GrlOtp6View extends StatefulWidget {
  @override
  State<GrlOtp6View> createState() => _GrlOtp6ViewState();
}

class _GrlOtp6ViewState extends State<GrlOtp6View> {
  String phoneNumber = "";
  String otpCode = "";
  bool isPhoneVerified = false;
  bool isOtpSent = false;
  bool isVerifying = false;
  int countdown = 0;
  Timer? _timer;

  List<String> countryCodes = [
    "+1", "+44", "+91", "+86", "+81", "+33", "+49", "+39", "+34", "+7"
  ];
  String selectedCountryCode = "+1";

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _startCountdown() {
    countdown = 60;
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (countdown > 0) {
        countdown--;
        setState(() {});
      } else {
        timer.cancel();
        setState(() {});
      }
    });
  }

  void _sendOtp() async {
    if (!_isValidPhoneNumber()) {
      se("Please enter a valid phone number");
      return;
    }

    showLoading();
    await Future.delayed(Duration(seconds: 2));
    hideLoading();

    isOtpSent = true;
    setState(() {});
    _startCountdown();
    
    si("OTP sent to ${selectedCountryCode} ${phoneNumber}");
  }

  bool _isValidPhoneNumber() {
    return phoneNumber.isNotEmpty && phoneNumber.length >= 10;
  }

  void _verifyOtp() async {
    if (otpCode.length < 6) {
      se("Please enter the complete 6-digit OTP");
      return;
    }

    isVerifying = true;
    setState(() {});

    await Future.delayed(Duration(seconds: 3));

    isVerifying = false;
    setState(() {});

    if (otpCode == "123456") {
      isPhoneVerified = true;
      _timer?.cancel();
      setState(() {});
      ss("Phone number verified successfully!");
    } else {
      se("Invalid OTP. Please try again.");
      otpCode = "";
      setState(() {});
    }
  }

  void _resendOtp() {
    if (countdown > 0) {
      sw("Please wait ${countdown} seconds before resending");
      return;
    }
    
    _sendOtp();
  }

  void _editPhoneNumber() {
    isOtpSent = false;
    isPhoneVerified = false;
    otpCode = "";
    _timer?.cancel();
    setState(() {});
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
            // Header
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
                        colors: [
                          isPhoneVerified ? successColor : primaryColor,
                          isPhoneVerified ? successColor.withAlpha(200) : primaryColor.withAlpha(200),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(radiusXl),
                      boxShadow: [shadowLg],
                    ),
                    child: Icon(
                      isPhoneVerified ? Icons.verified : Icons.smartphone,
                      size: 50,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    isPhoneVerified 
                        ? "Phone Verified!" 
                        : isOtpSent 
                            ? "Verify Your Phone" 
                            : "Add Your Phone Number",
                    style: TextStyle(
                      fontSize: fsH3,
                      fontWeight: FontWeight.bold,
                      color: isPhoneVerified ? successColor : primaryColor,
                    ),
                  ),
                  Text(
                    isPhoneVerified 
                        ? "Your phone number has been successfully verified"
                        : isOtpSent 
                            ? "Enter the code we sent to your phone" 
                            : "We'll send you a verification code via SMS",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ),
            ),

            // Phone Number Input (Step 1)
            if (!isOtpSent)
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
                        Icon(
                          Icons.phone,
                          size: 20,
                          color: primaryColor,
                        ),
                        SizedBox(width: spXs),
                        Text(
                          "Enter Phone Number",
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
                        Container(
                          width: 80,
                          child: QDropdownField(
                            label: "Code",
                            value: selectedCountryCode,
                            items: countryCodes.map((code) => {
                              "label": code,
                              "value": code,
                            }).toList(),
                            onChanged: (value, label) {
                              selectedCountryCode = value;
                              setState(() {});
                            },
                          ),
                        ),
                        Expanded(
                          child: QTextField(
                            label: "Phone Number",
                            value: phoneNumber,
                            hint: "Enter your phone number",
                            onChanged: (value) {
                              phoneNumber = value;
                              setState(() {});
                            },
                          ),
                        ),
                      ],
                    ),
                    Container(
                      width: double.infinity,
                      child: QButton(
                        label: "Send Verification Code",
                        size: bs.md,
                        onPressed: _sendOtp,
                      ),
                    ),
                  ],
                ),
              ),

            // Phone Number Display + Edit (Step 2)
            if (isOtpSent && !isPhoneVerified)
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: primaryColor.withAlpha(10),
                  borderRadius: BorderRadius.circular(radiusSm),
                  border: Border.all(
                    color: primaryColor.withAlpha(30),
                    width: 1,
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Code sent to:",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                        Text(
                          "${selectedCountryCode} ${phoneNumber}",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                    QButton(
                      label: "Edit",
                      size: bs.sm,
                      color: secondaryColor,
                      onPressed: _editPhoneNumber,
                    ),
                  ],
                ),
              ),

            // OTP Input (Step 2)
            if (isOtpSent && !isPhoneVerified)
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
                              Icons.verified_user,
                              size: 20,
                              color: primaryColor,
                            ),
                            SizedBox(width: spXs),
                            Text(
                              "Verification Code",
                              style: TextStyle(
                                fontSize: fsH6,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                          ],
                        ),
                        if (countdown > 0)
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: spSm,
                              vertical: spXs,
                            ),
                            decoration: BoxDecoration(
                              color: warningColor.withAlpha(10),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Text(
                              "Resend in ${countdown}s",
                              style: TextStyle(
                                fontSize: 12,
                                color: warningColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                      ],
                    ),
                    QTextField(
                      label: "Enter 6-digit code",
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
                            label: isVerifying ? "Verifying..." : "Verify Code",
                            size: bs.md,
                            onPressed: isVerifying ? null : _verifyOtp,
                          ),
                        ),
                        QButton(
                          label: countdown > 0 ? "Resend" : "Resend Code",
                          size: bs.md,
                          color: countdown > 0 ? disabledColor : secondaryColor,
                          onPressed: _resendOtp,
                        ),
                      ],
                    ),
                  ],
                ),
              ),

            // Success State
            if (isPhoneVerified)
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
                          "Verification Complete",
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
                                Icons.verified,
                                size: 18,
                                color: successColor,
                              ),
                              SizedBox(width: spXs),
                              Text(
                                "Verified Phone Number",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                          Text(
                            "${selectedCountryCode} ${phoneNumber}",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
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
                            label: "Continue",
                            size: bs.md,
                            color: successColor,
                            onPressed: () {
                              // Navigate to next screen
                            },
                          ),
                        ),
                        QButton(
                          label: "Change Number",
                          size: bs.md,
                          color: disabledBoldColor,
                          onPressed: _editPhoneNumber,
                        ),
                      ],
                    ),
                  ],
                ),
              ),

            // Benefits Section
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
                        Icons.security,
                        size: 18,
                        color: infoColor,
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "Phone Verification Benefits",
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
                      Row(
                        children: [
                          Icon(
                            Icons.check_circle_outline,
                            size: 14,
                            color: successColor,
                          ),
                          SizedBox(width: spXs),
                          Text(
                            "Enhanced account security",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.check_circle_outline,
                            size: 14,
                            color: successColor,
                          ),
                          SizedBox(width: spXs),
                          Text(
                            "Instant notifications and alerts",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.check_circle_outline,
                            size: 14,
                            color: successColor,
                          ),
                          SizedBox(width: spXs),
                          Text(
                            "Easy account recovery options",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
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
