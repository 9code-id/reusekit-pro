import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlVerification1View extends StatefulWidget {
  @override
  State<GrlVerification1View> createState() => _GrlVerification1ViewState();
}

class _GrlVerification1ViewState extends State<GrlVerification1View> {
  String phoneNumber = '';
  String selectedCountryCode = '+1';
  bool isLoading = false;
  
  List<Map<String, dynamic>> countryCodes = [
    {"code": "+1", "country": "United States", "flag": "🇺🇸"},
    {"code": "+44", "country": "United Kingdom", "flag": "🇬🇧"},
    {"code": "+33", "country": "France", "flag": "🇫🇷"},
    {"code": "+49", "country": "Germany", "flag": "🇩🇪"},
    {"code": "+81", "country": "Japan", "flag": "🇯🇵"},
    {"code": "+86", "country": "China", "flag": "🇨🇳"},
    {"code": "+91", "country": "India", "flag": "🇮🇳"},
    {"code": "+62", "country": "Indonesia", "flag": "🇮🇩"},
  ];

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
            // Header Illustration
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [primaryColor, primaryColor.withAlpha(180)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(radiusLg),
              ),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(spMd),
                    decoration: BoxDecoration(
                      color: Colors.white.withAlpha(51),
                      borderRadius: BorderRadius.circular(radiusLg),
                    ),
                    child: Icon(
                      Icons.phone_iphone,
                      color: Colors.white,
                      size: 48,
                    ),
                  ),
                  SizedBox(height: spMd),
                  Text(
                    "Verify Your Phone Number",
                    style: TextStyle(
                      fontSize: fsH4,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "We'll send you a verification code to confirm your phone number",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white70,
                    ),
                  ),
                ],
              ),
            ),
            
            SizedBox(height: spMd),
            
            // Phone Number Input
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Phone Number",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spMd),
                  
                  // Country Code Selector
                  QDropdownField(
                    label: "Country Code",
                    items: countryCodes.map((country) => {
                      "label": "${country["flag"]} ${country["code"]} ${country["country"]}",
                      "value": country["code"],
                    }).toList(),
                    value: selectedCountryCode,
                    onChanged: (value, label) {
                      selectedCountryCode = value;
                      setState(() {});
                    },
                  ),
                  
                  SizedBox(height: spMd),
                  
                  // Phone Number Field
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: spMd,
                          vertical: spSm + 4,
                        ),
                        decoration: BoxDecoration(
                          color: disabledColor.withAlpha(51),
                          borderRadius: BorderRadius.circular(radiusLg),
                          border: Border.all(color: disabledColor),
                        ),
                        child: Text(
                          selectedCountryCode,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: primaryColor,
                          ),
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QTextField(
                          label: "Phone number",
                          value: phoneNumber,
                          hint: "123-456-7890",
                          onChanged: (value) {
                            phoneNumber = value;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            
            SizedBox(height: spMd),
            
            // Security Information
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: infoColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusLg),
                border: Border.all(color: infoColor.withAlpha(102)),
              ),
              child: Column(
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
                        "Why We Need This",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: infoColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "• Verify your identity for account security\n• Enable two-factor authentication\n• Send important account notifications\n• Recover your account if needed",
                    style: TextStyle(
                      fontSize: 14,
                      color: disabledBoldColor,
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),
            
            SizedBox(height: spMd),
            
            // Terms and Privacy
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Privacy Notice",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "Your phone number will be used for verification purposes only. We will not share it with third parties or use it for marketing without your consent.",
                    style: TextStyle(
                      fontSize: 14,
                      color: disabledBoldColor,
                      height: 1.4,
                    ),
                  ),
                  SizedBox(height: spMd),
                  Row(
                    children: [
                      Text(
                        "By continuing, you agree to our ",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          si("Opening Terms of Service...");
                        },
                        child: Text(
                          "Terms of Service",
                          style: TextStyle(
                            fontSize: 14,
                            color: primaryColor,
                            fontWeight: FontWeight.w600,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        "and ",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          si("Opening Privacy Policy...");
                        },
                        child: Text(
                          "Privacy Policy",
                          style: TextStyle(
                            fontSize: 14,
                            color: primaryColor,
                            fontWeight: FontWeight.w600,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            
            SizedBox(height: spMd),
            
            // Send Verification Button
            Container(
              width: double.infinity,
              child: QButton(
                label: isLoading ? "Sending..." : "Send Verification Code",
                size: bs.md,
                onPressed: _canSendCode() && !isLoading ? _sendVerificationCode : null,
              ),
            ),
            
            SizedBox(height: spMd),
            
            // Alternative Methods
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Alternative Verification Methods",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spMd),
                  
                  GestureDetector(
                    onTap: () {
                      // navigateTo(EmailVerificationView());
                    },
                    child: Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: primaryColor.withAlpha(51),
                            borderRadius: BorderRadius.circular(radiusLg),
                          ),
                          child: Icon(
                            Icons.email,
                            color: primaryColor,
                            size: 20,
                          ),
                        ),
                        SizedBox(width: spMd),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Email Verification",
                                style: TextStyle(
                                  fontSize: fsH6,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                "Verify using your email address instead",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Icon(
                          Icons.arrow_forward_ios,
                          color: disabledBoldColor,
                          size: 16,
                        ),
                      ],
                    ),
                  ),
                  
                  SizedBox(height: spMd),
                  
                  GestureDetector(
                    onTap: () {
                      // navigateTo(DocumentVerificationView());
                    },
                    child: Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: warningColor.withAlpha(51),
                            borderRadius: BorderRadius.circular(radiusLg),
                          ),
                          child: Icon(
                            Icons.document_scanner,
                            color: warningColor,
                            size: 20,
                          ),
                        ),
                        SizedBox(width: spMd),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Document Verification",
                                style: TextStyle(
                                  fontSize: fsH6,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                "Upload identity documents for verification",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Icon(
                          Icons.arrow_forward_ios,
                          color: disabledBoldColor,
                          size: 16,
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

  bool _canSendCode() {
    return phoneNumber.isNotEmpty && phoneNumber.length >= 10;
  }

  void _sendVerificationCode() async {
    setState(() {
      isLoading = true;
    });
    
    // Simulate API call
    await Future.delayed(Duration(seconds: 2));
    
    setState(() {
      isLoading = false;
    });
    
    ss("Verification code sent to $selectedCountryCode $phoneNumber");
    
    // Navigate to verification code input screen
    // navigateTo(VerificationCodeView(phoneNumber: "$selectedCountryCode $phoneNumber"));
  }
}
