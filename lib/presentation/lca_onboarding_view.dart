import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class LcaOnboardingView extends StatefulWidget {
  const LcaOnboardingView({super.key});

  @override
  State<LcaOnboardingView> createState() => _LcaOnboardingViewState();
}

class _LcaOnboardingViewState extends State<LcaOnboardingView> {
  int currentStep = 0;
  bool loading = false;

  // Personal Information
  String firstName = "";
  String lastName = "";
  String email = "";
  String phone = "";
  String address = "";

  // Professional Information
  String barNumber = "";
  String lawSchool = "";
  String graduationYear = "";
  String specializations = "";
  List<String> selectedPracticeAreas = [];

  // Firm Information
  String firmName = "";
  String firmSize = "";
  String firmAddress = "";
  String position = "";
  int yearsExperience = 0;

  // Preferences
  bool emailNotifications = true;
  bool smsNotifications = false;
  bool marketingEmails = false;
  String preferredLanguage = "english";

  List<Map<String, dynamic>> practiceAreaOptions = [
    {"label": "Criminal Law", "value": "criminal", "selected": false},
    {"label": "Corporate Law", "value": "corporate", "selected": false},
    {"label": "Family Law", "value": "family", "selected": false},
    {"label": "Personal Injury", "value": "personal_injury", "selected": false},
    {"label": "Real Estate", "value": "real_estate", "selected": false},
    {"label": "Immigration", "value": "immigration", "selected": false},
    {"label": "Intellectual Property", "value": "ip", "selected": false},
    {"label": "Employment Law", "value": "employment", "selected": false},
  ];

  List<Map<String, dynamic>> firmSizeOptions = [
    {"label": "Solo Practice", "value": "solo"},
    {"label": "2-10 Attorneys", "value": "small"},
    {"label": "11-50 Attorneys", "value": "medium"},
    {"label": "51+ Attorneys", "value": "large"},
  ];

