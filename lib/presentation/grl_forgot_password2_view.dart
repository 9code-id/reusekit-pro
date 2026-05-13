import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlForgotPassword2View extends StatefulWidget {
  @override
  State<GrlForgotPassword2View> createState() => _GrlForgotPassword2ViewState();
}

class _GrlForgotPassword2ViewState extends State<GrlForgotPassword2View> {
  final formKey = GlobalKey<FormState>();
  String email = "";
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    SizedBox(height: sp3xl),
                    
                    // Back Button
                    GestureDetector(
                      onTap: () => back(),
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: primaryColor.withAlpha(10),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Icon(
                          Icons.arrow_back,
                          color: primaryColor,
                          size: 20,
                        ),
                      ),
                    ),
                    
                    SizedBox(height: spLg),
                    
                    // Header Section
                    Column(
                      spacing: spSm,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Forgot your password?",
                          style: TextStyle(
                            fontSize: fsH2,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "Don't worry! It happens. Please enter the email address associated with your account.",
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                            height: 1.5,
                          ),
                        ),
                      ],
                    ),
                    
                    SizedBox(height: sp2xl),
                    
                    // Email Input
                    QTextField(
                      label: "Email Address",
                      value: email,
                      hint: "example@email.com",
                      validator: Validator.email,
                      onChanged: (value) {
                        email = value;
                        setState(() {});
                      },
                    ),
                    
                    SizedBox(height: sp2xl),
                    
                    // Submit Button
                    Container(
                      width: double.infinity,
                      child: QButton(
                        label: "Send Reset Instructions",
                        size: bs.md,
                        onPressed: () async {
                          if (formKey.currentState!.validate()) {
                            loading = true;
                            setState(() {});
                            
                            // Simulate API call
                            await Future.delayed(Duration(seconds: 2));
                            
                            loading = false;
                            setState(() {});
                            
                            ss("Password reset instructions sent!");
                            // navigateTo(CheckEmailView());
                          }
                        },
                      ),
                    ),
                    
                    SizedBox(height: spXl),
                    
                    // Alternative Options
                    Column(
                      spacing: spMd,
                      children: [
                        // Divider
                        Row(
                          children: [
                            Expanded(child: Divider(color: disabledColor)),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: spMd),
                              child: Text(
                                "or",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ),
                            Expanded(child: Divider(color: disabledColor)),
                          ],
                        ),
                        
                        // Contact Support
                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.all(spMd),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: disabledOutlineBorderColor,
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(radiusLg),
                          ),
                          child: Column(
                            spacing: spSm,
                            children: [
                              Icon(
                                Icons.support_agent,
                                size: 24,
                                color: primaryColor,
                              ),
                              Text(
                                "Contact Support",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: primaryColor,
                                ),
                              ),
                              Text(
                                "Can't access your email? Get help from our support team",
                                textAlign: TextAlign.center,
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
                    
                    SizedBox(height: spXl),
                    
                    // Remember Password
                    Center(
                      child: GestureDetector(
                        onTap: () {
                          back();
                        },
                        child: Text(
                          "Remember your password? Sign In",
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
