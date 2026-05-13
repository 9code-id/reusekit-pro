import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlLogin3View extends StatefulWidget {
  const GrlLogin3View({super.key});

  @override
  State<GrlLogin3View> createState() => _GrlLogin3ViewState();
}

class _GrlLogin3ViewState extends State<GrlLogin3View> {
  String phoneNumber = "";
  String verificationCode = "";
  bool isCodeSent = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.white,
              primaryColor.withAlpha(30),
            ],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(spMd),
            child: Column(
              children: [
                SizedBox(height: spXl),
                
                // Header Illustration
                Container(
                  width: 200,
                  height: 200,
                  decoration: BoxDecoration(
                    color: primaryColor.withAlpha(50),
                    shape: BoxShape.circle,
                  ),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        width: 120,
                        height: 120,
                        decoration: BoxDecoration(
                          color: primaryColor,
                          shape: BoxShape.circle,
                          boxShadow: [shadowMd],
                        ),
                        child: Icon(
                          Icons.phone_android,
                          size: 60,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                
                SizedBox(height: spLg),
                
                Text(
                  isCodeSent ? "Verify Your Phone" : "Phone Login",
                  style: TextStyle(
                    fontSize: fsH1,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                
                Text(
                  isCodeSent 
                    ? "Enter the verification code sent to your phone number"
                    : "Enter your phone number to receive a verification code",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: disabledBoldColor,
                  ),
                ),
                
                SizedBox(height: spXl),
                
                // Phone Input Card
                Container(
                  padding: EdgeInsets.all(spLg),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radius2xl),
                    boxShadow: [shadowLg],
                  ),
                  child: Column(
                    spacing: spMd,
                    children: [
                      if (!isCodeSent) ...[
                        Row(
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: spSm,
                                vertical: spXs,
                              ),
                              decoration: BoxDecoration(
                                color: primaryColor.withAlpha(50),
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.flag,
                                    size: 20,
                                    color: primaryColor,
                                  ),
                                  SizedBox(width: spXs),
                                  Text(
                                    "+62",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: primaryColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(width: spSm),
                            Expanded(
                              child: QTextField(
                                label: "Phone Number",
                                value: phoneNumber,
                                hint: "812 3456 7890",
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
                            onPressed: () {
                              if (phoneNumber.isNotEmpty) {
                                isCodeSent = true;
                                setState(() {});
                              }
                            },
                          ),
                        ),
                      ] else ...[
                        QTextField(
                          label: "Verification Code",
                          value: verificationCode,
                          hint: "Enter 6-digit code",
                          onChanged: (value) {
                            verificationCode = value;
                            setState(() {});
                          },
                        ),
                        
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
                            GestureDetector(
                              onTap: () {
                                // Resend code
                              },
                              child: Text(
                                "Resend",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: primaryColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                        
                        Container(
                          width: double.infinity,
                          child: QButton(
                            label: "Verify & Continue",
                            size: bs.md,
                            onPressed: () {
                              // Handle verification
                            },
                          ),
                        ),
                        
                        GestureDetector(
                          onTap: () {
                            isCodeSent = false;
                            setState(() {});
                          },
                          child: Container(
                            width: double.infinity,
                            padding: EdgeInsets.symmetric(vertical: spSm),
                            child: Text(
                              "Change Phone Number",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 14,
                                color: primaryColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
                
                SizedBox(height: spXl),
                
                // Alternative Login Options
                Column(
                  spacing: spMd,
                  children: [
                    Row(
                      children: [
                        Expanded(child: Divider(color: disabledOutlineBorderColor)),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: spSm),
                          child: Text(
                            "Or",
                            style: TextStyle(
                              color: disabledBoldColor,
                              fontSize: 14,
                            ),
                          ),
                        ),
                        Expanded(child: Divider(color: disabledOutlineBorderColor)),
                      ],
                    ),
                    
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(vertical: spSm),
                      decoration: BoxDecoration(
                        border: Border.all(color: disabledOutlineBorderColor),
                        borderRadius: BorderRadius.circular(radiusLg),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.email, size: 20, color: primaryColor),
                          SizedBox(width: spXs),
                          Text(
                            "Continue with Email",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
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
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: spSm),
                            decoration: BoxDecoration(
                              border: Border.all(color: disabledOutlineBorderColor),
                              borderRadius: BorderRadius.circular(radiusLg),
                            ),
                            child: Icon(Icons.g_mobiledata, size: 24, color: dangerColor),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: spSm),
                            decoration: BoxDecoration(
                              border: Border.all(color: disabledOutlineBorderColor),
                              borderRadius: BorderRadius.circular(radiusLg),
                            ),
                            child: Icon(Icons.facebook, size: 24, color: infoColor),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: spSm),
                            decoration: BoxDecoration(
                              border: Border.all(color: disabledOutlineBorderColor),
                              borderRadius: BorderRadius.circular(radiusLg),
                            ),
                            child: Icon(Icons.apple, size: 24, color: primaryColor),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                
                SizedBox(height: spLg),
                
                Text(
                  "By continuing, you agree to our Terms & Conditions",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
