import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class RhaEditJobView extends StatefulWidget {
  const RhaEditJobView({super.key});

  @override
  State<RhaEditJobView> createState() => _RhaEditJobViewState();
}

class _RhaEditJobViewState extends State<RhaEditJobView> {
  final formKey = GlobalKey<FormState>();
  
  String jobTitle = "Senior Flutter Developer";
  String companyName = "Tech Solutions Inc";
  String location = "New York, NY";
  String jobType = "Full-time";
  String experience = "3-5 years";
  String salary = "80000";
  String description = "We are looking for an experienced Flutter developer to join our dynamic team. The ideal candidate will have strong experience in mobile app development and cross-platform solutions.";
  String requirements = "• Bachelor's degree in Computer Science\n• 3+ years Flutter development experience\n• Knowledge of Dart programming language\n• Experience with REST APIs\n• Strong problem-solving skills";
  String benefits = "• Competitive salary\n• Health insurance\n• Remote work options\n• Professional development budget\n• Flexible working hours";
  String deadline = "2024-08-15";
  bool isActive = true;
  bool isFeatured = false;
  bool allowRemote = true;
  
  List<Map<String, dynamic>> jobTypeItems = [
    {"label": "Full-time", "value": "Full-time"},
    {"label": "Part-time", "value": "Part-time"},
    {"label": "Contract", "value": "Contract"},
    {"label": "Internship", "value": "Internship"},
  ];
  
  List<Map<String, dynamic>> experienceItems = [
    {"label": "Entry Level", "value": "Entry Level"},
    {"label": "1-2 years", "value": "1-2 years"},
    {"label": "3-5 years", "value": "3-5 years"},
    {"label": "5+ years", "value": "5+ years"},
    {"label": "Senior Level", "value": "Senior Level"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Job Posting"),
        actions: [
          IconButton(
            icon: Icon(Icons.preview),
            onPressed: () {
              // Preview job posting
            },
          ),
          IconButton(
            icon: Icon(Icons.more_vert),
            onPressed: () {
              // More options
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Form(
          key: formKey,
          child: Column(
            spacing: spMd,
            children: [
              // Job Status Card
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: isActive ? successColor.withAlpha(20) : warningColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusMd),
                  border: Border.all(
                    color: isActive ? successColor : warningColor,
                    width: 1,
                  ),
                ),
                child: Row(
                  children: [
                    Icon(
                      isActive ? Icons.check_circle : Icons.pause_circle,
                      color: isActive ? successColor : warningColor,
                      size: 20,
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: Text(
                        isActive ? "Job posting is currently active" : "Job posting is paused",
                        style: TextStyle(
                          color: isActive ? successColor : warningColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    QButton(
                      label: isActive ? "Pause" : "Activate",
                      size: bs.sm,
                      onPressed: () {
                        isActive = !isActive;
                        setState(() {});
                      },
                    ),
                  ],
                ),
              ),

              // Basic Information Section
              Container(
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
                      "Basic Information",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    QTextField(
                      label: "Job Title",
                      value: jobTitle,
                      validator: Validator.required,
                      onChanged: (value) {
                        jobTitle = value;
                        setState(() {});
                      },
                    ),
                    QTextField(
                      label: "Company Name",
                      value: companyName,
                      validator: Validator.required,
                      onChanged: (value) {
                        companyName = value;
                        setState(() {});
                      },
                    ),
                    QTextField(
                      label: "Location",
                      value: location,
                      validator: Validator.required,
                      onChanged: (value) {
                        location = value;
                        setState(() {});
                      },
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: QDropdownField(
                            label: "Job Type",
                            items: jobTypeItems,
                            value: jobType,
                            onChanged: (value, label) {
                              jobType = value;
                              setState(() {});
                            },
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: QDropdownField(
                            label: "Experience Level",
                            items: experienceItems,
                            value: experience,
                            onChanged: (value, label) {
                              experience = value;
                              setState(() {});
                            },
                          ),
                        ),
                      ],
                    ),
                    QNumberField(
                      label: "Annual Salary (\$)",
                      value: salary,
                      validator: Validator.required,
                      onChanged: (value) {
                        salary = value;
                        setState(() {});
                      },
                    ),
                  ],
                ),
              ),

              // Job Details Section
              Container(
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
                      "Job Details",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    QMemoField(
                      label: "Job Description",
                      value: description,
                      validator: Validator.required,
                      onChanged: (value) {
                        description = value;
                        setState(() {});
                      },
                    ),
                    QMemoField(
                      label: "Requirements",
                      value: requirements,
                      validator: Validator.required,
                      onChanged: (value) {
                        requirements = value;
                        setState(() {});
                      },
                    ),
                    QMemoField(
                      label: "Benefits",
                      value: benefits,
                      onChanged: (value) {
                        benefits = value;
                        setState(() {});
                      },
                    ),
                  ],
                ),
              ),

              // Application Settings Section
              Container(
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
                      "Application Settings",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    QDatePicker(
                      label: "Application Deadline",
                      value: DateTime.parse(deadline),
                      onChanged: (value) {
                        deadline = value.toString().split(' ')[0];
                        setState(() {});
                      },
                    ),
                    QSwitch(
                      items: [
                        {
                          "label": "Mark as Featured",
                          "value": true,
                          "checked": isFeatured,
                        }
                      ],
                      value: [
                        if (isFeatured)
                          {
                            "label": "Mark as Featured",
                            "value": true,
                            "checked": true
                          }
                      ],
                      onChanged: (values, ids) {
                        isFeatured = values.isNotEmpty;
                        setState(() {});
                      },
                    ),
                    QSwitch(
                      items: [
                        {
                          "label": "Allow Remote Work",
                          "value": true,
                          "checked": allowRemote,
                        }
                      ],
                      value: [
                        if (allowRemote)
                          {
                            "label": "Allow Remote Work",
                            "value": true,
                            "checked": true
                          }
                      ],
                      onChanged: (values, ids) {
                        allowRemote = values.isNotEmpty;
                        setState(() {});
                      },
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
                      label: "Save Draft",
                      size: bs.md,
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          ss("Job saved as draft");
                        }
                      },
                    ),
                  ),
                  Expanded(
                    child: QButton(
                      label: "Update & Publish",
                      size: bs.md,
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          ss("Job posting updated successfully");
                        }
                      },
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
}
