import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class DmsClientOnboardingView extends StatefulWidget {
  const DmsClientOnboardingView({super.key});

  @override
  State<DmsClientOnboardingView> createState() => _DmsClientOnboardingViewState();
}

class _DmsClientOnboardingViewState extends State<DmsClientOnboardingView> {
  int currentStep = 0;
  bool loading = false;

  // Step 1: Basic Information
  String companyName = "";
  String contactPerson = "";
  String email = "";
  String phone = "";
  String industry = "";
  String website = "";

  // Step 2: Business Details
  String businessSize = "small";
  String businessType = "corporation";
  String annualRevenue = "";
  String employees = "";
  String description = "";

  // Step 3: Service Requirements
  List<String> selectedServices = [];
  String projectBudget = "";
  String timeline = "";
  String priorityLevel = "medium";
  String communicationPreference = "email";

  // Step 4: Documents
  List<String> uploadedDocuments = [];
  String contractType = "standard";
  bool termsAccepted = false;
  bool privacyAccepted = false;

  final formKey = GlobalKey<FormState>();

  List<Map<String, dynamic>> onboardingSteps = [
    {
      "title": "Basic Information",
      "description": "Company details and contact information",
      "icon": Icons.business,
    },
    {
      "title": "Business Details",
      "description": "Company size, type, and description",
      "icon": Icons.info,
    },
    {
      "title": "Service Requirements",
      "description": "Services needed and project details",
      "icon": Icons.work,
    },
    {
      "title": "Documentation",
      "description": "Upload documents and accept terms",
      "icon": Icons.folder,
    },
  ];

