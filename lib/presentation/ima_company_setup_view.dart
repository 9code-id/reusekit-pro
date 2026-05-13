import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class ImaCompanySetupView extends StatefulWidget {
  const ImaCompanySetupView({super.key});

  @override
  State<ImaCompanySetupView> createState() => _ImaCompanySetupViewState();
}

class _ImaCompanySetupViewState extends State<ImaCompanySetupView> {
  final formKey = GlobalKey<FormState>();
  
  // Company Basic Information
  String companyName = "";
  String companyDescription = "";
  String industry = "";
  String companySize = "";
  String website = "";
  String companyLogo = "";
  
  // Contact Information
  String businessEmail = "";
  String businessPhone = "";
  String businessAddress = "";
  String city = "";
  String state = "";
  String zipCode = "";
  String country = "";
  
  // Tax & Legal Information
  String businessRegistrationNumber = "";
  String taxId = "";
  String businessType = "";
  String fiscalYearStart = "January";
  
  // Integration & Settings
  List<String> selectedIntegrations = [];
  String baseCurrency = "USD";
  String timeZone = "";
  bool enableMultiLocation = false;
  bool enableInventoryTracking = true;
  bool enableFinancialReporting = true;
  
  List<Map<String, dynamic>> industries = [
    {"label": "Technology", "value": "technology"},
    {"label": "Retail", "value": "retail"},
    {"label": "Healthcare", "value": "healthcare"},
    {"label": "Finance", "value": "finance"},
    {"label": "Education", "value": "education"},
    {"label": "Manufacturing", "value": "manufacturing"},
    {"label": "Services", "value": "services"},
    {"label": "Real Estate", "value": "real_estate"},
    {"label": "Food & Beverage", "value": "food_beverage"},
    {"label": "Other", "value": "other"},
  ];

  List<Map<String, dynamic>> companySizes = [
    {"label": "1-10 employees", "value": "1-10"},
    {"label": "11-50 employees", "value": "11-50"},
    {"label": "51-200 employees", "value": "51-200"},
    {"label": "201-500 employees", "value": "201-500"},
    {"label": "500+ employees", "value": "500+"},
  ];

  List<Map<String, dynamic>> businessTypes = [
    {"label": "Sole Proprietorship", "value": "sole_proprietorship"},
    {"label": "Partnership", "value": "partnership"},
    {"label": "LLC", "value": "llc"},
    {"label": "Corporation", "value": "corporation"},
    {"label": "Non-Profit", "value": "non_profit"},
  ];

