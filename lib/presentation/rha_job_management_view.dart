import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class RhaJobManagementView extends StatefulWidget {
  const RhaJobManagementView({super.key});

  @override
  State<RhaJobManagementView> createState() => _RhaJobManagementViewState();
}

class _RhaJobManagementViewState extends State<RhaJobManagementView> {
  final formKey = GlobalKey<FormState>();
  String jobTitle = "";
  String department = "";
  String location = "";
  String jobType = "";
  String experienceLevel = "";
  String salaryMin = "";
  String salaryMax = "";
  String jobDescription = "";
  String requirements = "";
  String benefits = "";
  String applicationDeadline = "";
  bool isRemote = false;
  bool isUrgent = false;
  bool loading = false;

  List<Map<String, dynamic>> departmentOptions = [
    {"label": "Engineering", "value": "engineering"},
    {"label": "Sales", "value": "sales"},
    {"label": "Marketing", "value": "marketing"},
    {"label": "HR", "value": "hr"},
    {"label": "Finance", "value": "finance"},
    {"label": "Operations", "value": "operations"},
    {"label": "Design", "value": "design"},
    {"label": "Customer Service", "value": "customer_service"},
  ];

  List<Map<String, dynamic>> jobTypeOptions = [
    {"label": "Full-time", "value": "full_time"},
    {"label": "Part-time", "value": "part_time"},
    {"label": "Contract", "value": "contract"},
    {"label": "Freelance", "value": "freelance"},
    {"label": "Internship", "value": "internship"},
  ];

