import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlForgotPassword6View extends StatefulWidget {
  @override
  State<GrlForgotPassword6View> createState() => _GrlForgotPassword6ViewState();
}

class _GrlForgotPassword6ViewState extends State<GrlForgotPassword6View> {
  final formKey = GlobalKey<FormState>();
  String phoneNumber = "";
  String verificationCode = "";
  bool loading = false;
  bool codeSent = false;
  int countdown = 30;

  @override
  void initState() {
    super.initState();
    if (codeSent) {
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
      appBar: AppBar(
        title: Text("Reset via SMS"),
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
                    
                    // Phone Icon Header
                    Center(
                      child: Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          gradient: RadialGradient(
                            colors: [
                              primaryColor.withAlpha(20),
                              primaryColor.withAlpha(5),
                            ],
                          ),
                          borderRadius: BorderRadius.circular(radius2xl),
                        ),
                        child: Icon(
                          Icons.phone_android,
                          size: 50,
                          color: primaryColor,
                        ),
                      ),
                    ),
                    
                    SizedBox(height: spLg),
                    
                    if (!codeSent) ...[
                      // Phone Number Input Step
                      
                      // Title
                      Center(
                        child: Column(
                          spacing: spSm,
                          children: [
                            Text(
                              "Reset via SMS",
                              style: TextStyle(
                                fontSize: fsH3,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              "We'll send a verification code to your phone number to reset your password.",
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
                      
                      // Country Code & Phone Number
                      Column(
                        spacing: spSm,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Phone Number",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: primaryColor,
                            ),
                          ),
                          Row(
                            children: [
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: spMd,
                                  vertical: spSm,
                                ),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: disabledOutlineBorderColor,
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(radiusLg),
                                ),
                                child: Row(
                                  children: [
                                    Text(
                                      "🇺🇸",
                                      style: TextStyle(fontSize: 16),
                                    ),
                                    SizedBox(width: spXs),
                                    Text(
                                      "+1",
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
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
                                  hint: "(555) 123-4567",
                                  validator: Validator.required,
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
                      
                      SizedBox(height: spMd),
                      
                      // Info Card
                      Container(
                        padding: EdgeInsets.all(spMd),
                        decoration: BoxDecoration(
                          color: infoColor.withAlpha(5),
                          borderRadius: BorderRadius.circular(radiusLg),
                          border: Border.all(
                            color: infoColor.withAlpha(20),
                            width: 1,
                          ),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.info_outline,
                              color: infoColor,
                              size: 20,
                            ),
                            SizedBox(width: spSm),
                            Expanded(
                              child: Text(
                                "Standard messaging rates may apply. The verification code will expire in 10 minutes.",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: infoColor,
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
                          onPressed: () async {
                            if (formKey.currentState!.validate()) {
                              loading = true;
                              setState(() {});
                              
                              // Simulate SMS sending
                              await Future.delayed(Duration(seconds: 2));
                              
                              loading = false;
                              codeSent = true;
                              countdown = 30;
                              _startCountdown();
                              setState(() {});
                              
                              ss("Verification code sent to your phone!");
                            }
                          },
                        ),
                      ),
                    ] else ...[
                      // Verification Code Input Step
                      
                      // Title
                      Center(
                        child: Column(
                          spacing: spSm,
                          children: [
                            Text(
                              "Enter Verification Code",
                              style: TextStyle(
                                fontSize: fsH3,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            RichText(
                              textAlign: TextAlign.center,
                              text: TextSpan(
                                style: TextStyle(
                                  fontSize: 14,
                                  color: disabledBoldColor,
                                  height: 1.4,
                                ),
                                children: [
                                  TextSpan(text: "We've sent a 6-digit code to "),
                                  TextSpan(
                                    text: "+1 $phoneNumber",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: primaryColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      
                      SizedBox(height: sp2xl),
                      
                      // Verification Code Input
                      QTextField(
                        label: "Verification Code",
                        value: verificationCode,
                        hint: "Enter 6-digit code",
                        validator: Validator.required,
                        onChanged: (value) {
                          verificationCode = value;
                          setState(() {});
                        },
                      ),
                      
                      SizedBox(height: spMd),
                      
                      // Resend Timer
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(spMd),
                        decoration: BoxDecoration(
                          color: Colors.grey.withAlpha(5),
                          borderRadius: BorderRadius.circular(radiusLg),
                        ),
                        child: Column(
                          spacing: spSm,
                          children: [
                            Text(
                              "Didn't receive the code?",
                              style: TextStyle(
                                fontSize: 14,
                                color: disabledBoldColor,
                              ),
                            ),
                            if (countdown > 0)
                              Text(
                                "Resend code in ${countdown}s",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              )
                            else
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  GestureDetector(
                                    onTap: () async {
                                      loading = true;
                                      setState(() {});
                                      
                                      await Future.delayed(Duration(seconds: 1));
                                      
                                      loading = false;
                                      countdown = 30;
                                      _startCountdown();
                                      setState(() {});
                                      
                                      ss("New code sent!");
                                    },
                                    child: Text(
                                      "Resend SMS",
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: primaryColor,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    height: 20,
                                    width: 1,
                                    color: disabledColor,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      codeSent = false;
                                      phoneNumber = "";
                                      verificationCode = "";
                                      setState(() {});
                                    },
                                    child: Text(
                                      "Change Number",
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: primaryColor,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                          ],
                        ),
                      ),
                      
                      SizedBox(height: spXl),
                      
                      // Verify Button
                      Container(
                        width: double.infinity,
                        child: QButton(
                          label: "Verify & Continue",
                          size: bs.md,
                          onPressed: () async {
                            if (formKey.currentState!.validate()) {
                              loading = true;
                              setState(() {});
                              
                              // Simulate verification
                              await Future.delayed(Duration(seconds: 2));
                              
                              loading = false;
                              setState(() {});
                              
                              ss("Phone number verified!");
                              // navigateTo(NewPasswordView());
                            }
                          },
                        ),
                      ),
                    ],
                    
                    SizedBox(height: spXl),
                    
                    // Alternative Recovery Methods
                    Column(
                      spacing: spMd,
                      children: [
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
                        
                        // Email Recovery Option
                        GestureDetector(
                          onTap: () {
                            // navigateTo(EmailRecoveryView());
                          },
                          child: Container(
                            width: double.infinity,
                            padding: EdgeInsets.all(spMd),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: disabledOutlineBorderColor,
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(radiusLg),
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.email_outlined,
                                  color: primaryColor,
                                  size: 20,
                                ),
                                SizedBox(width: spMd),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Use Email Instead",
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          color: primaryColor,
                                        ),
                                      ),
                                      Text(
                                        "Reset password via email",
                                        style: TextStyle(
                                          fontSize: 12,
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
                        ),
                      ],
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
