import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class RhaCreateJobView extends StatefulWidget {
  const RhaCreateJobView({super.key});

  @override
  State<RhaCreateJobView> createState() => _RhaCreateJobViewState();
}

class _RhaCreateJobViewState extends State<RhaCreateJobView> {
  final formKey = GlobalKey<FormState>();
  
  String jobTitle = "";
  String department = "";
  String location = "";
  String jobType = "Full-time";
  String experienceLevel = "Mid-level";
  String salaryMin = "";
  String salaryMax = "";
  String currency = "USD";
  String jobDescription = "";
  String requirements = "";
  String benefits = "";
  String skills = "";
  String deadline = "";
  String priority = "Medium";
  
  bool isRemoteWork = false;
  bool isUrgentHiring = false;
  bool autoScreening = true;
  bool emailNotifications = true;
  bool publicListing = true;
  
  List<Map<String, dynamic>> jobTypeOptions = [
    {"label": "Full-time", "value": "Full-time"},
    {"label": "Part-time", "value": "Part-time"},
    {"label": "Contract", "value": "Contract"},
    {"label": "Freelance", "value": "Freelance"},
    {"label": "Internship", "value": "Internship"},
  ];

  List<Map<String, dynamic>> experienceOptions = [
    {"label": "Entry Level", "value": "Entry Level"},
    {"label": "Mid-level", "value": "Mid-level"},
    {"label": "Senior Level", "value": "Senior Level"},
    {"label": "Executive", "value": "Executive"},
  ];

  List<Map<String, dynamic>> priorityOptions = [
    {"label": "Low", "value": "Low"},
    {"label": "Medium", "value": "Medium"},
    {"label": "High", "value": "High"},
    {"label": "Urgent", "value": "Urgent"},
  ];

  List<Map<String, dynamic>> currencyOptions = [
    {"label": "USD - US Dollar", "value": "USD"},
    {"label": "EUR - Euro", "value": "EUR"},
    {"label": "GBP - British Pound", "value": "GBP"},
    {"label": "CAD - Canadian Dollar", "value": "CAD"},
  ];

