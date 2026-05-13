import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class CrmAddDealView extends StatefulWidget {
  const CrmAddDealView({super.key});

  @override
  State<CrmAddDealView> createState() => _CrmAddDealViewState();
}

class _CrmAddDealViewState extends State<CrmAddDealView> {
  final formKey = GlobalKey<FormState>();
  
  // Basic Information
  String dealTitle = "";
  String companyName = "";
  String contactPerson = "";
  String dealValue = "";
  String description = "";
  
  // Deal Details
  String selectedStage = "Discovery";
  String selectedOwner = "Sarah Wilson";
  String selectedSource = "Website";
  String selectedPriority = "Medium";
  String selectedIndustry = "Technology";
  
  // Dates
  String closeDate = DateTime.now().add(Duration(days: 30)).toString().split(' ')[0];
  String expectedCloseDate = DateTime.now().add(Duration(days: 45)).toString().split(' ')[0];
  
  // Company Information
  String companyWebsite = "";
  String companyPhone = "";
  String companyEmail = "";
  String companyAddress = "";
  String employeeCount = "1-50";
  String annualRevenue = "Under 1M";
  
  // Additional Fields
  String probability = "50";
  List<String> selectedTags = [];
  String notes = "";
  
  // Contact Information
  String contactEmail = "";
  String contactPhone = "";
  String contactTitle = "";
  
  // Dropdown Options
  List<Map<String, dynamic>> stageOptions = [
    {"label": "Discovery", "value": "Discovery"},
    {"label": "Qualified", "value": "Qualified"},
    {"label": "Proposal", "value": "Proposal"},
    {"label": "Negotiation", "value": "Negotiation"},
    {"label": "Closed Won", "value": "Closed Won"},
    {"label": "Closed Lost", "value": "Closed Lost"},
  ];

  List<Map<String, dynamic>> ownerOptions = [
    {"label": "Sarah Wilson", "value": "Sarah Wilson"},
    {"label": "Mike Johnson", "value": "Mike Johnson"},
    {"label": "Emily Chen", "value": "Emily Chen"},
    {"label": "David Brown", "value": "David Brown"},
    {"label": "Lisa Wang", "value": "Lisa Wang"},
  ];

  List<Map<String, dynamic>> sourceOptions = [
    {"label": "Website", "value": "Website"},
    {"label": "Email Campaign", "value": "Email Campaign"},
    {"label": "Social Media", "value": "Social Media"},
    {"label": "Referral", "value": "Referral"},
    {"label": "Cold Call", "value": "Cold Call"},
    {"label": "Trade Show", "value": "Trade Show"},
    {"label": "Partner", "value": "Partner"},
  ];

  List<Map<String, dynamic>> priorityOptions = [
    {"label": "Low", "value": "Low"},
    {"label": "Medium", "value": "Medium"},
    {"label": "High", "value": "High"},
    {"label": "Critical", "value": "Critical"},
  ];

  List<Map<String, dynamic>> industryOptions = [
    {"label": "Technology", "value": "Technology"},
    {"label": "Healthcare", "value": "Healthcare"},
    {"label": "Finance", "value": "Finance"},
    {"label": "Education", "value": "Education"},
    {"label": "Manufacturing", "value": "Manufacturing"},
    {"label": "Retail", "value": "Retail"},
    {"label": "Real Estate", "value": "Real Estate"},
    {"label": "Consulting", "value": "Consulting"},
  ];

  List<Map<String, dynamic>> employeeOptions = [
    {"label": "1-50", "value": "1-50"},
    {"label": "51-200", "value": "51-200"},
    {"label": "201-500", "value": "201-500"},
    {"label": "501-1000", "value": "501-1000"},
    {"label": "1000+", "value": "1000+"},
  ];

  List<Map<String, dynamic>> revenueOptions = [
    {"label": "Under 1M", "value": "Under 1M"},
    {"label": "1M-10M", "value": "1M-10M"},
    {"label": "10M-50M", "value": "10M-50M"},
    {"label": "50M-100M", "value": "50M-100M"},
    {"label": "100M+", "value": "100M+"},
  ];

