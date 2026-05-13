import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlOnboarding9View extends StatefulWidget {
  const GrlOnboarding9View({super.key});

  @override
  State<GrlOnboarding9View> createState() => _GrlOnboarding9ViewState();
}

class _GrlOnboarding9ViewState extends State<GrlOnboarding9View> {
  String firstName = "";
  String lastName = "";
  String email = "";
  String phone = "";
  String selectedRole = "";
  String selectedInterest = "";
  bool receiveNotifications = true;
  bool agreedToTerms = false;

  final List<Map<String, dynamic>> roles = [
    {"label": "Individual User", "value": "individual"},
    {"label": "Business Owner", "value": "business"},
    {"label": "Team Leader", "value": "team_leader"},
    {"label": "Developer", "value": "developer"},
  ];

  final List<Map<String, dynamic>> interests = [
    {"label": "Technology", "value": "technology"},
    {"label": "Business", "value": "business"},
    {"label": "Design", "value": "design"},
    {"label": "Marketing", "value": "marketing"},
    {"label": "Education", "value": "education"},
    {"label": "Healthcare", "value": "healthcare"},
  ];

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Complete Your Profile"),
      ),
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: spMd,
            children: [
              Text(
                "Tell us about yourself",
                style: TextStyle(
                  fontSize: fsH2,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Text(
                "Help us personalize your experience by providing some basic information about yourself.",
                style: TextStyle(
                  fontSize: 16,
                  color: disabledBoldColor,
                ),
              ),
              SizedBox(height: spMd),
              Row(
                spacing: spMd,
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
                hint: "+1 (555) 123-4567",
                onChanged: (value) {
                  phone = value;
                  setState(() {});
                },
              ),
              QDropdownField(
                label: "What best describes you?",
                items: roles,
                value: selectedRole,
                validator: Validator.required,
                onChanged: (value, label) {
                  selectedRole = value;
                  setState(() {});
                },
              ),
              QDropdownField(
                label: "Primary Interest",
                items: interests,
                value: selectedInterest,
                validator: Validator.required,
                onChanged: (value, label) {
                  selectedInterest = value;
                  setState(() {});
                },
              ),
              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.grey.shade50,
                  borderRadius: BorderRadius.circular(radiusLg),
                  border: Border.all(color: disabledOutlineBorderColor),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spMd,
                  children: [
                    Text(
                      "Preferences",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    QSwitch(
                      items: [
                        {
                          "label": "Receive notifications and updates",
                          "value": true,
                          "checked": receiveNotifications,
                        }
                      ],
                      value: [
                        if (receiveNotifications)
                          {
                            "label": "Receive notifications and updates",
                            "value": true,
                            "checked": true
                          }
                      ],
                      onChanged: (values, ids) {
                        receiveNotifications = values.isNotEmpty;
                        setState(() {});
                      },
                    ),
                    QSwitch(
                      items: [
                        {
                          "label": "I agree to the Terms of Service and Privacy Policy",
                          "value": true,
                          "checked": agreedToTerms,
                        }
                      ],
                      value: [
                        if (agreedToTerms)
                          {
                            "label": "I agree to the Terms of Service and Privacy Policy",
                            "value": true,
                            "checked": true
                          }
                      ],
                      onChanged: (values, ids) {
                        agreedToTerms = values.isNotEmpty;
                        setState(() {});
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(height: spMd),
              Container(
                width: double.infinity,
                child: QButton(
                  label: "Complete Setup",
                  size: bs.md,
                  onPressed: () {
                    if (formKey.currentState!.validate() && agreedToTerms) {
                      //navigateTo('dashboard')
                      ss("Profile setup completed successfully!");
                    } else if (!agreedToTerms) {
                      se("Please agree to the Terms of Service to continue");
                    }
                  },
                ),
              ),
              Container(
                width: double.infinity,
                child: QButton(
                  label: "Complete Later",
                  color: disabledBoldColor,
                  size: bs.md,
                  onPressed: () {
                    //navigateTo('dashboard')
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
