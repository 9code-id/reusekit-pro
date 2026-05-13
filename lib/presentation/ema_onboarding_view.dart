import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class EmaOnboardingView extends StatefulWidget {
  const EmaOnboardingView({super.key});

  @override
  State<EmaOnboardingView> createState() => _EmaOnboardingViewState();
}

class _EmaOnboardingViewState extends State<EmaOnboardingView> {
  int currentStep = 0;
  String fullName = "";
  String email = "";
  String companyName = "";
  String jobTitle = "";
  String industry = "";
  String experienceLevel = "";
  List<String> interests = [];
  List<String> goals = [];
  bool agreeToTerms = false;
  bool subscribeNewsletter = true;

  List<Map<String, dynamic>> industries = [
    {"label": "Technology", "value": "technology"},
    {"label": "Healthcare", "value": "healthcare"},
    {"label": "Finance", "value": "finance"},
    {"label": "Education", "value": "education"},
    {"label": "Manufacturing", "value": "manufacturing"},
    {"label": "Retail", "value": "retail"},
    {"label": "Consulting", "value": "consulting"},
    {"label": "Other", "value": "other"},
  ];

  List<Map<String, dynamic>> experienceLevels = [
    {"label": "Entry Level (0-2 years)", "value": "entry"},
    {"label": "Mid Level (3-5 years)", "value": "mid"},
    {"label": "Senior Level (6-10 years)", "value": "senior"},
    {"label": "Executive Level (10+ years)", "value": "executive"},
  ];

  List<Map<String, dynamic>> availableInterests = [
    {"label": "Event Planning", "value": "event_planning", "checked": false},
    {"label": "Marketing", "value": "marketing", "checked": false},
    {"label": "Networking", "value": "networking", "checked": false},
    {"label": "Sales", "value": "sales", "checked": false},
    {"label": "Team Building", "value": "team_building", "checked": false},
    {"label": "Training", "value": "training", "checked": false},
    {"label": "Conference Management", "value": "conference", "checked": false},
    {"label": "Corporate Events", "value": "corporate", "checked": false},
  ];

  List<Map<String, dynamic>> availableGoals = [
    {"label": "Improve Event ROI", "value": "improve_roi", "checked": false},
    {"label": "Streamline Planning Process", "value": "streamline", "checked": false},
    {"label": "Enhance Attendee Experience", "value": "experience", "checked": false},
    {"label": "Better Analytics & Reporting", "value": "analytics", "checked": false},
    {"label": "Reduce Planning Time", "value": "reduce_time", "checked": false},
    {"label": "Increase Event Attendance", "value": "attendance", "checked": false},
    {"label": "Better Budget Management", "value": "budget", "checked": false},
    {"label": "Team Collaboration", "value": "collaboration", "checked": false},
  ];

  final formKey = GlobalKey<FormState>();

  void _nextStep() {
    if (currentStep < 4) {
      if (_validateCurrentStep()) {
        currentStep++;
        setState(() {});
      }
    } else {
      _completeOnboarding();
    }
  }

  void _previousStep() {
    if (currentStep > 0) {
      currentStep--;
      setState(() {});
    }
  }

  bool _validateCurrentStep() {
    switch (currentStep) {
      case 0:
        if (fullName.isEmpty || email.isEmpty) {
          se("Please fill in all required fields");
          return false;
        }
        break;
      case 1:
        if (companyName.isEmpty || jobTitle.isEmpty || industry.isEmpty) {
          se("Please complete your professional information");
          return false;
        }
        break;
      case 2:
        if (experienceLevel.isEmpty) {
          se("Please select your experience level");
          return false;
        }
        break;
      case 3:
        if (interests.isEmpty) {
          se("Please select at least one interest");
          return false;
        }
        break;
      case 4:
        if (!agreeToTerms) {
          se("Please agree to the terms and conditions");
          return false;
        }
        break;
    }
    return true;
  }

  void _completeOnboarding() async {
    if (!_validateCurrentStep()) return;

    showLoading();
    await Future.delayed(Duration(seconds: 2));
    hideLoading();

    ss("Welcome to EMA! Your profile has been created successfully.");
    // Navigate to main app
    await offAll(EmaOnboardingView());
  }

