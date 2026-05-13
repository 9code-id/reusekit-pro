import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class FsmRegisterView extends StatefulWidget {
  const FsmRegisterView({super.key});

  @override
  State<FsmRegisterView> createState() => _FsmRegisterViewState();
}

class _FsmRegisterViewState extends State<FsmRegisterView> {
  final formKey = GlobalKey<FormState>();
  bool loading = false;
  int currentStep = 0;
  
  // Personal Information
  String firstName = "";
  String lastName = "";
  String email = "";
  String phone = "";
  String password = "";
  String confirmPassword = "";
  bool obscurePassword = true;
  bool obscureConfirmPassword = true;
  
  // Farm Information
  String farmName = "";
  String farmType = "crop";
  String farmSize = "";
  String farmLocation = "";
  String farmAddress = "";
  String experience = "beginner";
  
  // Preferences
  bool acceptTerms = false;
  bool newsletterSubscription = true;
  bool weatherAlerts = true;
  bool marketingEmails = false;
  String language = "en";
  String timezone = "UTC";
  
  List<Map<String, dynamic>> farmTypes = [
    {"label": "Crop Farming", "value": "crop"},
    {"label": "Livestock", "value": "livestock"},
    {"label": "Mixed Farming", "value": "mixed"},
    {"label": "Organic Farming", "value": "organic"},
    {"label": "Greenhouse", "value": "greenhouse"},
    {"label": "Other", "value": "other"},
  ];
  
  List<Map<String, dynamic>> experienceLevels = [
    {"label": "Beginner (0-2 years)", "value": "beginner"},
    {"label": "Intermediate (3-10 years)", "value": "intermediate"},
    {"label": "Advanced (10+ years)", "value": "advanced"},
    {"label": "Expert (20+ years)", "value": "expert"},
  ];
  
  List<Map<String, dynamic>> languages = [
    {"label": "English", "value": "en"},
    {"label": "Spanish", "value": "es"},
    {"label": "French", "value": "fr"},
    {"label": "German", "value": "de"},
    {"label": "Portuguese", "value": "pt"},
  ];
  
