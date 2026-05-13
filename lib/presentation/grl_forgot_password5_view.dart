import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlForgotPassword5View extends StatefulWidget {
  @override
  State<GrlForgotPassword5View> createState() => _GrlForgotPassword5ViewState();
}

class _GrlForgotPassword5ViewState extends State<GrlForgotPassword5View> {
  final formKey = GlobalKey<FormState>();
  String email = "";
  bool loading = false;
  bool emailSent = false;
  int countdown = 60;

  @override
  void initState() {
    super.initState();
    if (emailSent) {
      _startCountdown();
    }
  }

  void _startCountdown() {
    Future.doWhile(() async {
      await Future.delayed(Duration(seconds: 1));
      if (mounted && countdown > 0) {
        countdown--;
        setState(() {});
        return true;
      }
      return false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: loading
          ? Center(child: CircularProgressIndicator())
          : Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    primaryColor.withAlpha(5),
                    Colors.white,
                  ],
                ),
              ),
              child: SingleChildScrollView(
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
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(radiusSm),
                            boxShadow: [shadowSm],
                          ),
                          child: Icon(
                            Icons.arrow_back,
                            color: primaryColor,
                            size: 20,
                          ),
                        ),
                      ),
                      
                      SizedBox(height: spXl),
                      
                      if (!emailSent) ...[
                        // Initial State
                        
                        // Hero Illustration
                        Center(
                          child: Column(
                            spacing: spLg,
                            children: [
                              Container(
                                width: 150,
                                height: 150,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(radius3xl),
                                  boxShadow: [shadowLg],
                                ),
                                child: Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    Container(
                                      width: 100,
                                      height: 100,
                                      decoration: BoxDecoration(
                                        color: primaryColor.withAlpha(10),
                                        borderRadius: BorderRadius.circular(radius2xl),
                                      ),
                                    ),
                                    Icon(
                                      Icons.security,
                                      size: 60,
                                      color: primaryColor,
                                    ),
                                  ],
                                ),
                              ),
                              
                              Column(
                                spacing: spSm,
                                children: [
                                  Text(
                                    "Secure Password Reset",
                                    style: TextStyle(
                                      fontSize: fsH2,
                                      fontWeight: FontWeight.bold,
                                      color: primaryColor,
                                    ),
                                  ),
                                  Text(
                                    "Your account security is our priority. Enter your email to receive a secure reset link.",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: disabledBoldColor,
                                      height: 1.5,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        
                        SizedBox(height: sp2xl),
                        
                        // Email Input
                        Container(
                          padding: EdgeInsets.all(spMd),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(radiusLg),
                            boxShadow: [shadowSm],
                          ),
                          child: Column(
                            spacing: spMd,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Email Address",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: primaryColor,
                                ),
                              ),
                              QTextField(
                                label: "Enter your email",
                                value: email,
                                hint: "example@domain.com",
                                validator: Validator.email,
                                onChanged: (value) {
                                  email = value;
                                  setState(() {});
                                },
                              ),
                            ],
                          ),
                        ),
                        
                        SizedBox(height: spXl),
                        
                        // Send Link Button
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
                                emailSent = true;
                                countdown = 60;
                                _startCountdown();
                                setState(() {});
                                
                                ss("Reset link sent successfully!");
                              }
                            },
                          ),
                        ),
                      ] else ...[
                        // Email Sent State
                        
                        // Success Illustration
                        Center(
                          child: Column(
                            spacing: spLg,
                            children: [
                              Container(
                                width: 150,
                                height: 150,
                                decoration: BoxDecoration(
                                  color: successColor.withAlpha(10),
                                  borderRadius: BorderRadius.circular(radius3xl),
                                  border: Border.all(
                                    color: successColor.withAlpha(30),
                                    width: 3,
                                  ),
                                ),
                                child: Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    Icon(
                                      Icons.email,
                                      size: 60,
                                      color: successColor,
                                    ),
                                    Positioned(
                                      top: 30,
                                      right: 30,
                                      child: Container(
                                        width: 30,
                                        height: 30,
                                        decoration: BoxDecoration(
                                          color: successColor,
                                          borderRadius: BorderRadius.circular(radiusLg),
                                        ),
                                        child: Icon(
                                          Icons.check,
                                          color: Colors.white,
                                          size: 16,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              
                              Column(
                                spacing: spSm,
                                children: [
                                  Text(
                                    "Email Sent!",
                                    style: TextStyle(
                                      fontSize: fsH2,
                                      fontWeight: FontWeight.bold,
                                      color: successColor,
                                    ),
                                  ),
                                  Text(
                                    "We've sent a password reset link to:",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: spMd,
                                      vertical: spSm,
                                    ),
                                    decoration: BoxDecoration(
                                      color: primaryColor.withAlpha(10),
                                      borderRadius: BorderRadius.circular(radiusSm),
                                    ),
                                    child: Text(
                                      email,
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: primaryColor,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        
                        SizedBox(height: sp2xl),
                        
                        // Instructions
                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.all(spMd),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(radiusLg),
                            boxShadow: [shadowSm],
                          ),
                          child: Column(
                            spacing: spMd,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.info_outline,
                                    color: infoColor,
                                    size: 20,
                                  ),
                                  SizedBox(width: spSm),
                                  Text(
                                    "Next Steps",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: infoColor,
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                "1. Check your email inbox\n2. Click the reset link in the email\n3. Create your new password\n4. Sign in with your new credentials",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: disabledBoldColor,
                                  height: 1.5,
                                ),
                              ),
                            ],
                          ),
                        ),
                        
                        SizedBox(height: spLg),
                        
                        // Resend Section
                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.all(spMd),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(radiusLg),
                            border: Border.all(
                              color: disabledOutlineBorderColor,
                              width: 1,
                            ),
                          ),
                          child: Column(
                            spacing: spSm,
                            children: [
                              Text(
                                "Didn't receive the email?",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: disabledBoldColor,
                                ),
                              ),
                              if (countdown > 0)
                                Text(
                                  "Resend available in ${countdown}s",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                )
                              else
                                QButton(
                                  label: "Resend Email",
                                  size: bs.sm,
                                  onPressed: () async {
                                    loading = true;
                                    setState(() {});
                                    
                                    await Future.delayed(Duration(seconds: 1));
                                    
                                    loading = false;
                                    countdown = 60;
                                    _startCountdown();
                                    setState(() {});
                                    
                                    ss("Email resent successfully!");
                                  },
                                ),
                            ],
                          ),
                        ),
                      ],
                      
                      SizedBox(height: spXl),
                      
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
            ),
    );
  }
}