  List<Map<String, dynamic>> experienceOptions = [
    {"label": "Entry Level (0-2 years)", "value": "entry"},
    {"label": "Mid Level (3-5 years)", "value": "mid"},
    {"label": "Senior Level (5-8 years)", "value": "senior"},
    {"label": "Executive Level (8+ years)", "value": "executive"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create Job Posting"),
        actions: [
          IconButton(
            onPressed: () {
              // Save as draft
              _saveDraft();
            },
            icon: Icon(Icons.save),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Form(
          key: formKey,
          child: Column(
            spacing: spMd,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Job Posting Header
              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: primaryColor.withAlpha(10),
                  borderRadius: BorderRadius.circular(radiusMd),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: primaryColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Icon(
                        Icons.work,
                        color: primaryColor,
                        size: 24,
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Create New Job Posting",
                            style: TextStyle(
                              fontSize: fsH6,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          Text(
                            "Fill in the details to post a new job opening",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
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
                      label: "Job Title",
                      value: jobTitle,
                      hint: "e.g., Senior Frontend Developer",
                      validator: Validator.required,
                      onChanged: (value) {
                        jobTitle = value;
                        setState(() {});
                      },
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: QDropdownField(
                            label: "Department",
                            items: departmentOptions,
                            value: department,
                            onChanged: (value, label) {
                              department = value;
                              setState(() {});
                            },
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: QDropdownField(
                            label: "Job Type",
                            items: jobTypeOptions,
                            value: jobType,
                            onChanged: (value, label) {
                              jobType = value;
                              setState(() {});
                            },
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: QTextField(
                            label: "Location",
                            value: location,
                            hint: "e.g., New York, NY",
                            onChanged: (value) {
                              location = value;
                              setState(() {});
                            },
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: QDropdownField(
                            label: "Experience Level",
                            items: experienceOptions,
                            value: experienceLevel,
                            onChanged: (value, label) {
                              experienceLevel = value;
                              setState(() {});
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Compensation & Work Arrangement
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
                      "Compensation & Work Arrangement",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: QNumberField(
                            label: "Minimum Salary (\$)",
                            value: salaryMin,
                            onChanged: (value) {
                              salaryMin = value;
                              setState(() {});
                            },
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: QNumberField(
                            label: "Maximum Salary (\$)",
                            value: salaryMax,
                            onChanged: (value) {
                              salaryMax = value;
                              setState(() {});
                            },
                          ),
                        ),
                      ],
                    ),
                    // Work Arrangement Options
                    Row(
                      children: [
                        Expanded(
                          child: QSwitch(
                            items: [
                              {
                                "label": "Remote Work Available",
                                "value": true,
                                "checked": isRemote,
                              }
                            ],
                            value: [
                              if (isRemote)
                                {
                                  "label": "Remote Work Available",
                                  "value": true,
                                  "checked": true
                                }
                            ],
                            onChanged: (values, ids) {
                              isRemote = values.isNotEmpty;
                              setState(() {});
                            },
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: QSwitch(
                            items: [
                              {
                                "label": "Urgent Hiring",
                                "value": true,
                                "checked": isUrgent,
                              }
                            ],
                            value: [
                              if (isUrgent)
                                {
                                  "label": "Urgent Hiring",
                                  "value": true,
                                  "checked": true
                                }
                            ],
                            onChanged: (values, ids) {
                              isUrgent = values.isNotEmpty;
                              setState(() {});
                            },
                          ),
                        ),
                      ],
                    ),
                    QDatePicker(
                      label: "Application Deadline",
                      value: applicationDeadline.isNotEmpty 
                          ? DateTime.parse(applicationDeadline) 
                          : DateTime.now().add(Duration(days: 30)),
                      onChanged: (value) {
                        applicationDeadline = value.toString();
                        setState(() {});
                      },
                    ),
                  ],
                ),
              ),

              // Job Details
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
                      "Job Details",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                    QMemoField(
                      label: "Job Description",
                      value: jobDescription,
                      hint: "Describe the role, responsibilities, and what the candidate will be doing...",
                      validator: Validator.required,
                      onChanged: (value) {
                        jobDescription = value;
                        setState(() {});
                      },
                    ),
                    QMemoField(
                      label: "Requirements & Qualifications",
                      value: requirements,
                      hint: "List required skills, education, experience, and qualifications...",
                      validator: Validator.required,
                      onChanged: (value) {
                        requirements = value;
                        setState(() {});
                      },
                    ),
                    QMemoField(
                      label: "Benefits & Perks",
                      value: benefits,
                      hint: "Describe benefits, perks, and what makes this opportunity attractive...",
                      onChanged: (value) {
                        benefits = value;
                        setState(() {});
                      },
                    ),
                  ],
                ),
              ),

              // Preview Section
              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: infoColor.withAlpha(10),
                  borderRadius: BorderRadius.circular(radiusMd),
                  border: Border.all(
                    color: infoColor.withAlpha(30),
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
                          Icons.preview,
                          color: infoColor,
                          size: 20,
                        ),
                        SizedBox(width: spSm),
                        Text(
                          "Job Posting Preview",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: infoColor,
                          ),
                        ),
                      ],
                    ),
                    if (jobTitle.isNotEmpty) ...[
                      Text(
                        jobTitle,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      if (department.isNotEmpty || location.isNotEmpty)
                        Text(
                          "${department.isNotEmpty ? departmentOptions.firstWhere((d) => d["value"] == department, orElse: () => {"label": ""})["label"] : ""} ${department.isNotEmpty && location.isNotEmpty ? "•" : ""} ${location}",
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                          ),
                        ),
                      if (salaryMin.isNotEmpty || salaryMax.isNotEmpty)
                        Text(
                          "Salary: \$${salaryMin.isEmpty ? "0" : salaryMin} - \$${salaryMax.isEmpty ? "0" : salaryMax}",
                          style: TextStyle(
                            fontSize: 14,
                            color: successColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                    ] else ...[
                      Text(
                        "Fill in the job details above to see the preview",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ],
                  ],
                ),
              ),

              // Action Buttons
              Row(
                spacing: spSm,
                children: [
                  Expanded(
                    child: QButton(
                      label: "Save as Draft",
                      size: bs.md,
                      color: disabledBoldColor,
                      onPressed: () {
                        _saveDraft();
                      },
                    ),
                  ),
                  Expanded(
                    child: QButton(
                      label: loading ? "Publishing..." : "Publish Job",
                      size: bs.md,
                      onPressed: loading ? null : _publishJob,
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

  void _saveDraft() async {
    loading = true;
    setState(() {});

    // Simulate API call
    await Future.delayed(Duration(seconds: 1));

    loading = false;
    setState(() {});

    ss("Job posting saved as draft");
  }

  void _publishJob() async {
    if (!formKey.currentState!.validate()) return;

    if (jobTitle.isEmpty || jobDescription.isEmpty || requirements.isEmpty) {
      se("Please fill in all required fields");
      return;
    }

    loading = true;
    setState(() {});

    // Simulate API call
    await Future.delayed(Duration(seconds: 2));

    loading = false;
    setState(() {});

    ss("Job posting published successfully!");
    // ss('Next page'));
  }
}
