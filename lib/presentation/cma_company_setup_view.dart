import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class CmaCompanySetupView extends StatefulWidget {
  const CmaCompanySetupView({super.key});

  @override
  State<CmaCompanySetupView> createState() => _CmaCompanySetupViewState();
}

class _CmaCompanySetupViewState extends State<CmaCompanySetupView> {
  final formKey = GlobalKey<FormState>();
  String companyLogo = "";
  String companyName = "";
  String companyDescription = "";
  String registrationNumber = "";
  String taxNumber = "";
  String website = "";
  String email = "";
  String phoneNumber = "";
  String address = "";
  String city = "";
  String state = "";
  String postalCode = "";
  String country = "";
  
  String selectedCompanyType = "Construction Company";
  String selectedCompanySize = "1-10 employees";
  List<String> selectedServices = [];
  List<String> certifications = [];
  
  bool hasInsurance = false;
  bool isLicensed = false;
  bool acceptTerms = false;

  List<Map<String, dynamic>> companyTypeItems = [
    {"label": "Construction Company", "value": "Construction Company"},
    {"label": "Contracting Firm", "value": "Contracting Firm"},
    {"label": "Architecture Studio", "value": "Architecture Studio"},
    {"label": "Engineering Consultancy", "value": "Engineering Consultancy"},
    {"label": "Project Management Firm", "value": "Project Management Firm"},
    {"label": "Specialty Contractor", "value": "Specialty Contractor"},
    {"label": "Material Supplier", "value": "Material Supplier"},
  ];

  List<Map<String, dynamic>> companySizeItems = [
    {"label": "1-10 employees", "value": "1-10 employees"},
    {"label": "11-50 employees", "value": "11-50 employees"},
    {"label": "51-200 employees", "value": "51-200 employees"},
    {"label": "201-500 employees", "value": "201-500 employees"},
    {"label": "500+ employees", "value": "500+ employees"},
  ];

  List<Map<String, dynamic>> serviceItems = [
    {"label": "Residential Construction", "value": "residential", "checked": false},
    {"label": "Commercial Construction", "value": "commercial", "checked": false},
    {"label": "Industrial Construction", "value": "industrial", "checked": false},
    {"label": "Civil Engineering", "value": "civil", "checked": false},
    {"label": "Renovation & Remodeling", "value": "renovation", "checked": false},
    {"label": "Project Management", "value": "project_mgmt", "checked": false},
    {"label": "Consulting Services", "value": "consulting", "checked": false},
    {"label": "Material Supply", "value": "material_supply", "checked": false},
  ];

  void _addCertification() {
    String certification = "";
    // In a real app, this would open a dialog or new page
    ss("Add certification dialog would open here");
  }

  void _saveCompany() async {
    if (!acceptTerms) {
      se("Please accept the terms and conditions to continue");
      return;
    }

    if (formKey.currentState!.validate()) {
      showLoading();
      
      // Simulate company save
      await Future.delayed(Duration(seconds: 3));
      
      hideLoading();
      
      ss("Company setup completed successfully!");
      // ss('Next page'));
    }
  }

