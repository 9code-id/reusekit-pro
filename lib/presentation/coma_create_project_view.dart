import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class ComaCreateProjectView extends StatefulWidget {
  const ComaCreateProjectView({Key? key}) : super(key: key);

  @override
  State<ComaCreateProjectView> createState() => _ComaCreateProjectViewState();
}

class _ComaCreateProjectViewState extends State<ComaCreateProjectView> {
  final formKey = GlobalKey<FormState>();
  
  // Basic Information
  String projectName = "";
  String clientName = "";
  String projectDescription = "";
  String projectLocation = "";
  String projectType = "";
  
  // Timeline & Budget
  String startDate = "";
  String endDate = "";
  String budget = "";
  String currency = "USD";
  
  // Team & Management
  String projectManager = "";
  String siteEngineer = "";
  String safetyOfficer = "";
  String expectedTeamSize = "";
  
  // Project Images
  List<String> projectImages = [];
  String mainImage = "";
  
  // Requirements & Permits
  List<String> requiredPermits = [];
  String specialRequirements = "";
  String complianceNotes = "";
  
  // Materials & Equipment
  List<Map<String, dynamic>> initialMaterials = [];
  String equipmentNeeds = "";
  
  int currentStep = 0;
  
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create New Project"),
        actions: [
          if (currentStep > 0)
            TextButton(
              onPressed: _previousStep,
              child: Text(
                "Previous",
                style: TextStyle(color: primaryColor),
              ),
            ),
        ],
      ),
      body: Form(
        key: formKey,
        child: Column(
          children: [
            _buildProgressIndicator(),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(spMd),
                child: _buildCurrentStep(),
              ),
            ),
            _buildBottomActions(),
          ],
        ),
      ),
    );
  }

  Widget _buildProgressIndicator() {
    return Container(
      padding: EdgeInsets.all(spMd),
      color: Colors.white,
      child: Column(
        children: [
          Row(
            children: List.generate(4, (index) {
              bool isActive = index <= currentStep;
              bool isCurrent = index == currentStep;
              return Expanded(
                child: Container(
                  height: 4,
                  margin: EdgeInsets.symmetric(horizontal: 2),
                  decoration: BoxDecoration(
                    color: isActive ? primaryColor : disabledOutlineBorderColor,
                    borderRadius: BorderRadius.circular(radiusXs),
                  ),
                ),
              );
            }),
          ),
          SizedBox(height: spSm),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildStepLabel("Basic Info", 0),
              _buildStepLabel("Timeline", 1),
              _buildStepLabel("Team", 2),
              _buildStepLabel("Review", 3),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStepLabel(String label, int step) {
    bool isActive = step <= currentStep;
    return Text(
      label,
      style: TextStyle(
        fontSize: 12,
        color: isActive ? primaryColor : disabledBoldColor,
        fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
      ),
    );
  }

  Widget _buildCurrentStep() {
    switch (currentStep) {
      case 0:
        return _buildBasicInfoStep();
      case 1:
        return _buildTimelineStep();
      case 2:
        return _buildTeamStep();
      case 3:
        return _buildReviewStep();
      default:
        return _buildBasicInfoStep();
    }
  }

  Widget _buildBasicInfoStep() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Project Basic Information",
          style: TextStyle(
            fontSize: fsH5,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        SizedBox(height: spMd),
        
        QTextField(
          label: "Project Name",
          value: projectName,
          hint: "Enter project name",
          validator: Validator.required,
          onChanged: (value) {
            projectName = value;
            setState(() {});
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
            setState(() {});
          },
        ),
        SizedBox(height: spSm),
        
        QDropdownField(
          label: "Project Type",
          items: projectTypeOptions,
          value: projectType,
          validator: Validator.required,
          onChanged: (value, label) {
            projectType = value;
            setState(() {});
          },
        ),
        SizedBox(height: spSm),
        
        QTextField(
          label: "Project Location",
          value: projectLocation,
          hint: "Enter complete address",
          validator: Validator.required,
          onChanged: (value) {
            projectLocation = value;
            setState(() {});
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
            setState(() {});
          },
        ),
        SizedBox(height: spSm),
        
        QImagePicker(
          label: "Main Project Image",
          value: mainImage,
          hint: "Select main project image",
          onChanged: (value) {
            mainImage = value;
            setState(() {});
          },
        ),
        SizedBox(height: spSm),
        
        QMultiImagePicker(
          label: "Additional Project Images",
          value: projectImages,
          maxImages: 8,
          hint: "Select additional project images",
          onChanged: (value) {
            projectImages = value;
            setState(() {});
          },
        ),
      ],
    );
  }

  Widget _buildTimelineStep() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Timeline & Budget",
          style: TextStyle(
            fontSize: fsH5,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        SizedBox(height: spMd),
        
        Row(
          children: [
            Expanded(
              child: QDatePicker(
                label: "Start Date",
                value: startDate.isNotEmpty ? DateTime.parse(startDate) : DateTime.now(),
                onChanged: (value) {
                  startDate = value.toIso8601String();
                  setState(() {});
                },
              ),
            ),
            SizedBox(width: spSm),
            Expanded(
              child: QDatePicker(
                label: "Expected End Date",
                value: endDate.isNotEmpty ? DateTime.parse(endDate) : DateTime.now().add(Duration(days: 365)),
                onChanged: (value) {
                  endDate = value.toIso8601String();
                  setState(() {});
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
                  setState(() {});
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
                  setState(() {});
                },
              ),
            ),
          ],
        ),
        SizedBox(height: spMd),
        
        Text(
          "Required Permits & Compliance",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        SizedBox(height: spSm),
        
        QCategoryPicker(
          label: "Select Required Permits",
          items: permitOptions,
          value: requiredPermits.isNotEmpty ? requiredPermits.first : "",
          onChanged: (index, label, value, item) {
            if (!requiredPermits.contains(value)) {
              requiredPermits.add(value);
              setState(() {});
            }
          },
        ),
        if (requiredPermits.isNotEmpty) ...[
          SizedBox(height: spSm),
          Wrap(
            spacing: spXs,
            runSpacing: spXs,
            children: requiredPermits.map((permit) {
              String permitLabel = permitOptions.firstWhere(
                (option) => option["value"] == permit,
                orElse: () => {"label": permit}
              )["label"];
              
              return Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: primaryColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      permitLabel,
                      style: TextStyle(
                        fontSize: 12,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(width: spXs),
                    GestureDetector(
                      onTap: () {
                        requiredPermits.remove(permit);
                        setState(() {});
                      },
                      child: Icon(
                        Icons.close,
                        size: 14,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ],
        SizedBox(height: spSm),
        
        QMemoField(
          label: "Special Requirements",
          value: specialRequirements,
          hint: "Any special requirements or constraints",
          onChanged: (value) {
            specialRequirements = value;
            setState(() {});
          },
        ),
        SizedBox(height: spSm),
        
        QMemoField(
          label: "Compliance Notes",
          value: complianceNotes,
          hint: "Any compliance or regulatory notes",
          onChanged: (value) {
            complianceNotes = value;
            setState(() {});
          },
        ),
      ],
    );
  }

  Widget _buildTeamStep() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Team & Management",
          style: TextStyle(
            fontSize: fsH5,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        SizedBox(height: spMd),
        
        QTextField(
          label: "Project Manager",
          value: projectManager,
          hint: "Enter project manager name",
          validator: Validator.required,
          onChanged: (value) {
            projectManager = value;
            setState(() {});
          },
        ),
        SizedBox(height: spSm),
        
        QTextField(
          label: "Site Engineer",
          value: siteEngineer,
          hint: "Enter site engineer name",
          onChanged: (value) {
            siteEngineer = value;
            setState(() {});
          },
        ),
        SizedBox(height: spSm),
        
        QTextField(
          label: "Safety Officer",
          value: safetyOfficer,
          hint: "Enter safety officer name",
          onChanged: (value) {
            safetyOfficer = value;
            setState(() {});
          },
        ),
        SizedBox(height: spSm),
        
        QNumberField(
          label: "Expected Team Size",
          value: expectedTeamSize,
          hint: "Enter expected number of team members",
          onChanged: (value) {
            expectedTeamSize = value;
            setState(() {});
          },
        ),
        SizedBox(height: spMd),
        
        Text(
          "Materials & Equipment",
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
            setState(() {});
          },
        ),
        SizedBox(height: spSm),
        
        Container(
          padding: EdgeInsets.all(spSm),
          decoration: BoxDecoration(
            color: infoColor.withAlpha(10),
            borderRadius: BorderRadius.circular(radiusSm),
            border: Border.all(color: infoColor.withAlpha(30)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.info,
                    size: 16,
                    color: infoColor,
                  ),
                  SizedBox(width: spXs),
                  Text(
                    "Material Management",
                    style: TextStyle(
                      fontSize: 14,
                      color: infoColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              SizedBox(height: spXs),
              Text(
                "Detailed material planning and procurement can be managed after project creation through the Material Management section.",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildReviewStep() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Review Project Details",
          style: TextStyle(
            fontSize: fsH5,
            fontWeight: FontWeight.bold,
            color: primaryColor,
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
                "Basic Information",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              SizedBox(height: spSm),
              _buildReviewItem("Project Name", projectName),
              _buildReviewItem("Client", clientName),
              _buildReviewItem("Type", projectType.isNotEmpty ? projectTypeOptions.firstWhere((option) => option["value"] == projectType)["label"] : ""),
              _buildReviewItem("Location", projectLocation),
              if (projectDescription.isNotEmpty)
                _buildReviewItem("Description", projectDescription),
            ],
          ),
        ),
        SizedBox(height: spSm),
        
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
              if (startDate.isNotEmpty)
                _buildReviewItem("Start Date", DateTime.parse(startDate).dMMMy),
              if (endDate.isNotEmpty)
                _buildReviewItem("End Date", DateTime.parse(endDate).dMMMy),
              if (budget.isNotEmpty)
                _buildReviewItem("Budget", "$currency ${double.tryParse(budget)?.toStringAsFixed(2) ?? budget}"),
              if (requiredPermits.isNotEmpty)
                _buildReviewItem("Required Permits", "${requiredPermits.length} permits selected"),
            ],
          ),
        ),
        SizedBox(height: spSm),
        
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
              if (projectManager.isNotEmpty)
                _buildReviewItem("Project Manager", projectManager),
              if (siteEngineer.isNotEmpty)
                _buildReviewItem("Site Engineer", siteEngineer),
              if (safetyOfficer.isNotEmpty)
                _buildReviewItem("Safety Officer", safetyOfficer),
              if (expectedTeamSize.isNotEmpty)
                _buildReviewItem("Expected Team Size", "$expectedTeamSize members"),
            ],
          ),
        ),
        
        if (mainImage.isNotEmpty || projectImages.isNotEmpty) ...[
          SizedBox(height: spSm),
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
                if (mainImage.isNotEmpty)
                  _buildReviewItem("Main Image", "Selected"),
                if (projectImages.isNotEmpty)
                  _buildReviewItem("Additional Images", "${projectImages.length} images"),
              ],
            ),
          ),
        ],
        
        SizedBox(height: spMd),
        Container(
          padding: EdgeInsets.all(spSm),
          decoration: BoxDecoration(
            color: successColor.withAlpha(10),
            borderRadius: BorderRadius.circular(radiusSm),
            border: Border.all(color: successColor.withAlpha(30)),
          ),
          child: Row(
            children: [
              Icon(
                Icons.check_circle,
                color: successColor,
                size: 20,
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Text(
                  "Review all details carefully before creating the project. You can edit most information later if needed.",
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

  Widget _buildReviewItem(String label, String value) {
    return Padding(
      padding: EdgeInsets.only(bottom: spXs),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 100,
            child: Text(
              "$label:",
              style: TextStyle(
                fontSize: 12,
                color: disabledBoldColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value.isNotEmpty ? value : "Not specified",
              style: TextStyle(
                fontSize: 12,
                color: value.isNotEmpty ? primaryColor : disabledBoldColor,
              ),
            ),
          ),
        ],
      ),
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
          if (currentStep > 0) ...[
            Expanded(
              child: QButton(
                label: "Previous",
                size: bs.sm,
                color: disabledBoldColor,
                onPressed: _previousStep,
              ),
            ),
            SizedBox(width: spSm),
          ],
          Expanded(
            child: QButton(
              label: currentStep == 3 ? "Create Project" : "Next",
              size: bs.sm,
              onPressed: _nextStep,
            ),
          ),
        ],
      ),
    );
  }

  void _nextStep() {
    if (currentStep == 3) {
      _createProject();
    } else {
      if (_validateCurrentStep()) {
        currentStep++;
        setState(() {});
      }
    }
  }

  void _previousStep() {
    if (currentStep > 0) {
      currentStep--;
      setState(() {});
    }
  }

  bool _validateCurrentStep() {
    switch (currentStep) {
      case 0:
        return projectName.isNotEmpty && 
               clientName.isNotEmpty && 
               projectType.isNotEmpty && 
               projectLocation.isNotEmpty &&
               projectDescription.isNotEmpty;
      case 1:
        return startDate.isNotEmpty && 
               endDate.isNotEmpty && 
               budget.isNotEmpty;
      case 2:
        return projectManager.isNotEmpty;
      default:
        return true;
    }
  }

  void _createProject() async {
    if (!formKey.currentState!.validate()) {
      return;
    }

    showLoading();
    
    // Simulate project creation
    await Future.delayed(Duration(seconds: 2));
    
    hideLoading();
    
    ss("Project created successfully!");
    
    // Navigate back or to project detail
    back();
  }
}
