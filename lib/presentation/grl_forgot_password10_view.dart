import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlForgotPassword10View extends StatefulWidget {
  @override
  State<GrlForgotPassword10View> createState() => _GrlForgotPassword10ViewState();
}

class _GrlForgotPassword10ViewState extends State<GrlForgotPassword10View> {
  final formKey = GlobalKey<FormState>();
  String emailOrPhone = "";
  String selectedMethod = "email";
  bool loading = false;
  int currentStep = 1; // 1: method selection, 2: input, 3: verification sent
  int resendCountdown = 0;

  final List<Map<String, dynamic>> recoveryMethods = [
    {
      "id": "email",
      "title": "Email Recovery",
      "description": "Get a reset link via email",
      "icon": Icons.email,
      "color": primaryColor,
      "timeEstimate": "Instant delivery",
    },
    {
      "id": "sms",
      "title": "SMS Recovery",
      "description": "Get a verification code via SMS",
      "icon": Icons.sms,
      "color": successColor,
      "timeEstimate": "1-2 minutes",
    },
    {
      "id": "security",
      "title": "Security Questions",
      "description": "Answer your security questions",
      "icon": Icons.quiz,
      "color": warningColor,
      "timeEstimate": "Immediate",
    },
    {
      "id": "support",
      "title": "Contact Support",
      "description": "Get help from our team",
      "icon": Icons.support_agent,
      "color": infoColor,
      "timeEstimate": "2-4 hours",
    },
  ];

  @override
  void initState() {
    super.initState();
    if (resendCountdown > 0) {
      _startCountdown();
    }
  }

  void _startCountdown() {
    Future.doWhile(() async {
      await Future.delayed(Duration(seconds: 1));
      if (mounted && resendCountdown > 0) {
        resendCountdown--;
        setState(() {});
        return true;
      }
      return false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              primaryColor.withAlpha(3),
              Colors.white,
            ],
          ),
        ),
        child: loading
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
                        onTap: () {
                          if (currentStep > 1) {
                            currentStep--;
                            setState(() {});
                          } else {
                            back();
                          }
                        },
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
                      
                      SizedBox(height: spLg),
                      
