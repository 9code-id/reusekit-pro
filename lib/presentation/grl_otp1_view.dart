import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlOtp1View extends StatefulWidget {
  @override
  State<GrlOtp1View> createState() => _GrlOtp1ViewState();
}

class _GrlOtp1ViewState extends State<GrlOtp1View> {
  String otp1 = "";
  String otp2 = "";
  String otp3 = "";
  String otp4 = "";
  String otp5 = "";
  String otp6 = "";
  int resendCountdown = 60;
  bool isResendEnabled = false;

  @override
  void initState() {
    super.initState();
    _startCountdown();
  }

  void _startCountdown() {
    Future.delayed(Duration(seconds: 1), () {
      if (mounted && resendCountdown > 0) {
        resendCountdown--;
        setState(() {});
        _startCountdown();
      } else if (mounted) {
        isResendEnabled = true;
        setState(() {});
      }
    });
  }

  void _verifyOTP() {
    String completeOTP = otp1 + otp2 + otp3 + otp4 + otp5 + otp6;
    if (completeOTP.length == 6) {
      ss("OTP verification successful");
      // Navigate to next screen
    } else {
      se("Please enter complete OTP code");
    }
  }

  void _resendOTP() {
    if (isResendEnabled) {
      resendCountdown = 60;
      isResendEnabled = false;
      setState(() {});
      _startCountdown();
      si("OTP code has been resent");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Verify OTP"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            // Header Section
            Container(
              alignment: Alignment.center,
              child: Column(
                spacing: spSm,
                children: [
                  Container(
                    height: 80,
                    width: 80,
                    decoration: BoxDecoration(
                      color: primaryColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusLg),
                    ),
                    child: Icon(
                      Icons.security,
                      size: 40,
                      color: primaryColor,
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
                  Text(
                    "We've sent a 6-digit verification code to\n+1 (555) 123-4567",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ),
            ),

            // OTP Input Section
            Container(
              padding: EdgeInsets.all(spLg),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Column(
                spacing: spMd,
                children: [
                  Text(
                    "Verification Code",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Row(
                    spacing: spSm,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildOTPField(otp1, (value) {
                        otp1 = value;
                        setState(() {});
                      }),
                      _buildOTPField(otp2, (value) {
                        otp2 = value;
                        setState(() {});
                      }),
                      _buildOTPField(otp3, (value) {
                        otp3 = value;
                        setState(() {});
                      }),
                      _buildOTPField(otp4, (value) {
                        otp4 = value;
                        setState(() {});
                      }),
                      _buildOTPField(otp5, (value) {
                        otp5 = value;
                        setState(() {});
                      }),
                      _buildOTPField(otp6, (value) {
                        otp6 = value;
                        setState(() {});
                      }),
                    ],
                  ),
                ],
              ),
            ),

            // Resend Section
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.grey[50],
                borderRadius: BorderRadius.circular(radiusSm),
                border: Border.all(
                  color: disabledOutlineBorderColor,
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
                        "Didn't receive the code?",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),
                      if (!isResendEnabled)
                        Text(
                          "Resend available in ${resendCountdown}s",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledColor,
                          ),
                        ),
                    ],
                  ),
                  QButton(
                    label: "Resend Code",
                    size: bs.sm,
                    color: isResendEnabled ? primaryColor : disabledColor,
                    onPressed: isResendEnabled ? _resendOTP : null,
                  ),
                ],
              ),
            ),

            // Verify Button
            Container(
              width: double.infinity,
              child: QButton(
                label: "Verify Code",
                size: bs.md,
                onPressed: _verifyOTP,
              ),
            ),

            // Help Section
            Container(
              padding: EdgeInsets.all(spMd),
              child: Column(
                spacing: spSm,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.info_outline,
                        size: 16,
                        color: infoColor,
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "Having trouble?",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: infoColor,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    "Make sure your phone has signal and try again. Contact support if the issue persists.",
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

  Widget _buildOTPField(String value, Function(String) onChanged) {
    return Container(
      width: 45,
      height: 50,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(
          color: value.isNotEmpty ? primaryColor : disabledOutlineBorderColor,
          width: value.isNotEmpty ? 2 : 1,
        ),
      ),
      child: TextField(
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        maxLength: 1,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: primaryColor,
        ),
        decoration: InputDecoration(
          counterText: "",
          border: InputBorder.none,
          contentPadding: EdgeInsets.zero,
        ),
        onChanged: (val) {
          if (val.length <= 1) {
            onChanged(val);
            if (val.length == 1) {
              FocusScope.of(context).nextFocus();
            }
          }
        },
      ),
    );
  }
}
