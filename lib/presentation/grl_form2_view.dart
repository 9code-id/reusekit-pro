import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlForm2View extends StatefulWidget {
  const GrlForm2View({Key? key}) : super(key: key);

  @override
  State<GrlForm2View> createState() => _GrlForm2ViewState();
}

class _GrlForm2ViewState extends State<GrlForm2View> {
  final formKey = GlobalKey<FormState>();
  
  String firstName = "";
  String lastName = "";
  String email = "";
  String phone = "";
  String position = "";
  String department = "";
  String experience = "";
  String expectedSalary = "";
  String availableDate = "";
  String workArrangement = "";
  String employmentType = "";
  String skills = "";
  String education = "";
  String coverLetter = "";
  String resumeFile = "";
  List<String> certifications = [];
  String linkedinProfile = "";
  String portfolioWebsite = "";
  bool relocateWillingness = false;
  bool travelWillingness = false;
  bool backgroundCheck = false;
  bool drugTest = false;
  bool loading = false;

  List<Map<String, dynamic>> experienceItems = [
    {"label": "Entry Level (0-2 years)", "value": "entry"},
    {"label": "Mid Level (3-5 years)", "value": "mid"},
    {"label": "Senior Level (6-10 years)", "value": "senior"},
    {"label": "Expert Level (10+ years)", "value": "expert"},
  ];

  List<Map<String, dynamic>> workArrangementItems = [
    {"label": "Remote", "value": "remote"},
    {"label": "On-site", "value": "onsite"},
    {"label": "Hybrid", "value": "hybrid"},
    {"label": "Flexible", "value": "flexible"},
  ];

  List<Map<String, dynamic>> employmentTypeItems = [
    {"label": "Full-time", "value": "fulltime"},
    {"label": "Part-time", "value": "parttime"},
    {"label": "Contract", "value": "contract"},
    {"label": "Freelance", "value": "freelance"},
  ];

  List<Map<String, dynamic>> educationItems = [
    {"label": "High School", "value": "highschool"},
    {"label": "Associate Degree", "value": "associate"},
    {"label": "Bachelor's Degree", "value": "bachelor"},
    {"label": "Master's Degree", "value": "master"},
    {"label": "PhD/Doctorate", "value": "phd"},
  ];

