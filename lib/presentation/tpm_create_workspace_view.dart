import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class TpmCreateWorkspaceView extends StatefulWidget {
  const TpmCreateWorkspaceView({super.key});

  @override
  State<TpmCreateWorkspaceView> createState() => _TpmCreateWorkspaceViewState();
}

class _TpmCreateWorkspaceViewState extends State<TpmCreateWorkspaceView> {
  final formKey = GlobalKey<FormState>();
  int currentStep = 0;
  bool loading = false;

  // Basic Information
  String workspaceName = "";
  String description = "";
  String category = "";
  String priority = "";

  // Project Details
  String startDate = "";
  String endDate = "";
  double budget = 0.0;
  String budgetCurrency = "USD";

  // Team Settings
  bool isPublic = false;
  bool allowGuestAccess = false;
  bool enableNotifications = true;
  List<String> inviteEmails = [];
  String newEmail = "";

  // Template Selection
  String selectedTemplate = "";

  List<Map<String, dynamic>> categoryOptions = [
    {"label": "Development", "value": "Development"},
    {"label": "Marketing", "value": "Marketing"},
    {"label": "Design", "value": "Design"},
    {"label": "Research", "value": "Research"},
    {"label": "Operations", "value": "Operations"},
    {"label": "Sales", "value": "Sales"},
    {"label": "HR", "value": "HR"},
    {"label": "Other", "value": "Other"},
  ];

  List<Map<String, dynamic>> priorityOptions = [
    {"label": "Low", "value": "Low"},
    {"label": "Medium", "value": "Medium"},
    {"label": "High", "value": "High"},
    {"label": "Critical", "value": "Critical"},
  ];

  List<Map<String, dynamic>> currencyOptions = [
    {"label": "USD (\$)", "value": "USD"},
    {"label": "EUR (€)", "value": "EUR"},
    {"label": "GBP (£)", "value": "GBP"},
    {"label": "JPY (¥)", "value": "JPY"},
  ];

  List<Map<String, dynamic>> templates = [
    {
      "id": "custom",
      "name": "Start from Scratch",
      "description": "Create a custom workspace with your own settings",
      "icon": Icons.add_circle,
      "color": primaryColor,
      "tasks": 0,
    },
    {
      "id": "software",
      "name": "Software Development",
      "description": "Pre-configured for software development projects",
      "icon": Icons.code,
      "color": infoColor,
      "tasks": 15,
    },
    {
      "id": "marketing",
      "name": "Marketing Campaign",
      "description": "Template for marketing projects and campaigns",
      "icon": Icons.campaign,
      "color": successColor,
      "tasks": 12,
    },
    {
      "id": "design",
      "name": "Design Project",
      "description": "Perfect for UI/UX and graphic design projects",
      "icon": Icons.design_services,
      "color": warningColor,
      "tasks": 10,
    },
    {
      "id": "research",
      "name": "Research & Analysis",
      "description": "Structured template for research projects",
      "icon": Icons.science,
      "color": Colors.purple,
      "tasks": 8,
    },
    {
      "id": "event",
      "name": "Event Planning",
      "description": "Organize events and manage timelines",
      "icon": Icons.event,
      "color": Colors.orange,
      "tasks": 18,
    },
  ];

