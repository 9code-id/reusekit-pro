import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class ElaTeacherProfileView extends StatefulWidget {
  const ElaTeacherProfileView({super.key});

  @override
  State<ElaTeacherProfileView> createState() => _ElaTeacherProfileViewState();
}

class _ElaTeacherProfileViewState extends State<ElaTeacherProfileView> {
  final formKey = GlobalKey<FormState>();
  String profileImage = "";
  String employeeId = "";
  String qualifications = "";
  String institution = "";
  String department = "";
  String experience = "";
  String specializations = "";
  String teachingPhilosophy = "";
  String contactHours = "";

  List<Map<String, dynamic>> experienceOptions = [
    {"label": "Less than 1 year", "value": "0-1"},
    {"label": "1-2 years", "value": "1-2"},
    {"label": "3-5 years", "value": "3-5"},
    {"label": "6-10 years", "value": "6-10"},
    {"label": "11-15 years", "value": "11-15"},
    {"label": "More than 15 years", "value": "15+"},
  ];

  List<Map<String, dynamic>> contactHoursOptions = [
    {"label": "Monday - Friday, 9 AM - 5 PM", "value": "weekdays_9_5"},
    {"label": "Monday - Friday, 8 AM - 4 PM", "value": "weekdays_8_4"},
    {"label": "Flexible hours", "value": "flexible"},
    {"label": "Evening hours (5 PM - 9 PM)", "value": "evening"},
    {"label": "Weekend availability", "value": "weekend"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Teacher Profile"),
        actions: [
          IconButton(
            icon: Icon(Icons.help),
            onPressed: () {
              _showHelp();
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Center(
                child: Column(
                  children: [
                    Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        color: successColor.withAlpha(20),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.person_2,
                        size: 50,
                        color: successColor,
                      ),
                    ),
                    SizedBox(height: spMd),
                    Text(
                      "Complete Your Teacher Profile",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "Help us set up your teaching environment",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: spXl),

              // Profile Picture
              Text(
                "Professional Profile",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              SizedBox(height: spMd),
              
              QImagePicker(
                label: "Profile Picture",
                value: profileImage,
                hint: "Upload your professional photo",
                onChanged: (value) {
                  profileImage = value;
                  setState(() {});
                },
              ),
              SizedBox(height: spLg),

              // Professional Information
              Text(
                "Professional Information",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              SizedBox(height: spMd),
              
              QTextField(
                label: "Employee/Faculty ID",
                value: employeeId,
                hint: "Enter your employee or faculty ID",
                validator: Validator.required,
                onChanged: (value) {
                  employeeId = value;
                  setState(() {});
                },
              ),
              SizedBox(height: spMd),
              
              QTextField(
                label: "Institution/School",
                value: institution,
                hint: "Enter your institution name",
                validator: Validator.required,
                onChanged: (value) {
                  institution = value;
                  setState(() {});
                },
              ),
              SizedBox(height: spMd),
              
              QTextField(
                label: "Department",
                value: department,
                hint: "Enter your department (e.g., Mathematics, Science)",
                validator: Validator.required,
                onChanged: (value) {
                  department = value;
                  setState(() {});
                },
              ),
              SizedBox(height: spMd),
              
              QDropdownField(
                label: "Teaching Experience",
                items: experienceOptions,
                value: experience,
                onChanged: (value, label) {
                  experience = value;
                  setState(() {});
                },
              ),
              SizedBox(height: spLg),

              // Academic Background
              Text(
                "Academic Background",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              SizedBox(height: spMd),
              
              QMemoField(
                label: "Qualifications & Degrees",
                value: qualifications,
                hint: "List your educational qualifications (e.g., M.Ed in Mathematics, Ph.D in Computer Science)",
                validator: Validator.required,
                onChanged: (value) {
                  qualifications = value;
                  setState(() {});
                },
              ),
              SizedBox(height: spMd),
              
              QMemoField(
                label: "Subject Specializations",
                value: specializations,
                hint: "List subjects you specialize in (e.g., Algebra, Physics, Creative Writing)",
                onChanged: (value) {
                  specializations = value;
                  setState(() {});
                },
              ),
              SizedBox(height: spLg),

              // Teaching Preferences
              Text(
                "Teaching Preferences",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              SizedBox(height: spMd),
              
              QMemoField(
                label: "Teaching Philosophy",
                value: teachingPhilosophy,
                hint: "Describe your teaching approach and philosophy",
                onChanged: (value) {
                  teachingPhilosophy = value;
                  setState(() {});
                },
              ),
              SizedBox(height: spMd),
              
              QDropdownField(
                label: "Preferred Contact Hours",
                items: contactHoursOptions,
                value: contactHours,
                onChanged: (value, label) {
                  contactHours = value;
                  setState(() {});
                },
              ),
              SizedBox(height: spLg),

              // Verification Notice
              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: warningColor.withAlpha(10),
                  borderRadius: BorderRadius.circular(radiusMd),
                  border: Border.all(
                    color: warningColor.withAlpha(40),
                    width: 1,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.verified_user,
                          size: 20,
                          color: warningColor,
                        ),
                        SizedBox(width: spSm),
                        Text(
                          "Account Verification Required",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: warningColor,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "Teacher accounts require verification by your institution. After completing your profile, an administrator will review and approve your account within 24-48 hours.",
                      style: TextStyle(
                        fontSize: 12,
                        color: primaryColor,
                        height: 1.5,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: spMd),

              // Features Preview
              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: successColor.withAlpha(10),
                  borderRadius: BorderRadius.circular(radiusMd),
                  border: Border.all(
                    color: successColor.withAlpha(40),
                    width: 1,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.person_2,
                          size: 20,
                          color: successColor,
                        ),
                        SizedBox(width: spSm),
                        Text(
                          "Teacher Features Access",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: successColor,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "Once verified, you'll have access to:\n• Course creation and management tools\n• Student progress tracking and analytics\n• Assignment and quiz builders\n• Grade book and reporting features\n• Communication tools with students and parents\n• Content library and resource sharing",
                      style: TextStyle(
                        fontSize: 12,
                        color: primaryColor,
                        height: 1.5,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: spLg),

              // Action Buttons
              Container(
                width: double.infinity,
                child: QButton(
                  label: "Submit for Verification",
                  icon: Icons.check_circle,
                  size: bs.md,
                  onPressed: () {
                    _submitProfile();
                  },
                ),
              ),
              SizedBox(height: spMd),
              
              Container(
                width: double.infinity,
                child: QButton(
                  label: "Save as Draft",
                  color: disabledBoldColor,
                  size: bs.md,
                  onPressed: () {
                    _saveDraft();
                  },
                ),
              ),
              SizedBox(height: spLg),
            ],
          ),
        ),
      ),
    );
  }

  void _submitProfile() async {
    if (formKey.currentState!.validate()) {
      showLoading();
      await Future.delayed(Duration(seconds: 2));
      hideLoading();
      
      _showVerificationDialog();
    }
  }

  void _saveDraft() async {
    showLoading();
    await Future.delayed(Duration(seconds: 1));
    hideLoading();
    
    ss("Profile saved as draft");
    // navigateTo(ElaHomeView())
  }

  void _showVerificationDialog() {
    showModalBottomSheet(
      context: context,
      isDismissible: false,
      builder: (context) => Container(
        padding: EdgeInsets.all(spMd),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: successColor.withAlpha(20),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.pending_actions,
                size: 40,
                color: successColor,
              ),
            ),
            SizedBox(height: spMd),
            Text(
              "Profile Submitted Successfully!",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spMd),
            Text(
              "Your teacher profile has been submitted for verification. You'll receive an email notification once your account is approved.",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: disabledBoldColor,
              ),
            ),
            SizedBox(height: spLg),
            Container(
              width: double.infinity,
              child: QButton(
                label: "Continue to Dashboard",
                size: bs.md,
                onPressed: () {
                  back();
                  // navigateTo(ElaHomeView())
                },
              ),
            ),
            SizedBox(height: spSm),
          ],
        ),
      ),
    );
  }

  void _showHelp() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.7,
        padding: EdgeInsets.all(spMd),
        child: Column(
          children: [
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: disabledColor,
                borderRadius: BorderRadius.circular(radiusXs),
              ),
            ),
            SizedBox(height: spMd),
            Text(
              "Teacher Profile Help",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spMd),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildHelpSection(
                      "Verification Process",
                      "Teacher accounts require institutional verification to ensure security and authenticity. This process typically takes 24-48 hours.",
                    ),
                    _buildHelpSection(
                      "Required Information",
                      "Please provide accurate information including your employee ID, qualifications, and institutional affiliation for faster verification.",
                    ),
                    _buildHelpSection(
                      "Teaching Features",
                      "Once verified, you'll have access to advanced teaching tools including course creation, student management, and progress tracking.",
                    ),
                    _buildHelpSection(
                      "Support",
                      "If you need assistance with verification or have questions about teacher features, contact our support team.",
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHelpSection(String title, String content) {
    return Container(
      margin: EdgeInsets.only(bottom: spMd),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusSm),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spXs),
          Text(
            content,
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }
}