  Widget _buildStep0() {
    return Column(
      spacing: spMd,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.all(spLg),
          decoration: BoxDecoration(
            color: primaryColor.withAlpha(20),
            borderRadius: BorderRadius.circular(radiusLg),
          ),
          child: Column(
            children: [
              Icon(
                Icons.person_add,
                size: 64,
                color: primaryColor,
              ),
              SizedBox(height: spSm),
              Text(
                "Welcome to EMA",
                style: TextStyle(
                  fontSize: fsH3,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              SizedBox(height: spXs),
              Text(
                "Let's get you started with your event management journey",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
        ),
        Text(
          "Personal Information",
          style: TextStyle(
            fontSize: fsH5,
            fontWeight: FontWeight.bold,
          ),
        ),
        QTextField(
          label: "Full Name",
          value: fullName,
          hint: "Enter your full name",
          validator: Validator.required,
          onChanged: (value) {
            fullName = value;
            setState(() {});
          },
        ),
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
      ],
    );
  }

  Widget _buildStep1() {
    return Column(
      spacing: spMd,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.all(spLg),
          decoration: BoxDecoration(
            color: secondaryColor.withAlpha(20),
            borderRadius: BorderRadius.circular(radiusLg),
          ),
          child: Column(
            children: [
              Icon(
                Icons.business,
                size: 64,
                color: secondaryColor,
              ),
              SizedBox(height: spSm),
              Text(
                "Professional Details",
                style: TextStyle(
                  fontSize: fsH4,
                  fontWeight: FontWeight.bold,
                  color: secondaryColor,
                ),
              ),
              SizedBox(height: spXs),
              Text(
                "Help us understand your professional background",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
        ),
        QTextField(
          label: "Company Name",
          value: companyName,
          hint: "Enter your company name",
          validator: Validator.required,
          onChanged: (value) {
            companyName = value;
            setState(() {});
          },
        ),
        QTextField(
          label: "Job Title",
          value: jobTitle,
          hint: "Enter your job title",
          validator: Validator.required,
          onChanged: (value) {
            jobTitle = value;
            setState(() {});
          },
        ),
        QDropdownField(
          label: "Industry",
          items: industries,
          value: industry,
          validator: Validator.required,
          onChanged: (value, label) {
            industry = value;
            setState(() {});
          },
        ),
      ],
    );
  }

  Widget _buildStep2() {
    return Column(
      spacing: spMd,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.all(spLg),
          decoration: BoxDecoration(
            color: infoColor.withAlpha(20),
            borderRadius: BorderRadius.circular(radiusLg),
          ),
          child: Column(
            children: [
              Icon(
                Icons.star,
                size: 64,
                color: infoColor,
              ),
              SizedBox(height: spSm),
              Text(
                "Experience Level",
                style: TextStyle(
                  fontSize: fsH4,
                  fontWeight: FontWeight.bold,
                  color: infoColor,
                ),
              ),
              SizedBox(height: spXs),
              Text(
                "This helps us customize your experience",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
        ),
        QDropdownField(
          label: "Experience Level",
          items: experienceLevels,
          value: experienceLevel,
          validator: Validator.required,
          onChanged: (value, label) {
            experienceLevel = value;
            setState(() {});
          },
        ),
        Container(
          padding: EdgeInsets.all(spMd),
          decoration: BoxDecoration(
            color: Colors.grey.withAlpha(20),
            borderRadius: BorderRadius.circular(radiusMd),
            border: Border.all(color: disabledOutlineBorderColor),
          ),
          child: Column(
            spacing: spSm,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "What this means:",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: primaryColor,
                ),
              ),
              Row(
                children: [
                  Icon(Icons.check_circle, color: successColor, size: 16),
                  SizedBox(width: spXs),
                  Expanded(
                    child: Text(
                      "Personalized recommendations based on your level",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Icon(Icons.check_circle, color: successColor, size: 16),
                  SizedBox(width: spXs),
                  Expanded(
                    child: Text(
                      "Relevant tutorials and best practices",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Icon(Icons.check_circle, color: successColor, size: 16),
                  SizedBox(width: spXs),
                  Expanded(
                    child: Text(
                      "Connect with peers at similar levels",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildStep3() {
    return Column(
      spacing: spMd,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.all(spLg),
          decoration: BoxDecoration(
            color: warningColor.withAlpha(20),
            borderRadius: BorderRadius.circular(radiusLg),
          ),
          child: Column(
            children: [
              Icon(
                Icons.interests,
                size: 64,
                color: warningColor,
              ),
              SizedBox(height: spSm),
              Text(
                "Your Interests",
                style: TextStyle(
                  fontSize: fsH4,
                  fontWeight: FontWeight.bold,
                  color: warningColor,
                ),
              ),
              SizedBox(height: spXs),
              Text(
                "Select areas you're most interested in",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
        ),
        QSwitch(
          label: "Select Your Interests (Choose multiple)",
          items: availableInterests,
          value: availableInterests.where((item) => interests.contains(item["value"])).toList(),
          onChanged: (values, ids) {
            interests = values.map((item) => item["value"] as String).toList();
            setState(() {});
          },
        ),
        Text(
          "Goals & Objectives",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
          ),
        ),
        QSwitch(
          label: "What do you want to achieve? (Optional)",
          items: availableGoals,
          value: availableGoals.where((item) => goals.contains(item["value"])).toList(),
          onChanged: (values, ids) {
            goals = values.map((item) => item["value"] as String).toList();
            setState(() {});
          },
        ),
      ],
    );
  }

  Widget _buildStep4() {
    return Column(
      spacing: spMd,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.all(spLg),
          decoration: BoxDecoration(
            color: successColor.withAlpha(20),
            borderRadius: BorderRadius.circular(radiusLg),
          ),
          child: Column(
            children: [
              Icon(
                Icons.check_circle,
                size: 64,
                color: successColor,
              ),
              SizedBox(height: spSm),
              Text(
                "Almost Ready!",
                style: TextStyle(
                  fontSize: fsH4,
                  fontWeight: FontWeight.bold,
                  color: successColor,
                ),
              ),
              SizedBox(height: spXs),
              Text(
                "Review and confirm your preferences",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.all(spMd),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(radiusMd),
            border: Border.all(color: disabledOutlineBorderColor),
          ),
          child: Column(
            spacing: spSm,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Profile Summary",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Row(
                children: [
                  Text("Name: ", style: TextStyle(fontWeight: FontWeight.w600)),
                  Text("$fullName"),
                ],
              ),
              Row(
                children: [
                  Text("Email: ", style: TextStyle(fontWeight: FontWeight.w600)),
                  Text("$email"),
                ],
              ),
              Row(
                children: [
                  Text("Company: ", style: TextStyle(fontWeight: FontWeight.w600)),
                  Text("$companyName"),
                ],
              ),
              Row(
                children: [
                  Text("Position: ", style: TextStyle(fontWeight: FontWeight.w600)),
                  Text("$jobTitle"),
                ],
              ),
              Row(
                children: [
                  Text("Experience: ", style: TextStyle(fontWeight: FontWeight.w600)),
                  Text("${experienceLevels.firstWhere((e) => e["value"] == experienceLevel)["label"]}"),
                ],
              ),
              if (interests.isNotEmpty) ...[
                Text("Interests: ", style: TextStyle(fontWeight: FontWeight.w600)),
                Wrap(
                  spacing: spXs,
                  children: interests.map((interest) {
                    String label = availableInterests.firstWhere((item) => item["value"] == interest)["label"];
                    return Container(
                      padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                      decoration: BoxDecoration(
                        color: primaryColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Text(
                        label,
                        style: TextStyle(
                          fontSize: 12,
                          color: primaryColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ],
            ],
          ),
        ),
        QSwitch(
          items: [
            {
              "label": "I agree to the Terms and Conditions",
              "value": true,
              "checked": agreeToTerms,
            }
          ],
          value: [if (agreeToTerms) {"label": "I agree to the Terms and Conditions", "value": true, "checked": true}],
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
          value: [if (subscribeNewsletter) {"label": "Subscribe to newsletter and updates", "value": true, "checked": true}],
          onChanged: (values, ids) {
            subscribeNewsletter = values.isNotEmpty;
            setState(() {});
          },
        ),
      ],
    );
  }

  Widget _buildStepIndicator() {
    return Container(
      padding: EdgeInsets.all(spMd),
      child: Row(
        children: List.generate(5, (index) {
          bool isActive = index <= currentStep;
          bool isCurrent = index == currentStep;
          
          return Expanded(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: spXs),
              child: Column(
                children: [
                  Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      color: isActive ? primaryColor : disabledColor,
                      borderRadius: BorderRadius.circular(16),
                      border: isCurrent ? Border.all(color: primaryColor, width: 3) : null,
                    ),
                    child: Center(
                      child: isActive && index < currentStep 
                        ? Icon(Icons.check, color: Colors.white, size: 18)
                        : Text(
                            "${index + 1}",
                            style: TextStyle(
                              color: isActive ? Colors.white : disabledBoldColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                    ),
                  ),
                  SizedBox(height: spXs),
                  Container(
                    height: 4,
                    decoration: BoxDecoration(
                      color: isActive ? primaryColor : disabledColor,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Get Started"),
      ),
      body: Column(
        children: [
          _buildStepIndicator(),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(spMd),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    if (currentStep == 0) _buildStep0(),
                    if (currentStep == 1) _buildStep1(),
                    if (currentStep == 2) _buildStep2(),
                    if (currentStep == 3) _buildStep3(),
                    if (currentStep == 4) _buildStep4(),
                  ],
                ),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(top: BorderSide(color: disabledOutlineBorderColor)),
            ),
            child: Row(
              children: [
                if (currentStep > 0)
                  Expanded(
                    child: QButton(
                      label: "Previous",
                      color: disabledColor,
                      size: bs.md,
                      onPressed: _previousStep,
                    ),
                  ),
                if (currentStep > 0) SizedBox(width: spMd),
                Expanded(
                  flex: currentStep == 0 ? 1 : 1,
                  child: QButton(
                    label: currentStep == 4 ? "Complete Setup" : "Next",
                    size: bs.md,
                    onPressed: _nextStep,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