  List<Map<String, dynamic>> availableServices = [
    {"label": "Web Development", "value": "web_dev", "icon": Icons.web},
    {"label": "Mobile Apps", "value": "mobile", "icon": Icons.phone_android},
    {"label": "Digital Marketing", "value": "marketing", "icon": Icons.campaign},
    {"label": "Consulting", "value": "consulting", "icon": Icons.psychology},
    {"label": "Design Services", "value": "design", "icon": Icons.palette},
    {"label": "Data Analytics", "value": "analytics", "icon": Icons.analytics},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Client Onboarding"),
        actions: [
          if (currentStep > 0)
            IconButton(
              icon: Icon(Icons.save),
              onPressed: () => _saveDraft(),
            ),
        ],
      ),
      body: loading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: EdgeInsets.all(spMd),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildProgressIndicator(),
                  SizedBox(height: spLg),
                  _buildStepContent(),
                  SizedBox(height: spLg),
                  _buildNavigationButtons(),
                ],
              ),
            ),
    );
  }

  Widget _buildProgressIndicator() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Onboarding Progress",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          Row(
            children: List.generate(onboardingSteps.length, (index) {
              final isCompleted = index < currentStep;
              final isCurrent = index == currentStep;
              final stepData = onboardingSteps[index];

              return Expanded(
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: isCompleted
                                  ? successColor
                                  : isCurrent
                                      ? primaryColor
                                      : disabledColor,
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Icon(
                              isCompleted
                                  ? Icons.check
                                  : stepData["icon"],
                              color: Colors.white,
                              size: 20,
                            ),
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "${stepData["title"]}",
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                              color: isCurrent ? primaryColor : disabledBoldColor,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                    if (index < onboardingSteps.length - 1)
                      Container(
                        height: 2,
                        width: 20,
                        color: isCompleted ? successColor : disabledOutlineBorderColor,
                      ),
                  ],
                ),
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildStepContent() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "${onboardingSteps[currentStep]["title"]}",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spXs),
            Text(
              "${onboardingSteps[currentStep]["description"]}",
              style: TextStyle(
                fontSize: 14,
                color: disabledBoldColor,
              ),
            ),
            SizedBox(height: spSm),
            _getStepWidget(),
          ],
        ),
      ),
    );
  }

  Widget _getStepWidget() {
    switch (currentStep) {
      case 0:
        return _buildBasicInformation();
      case 1:
        return _buildBusinessDetails();
      case 2:
        return _buildServiceRequirements();
      case 3:
        return _buildDocumentation();
      default:
        return Container();
    }
  }

  Widget _buildBasicInformation() {
    return Column(
      spacing: spSm,
      children: [
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
          label: "Contact Person",
          value: contactPerson,
          validator: Validator.required,
          onChanged: (value) {
            contactPerson = value;
            setState(() {});
          },
        ),
        Row(
          children: [
            Expanded(
              child: QTextField(
                label: "Email Address",
                value: email,
                validator: Validator.email,
                onChanged: (value) {
                  email = value;
                  setState(() {});
                },
              ),
            ),
            SizedBox(width: spSm),
            Expanded(
              child: QTextField(
                label: "Phone Number",
                value: phone,
                validator: Validator.required,
                onChanged: (value) {
                  phone = value;
                  setState(() {});
                },
              ),
            ),
          ],
        ),
        Row(
          children: [
            Expanded(
              child: QDropdownField(
                label: "Industry",
                items: [
                  {"label": "Technology", "value": "technology"},
                  {"label": "Healthcare", "value": "healthcare"},
                  {"label": "Finance", "value": "finance"},
                  {"label": "Education", "value": "education"},
                  {"label": "Retail", "value": "retail"},
                  {"label": "Manufacturing", "value": "manufacturing"},
                  {"label": "Other", "value": "other"},
                ],
                value: industry,
                onChanged: (value, label) {
                  industry = value;
                  setState(() {});
                },
              ),
            ),
            SizedBox(width: spSm),
            Expanded(
              child: QTextField(
                label: "Website (Optional)",
                value: website,
                onChanged: (value) {
                  website = value;
                  setState(() {});
                },
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildBusinessDetails() {
    return Column(
      spacing: spSm,
      children: [
        Row(
          children: [
            Expanded(
              child: QDropdownField(
                label: "Business Size",
                items: [
                  {"label": "Small (1-10 employees)", "value": "small"},
                  {"label": "Medium (11-50 employees)", "value": "medium"},
                  {"label": "Large (51-200 employees)", "value": "large"},
                  {"label": "Enterprise (200+ employees)", "value": "enterprise"},
                ],
                value: businessSize,
                onChanged: (value, label) {
                  businessSize = value;
                  setState(() {});
                },
              ),
            ),
            SizedBox(width: spSm),
            Expanded(
              child: QDropdownField(
                label: "Business Type",
                items: [
                  {"label": "Corporation", "value": "corporation"},
                  {"label": "LLC", "value": "llc"},
                  {"label": "Partnership", "value": "partnership"},
                  {"label": "Sole Proprietorship", "value": "sole"},
                  {"label": "Non-Profit", "value": "nonprofit"},
                ],
                value: businessType,
                onChanged: (value, label) {
                  businessType = value;
                  setState(() {});
                },
              ),
            ),
          ],
        ),
        Row(
          children: [
            Expanded(
              child: QNumberField(
                label: "Annual Revenue (\$)",
                value: annualRevenue,
                onChanged: (value) {
                  annualRevenue = value;
                  setState(() {});
                },
              ),
            ),
            SizedBox(width: spSm),
            Expanded(
              child: QNumberField(
                label: "Number of Employees",
                value: employees,
                onChanged: (value) {
                  employees = value;
                  setState(() {});
                },
              ),
            ),
          ],
        ),
        QMemoField(
          label: "Business Description",
          value: description,
          hint: "Describe your business, mission, and goals...",
          onChanged: (value) {
            description = value;
            setState(() {});
          },
        ),
      ],
    );
  }

  Widget _buildServiceRequirements() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Select Services Needed",
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: primaryColor,
          ),
        ),
        SizedBox(height: spSm),
        Wrap(
          spacing: spSm,
          runSpacing: spSm,
          children: availableServices.map((service) {
            final isSelected = selectedServices.contains(service["value"]);
            return GestureDetector(
              onTap: () {
                if (isSelected) {
                  selectedServices.remove(service["value"]);
                } else {
                  selectedServices.add(service["value"]);
                }
                setState(() {});
              },
              child: Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: isSelected ? primaryColor.withAlpha(20) : Colors.grey.withAlpha(10),
                  borderRadius: BorderRadius.circular(radiusSm),
                  border: Border.all(
                    color: isSelected ? primaryColor : disabledOutlineBorderColor,
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      service["icon"],
                      color: isSelected ? primaryColor : disabledBoldColor,
                      size: 16,
                    ),
                    SizedBox(width: spXs),
                    Text(
                      "${service["label"]}",
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
        Column(
          spacing: spSm,
          children: [
            Row(
              children: [
                Expanded(
                  child: QNumberField(
                    label: "Project Budget (\$)",
                    value: projectBudget,
                    onChanged: (value) {
                      projectBudget = value;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QDropdownField(
                    label: "Timeline",
                    items: [
                      {"label": "ASAP", "value": "asap"},
                      {"label": "1-3 months", "value": "1-3"},
                      {"label": "3-6 months", "value": "3-6"},
                      {"label": "6-12 months", "value": "6-12"},
                      {"label": "12+ months", "value": "12+"},
                    ],
                    value: timeline,
                    onChanged: (value, label) {
                      timeline = value;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: QDropdownField(
                    label: "Priority Level",
                    items: [
                      {"label": "Low", "value": "low"},
                      {"label": "Medium", "value": "medium"},
                      {"label": "High", "value": "high"},
                      {"label": "Urgent", "value": "urgent"},
                    ],
                    value: priorityLevel,
                    onChanged: (value, label) {
                      priorityLevel = value;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QDropdownField(
                    label: "Communication Preference",
                    items: [
                      {"label": "Email", "value": "email"},
                      {"label": "Phone", "value": "phone"},
                      {"label": "Video Calls", "value": "video"},
                      {"label": "In-Person", "value": "person"},
                    ],
                    value: communicationPreference,
                    onChanged: (value, label) {
                      communicationPreference = value;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildDocumentation() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        QMultiImagePicker(
          label: "Upload Documents",
          value: uploadedDocuments,
          hint: "Upload business documents, contracts, etc.",
          onChanged: (value) {
            uploadedDocuments = value;
            setState(() {});
          },
        ),
        SizedBox(height: spSm),
        QDropdownField(
          label: "Contract Type",
          items: [
            {"label": "Standard Contract", "value": "standard"},
            {"label": "Enterprise Contract", "value": "enterprise"},
            {"label": "Custom Contract", "value": "custom"},
          ],
          value: contractType,
          onChanged: (value, label) {
            contractType = value;
            setState(() {});
          },
        ),
        SizedBox(height: spSm),
        QSwitch(
          items: [
            {
              "label": "I accept the Terms and Conditions",
              "value": "terms",
              "checked": termsAccepted,
            }
          ],
          value: termsAccepted ? [{"label": "I accept the Terms and Conditions", "value": "terms", "checked": true}] : [],
          onChanged: (values, ids) {
            termsAccepted = values.isNotEmpty;
            setState(() {});
          },
        ),
        SizedBox(height: spSm),
        QSwitch(
          items: [
            {
              "label": "I accept the Privacy Policy",
              "value": "privacy",
              "checked": privacyAccepted,
            }
          ],
          value: privacyAccepted ? [{"label": "I accept the Privacy Policy", "value": "privacy", "checked": true}] : [],
          onChanged: (values, ids) {
            privacyAccepted = values.isNotEmpty;
            setState(() {});
          },
        ),
      ],
    );
  }

  Widget _buildNavigationButtons() {
    return Row(
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
        if (currentStep > 0) SizedBox(width: spSm),
        Expanded(
          child: QButton(
            label: currentStep == onboardingSteps.length - 1 ? "Complete Onboarding" : "Next",
            size: bs.md,
            onPressed: () => _nextStep(),
          ),
        ),
      ],
    );
  }

  void _nextStep() async {
    if (formKey.currentState!.validate()) {
      if (currentStep == onboardingSteps.length - 1) {
        // Complete onboarding
        if (!termsAccepted || !privacyAccepted) {
          se("Please accept all terms and conditions to continue");
          return;
        }
        
        loading = true;
        setState(() {});

        await Future.delayed(Duration(seconds: 2));
        
        loading = false;
        setState(() {});
        
        ss("Client onboarding completed successfully!");
        // navigateTo('ClientDashboardView')
      } else {
        currentStep++;
        setState(() {});
      }
    }
  }

  void _saveDraft() {
    ss("Draft saved successfully!");
  }
}