                      // Progress Indicator
                      Row(
                        children: List.generate(3, (index) {
                          return Expanded(
                            child: Container(
                              margin: EdgeInsets.only(right: index < 2 ? spXs : 0),
                              height: 4,
                              decoration: BoxDecoration(
                                color: index < currentStep ? primaryColor : disabledColor,
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                            ),
                          );
                        }),
                      ),
                      
                      SizedBox(height: spXl),
                      
                      if (currentStep == 1) ...[
                        // Step 1: Method Selection
                        
                        // Header
                        Column(
                          spacing: spMd,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Account Recovery",
                              style: TextStyle(
                                fontSize: fsH1,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              "Choose how you'd like to recover your account. We'll guide you through the process step by step.",
                              style: TextStyle(
                                fontSize: 16,
                                color: disabledBoldColor,
                                height: 1.4,
                              ),
                            ),
                          ],
                        ),
                        
                        SizedBox(height: sp2xl),
                        
                        // Recovery Methods Grid
                        Column(
                          spacing: spMd,
                          children: recoveryMethods.map((method) {
                            final isSelected = selectedMethod == method["id"];
                            return GestureDetector(
                              onTap: () {
                                selectedMethod = method["id"];
                                setState(() {});
                              },
                              child: Container(
                                width: double.infinity,
                                padding: EdgeInsets.all(spLg),
                                decoration: BoxDecoration(
                                  color: isSelected ? method["color"].withAlpha(5) : Colors.white,
                                  border: Border.all(
                                    color: isSelected ? method["color"] : disabledOutlineBorderColor,
                                    width: isSelected ? 2 : 1,
                                  ),
                                  borderRadius: BorderRadius.circular(radiusLg),
                                  boxShadow: isSelected ? [shadowMd] : [shadowSm],
                                ),
                                child: Row(
                                  children: [
                                    Container(
                                      width: 60,
                                      height: 60,
                                      decoration: BoxDecoration(
                                        color: isSelected ? method["color"] : method["color"].withAlpha(20),
                                        borderRadius: BorderRadius.circular(radiusLg),
                                      ),
                                      child: Icon(
                                        method["icon"],
                                        color: isSelected ? Colors.white : method["color"],
                                        size: 28,
                                      ),
                                    ),
                                    SizedBox(width: spLg),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            method["title"],
                                            style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                              color: isSelected ? method["color"] : primaryColor,
                                            ),
                                          ),
                                          SizedBox(height: spXs),
                                          Text(
                                            method["description"],
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: disabledBoldColor,
                                            ),
                                          ),
                                          SizedBox(height: spXs),
                                          Row(
                                            children: [
                                              Icon(
                                                Icons.schedule,
                                                size: 14,
                                                color: method["color"],
                                              ),
                                              SizedBox(width: spXs),
                                              Text(
                                                method["timeEstimate"],
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  color: method["color"],
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    if (isSelected)
                                      Container(
                                        width: 24,
                                        height: 24,
                                        decoration: BoxDecoration(
                                          color: method["color"],
                                          borderRadius: BorderRadius.circular(radiusLg),
                                        ),
                                        child: Icon(
                                          Icons.check,
                                          color: Colors.white,
                                          size: 16,
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                        
                        SizedBox(height: spXl),
                        
                        // Continue Button
                        Container(
                          width: double.infinity,
                          child: QButton(
                            label: "Continue",
                            size: bs.md,
                            onPressed: () {
                              currentStep = 2;
                              setState(() {});
                            },
                          ),
                        ),
                      ] else if (currentStep == 2) ...[
                        // Step 2: Information Input
                        
                        // Header
                        Column(
                          spacing: spMd,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Container(
                                  width: 50,
                                  height: 50,
                                  decoration: BoxDecoration(
                                    color: recoveryMethods.firstWhere((m) => m["id"] == selectedMethod)["color"].withAlpha(20),
                                    borderRadius: BorderRadius.circular(radiusLg),
                                  ),
                                  child: Icon(
                                    recoveryMethods.firstWhere((m) => m["id"] == selectedMethod)["icon"],
                                    color: recoveryMethods.firstWhere((m) => m["id"] == selectedMethod)["color"],
                                    size: 24,
                                  ),
                                ),
                                SizedBox(width: spMd),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        recoveryMethods.firstWhere((m) => m["id"] == selectedMethod)["title"],
                                        style: TextStyle(
                                          fontSize: fsH4,
                                          fontWeight: FontWeight.bold,
                                          color: primaryColor,
                                        ),
                                      ),
                                      Text(
                                        "Enter your details below",
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        
                        SizedBox(height: sp2xl),
                        
                        // Input Field
                        Container(
                          padding: EdgeInsets.all(spLg),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(radiusLg),
                            boxShadow: [shadowMd],
                          ),
                          child: Column(
                            spacing: spMd,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (selectedMethod == "email") ...[
                                Text(
                                  "Email Address",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: primaryColor,
                                  ),
                                ),
                                QTextField(
                                  label: "Enter your email address",
                                  value: emailOrPhone,
                                  hint: "example@domain.com",
                                  validator: Validator.email,
                                  onChanged: (value) {
                                    emailOrPhone = value;
                                    setState(() {});
                                  },
                                ),
                              ] else if (selectedMethod == "sms") ...[
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
                                      child: Text(
                                        "+1",
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                          color: primaryColor,
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: spMd),
                                    Expanded(
                                      child: QTextField(
                                        label: "Phone number",
                                        value: emailOrPhone,
                                        hint: "(555) 123-4567",
                                        validator: Validator.required,
                                        onChanged: (value) {
                                          emailOrPhone = value;
                                          setState(() {});
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ] else if (selectedMethod == "security") ...[
                                Text(
                                  "Username or Email",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: primaryColor,
                                  ),
                                ),
                                QTextField(
                                  label: "Enter username or email",
                                  value: emailOrPhone,
                                  hint: "username or email@domain.com",
                                  validator: Validator.required,
                                  onChanged: (value) {
                                    emailOrPhone = value;
                                    setState(() {});
                                  },
                                ),
                              ] else if (selectedMethod == "support") ...[
                                Text(
                                  "Contact Email",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: primaryColor,
                                  ),
                                ),
                                QTextField(
                                  label: "Enter your email for support",
                                  value: emailOrPhone,
                                  hint: "your.email@domain.com",
                                  validator: Validator.email,
                                  onChanged: (value) {
                                    emailOrPhone = value;
                                    setState(() {});
                                  },
                                ),
                              ],
                              
                              // Help Text
                              Container(
                                padding: EdgeInsets.all(spMd),
                                decoration: BoxDecoration(
                                  color: recoveryMethods.firstWhere((m) => m["id"] == selectedMethod)["color"].withAlpha(5),
                                  borderRadius: BorderRadius.circular(radiusLg),
                                ),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.info_outline,
                                      color: recoveryMethods.firstWhere((m) => m["id"] == selectedMethod)["color"],
                                      size: 16,
                                    ),
                                    SizedBox(width: spSm),
                                    Expanded(
                                      child: Text(
                                        _getHelpText(),
                                        style: TextStyle(
                                          fontSize: 12,
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
                        
                        SizedBox(height: spXl),
                        
                        // Send/Proceed Button
                        Container(
                          width: double.infinity,
                          child: QButton(
                            label: _getButtonText(),
                            size: bs.md,
                            onPressed: () async {
                              if (formKey.currentState!.validate()) {
                                loading = true;
                                setState(() {});
                                
                                // Simulate processing
                                await Future.delayed(Duration(seconds: 2));
                                
                                loading = false;
                                currentStep = 3;
                                if (selectedMethod == "email" || selectedMethod == "sms") {
                                  resendCountdown = 60;
                                  _startCountdown();
                                }
                                setState(() {});
                                
                                ss(_getSuccessMessage());
                              }
                            },
                          ),
                        ),
                      ] else ...[
                        // Step 3: Confirmation/Success
                        
                        Center(
                          child: Column(
                            spacing: spLg,
                            children: [
                              Container(
                                width: 150,
                                height: 150,
                                decoration: BoxDecoration(
                                  color: recoveryMethods.firstWhere((m) => m["id"] == selectedMethod)["color"].withAlpha(10),
                                  borderRadius: BorderRadius.circular(radius3xl),
                                  border: Border.all(
                                    color: recoveryMethods.firstWhere((m) => m["id"] == selectedMethod)["color"].withAlpha(30),
                                    width: 3,
                                  ),
                                ),
                                child: Icon(
                                  selectedMethod == "support" ? Icons.mail_outline : Icons.check_circle_outline,
                                  size: 80,
                                  color: recoveryMethods.firstWhere((m) => m["id"] == selectedMethod)["color"],
                                ),
                              ),
                              
                              Column(
                                spacing: spSm,
                                children: [
                                  Text(
                                    _getConfirmationTitle(),
                                    style: TextStyle(
                                      fontSize: fsH2,
                                      fontWeight: FontWeight.bold,
                                      color: recoveryMethods.firstWhere((m) => m["id"] == selectedMethod)["color"],
                                    ),
                                  ),
                                  Text(
                                    _getConfirmationMessage(),
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: disabledBoldColor,
                                      height: 1.4,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        
                        SizedBox(height: sp2xl),
                        
                        // Next Steps
                        Container(
                          padding: EdgeInsets.all(spLg),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(radiusLg),
                            boxShadow: [shadowMd],
                          ),
                          child: Column(
                            spacing: spMd,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.checklist,
                                    color: infoColor,
                                    size: 24,
                                  ),
                                  SizedBox(width: spSm),
                                  Text(
                                    "What's Next?",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: infoColor,
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                _getNextStepsText(),
                                style: TextStyle(
                                  fontSize: 14,
                                  color: disabledBoldColor,
                                  height: 1.5,
                                ),
                              ),
                            ],
                          ),
                        ),
                        
                        if (selectedMethod == "email" || selectedMethod == "sms") ...[
                          SizedBox(height: spMd),
                          
                          // Resend Option
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
                                  "Didn't receive anything?",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                if (resendCountdown > 0)
                                  Text(
                                    "Resend available in ${resendCountdown}s",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                  )
                                else
                                  QButton(
                                    label: "Resend ${selectedMethod == 'email' ? 'Email' : 'SMS'}",
                                    size: bs.sm,
                                    onPressed: () async {
                                      loading = true;
                                      setState(() {});
                                      
                                      await Future.delayed(Duration(seconds: 1));
                                      
                                      loading = false;
                                      resendCountdown = 60;
                                      _startCountdown();
                                      setState(() {});
                                      
                                      ss("${selectedMethod == 'email' ? 'Email' : 'SMS'} resent successfully!");
                                    },
                                  ),
                              ],
                            ),
                          ),
                        ],
                        
                        SizedBox(height: spXl),
                        
                        // Try Different Method
                        Center(
                          child: GestureDetector(
                            onTap: () {
                              currentStep = 1;
                              emailOrPhone = "";
                              setState(() {});
                            },
                            child: Text(
                              "Try Different Method",
                              style: TextStyle(
                                fontSize: 14,
                                color: primaryColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ],
                      
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
      ),
    );
  }

  String _getHelpText() {
    switch (selectedMethod) {
      case "email":
        return "We'll send a secure reset link to this email address";
      case "sms":
        return "We'll send a verification code to this phone number";
      case "security":
        return "We'll show you your security question after verification";
      case "support":
        return "Our team will contact you within 2-4 business hours";
      default:
        return "";
    }
  }

  String _getButtonText() {
    switch (selectedMethod) {
      case "email":
        return "Send Reset Link";
      case "sms":
        return "Send Verification Code";
      case "security":
        return "Get Security Question";
      case "support":
        return "Contact Support";
      default:
        return "Continue";
    }
  }

  String _getSuccessMessage() {
    switch (selectedMethod) {
      case "email":
        return "Reset link sent to your email!";
      case "sms":
        return "Verification code sent to your phone!";
      case "security":
        return "Security question retrieved!";
      case "support":
        return "Support request submitted!";
      default:
        return "Request processed successfully!";
    }
  }

  String _getConfirmationTitle() {
    switch (selectedMethod) {
      case "email":
        return "Check Your Email";
      case "sms":
        return "Check Your Phone";
      case "security":
        return "Security Question";
      case "support":
        return "Request Submitted";
      default:
        return "Success";
    }
  }

  String _getConfirmationMessage() {
    switch (selectedMethod) {
      case "email":
        return "We've sent a password reset link to $emailOrPhone. Click the link in the email to continue.";
      case "sms":
        return "We've sent a verification code to $emailOrPhone. Enter the code to continue with password reset.";
      case "security":
        return "Answer your security question to verify your identity and proceed with password reset.";
      case "support":
        return "We've received your support request. Our team will contact you at $emailOrPhone within 2-4 hours.";
      default:
        return "Your request has been processed successfully.";
    }
  }

  String _getNextStepsText() {
    switch (selectedMethod) {
      case "email":
        return "1. Check your email inbox (and spam folder)\n2. Click the reset link in the email\n3. Create your new password\n4. Sign in with new credentials";
      case "sms":
        return "1. Check your phone for the SMS\n2. Enter the verification code\n3. Create your new password\n4. Sign in with new credentials";
      case "security":
        return "1. Answer your security question correctly\n2. Verify your identity\n3. Create your new password\n4. Sign in with new credentials";
      case "support":
        return "1. Our team will review your request\n2. We'll contact you via email\n3. Follow the instructions provided\n4. Complete the password reset process";
      default:
        return "";
    }
  }
}