  List<Map<String, dynamic>> integrations = [
    {
      "label": "QuickBooks",
      "value": "quickbooks",
      "icon": Icons.account_balance,
      "description": "Sync financial data",
    },
    {
      "label": "Shopify",
      "value": "shopify",
      "icon": Icons.store,
      "description": "E-commerce integration",
    },
    {
      "label": "Salesforce",
      "value": "salesforce",
      "icon": Icons.people,
      "description": "CRM integration",
    },
    {
      "label": "Slack",
      "value": "slack",
      "icon": Icons.chat,
      "description": "Team communication",
    },
    {
      "label": "Google Workspace",
      "value": "google_workspace",
      "icon": Icons.work,
      "description": "Office productivity",
    },
    {
      "label": "Microsoft 365",
      "value": "microsoft_365",
      "icon": Icons.business_center,
      "description": "Office suite integration",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Company Setup"),
        actions: [
          GestureDetector(
            onTap: () {
              // navigateTo('HomeView')
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: spMd),
              alignment: Alignment.center,
              child: Text(
                "Skip",
                style: TextStyle(
                  color: disabledBoldColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: spMd,
            children: [
              // Progress Indicator
              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: primaryColor.withAlpha(10),
                  borderRadius: BorderRadius.circular(radiusMd),
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.business,
                          color: primaryColor,
                          size: 24,
                        ),
                        SizedBox(width: spSm),
                        Text(
                          "Step 3 of 3: Company Information",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spSm),
                    Container(
                      height: 6,
                      decoration: BoxDecoration(
                        color: disabledColor,
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: FractionallySizedBox(
                        alignment: Alignment.centerLeft,
                        widthFactor: 1.0,
                        child: Container(
                          decoration: BoxDecoration(
                            color: primaryColor,
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Company Logo Section
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
                      "Company Logo",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Row(
                      children: [
                        Container(
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(
                            color: primaryColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusMd),
                            border: Border.all(color: primaryColor.withAlpha(50)),
                          ),
                          child: companyLogo.isEmpty
                              ? Icon(
                                  Icons.business,
                                  size: 40,
                                  color: primaryColor,
                                )
                              : ClipRRect(
                                  borderRadius: BorderRadius.circular(radiusMd),
                                  child: Image.network(
                                    companyLogo,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                        ),
                        SizedBox(width: spMd),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              QButton(
                                label: "Upload Logo",
                                size: bs.sm,
                                onPressed: () {
                                  // Simulate image selection
                                  companyLogo = "https://picsum.photos/200/200?random=2&keyword=logo";
                                  setState(() {});
                                },
                              ),
                              SizedBox(height: spSm),
                              Text(
                                "Recommended: 200x200px, PNG with transparent background",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Basic Company Information
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
                      "Basic Information",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
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
                    QMemoField(
                      label: "Company Description",
                      value: companyDescription,
                      hint: "Brief description of your company and what you do",
                      onChanged: (value) {
                        companyDescription = value;
                        setState(() {});
                      },
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: QDropdownField(
                            label: "Industry",
                            items: industries,
                            value: industry,
                            validator: Validator.required,
                            onChanged: (value, label) {
                              industry = value;
                              setState(() {});
                            },
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: QDropdownField(
                            label: "Company Size",
                            items: companySizes,
                            value: companySize,
                            validator: Validator.required,
                            onChanged: (value, label) {
                              companySize = value;
                              setState(() {});
                            },
                          ),
                        ),
                      ],
                    ),
                    QTextField(
                      label: "Website",
                      value: website,
                      hint: "https://www.yourcompany.com",
                      onChanged: (value) {
                        website = value;
                        setState(() {});
                      },
                    ),
                  ],
                ),
              ),

              // Contact Information
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
                      "Contact Information",
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
                            label: "Business Email",
                            value: businessEmail,
                            validator: Validator.email,
                            onChanged: (value) {
                              businessEmail = value;
                              setState(() {});
                            },
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: QTextField(
                            label: "Business Phone",
                            value: businessPhone,
                            hint: "+1 (555) 123-4567",
                            onChanged: (value) {
                              businessPhone = value;
                              setState(() {});
                            },
                          ),
                        ),
                      ],
                    ),
                    QTextField(
                      label: "Business Address",
                      value: businessAddress,
                      hint: "123 Main Street",
                      onChanged: (value) {
                        businessAddress = value;
                        setState(() {});
                      },
                    ),
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
                        SizedBox(width: spSm),
                        Expanded(
                          child: QTextField(
                            label: "State/Province",
                            value: state,
                            onChanged: (value) {
                              state = value;
                              setState(() {});
                            },
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: QTextField(
                            label: "ZIP Code",
                            value: zipCode,
                            onChanged: (value) {
                              zipCode = value;
                              setState(() {});
                            },
                          ),
                        ),
                      ],
                    ),
                    QTextField(
                      label: "Country",
                      value: country,
                      onChanged: (value) {
                        country = value;
                        setState(() {});
                      },
                    ),
                  ],
                ),
              ),

              // Tax & Legal Information
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
                      "Tax & Legal Information",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    QDropdownField(
                      label: "Business Type",
                      items: businessTypes,
                      value: businessType,
                      onChanged: (value, label) {
                        businessType = value;
                        setState(() {});
                      },
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: QTextField(
                            label: "Business Registration Number",
                            value: businessRegistrationNumber,
                            hint: "Registration or incorporation number",
                            onChanged: (value) {
                              businessRegistrationNumber = value;
                              setState(() {});
                            },
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: QTextField(
                            label: "Tax ID",
                            value: taxId,
                            hint: "EIN or Tax ID number",
                            onChanged: (value) {
                              taxId = value;
                              setState(() {});
                            },
                          ),
                        ),
                      ],
                    ),
                    QDropdownField(
                      label: "Fiscal Year Start",
                      items: [
                        {"label": "January", "value": "January"},
                        {"label": "February", "value": "February"},
                        {"label": "March", "value": "March"},
                        {"label": "April", "value": "April"},
                        {"label": "May", "value": "May"},
                        {"label": "June", "value": "June"},
                        {"label": "July", "value": "July"},
                        {"label": "August", "value": "August"},
                        {"label": "September", "value": "September"},
                        {"label": "October", "value": "October"},
                        {"label": "November", "value": "November"},
                        {"label": "December", "value": "December"},
                      ],
                      value: fiscalYearStart,
                      onChanged: (value, label) {
                        fiscalYearStart = value;
                        setState(() {});
                      },
                    ),
                  ],
                ),
              ),

