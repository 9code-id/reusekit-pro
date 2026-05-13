import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class CmaProfileSetupView extends StatefulWidget {
  const CmaProfileSetupView({super.key});

  @override
  State<CmaProfileSetupView> createState() => _CmaProfileSetupViewState();
}

class _CmaProfileSetupViewState extends State<CmaProfileSetupView> {
  final formKey = GlobalKey<FormState>();
  String profileImage = "";
  String firstName = "";
  String lastName = "";
  String jobTitle = "";
  String phoneNumber = "";
  String country = "";
  String city = "";
  String bio = "";
  String linkedinProfile = "";
  String website = "";
  
  String selectedExperience = "1-3 years";
  String selectedSpecialty = "General Construction";
  List<String> selectedSkills = [];
  bool publicProfile = true;
  bool receiveNotifications = true;

  List<Map<String, dynamic>> experienceItems = [
    {"label": "Less than 1 year", "value": "Less than 1 year"},
    {"label": "1-3 years", "value": "1-3 years"},
    {"label": "3-5 years", "value": "3-5 years"},
    {"label": "5-10 years", "value": "5-10 years"},
    {"label": "10+ years", "value": "10+ years"},
  ];

  List<Map<String, dynamic>> specialtyItems = [
    {"label": "General Construction", "value": "General Construction"},
    {"label": "Residential Building", "value": "Residential Building"},
    {"label": "Commercial Construction", "value": "Commercial Construction"},
    {"label": "Civil Engineering", "value": "Civil Engineering"},
    {"label": "Project Management", "value": "Project Management"},
    {"label": "Architecture", "value": "Architecture"},
    {"label": "Electrical", "value": "Electrical"},
    {"label": "Plumbing", "value": "Plumbing"},
    {"label": "HVAC", "value": "HVAC"},
  ];

  List<Map<String, dynamic>> skillItems = [
    {"label": "Project Planning", "value": "project_planning", "checked": false},
    {"label": "Cost Estimation", "value": "cost_estimation", "checked": false},
    {"label": "Quality Control", "value": "quality_control", "checked": false},
    {"label": "Safety Management", "value": "safety_management", "checked": false},
    {"label": "Team Leadership", "value": "team_leadership", "checked": false},
    {"label": "Client Relations", "value": "client_relations", "checked": false},
    {"label": "Building Codes", "value": "building_codes", "checked": false},
    {"label": "Construction Law", "value": "construction_law", "checked": false},
  ];

  void _saveProfile() async {
    if (formKey.currentState!.validate()) {
      showLoading();
      
      // Simulate profile save
      await Future.delayed(Duration(seconds: 2));
      
      hideLoading();
      
      ss("Profile setup completed successfully!");
      // ss('Next page'));
    }
  }

