import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class PmaAddMemberView extends StatefulWidget {
  const PmaAddMemberView({super.key});

  @override
  State<PmaAddMemberView> createState() => _PmaAddMemberViewState();
}

class _PmaAddMemberViewState extends State<PmaAddMemberView> {
  final formKey = GlobalKey<FormState>();
  
  // Basic Information
  String firstName = "";
  String lastName = "";
  String email = "";
  String phone = "";
  String dateOfBirth = "";
  String gender = "";
  String address = "";
  String city = "";
  String country = "";
  String profileImage = "";
  
  // Employment Information
  String employeeId = "";
  String department = "";
  String team = "";
  String role = "";
  String reportingManager = "";
  String startDate = "";
  String employmentType = "";
  String workLocation = "";
  String salary = "";
  
  // Account Information
  String username = "";
  String password = "";
  String confirmPassword = "";
  List<String> permissions = [];
  bool isActive = true;
  bool sendWelcomeEmail = true;
  
  // Skills and Experience
  List<String> skills = [];
  String experience = "";
  String previousCompany = "";
  String education = "";
  String certifications = "";
  
  List<Map<String, dynamic>> genderOptions = [
    {"label": "Male", "value": "male"},
    {"label": "Female", "value": "female"},
    {"label": "Other", "value": "other"},
  ];

  List<Map<String, dynamic>> departmentOptions = [
    {"label": "Engineering", "value": "engineering"},
    {"label": "Design", "value": "design"},
    {"label": "Marketing", "value": "marketing"},
    {"label": "Sales", "value": "sales"},
    {"label": "HR", "value": "hr"},
    {"label": "Finance", "value": "finance"},
  ];

  List<Map<String, dynamic>> teamOptions = [
    {"label": "Frontend Development", "value": "frontend"},
    {"label": "Backend Development", "value": "backend"},
    {"label": "UI/UX Design", "value": "design"},
    {"label": "Quality Assurance", "value": "qa"},
    {"label": "DevOps", "value": "devops"},
    {"label": "Digital Marketing", "value": "digital_marketing"},
  ];

  List<Map<String, dynamic>> roleOptions = [
    {"label": "Team Lead", "value": "lead"},
    {"label": "Senior Developer", "value": "senior"},
    {"label": "Developer", "value": "developer"},
    {"label": "Junior Developer", "value": "junior"},
    {"label": "Designer", "value": "designer"},
    {"label": "QA Engineer", "value": "qa"},
  ];

  List<Map<String, dynamic>> employmentTypeOptions = [
    {"label": "Full-time", "value": "fulltime"},
    {"label": "Part-time", "value": "parttime"},
    {"label": "Contract", "value": "contract"},
    {"label": "Intern", "value": "intern"},
  ];

  List<Map<String, dynamic>> workLocationOptions = [
    {"label": "Office", "value": "office"},
    {"label": "Remote", "value": "remote"},
    {"label": "Hybrid", "value": "hybrid"},
  ];

  List<Map<String, dynamic>> permissionOptions = [
    {"label": "View Projects", "value": "view_projects"},
    {"label": "Edit Projects", "value": "edit_projects"},
    {"label": "Delete Projects", "value": "delete_projects"},
    {"label": "Manage Team", "value": "manage_team"},
    {"label": "View Reports", "value": "view_reports"},
    {"label": "Admin Access", "value": "admin_access"},
  ];