  void _skipCompanySetup() async {
    bool isConfirmed = await confirm("Skip company setup? You can add company details later in settings.");
    if (isConfirmed) {
      // ss('Next page'));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Company Setup"),
        actions: [
          GestureDetector(
            onTap: _skipCompanySetup,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
              child: Text(
                "Skip",
                style: TextStyle(
                  fontSize: 14,
                  color: primaryColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: spMd,
            children: [
              // Header
              Center(
                child: Column(
                  children: [
                    Text(
                      "Setup Your Company",
                      style: TextStyle(
                        fontSize: fsH3,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "Add your company information to complete your business profile",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),

              // Company Logo
              Text(
                "Company Branding",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),

              QImagePicker(
                label: "Company Logo",
                value: companyLogo,
                hint: "Upload your company logo",
                onChanged: (value) {
                  companyLogo = value;
                  setState(() {});
                },
              ),

              // Basic Company Information
              Text(
                "Company Information",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),

              QTextField(
                label: "Company Name",
                value: companyName,
                hint: "Enter your company name",
                validator: Validator.required,
                onChanged: (value) {
                  companyName = value;
                  setState(() {});
                },
              ),

              QDropdownField(
                label: "Company Type",
                items: companyTypeItems,
                value: selectedCompanyType,
                validator: Validator.required,
                onChanged: (value, label) {
                  selectedCompanyType = value;
                  setState(() {});
                },
              ),

              QDropdownField(
                label: "Company Size",
                items: companySizeItems,
                value: selectedCompanySize,
                validator: Validator.required,
                onChanged: (value, label) {
                  selectedCompanySize = value;
                  setState(() {});
                },
              ),

              QMemoField(
                label: "Company Description",
                value: companyDescription,
                hint: "Describe your company's mission, expertise, and what sets you apart in the construction industry...",
                validator: Validator.required,
                onChanged: (value) {
                  companyDescription = value;
                  setState(() {});
                },
              ),

              // Legal Information
              Text(
                "Legal Information",
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
                      label: "Registration Number",
                      value: registrationNumber,
                      hint: "Business registration #",
                      validator: Validator.required,
                      onChanged: (value) {
                        registrationNumber = value;
                        setState(() {});
                      },
                    ),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: QTextField(
                      label: "Tax Number",
                      value: taxNumber,
                      hint: "Tax ID number",
                      validator: Validator.required,
                      onChanged: (value) {
                        taxNumber = value;
                        setState(() {});
                      },
                    ),
                  ),
                ],
              ),

              // Contact Information
              Text(
                "Contact Information",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),

              QTextField(
                label: "Company Website",
                value: website,
                hint: "https://yourcompany.com",
                onChanged: (value) {
                  website = value;
                  setState(() {});
                },
              ),

              Row(
                children: [
                  Expanded(
                    child: QTextField(
                      label: "Company Email",
                      value: email,
                      hint: "info@yourcompany.com",
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
                      value: phoneNumber,
                      hint: "Company phone",
                      validator: Validator.required,
                      onChanged: (value) {
                        phoneNumber = value;
                        setState(() {});
                      },
                    ),
                  ),
                ],
              ),

              // Address Information
              Text(
                "Company Address",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),

              QTextField(
                label: "Street Address",
                value: address,
                hint: "Company address",
                validator: Validator.required,
                onChanged: (value) {
                  address = value;
                  setState(() {});
                },
              ),

              Row(
                children: [
                  Expanded(
                    child: QTextField(
                      label: "City",
                      value: city,
                      hint: "City",
                      validator: Validator.required,
                      onChanged: (value) {
                        city = value;
                        setState(() {});
                      },
                    ),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: QTextField(
                      label: "State/Province",
                      value: state,
                      hint: "State",
                      validator: Validator.required,
                      onChanged: (value) {
                        state = value;
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
                      label: "Postal Code",
                      value: postalCode,
                      hint: "Zip/Postal code",
                      validator: Validator.required,
                      onChanged: (value) {
                        postalCode = value;
                        setState(() {});
                      },
                    ),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: QTextField(
                      label: "Country",
                      value: country,
                      hint: "Country",
                      validator: Validator.required,
                      onChanged: (value) {
                        country = value;
                        setState(() {});
                      },
                    ),
                  ),
                ],
              ),

              // Services Offered
              Text(
                "Services Offered",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),

              QSwitch(
                label: "Select the services your company provides",
                items: serviceItems,
                value: selectedServices.map((service) => 
                  serviceItems.firstWhere((item) => item["value"] == service)
                ).toList(),
                onChanged: (values, ids) {
                  selectedServices = values.map((item) => item["value"] as String).toList();
                  setState(() {});
                },
              ),

              // Certifications & Licensing
              Text(
                "Certifications & Licensing",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),

              QSwitch(
                items: [
                  {
                    "label": "Company is properly licensed for construction work",
                    "value": true,
                    "checked": isLicensed,
                  }
                ],
                value: [
                  if (isLicensed)
                    {
                      "label": "Company is properly licensed for construction work",
                      "value": true,
                      "checked": true
                    }
                ],
                onChanged: (values, ids) {
                  setState(() {
                    isLicensed = values.isNotEmpty;
                  });
                },
              ),

              QSwitch(
                items: [
                  {
                    "label": "Company has liability insurance coverage",
                    "value": true,
                    "checked": hasInsurance,
                  }
                ],
                value: [
                  if (hasInsurance)
                    {
                      "label": "Company has liability insurance coverage",
                      "value": true,
                      "checked": true
                    }
                ],
                onChanged: (values, ids) {
                  setState(() {
                    hasInsurance = values.isNotEmpty;
                  });
                },
              ),

              // Add Certifications Button
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  border: Border.all(color: primaryColor),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: InkWell(
                  onTap: _addCertification,
                  borderRadius: BorderRadius.circular(radiusSm),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.add, color: primaryColor, size: 20),
                      SizedBox(width: spSm),
                      Text(
                        "Add Professional Certifications",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Terms and Conditions
              QSwitch(
                items: [
                  {
                    "label": "I accept the Terms of Service and Business Agreement",
                    "value": true,
                    "checked": acceptTerms,
                  }
                ],
                value: [
                  if (acceptTerms)
                    {
                      "label": "I accept the Terms of Service and Business Agreement",
                      "value": true,
                      "checked": true
                    }
                ],
                onChanged: (values, ids) {
                  setState(() {
                    acceptTerms = values.isNotEmpty;
                  });
                },
              ),

              SizedBox(height: spMd),

              // Progress Indicator
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: successColor.withAlpha(10),
                  borderRadius: BorderRadius.circular(radiusXs),
                  border: Border.all(color: successColor.withAlpha(30)),
                ),
                child: Row(
                  children: [
                    Icon(Icons.check_circle, color: successColor, size: 20),
                    SizedBox(width: spSm),
                    Expanded(
                      child: Text(
                        "Final step: After completing company setup, you'll access your CMA Business dashboard.",
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

              // Action Buttons
              Container(
                width: double.infinity,
                child: QButton(
                  label: "Complete Setup & Access Dashboard",
                  size: bs.md,
                  onPressed: _saveCompany,
                ),
              ),

              SizedBox(height: spSm),

              // Skip Button
              Center(
                child: GestureDetector(
                  onTap: _skipCompanySetup,
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 12),
                    child: Text(
                      "Set up company later",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),

              SizedBox(height: spMd),

              // Benefits Info
              Container(
                padding: EdgeInsets.all(spMd),
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
                        Icon(Icons.business, color: infoColor, size: 24),
                        SizedBox(width: spSm),
                        Text(
                          "Company Profile Benefits",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: infoColor,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "• Establish credibility with potential clients\n• Access business networking opportunities\n• Qualify for larger project bids\n• Track company performance and growth\n• Manage team members and permissions",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: spMd),
            ],
          ),
        ),
      ),
    );
  }
}
