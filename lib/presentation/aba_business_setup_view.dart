import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class AbaBusinessSetupView extends StatefulWidget {
  const AbaBusinessSetupView({super.key});

  @override
  State<AbaBusinessSetupView> createState() => _AbaBusinessSetupViewState();
}

class _AbaBusinessSetupViewState extends State<AbaBusinessSetupView> {
  final formKey = GlobalKey<FormState>();
  String businessName = "";
  String businessType = "";
  String industry = "";
  String businessAddress = "";
  String city = "";
  String state = "";
  String zipCode = "";
  String country = "";
  String phoneNumber = "";
  String website = "";
  String taxId = "";
  String businessLogo = "";

  List<Map<String, dynamic>> businessTypes = [
    {"label": "Sole Proprietorship", "value": "sole_proprietorship"},
    {"label": "Partnership", "value": "partnership"},
    {"label": "Limited Liability Company (LLC)", "value": "llc"},
    {"label": "Corporation", "value": "corporation"},
    {"label": "S Corporation", "value": "s_corporation"},
    {"label": "Non-Profit Organization", "value": "non_profit"},
  ];

  List<Map<String, dynamic>> industries = [
    {"label": "Retail & E-commerce", "value": "retail"},
    {"label": "Professional Services", "value": "professional_services"},
    {"label": "Technology", "value": "technology"},
    {"label": "Healthcare", "value": "healthcare"},
    {"label": "Manufacturing", "value": "manufacturing"},
    {"label": "Real Estate", "value": "real_estate"},
    {"label": "Food & Beverage", "value": "food_beverage"},
    {"label": "Construction", "value": "construction"},
    {"label": "Education", "value": "education"},
    {"label": "Other", "value": "other"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Business Setup"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: primaryColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusSm),
                border: Border.all(color: primaryColor.withAlpha(100)),
              ),
              child: Column(
                children: [
                  Icon(Icons.business, color: primaryColor, size: 40),
                  SizedBox(height: spSm),
                  Text(
                    "Set Up Your Business",
                    style: TextStyle(
                      fontSize: fsH3,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spXs),
                  Text(
                    "Tell us about your business to customize your accounting experience",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ),
            ),
            
            SizedBox(height: spLg),
            
            // Business Setup Form
            Form(
              key: formKey,
              child: Column(
                spacing: spMd,
                children: [
                  // Business Logo
                  QImagePicker(
                    label: "Business Logo",
                    value: businessLogo,
                    hint: "Upload your business logo (optional)",
                    onChanged: (value) {
                      businessLogo = value;
                      setState(() {});
                    },
                  ),
                  
                  // Business Name
                  QTextField(
                    label: "Business Name",
                    value: businessName,
                    hint: "Enter your business name",
                    validator: Validator.required,
                    onChanged: (value) {
                      businessName = value;
                      setState(() {});
                    },
                  ),
                  
                  // Business Type
                  QDropdownField(
                    label: "Business Type",
                    items: businessTypes,
                    value: businessType,
                    onChanged: (value, label) {
                      businessType = value;
                      setState(() {});
                    },
                  ),
                  
                  // Industry
                  QDropdownField(
                    label: "Industry",
                    items: industries,
                    value: industry,
                    onChanged: (value, label) {
                      industry = value;
                      setState(() {});
                    },
                  ),
                  
                  // Business Address Section
                  Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      border: Border.all(color: disabledOutlineBorderColor),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: spMd,
                      children: [
                        Text(
                          "Business Address",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        
                        QTextField(
                          label: "Street Address",
                          value: businessAddress,
                          hint: "Enter business address",
                          validator: Validator.required,
                          onChanged: (value) {
                            businessAddress = value;
                            setState(() {});
                          },
                        ),
                        
                        Row(
                          children: [
                            Expanded(
                              flex: 2,
                              child: QTextField(
                                label: "City",
                                value: city,
                                hint: "Enter city",
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
                                label: "State",
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
                                label: "ZIP Code",
                                value: zipCode,
                                hint: "12345",
                                validator: Validator.required,
                                onChanged: (value) {
                                  zipCode = value;
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
                      ],
                    ),
                  ),
                  
                  // Contact Information Section
                  Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      border: Border.all(color: disabledOutlineBorderColor),
                      borderRadius: BorderRadius.circular(radiusSm),
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
                        
                        QTextField(
                          label: "Business Phone",
                          value: phoneNumber,
                          hint: "Enter business phone number",
                          validator: Validator.required,
                          onChanged: (value) {
                            phoneNumber = value;
                            setState(() {});
                          },
                        ),
                        
                        QTextField(
                          label: "Website",
                          value: website,
                          hint: "https://www.yourbusiness.com (optional)",
                          onChanged: (value) {
                            website = value;
                            setState(() {});
                          },
                        ),
                      ],
                    ),
                  ),
                  
                  // Tax Information
                  Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      border: Border.all(color: disabledOutlineBorderColor),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: spMd,
                      children: [
                        Text(
                          "Tax Information",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        
                        QTextField(
                          label: "Tax ID / EIN",
                          value: taxId,
                          hint: "Enter Tax ID or EIN (optional)",
                          onChanged: (value) {
                            taxId = value;
                            setState(() {});
                          },
                        ),
                        
                        Container(
                          padding: EdgeInsets.all(spXs),
                          decoration: BoxDecoration(
                            color: infoColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Row(
                            children: [
                              Icon(Icons.info, color: infoColor, size: 16),
                              SizedBox(width: spXs),
                              Expanded(
                                child: Text(
                                  "This information is used for tax reporting and invoicing",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: infoColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            
            SizedBox(height: spLg),
            
            // Continue Button
            Container(
              width: double.infinity,
              child: QButton(
                label: "Continue to Chart of Accounts",
                size: bs.md,
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    ss("Business information saved successfully!");
                    //navigateTo('AbaChartOfAccountsSetupView')
                  }
                },
              ),
            ),
            
            SizedBox(height: spSm),
            
            // Skip Button
            Center(
              child: GestureDetector(
                onTap: () {
                  //navigateTo('AbaHomeView')
                },
                child: Text(
                  "Skip for now",
                  style: TextStyle(
                    fontSize: 16,
                    color: disabledBoldColor,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ),
            
            SizedBox(height: spMd),
          ],
        ),
      ),
    );
  }
}
