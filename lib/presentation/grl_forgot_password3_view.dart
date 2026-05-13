import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlForgotPassword3View extends StatefulWidget {
  @override
  State<GrlForgotPassword3View> createState() => _GrlForgotPassword3ViewState();
}

class _GrlForgotPassword3ViewState extends State<GrlForgotPassword3View> {
  final formKey = GlobalKey<FormState>();
  String emailOrPhone = "";
  String selectedMethod = "email";
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Account Recovery"),
      ),
      body: loading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: EdgeInsets.all(spMd),
              child: Form(
                key: formKey,
                child: Column(
                  spacing: spMd,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: spMd),
                    
                    // Header Illustration
                    Center(
                      child: Container(
                        width: 120,
                        height: 120,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              primaryColor.withAlpha(20),
                              primaryColor.withAlpha(10),
                            ],
                          ),
                          borderRadius: BorderRadius.circular(radiusXl),
                        ),
                        child: Icon(
                          Icons.lock_open,
                          size: 60,
                          color: primaryColor,
                        ),
                      ),
                    ),
                    
                    SizedBox(height: spLg),
                    
                    // Title and Description
                    Center(
                      child: Column(
                        spacing: spSm,
                        children: [
                          Text(
                            "Recover Your Account",
                            style: TextStyle(
                              fontSize: fsH3,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          Text(
                            "Choose how you'd like to recover your account. We'll send you a secure link to reset your password.",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                              height: 1.4,
                            ),
                          ),
                        ],
                      ),
                    ),
                    
                    SizedBox(height: sp2xl),
                    
                    // Recovery Method Selection
                    Text(
                      "Recovery Method",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                    
                    SizedBox(height: spSm),
                    
                    // Email Option
                    GestureDetector(
                      onTap: () {
                        selectedMethod = "email";
                        setState(() {});
                      },
                      child: Container(
                        padding: EdgeInsets.all(spMd),
                        decoration: BoxDecoration(
                          color: selectedMethod == "email" 
                              ? primaryColor.withAlpha(10) 
                              : Colors.white,
                          border: Border.all(
                            color: selectedMethod == "email" 
                                ? primaryColor 
                                : disabledOutlineBorderColor,
                            width: selectedMethod == "email" ? 2 : 1,
                          ),
                          borderRadius: BorderRadius.circular(radiusLg),
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                color: selectedMethod == "email" 
                                    ? primaryColor 
                                    : disabledColor,
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Icon(
                                Icons.email,
                                color: Colors.white,
                                size: 20,
                              ),
                            ),
                            SizedBox(width: spMd),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Email Address",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: selectedMethod == "email" 
                                          ? primaryColor 
                                          : disabledBoldColor,
                                    ),
                                  ),
                                  Text(
                                    "We'll send a reset link to your email",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            if (selectedMethod == "email")
                              Icon(
                                Icons.check_circle,
                                color: primaryColor,
                                size: 20,
                              ),
                          ],
                        ),
                      ),
                    ),
                    
                    SizedBox(height: spSm),
                    
                    // Phone Option
                    GestureDetector(
                      onTap: () {
                        selectedMethod = "phone";
                        setState(() {});
                      },
                      child: Container(
                        padding: EdgeInsets.all(spMd),
                        decoration: BoxDecoration(
                          color: selectedMethod == "phone" 
                              ? primaryColor.withAlpha(10) 
                              : Colors.white,
                          border: Border.all(
                            color: selectedMethod == "phone" 
                                ? primaryColor 
                                : disabledOutlineBorderColor,
                            width: selectedMethod == "phone" ? 2 : 1,
                          ),
                          borderRadius: BorderRadius.circular(radiusLg),
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                color: selectedMethod == "phone" 
                                    ? primaryColor 
                                    : disabledColor,
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Icon(
                                Icons.phone,
                                color: Colors.white,
                                size: 20,
                              ),
                            ),
                            SizedBox(width: spMd),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Phone Number",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: selectedMethod == "phone" 
                                          ? primaryColor 
                                          : disabledBoldColor,
                                    ),
                                  ),
                                  Text(
                                    "We'll send an SMS with reset code",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            if (selectedMethod == "phone")
                              Icon(
                                Icons.check_circle,
                                color: primaryColor,
                                size: 20,
                              ),
                          ],
                        ),
                      ),
                    ),
                    
                    SizedBox(height: spLg),
                    
                    // Input Field
                    QTextField(
                      label: selectedMethod == "email" ? "Email Address" : "Phone Number",
                      value: emailOrPhone,
                      hint: selectedMethod == "email" 
                          ? "Enter your email address" 
                          : "Enter your phone number",
                      validator: selectedMethod == "email" 
                          ? Validator.email 
                          : Validator.required,
                      onChanged: (value) {
                        emailOrPhone = value;
                        setState(() {});
                      },
                    ),
                    
                    SizedBox(height: spXl),
                    
                    // Continue Button
                    Container(
                      width: double.infinity,
                      child: QButton(
                        label: "Continue",
                        size: bs.md,
                        onPressed: () async {
                          if (formKey.currentState!.validate()) {
                            loading = true;
                            setState(() {});
                            
                            // Simulate API call
                            await Future.delayed(Duration(seconds: 2));
                            
                            loading = false;
                            setState(() {});
                            
                            if (selectedMethod == "email") {
                              ss("Reset link sent to your email!");
                            } else {
                              ss("SMS sent to your phone!");
                            }
                            // navigateTo(VerificationView());
                          }
                        },
                      ),
                    ),
                    
                    SizedBox(height: spMd),
                    
                    // Back to Login
                    Center(
                      child: GestureDetector(
                        onTap: () {
                          back();
                        },
                        child: Text(
                          "Back to Login",
                          style: TextStyle(
                            fontSize: 14,
                            color: primaryColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
