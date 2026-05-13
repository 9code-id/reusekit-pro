import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class EmaProfileSetupView extends StatefulWidget {
  const EmaProfileSetupView({super.key});

  @override
  State<EmaProfileSetupView> createState() => _EmaProfileSetupViewState();
}

class _EmaProfileSetupViewState extends State<EmaProfileSetupView> {
  final formKey = GlobalKey<FormState>();
  
  // Profile Information
  String firstName = "";
  String lastName = "";
  String profileImage = "";
  String phoneNumber = "";
  String dateOfBirth = "";
  String gender = "";
  String location = "";
  String bio = "";
  
  // Work Information
  String jobTitle = "";
  String company = "";
  String department = "";
  String workLocation = "";
  
  // Notification Preferences
  bool emailNotifications = true;
  bool pushNotifications = true;
  bool marketingEmails = false;
  bool weeklyDigest = true;
  
  // Privacy Settings
  bool profileVisibility = true;
  bool showEmail = false;
  bool showPhone = false;
  
  int currentStep = 0;
  
  final List<Map<String, dynamic>> genderOptions = [
    {"label": "Male", "value": "male"},
    {"label": "Female", "value": "female"},
    {"label": "Other", "value": "other"},
    {"label": "Prefer not to say", "value": "not_specified"},
  ];
  
  final List<Map<String, dynamic>> locationOptions = [
    {"label": "New York, NY", "value": "ny"},
    {"label": "Los Angeles, CA", "value": "la"},
    {"label": "Chicago, IL", "value": "chicago"},
    {"label": "Houston, TX", "value": "houston"},
    {"label": "Phoenix, AZ", "value": "phoenix"},
    {"label": "Philadelphia, PA", "value": "philadelphia"},
    {"label": "San Antonio, TX", "value": "san_antonio"},
    {"label": "San Diego, CA", "value": "san_diego"},
  ];
  
