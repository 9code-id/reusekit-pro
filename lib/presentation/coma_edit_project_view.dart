import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class ComaEditProjectView extends StatefulWidget {
  const ComaEditProjectView({Key? key}) : super(key: key);

  @override
  State<ComaEditProjectView> createState() => _ComaEditProjectViewState();
}

class _ComaEditProjectViewState extends State<ComaEditProjectView> {
  final formKey = GlobalKey<FormState>();
  
  // Project data (simulated existing project)
  String projectName = "Riverside Commercial Complex";
  String clientName = "Riverside Development Corp";
  String projectDescription = "A state-of-the-art commercial complex featuring modern office spaces, retail outlets, and entertainment facilities. The project includes sustainable design elements and smart building technologies.";
  String projectLocation = "Downtown District";
  String projectType = "commercial";
  String projectStatus = "in_progress";
  
  // Timeline & Budget
  String startDate = "2024-01-15";
  String endDate = "2024-12-30";
  String budget = "2500000";
  String currency = "USD";
  double progress = 65.0;
  
  // Team & Management
  String projectManager = "Sarah Wilson";
  String siteEngineer = "Mike Chen";
  String safetyOfficer = "David Brown";
  String expectedTeamSize = "8";
  
  // Contact Information
  String projectManagerPhone = "+1 555-0101";
  String projectManagerEmail = "sarah.wilson@company.com";
  String siteEngineerPhone = "+1 555-0102";
  String siteEngineerEmail = "mike.chen@company.com";
  
  // Project Images
  List<String> projectImages = [
    "https://picsum.photos/300/200?random=1&keyword=construction",
    "https://picsum.photos/300/200?random=2&keyword=building",
    "https://picsum.photos/300/200?random=3&keyword=architecture"
  ];
  String mainImage = "https://picsum.photos/400/250?random=1&keyword=construction";
  
  // Requirements & Permits
  List<String> requiredPermits = ["building_permit", "environmental", "fire_safety"];
  String specialRequirements = "LEED Gold certification required, Smart building integration, Underground parking";
  String complianceNotes = "All materials must meet environmental standards. Regular safety inspections required.";
  
  // Materials & Equipment
  String equipmentNeeds = "Tower crane, Concrete mixers, Steel cutting equipment, Safety equipment";
  
  // Priority and Risk Assessment
  String projectPriority = "high";
  String riskAssessment = "Medium risk project with weather dependency concerns";
  
  int currentTab = 0;
  bool hasUnsavedChanges = false;
  
  List<Map<String, dynamic>> projectTypeOptions = [
    {"label": "Commercial Building", "value": "commercial"},
    {"label": "Residential Complex", "value": "residential"},
    {"label": "Infrastructure", "value": "infrastructure"},
    {"label": "Healthcare Facility", "value": "healthcare"},
    {"label": "Educational Building", "value": "education"},
    {"label": "Industrial Facility", "value": "industrial"},
    {"label": "Government Building", "value": "government"},
    {"label": "Mixed-Use Development", "value": "mixed_use"},
  ];
  
  List<Map<String, dynamic>> statusOptions = [
    {"label": "Planning", "value": "planning"},
    {"label": "In Progress", "value": "in_progress"},
    {"label": "On Hold", "value": "on_hold"},
    {"label": "Delayed", "value": "delayed"},
    {"label": "Completed", "value": "completed"},
    {"label": "Cancelled", "value": "cancelled"},
  ];
  
  List<Map<String, dynamic>> priorityOptions = [
    {"label": "Low Priority", "value": "low"},
    {"label": "Medium Priority", "value": "medium"},
    {"label": "High Priority", "value": "high"},
    {"label": "Critical", "value": "critical"},
  ];
  
  List<Map<String, dynamic>> currencyOptions = [
    {"label": "US Dollar (USD)", "value": "USD"},
    {"label": "Euro (EUR)", "value": "EUR"},
    {"label": "British Pound (GBP)", "value": "GBP"},
    {"label": "Canadian Dollar (CAD)", "value": "CAD"},
  ];
  
  List<Map<String, dynamic>> permitOptions = [
    {"label": "Building Permit", "value": "building_permit"},
    {"label": "Environmental Clearance", "value": "environmental"},
    {"label": "Fire Safety Certificate", "value": "fire_safety"},
    {"label": "Electrical Permit", "value": "electrical"},
    {"label": "Plumbing Permit", "value": "plumbing"},
    {"label": "Zoning Approval", "value": "zoning"},
    {"label": "Road Cutting Permit", "value": "road_cutting"},
    {"label": "Waste Management Permit", "value": "waste_management"},
  ];