              // System Configuration
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
                      "System Configuration",
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
                            label: "Base Currency",
                            items: [
                              {"label": "USD - US Dollar", "value": "USD"},
                              {"label": "EUR - Euro", "value": "EUR"},
                              {"label": "GBP - British Pound", "value": "GBP"},
                              {"label": "CAD - Canadian Dollar", "value": "CAD"},
                              {"label": "AUD - Australian Dollar", "value": "AUD"},
                            ],
                            value: baseCurrency,
                            onChanged: (value, label) {
                              baseCurrency = value;
                              setState(() {});
                            },
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: QTextField(
                            label: "Time Zone",
                            value: timeZone,
                            hint: "PST (UTC-8)",
                            onChanged: (value) {
                              timeZone = value;
                              setState(() {});
                            },
                          ),
                        ),
                      ],
                    ),
                    QSwitch(
                      items: [
                        {
                          "label": "Enable Multi-Location Support",
                          "value": "multi_location",
                          "checked": enableMultiLocation,
                        }
                      ],
                      value: enableMultiLocation ? [{"label": "Enable Multi-Location Support", "value": "multi_location", "checked": true}] : [],
                      onChanged: (values, ids) {
                        enableMultiLocation = values.isNotEmpty;
                        setState(() {});
                      },
                    ),
                    QSwitch(
                      items: [
                        {
                          "label": "Enable Inventory Tracking",
                          "value": "inventory",
                          "checked": enableInventoryTracking,
                        }
                      ],
                      value: enableInventoryTracking ? [{"label": "Enable Inventory Tracking", "value": "inventory", "checked": true}] : [],
                      onChanged: (values, ids) {
                        enableInventoryTracking = values.isNotEmpty;
                        setState(() {});
                      },
                    ),
                    QSwitch(
                      items: [
                        {
                          "label": "Enable Financial Reporting",
                          "value": "financial",
                          "checked": enableFinancialReporting,
                        }
                      ],
                      value: enableFinancialReporting ? [{"label": "Enable Financial Reporting", "value": "financial", "checked": true}] : [],
                      onChanged: (values, ids) {
                        enableFinancialReporting = values.isNotEmpty;
                        setState(() {});
                      },
                    ),
                  ],
                ),
              ),

              // Integration Options
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
                      "Third-Party Integrations (Optional)",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "Select integrations you'd like to set up later",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                    ResponsiveGridView(
                      minItemWidth: 200,
                      children: integrations.map((integration) {
                        bool isSelected = selectedIntegrations.contains(integration["value"]);
                        return GestureDetector(
                          onTap: () {
                            if (isSelected) {
                              selectedIntegrations.remove(integration["value"]);
                            } else {
                              selectedIntegrations.add(integration["value"]);
                            }
                            setState(() {});
                          },
                          child: Container(
                            padding: EdgeInsets.all(spMd),
                            decoration: BoxDecoration(
                              color: isSelected ? primaryColor.withAlpha(10) : Colors.grey.withAlpha(10),
                              borderRadius: BorderRadius.circular(radiusMd),
                              border: Border.all(
                                color: isSelected ? primaryColor : disabledOutlineBorderColor,
                              ),
                            ),
                            child: Column(
                              children: [
                                Container(
                                  width: 50,
                                  height: 50,
                                  decoration: BoxDecoration(
                                    color: isSelected 
                                        ? primaryColor.withAlpha(20) 
                                        : disabledColor.withAlpha(20),
                                    borderRadius: BorderRadius.circular(radiusSm),
                                  ),
                                  child: Icon(
                                    integration["icon"],
                                    color: isSelected ? primaryColor : disabledBoldColor,
                                    size: 24,
                                  ),
                                ),
                                SizedBox(height: spSm),
                                Text(
                                  "${integration["label"]}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: isSelected ? primaryColor : primaryColor,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                Text(
                                  "${integration["description"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                if (isSelected)
                                  Container(
                                    margin: EdgeInsets.only(top: spSm),
                                    child: Icon(
                                      Icons.check_circle,
                                      color: primaryColor,
                                      size: 20,
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),

              SizedBox(height: spLg),

              // Action Buttons
              Container(
                width: double.infinity,
                child: QButton(
                  label: "Complete Setup",
                  size: bs.md,
                  onPressed: () {
                    _completeSetup();
                  },
                ),
              ),

              Container(
                width: double.infinity,
                child: QButton(
                  label: "Save as Draft",
                  size: bs.sm,
                  onPressed: () {
                    _saveDraft();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _completeSetup() {
    if (formKey.currentState!.validate()) {
      if (companyName.isEmpty) {
        se("Please enter your company name");
        return;
      }

      // Complete setup and navigate to main app
      ss("Company setup completed successfully! Welcome to IMA.");
      // navigateTo('HomeView')
    }
  }

  void _saveDraft() {
    ss("Setup saved as draft. You can continue later from your dashboard.");
    // navigateTo('HomeView')
  }
}