  List<Map<String, dynamic>> timezones = [
    {"label": "UTC", "value": "UTC"},
    {"label": "US Eastern", "value": "America/New_York"},
    {"label": "US Central", "value": "America/Chicago"},
    {"label": "US Pacific", "value": "America/Los_Angeles"},
    {"label": "Europe/London", "value": "Europe/London"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            SizedBox(height: MediaQuery.of(context).padding.top + spLg),
            _buildHeader(),
            _buildProgressIndicator(),
            _buildStepContent(),
            _buildNavigationButtons(),
            _buildFooter(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            successColor.withAlpha(20),
            primaryColor.withAlpha(10),
          ],
        ),
        borderRadius: BorderRadius.circular(radiusLg),
      ),
      child: Column(
        spacing: spMd,
        children: [
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Icon(
              Icons.agriculture,
              color: successColor,
              size: 48,
            ),
          ),
          Text(
            "Join FieldSmart Manager",
            style: TextStyle(
              fontSize: fsH4,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Text(
            "Create your account and start managing your fields smarter",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProgressIndicator() {
    List<String> stepTitles = ["Personal", "Farm", "Preferences"];
    
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        children: [
          Row(
            children: List.generate(stepTitles.length, (index) {
              bool isActive = index <= currentStep;
              bool isCurrent = index == currentStep;
              
              return Expanded(
                child: Row(
                  children: [
                    Container(
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                        color: isActive ? primaryColor : disabledColor,
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(
                          color: isCurrent ? primaryColor : disabledColor,
                          width: isCurrent ? 2 : 1,
                        ),
                      ),
                      child: Center(
                        child: Text(
                          "${index + 1}",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    if (index < stepTitles.length - 1)
                      Expanded(
                        child: Container(
                          height: 2,
                          color: index < currentStep ? primaryColor : disabledColor,
                        ),
                      ),
                  ],
                ),
              );
            }),
          ),
          Row(
            children: List.generate(stepTitles.length, (index) {
              bool isActive = index <= currentStep;
              
              return Expanded(
                child: Text(
                  stepTitles[index],
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 12,
                    color: isActive ? primaryColor : disabledBoldColor,
                    fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
                  ),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildStepContent() {
    switch (currentStep) {
      case 0:
        return _buildPersonalInfoStep();
      case 1:
        return _buildFarmInfoStep();
      case 2:
        return _buildPreferencesStep();
      default:
        return Container();
    }
  }

  Widget _buildPersonalInfoStep() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowMd],
      ),
      child: Form(
        key: formKey,
        child: Column(
          spacing: spMd,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Personal Information",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: QTextField(
                    label: "First Name",
                    value: firstName,
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
                    label: "Last Name",
                    value: lastName,
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
              label: "Email Address",
              value: email,
              validator: Validator.email,
              onChanged: (value) {
                email = value;
                setState(() {});
              },
            ),
            QTextField(
              label: "Phone Number",
              value: phone,
              validator: Validator.required,
              onChanged: (value) {
                phone = value;
                setState(() {});
              },
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                QTextField(
                  label: "Password",
                  value: password,
                  obscureText: obscurePassword,
                  validator: Validator.required,
                  onChanged: (value) {
                    password = value;
                    setState(() {});
                  },
                ),
                SizedBox(height: spXs),
                Row(
                  children: [
                    Expanded(child: Container()),
                    GestureDetector(
                      onTap: () {
                        obscurePassword = !obscurePassword;
                        setState(() {});
                      },
                      child: Text(
                        obscurePassword ? "Show" : "Hide",
                        style: TextStyle(
                          color: primaryColor,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                QTextField(
                  label: "Confirm Password",
                  value: confirmPassword,
                  obscureText: obscureConfirmPassword,
                  validator: (value) {
                    if (value != password) {
                      return "Passwords do not match";
                    }
                    return null;
                  },
                  onChanged: (value) {
                    confirmPassword = value;
                    setState(() {});
                  },
                ),
                SizedBox(height: spXs),
                Row(
                  children: [
                    Expanded(child: Container()),
                    GestureDetector(
                      onTap: () {
                        obscureConfirmPassword = !obscureConfirmPassword;
                        setState(() {});
                      },
                      child: Text(
                        obscureConfirmPassword ? "Show" : "Hide",
                        style: TextStyle(
                          color: primaryColor,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFarmInfoStep() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowMd],
      ),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Farm Information",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          QTextField(
            label: "Farm Name",
            value: farmName,
            validator: Validator.required,
            onChanged: (value) {
              farmName = value;
              setState(() {});
            },
          ),
          Row(
            children: [
              Expanded(
                child: QDropdownField(
                  label: "Farm Type",
                  items: farmTypes,
                  value: farmType,
                  onChanged: (value, label) {
                    farmType = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QTextField(
                  label: "Farm Size (acres)",
                  value: farmSize,
                  validator: Validator.required,
                  onChanged: (value) {
                    farmSize = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
          QTextField(
            label: "Farm Location (City, State)",
            value: farmLocation,
            validator: Validator.required,
            onChanged: (value) {
              farmLocation = value;
              setState(() {});
            },
          ),
          QMemoField(
            label: "Farm Address",
            value: farmAddress,
            hint: "Enter complete farm address for accurate weather data",
            onChanged: (value) {
              farmAddress = value;
              setState(() {});
            },
          ),
          QDropdownField(
            label: "Farming Experience",
            items: experienceLevels,
            value: experience,
            onChanged: (value, label) {
              experience = value;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  Widget _buildPreferencesStep() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowMd],
      ),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Preferences & Agreements",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Row(
            children: [
              Expanded(
                child: QDropdownField(
                  label: "Language",
                  items: languages,
                  value: language,
                  onChanged: (value, label) {
                    language = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QDropdownField(
                  label: "Timezone",
                  items: timezones,
                  value: timezone,
                  onChanged: (value, label) {
                    timezone = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(5),
              borderRadius: BorderRadius.circular(radiusMd),
              border: Border.all(color: disabledOutlineBorderColor),
            ),
            child: Column(
              spacing: spSm,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Notification Preferences",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
                QSwitch(
                  items: [
                    {
                      "label": "Newsletter Subscription",
                      "value": true,
                      "checked": newsletterSubscription,
                    }
                  ],
                  value: [
                    if (newsletterSubscription)
                      {
                        "label": "Newsletter Subscription",
                        "value": true,
                        "checked": true
                      }
                  ],
                  onChanged: (values, ids) {
                    newsletterSubscription = values.isNotEmpty;
                    setState(() {});
                  },
                ),
                QSwitch(
                  items: [
                    {
                      "label": "Weather Alerts",
                      "value": true,
                      "checked": weatherAlerts,
                    }
                  ],
                  value: [
                    if (weatherAlerts)
                      {
                        "label": "Weather Alerts",
                        "value": true,
                        "checked": true
                      }
                  ],
                  onChanged: (values, ids) {
                    weatherAlerts = values.isNotEmpty;
                    setState(() {});
                  },
                ),
                QSwitch(
                  items: [
                    {
                      "label": "Marketing Emails",
                      "value": true,
                      "checked": marketingEmails,
                    }
                  ],
                  value: [
                    if (marketingEmails)
                      {
                        "label": "Marketing Emails",
                        "value": true,
                        "checked": true
                      }
                  ],
                  onChanged: (values, ids) {
                    marketingEmails = values.isNotEmpty;
                    setState(() {});
                  },
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: warningColor.withAlpha(10),
              borderRadius: BorderRadius.circular(radiusMd),
              border: Border.all(color: warningColor.withAlpha(30)),
            ),
            child: Column(
              spacing: spSm,
              children: [
                QSwitch(
                  items: [
                    {
                      "label": "I accept the Terms of Service and Privacy Policy",
                      "value": true,
                      "checked": acceptTerms,
                    }
                  ],
                  value: [
                    if (acceptTerms)
                      {
                        "label": "I accept the Terms of Service and Privacy Policy",
                        "value": true,
                        "checked": true
                      }
                  ],
                  onChanged: (values, ids) {
                    acceptTerms = values.isNotEmpty;
                    setState(() {});
                  },
                ),
                if (!acceptTerms)
                  Container(
                    padding: EdgeInsets.all(spXs),
                    decoration: BoxDecoration(
                      color: dangerColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.warning, color: dangerColor, size: 16),
                        SizedBox(width: spXs),
                        Expanded(
                          child: Text(
                            "You must accept the terms to continue",
                            style: TextStyle(
                              fontSize: 11,
                              color: dangerColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavigationButtons() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Row(
        children: [
          if (currentStep > 0)
            Expanded(
              child: QButton(
                label: "Previous",
                icon: Icons.arrow_back,
                size: bs.md,
                onPressed: () {
                  currentStep--;
                  setState(() {});
                },
              ),
            ),
          if (currentStep > 0) SizedBox(width: spSm),
          Expanded(
            child: QButton(
              label: currentStep == 2 ? (loading ? "Creating Account..." : "Create Account") : "Next",
              icon: currentStep == 2 ? Icons.check : Icons.arrow_forward,
              size: bs.md,
              onPressed: loading ? null : _handleNext,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFooter() {
    return Column(
      spacing: spMd,
      children: [
        Container(
          padding: EdgeInsets.all(spMd),
          decoration: BoxDecoration(
            color: primaryColor.withAlpha(10),
            borderRadius: BorderRadius.circular(radiusMd),
            border: Border.all(
              color: primaryColor.withAlpha(30),
              width: 1,
            ),
          ),
          child: Column(
            spacing: spSm,
            children: [
              Text(
                "Already have an account?",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: primaryColor,
                ),
              ),
              Container(
                width: double.infinity,
                child: QButton(
                  label: "Sign In",
                  icon: Icons.login,
                  size: bs.md,
                  onPressed: () {
                    //navigateTo(FsmLoginView());
                  },
                ),
              ),
            ],
          ),
        ),
        Text(
          "© 2024 FieldSmart Manager",
          style: TextStyle(
            fontSize: 12,
            color: disabledColor,
          ),
        ),
      ],
    );
  }

  void _handleNext() async {
    if (currentStep < 2) {
      if (currentStep == 0 && !formKey.currentState!.validate()) return;
      
      currentStep++;
      setState(() {});
    } else {
      if (!acceptTerms) {
        se("Please accept the terms and conditions to continue");
        return;
      }
      
      await _createAccount();
    }
  }

  Future<void> _createAccount() async {
    loading = true;
    setState(() {});

    showLoading();

    // Simulate account creation
    await Future.delayed(Duration(seconds: 3));

    hideLoading();
    loading = false;
    setState(() {});

    ss("Account created successfully! Welcome to FieldSmart Manager.");
    //navigateTo(FsmDashboardView());
  }
}
