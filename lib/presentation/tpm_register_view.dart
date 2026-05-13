import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class TpmRegisterView extends StatefulWidget {
  const TpmRegisterView({super.key});

  @override
  State<TpmRegisterView> createState() => _TpmRegisterViewState();
}

class _TpmRegisterViewState extends State<TpmRegisterView> {
  final formKey = GlobalKey<FormState>();
  String firstName = "";
  String lastName = "";
  String email = "";
  String password = "";
  String confirmPassword = "";
  String phoneNumber = "";
  String companyName = "";
  String jobTitle = "";
  bool agreeToTerms = false;
  bool subscribeNewsletter = false;
  bool obscurePassword = true;
  bool obscureConfirmPassword = true;
  bool loading = false;
  int currentStep = 0;

  List<Map<String, dynamic>> companyRoles = [
    {"label": "Project Manager", "value": "Project Manager"},
    {"label": "Team Lead", "value": "Team Lead"},
    {"label": "Developer", "value": "Developer"},
    {"label": "Designer", "value": "Designer"},
    {"label": "Business Analyst", "value": "Business Analyst"},
    {"label": "Other", "value": "Other"},
  ];

  List<Map<String, dynamic>> socialSignupOptions = [
    {
      "name": "Google",
      "icon": Icons.g_mobiledata,
      "color": Colors.red,
    },
    {
      "name": "Microsoft",
      "icon": Icons.business,
      "color": Colors.blue,
    },
    {
      "name": "LinkedIn",
      "icon": Icons.business_center,
      "color": Colors.blue,
    },
  ];

  Future<void> _handleRegister() async {
    if (!formKey.currentState!.validate()) return;
    
    if (!agreeToTerms) {
      se("Please agree to the Terms of Service and Privacy Policy");
      return;
    }

    if (password != confirmPassword) {
      se("Passwords do not match");
      return;
    }

    loading = true;
    setState(() {});

    // Simulate API call
    await Future.delayed(Duration(seconds: 2));

    loading = false;
    setState(() {});

    ss("Account created successfully! Please check your email for verification.");
    // Navigate to email verification or login
  }

  Future<void> _handleSocialSignup(String provider) async {
    showLoading();
    
    // Simulate social signup
    await Future.delayed(Duration(seconds: 1));
    
    hideLoading();
    ss("$provider signup successful!");
    // Navigate to dashboard
  }

  void _nextStep() {
    if (currentStep == 0) {
      // Validate basic info
      if (firstName.isEmpty || lastName.isEmpty || email.isEmpty) {
        se("Please fill in all required fields");
        return;
      }
    }
    
    if (currentStep < 2) {
      currentStep++;
      setState(() {});
    }
  }

