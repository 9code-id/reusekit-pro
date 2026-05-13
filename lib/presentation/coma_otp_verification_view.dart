import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class ComaOtpVerificationView extends StatefulWidget {
  const ComaOtpVerificationView({super.key});

  @override
  State<ComaOtpVerificationView> createState() => _ComaOtpVerificationViewState();
}

class _ComaOtpVerificationViewState extends State<ComaOtpVerificationView> {
  String otp1 = "";
  String otp2 = "";
  String otp3 = "";
  String otp4 = "";
  String otp5 = "";
  String otp6 = "";
  
  String email = "john.doe@construction.com";
  bool loading = false;
  int resendTimer = 60;
  bool canResend = false;

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  void startTimer() {
    resendTimer = 60;
    canResend = false;
    setState(() {});
    
    Future.doWhile(() async {
      await Future.delayed(Duration(seconds: 1));
      if (resendTimer > 0) {
        resendTimer--;
        setState(() {});
        return true;
      } else {
        canResend = true;
        setState(() {});
        return false;
      }
    });
  }

  String get fullOtp => otp1 + otp2 + otp3 + otp4 + otp5 + otp6;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Verify Account"),
      ),
      body: loading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: EdgeInsets.all(spMd),
              child: Column(
                spacing: spMd,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: spXl),

                  // Header
                  Column(
                    spacing: spSm,
                    children: [
                      Icon(
                        Icons.shield_outlined,
                        size: 80,
                        color: primaryColor,
                      ),
                      Text(
                        "Verify Your Account",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: fsH1,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "We've sent a 6-digit verification code to",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16,
                          color: disabledBoldColor,
                        ),
                      ),
                      Text(
                        email,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),

                  // OTP Input Fields
                  Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusMd),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      spacing: spSm,
                      children: [
                        Text(
                          "Enter Verification Code",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            _buildOtpField(
                              value: otp1,
                              onChanged: (value) {
                                otp1 = value;
                                setState(() {});
                                if (value.length == 1) {
                                  FocusScope.of(context).nextFocus();
                                }
                              },
                            ),
                            _buildOtpField(
                              value: otp2,
                              onChanged: (value) {
                                otp2 = value;
                                setState(() {});
                                if (value.length == 1) {
                                  FocusScope.of(context).nextFocus();
                                }
                              },
                            ),
                            _buildOtpField(
                              value: otp3,
                              onChanged: (value) {
                                otp3 = value;
                                setState(() {});
                                if (value.length == 1) {
                                  FocusScope.of(context).nextFocus();
                                }
                              },
                            ),
                            _buildOtpField(
                              value: otp4,
                              onChanged: (value) {
                                otp4 = value;
                                setState(() {});
                                if (value.length == 1) {
                                  FocusScope.of(context).nextFocus();
                                }
                              },
                            ),
                            _buildOtpField(
                              value: otp5,
                              onChanged: (value) {
                                otp5 = value;
                                setState(() {});
                                if (value.length == 1) {
                                  FocusScope.of(context).nextFocus();
                                }
                              },
                            ),
                            _buildOtpField(
                              value: otp6,
                              onChanged: (value) {
                                otp6 = value;
                                setState(() {});
                                if (value.length == 1) {
                                  FocusScope.of(context).unfocus();
                                }
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  // Timer and Resend
                  Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: warningColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusMd),
                      border: Border.all(color: warningColor.withAlpha(50)),
                    ),
                    child: Column(
                      spacing: spXs,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.timer,
                              color: warningColor,
                              size: 20,
                            ),
                            SizedBox(width: spSm),
                            Text(
                              canResend 
                                  ? "You can resend the code now"
                                  : "Resend code in ${resendTimer}s",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: canResend ? successColor : warningColor,
                              ),
                            ),
                          ],
                        ),
                        if (canResend)
                          GestureDetector(
                            onTap: () async {
                              loading = true;
                              setState(() {});
                              
                              await Future.delayed(Duration(seconds: 1));
                              
                              loading = false;
                              setState(() {});
                              
                              startTimer();
                              ss("Verification code resent");
                            },
                            child: Text(
                              "Resend Code",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: primaryColor,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),

                  // Security Tips
                  Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: infoColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusMd),
                      border: Border.all(color: infoColor.withAlpha(50)),
                    ),
                    child: Column(
                      spacing: spXs,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.security,
                              color: infoColor,
                              size: 20,
                            ),
                            SizedBox(width: spSm),
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
                        Text(
                          "• Don't share this code with anyone\n• The code expires in 10 minutes\n• If you didn't request this, contact support",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Verify Button
                  Container(
                    width: double.infinity,
                    child: QButton(
                      label: "Verify Account",
                      size: bs.md,
                      onPressed: fullOtp.length == 6 ? () async {
                        loading = true;
                        setState(() {});
                        
                        await Future.delayed(Duration(seconds: 2));
                        
                        if (fullOtp == "123456") {
                          loading = false;
                          setState(() {});
                          
                          ss("Account verified successfully");
                          // ss('Next page'));
                        } else {
                          loading = false;
                          setState(() {});
                          
                          se("Invalid verification code");
                          
                          // Clear OTP fields
                          otp1 = otp2 = otp3 = otp4 = otp5 = otp6 = "";
                          setState(() {});
                        }
                      } : null,
                    ),
                  ),

                  // Alternative Actions
                  Column(
                    spacing: spSm,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Didn't receive the code? ",
                            style: TextStyle(
                              color: disabledBoldColor,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              // Change email/phone
                            },
                            child: Text(
                              "Change Email",
                              style: TextStyle(
                                color: primaryColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Need help? ",
                            style: TextStyle(
                              color: disabledBoldColor,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              // Contact support
                            },
                            child: Text(
                              "Contact Support",
                              style: TextStyle(
                                color: primaryColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
    );
  }

  Widget _buildOtpField({
    required String value,
    required Function(String) onChanged,
  }) {
    return Container(
      width: 45,
      height: 55,
      child: QTextField(
        label: "",
        value: value,
        onChanged: onChanged,
      ),
    );
  }
}