  void _skipProfileSetup() async {
    bool isConfirmed = await confirm("Skip profile setup? You can complete this later in settings.");
    if (isConfirmed) {
      // ss('Next page'));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile Setup"),
        actions: [
          GestureDetector(
            onTap: _skipProfileSetup,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
              child: Text(
                "Skip",
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
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: spMd,
            children: [
              // Header
              Center(
                child: Column(
                  children: [
                    Text(
                      "Complete Your Profile",
                      style: TextStyle(
                        fontSize: fsH3,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "Help others know more about your construction expertise",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),

              // Profile Picture
              Text(
                "Profile Picture",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),

              QImagePicker(
                label: "Profile Photo",
                value: profileImage,
                hint: "Upload your professional photo",
                onChanged: (value) {
                  profileImage = value;
                  setState(() {});
                },
              ),

              // Basic Information
              Text(
                "Basic Information",
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
                      hint: "Enter first name",
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

              QTextField(
                label: "Job Title",
                value: jobTitle,
                hint: "e.g. Construction Manager, Site Supervisor",
                validator: Validator.required,
                onChanged: (value) {
                  jobTitle = value;
                  setState(() {});
                },
              ),

              QTextField(
                label: "Phone Number",
                value: phoneNumber,
                hint: "Enter your phone number",
                validator: Validator.required,
                onChanged: (value) {
                  phoneNumber = value;
                  setState(() {});
                },
              ),

              // Location
              Text(
                "Location",
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
                      label: "Country",
                      value: country,
                      hint: "Enter country",
                      validator: Validator.required,
                      onChanged: (value) {
                        country = value;
                        setState(() {});
                      },
                    ),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: QTextField(
                      label: "City",
                      value: city,
                      hint: "Enter city",
                      validator: Validator.required,
                      onChanged: (value) {
                        city = value;
                        setState(() {});
                      },
                    ),
                  ),
                ],
              ),

              // Professional Experience
              Text(
                "Professional Experience",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),

              QDropdownField(
                label: "Years of Experience",
                items: experienceItems,
                value: selectedExperience,
                validator: Validator.required,
                onChanged: (value, label) {
                  selectedExperience = value;
                  setState(() {});
                },
              ),

              QDropdownField(
                label: "Primary Specialty",
                items: specialtyItems,
                value: selectedSpecialty,
                validator: Validator.required,
                onChanged: (value, label) {
                  selectedSpecialty = value;
                  setState(() {});
                },
              ),

              // Skills
              Text(
                "Skills & Expertise",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),

              QSwitch(
                label: "Select your areas of expertise",
                items: skillItems,
                value: selectedSkills.map((skill) => 
                  skillItems.firstWhere((item) => item["value"] == skill)
                ).toList(),
                onChanged: (values, ids) {
                  selectedSkills = values.map((item) => item["value"] as String).toList();
                  setState(() {});
                },
              ),

              // Bio
              Text(
                "About You",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),

              QMemoField(
                label: "Professional Bio",
                value: bio,
                hint: "Tell us about your construction experience, achievements, and what makes you unique in the industry...",
                onChanged: (value) {
                  bio = value;
                  setState(() {});
                },
              ),

              // Social Links
              Text(
                "Professional Links (Optional)",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),

              QTextField(
                label: "LinkedIn Profile",
                value: linkedinProfile,
                hint: "https://linkedin.com/in/yourprofile",
                onChanged: (value) {
                  linkedinProfile = value;
                  setState(() {});
                },
              ),

              QTextField(
                label: "Website/Portfolio",
                value: website,
                hint: "https://yourwebsite.com",
                onChanged: (value) {
                  website = value;
                  setState(() {});
                },
              ),

              // Privacy Settings
              Text(
                "Privacy Settings",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),

              QSwitch(
                items: [
                  {
                    "label": "Make my profile visible to other CMA users",
                    "value": true,
                    "checked": publicProfile,
                  }
                ],
                value: [
                  if (publicProfile)
                    {
                      "label": "Make my profile visible to other CMA users",
                      "value": true,
                      "checked": true
                    }
                ],
                onChanged: (values, ids) {
                  setState(() {
                    publicProfile = values.isNotEmpty;
                  });
                },
              ),

              QSwitch(
                items: [
                  {
                    "label": "Receive notifications about industry updates",
                    "value": true,
                    "checked": receiveNotifications,
                  }
                ],
                value: [
                  if (receiveNotifications)
                    {
                      "label": "Receive notifications about industry updates",
                      "value": true,
                      "checked": true
                    }
                ],
                onChanged: (values, ids) {
                  setState(() {
                    receiveNotifications = values.isNotEmpty;
                  });
                },
              ),

              SizedBox(height: spMd),

              // Progress Indicator
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: infoColor.withAlpha(10),
                  borderRadius: BorderRadius.circular(radiusXs),
                  border: Border.all(color: infoColor.withAlpha(30)),
                ),
                child: Row(
                  children: [
                    Icon(Icons.info_outline, color: infoColor, size: 20),
                    SizedBox(width: spSm),
                    Expanded(
                      child: Text(
                        "Step 1 of 2: After completing your profile, you'll set up your company information.",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: spMd),

              // Action Buttons
              Container(
                width: double.infinity,
                child: QButton(
                  label: "Continue to Company Setup",
                  size: bs.md,
                  onPressed: _saveProfile,
                ),
              ),

              SizedBox(height: spSm),

              // Skip Button
              Center(
                child: GestureDetector(
                  onTap: _skipProfileSetup,
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 12),
                    child: Text(
                      "Skip for now",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),

              SizedBox(height: spMd),

              // Benefits Info
              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: successColor.withAlpha(10),
                  borderRadius: BorderRadius.circular(radiusSm),
                  border: Border.all(color: successColor.withAlpha(30)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.star, color: successColor, size: 24),
                        SizedBox(width: spSm),
                        Text(
                          "Profile Benefits",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: successColor,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "• Get discovered by potential clients and partners\n• Showcase your expertise and build credibility\n• Access exclusive networking opportunities\n• Receive personalized project recommendations",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: spMd),
            ],
          ),
        ),
      ),
    );
  }
}
