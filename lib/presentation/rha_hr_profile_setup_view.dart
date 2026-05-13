import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class RhaHrProfileSetupView extends StatefulWidget {
  const RhaHrProfileSetupView({super.key});

  @override
  State<RhaHrProfileSetupView> createState() => _RhaHrProfileSetupViewState();
}

class _RhaHrProfileSetupViewState extends State<RhaHrProfileSetupView> {
  final formKey = GlobalKey<FormState>();
  String fullName = "";
  String jobTitle = "";
  String department = "";
  String phoneNumber = "";
  String profilePhoto = "";
  String experience = "";
  String bio = "";
  bool loading = false;
  List<String> selectedSkills = [];

  List<Map<String, dynamic>> experienceOptions = [
    {"label": "Less than 1 year", "value": "0-1"},
    {"label": "1-3 years", "value": "1-3"},
    {"label": "3-5 years", "value": "3-5"},
    {"label": "5-10 years", "value": "5-10"},
    {"label": "10+ years", "value": "10+"},
  ];

  List<String> skillOptions = [
    "Recruitment",
    "Performance Management",
    "Employee Relations",
    "Compensation & Benefits",
    "Training & Development",
    "HR Analytics",
    "Compliance",
    "Payroll",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("HR Profile Setup"),
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Progress Header
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: primaryColor.withAlpha(10),
                borderRadius: BorderRadius.circular(radiusMd),
              ),
              child: Column(
                spacing: spSm,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.person_add,
                        color: primaryColor,
                        size: 24,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "Complete Your HR Profile",
                        style: TextStyle(
                          fontSize: fsH5,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    "Set up your HR profile to help colleagues connect with you and showcase your expertise.",
                    style: TextStyle(
                      fontSize: 14,
                      color: disabledBoldColor,
                    ),
                  ),
                  // Progress Indicator
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 4,
                          decoration: BoxDecoration(
                            color: primaryColor,
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                        ),
                      ),
                      SizedBox(width: spXs),
                      Expanded(
                        child: Container(
                          height: 4,
                          decoration: BoxDecoration(
                            color: primaryColor,
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Text(
                    "Step 2 of 2 - Your HR Profile",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),

            // Profile Photo
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                spacing: spMd,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Profile Photo",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.w600,
                      color: primaryColor,
                    ),
                  ),
                  QImagePicker(
                    label: "Upload Profile Photo",
                    value: profilePhoto,
                    hint: "Choose your profile picture",
                    onChanged: (value) {
                      profilePhoto = value;
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),

            // Basic Information
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Form(
                key: formKey,
                child: Column(
                  spacing: spMd,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Basic Information",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
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
                      label: "Job Title",
                      value: jobTitle,
                      hint: "e.g., HR Manager",
                      validator: Validator.required,
                      onChanged: (value) {
                        jobTitle = value;
                        setState(() {});
                      },
                    ),
                    QTextField(
                      label: "Department",
                      value: department,
                      hint: "e.g., Human Resources",
                      validator: Validator.required,
                      onChanged: (value) {
                        department = value;
                        setState(() {});
                      },
                    ),
                    QTextField(
                      label: "Phone Number",
                      value: phoneNumber,
                      hint: "+1 (555) 123-4567",
                      onChanged: (value) {
                        phoneNumber = value;
                        setState(() {});
                      },
                    ),
                  ],
                ),
              ),
            ),

            // Experience & Skills
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                spacing: spMd,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Experience & Skills",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.w600,
                      color: primaryColor,
                    ),
                  ),
                  QDropdownField(
                    label: "HR Experience",
                    items: experienceOptions,
                    value: experience,
                    onChanged: (value, label) {
                      experience = value;
                      setState(() {});
                    },
                  ),
                  // Skills Selection
                  Text(
                    "Core HR Skills",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: primaryColor,
                    ),
                  ),
                  Wrap(
                    spacing: spSm,
                    runSpacing: spSm,
                    children: skillOptions.map((skill) {
                      bool isSelected = selectedSkills.contains(skill);
                      return GestureDetector(
                        onTap: () {
                          if (isSelected) {
                            selectedSkills.remove(skill);
                          } else {
                            selectedSkills.add(skill);
                          }
                          setState(() {});
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: spSm,
                            vertical: spXs,
                          ),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? primaryColor
                                : Colors.grey.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                            border: Border.all(
                              color: isSelected
                                  ? primaryColor
                                  : disabledOutlineBorderColor,
                              width: 1,
                            ),
                          ),
                          child: Text(
                            skill,
                            style: TextStyle(
                              fontSize: 12,
                              color: isSelected ? Colors.white : disabledBoldColor,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                  QMemoField(
                    label: "Professional Bio",
                    value: bio,
                    hint: "Brief description of your HR experience and goals...",
                    onChanged: (value) {
                      bio = value;
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),

            // Welcome Message
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: successColor.withAlpha(10),
                borderRadius: BorderRadius.circular(radiusMd),
                border: Border.all(
                  color: successColor.withAlpha(30),
                  width: 1,
                ),
              ),
              child: Column(
                spacing: spSm,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.celebration,
                        color: successColor,
                        size: 20,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "Almost Done!",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: successColor,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    "Your HR platform is ready! Complete your profile to unlock all features and start managing your organization effectively.",
                    style: TextStyle(
                      fontSize: 13,
                      color: disabledBoldColor,
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),

            // Action Buttons
            Row(
              spacing: spSm,
              children: [
                Expanded(
                  child: QButton(
                    label: "Complete Later",
                    size: bs.md,
                    color: disabledBoldColor,
                    onPressed: () {
                      // ss('Next page'));
                    },
                  ),
                ),
                Expanded(
                  child: QButton(
                    label: loading ? "Setting Up..." : "Complete Setup",
                    size: bs.md,
                    onPressed: loading ? null : _completeSetup,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _completeSetup() async {
    if (!formKey.currentState!.validate()) return;

    if (fullName.isEmpty || jobTitle.isEmpty || department.isEmpty) {
      se("Please fill in all required fields");
      return;
    }

    loading = true;
    setState(() {});

    // Simulate API call
    await Future.delayed(Duration(seconds: 3));

    loading = false;
    setState(() {});

    ss("Profile setup completed successfully!");
    // ss('Next page'));
  }
}
