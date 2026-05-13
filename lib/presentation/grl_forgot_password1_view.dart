import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlForgotPassword1View extends StatefulWidget {
  @override
  State<GrlForgotPassword1View> createState() => _GrlForgotPassword1ViewState();
}

class _GrlForgotPassword1ViewState extends State<GrlForgotPassword1View> {
  final formKey = GlobalKey<FormState>();
  String email = "";
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Forgot Password"),
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
                    SizedBox(height: spXl),
                    
                    // Header Section
                    Center(
                      child: Column(
                        spacing: spSm,
                        children: [
                          Container(
                            width: 80,
                            height: 80,
                            decoration: BoxDecoration(
                              color: primaryColor.withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusLg),
                            ),
                            child: Icon(
                              Icons.lock_reset,
                              size: 40,
                              color: primaryColor,
                            ),
                          ),
                          Text(
                            "Reset Password",
                            style: TextStyle(
                              fontSize: fsH3,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          Text(
                            "Enter your email address and we'll send you a link to reset your password.",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    
                    SizedBox(height: spXl),
                    
                    // Email Input Section
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
                    
                    SizedBox(height: spLg),
                    
                    // Send Reset Link Button
                    Container(
                      width: double.infinity,
                      child: QButton(
                        label: "Send Reset Link",
                        size: bs.md,
                        onPressed: () async {
                          if (formKey.currentState!.validate()) {
                            loading = true;
                            setState(() {});
                            
                            // Simulate API call
                            await Future.delayed(Duration(seconds: 2));
                            
                            loading = false;
                            setState(() {});
                            
                            ss("Reset link sent to your email!");
                            // navigateTo(CheckEmailView());
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
                    
                    SizedBox(height: spXl),
                    
                    // Help Section
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(spMd),
                      decoration: BoxDecoration(
                        color: infoColor.withAlpha(10),
                        borderRadius: BorderRadius.circular(radiusLg),
                        border: Border.all(
                          color: infoColor.withAlpha(30),
                          width: 1,
                        ),
                      ),
                      child: Column(
                        spacing: spSm,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.info_outline,
                                size: 20,
                                color: infoColor,
                              ),
                              SizedBox(width: spSm),
                              Text(
                                "Need Help?",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: infoColor,
                                ),
                              ),
                            ],
                          ),
                          Text(
                            "If you don't receive the email within a few minutes, please check your spam folder or contact our support team.",
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
            ),
    );
  }
}