  int currentStep = 0;
  List<String> stepTitles = [
    "Personal Info",
    "Employment",
    "Account Setup",
    "Skills & Review"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add New Member"),
        actions: [
          QButton(
            icon: Icons.help,
            size: bs.sm,
            onPressed: () {},
          ),
        ],
      ),
      body: Form(
        key: formKey,
        child: Column(
          children: [
            // Step Progress
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [shadowSm],
              ),
              child: Row(
                children: stepTitles.asMap().entries.map((entry) {
                  int index = entry.key;
                  String title = entry.value;
                  bool isActive = index == currentStep;
                  bool isCompleted = index < currentStep;
                  
                  return Expanded(
                    child: Column(
                      children: [
                        Row(
                          children: [
                            if (index > 0) 
                              Expanded(
                                child: Container(
                                  height: 2,
                                  color: isCompleted ? primaryColor : disabledColor,
                                ),
                              ),
                            Container(
                              width: 30,
                              height: 30,
                              decoration: BoxDecoration(
                                color: isCompleted 
                                    ? primaryColor 
                                    : isActive 
                                        ? primaryColor 
                                        : disabledColor,
                                shape: BoxShape.circle,
                              ),
                              child: Center(
                                child: Text(
                                  "${index + 1}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                            if (index < stepTitles.length - 1)
                              Expanded(
                                child: Container(
                                  height: 2,
                                  color: isCompleted ? primaryColor : disabledColor,
                                ),
                              ),
                          ],
                        ),
                        SizedBox(height: spSm),
                        Text(
                          title,
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
                            color: isActive ? primaryColor : disabledBoldColor,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),

            // Step Content
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(spMd),
                child: _buildStepContent(),
              ),
            ),

            // Navigation Buttons
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [shadowSm],
              ),
              child: Row(
                children: [
                  if (currentStep > 0)
                    Expanded(
                      child: QButton(
                        label: "Previous",
                        size: bs.md,
                        onPressed: () {
                          currentStep--;
                          setState(() {});
                        },
                      ),
                    ),
                  if (currentStep > 0) SizedBox(width: spMd),
                  Expanded(
                    child: QButton(
                      label: currentStep == stepTitles.length - 1 ? "Create Member" : "Next",
                      size: bs.md,
                      onPressed: () {
                        if (currentStep == stepTitles.length - 1) {
                          _createMember();
                        } else {
                          if (_validateCurrentStep()) {
                            currentStep++;
                            setState(() {});
                          }
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStepContent() {
    switch (currentStep) {
      case 0:
        return _buildPersonalInfoStep();
      case 1:
        return _buildEmploymentStep();
      case 2:
        return _buildAccountSetupStep();
      case 3:
        return _buildSkillsReviewStep();
      default:
        return Container();
    }
  }

  Widget _buildPersonalInfoStep() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Personal Information",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        SizedBox(height: spMd),

        // Profile Image
        QImagePicker(
          label: "Profile Photo",
          value: profileImage,
          hint: "Upload profile picture",
          onChanged: (value) {
            profileImage = value;
            setState(() {});
          },
        ),

        SizedBox(height: spMd),

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
            SizedBox(width: spMd),
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

        SizedBox(height: spMd),

        // Contact Information
        QTextField(
          label: "Email Address",
          value: email,
          validator: Validator.email,
          onChanged: (value) {
            email = value;
            setState(() {});
          },
        ),

        SizedBox(height: spMd),

        QTextField(
          label: "Phone Number",
          value: phone,
          validator: Validator.required,
          onChanged: (value) {
            phone = value;
            setState(() {});
          },
        ),

        SizedBox(height: spMd),

        // Date of Birth & Gender
        Row(
          children: [
            Expanded(
              child: QDatePicker(
                label: "Date of Birth",
                value: dateOfBirth.isNotEmpty ? DateTime.parse(dateOfBirth) : null,
                onChanged: (value) {
                  dateOfBirth = value.toString();
                  setState(() {});
                },
              ),
            ),
            SizedBox(width: spMd),
            Expanded(
              child: QDropdownField(
                label: "Gender",
                items: genderOptions,
                value: gender,
                onChanged: (value, label) {
                  gender = value;
                  setState(() {});
                },
              ),
            ),
          ],
        ),

        SizedBox(height: spMd),

        // Address Information
        QTextField(
          label: "Address",
          value: address,
          onChanged: (value) {
            address = value;
            setState(() {});
          },
        ),

        SizedBox(height: spMd),

        Row(
          children: [
            Expanded(
              child: QTextField(
                label: "City",
                value: city,
                onChanged: (value) {
                  city = value;
                  setState(() {});
                },
              ),
            ),
            SizedBox(width: spMd),
            Expanded(
              child: QTextField(
                label: "Country",
                value: country,
                onChanged: (value) {
                  country = value;
                  setState(() {});
                },
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildEmploymentStep() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Employment Information",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        SizedBox(height: spMd),

        // Employee ID
        QTextField(
          label: "Employee ID",
          value: employeeId,
          validator: Validator.required,
          onChanged: (value) {
            employeeId = value;
            setState(() {});
          },
        ),

        SizedBox(height: spMd),

        // Department & Team
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
            SizedBox(width: spMd),
            Expanded(
              child: QDropdownField(
                label: "Team",
                items: teamOptions,
                value: team,
                onChanged: (value, label) {
                  team = value;
                  setState(() {});
                },
              ),
            ),
          ],
        ),

        SizedBox(height: spMd),

        // Role & Reporting Manager
        Row(
          children: [
            Expanded(
              child: QDropdownField(
                label: "Role",
                items: roleOptions,
                value: role,
                onChanged: (value, label) {
                  role = value;
                  setState(() {});
                },
              ),
            ),
            SizedBox(width: spMd),
            Expanded(
              child: QTextField(
                label: "Reporting Manager",
                value: reportingManager,
                onChanged: (value) {
                  reportingManager = value;
                  setState(() {});
                },
              ),
            ),
          ],
        ),

        SizedBox(height: spMd),

        // Start Date & Employment Type
        Row(
          children: [
            Expanded(
              child: QDatePicker(
                label: "Start Date",
                value: startDate.isNotEmpty ? DateTime.parse(startDate) : null,
                onChanged: (value) {
                  startDate = value.toString();
                  setState(() {});
                },
              ),
            ),
            SizedBox(width: spMd),
            Expanded(
              child: QDropdownField(
                label: "Employment Type",
                items: employmentTypeOptions,
                value: employmentType,
                onChanged: (value, label) {
                  employmentType = value;
                  setState(() {});
                },
              ),
            ),
          ],
        ),

        SizedBox(height: spMd),

        // Work Location & Salary
        Row(
          children: [
            Expanded(
              child: QDropdownField(
                label: "Work Location",
                items: workLocationOptions,
                value: workLocation,
                onChanged: (value, label) {
                  workLocation = value;
                  setState(() {});
                },
              ),
            ),
            SizedBox(width: spMd),
            Expanded(
              child: QNumberField(
                label: "Annual Salary (\$)",
                value: salary,
                onChanged: (value) {
                  salary = value;
                  setState(() {});
                },
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildAccountSetupStep() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Account Setup",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        SizedBox(height: spMd),

        // Login Credentials
        QTextField(
          label: "Username",
          value: username,
          validator: Validator.required,
          onChanged: (value) {
            username = value;
            setState(() {});
          },
        ),

        SizedBox(height: spMd),

        QTextField(
          label: "Password",
          value: password,
          obscureText: true,
          validator: Validator.required,
          onChanged: (value) {
            password = value;
            setState(() {});
          },
        ),

        SizedBox(height: spMd),

        QTextField(
          label: "Confirm Password",
          value: confirmPassword,
          obscureText: true,
          validator: Validator.required,
          onChanged: (value) {
            confirmPassword = value;
            setState(() {});
          },
        ),

        SizedBox(height: spMd),

        // Permissions
        Text(
          "Permissions",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        SizedBox(height: spSm),

        QSwitch(
          items: permissionOptions.map((permission) {
            return {
              "label": permission["label"],
              "value": permission["value"],
              "checked": permissions.contains(permission["value"]),
            };
          }).toList(),
          value: permissions.map((permission) {
            return {
              "label": permissionOptions.firstWhere((p) => p["value"] == permission)["label"],
              "value": permission,
              "checked": true,
            };
          }).toList(),
          onChanged: (values, ids) {
            permissions = values.map((v) => v["value"].toString()).toList();
            setState(() {});
          },
        ),

        SizedBox(height: spMd),

        // Account Status
        QSwitch(
          items: [
            {
              "label": "Account Active",
              "value": "active",
              "checked": isActive,
            }
          ],
          value: [
            if (isActive) {
              "label": "Account Active",
              "value": "active",
              "checked": true,
            }
          ],
          onChanged: (values, ids) {
            isActive = values.isNotEmpty;
            setState(() {});
          },
        ),

        SizedBox(height: spMd),

        // Welcome Email
        QSwitch(
          items: [
            {
              "label": "Send Welcome Email",
              "value": "welcome",
              "checked": sendWelcomeEmail,
            }
          ],
          value: [
            if (sendWelcomeEmail) {
              "label": "Send Welcome Email",
              "value": "welcome",
              "checked": true,
            }
          ],
          onChanged: (values, ids) {
            sendWelcomeEmail = values.isNotEmpty;
            setState(() {});
          },
        ),
      ],
    );
  }

  Widget _buildSkillsReviewStep() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Skills & Experience",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        SizedBox(height: spMd),

        // Skills (as text input for simplicity)
        QTextField(
          label: "Skills (comma separated)",
          value: skills.join(", "),
          hint: "e.g., React, Flutter, JavaScript",
          onChanged: (value) {
            skills = value.split(",").map((s) => s.trim()).where((s) => s.isNotEmpty).toList();
            setState(() {});
          },
        ),

        SizedBox(height: spMd),

        // Experience
        QTextField(
          label: "Years of Experience",
          value: experience,
          onChanged: (value) {
            experience = value;
            setState(() {});
          },
        ),

        SizedBox(height: spMd),

        // Previous Company
        QTextField(
          label: "Previous Company",
          value: previousCompany,
          onChanged: (value) {
            previousCompany = value;
            setState(() {});
          },
        ),

        SizedBox(height: spMd),

        // Education
        QTextField(
          label: "Education",
          value: education,
          onChanged: (value) {
            education = value;
            setState(() {});
          },
        ),

        SizedBox(height: spMd),

        // Certifications
        QTextField(
          label: "Certifications",
          value: certifications,
          onChanged: (value) {
            certifications = value;
            setState(() {});
          },
        ),

        SizedBox(height: spMd),

        // Review Summary
        Text(
          "Review Information",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        SizedBox(height: spMd),

        Container(
          width: double.infinity,
          padding: EdgeInsets.all(spMd),
          decoration: BoxDecoration(
            color: primaryColor.withAlpha(10),
            borderRadius: BorderRadius.circular(radiusMd),
            border: Border.all(color: primaryColor.withAlpha(30)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildReviewRow("Name", "$firstName $lastName"),
              _buildReviewRow("Email", email),
              _buildReviewRow("Employee ID", employeeId),
              _buildReviewRow("Department", department),
              _buildReviewRow("Team", team),
              _buildReviewRow("Role", role),
              _buildReviewRow("Employment Type", employmentType),
              _buildReviewRow("Username", username),
              _buildReviewRow("Active", isActive ? "Yes" : "No"),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildReviewRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: spXs),
      child: Row(
        children: [
          Text(
            "$label:",
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: primaryColor,
            ),
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Text(
              value.isEmpty ? "Not specified" : value,
              style: TextStyle(
                color: value.isEmpty ? disabledBoldColor : primaryColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  bool _validateCurrentStep() {
    switch (currentStep) {
      case 0:
        return firstName.isNotEmpty && lastName.isNotEmpty && email.isNotEmpty;
      case 1:
        return employeeId.isNotEmpty && department.isNotEmpty && role.isNotEmpty;
      case 2:
        return username.isNotEmpty && password.isNotEmpty && password == confirmPassword;
      case 3:
        return true;
      default:
        return false;
    }
  }

  void _createMember() {
    if (formKey.currentState!.validate()) {
      // Create member logic here
      ss("Member created successfully!");
      back();
    }
  }
}