  void _markAsChanged() {
    if (!hasUnsavedChanges) {
      hasUnsavedChanges = true;
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Project"),
        actions: [
          if (hasUnsavedChanges)
            Container(
              padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
              margin: EdgeInsets.only(right: spSm),
              decoration: BoxDecoration(
                color: warningColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Text(
                "Unsaved",
                style: TextStyle(
                  fontSize: 12,
                  color: warningColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          IconButton(
            icon: Icon(Icons.more_vert),
            onPressed: () => _showMoreOptions(),
          ),
        ],
      ),
      body: Form(
        key: formKey,
        child: Column(
          children: [
            _buildTabBar(),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(spMd),
                child: _buildTabContent(),
              ),
            ),
            _buildBottomActions(),
          ],
        ),
      ),
    );
  }

  Widget _buildTabBar() {
    List<String> tabs = ["General", "Timeline", "Team", "Settings"];
    
    return Container(
      height: 50,
      color: Colors.white,
      child: Row(
        children: tabs.asMap().entries.map((entry) {
          int index = entry.key;
          String tab = entry.value;
          bool isActive = currentTab == index;
          
          return Expanded(
            child: GestureDetector(
              onTap: () {
                currentTab = index;
                setState(() {});
              },
              child: Container(
                decoration: BoxDecoration(
                  color: isActive ? primaryColor : Colors.transparent,
                  border: Border(
                    bottom: BorderSide(
                      color: isActive ? primaryColor : disabledOutlineBorderColor,
                      width: 2,
                    ),
                  ),
                ),
                child: Center(
                  child: Text(
                    tab,
                    style: TextStyle(
                      color: isActive ? Colors.white : disabledBoldColor,
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildTabContent() {
    switch (currentTab) {
      case 0:
        return _buildGeneralTab();
      case 1:
        return _buildTimelineTab();
      case 2:
        return _buildTeamTab();
      case 3:
        return _buildSettingsTab();
      default:
        return _buildGeneralTab();
    }
  }

  Widget _buildGeneralTab() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
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
            children: [
              Text(
                "Basic Information",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              SizedBox(height: spSm),
              
              QTextField(
                label: "Project Name",
                value: projectName,
                hint: "Enter project name",
                validator: Validator.required,
                onChanged: (value) {
                  projectName = value;
                  _markAsChanged();
                },
              ),
              SizedBox(height: spSm),
              
              QTextField(
                label: "Client Name",
                value: clientName,
                hint: "Enter client/company name",
                validator: Validator.required,
                onChanged: (value) {
                  clientName = value;
                  _markAsChanged();
                },
              ),
              SizedBox(height: spSm),
              
              Row(
                children: [
                  Expanded(
                    child: QDropdownField(
                      label: "Project Type",
                      items: projectTypeOptions,
                      value: projectType,
                      validator: Validator.required,
                      onChanged: (value, label) {
                        projectType = value;
                        _markAsChanged();
                      },
                    ),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: QDropdownField(
                      label: "Project Status",
                      items: statusOptions,
                      value: projectStatus,
                      onChanged: (value, label) {
                        projectStatus = value;
                        _markAsChanged();
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: spSm),
              
              QTextField(
                label: "Project Location",
                value: projectLocation,
                hint: "Enter complete address",
                validator: Validator.required,
                onChanged: (value) {
                  projectLocation = value;
                  _markAsChanged();
                },
              ),
              SizedBox(height: spSm),
              
              QMemoField(
                label: "Project Description",
                value: projectDescription,
                hint: "Describe the project scope and objectives",
                validator: Validator.required,
                onChanged: (value) {
                  projectDescription = value;
                  _markAsChanged();
                },
              ),
            ],
          ),
        ),
        SizedBox(height: spMd),
        
        Container(
          padding: EdgeInsets.all(spMd),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(radiusMd),
            boxShadow: [shadowSm],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Project Progress",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              SizedBox(height: spSm),
              
              Row(
                children: [
                  Text(
                    "Current Progress: ${progress.toStringAsFixed(0)}%",
                    style: TextStyle(
                      fontSize: 14,
                      color: disabledBoldColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Spacer(),
                  Text(
                    "${progress.toStringAsFixed(0)}%",
                    style: TextStyle(
                      fontSize: fsH6,
                      color: primaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              SizedBox(height: spXs),
              
              Slider(
                value: progress,
                min: 0,
                max: 100,
                divisions: 100,
                activeColor: primaryColor,
                inactiveColor: disabledOutlineBorderColor,
                onChanged: (value) {
                  progress = value;
                  _markAsChanged();
                },
              ),
              
              LinearProgressIndicator(
                value: progress / 100,
                backgroundColor: disabledOutlineBorderColor,
                valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
              ),
            ],
          ),
        ),
        SizedBox(height: spMd),
        
        Container(
          padding: EdgeInsets.all(spMd),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(radiusMd),
            boxShadow: [shadowSm],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Project Images",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              SizedBox(height: spSm),
              
              QImagePicker(
                label: "Main Project Image",
                value: mainImage,
                hint: "Select main project image",
                onChanged: (value) {
                  mainImage = value;
                  _markAsChanged();
                },
              ),
              SizedBox(height: spSm),
              
              QMultiImagePicker(
                label: "Additional Project Images",
                value: projectImages,
                maxImages: 10,
                hint: "Select additional project images",
                onChanged: (value) {
                  projectImages = value;
                  _markAsChanged();
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTimelineTab() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
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
            children: [
              Text(
                "Timeline & Budget",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              SizedBox(height: spSm),
              
              Row(
                children: [
                  Expanded(
                    child: QDatePicker(
                      label: "Start Date",
                      value: DateTime.parse(startDate),
                      onChanged: (value) {
                        startDate = value.toIso8601String();
                        _markAsChanged();
                      },
                    ),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: QDatePicker(
                      label: "Expected End Date",
                      value: DateTime.parse(endDate),
                      onChanged: (value) {
                        endDate = value.toIso8601String();
                        _markAsChanged();
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: spSm),
              
              Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: QNumberField(
                      label: "Project Budget",
                      value: budget,
                      hint: "Enter total budget amount",
                      validator: Validator.required,
                      onChanged: (value) {
                        budget = value;
                        _markAsChanged();
                      },
                    ),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: QDropdownField(
                      label: "Currency",
                      items: currencyOptions,
                      value: currency,
                      onChanged: (value, label) {
                        currency = value;
                        _markAsChanged();
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: spSm),
              
              QDropdownField(
                label: "Project Priority",
                items: priorityOptions,
                value: projectPriority,
                onChanged: (value, label) {
                  projectPriority = value;
                  _markAsChanged();
                },
              ),
            ],
          ),
        ),
        SizedBox(height: spMd),
        
        Container(
          padding: EdgeInsets.all(spMd),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(radiusMd),
            boxShadow: [shadowSm],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Requirements & Compliance",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              SizedBox(height: spSm),
              
              Text(
                "Required Permits",
                style: TextStyle(
                  fontSize: 14,
                  color: disabledBoldColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: spXs),
              
              Wrap(
                spacing: spSm,
                runSpacing: spXs,
                children: permitOptions.map((permit) {
                  bool isSelected = requiredPermits.contains(permit["value"]);
                  return GestureDetector(
                    onTap: () {
                      if (isSelected) {
                        requiredPermits.remove(permit["value"]);
                      } else {
                        requiredPermits.add(permit["value"]);
                      }
                      _markAsChanged();
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                      decoration: BoxDecoration(
                        color: isSelected ? primaryColor.withAlpha(20) : disabledColor.withAlpha(10),
                        borderRadius: BorderRadius.circular(radiusSm),
                        border: Border.all(
                          color: isSelected ? primaryColor : disabledOutlineBorderColor,
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            isSelected ? Icons.check_circle : Icons.circle_outlined,
                            size: 16,
                            color: isSelected ? primaryColor : disabledBoldColor,
                          ),
                          SizedBox(width: spXs),
                          Text(
                            "${permit["label"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: isSelected ? primaryColor : disabledBoldColor,
                              fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
              SizedBox(height: spSm),
              
              QMemoField(
                label: "Special Requirements",
                value: specialRequirements,
                hint: "Any special requirements or constraints",
                onChanged: (value) {
                  specialRequirements = value;
                  _markAsChanged();
                },
              ),
              SizedBox(height: spSm),
              
              QMemoField(
                label: "Compliance Notes",
                value: complianceNotes,
                hint: "Any compliance or regulatory notes",
                onChanged: (value) {
                  complianceNotes = value;
                  _markAsChanged();
                },
              ),
              SizedBox(height: spSm),
              
              QMemoField(
                label: "Risk Assessment",
                value: riskAssessment,
                hint: "Identify potential risks and mitigation strategies",
                onChanged: (value) {
                  riskAssessment = value;
                  _markAsChanged();
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTeamTab() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
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
            children: [
              Text(
                "Team Management",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              SizedBox(height: spSm),
              
              Row(
                children: [
                  Expanded(
                    child: QTextField(
                      label: "Project Manager",
                      value: projectManager,
                      hint: "Enter project manager name",
                      validator: Validator.required,
                      onChanged: (value) {
                        projectManager = value;
                        _markAsChanged();
                      },
                    ),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: QTextField(
                      label: "Manager Phone",
                      value: projectManagerPhone,
                      hint: "Enter phone number",
                      onChanged: (value) {
                        projectManagerPhone = value;
                        _markAsChanged();
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: spSm),
              
              QTextField(
                label: "Manager Email",
                value: projectManagerEmail,
                hint: "Enter email address",
                onChanged: (value) {
                  projectManagerEmail = value;
                  _markAsChanged();
                },
              ),
              SizedBox(height: spSm),
              
              Row(
                children: [
                  Expanded(
                    child: QTextField(
                      label: "Site Engineer",
                      value: siteEngineer,
                      hint: "Enter site engineer name",
                      onChanged: (value) {
                        siteEngineer = value;
                        _markAsChanged();
                      },
                    ),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: QTextField(
                      label: "Engineer Phone",
                      value: siteEngineerPhone,
                      hint: "Enter phone number",
                      onChanged: (value) {
                        siteEngineerPhone = value;
                        _markAsChanged();
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: spSm),
              
              QTextField(
                label: "Engineer Email",
                value: siteEngineerEmail,
                hint: "Enter email address",
                onChanged: (value) {
                  siteEngineerEmail = value;
                  _markAsChanged();
                },
              ),
              SizedBox(height: spSm),
              
              Row(
                children: [
                  Expanded(
                    child: QTextField(
                      label: "Safety Officer",
                      value: safetyOfficer,
                      hint: "Enter safety officer name",
                      onChanged: (value) {
                        safetyOfficer = value;
                        _markAsChanged();
                      },
                    ),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: QNumberField(
                      label: "Team Size",
                      value: expectedTeamSize,
                      hint: "Number of team members",
                      onChanged: (value) {
                        expectedTeamSize = value;
                        _markAsChanged();
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        SizedBox(height: spMd),
        
        Container(
          padding: EdgeInsets.all(spMd),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(radiusMd),
            boxShadow: [shadowSm],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Resources & Equipment",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              SizedBox(height: spSm),
              
              QMemoField(
                label: "Equipment Requirements",
                value: equipmentNeeds,
                hint: "List required equipment and machinery",
                onChanged: (value) {
                  equipmentNeeds = value;
                  _markAsChanged();
                },
              ),
            ],
          ),
        ),
        SizedBox(height: spMd),
        
        Container(
          padding: EdgeInsets.all(spSm),
          decoration: BoxDecoration(
            color: infoColor.withAlpha(10),
            borderRadius: BorderRadius.circular(radiusSm),
            border: Border.all(color: infoColor.withAlpha(30)),
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
                  "Team member details and assignments can be managed through the dedicated Team Management section for more advanced features.",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSettingsTab() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
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
            children: [
              Text(
                "Project Settings",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              SizedBox(height: spSm),
              
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: warningColor.withAlpha(10),
                  borderRadius: BorderRadius.circular(radiusSm),
                  border: Border.all(color: warningColor.withAlpha(30)),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.warning,
                      color: warningColor,
                      size: 20,
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: Text(
                        "Advanced project settings and configuration options. Changes here may affect project workflow and team access.",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: spMd),
              
              Row(
                children: [
                  Expanded(
                    child: QButton(
                      label: "Export Project Data",
                      icon: Icons.download,
                      size: bs.sm,
                      color: successColor,
                      onPressed: () {
                        si("Project data export started");
                      },
                    ),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: QButton(
                      label: "Duplicate Project",
                      icon: Icons.copy,
                      size: bs.sm,
                      color: infoColor,
                      onPressed: () {
                        _showDuplicateConfirmation();
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: spSm),
              
              Row(
                children: [
                  Expanded(
                    child: QButton(
                      label: "Archive Project",
                      icon: Icons.archive,
                      size: bs.sm,
                      color: warningColor,
                      onPressed: () {
                        _showArchiveConfirmation();
                      },
                    ),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: QButton(
                      label: "Delete Project",
                      icon: Icons.delete,
                      size: bs.sm,
                      color: dangerColor,
                      onPressed: () {
                        _showDeleteConfirmation();
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        SizedBox(height: spMd),
        
        Container(
          padding: EdgeInsets.all(spMd),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(radiusMd),
            boxShadow: [shadowSm],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Project History",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              SizedBox(height: spSm),
              
              Row(
                children: [
                  Icon(
                    Icons.history,
                    size: 16,
                    color: disabledBoldColor,
                  ),
                  SizedBox(width: spXs),
                  Text(
                    "Created: ${DateTime.parse(startDate).dMMMy}",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ),
              SizedBox(height: spXs),
              
              Row(
                children: [
                  Icon(
                    Icons.edit,
                    size: 16,
                    color: disabledBoldColor,
                  ),
                  SizedBox(width: spXs),
                  Text(
                    "Last Modified: ${DateTime.now().dMMMy}",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ),
              SizedBox(height: spXs),
              
              Row(
                children: [
                  Icon(
                    Icons.person,
                    size: 16,
                    color: disabledBoldColor,
                  ),
                  SizedBox(width: spXs),
                  Text(
                    "Last Modified By: $projectManager",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildBottomActions() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [shadowSm],
      ),
      child: Row(
        children: [
          Expanded(
            child: QButton(
              label: "Cancel",
              size: bs.sm,
              color: disabledBoldColor,
              onPressed: () {
                if (hasUnsavedChanges) {
                  _showUnsavedChangesDialog();
                } else {
                  back();
                }
              },
            ),
          ),
          SizedBox(width: spSm),
          Expanded(
            flex: 2,
            child: QButton(
              label: hasUnsavedChanges ? "Save Changes" : "Update Project",
              size: bs.sm,
              onPressed: _saveProject,
            ),
          ),
        ],
      ),
    );
  }

  void _saveProject() async {
    if (!formKey.currentState!.validate()) {
      return;
    }

    showLoading();
    
    // Simulate saving
    await Future.delayed(Duration(seconds: 2));
    
    hideLoading();
    
    hasUnsavedChanges = false;
    setState(() {});
    
    ss("Project updated successfully!");
  }

  void _showUnsavedChangesDialog() async {
    bool isConfirmed = await confirm("You have unsaved changes. Are you sure you want to leave without saving?");
    if (isConfirmed) {
      back();
    }
  }

  void _showDuplicateConfirmation() async {
    bool isConfirmed = await confirm("Create a duplicate of this project with the same settings?");
    if (isConfirmed) {
      si("Project duplicated successfully!");
    }
  }

  void _showArchiveConfirmation() async {
    bool isConfirmed = await confirm("Archive this project? It will be moved to archived projects and can be restored later.");
    if (isConfirmed) {
      sw("Project archived successfully!");
    }
  }

  void _showDeleteConfirmation() async {
    bool isConfirmed = await confirm("Permanently delete this project? This action cannot be undone.");
    if (isConfirmed) {
      se("Project deleted successfully!");
      back();
    }
  }

  void _showMoreOptions() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        padding: EdgeInsets.all(spMd),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(radiusLg)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: disabledOutlineBorderColor,
                borderRadius: BorderRadius.circular(radiusXs),
              ),
            ),
            SizedBox(height: spMd),
            Row(
              children: [
                Expanded(
                  child: QButton(
                    label: "View Timeline",
                    icon: Icons.timeline,
                    size: bs.sm,
                    onPressed: () {
                      Navigator.pop(context);
                      //navigateTo('ComaProjectTimelineView')
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QButton(
                    label: "View Milestones",
                    icon: Icons.flag,
                    size: bs.sm,
                    color: secondaryColor,
                    onPressed: () {
                      Navigator.pop(context);
                      //navigateTo('ComaProjectMilestonesView')
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: spSm),
            Row(
              children: [
                Expanded(
                  child: QButton(
                    label: "Material Management",
                    icon: Icons.inventory,
                    size: bs.sm,
                    color: successColor,
                    onPressed: () {
                      Navigator.pop(context);
                      //navigateTo('ComaMaterialManagementView')
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QButton(
                    label: "Permit Management",
                    icon: Icons.assignment,
                    size: bs.sm,
                    color: warningColor,
                    onPressed: () {
                      Navigator.pop(context);
                      //navigateTo('ComaPermitManagementView')
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
