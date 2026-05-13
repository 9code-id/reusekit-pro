import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class EcsOtpVerificationView extends StatefulWidget {
  const EcsOtpVerificationView({super.key});

  @override
  State<EcsOtpVerificationView> createState() => _EcsOtpVerificationViewState();
}

class _EcsOtpVerificationViewState extends State<EcsOtpVerificationView> {
  String otp = "";
  String email = "user@example.com";
  bool loading = false;
  int countdown = 60;
  bool canResend = false;

  @override
  void initState() {
    super.initState();
    _startCountdown();
  }

  void _startCountdown() {
    countdown = 60;
    canResend = false;
    setState(() {});
    
    Future.doWhile(() async {
      await Future.delayed(Duration(seconds: 1));
      if (countdown > 0) {
        countdown--;
        setState(() {});
        return true;
      } else {
        canResend = true;
        setState(() {});
        return false;
      }
    });
  }

  void _verifyOtp() async {
    if (otp.length != 6) {
      se("Please enter complete 6-digit OTP");
      return;
    }
    
    loading = true;
    setState(() {});
    
    await Future.delayed(Duration(seconds: 2));
    
    loading = false;
    setState(() {});
    
    if (otp == "123456") {
      ss("Email verified successfully!");
      // ss('Next page'));
    } else {
      se("Invalid OTP. Please try again.");
    }
  }

  void _resendOtp() async {
    if (!canResend) return;
    
    showLoading();
    await Future.delayed(Duration(seconds: 2));
    hideLoading();
    
    ss("OTP sent again!");
    _startCountdown();
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
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: spLg),
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: successColor.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(radiusLg),
              ),
              child: Icon(
                Icons.email_outlined,
                size: 50,
                color: successColor,
              ),
            ),
            SizedBox(height: spLg),
            Text(
              "Enter Verification Code",
              style: TextStyle(
                fontSize: fsH3,
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
              "$email",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spXl),
            Container(
              padding: EdgeInsets.symmetric(horizontal: spMd),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(6, (index) {
                  return Container(
                    width: 45,
                    height: 50,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: index < otp.length ? primaryColor : disabledOutlineBorderColor,
                        width: index < otp.length ? 2 : 1,
                      ),
                      borderRadius: BorderRadius.circular(radiusSm),
                      color: index < otp.length ? primaryColor.withValues(alpha: 0.05) : Colors.transparent,
                    ),
                    child: Center(
                      child: Text(
                        index < otp.length ? otp[index] : "",
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
            ),
            SizedBox(height: spMd),
            Container(
              height: 60,
              child: GridView.builder(
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 1.5,
                  crossAxisSpacing: spSm,
                  mainAxisSpacing: spSm,
                ),
                itemCount: 12,
                itemBuilder: (context, index) {
                  if (index < 9) {
                    final number = (index + 1).toString();
                    return GestureDetector(
                      onTap: () {
                        if (otp.length < 6) {
                          otp += number;
                          setState(() {});
                        }
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Center(
                          child: Text(
                            number,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: primaryColor,
                            ),
                          ),
                        ),
                      ),
                    );
                  } else if (index == 9) {
                    return Container();
                  } else if (index == 10) {
                    return GestureDetector(
                      onTap: () {
                        if (otp.length < 6) {
                          otp += "0";
                          setState(() {});
                        }
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Center(
                          child: Text(
                            "0",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: primaryColor,
                            ),
                          ),
                        ),
                      ),
                    );
                  } else {
                    return GestureDetector(
                      onTap: () {
                        if (otp.isNotEmpty) {
                          otp = otp.substring(0, otp.length - 1);
                          setState(() {});
                        }
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Center(
                          child: Icon(
                            Icons.backspace,
                            color: primaryColor,
                            size: 20,
                          ),
                        ),
                      ),
                    );
                  }
                },
              ),
            ),
            SizedBox(height: spXl),
            Container(
              width: double.infinity,
              child: loading
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : QButton(
                      label: "Verify Code",
                      size: bs.md,
                      onPressed: _verifyOtp,
                    ),
            ),
            SizedBox(height: spLg),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Didn't receive the code? ",
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                  ),
                ),
                GestureDetector(
                  onTap: canResend ? _resendOtp : null,
                  child: Text(
                    canResend ? "Resend" : "Resend in ${countdown}s",
                    style: TextStyle(
                      fontSize: 14,
                      color: canResend ? primaryColor : disabledColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: spLg),
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: warningColor.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(radiusSm),
                border: Border.all(
                  color: warningColor.withValues(alpha: 0.3),
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.info,
                    color: warningColor,
                    size: 20,
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Text(
                      "Check your spam folder if you don't see the email in your inbox",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
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
}
