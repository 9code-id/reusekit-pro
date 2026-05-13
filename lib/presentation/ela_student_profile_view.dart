import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class ElaStudentProfileView extends StatefulWidget {
  const ElaStudentProfileView({super.key});

  @override
  State<ElaStudentProfileView> createState() => _ElaStudentProfileViewState();
}

class _ElaStudentProfileViewState extends State<ElaStudentProfileView> {
  final formKey = GlobalKey<FormState>();
  String profileImage = "";
  String studentId = "";
  String grade = "";
  String school = "";
  String dateOfBirth = "";
  String interests = "";
  String learningGoals = "";
  String preferredLanguage = "";
  
  List<Map<String, dynamic>> gradeOptions = [
    {"label": "Grade 1", "value": "1"},
    {"label": "Grade 2", "value": "2"},
    {"label": "Grade 3", "value": "3"},
    {"label": "Grade 4", "value": "4"},
    {"label": "Grade 5", "value": "5"},
    {"label": "Grade 6", "value": "6"},
    {"label": "Grade 7", "value": "7"},
    {"label": "Grade 8", "value": "8"},
    {"label": "Grade 9", "value": "9"},
    {"label": "Grade 10", "value": "10"},
    {"label": "Grade 11", "value": "11"},
    {"label": "Grade 12", "value": "12"},
  ];

  List<Map<String, dynamic>> languageOptions = [
    {"label": "English", "value": "en"},
    {"label": "Spanish", "value": "es"},
    {"label": "French", "value": "fr"},
    {"label": "German", "value": "de"},
    {"label": "Chinese", "value": "zh"},
    {"label": "Japanese", "value": "ja"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Student Profile"),
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
                        color: primaryColor.withAlpha(20),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.school,
                        size: 50,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spMd),
                    Text(
                      "Complete Your Student Profile",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "Help us personalize your learning experience",
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
                "Profile Picture",
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
                hint: "Upload your profile picture",
                onChanged: (value) {
                  profileImage = value;
                  setState(() {});
                },
              ),
              SizedBox(height: spLg),

              // Academic Information
              Text(
                "Academic Information",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              SizedBox(height: spMd),
              
              QTextField(
                label: "Student ID",
                value: studentId,
                hint: "Enter your student ID (optional)",
                onChanged: (value) {
                  studentId = value;
                  setState(() {});
                },
              ),
              SizedBox(height: spMd),
              
              QDropdownField(
                label: "Current Grade",
                items: gradeOptions,
                value: grade,
                onChanged: (value, label) {
                  grade = value;
                  setState(() {});
                },
              ),
              SizedBox(height: spMd),
              
              QTextField(
                label: "School/Institution",
                value: school,
                hint: "Enter your school name",
                validator: Validator.required,
                onChanged: (value) {
                  school = value;
                  setState(() {});
                },
              ),
              SizedBox(height: spMd),
              
              QDatePicker(
                label: "Date of Birth",
                value: dateOfBirth.isNotEmpty ? DateTime.parse(dateOfBirth) : DateTime.now(),
                onChanged: (value) {
                  dateOfBirth = value.toString();
                  setState(() {});
                },
              ),
              SizedBox(height: spLg),

              // Learning Preferences
              Text(
                "Learning Preferences",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              SizedBox(height: spMd),
              
              QMemoField(
                label: "Interests & Hobbies",
                value: interests,
                hint: "Tell us about your interests (e.g., Science, Art, Sports)",
                onChanged: (value) {
                  interests = value;
                  setState(() {});
                },
              ),
              SizedBox(height: spMd),
              
              QMemoField(
                label: "Learning Goals",
                value: learningGoals,
                hint: "What do you hope to achieve? (e.g., Improve math skills, Learn coding)",
                onChanged: (value) {
                  learningGoals = value;
                  setState(() {});
                },
              ),
              SizedBox(height: spMd),
              
              QDropdownField(
                label: "Preferred Language",
                items: languageOptions,
                value: preferredLanguage,
                onChanged: (value, label) {
                  preferredLanguage = value;
                  setState(() {});
                },
              ),
              SizedBox(height: spLg),

              // Progress Summary
              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: primaryColor.withAlpha(10),
                  borderRadius: BorderRadius.circular(radiusMd),
                  border: Border.all(
                    color: primaryColor.withAlpha(40),
                    width: 1,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.school,
                          size: 20,
                          color: primaryColor,
                        ),
                        SizedBox(width: spSm),
                        Text(
                          "Your Learning Journey Starts Here!",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "Once you complete your profile, you'll have access to:\n• Personalized course recommendations\n• Progress tracking and analytics\n• Interactive learning materials\n• Study groups and discussions\n• Achievement badges and rewards",
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
                  label: "Complete Profile",
                  icon: Icons.check_circle,
                  size: bs.md,
                  onPressed: () {
                    _completeProfile();
                  },
                ),
              ),
              SizedBox(height: spMd),
              
              Container(
                width: double.infinity,
                child: QButton(
                  label: "Skip for Now",
                  color: disabledBoldColor,
                  size: bs.md,
                  onPressed: () {
                    _skipProfile();
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

  void _completeProfile() async {
    if (formKey.currentState!.validate()) {
      showLoading();
      await Future.delayed(Duration(seconds: 2));
      hideLoading();
      
      // navigateTo(ElaHomeView())
      ss("Profile completed successfully! Welcome to EduLearn!");
    }
  }

  void _skipProfile() async {
    bool isConfirmed = await confirm("Skip profile setup? You can complete it later in settings.");
    if (isConfirmed) {
      // navigateTo(ElaHomeView())
    }
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
              "Profile Setup Help",
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
                      "Why complete your profile?",
                      "A complete profile helps us provide personalized learning recommendations, track your progress effectively, and connect you with relevant courses and study materials.",
                    ),
                    _buildHelpSection(
                      "Student ID",
                      "Your student ID helps schools track your progress. This field is optional and can be added later if your institution uses our platform.",
                    ),
                    _buildHelpSection(
                      "Learning Goals",
                      "Sharing your learning goals helps us recommend courses and materials that align with your objectives. Be specific about what you want to achieve.",
                    ),
                    _buildHelpSection(
                      "Privacy & Security",
                      "Your profile information is kept secure and private. Only you and authorized educators can access your learning data.",
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