  bool isLoading = false;
  int currentStep = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create New Job"),
        actions: [
          QButton(
            label: "Save Draft",
            size: bs.sm,
            onPressed: () => _saveDraft(),
          ),
          SizedBox(width: spSm),
        ],
      ),
      body: isLoading
        ? Center(child: CircularProgressIndicator())
        : Form(
            key: formKey,
            child: SingleChildScrollView(
              padding: EdgeInsets.all(spMd),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spMd,
                children: [
                  _buildProgressIndicator(),
                  _buildStepContent(),
                  _buildNavigationButtons(),
                ],
              ),
            ),
          ),
    );
  }

  Widget _buildProgressIndicator() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        children: [
          Row(
            children: [
              _buildStepIndicator(0, "Basic Info"),
              Expanded(child: _buildProgressLine(0)),
              _buildStepIndicator(1, "Details"),
              Expanded(child: _buildProgressLine(1)),
              _buildStepIndicator(2, "Settings"),
            ],
          ),
          Text(
            _getStepTitle(),
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStepIndicator(int step, String label) {
    bool isActive = currentStep >= step;
    return Column(
      children: [
        Container(
          width: 30,
          height: 30,
          decoration: BoxDecoration(
            color: isActive ? primaryColor : disabledColor,
            shape: BoxShape.circle,
          ),
          child: Center(
            child: isActive
              ? Icon(Icons.check, color: Colors.white, size: 16)
              : Text(
                  "${step + 1}",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
          ),
        ),
        SizedBox(height: spXs),
        Text(
          label,
          style: TextStyle(
            fontSize: 10,
            color: isActive ? primaryColor : disabledBoldColor,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Widget _buildProgressLine(int step) {
    bool isCompleted = currentStep > step;
    return Container(
      height: 2,
      margin: EdgeInsets.symmetric(horizontal: spSm),
      color: isCompleted ? primaryColor : disabledColor,
    );
  }

  String _getStepTitle() {
    switch (currentStep) {
      case 0:
        return "Step 1: Basic Job Information";
      case 1:
        return "Step 2: Job Details & Requirements";
      case 2:
        return "Step 3: Settings & Preferences";
      default:
        return "";
    }
  }

  Widget _buildStepContent() {
    switch (currentStep) {
      case 0:
        return _buildBasicInfoStep();
      case 1:
        return _buildDetailsStep();
      case 2:
        return _buildSettingsStep();
      default:
        return Container();
    }
  }

  Widget _buildBasicInfoStep() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          QTextField(
            label: "Job Title",
            value: jobTitle,
            hint: "e.g. Senior Flutter Developer",
            validator: Validator.required,
            onChanged: (value) {
              jobTitle = value;
              setState(() {});
            },
          ),
          QTextField(
            label: "Department",
            value: department,
            hint: "e.g. Engineering, Marketing",
            validator: Validator.required,
            onChanged: (value) {
              department = value;
              setState(() {});
            },
          ),
          QTextField(
            label: "Location",
            value: location,
            hint: "e.g. San Francisco, CA or Remote",
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
                  items: jobTypeOptions,
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
          QSwitch(
            items: [
              {
                "label": "Remote Work Available",
                "value": true,
                "checked": isRemoteWork,
              }
            ],
            value: [
              if (isRemoteWork)
                {
                  "label": "Remote Work Available",
                  "value": true,
                  "checked": true
                }
            ],
            onChanged: (values, ids) {
              setState(() {
                isRemoteWork = values.isNotEmpty;
              });
            },
          ),
        ],
      ),
    );
  }

  Widget _buildDetailsStep() {
    return Column(
      spacing: spMd,
      children: [
        Container(
          padding: EdgeInsets.all(spMd),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(radiusMd),
            boxShadow: [shadowSm],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: spMd,
            children: [
              Text(
                "Salary Range",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              QDropdownField(
                label: "Currency",
                items: currencyOptions,
                value: currency,
                onChanged: (value, label) {
                  currency = value;
                  setState(() {});
                },
              ),
              Row(
                children: [
                  Expanded(
                    child: QNumberField(
                      label: "Minimum Salary",
                      value: salaryMin,
                      hint: "50000",
                      onChanged: (value) {
                        salaryMin = value;
                        setState(() {});
                      },
                    ),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: QNumberField(
                      label: "Maximum Salary",
                      value: salaryMax,
                      hint: "80000",
                      onChanged: (value) {
                        salaryMax = value;
                        setState(() {});
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.all(spMd),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(radiusMd),
            boxShadow: [shadowSm],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: spMd,
            children: [
              Text(
                "Job Content",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
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
                label: "Requirements",
                value: requirements,
                hint: "List the required skills, experience, and qualifications...",
                validator: Validator.required,
                onChanged: (value) {
                  requirements = value;
                  setState(() {});
                },
              ),
              QMemoField(
                label: "Benefits",
                value: benefits,
                hint: "List the benefits and perks offered...",
                onChanged: (value) {
                  benefits = value;
                  setState(() {});
                },
              ),
              QTextField(
                label: "Required Skills",
                value: skills,
                hint: "Flutter, Dart, Firebase (comma separated)",
                onChanged: (value) {
                  skills = value;
                  setState(() {});
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSettingsStep() {
    return Column(
      spacing: spMd,
      children: [
        Container(
          padding: EdgeInsets.all(spMd),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(radiusMd),
            boxShadow: [shadowSm],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: spMd,
            children: [
              Text(
                "Job Settings",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              QDatePicker(
                label: "Application Deadline",
                value: deadline.isNotEmpty ? DateTime.parse(deadline) : DateTime.now().add(Duration(days: 30)),
                onChanged: (value) {
                  deadline = value.toIso8601String();
                  setState(() {});
                },
              ),
              QDropdownField(
                label: "Priority Level",
                items: priorityOptions,
                value: priority,
                onChanged: (value, label) {
                  priority = value;
                  setState(() {});
                },
              ),
              QSwitch(
                items: [
                  {
                    "label": "Urgent Hiring",
                    "value": true,
                    "checked": isUrgentHiring,
                  }
                ],
                value: [
                  if (isUrgentHiring)
                    {
                      "label": "Urgent Hiring",
                      "value": true,
                      "checked": true
                    }
                ],
                onChanged: (values, ids) {
                  setState(() {
                    isUrgentHiring = values.isNotEmpty;
                  });
                },
              ),
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.all(spMd),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(radiusMd),
            boxShadow: [shadowSm],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: spMd,
            children: [
              Text(
                "Automation & Notifications",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              QSwitch(
                items: [
                  {
                    "label": "Auto-screening enabled",
                    "value": true,
                    "checked": autoScreening,
                  }
                ],
                value: [
                  if (autoScreening)
                    {
                      "label": "Auto-screening enabled",
                      "value": true,
                      "checked": true
                    }
                ],
                onChanged: (values, ids) {
                  setState(() {
                    autoScreening = values.isNotEmpty;
                  });
                },
              ),
              QSwitch(
                items: [
                  {
                    "label": "Email notifications",
                    "value": true,
                    "checked": emailNotifications,
                  }
                ],
                value: [
                  if (emailNotifications)
                    {
                      "label": "Email notifications",
                      "value": true,
                      "checked": true
                    }
                ],
                onChanged: (values, ids) {
                  setState(() {
                    emailNotifications = values.isNotEmpty;
                  });
                },
              ),
              QSwitch(
                items: [
                  {
                    "label": "Public job listing",
                    "value": true,
                    "checked": publicListing,
                  }
                ],
                value: [
                  if (publicListing)
                    {
                      "label": "Public job listing",
                      "value": true,
                      "checked": true
                    }
                ],
                onChanged: (values, ids) {
                  setState(() {
                    publicListing = values.isNotEmpty;
                  });
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildNavigationButtons() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Row(
        children: [
          if (currentStep > 0)
            Expanded(
              child: QButton(
                label: "Previous",
                size: bs.md,
                icon: Icons.arrow_back,
                onPressed: () {
                  currentStep--;
                  setState(() {});
                },
              ),
            ),
          if (currentStep > 0) SizedBox(width: spSm),
          Expanded(
            child: QButton(
              label: currentStep < 2 ? "Next" : "Create Job",
              size: bs.md,
              icon: currentStep < 2 ? Icons.arrow_forward : Icons.check,
              onPressed: () => _handleNextStep(),
            ),
          ),
        ],
      ),
    );
  }

  void _handleNextStep() {
    if (currentStep < 2) {
      if (_validateCurrentStep()) {
        currentStep++;
        setState(() {});
      }
    } else {
      _createJob();
    }
  }

  bool _validateCurrentStep() {
    switch (currentStep) {
      case 0:
        if (jobTitle.isEmpty || department.isEmpty || location.isEmpty) {
          se("Please fill all required fields");
          return false;
        }
        break;
      case 1:
        if (jobDescription.isEmpty || requirements.isEmpty) {
          se("Please fill job description and requirements");
          return false;
        }
        break;
    }
    return true;
  }

  void _createJob() async {
    if (!formKey.currentState!.validate()) {
      return;
    }

    bool isConfirmed = await confirm("Are you sure you want to create this job posting?");
    if (!isConfirmed) return;

    isLoading = true;
    setState(() {});

    // Simulate API call
    await Future.delayed(Duration(seconds: 2));

    isLoading = false;
    setState(() {});

    ss("Job created successfully!");
    back();
  }

  void _saveDraft() async {
    isLoading = true;
    setState(() {});

    // Simulate API call
    await Future.delayed(Duration(seconds: 1));

    isLoading = false;
    setState(() {});

    ss("Draft saved successfully!");
  }
}
