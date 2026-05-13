import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlVerification5View extends StatefulWidget {
  @override
  State<GrlVerification5View> createState() => _GrlVerification5ViewState();
}

class _GrlVerification5ViewState extends State<GrlVerification5View> {
  String phoneNumber = "";
  String countryCode = "+1";
  List<String> verificationCodes = ["", "", "", "", "", ""];
  int currentStep = 0;
  bool isLoading = false;
  int resendTimer = 60;
  
  List<Map<String, dynamic>> countries = [
    {"code": "+1", "name": "United States", "flag": "🇺🇸"},
    {"code": "+44", "name": "United Kingdom", "flag": "🇬🇧"},
    {"code": "+49", "name": "Germany", "flag": "🇩🇪"},
    {"code": "+33", "name": "France", "flag": "🇫🇷"},
    {"code": "+81", "name": "Japan", "flag": "🇯🇵"},
    {"code": "+86", "name": "China", "flag": "🇨🇳"},
    {"code": "+91", "name": "India", "flag": "🇮🇳"},
    {"code": "+62", "name": "Indonesia", "flag": "🇮🇩"},
  ];

  @override
  void initState() {
    super.initState();
    _startResendTimer();
  }

  void _startResendTimer() {
    Future.delayed(Duration(seconds: 1), () {
      if (resendTimer > 0 && mounted) {
        resendTimer--;
        setState(() {});
        _startResendTimer();
      }
    });
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Progress Indicator
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                          color: currentStep >= 0 ? primaryColor : disabledColor,
                          borderRadius: BorderRadius.circular(radiusLg),
                        ),
                        child: Center(
                          child: Text(
                            "1",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          height: 2,
                          color: currentStep >= 1 ? primaryColor : disabledColor,
                        ),
                      ),
                      Container(
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                          color: currentStep >= 1 ? primaryColor : disabledColor,
                          borderRadius: BorderRadius.circular(radiusLg),
                        ),
                        child: Center(
                          child: Text(
                            "2",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          height: 2,
                          color: currentStep >= 2 ? primaryColor : disabledColor,
                        ),
                      ),
                      Container(
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                          color: currentStep >= 2 ? successColor : disabledColor,
                          borderRadius: BorderRadius.circular(radiusLg),
                        ),
                        child: Center(
                          child: currentStep >= 2
                              ? Icon(
                                  Icons.check,
                                  color: Colors.white,
                                  size: 16,
                                )
                              : Text(
                                  "3",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                  ),
                                ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spMd),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Enter Phone",
                        style: TextStyle(
                          fontSize: 12,
                          color: currentStep >= 0 ? primaryColor : disabledBoldColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        "Verify Code",
                        style: TextStyle(
                          fontSize: 12,
                          color: currentStep >= 1 ? primaryColor : disabledBoldColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        "Complete",
                        style: TextStyle(
                          fontSize: 12,
                          color: currentStep >= 2 ? successColor : disabledBoldColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            
            SizedBox(height: spLg),
            
            if (currentStep == 0) _buildPhoneInputStep(),
            if (currentStep == 1) _buildVerificationStep(),
            if (currentStep == 2) _buildSuccessStep(),
          ],
        ),
      ),
    );
  }

  Widget _buildPhoneInputStep() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(spLg),
          decoration: BoxDecoration(
            color: primaryColor.withAlpha(20),
            borderRadius: BorderRadius.circular(radiusLg),
          ),
          child: Column(
            children: [
              Icon(
                Icons.phone_android,
                size: 48,
                color: primaryColor,
              ),
              SizedBox(height: spMd),
              Text(
                "Enter Your Phone Number",
                style: TextStyle(
                  fontSize: fsH5,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              SizedBox(height: spSm),
              Text(
                "We'll send you a verification code to confirm your number",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
        ),
        
        SizedBox(height: spLg),
        
        // Country Code Selector
        Text(
          "Country",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        
        SizedBox(height: spMd),
        
        QDropdownField(
          label: "Select Country",
          items: countries.map((country) => {
            "label": "${country["flag"]} ${country["name"]} (${country["code"]})",
            "value": country["code"],
          }).toList(),
          value: countryCode,
          onChanged: (value, label) {
            countryCode = value;
            setState(() {});
          },
        ),
        
        SizedBox(height: spMd),
        
        // Phone Number Input
        Text(
          "Phone Number",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        
        SizedBox(height: spMd),
        
        Row(
          children: [
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: spMd,
                vertical: spMd + 2,
              ),
              decoration: BoxDecoration(
                color: disabledColor.withAlpha(40),
                borderRadius: BorderRadius.circular(radiusLg),
                border: Border.all(
                  color: disabledOutlineBorderColor,
                  width: 1,
                ),
              ),
              child: Text(
                countryCode,
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ),
            SizedBox(width: spMd),
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
        
        SizedBox(height: spMd),
        
        // Information
        Container(
          padding: EdgeInsets.all(spMd),
          decoration: BoxDecoration(
            color: infoColor.withAlpha(20),
            borderRadius: BorderRadius.circular(radiusLg),
          ),
          child: Row(
            children: [
              Icon(
                Icons.info,
                color: infoColor,
                size: 20,
              ),
              SizedBox(width: spMd),
              Expanded(
                child: Text(
                  "Standard messaging rates may apply. We'll never share your phone number.",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ),
            ],
          ),
        ),
        
        SizedBox(height: spXl),
        
        // Send Code Button
        Container(
          width: double.infinity,
          child: QButton(
            label: "Send Verification Code",
            size: bs.md,
            onPressed: phoneNumber.isNotEmpty && !isLoading ? () async {
              isLoading = true;
              setState(() {});
              
              // Simulate API call
              await Future.delayed(Duration(seconds: 2));
              
              isLoading = false;
              currentStep = 1;
              resendTimer = 60;
              setState(() {});
              
              ss("Verification code sent to $countryCode $phoneNumber");
            } : null,
          ),
        ),
        
        if (isLoading) ...[
          SizedBox(height: spMd),
          Center(
            child: CircularProgressIndicator(
              color: primaryColor,
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildVerificationStep() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(spLg),
          decoration: BoxDecoration(
            color: warningColor.withAlpha(20),
            borderRadius: BorderRadius.circular(radiusLg),
          ),
          child: Column(
            children: [
              Icon(
                Icons.sms,
                size: 48,
                color: warningColor,
              ),
              SizedBox(height: spMd),
              Text(
                "Enter Verification Code",
                style: TextStyle(
                  fontSize: fsH5,
                  fontWeight: FontWeight.bold,
                  color: warningColor,
                ),
              ),
              SizedBox(height: spSm),
              Text(
                "We sent a 6-digit code to",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  color: disabledBoldColor,
                ),
              ),
              SizedBox(height: spXs),
              Text(
                "$countryCode $phoneNumber",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
        ),
        
        SizedBox(height: spLg),
        
        // Code Input Fields
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: List.generate(6, (index) {
            return Container(
              width: 45,
              height: 55,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                border: Border.all(
                  color: verificationCodes[index].isNotEmpty 
                      ? primaryColor 
                      : disabledOutlineBorderColor,
                  width: verificationCodes[index].isNotEmpty ? 2 : 1,
                ),
                boxShadow: [shadowSm],
              ),
              child: TextField(
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: fsH5,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  counterText: "",
                ),
                maxLength: 1,
                onChanged: (value) {
                  verificationCodes[index] = value;
                  setState(() {});
                  
                  if (value.isNotEmpty && index < 5) {
                    FocusScope.of(context).nextFocus();
                  }
                  
                  if (verificationCodes.every((code) => code.isNotEmpty)) {
                    _verifyCode();
                  }
                },
              ),
            );
          }),
        ),
        
        SizedBox(height: spLg),
        
        // Resend Code
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Didn't receive code? ",
              style: TextStyle(
                fontSize: 14,
                color: disabledBoldColor,
              ),
            ),
            if (resendTimer > 0)
              Text(
                "Resend in ${resendTimer}s",
                style: TextStyle(
                  fontSize: 14,
                  color: disabledBoldColor,
                ),
              )
            else
              GestureDetector(
                onTap: () {
                  resendTimer = 60;
                  _startResendTimer();
                  ss("Verification code resent!");
                },
                child: Text(
                  "Resend Code",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
              ),
          ],
        ),
        
        SizedBox(height: spLg),
        
        // Change Number
        Center(
          child: GestureDetector(
            onTap: () {
              currentStep = 0;
              verificationCodes = ["", "", "", "", "", ""];
              setState(() {});
            },
            child: Text(
              "Change Phone Number",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: primaryColor,
                decoration: TextDecoration.underline,
              ),
            ),
          ),
        ),
        
        if (isLoading) ...[
          SizedBox(height: spMd),
          Center(
            child: CircularProgressIndicator(
              color: primaryColor,
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildSuccessStep() {
    return Column(
      children: [
        SizedBox(height: spXl),
        
        // Success Animation
        Container(
          width: 120,
          height: 120,
          decoration: BoxDecoration(
            color: successColor.withAlpha(20),
            borderRadius: BorderRadius.circular(radiusLg),
          ),
          child: Center(
            child: Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: successColor,
                borderRadius: BorderRadius.circular(radiusLg),
              ),
              child: Icon(
                Icons.check,
                size: 40,
                color: Colors.white,
              ),
            ),
          ),
        ),
        
        SizedBox(height: spLg),
        
        Text(
          "Phone Verified Successfully!",
          style: TextStyle(
            fontSize: fsH4,
            fontWeight: FontWeight.bold,
            color: successColor,
          ),
        ),
        
        SizedBox(height: spMd),
        
        Text(
          "Your phone number has been verified and your account is now secure.",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 14,
            color: disabledBoldColor,
          ),
        ),
        
        SizedBox(height: spLg),
        
        // Account Details
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(spMd),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(radiusLg),
            boxShadow: [shadowSm],
          ),
          child: Column(
            children: [
              Row(
                children: [
                  Icon(
                    Icons.phone,
                    color: primaryColor,
                    size: 20,
                  ),
                  SizedBox(width: spMd),
                  Text(
                    "Verified Phone:",
                    style: TextStyle(
                      fontSize: 14,
                      color: disabledBoldColor,
                    ),
                  ),
                  Spacer(),
                  Text(
                    "$countryCode $phoneNumber",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                ],
              ),
              SizedBox(height: spMd),
              Row(
                children: [
                  Icon(
                    Icons.security,
                    color: successColor,
                    size: 20,
                  ),
                  SizedBox(width: spMd),
                  Text(
                    "Security Status:",
                    style: TextStyle(
                      fontSize: 14,
                      color: disabledBoldColor,
                    ),
                  ),
                  Spacer(),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: spSm,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: successColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Text(
                      "VERIFIED",
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: successColor,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        
        SizedBox(height: spXl),
        
        // Continue Button
        Container(
          width: double.infinity,
          child: QButton(
            label: "Continue to Dashboard",
            size: bs.md,
            onPressed: () {
              // navigateTo(DashboardView());
            },
          ),
        ),
      ],
    );
  }

  void _verifyCode() async {
    String code = verificationCodes.join();
    if (code.length == 6) {
      isLoading = true;
      setState(() {});
      
      // Simulate API call
      await Future.delayed(Duration(seconds: 2));
      
      isLoading = false;
      currentStep = 2;
      setState(() {});
      
      ss("Phone number verified successfully!");
    }
  }
}
