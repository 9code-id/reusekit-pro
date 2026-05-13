import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlVerification4View extends StatefulWidget {
  @override
  State<GrlVerification4View> createState() => _GrlVerification4ViewState();
}

class _GrlVerification4ViewState extends State<GrlVerification4View> {
  String email = "";
  String verificationCode = "";
  String password = "";
  String confirmPassword = "";
  int selectedMethodIndex = 0;
  bool isLoading = false;
  
  final formKey = GlobalKey<FormState>();
  
  List<Map<String, dynamic>> verificationMethods = [
    {
      "title": "Email Verification",
      "description": "We'll send a verification code to your email",
      "icon": Icons.email,
      "type": "email",
    },
    {
      "title": "SMS Verification",
      "description": "Get verification code via SMS",
      "icon": Icons.sms,
      "type": "sms",
    },
    {
      "title": "App Authenticator",
      "description": "Use your authenticator app",
      "icon": Icons.security,
      "type": "app",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Account Verification"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(spLg),
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
                        color: Colors.white.withAlpha(40),
                        borderRadius: BorderRadius.circular(radiusLg),
                      ),
                      child: Icon(
                        Icons.verified_user,
                        size: 48,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: spMd),
                    Text(
                      "Secure Account Setup",
                      style: TextStyle(
                        fontSize: fsH4,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "Complete your account verification to ensure security",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white70,
                      ),
                    ),
                  ],
                ),
              ),
              
              SizedBox(height: spLg),
              
              // Verification Methods
              Text(
                "Choose Verification Method",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              
              SizedBox(height: spMd),
              
              ...verificationMethods.asMap().entries.map((entry) {
                int index = entry.key;
                Map<String, dynamic> method = entry.value;
                
                return Container(
                  margin: EdgeInsets.only(bottom: spMd),
                  child: GestureDetector(
                    onTap: () {
                      selectedMethodIndex = index;
                      setState(() {});
                    },
                    child: Container(
                      padding: EdgeInsets.all(spMd),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(radiusLg),
                        border: Border.all(
                          color: selectedMethodIndex == index ? primaryColor : disabledOutlineBorderColor,
                          width: selectedMethodIndex == index ? 2 : 1,
                        ),
                        boxShadow: selectedMethodIndex == index ? [shadowMd] : [shadowSm],
                      ),
                      child: Row(
                        children: [
                          Container(
                            padding: EdgeInsets.all(spMd),
                            decoration: BoxDecoration(
                              color: selectedMethodIndex == index ? primaryColor : disabledColor,
                              borderRadius: BorderRadius.circular(radiusLg),
                            ),
                            child: Icon(
                              method["icon"] as IconData,
                              color: Colors.white,
                              size: 24,
                            ),
                          ),
                          SizedBox(width: spMd),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${method["title"]}",
                                  style: TextStyle(
                                    fontSize: fsH6,
                                    fontWeight: FontWeight.bold,
                                    color: selectedMethodIndex == index ? primaryColor : Colors.black,
                                  ),
                                ),
                                SizedBox(height: spXs),
                                Text(
                                  "${method["description"]}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            width: 20,
                            height: 20,
                            decoration: BoxDecoration(
                              color: selectedMethodIndex == index ? primaryColor : Colors.transparent,
                              border: Border.all(
                                color: selectedMethodIndex == index ? primaryColor : disabledBoldColor,
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(radiusLg),
                            ),
                            child: selectedMethodIndex == index
                                ? Icon(
                                    Icons.check,
                                    size: 12,
                                    color: Colors.white,
                                  )
                                : null,
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }).toList(),
              
              SizedBox(height: spLg),
              
              // Contact Information
              if (selectedMethodIndex == 0) ...[
                Text(
                  "Email Address",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spMd),
                QTextField(
                  label: "Email Address",
                  value: email,
                  hint: "Enter your email address",
                  validator: Validator.email,
                  onChanged: (value) {
                    email = value;
                    setState(() {});
                  },
                ),
              ],
              
              if (selectedMethodIndex == 1) ...[
                Text(
                  "Phone Number",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spMd),
                QTextField(
                  label: "Phone Number",
                  value: email,
                  hint: "Enter your phone number",
                  validator: Validator.required,
                  onChanged: (value) {
                    email = value;
                    setState(() {});
                  },
                ),
              ],
              
              SizedBox(height: spLg),
              
              // Verification Code
              Text(
                "Verification Code",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              
              SizedBox(height: spMd),
              
              QTextField(
                label: "6-Digit Code",
                value: verificationCode,
                hint: "Enter verification code",
                validator: Validator.required,
                onChanged: (value) {
                  verificationCode = value;
                  setState(() {});
                },
              ),
              
              SizedBox(height: spMd),
              
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Didn't receive code?",
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
              
              // Password Setup
              Text(
                "Set Password",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              
              SizedBox(height: spMd),
              
              QTextField(
                label: "Password",
                value: password,
                hint: "Create a strong password",
                obscureText: true,
                validator: Validator.required,
                onChanged: (value) {
                  password = value;
                  setState(() {});
                },
              ),
              
              SizedBox(height: spMd),
              
              QTextField(
                label: "Confirm Password",
                value: confirmPassword,
                hint: "Confirm your password",
                obscureText: true,
                validator: Validator.required,
                onChanged: (value) {
                  confirmPassword = value;
                  setState(() {});
                },
              ),
              
              SizedBox(height: spMd),
              
              // Password Requirements
              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: infoColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusLg),
                  border: Border.all(
                    color: infoColor.withAlpha(60),
                    width: 1,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.info,
                          color: infoColor,
                          size: 16,
                        ),
                        SizedBox(width: spSm),
                        Text(
                          "Password Requirements",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: infoColor,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "• At least 8 characters\n• One uppercase letter\n• One lowercase letter\n• One number\n• One special character",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              
              SizedBox(height: spXl),
              
              // Action Buttons
              Row(
                children: [
                  Expanded(
                    child: QButton(
                      label: "Send Code",
                      size: bs.md,
                      onPressed: isLoading ? null : () async {
                        if (formKey.currentState!.validate()) {
                          isLoading = true;
                          setState(() {});
                          
                          // Simulate API call
                          await Future.delayed(Duration(seconds: 2));
                          
                          isLoading = false;
                          setState(() {});
                          
                          ss("Verification code sent successfully!");
                        }
                      },
                    ),
                  ),
                  SizedBox(width: spMd),
                  Expanded(
                    child: QButton(
                      label: "Verify Account",
                      size: bs.md,
                      onPressed: isLoading ? null : () async {
                        if (formKey.currentState!.validate()) {
                          isLoading = true;
                          setState(() {});
                          
                          // Simulate API call
                          await Future.delayed(Duration(seconds: 2));
                          
                          isLoading = false;
                          setState(() {});
                          
                          ss("Account verified successfully!");
                          // navigateTo(DashboardView());
                        }
                      },
                    ),
                  ),
                ],
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
          ),
        ),
      ),
    );
  }
}
