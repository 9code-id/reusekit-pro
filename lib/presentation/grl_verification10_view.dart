import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlVerification10View extends StatefulWidget {
  @override
  State<GrlVerification10View> createState() => _GrlVerification10ViewState();
}

class _GrlVerification10ViewState extends State<GrlVerification10View> {
  String selectedVerificationType = "";
  String email = "";
  String phoneNumber = "";
  String countryCode = "+1";
  String code = "";
  bool resendEnabled = false;
  int resendCountdown = 60;
  int currentStep = 0;
  bool isLoading = false;
  
  List<Map<String, dynamic>> verificationTypes = [
    {
      "title": "Email Verification",
      "description": "Verify your email address with a code",
      "icon": Icons.email,
      "type": "email",
      "required": true,
    },
    {
      "title": "Phone Verification",
      "description": "Verify your phone number with SMS",
      "icon": Icons.phone,
      "type": "phone",
      "required": true,
    },
    {
      "title": "Two-Factor Authentication", 
      "description": "Enhanced security with 2FA",
      "icon": Icons.security,
      "type": "2fa",
      "required": false,
    },
  ];

  @override
  void initState() {
    super.initState();
    _startCountdown();
  }

  void _startCountdown() {
    if (resendCountdown > 0) {
      Future.delayed(Duration(seconds: 1), () {
        if (mounted) {
          resendCountdown--;
          if (resendCountdown == 0) {
            resendEnabled = true;
          }
          setState(() {});
          if (resendCountdown > 0) {
            _startCountdown();
          }
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Multi-Step Verification"),
      ),
      body: Column(
        children: [
          // Progress Header
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [primaryColor, primaryColor.withAlpha(180)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              boxShadow: [shadowSm],
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.verified_user,
                      color: Colors.white,
                      size: 24,
                    ),
                    SizedBox(width: spMd),
                    Text(
                      "Account Security Setup",
                      style: TextStyle(
                        fontSize: fsH5,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spMd),
                Row(
                  children: List.generate(verificationTypes.length, (index) {
                    bool isActive = index <= currentStep;
                    bool isCompleted = index < currentStep;
                    
                    return Expanded(
                      child: Row(
                        children: [
                          Container(
                            width: 24,
                            height: 24,
                            decoration: BoxDecoration(
                              color: isCompleted 
                                  ? Colors.white 
                                  : isActive 
                                      ? Colors.white.withAlpha(200) 
                                      : Colors.white.withAlpha(100),
                              borderRadius: BorderRadius.circular(radiusLg),
                            ),
                            child: Center(
                              child: isCompleted
                                  ? Icon(
                                      Icons.check,
                                      color: primaryColor,
                                      size: 16,
                                    )
                                  : Text(
                                      "${index + 1}",
                                      style: TextStyle(
                                        color: isActive ? primaryColor : Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12,
                                      ),
                                    ),
                            ),
                          ),
                          if (index < verificationTypes.length - 1)
                            Expanded(
                              child: Container(
                                height: 2,
                                color: index < currentStep 
                                    ? Colors.white 
                                    : Colors.white.withAlpha(100),
                              ),
                            ),
                        ],
                      ),
                    );
                  }),
                ),
                SizedBox(height: spSm),
                Text(
                  currentStep < verificationTypes.length 
                      ? verificationTypes[currentStep]["title"] 
                      : "Verification Complete",
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white70,
                  ),
                ),
              ],
            ),
          ),
          
          // Content
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(spMd),
              child: _buildCurrentStep(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCurrentStep() {
    if (currentStep >= verificationTypes.length) {
      return _buildCompletionStep();
    }
    
    Map<String, dynamic> currentVerification = verificationTypes[currentStep];
    
    switch (currentVerification["type"]) {
      case "email":
        return _buildEmailVerificationStep();
      case "phone":
        return _buildPhoneVerificationStep();
      case "2fa":
        return _build2FAStep();
      default:
        return Container();
    }
  }

  Widget _buildEmailVerificationStep() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header Card
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(spLg),
          decoration: BoxDecoration(
            color: infoColor.withAlpha(20),
            borderRadius: BorderRadius.circular(radiusLg),
            border: Border.all(
              color: infoColor.withAlpha(60),
              width: 1,
            ),
          ),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: infoColor,
                  borderRadius: BorderRadius.circular(radiusLg),
                ),
                child: Icon(
                  Icons.email,
                  size: 32,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: spMd),
              Text(
                "Email Verification",
                style: TextStyle(
                  fontSize: fsH5,
                  fontWeight: FontWeight.bold,
                  color: infoColor,
                ),
              ),
              SizedBox(height: spSm),
              Text(
                "We'll send a verification code to your email address",
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
        
        SizedBox(height: spMd),
        
        if (code.isEmpty) ...[
          Container(
            width: double.infinity,
            child: QButton(
              label: "Send Verification Code",
              size: bs.md,
              onPressed: email.isNotEmpty && !isLoading ? () async {
                await _sendEmailCode();
              } : null,
            ),
          ),
        ] else ...[
          QTextField(
            label: "Verification Code",
            value: code,
            hint: "Enter 6-digit code",
            onChanged: (value) {
              code = value;
              setState(() {});
              if (value.length == 6) {
                _verifyEmailCode();
              }
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
                onTap: resendEnabled ? () async {
                  await _sendEmailCode();
                  resendCountdown = 60;
                  resendEnabled = false;
                  _startCountdown();
                } : null,
                child: Text(
                  resendEnabled ? "Resend Code" : "Resend in ${resendCountdown}s",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: resendEnabled ? primaryColor : disabledBoldColor,
                  ),
                ),
              ),
            ],
          ),
          
          SizedBox(height: spMd),
          
          Container(
            width: double.infinity,
            child: QButton(
              label: "Verify Email",
              size: bs.md,
              onPressed: code.length == 6 && !isLoading ? () async {
                await _verifyEmailCode();
              } : null,
            ),
          ),
        ],
        
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

  Widget _buildPhoneVerificationStep() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header Card
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(spLg),
          decoration: BoxDecoration(
            color: successColor.withAlpha(20),
            borderRadius: BorderRadius.circular(radiusLg),
            border: Border.all(
              color: successColor.withAlpha(60),
              width: 1,
            ),
          ),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: successColor,
                  borderRadius: BorderRadius.circular(radiusLg),
                ),
                child: Icon(
                  Icons.phone,
                  size: 32,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: spMd),
              Text(
                "Phone Verification",
                style: TextStyle(
                  fontSize: fsH5,
                  fontWeight: FontWeight.bold,
                  color: successColor,
                ),
              ),
              SizedBox(height: spSm),
              Text(
                "We'll send a verification code via SMS",
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
        
        if (code.isEmpty) ...[
          Container(
            width: double.infinity,
            child: QButton(
              label: "Send SMS Code",
              size: bs.md,
              onPressed: phoneNumber.isNotEmpty && !isLoading ? () async {
                await _sendSMSCode();
              } : null,
            ),
          ),
        ] else ...[
          QTextField(
            label: "SMS Code",
            value: code,
            hint: "Enter 6-digit SMS code",
            onChanged: (value) {
              code = value;
              setState(() {});
              if (value.length == 6) {
                _verifyPhoneCode();
              }
            },
          ),
          
          SizedBox(height: spMd),
          
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Didn't receive SMS?",
                style: TextStyle(
                  fontSize: 14,
                  color: disabledBoldColor,
                ),
              ),
              GestureDetector(
                onTap: resendEnabled ? () async {
                  await _sendSMSCode();
                  resendCountdown = 60;
                  resendEnabled = false;
                  _startCountdown();
                } : null,
                child: Text(
                  resendEnabled ? "Resend SMS" : "Resend in ${resendCountdown}s",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: resendEnabled ? primaryColor : disabledBoldColor,
                  ),
                ),
              ),
            ],
          ),
          
          SizedBox(height: spMd),
          
          Container(
            width: double.infinity,
            child: QButton(
              label: "Verify Phone",
              size: bs.md,
              onPressed: code.length == 6 && !isLoading ? () async {
                await _verifyPhoneCode();
              } : null,
            ),
          ),
        ],
        
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

  Widget _build2FAStep() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header Card
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(spLg),
          decoration: BoxDecoration(
            color: warningColor.withAlpha(20),
            borderRadius: BorderRadius.circular(radiusLg),
            border: Border.all(
              color: warningColor.withAlpha(60),
              width: 1,
            ),
          ),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: warningColor,
                  borderRadius: BorderRadius.circular(radiusLg),
                ),
                child: Icon(
                  Icons.security,
                  size: 32,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: spMd),
              Text(
                "Two-Factor Authentication",
                style: TextStyle(
                  fontSize: fsH5,
                  fontWeight: FontWeight.bold,
                  color: warningColor,
                ),
              ),
              SizedBox(height: spSm),
              Text(
                "Add an extra layer of security to your account",
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
        
        // 2FA Options
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
                "Choose your preferred 2FA method:",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: spMd),
              
              _build2FAOption(
                "Authenticator App",
                "Use Google Authenticator or similar apps",
                Icons.phone_android,
                () => _setup2FA("app"),
              ),
              
              SizedBox(height: spMd),
              
              _build2FAOption(
                "SMS Codes",
                "Receive codes via SMS to your phone",
                Icons.sms,
                () => _setup2FA("sms"),
              ),
              
              SizedBox(height: spMd),
              
              _build2FAOption(
                "Email Codes",
                "Receive codes via email",
                Icons.email,
                () => _setup2FA("email"),
              ),
            ],
          ),
        ),
        
        SizedBox(height: spLg),
        
        // Skip Option
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(spMd),
          decoration: BoxDecoration(
            color: infoColor.withAlpha(20),
            borderRadius: BorderRadius.circular(radiusLg),
          ),
          child: Column(
            children: [
              Text(
                "Optional Step",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: infoColor,
                ),
              ),
              SizedBox(height: spSm),
              Text(
                "You can set up 2FA later in your security settings",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
              SizedBox(height: spMd),
              QButton(
                label: "Skip for Now",
                size: bs.md,
                onPressed: () {
                  currentStep++;
                  setState(() {});
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _build2FAOption(String title, String description, IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
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
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: primaryColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusLg),
              ),
              child: Icon(
                icon,
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
                    title,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: spXs),
                  Text(
                    description,
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.chevron_right,
              color: disabledBoldColor,
              size: 20,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCompletionStep() {
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
                Icons.verified_user,
                size: 40,
                color: Colors.white,
              ),
            ),
          ),
        ),
        
        SizedBox(height: spLg),
        
        Text(
          "Verification Complete!",
          style: TextStyle(
            fontSize: fsH4,
            fontWeight: FontWeight.bold,
            color: successColor,
          ),
        ),
        
        SizedBox(height: spMd),
        
        Text(
          "Your account is now fully verified and secure",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 14,
            color: disabledBoldColor,
          ),
        ),
        
        SizedBox(height: spLg),
        
        // Verification Summary
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
              _buildVerificationStatus("Email Verified", email, Icons.email, successColor),
              Divider(height: 1, color: disabledColor),
              _buildVerificationStatus("Phone Verified", "$countryCode $phoneNumber", Icons.phone, successColor),
              Divider(height: 1, color: disabledColor),
              _buildVerificationStatus("2FA Status", "Optional - Not set up", Icons.security, disabledBoldColor),
            ],
          ),
        ),
        
        SizedBox(height: spXl),
        
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

  Widget _buildVerificationStatus(String title, String value, IconData icon, Color color) {
    return Padding(
      padding: EdgeInsets.all(spMd),
      child: Row(
        children: [
          Icon(
            icon,
            color: color,
            size: 20,
          ),
          SizedBox(width: spMd),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: spXs),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
          if (color == successColor)
            Icon(
              Icons.check_circle,
              color: successColor,
              size: 16,
            ),
        ],
      ),
    );
  }

  Future<void> _sendEmailCode() async {
    isLoading = true;
    setState(() {});
    
    // Simulate API call
    await Future.delayed(Duration(seconds: 2));
    
    isLoading = false;
    code = "";
    setState(() {});
    
    ss("Verification code sent to $email");
  }

  Future<void> _verifyEmailCode() async {
    isLoading = true;
    setState(() {});
    
    // Simulate API call
    await Future.delayed(Duration(seconds: 2));
    
    isLoading = false;
    currentStep++;
    code = "";
    setState(() {});
    
    ss("Email verified successfully!");
  }

  Future<void> _sendSMSCode() async {
    isLoading = true;
    setState(() {});
    
    // Simulate API call
    await Future.delayed(Duration(seconds: 2));
    
    isLoading = false;
    code = "";
    setState(() {});
    
    ss("SMS code sent to $countryCode $phoneNumber");
  }

  Future<void> _verifyPhoneCode() async {
    isLoading = true;
    setState(() {});
    
    // Simulate API call
    await Future.delayed(Duration(seconds: 2));
    
    isLoading = false;
    currentStep++;
    code = "";
    setState(() {});
    
    ss("Phone verified successfully!");
  }

  void _setup2FA(String method) {
    ss("Setting up 2FA with $method");
    currentStep++;
    setState(() {});
  }
}