  List<String> availableTags = [
    "Enterprise",
    "Software",
    "Cloud",
    "Security",
    "Integration",
    "Mobile",
    "Analytics",
    "AI/ML",
    "Automation",
    "Training",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add New Deal"),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () {
              _saveDeal();
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
              // Basic Information Section
              Container(
                width: double.infinity,
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
                      label: "Deal Title",
                      value: dealTitle,
                      validator: Validator.required,
                      hint: "Enter deal title",
                      onChanged: (value) {
                        dealTitle = value;
                        setState(() {});
                      },
                    ),
                    QTextField(
                      label: "Company Name",
                      value: companyName,
                      validator: Validator.required,
                      hint: "Enter company name",
                      onChanged: (value) {
                        companyName = value;
                        setState(() {});
                      },
                    ),
                    QTextField(
                      label: "Contact Person",
                      value: contactPerson,
                      validator: Validator.required,
                      hint: "Enter primary contact name",
                      onChanged: (value) {
                        contactPerson = value;
                        setState(() {});
                      },
                    ),
                    QNumberField(
                      label: "Deal Value (\$)",
                      value: dealValue,
                      validator: Validator.required,
                      hint: "Enter deal value",
                      onChanged: (value) {
                        dealValue = value;
                        setState(() {});
                      },
                    ),
                    QMemoField(
                      label: "Description",
                      value: description,
                      hint: "Describe the deal opportunity",
                      onChanged: (value) {
                        description = value;
                        setState(() {});
                      },
                    ),
                  ],
                ),
              ),

              // Deal Details Section
              Container(
                width: double.infinity,
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
                      "Deal Details",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: QDropdownField(
                            label: "Stage",
                            items: stageOptions,
                            value: selectedStage,
                            onChanged: (value, label) {
                              selectedStage = value;
                              setState(() {});
                            },
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: QDropdownField(
                            label: "Owner",
                            items: ownerOptions,
                            value: selectedOwner,
                            onChanged: (value, label) {
                              selectedOwner = value;
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
                            label: "Source",
                            items: sourceOptions,
                            value: selectedSource,
                            onChanged: (value, label) {
                              selectedSource = value;
                              setState(() {});
                            },
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: QDropdownField(
                            label: "Priority",
                            items: priorityOptions,
                            value: selectedPriority,
                            onChanged: (value, label) {
                              selectedPriority = value;
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
                            label: "Probability (%)",
                            value: probability,
                            hint: "0-100",
                            onChanged: (value) {
                              probability = value;
                              setState(() {});
                            },
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: QDropdownField(
                            label: "Industry",
                            items: industryOptions,
                            value: selectedIndustry,
                            onChanged: (value, label) {
                              selectedIndustry = value;
                              setState(() {});
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Date Information Section
              Container(
                width: double.infinity,
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
                      "Timeline",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: QDatePicker(
                            label: "Expected Close Date",
                            value: DateTime.parse(closeDate),
                            onChanged: (value) {
                              closeDate = value.toString().split(' ')[0];
                              setState(() {});
                            },
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: QDatePicker(
                            label: "Latest Close Date",
                            value: DateTime.parse(expectedCloseDate),
                            onChanged: (value) {
                              expectedCloseDate = value.toString().split(' ')[0];
                              setState(() {});
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Company Information Section
              Container(
                width: double.infinity,
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
                      "Company Information",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    QTextField(
                      label: "Company Website",
                      value: companyWebsite,
                      hint: "https://company.com",
                      onChanged: (value) {
                        companyWebsite = value;
                        setState(() {});
                      },
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: QTextField(
                            label: "Company Phone",
                            value: companyPhone,
                            hint: "+1 (555) 123-4567",
                            onChanged: (value) {
                              companyPhone = value;
                              setState(() {});
                            },
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: QTextField(
                            label: "Company Email",
                            value: companyEmail,
                            hint: "contact@company.com",
                            onChanged: (value) {
                              companyEmail = value;
                              setState(() {});
                            },
                          ),
                        ),
                      ],
                    ),
                    QTextField(
                      label: "Company Address",
                      value: companyAddress,
                      hint: "Enter company address",
                      onChanged: (value) {
                        companyAddress = value;
                        setState(() {});
                      },
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: QDropdownField(
                            label: "Employee Count",
                            items: employeeOptions,
                            value: employeeCount,
                            onChanged: (value, label) {
                              employeeCount = value;
                              setState(() {});
                            },
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: QDropdownField(
                            label: "Annual Revenue",
                            items: revenueOptions,
                            value: annualRevenue,
                            onChanged: (value, label) {
                              annualRevenue = value;
                              setState(() {});
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Contact Information Section
              Container(
                width: double.infinity,
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
                      "Primary Contact Details",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    QTextField(
                      label: "Contact Title",
                      value: contactTitle,
                      hint: "Job title or position",
                      onChanged: (value) {
                        contactTitle = value;
                        setState(() {});
                      },
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: QTextField(
                            label: "Contact Email",
                            value: contactEmail,
                            hint: "contact@company.com",
                            validator: Validator.email,
                            onChanged: (value) {
                              contactEmail = value;
                              setState(() {});
                            },
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: QTextField(
                            label: "Contact Phone",
                            value: contactPhone,
                            hint: "+1 (555) 123-4567",
                            onChanged: (value) {
                              contactPhone = value;
                              setState(() {});
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Tags Section
              Container(
                width: double.infinity,
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
                      "Tags",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "Select relevant tags for this deal",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Wrap(
                      spacing: spXs,
                      runSpacing: spXs,
                      children: availableTags.map((tag) {
                        bool isSelected = selectedTags.contains(tag);
                        return GestureDetector(
                          onTap: () {
                            if (isSelected) {
                              selectedTags.remove(tag);
                            } else {
                              selectedTags.add(tag);
                            }
                            setState(() {});
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                            decoration: BoxDecoration(
                              color: isSelected ? primaryColor : Colors.white,
                              borderRadius: BorderRadius.circular(radiusSm),
                              border: Border.all(
                                color: isSelected ? primaryColor : disabledOutlineBorderColor,
                              ),
                            ),
                            child: Text(
                              tag,
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: isSelected ? Colors.white : disabledBoldColor,
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),

              // Notes Section
              Container(
                width: double.infinity,
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
                      "Additional Notes",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    QMemoField(
                      label: "Notes",
                      value: notes,
                      hint: "Add any additional information about this deal...",
                      onChanged: (value) {
                        notes = value;
                        setState(() {});
                      },
                    ),
                  ],
                ),
              ),

              // Action Buttons
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: QButton(
                        label: "Save as Draft",
                        size: bs.md,
                        onPressed: () {
                          _saveDraft();
                        },
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: QButton(
                        label: "Create Deal",
                        size: bs.md,
                        onPressed: () {
                          _saveDeal();
                        },
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: spLg),
            ],
          ),
        ),
      ),
    );
  }

  void _saveDraft() {
    ss("Deal saved as draft");
    Navigator.pop(context);
  }

  void _saveDeal() {
    if (formKey.currentState!.validate()) {
      showLoading();
      
      // Simulate API call
      Future.delayed(Duration(seconds: 2), () {
        hideLoading();
        ss("Deal created successfully");
        Navigator.pop(context);
      });
    } else {
      se("Please fill in all required fields");
    }
  }
}