  void _previousStep() {
    if (currentStep > 0) {
      currentStep--;
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create Account"),
        leading: currentStep > 0 
          ? IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: _previousStep,
            )
          : null,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          children: [
            // Progress Indicator
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusSm),
                boxShadow: [shadowSm],
              ),
              child: Column(
                spacing: spSm,
                children: [
                  Row(
                    children: List.generate(3, (index) {
                      bool isActive = index <= currentStep;
                      bool isCurrent = index == currentStep;
                      
                      return Expanded(
                        child: Container(
                          margin: EdgeInsets.symmetric(horizontal: 4),
                          child: Column(
                            children: [
                              Container(
                                width: 32,
                                height: 32,
                                decoration: BoxDecoration(
                                  color: isActive ? primaryColor : disabledColor,
                                  borderRadius: BorderRadius.circular(radiusLg),
                                  border: isCurrent 
                                    ? Border.all(color: primaryColor, width: 2)
                                    : null,
                                ),
                                child: Center(
                                  child: Text(
                                    "${index + 1}",
                                    style: TextStyle(
                                      color: isActive ? Colors.white : disabledBoldColor,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: spXs),
                              Text(
                                ["Basic Info", "Password", "Company"][index],
                                style: TextStyle(
                                  fontSize: 10,
                                  color: isActive ? primaryColor : disabledBoldColor,
                                  fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
                  ),
                  SizedBox(height: spSm),
                  LinearProgressIndicator(
                    value: (currentStep + 1) / 3,
                    backgroundColor: disabledColor,
                    valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
                  ),
                ],
              ),
            ),

            SizedBox(height: spMd),

            // Form Steps
            Form(
              key: formKey,
              child: _buildCurrentStep(),
            ),

            SizedBox(height: spMd),

            // Social Signup (Only on first step)
            if (currentStep == 0) ...[
              Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 1,
                      color: disabledColor,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: spSm),
                    child: Text(
                      "OR",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      height: 1,
                      color: disabledColor,
                    ),
                  ),
                ],
              ),

              SizedBox(height: spMd),

              Column(
                spacing: spSm,
                children: [
                  Text(
                    "Sign up with",
                    style: TextStyle(
                      fontSize: 14,
                      color: disabledBoldColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Row(
                    children: socialSignupOptions.map((option) {
                      return Expanded(
                        child: Container(
                          margin: EdgeInsets.symmetric(horizontal: 4),
                          child: GestureDetector(
                            onTap: () => _handleSocialSignup("${option["name"]}"),
                            child: Container(
                              padding: EdgeInsets.all(spSm),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(radiusSm),
                                border: Border.all(color: disabledOutlineBorderColor),
                              ),
                              child: Column(
                                children: [
                                  Icon(
                                    option["icon"] as IconData,
                                    color: option["color"] as Color,
                                    size: 24,
                                  ),
                                  SizedBox(height: spXs),
                                  Text(
                                    "${option["name"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),

              SizedBox(height: spMd),
            ],

            // Already have account
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Already have an account? ",
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    // Navigate to login
                  },
                  child: Text(
                    "Sign In",
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
    );
  }

  Widget _buildCurrentStep() {
    switch (currentStep) {
      case 0:
        return _buildBasicInfoStep();
      case 1:
        return _buildPasswordStep();
      case 2:
        return _buildCompanyStep();
      default:
        return Container();
    }
  }

  Widget _buildBasicInfoStep() {
    return Column(
      spacing: spMd,
      children: [
        // Header
        Container(
          padding: EdgeInsets.all(spMd),
          decoration: BoxDecoration(
            color: primaryColor.withAlpha(20),
            borderRadius: BorderRadius.circular(radiusSm),
          ),
          child: Column(
            children: [
              Icon(Icons.person_add, color: primaryColor, size: 48),
              SizedBox(height: spSm),
              Text(
                "Personal Information",
                style: TextStyle(
                  fontSize: fsH4,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Text(
                "Let's start with your basic information",
                style: TextStyle(
                  fontSize: 14,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
        ),

        // Form Fields
        Row(
          children: [
            Expanded(
              child: QTextField(
                label: "First Name *",
                value: firstName,
                hint: "Enter your first name",
                validator: Validator.required,
                onChanged: (value) {
                  firstName = value;
                  setState(() {});
                },
              ),
            ),
            SizedBox(width: spSm),
            Expanded(
              child: QTextField(
                label: "Last Name *",
                value: lastName,
                hint: "Enter your last name",
                validator: Validator.required,
                onChanged: (value) {
                  lastName = value;
                  setState(() {});
                },
              ),
            ),
          ],
        ),

        QTextField(
          label: "Email Address *",
          value: email,
          hint: "Enter your email address",
          validator: Validator.email,
          onChanged: (value) {
            email = value;
            setState(() {});
          },
        ),

        QTextField(
          label: "Phone Number",
          value: phoneNumber,
          hint: "Enter your phone number",
          onChanged: (value) {
            phoneNumber = value;
            setState(() {});
          },
        ),

        Container(
          width: double.infinity,
          child: QButton(
            label: "Continue",
            size: bs.md,
            onPressed: _nextStep,
          ),
        ),
      ],
    );
  }

  Widget _buildPasswordStep() {
    return Column(
      spacing: spMd,
      children: [
        // Header
        Container(
          padding: EdgeInsets.all(spMd),
          decoration: BoxDecoration(
            color: successColor.withAlpha(20),
            borderRadius: BorderRadius.circular(radiusSm),
          ),
          child: Column(
            children: [
              Icon(Icons.security, color: successColor, size: 48),
              SizedBox(height: spSm),
              Text(
                "Secure Your Account",
                style: TextStyle(
                  fontSize: fsH4,
                  fontWeight: FontWeight.bold,
                  color: successColor,
                ),
              ),
              Text(
                "Create a strong password to protect your account",
                style: TextStyle(
                  fontSize: 14,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
        ),

        // Password Fields
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            QTextField(
              label: "Password *",
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
                  obscurePassword ? "Show Password" : "Hide Password",
                  style: TextStyle(
                    color: primaryColor,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),

        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            QTextField(
              label: "Confirm Password *",
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
                  obscureConfirmPassword ? "Show Password" : "Hide Password",
                  style: TextStyle(
                    color: primaryColor,
                    fontSize: 12,
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
            color: infoColor.withAlpha(20),
            borderRadius: BorderRadius.circular(radiusSm),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: spXs,
            children: [
              Text(
                "Password Requirements:",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: infoColor,
                ),
              ),
              Text("• At least 8 characters long", style: TextStyle(fontSize: 11, color: disabledBoldColor)),
              Text("• Contains uppercase and lowercase letters", style: TextStyle(fontSize: 11, color: disabledBoldColor)),
              Text("• Contains at least one number", style: TextStyle(fontSize: 11, color: disabledBoldColor)),
              Text("• Contains at least one special character", style: TextStyle(fontSize: 11, color: disabledBoldColor)),
            ],
          ),
        ),

        Container(
          width: double.infinity,
          child: QButton(
            label: "Continue",
            size: bs.md,
            onPressed: _nextStep,
          ),
        ),
      ],
    );
  }

  Widget _buildCompanyStep() {
    return Column(
      spacing: spMd,
      children: [
        // Header
        Container(
          padding: EdgeInsets.all(spMd),
          decoration: BoxDecoration(
            color: infoColor.withAlpha(20),
            borderRadius: BorderRadius.circular(radiusSm),
          ),
          child: Column(
            children: [
              Icon(Icons.business, color: infoColor, size: 48),
              SizedBox(height: spSm),
              Text(
                "Company Information",
                style: TextStyle(
                  fontSize: fsH4,
                  fontWeight: FontWeight.bold,
                  color: infoColor,
                ),
              ),
              Text(
                "Tell us about your organization",
                style: TextStyle(
                  fontSize: 14,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
        ),

        // Company Fields
        QTextField(
          label: "Company Name",
          value: companyName,
          hint: "Enter your company name",
          onChanged: (value) {
            companyName = value;
            setState(() {});
          },
        ),

        QDropdownField(
          label: "Job Title",
          items: companyRoles,
          value: jobTitle,
          onChanged: (value, label) {
            jobTitle = value;
            setState(() {});
          },
        ),

        // Terms and Conditions
        Column(
          spacing: spSm,
          children: [
            QSwitch(
              items: [
                {
                  "label": "I agree to the Terms of Service and Privacy Policy *",
                  "value": true,
                  "checked": agreeToTerms,
                }
              ],
              value: [
                if (agreeToTerms)
                  {
                    "label": "I agree to the Terms of Service and Privacy Policy *",
                    "value": true,
                    "checked": true
                  }
              ],
              onChanged: (values, ids) {
                agreeToTerms = values.isNotEmpty;
                setState(() {});
              },
            ),

            QSwitch(
              items: [
                {
                  "label": "Subscribe to newsletter and updates",
                  "value": true,
                  "checked": subscribeNewsletter,
                }
              ],
              value: [
                if (subscribeNewsletter)
                  {
                    "label": "Subscribe to newsletter and updates",
                    "value": true,
                    "checked": true
                  }
              ],
              onChanged: (values, ids) {
                subscribeNewsletter = values.isNotEmpty;
                setState(() {});
              },
            ),
          ],
        ),

        // Terms Links
        Container(
          padding: EdgeInsets.all(spSm),
          decoration: BoxDecoration(
            color: disabledColor.withAlpha(50),
            borderRadius: BorderRadius.circular(radiusSm),
          ),
          child: Column(
            spacing: spXs,
            children: [
              Text(
                "By creating an account, you agree to our:",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {},
                    child: Text(
                      "Terms of Service",
                      style: TextStyle(
                        fontSize: 12,
                        color: primaryColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Text(" and ", style: TextStyle(fontSize: 12, color: disabledBoldColor)),
                  GestureDetector(
                    onTap: () {},
                    child: Text(
                      "Privacy Policy",
                      style: TextStyle(
                        fontSize: 12,
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

        // Register Button
        if (loading) ...[
          Container(
            height: 48,
            child: Center(
              child: CircularProgressIndicator(),
            ),
          ),
        ] else ...[
          Container(
            width: double.infinity,
            child: QButton(
              label: "Create Account",
              size: bs.md,
              onPressed: _handleRegister,
            ),
          ),
        ],
      ],
    );
  }
}