  void _nextStep() {
    if (currentStep < 3) {
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
  
  void _finishSetup() async {
    if (formKey.currentState!.validate()) {
      showLoading();
      await Future.delayed(Duration(seconds: 2));
      hideLoading();
      
      ss("Profile setup completed successfully!");
      //navigateTo(DashboardView());
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile Setup"),
        automaticallyImplyLeading: currentStep > 0,
        leading: currentStep > 0 ? IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: _previousStep,
        ) : null,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Progress Indicator
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Step ${currentStep + 1} of 4",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: spXs),
                    LinearProgressIndicator(
                      value: (currentStep + 1) / 4,
                      backgroundColor: disabledColor,
                      valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      _getStepTitle(currentStep),
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
              ),
              
              SizedBox(height: spMd),
              
              // Step Content
              _buildStepContent(currentStep),
              
              SizedBox(height: sp2xl),
              
              // Navigation Buttons
              Row(
                children: [
                  if (currentStep > 0) ...[
                    Expanded(
                      child: QButton(
                        label: "Previous",
                        color: disabledBoldColor,
                        size: bs.md,
                        onPressed: _previousStep,
                      ),
                    ),
                    SizedBox(width: spSm),
                  ],
                  Expanded(
                    flex: currentStep == 0 ? 1 : 1,
                    child: QButton(
                      label: currentStep == 3 ? "Complete Setup" : "Next",
                      size: bs.md,
                      onPressed: currentStep == 3 ? _finishSetup : _nextStep,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
  
  String _getStepTitle(int step) {
    switch (step) {
      case 0:
        return "Personal Information";
      case 1:
        return "Work Information";
      case 2:
        return "Notification Preferences";
      case 3:
        return "Privacy Settings";
      default:
        return "Setup";
    }
  }
  
  Widget _buildStepContent(int step) {
    switch (step) {
      case 0:
        return _buildPersonalInformationStep();
      case 1:
        return _buildWorkInformationStep();
      case 2:
        return _buildNotificationPreferencesStep();
      case 3:
        return _buildPrivacySettingsStep();
      default:
        return Container();
    }
  }
  
  Widget _buildPersonalInformationStep() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Text(
            "Tell us about yourself",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          
          Text(
            "This information helps us personalize your experience and connect you with relevant content.",
            style: TextStyle(
              fontSize: 14,
              color: disabledBoldColor,
            ),
          ),
          
          SizedBox(height: spSm),
          
          // Profile Image
          QImagePicker(
            label: "Profile Photo",
            value: profileImage,
            hint: "Upload your profile picture",
            onChanged: (value) {
              profileImage = value;
              setState(() {});
            },
          ),
          
          // Name Fields
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
          
          // Phone Number
          QTextField(
            label: "Phone Number",
            value: phoneNumber,
            hint: "+1 (555) 123-4567",
            onChanged: (value) {
              phoneNumber = value;
              setState(() {});
            },
          ),
          
          // Date of Birth
          QDatePicker(
            label: "Date of Birth",
            value: dateOfBirth.isNotEmpty ? DateTime.parse(dateOfBirth) : null,
            onChanged: (value) {
              dateOfBirth = value.toString();
              setState(() {});
            },
          ),
          
          // Gender
          QDropdownField(
            label: "Gender",
            items: genderOptions,
            value: gender,
            onChanged: (value, label) {
              gender = value;
              setState(() {});
            },
          ),
          
          // Location
          QDropdownField(
            label: "Location",
            items: locationOptions,
            value: location,
            onChanged: (value, label) {
              location = value;
              setState(() {});
            },
          ),
          
          // Bio
          QMemoField(
            label: "Bio",
            value: bio,
            hint: "Tell us a bit about yourself...",
            onChanged: (value) {
              bio = value;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }
  
  Widget _buildWorkInformationStep() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Text(
            "Professional Details",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          
          Text(
            "Help us understand your professional background to provide better networking opportunities.",
            style: TextStyle(
              fontSize: 14,
              color: disabledBoldColor,
            ),
          ),
          
          SizedBox(height: spSm),
          
          // Job Title
          QTextField(
            label: "Job Title",
            value: jobTitle,
            hint: "e.g. Senior Software Engineer",
            validator: Validator.required,
            onChanged: (value) {
              jobTitle = value;
              setState(() {});
            },
          ),
          
          // Company
          QTextField(
            label: "Company",
            value: company,
            hint: "e.g. Google Inc.",
            validator: Validator.required,
            onChanged: (value) {
              company = value;
              setState(() {});
            },
          ),
          
          // Department
          QTextField(
            label: "Department",
            value: department,
            hint: "e.g. Engineering, Marketing",
            onChanged: (value) {
              department = value;
              setState(() {});
            },
          ),
          
          // Work Location
          QTextField(
            label: "Work Location",
            value: workLocation,
            hint: "e.g. Remote, San Francisco",
            onChanged: (value) {
              workLocation = value;
              setState(() {});
            },
          ),
          
          // Info Card
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: infoColor.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusSm),
              border: Border.all(color: infoColor.withAlpha(100)),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.info,
                  color: infoColor,
                  size: 20,
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: Text(
                    "Your professional information will be used to suggest relevant connections and content. You can update this anytime in your profile settings.",
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
  
  Widget _buildNotificationPreferencesStep() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Text(
            "Notification Preferences",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          
          Text(
            "Choose how you'd like to receive notifications and updates.",
            style: TextStyle(
              fontSize: 14,
              color: disabledBoldColor,
            ),
          ),
          
          SizedBox(height: spSm),
          
          // Email Notifications
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              border: Border.all(color: disabledColor),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.email,
                  color: primaryColor,
                  size: 24,
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Email Notifications",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "Receive important updates via email",
                        style: TextStyle(
                          fontSize: 13,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Switch(
                  value: emailNotifications,
                  onChanged: (value) {
                    emailNotifications = value;
                    setState(() {});
                  },
                ),
              ],
            ),
          ),
          
          // Push Notifications
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              border: Border.all(color: disabledColor),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.notifications,
                  color: primaryColor,
                  size: 24,
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Push Notifications",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "Real-time notifications on your device",
                        style: TextStyle(
                          fontSize: 13,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Switch(
                  value: pushNotifications,
                  onChanged: (value) {
                    pushNotifications = value;
                    setState(() {});
                  },
                ),
              ],
            ),
          ),
          
          // Marketing Emails
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              border: Border.all(color: disabledColor),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.campaign,
                  color: primaryColor,
                  size: 24,
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Marketing Emails",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "Promotional content and special offers",
                        style: TextStyle(
                          fontSize: 13,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Switch(
                  value: marketingEmails,
                  onChanged: (value) {
                    marketingEmails = value;
                    setState(() {});
                  },
                ),
              ],
            ),
          ),
          
          // Weekly Digest
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              border: Border.all(color: disabledColor),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.schedule,
                  color: primaryColor,
                  size: 24,
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Weekly Digest",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "Weekly summary of your activity",
                        style: TextStyle(
                          fontSize: 13,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Switch(
                  value: weeklyDigest,
                  onChanged: (value) {
                    weeklyDigest = value;
                    setState(() {});
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildPrivacySettingsStep() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Text(
            "Privacy Settings",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          
          Text(
            "Control what information is visible to other users and how your data is used.",
            style: TextStyle(
              fontSize: 14,
              color: disabledBoldColor,
            ),
          ),
          
          SizedBox(height: spSm),
          
          // Profile Visibility
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              border: Border.all(color: disabledColor),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.visibility,
                  color: primaryColor,
                  size: 24,
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Profile Visibility",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "Make your profile visible to other users",
                        style: TextStyle(
                          fontSize: 13,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Switch(
                  value: profileVisibility,
                  onChanged: (value) {
                    profileVisibility = value;
                    setState(() {});
                  },
                ),
              ],
            ),
          ),
          
          // Show Email
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              border: Border.all(color: disabledColor),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.email_outlined,
                  color: primaryColor,
                  size: 24,
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Show Email Address",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "Allow others to see your email address",
                        style: TextStyle(
                          fontSize: 13,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Switch(
                  value: showEmail,
                  onChanged: (value) {
                    showEmail = value;
                    setState(() {});
                  },
                ),
              ],
            ),
          ),
          
          // Show Phone
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              border: Border.all(color: disabledColor),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.phone,
                  color: primaryColor,
                  size: 24,
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Show Phone Number",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "Allow others to see your phone number",
                        style: TextStyle(
                          fontSize: 13,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Switch(
                  value: showPhone,
                  onChanged: (value) {
                    showPhone = value;
                    setState(() {});
                  },
                ),
              ],
            ),
          ),
          
          // Privacy Notice
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: successColor.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusSm),
              border: Border.all(color: successColor.withAlpha(100)),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.security,
                  color: successColor,
                  size: 20,
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Privacy Protection",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: successColor,
                        ),
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "Your data is encrypted and secure. You can change these settings anytime from your profile. We never share your personal information without your consent.",
                        style: TextStyle(
                          fontSize: 13,
                          color: successColor,
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
}