  List<Map<String, dynamic>> languageOptions = [
    {"label": "English", "value": "english"},
    {"label": "Spanish", "value": "spanish"},
    {"label": "French", "value": "french"},
    {"label": "German", "value": "german"},
  ];

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Legal Case Analytics - Setup"),
        automaticallyImplyLeading: currentStep > 0,
        leading: currentStep > 0
            ? IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  setState(() {
                    currentStep--;
                  });
                },
              )
            : null,
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
                    _buildProgressIndicator(),
                    _buildStepContent(),
                    _buildNavigationButtons(),
                  ],
                ),
              ),
            ),
    );
  }

  Widget _buildProgressIndicator() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        children: [
          Row(
            children: [
              Icon(Icons.timeline, color: primaryColor, size: 20),
              SizedBox(width: spXs),
              Text(
                "Setup Progress",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Spacer(),
              Text(
                "${currentStep + 1}/4",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
          Row(
            children: List.generate(4, (index) {
              bool isCompleted = index < currentStep;
              bool isCurrent = index == currentStep;
              
              return Expanded(
                child: Container(
                  height: 4,
                  margin: EdgeInsets.only(right: index < 3 ? spXs : 0),
                  decoration: BoxDecoration(
                    color: isCompleted || isCurrent ? primaryColor : disabledOutlineBorderColor,
                    borderRadius: BorderRadius.circular(radiusXs),
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
        return _buildProfessionalInfoStep();
      case 2:
        return _buildFirmInfoStep();
      case 3:
        return _buildPreferencesStep();
      default:
        return Container();
    }
  }

  Widget _buildPersonalInfoStep() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.person, color: primaryColor, size: 20),
              SizedBox(width: spXs),
              Text(
                "Personal Information",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          Text(
            "Please provide your basic personal information to get started.",
            style: TextStyle(
              fontSize: 14,
              color: disabledBoldColor,
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
          QMemoField(
            label: "Address",
            value: address,
            validator: Validator.required,
            onChanged: (value) {
              address = value;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  Widget _buildProfessionalInfoStep() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.school, color: primaryColor, size: 20),
              SizedBox(width: spXs),
              Text(
                "Professional Credentials",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          Text(
            "Tell us about your legal education and practice areas.",
            style: TextStyle(
              fontSize: 14,
              color: disabledBoldColor,
            ),
          ),
          QTextField(
            label: "Bar Number",
            value: barNumber,
            validator: Validator.required,
            onChanged: (value) {
              barNumber = value;
              setState(() {});
            },
          ),
          Row(
            children: [
              Expanded(
                child: QTextField(
                  label: "Law School",
                  value: lawSchool,
                  validator: Validator.required,
                  onChanged: (value) {
                    lawSchool = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QNumberField(
                  label: "Graduation Year",
                  value: graduationYear,
                  validator: Validator.required,
                  onChanged: (value) {
                    graduationYear = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
          Text(
            "Practice Areas (Select all that apply)",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: primaryColor,
            ),
          ),
          Wrap(
            spacing: spXs,
            runSpacing: spXs,
            children: practiceAreaOptions.map((area) {
              bool isSelected = selectedPracticeAreas.contains(area["value"]);
              return GestureDetector(
                onTap: () {
                  setState(() {
                    if (isSelected) {
                      selectedPracticeAreas.remove(area["value"]);
                    } else {
                      selectedPracticeAreas.add(area["value"]);
                    }
                  });
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                  decoration: BoxDecoration(
                    color: isSelected ? primaryColor : Colors.white,
                    borderRadius: BorderRadius.circular(radiusLg),
                    border: Border.all(
                      color: isSelected ? primaryColor : disabledOutlineBorderColor,
                    ),
                  ),
                  child: Text(
                    "${area["label"]}",
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: isSelected ? Colors.white : primaryColor,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
          QMemoField(
            label: "Specializations (Optional)",
            value: specializations,
            hint: "Describe any specific areas of expertise",
            onChanged: (value) {
              specializations = value;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  Widget _buildFirmInfoStep() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.business, color: primaryColor, size: 20),
              SizedBox(width: spXs),
              Text(
                "Firm Information",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          Text(
            "Provide details about your law firm or practice.",
            style: TextStyle(
              fontSize: 14,
              color: disabledBoldColor,
            ),
          ),
          QTextField(
            label: "Firm Name",
            value: firmName,
            validator: Validator.required,
            onChanged: (value) {
              firmName = value;
              setState(() {});
            },
          ),
          Row(
            children: [
              Expanded(
                child: QDropdownField(
                  label: "Firm Size",
                  items: firmSizeOptions,
                  value: firmSize,
                  onChanged: (value, label) {
                    firmSize = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QNumberField(
                  label: "Years Experience",
                  value: yearsExperience.toString(),
                  validator: Validator.required,
                  onChanged: (value) {
                    yearsExperience = int.tryParse(value) ?? 0;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
          QTextField(
            label: "Your Position",
            value: position,
            validator: Validator.required,
            hint: "e.g., Partner, Associate, Solo Practitioner",
            onChanged: (value) {
              position = value;
              setState(() {});
            },
          ),
          QMemoField(
            label: "Firm Address",
            value: firmAddress,
            validator: Validator.required,
            onChanged: (value) {
              firmAddress = value;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  Widget _buildPreferencesStep() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.settings, color: primaryColor, size: 20),
              SizedBox(width: spXs),
              Text(
                "Preferences & Settings",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          Text(
            "Configure your notification preferences and settings.",
            style: TextStyle(
              fontSize: 14,
              color: disabledBoldColor,
            ),
          ),
          QDropdownField(
            label: "Preferred Language",
            items: languageOptions,
            value: preferredLanguage,
            onChanged: (value, label) {
              preferredLanguage = value;
              setState(() {});
            },
          ),
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(13),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Column(
              spacing: spXs,
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
                      "label": "Email Notifications",
                      "value": true,
                      "checked": emailNotifications,
                    }
                  ],
                  value: emailNotifications ? [{"label": "Email Notifications", "value": true, "checked": true}] : [],
                  onChanged: (values, ids) {
                    emailNotifications = values.isNotEmpty;
                    setState(() {});
                  },
                ),
                QSwitch(
                  items: [
                    {
                      "label": "SMS Notifications",
                      "value": true,
                      "checked": smsNotifications,
                    }
                  ],
                  value: smsNotifications ? [{"label": "SMS Notifications", "value": true, "checked": true}] : [],
                  onChanged: (values, ids) {
                    smsNotifications = values.isNotEmpty;
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
                  value: marketingEmails ? [{"label": "Marketing Emails", "value": true, "checked": true}] : [],
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
              color: infoColor.withAlpha(26),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Row(
              children: [
                Icon(Icons.info_outline, color: infoColor, size: 20),
                SizedBox(width: spXs),
                Expanded(
                  child: Text(
                    "You can change these preferences anytime in your account settings.",
                    style: TextStyle(
                      fontSize: 13,
                      color: infoColor,
                    ),
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
      padding: EdgeInsets.all(spSm),
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
                  setState(() {
                    currentStep--;
                  });
                },
              ),
            ),
          if (currentStep > 0) SizedBox(width: spSm),
          Expanded(
            child: QButton(
              label: currentStep == 3 ? "Complete Setup" : "Next",
              icon: currentStep == 3 ? Icons.check : Icons.arrow_forward,
              size: bs.md,
              onPressed: () {
                if (currentStep == 3) {
                  _completeOnboarding();
                } else {
                  if (formKey.currentState!.validate()) {
                    setState(() {
                      currentStep++;
                    });
                  }
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  void _completeOnboarding() async {
    if (!formKey.currentState!.validate()) {
      se("Please complete all required fields");
      return;
    }

    if (selectedPracticeAreas.isEmpty) {
      se("Please select at least one practice area");
      return;
    }

    setState(() {
      loading = true;
    });

    await Future.delayed(Duration(seconds: 3));

    setState(() {
      loading = false;
    });

    ss("Welcome to Legal Case Analytics! Your account has been set up successfully.");
    
    // Navigate to main dashboard or next screen
    // ss('Next page'));
  }
}
