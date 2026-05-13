import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class TtaOtpVerificationView extends StatefulWidget {
  const TtaOtpVerificationView({super.key});

  @override
  State<TtaOtpVerificationView> createState() => _TtaOtpVerificationViewState();
}

class _TtaOtpVerificationViewState extends State<TtaOtpVerificationView> {
  String otp1 = "";
  String otp2 = "";
  String otp3 = "";
  String otp4 = "";
  String otp5 = "";
  String otp6 = "";
  
  bool loading = false;
  int resendTimer = 60;
  Timer? timer;
  String phoneNumber = "+1 (555) 123-4567";

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  void startTimer() {
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (resendTimer > 0) {
        setState(() {
          resendTimer--;
        });
      } else {
        timer.cancel();
      }
    });
  }

  String get fullOtp => otp1 + otp2 + otp3 + otp4 + otp5 + otp6;

  bool get isOtpComplete => fullOtp.length == 6;

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
            SizedBox(height: sp2xl),
            
            // Icon
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: primaryColor,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowMd],
              ),
              child: Icon(
                Icons.sms,
                size: 50,
                color: Colors.white,
              ),
            ),
            
            Text(
              "Verification Code",
              style: TextStyle(
                fontSize: fsH2,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            
            Text(
              "We've sent a 6-digit verification code to",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: disabledBoldColor,
              ),
            ),
            
            Text(
              phoneNumber,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            
            SizedBox(height: spXl),
            
            // OTP Input Fields
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildOtpField(otp1, (value) {
                  otp1 = value;
                  setState(() {});
                }),
                _buildOtpField(otp2, (value) {
                  otp2 = value;
                  setState(() {});
                }),
                _buildOtpField(otp3, (value) {
                  otp3 = value;
                  setState(() {});
                }),
                _buildOtpField(otp4, (value) {
                  otp4 = value;
                  setState(() {});
                }),
                _buildOtpField(otp5, (value) {
                  otp5 = value;
                  setState(() {});
                }),
                _buildOtpField(otp6, (value) {
                  otp6 = value;
                  setState(() {});
                }),
              ],
            ),
            
            SizedBox(height: spMd),
            
            // OTP Status
            if (fullOtp.isNotEmpty && !isOtpComplete)
              Text(
                "Please enter all 6 digits",
                style: TextStyle(
                  fontSize: 12,
                  color: warningColor,
                ),
              ),
            
            if (isOtpComplete)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.check_circle,
                    color: successColor,
                    size: 16,
                  ),
                  SizedBox(width: spXs),
                  Text(
                    "Code completed",
                    style: TextStyle(
                      fontSize: 12,
                      color: successColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            
            SizedBox(height: spXl),
            
            // Verify Button
            Container(
              width: double.infinity,
              child: QButton(
                label: loading ? "Verifying..." : "Verify Code",
                size: bs.md,
                onPressed: loading || !isOtpComplete ? null : () async {
                  loading = true;
                  setState(() {});
                  
                  // Simulate verification
                  await Future.delayed(Duration(seconds: 2));
                  
                  loading = false;
                  setState(() {});
                  
                  ss("Phone number verified successfully!");
                  // Navigate to next screen
                },
              ),
            ),
            
            SizedBox(height: spMd),
            
            // Resend Code
            if (resendTimer > 0)
              Text(
                "Resend code in ${resendTimer}s",
                style: TextStyle(
                  fontSize: 14,
                  color: disabledBoldColor,
                ),
              )
            else
              GestureDetector(
                onTap: () async {
                  // Simulate resending OTP
                  loading = true;
                  setState(() {});
                  
                  await Future.delayed(Duration(seconds: 1));
                  
                  loading = false;
                  resendTimer = 60;
                  setState(() {});
                  startTimer();
                  
                  ss("New verification code sent!");
                },
                child: Text(
                  "Resend Code",
                  style: TextStyle(
                    fontSize: 14,
                    color: primaryColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            
            SizedBox(height: spMd),
            
            // Change Phone Number
            GestureDetector(
              onTap: () {
                // Navigate back to change phone number
              },
              child: Text(
                "Wrong number? Change it",
                style: TextStyle(
                  fontSize: 14,
                  color: primaryColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            
            SizedBox(height: sp2xl),
            
            // Help Section
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: infoColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusMd),
                border: Border.all(color: infoColor.withAlpha(50)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.help_outline,
                        color: infoColor,
                        size: 20,
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "Having trouble?",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: infoColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spXs),
                  Text(
                    "• Make sure you have good network coverage\n• Check if SMS is blocked on your device\n• Try requesting a new code\n• Contact support if the issue persists",
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

  Widget _buildOtpField(String value, Function(String) onChanged) {
    return Container(
      width: 45,
      height: 55,
      decoration: BoxDecoration(
        border: Border.all(
          color: value.isNotEmpty ? primaryColor : disabledOutlineBorderColor,
          width: value.isNotEmpty ? 2 : 1,
        ),
        borderRadius: BorderRadius.circular(radiusMd),
        color: value.isNotEmpty ? primaryColor.withAlpha(10) : Colors.transparent,
      ),
      child: TextField(
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: primaryColor,
        ),
        keyboardType: TextInputType.number,
        maxLength: 1,
        decoration: InputDecoration(
          border: InputBorder.none,
          counterText: "",
        ),
        onChanged: (val) {
          onChanged(val);
          if (val.isNotEmpty) {
            FocusScope.of(context).nextFocus();
          } else {
            FocusScope.of(context).previousFocus();
          }
        },
      ),
    );
  }
}