  void _submitForm() async {
    if (!formKey.currentState!.validate()) return;

    loading = true;
    setState(() {});

    // Simulate API call
    await Future.delayed(Duration(seconds: 2));

    loading = false;
    setState(() {});

    ss("Job application submitted successfully!");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Job Application"),
        actions: [
          IconButton(
            icon: Icon(Icons.help_outline),
            onPressed: () {
              si("Complete all sections to submit your job application");
            },
          ),
        ],
      ),
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: Column(
            spacing: spMd,
            children: [
              // Personal Information Section
              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [primaryColor.withAlpha(20), primaryColor.withAlpha(10)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(radiusLg),
                  border: Border.all(color: primaryColor.withAlpha(30)),
                ),
                child: Column(
                  spacing: spSm,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.person, color: primaryColor, size: 24),
                        SizedBox(width: spSm),
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
                    Row(
                      spacing: spSm,
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
                      validator: Validator.required,
                      onChanged: (value) {
                        phone = value;
                        setState(() {});
                      },
                    ),
                  ],
                ),
              ),

              // Job Details Section
              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [successColor.withAlpha(20), successColor.withAlpha(10)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(radiusLg),
                  border: Border.all(color: successColor.withAlpha(30)),
                ),
                child: Column(
                  spacing: spSm,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.work, color: successColor, size: 24),
                        SizedBox(width: spSm),
                        Text(
                          "Job Details",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: successColor,
                          ),
                        ),
                      ],
                    ),
                    QTextField(
                      label: "Position Applied For",
                      value: position,
                      validator: Validator.required,
                      onChanged: (value) {
                        position = value;
                        setState(() {});
                      },
                    ),
                    QTextField(
                      label: "Department",
                      value: department,
                      onChanged: (value) {
                        department = value;
                        setState(() {});
                      },
                    ),
                    Row(
                      spacing: spSm,
                      children: [
                        Expanded(
                          child: QDropdownField(
                            label: "Experience Level",
                            items: experienceItems,
                            value: experience,
                            validator: Validator.required,
                            onChanged: (value, label) {
                              experience = value;
                              setState(() {});
                            },
                          ),
                        ),
                        Expanded(
                          child: QNumberField(
                            label: "Expected Salary (\$)",
                            value: expectedSalary,
                            onChanged: (value) {
                              expectedSalary = value;
                              setState(() {});
                            },
                          ),
                        ),
                      ],
                    ),
                    QDatePicker(
                      label: "Available Start Date",
                      value: availableDate.isNotEmpty ? DateTime.parse(availableDate) : DateTime.now().add(Duration(days: 30)),
                      onChanged: (value) {
                        availableDate = "${value.year}-${value.month.toString().padLeft(2, '0')}-${value.day.toString().padLeft(2, '0')}";
                        setState(() {});
                      },
                    ),
                  ],
                ),
              ),

              // Work Preferences Section
              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [infoColor.withAlpha(20), infoColor.withAlpha(10)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(radiusLg),
                  border: Border.all(color: infoColor.withAlpha(30)),
                ),
                child: Column(
                  spacing: spSm,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.settings, color: infoColor, size: 24),
                        SizedBox(width: spSm),
                        Text(
                          "Work Preferences",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: infoColor,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      spacing: spSm,
                      children: [
                        Expanded(
                          child: QDropdownField(
                            label: "Work Arrangement",
                            items: workArrangementItems,
                            value: workArrangement,
                            onChanged: (value, label) {
                              workArrangement = value;
                              setState(() {});
                            },
                          ),
                        ),
                        Expanded(
                          child: QDropdownField(
                            label: "Employment Type",
                            items: employmentTypeItems,
                            value: employmentType,
                            onChanged: (value, label) {
                              employmentType = value;
                              setState(() {});
                            },
                          ),
                        ),
                      ],
                    ),
                    Row(
                      spacing: spSm,
                      children: [
                        Expanded(
                          child: QSwitch(
                            items: [
                              {
                                "label": "Willing to relocate",
                                "value": "relocate",
                                "checked": relocateWillingness,
                              }
                            ],
                            value: relocateWillingness ? [{"label": "Willing to relocate", "value": "relocate", "checked": true}] : [],
                            onChanged: (values, ids) {
                              relocateWillingness = values.isNotEmpty;
                              setState(() {});
                            },
                          ),
                        ),
                        Expanded(
                          child: QSwitch(
                            items: [
                              {
                                "label": "Willing to travel",
                                "value": "travel",
                                "checked": travelWillingness,
                              }
                            ],
                            value: travelWillingness ? [{"label": "Willing to travel", "value": "travel", "checked": true}] : [],
                            onChanged: (values, ids) {
                              travelWillingness = values.isNotEmpty;
                              setState(() {});
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Education & Skills Section
              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [warningColor.withAlpha(20), warningColor.withAlpha(10)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(radiusLg),
                  border: Border.all(color: warningColor.withAlpha(30)),
                ),
                child: Column(
                  spacing: spSm,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.school, color: warningColor, size: 24),
                        SizedBox(width: spSm),
                        Text(
                          "Education & Skills",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: warningColor,
                          ),
                        ),
                      ],
                    ),
                    QDropdownField(
                      label: "Highest Education",
                      items: educationItems,
                      value: education,
                      validator: Validator.required,
                      onChanged: (value, label) {
                        education = value;
                        setState(() {});
                      },
                    ),
                    QMemoField(
                      label: "Skills & Competencies",
                      value: skills,
                      hint: "List your relevant skills, separated by commas",
                      validator: Validator.required,
                      onChanged: (value) {
                        skills = value;
                        setState(() {});
                      },
                    ),
                    QAttachmentPicker(
                      label: "Certifications",
                      value: certifications,
                      hint: "Upload your certificates",
                      onChanged: (value) {
                        certifications = value;
                        setState(() {});
                      },
                    ),
                  ],
                ),
              ),

              // Documents & Links Section
              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [secondaryColor.withAlpha(20), secondaryColor.withAlpha(10)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(radiusLg),
                  border: Border.all(color: secondaryColor.withAlpha(30)),
                ),
                child: Column(
                  spacing: spSm,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.folder, color: secondaryColor, size: 24),
                        SizedBox(width: spSm),
                        Text(
                          "Documents & Links",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: secondaryColor,
                          ),
                        ),
                      ],
                    ),
                    QAttachmentPicker(
                      label: "Resume/CV",
                      value: resumeFile.isNotEmpty ? [resumeFile] : [],
                      hint: "Upload your resume",
                      maxAttachments: 1,
                      validator: (files) {
                        if (files == null || files.isEmpty) {
                          return "Resume is required";
                        }
                        return null;
                      },
                      onChanged: (value) {
                        resumeFile = value.isNotEmpty ? value.first : "";
                        setState(() {});
                      },
                    ),
                    QTextField(
                      label: "LinkedIn Profile",
                      value: linkedinProfile,
                      hint: "https://linkedin.com/in/username",
                      onChanged: (value) {
                        linkedinProfile = value;
                        setState(() {});
                      },
                    ),
                    QTextField(
                      label: "Portfolio Website",
                      value: portfolioWebsite,
                      hint: "https://yourportfolio.com",
                      onChanged: (value) {
                        portfolioWebsite = value;
                        setState(() {});
                      },
                    ),
                  ],
                ),
              ),

              // Cover Letter Section
              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [dangerColor.withAlpha(20), dangerColor.withAlpha(10)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(radiusLg),
                  border: Border.all(color: dangerColor.withAlpha(30)),
                ),
                child: Column(
                  spacing: spSm,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.description, color: dangerColor, size: 24),
                        SizedBox(width: spSm),
                        Text(
                          "Cover Letter",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: dangerColor,
                          ),
                        ),
                      ],
                    ),
                    QMemoField(
                      label: "Cover Letter",
                      value: coverLetter,
                      hint: "Tell us why you're the perfect fit for this position...",
                      validator: Validator.required,
                      onChanged: (value) {
                        coverLetter = value;
                        setState(() {});
                      },
                    ),
                  ],
                ),
              ),

              // Legal Agreements Section
              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.grey.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusLg),
                  border: Border.all(color: disabledOutlineBorderColor),
                ),
                child: Column(
                  spacing: spSm,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.gavel, color: disabledBoldColor, size: 24),
                        SizedBox(width: spSm),
                        Text(
                          "Legal Agreements",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                    QSwitch(
                      items: [
                        {
                          "label": "I consent to background check verification",
                          "value": "background",
                          "checked": backgroundCheck,
                        }
                      ],
                      value: backgroundCheck ? [{"label": "I consent to background check verification", "value": "background", "checked": true}] : [],
                      onChanged: (values, ids) {
                        backgroundCheck = values.isNotEmpty;
                        setState(() {});
                      },
                    ),
                    QSwitch(
                      items: [
                        {
                          "label": "I consent to drug testing if required",
                          "value": "drug",
                          "checked": drugTest,
                        }
                      ],
                      value: drugTest ? [{"label": "I consent to drug testing if required", "value": "drug", "checked": true}] : [],
                      onChanged: (values, ids) {
                        drugTest = values.isNotEmpty;
                        setState(() {});
                      },
                    ),
                  ],
                ),
              ),

              // Submit Button
              Container(
                width: double.infinity,
                child: loading
                    ? Center(child: CircularProgressIndicator())
                    : QButton(
                        label: "Submit Application",
                        size: bs.md,
                        onPressed: _submitForm,
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
