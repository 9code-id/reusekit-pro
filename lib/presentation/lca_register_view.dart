import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class LcaRegisterView extends StatefulWidget {
  const LcaRegisterView({super.key});

  @override
  State<LcaRegisterView> createState() => _LcaRegisterViewState();
}

class _LcaRegisterViewState extends State<LcaRegisterView> {
  final formKey = GlobalKey<FormState>();
  String firstName = "";
  String lastName = "";
  String email = "";
  String phone = "";
  String password = "";
  String confirmPassword = "";
  bool obscurePassword = true;
  bool obscureConfirmPassword = true;
  bool agreeToTerms = false;
  bool subscribeNewsletter = false;
  bool loading = false;
  int currentStep = 0;

  List<String> registrationSteps = [
    "Personal Information",
    "Account Security",
    "Terms & Preferences"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              primaryColor.withAlpha(25),
              Colors.white,
              Colors.white,
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Header
              Container(
                padding: EdgeInsets.all(spMd),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        back();
                      },
                      child: Icon(Icons.arrow_back, color: primaryColor),
                    ),
                    SizedBox(width: spSm),
                    Text(
                      "Create Account",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Spacer(),
                    GestureDetector(
                      onTap: () {
                        //navigateTo(LcaLoginView());
                      },
                      child: Text(
                        "Sign In",
                        style: TextStyle(
                          fontSize: 16,
                          color: primaryColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Progress Indicator
              Container(
                padding: EdgeInsets.symmetric(horizontal: spMd),
                child: Row(
                  children: List.generate(
                    registrationSteps.length,
                    (index) => _buildStepIndicator(index),
                  ),
                ),
              ),

              SizedBox(height: spMd),

              // Current Step Title
              Container(
                padding: EdgeInsets.symmetric(horizontal: spMd),
                child: Text(
                  registrationSteps[currentStep],
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
              ),

              SizedBox(height: spMd),

              // Form Content
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.all(spMd),
                  child: Form(
                    key: formKey,
                    child: _buildCurrentStepContent(),
                  ),
                ),
              ),

              // Bottom Navigation
              Container(
                padding: EdgeInsets.all(spMd),
                child: Column(
                  children: [
                    if (loading)
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(spMd),
                        child: Center(
                          child: CircularProgressIndicator(color: primaryColor),
                        ),
                      )
                    else
                      Row(
                        spacing: spSm,
                        children: [
                          if (currentStep > 0)
                            Expanded(
                              child: QButton(
                                label: "Previous",
                                color: disabledBoldColor,
                                size: bs.md,
                                onPressed: () {
                                  currentStep--;
                                  setState(() {});
                                },
                              ),
                            ),
                          Expanded(
                            child: QButton(
                              label: currentStep == registrationSteps.length - 1
                                  ? "Create Account"
                                  : "Continue",
                              size: bs.md,
                              onPressed: () {
                                _handleNextStep();
                              },
                            ),
                          ),
                        ],
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

  Widget _buildStepIndicator(int index) {
    bool isActive = index <= currentStep;
    bool isCurrent = index == currentStep;

    return Expanded(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 2),
        child: Column(
          children: [
            Container(
              height: 4,
              decoration: BoxDecoration(
                color: isActive ? primaryColor : disabledColor,
                borderRadius: BorderRadius.circular(radiusXs),
              ),
            ),
            SizedBox(height: spXs),
            Text(
              "${index + 1}",
              style: TextStyle(
                fontSize: 12,
                fontWeight: isCurrent ? FontWeight.bold : FontWeight.normal,
                color: isActive ? primaryColor : disabledBoldColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCurrentStepContent() {
    switch (currentStep) {
      case 0:
        return _buildPersonalInfoStep();
      case 1:
        return _buildSecurityStep();
      case 2:
        return _buildTermsStep();
      default:
        return Container();
    }
  }

  Widget _buildPersonalInfoStep() {
    return Column(
      spacing: spMd,
      children: [
        // Profile Image Placeholder
        Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            color: primaryColor.withAlpha(25),
            borderRadius: BorderRadius.circular(radius2xl),
            border: Border.all(color: primaryColor.withAlpha(80)),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.camera_alt, color: primaryColor, size: 24),
              SizedBox(height: spXs),
              Text(
                "Add Photo",
                style: TextStyle(
                  fontSize: 12,
                  color: primaryColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
        
        SizedBox(height: spMd),

        // Name Fields
        Row(
          spacing: spSm,
          children: [
            Expanded(
              child: QTextField(
                label: "First Name",
                value: firstName,
                hint: "Enter first name",
                validator: Validator.required,
                onChanged: (value) {
                  firstName = value;
                  setState(() {});
                },
              ),
            ),
            Expanded(
              child: QTextField(
                label: "Last Name",
                value: lastName,
                hint: "Enter last name",
                validator: Validator.required,
                onChanged: (value) {
                  lastName = value;
                  setState(() {});
                },
              ),
            ),
          ],
        ),

        // Email Field
        QTextField(
          label: "Email Address",
          value: email,
          hint: "Enter your email",
          validator: Validator.email,
          onChanged: (value) {
            email = value;
            setState(() {});
          },
        ),

        // Phone Field
        QTextField(
          label: "Phone Number",
          value: phone,
          hint: "Enter your phone number",
          validator: Validator.required,
          onChanged: (value) {
            phone = value;
            setState(() {});
          },
        ),

        // Info Section
        Container(
          padding: EdgeInsets.all(spSm),
          decoration: BoxDecoration(
            color: infoColor.withAlpha(25),
            borderRadius: BorderRadius.circular(radiusSm),
            border: Border.all(color: infoColor.withAlpha(80)),
          ),
          child: Row(
            children: [
              Icon(Icons.info, color: infoColor, size: 16),
              SizedBox(width: spSm),
              Expanded(
                child: Text(
                  "Your personal information is encrypted and secure",
                  style: TextStyle(
                    fontSize: 12,
                    color: infoColor,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSecurityStep() {
    return Column(
      spacing: spMd,
      children: [
        // Security Icon
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            color: successColor.withAlpha(25),
            borderRadius: BorderRadius.circular(radius2xl),
          ),
          child: Icon(
            Icons.security,
            size: 40,
            color: successColor,
          ),
        ),

        Text(
          "Secure Your Account",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),

        Text(
          "Create a strong password to protect your financial data",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 14,
            color: disabledBoldColor,
          ),
        ),

        SizedBox(height: spMd),

        // Password Field
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            QTextField(
              label: "Password",
              value: password,
              hint: "Create a strong password",
              obscureText: obscurePassword,
              validator: Validator.required,
              onChanged: (value) {
                password = value;
                setState(() {});
              },
            ),
            SizedBox(height: spXs),
            Align(
              alignment: Alignment.centerRight,
              child: GestureDetector(
                onTap: () {
                  obscurePassword = !obscurePassword;
                  setState(() {});
                },
                child: Text(
                  obscurePassword ? "Show" : "Hide",
                  style: TextStyle(
                    color: primaryColor,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),

        // Confirm Password Field
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            QTextField(
              label: "Confirm Password",
              value: confirmPassword,
              hint: "Confirm your password",
              obscureText: obscureConfirmPassword,
              validator: Validator.required,
              onChanged: (value) {
                confirmPassword = value;
                setState(() {});
              },
            ),
            SizedBox(height: spXs),
            Align(
              alignment: Alignment.centerRight,
              child: GestureDetector(
                onTap: () {
                  obscureConfirmPassword = !obscureConfirmPassword;
                  setState(() {});
                },
                child: Text(
                  obscureConfirmPassword ? "Show" : "Hide",
                  style: TextStyle(
                    color: primaryColor,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),

        // Password Requirements
        Container(
          padding: EdgeInsets.all(spSm),
          decoration: BoxDecoration(
            color: warningColor.withAlpha(25),
            borderRadius: BorderRadius.circular(radiusSm),
            border: Border.all(color: warningColor.withAlpha(80)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Password Requirements:",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: warningColor,
                ),
              ),
              SizedBox(height: spXs),
              _buildPasswordRequirement("At least 8 characters", password.length >= 8),
              _buildPasswordRequirement("Contains uppercase letter", password.contains(RegExp(r'[A-Z]'))),
              _buildPasswordRequirement("Contains lowercase letter", password.contains(RegExp(r'[a-z]'))),
              _buildPasswordRequirement("Contains number", password.contains(RegExp(r'[0-9]'))),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildPasswordRequirement(String requirement, bool isMet) {
    return Row(
      children: [
        Icon(
          isMet ? Icons.check_circle : Icons.circle,
          size: 12,
          color: isMet ? successColor : disabledBoldColor,
        ),
        SizedBox(width: spXs),
        Text(
          requirement,
          style: TextStyle(
            fontSize: 10,
            color: isMet ? successColor : disabledBoldColor,
          ),
        ),
      ],
    );
  }

  Widget _buildTermsStep() {
    return Column(
      spacing: spMd,
      children: [
        // Success Icon
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            color: primaryColor.withAlpha(25),
            borderRadius: BorderRadius.circular(radius2xl),
          ),
          child: Icon(
            Icons.check_circle,
            size: 40,
            color: primaryColor,
          ),
        ),

        Text(
          "Almost Done!",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),

        Text(
          "Review and accept our terms to complete your registration",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 14,
            color: disabledBoldColor,
          ),
        ),

        SizedBox(height: spMd),

        // Terms and Conditions
        Container(
          padding: EdgeInsets.all(spSm),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(radiusSm),
            border: Border.all(color: disabledOutlineBorderColor),
          ),
          child: Column(
            children: [
              Row(
                children: [
                  Checkbox(
                    value: agreeToTerms,
                    onChanged: (value) {
                      agreeToTerms = value ?? false;
                      setState(() {});
                    },
                    activeColor: primaryColor,
                  ),
                  Expanded(
                    child: Text.rich(
                      TextSpan(
                        text: "I agree to the ",
                        style: TextStyle(fontSize: 14, color: disabledBoldColor),
                        children: [
                          TextSpan(
                            text: "Terms of Service",
                            style: TextStyle(
                              color: primaryColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          TextSpan(text: " and "),
                          TextSpan(
                            text: "Privacy Policy",
                            style: TextStyle(
                              color: primaryColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Checkbox(
                    value: subscribeNewsletter,
                    onChanged: (value) {
                      subscribeNewsletter = value ?? false;
                      setState(() {});
                    },
                    activeColor: primaryColor,
                  ),
                  Expanded(
                    child: Text(
                      "Subscribe to newsletter for financial tips and updates",
                      style: TextStyle(fontSize: 14, color: disabledBoldColor),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),

        // Account Summary
        Container(
          padding: EdgeInsets.all(spSm),
          decoration: BoxDecoration(
            color: primaryColor.withAlpha(15),
            borderRadius: BorderRadius.circular(radiusSm),
            border: Border.all(color: primaryColor.withAlpha(80)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Account Summary",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              SizedBox(height: spSm),
              _buildSummaryRow("Name", "$firstName $lastName"),
              _buildSummaryRow("Email", email),
              _buildSummaryRow("Phone", phone),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSummaryRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.only(bottom: spXs),
      child: Row(
        children: [
          Text(
            "$label:",
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                fontSize: 12,
                color: primaryColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _handleNextStep() {
    bool canProceed = false;

    switch (currentStep) {
      case 0:
        canProceed = firstName.isNotEmpty && 
                    lastName.isNotEmpty && 
                    email.isNotEmpty && 
                    phone.isNotEmpty;
        break;
      case 1:
        canProceed = password.isNotEmpty && 
                    confirmPassword.isNotEmpty && 
                    password == confirmPassword;
        break;
      case 2:
        canProceed = agreeToTerms;
        break;
    }

    if (!canProceed) {
      se("Please complete all required fields");
      return;
    }

    if (currentStep < registrationSteps.length - 1) {
      currentStep++;
      setState(() {});
    } else {
      _handleRegistration();
    }
  }

  void _handleRegistration() {
    if (formKey.currentState!.validate() && agreeToTerms) {
      loading = true;
      setState(() {});

      Future.delayed(Duration(seconds: 3), () {
        loading = false;
        setState(() {});
        ss("Account created successfully! Welcome to LCA.");
        //navigateTo(LcaLoginView());
      });
    }
  }
}