  void _nextStep() {
    if (currentStep == 0) {
      if (!formKey.currentState!.validate()) return;
      if (workspaceName.isEmpty || category.isEmpty || priority.isEmpty) {
        se("Please fill in all required fields");
        return;
      }
    }
    
    if (currentStep == 1) {
      if (startDate.isEmpty || endDate.isEmpty) {
        se("Please select start and end dates");
        return;
      }
    }

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

  void _addEmail() {
    if (newEmail.isNotEmpty && !inviteEmails.contains(newEmail)) {
      inviteEmails.add(newEmail);
      newEmail = "";
      setState(() {});
    }
  }

  void _removeEmail(String email) {
    inviteEmails.remove(email);
    setState(() {});
  }

  Future<void> _createWorkspace() async {
    if (currentStep == 2 && selectedTemplate.isEmpty) {
      se("Please select a template");
      return;
    }

    loading = true;
    setState(() {});

    // Simulate API call
    await Future.delayed(Duration(seconds: 2));

    loading = false;
    setState(() {});

    ss("Workspace created successfully!");
    // Navigate to workspace or dashboard
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create Workspace"),
        leading: currentStep > 0 
          ? IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: _previousStep,
            )
          : null,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          children: [
            // Progress Indicator
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusSm),
                boxShadow: [shadowSm],
              ),
              child: Column(
                spacing: spSm,
                children: [
                  Row(
                    children: List.generate(4, (index) {
                      bool isActive = index <= currentStep;
                      bool isCurrent = index == currentStep;
                      
                      return Expanded(
                        child: Container(
                          margin: EdgeInsets.symmetric(horizontal: 2),
                          child: Column(
                            children: [
                              Container(
                                width: 28,
                                height: 28,
                                decoration: BoxDecoration(
                                  color: isActive ? primaryColor : disabledColor,
                                  borderRadius: BorderRadius.circular(radiusLg),
                                  border: isCurrent 
                                    ? Border.all(color: primaryColor, width: 2)
                                    : null,
                                ),
                                child: Center(
                                  child: Text(
                                    "${index + 1}",
                                    style: TextStyle(
                                      color: isActive ? Colors.white : disabledBoldColor,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: spXs),
                              Text(
                                ["Basic", "Details", "Template", "Team"][index],
                                style: TextStyle(
                                  fontSize: 10,
                                  color: isActive ? primaryColor : disabledBoldColor,
                                  fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
                  ),
                  SizedBox(height: spSm),
                  LinearProgressIndicator(
                    value: (currentStep + 1) / 4,
                    backgroundColor: disabledColor,
                    valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
                  ),
                ],
              ),
            ),

            SizedBox(height: spMd),

            // Form Steps
            Form(
              key: formKey,
              child: _buildCurrentStep(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCurrentStep() {
    switch (currentStep) {
      case 0:
        return _buildBasicInfoStep();
      case 1:
        return _buildProjectDetailsStep();
      case 2:
        return _buildTemplateStep();
      case 3:
        return _buildTeamSettingsStep();
      default:
        return Container();
    }
  }

  Widget _buildBasicInfoStep() {
    return Column(
      spacing: spMd,
      children: [
        // Header
        Container(
          padding: EdgeInsets.all(spMd),
          decoration: BoxDecoration(
            color: primaryColor.withAlpha(20),
            borderRadius: BorderRadius.circular(radiusSm),
          ),
          child: Column(
            children: [
              Icon(Icons.work, color: primaryColor, size: 48),
              SizedBox(height: spSm),
              Text(
                "Basic Information",
                style: TextStyle(
                  fontSize: fsH4,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Text(
                "Let's start with the basic details of your workspace",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
        ),

        // Form Fields
        QTextField(
          label: "Workspace Name *",
          value: workspaceName,
          hint: "Enter workspace name",
          validator: Validator.required,
          onChanged: (value) {
            workspaceName = value;
            setState(() {});
          },
        ),

        QMemoField(
          label: "Description",
          value: description,
          hint: "Describe your workspace and its objectives",
          onChanged: (value) {
            description = value;
            setState(() {});
          },
        ),

        Row(
          children: [
            Expanded(
              child: QDropdownField(
                label: "Category *",
                items: categoryOptions,
                value: category,
                onChanged: (value, label) {
                  category = value;
                  setState(() {});
                },
              ),
            ),
            SizedBox(width: spSm),
            Expanded(
              child: QDropdownField(
                label: "Priority *",
                items: priorityOptions,
                value: priority,
                onChanged: (value, label) {
                  priority = value;
                  setState(() {});
                },
              ),
            ),
          ],
        ),

        // Workspace Settings Preview
        Container(
          padding: EdgeInsets.all(spSm),
          decoration: BoxDecoration(
            color: infoColor.withAlpha(20),
            borderRadius: BorderRadius.circular(radiusSm),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: spXs,
            children: [
              Row(
                children: [
                  Icon(Icons.info, color: infoColor, size: 16),
                  SizedBox(width: spSm),
                  Text(
                    "Workspace Preview",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: infoColor,
                    ),
                  ),
                ],
              ),
              if (workspaceName.isNotEmpty) ...[
                Text(
                  "Name: $workspaceName",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ],
              if (category.isNotEmpty) ...[
                Text(
                  "Category: $category",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ],
              if (priority.isNotEmpty) ...[
                Text(
                  "Priority: $priority",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ],
          ),
        ),

        Container(
          width: double.infinity,
          child: QButton(
            label: "Continue",
            size: bs.md,
            onPressed: _nextStep,
          ),
        ),
      ],
    );
  }

  Widget _buildProjectDetailsStep() {
    return Column(
      spacing: spMd,
      children: [
        // Header
        Container(
          padding: EdgeInsets.all(spMd),
          decoration: BoxDecoration(
            color: successColor.withAlpha(20),
            borderRadius: BorderRadius.circular(radiusSm),
          ),
          child: Column(
            children: [
              Icon(Icons.schedule, color: successColor, size: 48),
              SizedBox(height: spSm),
              Text(
                "Project Timeline & Budget",
                style: TextStyle(
                  fontSize: fsH4,
                  fontWeight: FontWeight.bold,
                  color: successColor,
                ),
              ),
              Text(
                "Set your project timeline and budget details",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
        ),

        // Date Fields
        Row(
          children: [
            Expanded(
              child: QDatePicker(
                label: "Start Date *",
                value: startDate.isNotEmpty ? DateTime.parse(startDate) : DateTime.now(),
                onChanged: (value) {
                  startDate = value.toString().split(' ')[0];
                  setState(() {});
                },
              ),
            ),
            SizedBox(width: spSm),
            Expanded(
              child: QDatePicker(
                label: "End Date *",
                value: endDate.isNotEmpty ? DateTime.parse(endDate) : DateTime.now().add(Duration(days: 30)),
                onChanged: (value) {
                  endDate = value.toString().split(' ')[0];
                  setState(() {});
                },
              ),
            ),
          ],
        ),

        // Budget Fields
        Row(
          children: [
            Expanded(
              flex: 2,
              child: QNumberField(
                label: "Budget",
                value: budget.toString(),
                onChanged: (value) {
                  budget = double.tryParse(value) ?? 0.0;
                  setState(() {});
                },
              ),
            ),
            SizedBox(width: spSm),
            Expanded(
              child: QDropdownField(
                label: "Currency",
                items: currencyOptions,
                value: budgetCurrency,
                onChanged: (value, label) {
                  budgetCurrency = value;
                  setState(() {});
                },
              ),
            ),
          ],
        ),

        // Duration Calculation
        if (startDate.isNotEmpty && endDate.isNotEmpty) ...[
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Row(
              children: [
                Icon(Icons.calculate, color: primaryColor, size: 20),
                SizedBox(width: spSm),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Project Duration",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "${DateTime.parse(endDate).difference(DateTime.parse(startDate)).inDays} days",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ),
                if (budget > 0) ...[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        "Total Budget",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "${budgetCurrency == "USD" ? "\$" : budgetCurrency == "EUR" ? "€" : budgetCurrency == "GBP" ? "£" : "¥"}${budget.toStringAsFixed(0)}",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ],
            ),
          ),
        ],

        Container(
          width: double.infinity,
          child: QButton(
            label: "Continue",
            size: bs.md,
            onPressed: _nextStep,
          ),
        ),
      ],
    );
  }

  Widget _buildTemplateStep() {
    return Column(
      spacing: spMd,
      children: [
        // Header
        Container(
          padding: EdgeInsets.all(spMd),
          decoration: BoxDecoration(
            color: warningColor.withAlpha(20),
            borderRadius: BorderRadius.circular(radiusSm),
          ),
          child: Column(
            children: [
              Icon(Icons.description, color: warningColor, size: 48),
              SizedBox(height: spSm),
              Text(
                "Choose Template",
                style: TextStyle(
                  fontSize: fsH4,
                  fontWeight: FontWeight.bold,
                  color: warningColor,
                ),
              ),
              Text(
                "Select a template to get started quickly",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
        ),

        // Templates Grid
        ResponsiveGridView(
          padding: EdgeInsets.zero,
          minItemWidth: 200,
          children: templates.map((template) {
            bool isSelected = selectedTemplate == template["id"];
            
            return GestureDetector(
              onTap: () {
                selectedTemplate = template["id"];
                setState(() {});
              },
              child: Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusSm),
                  boxShadow: [shadowSm],
                  border: isSelected 
                    ? Border.all(color: primaryColor, width: 2)
                    : Border.all(color: disabledOutlineBorderColor),
                ),
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.all(spMd),
                      decoration: BoxDecoration(
                        color: (template["color"] as Color).withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Icon(
                        template["icon"] as IconData,
                        color: template["color"] as Color,
                        size: 32,
                      ),
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "${template["name"]}",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: isSelected ? primaryColor : disabledBoldColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "${template["description"]}",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                        height: 1.4,
                      ),
                    ),
                    if (template["tasks"] > 0) ...[
                      SizedBox(height: spXs),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                        decoration: BoxDecoration(
                          color: (template["color"] as Color).withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Text(
                          "${template["tasks"]} tasks included",
                          style: TextStyle(
                            fontSize: 10,
                            color: template["color"] as Color,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                    if (isSelected) ...[
                      SizedBox(height: spSm),
                      Icon(
                        Icons.check_circle,
                        color: primaryColor,
                        size: 24,
                      ),
                    ],
                  ],
                ),
              ),
            );
          }).toList(),
        ),

        if (selectedTemplate.isNotEmpty) ...[
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: successColor.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Row(
              children: [
                Icon(Icons.check_circle, color: successColor, size: 20),
                SizedBox(width: spSm),
                Expanded(
                  child: Text(
                    "Template selected: ${templates.firstWhere((t) => t["id"] == selectedTemplate)["name"]}",
                    style: TextStyle(
                      fontSize: 14,
                      color: successColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],

        Container(
          width: double.infinity,
          child: QButton(
            label: "Continue",
            size: bs.md,
            onPressed: _nextStep,
          ),
        ),
      ],
    );
  }

  Widget _buildTeamSettingsStep() {
    return Column(
      spacing: spMd,
      children: [
        // Header
        Container(
          padding: EdgeInsets.all(spMd),
          decoration: BoxDecoration(
            color: infoColor.withAlpha(20),
            borderRadius: BorderRadius.circular(radiusSm),
          ),
          child: Column(
            children: [
              Icon(Icons.group, color: infoColor, size: 48),
              SizedBox(height: spSm),
              Text(
                "Team & Privacy Settings",
                style: TextStyle(
                  fontSize: fsH4,
                  fontWeight: FontWeight.bold,
                  color: infoColor,
                ),
              ),
              Text(
                "Configure team access and invite members",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
        ),

        // Privacy Settings
        Container(
          padding: EdgeInsets.all(spMd),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(radiusSm),
            boxShadow: [shadowSm],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: spMd,
            children: [
              Text(
                "Privacy & Access",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              
              QSwitch(
                items: [
                  {
                    "label": "Make workspace public",
                    "value": true,
                    "checked": isPublic,
                  }
                ],
                value: [
                  if (isPublic)
                    {
                      "label": "Make workspace public",
                      "value": true,
                      "checked": true
                    }
                ],
                onChanged: (values, ids) {
                  isPublic = values.isNotEmpty;
                  setState(() {});
                },
              ),

              QSwitch(
                items: [
                  {
                    "label": "Allow guest access",
                    "value": true,
                    "checked": allowGuestAccess,
                  }
                ],
                value: [
                  if (allowGuestAccess)
                    {
                      "label": "Allow guest access",
                      "value": true,
                      "checked": true
                    }
                ],
                onChanged: (values, ids) {
                  allowGuestAccess = values.isNotEmpty;
                  setState(() {});
                },
              ),

              QSwitch(
                items: [
                  {
                    "label": "Enable notifications",
                    "value": true,
                    "checked": enableNotifications,
                  }
                ],
                value: [
                  if (enableNotifications)
                    {
                      "label": "Enable notifications",
                      "value": true,
                      "checked": true
                    }
                ],
                onChanged: (values, ids) {
                  enableNotifications = values.isNotEmpty;
                  setState(() {});
                },
              ),
            ],
          ),
        ),

        // Team Invitations
        Container(
          padding: EdgeInsets.all(spMd),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(radiusSm),
            boxShadow: [shadowSm],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: spMd,
            children: [
              Text(
                "Invite Team Members",
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
                      label: "Email Address",
                      value: newEmail,
                      hint: "Enter email to invite",
                      onChanged: (value) {
                        newEmail = value;
                        setState(() {});
                      },
                    ),
                  ),
                  SizedBox(width: spSm),
                  QButton(
                    label: "Add",
                    size: bs.sm,
                    onPressed: _addEmail,
                  ),
                ],
              ),

              if (inviteEmails.isNotEmpty) ...[
                Text(
                  "Invited Members (${inviteEmails.length})",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: disabledBoldColor,
                  ),
                ),
                Column(
                  spacing: spXs,
                  children: inviteEmails.map((email) {
                    return Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: primaryColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.email, color: primaryColor, size: 16),
                          SizedBox(width: spSm),
                          Expanded(
                            child: Text(
                              email,
                              style: TextStyle(
                                fontSize: 14,
                                color: primaryColor,
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () => _removeEmail(email),
                            child: Icon(Icons.close, color: dangerColor, size: 16),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ],
            ],
          ),
        ),

        // Create Button
        if (loading) ...[
          Container(
            height: 48,
            child: Center(
              child: CircularProgressIndicator(),
            ),
          ),
        ] else ...[
          Container(
            width: double.infinity,
            child: QButton(
              label: "Create Workspace",
              size: bs.md,
              onPressed: _createWorkspace,
            ),
          ),
        ],

        // Summary
        Container(
          padding: EdgeInsets.all(spSm),
          decoration: BoxDecoration(
            color: disabledColor.withAlpha(50),
            borderRadius: BorderRadius.circular(radiusSm),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: spXs,
            children: [
              Text(
                "Workspace Summary",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: primaryColor,
                ),
              ),
              if (workspaceName.isNotEmpty) ...[
                Text("• Name: $workspaceName", style: TextStyle(fontSize: 12, color: disabledBoldColor)),
              ],
              if (category.isNotEmpty) ...[
                Text("• Category: $category", style: TextStyle(fontSize: 12, color: disabledBoldColor)),
              ],
              if (selectedTemplate.isNotEmpty) ...[
                Text("• Template: ${templates.firstWhere((t) => t["id"] == selectedTemplate)["name"]}", style: TextStyle(fontSize: 12, color: disabledBoldColor)),
              ],
              if (inviteEmails.isNotEmpty) ...[
                Text("• Team members: ${inviteEmails.length} invited", style: TextStyle(fontSize: 12, color: disabledBoldColor)),
              ],
            ],
          ),
        ),
      ],
    );
  }
}
