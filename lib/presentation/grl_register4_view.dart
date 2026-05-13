import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlRegister4View extends StatefulWidget {
  @override
  State<GrlRegister4View> createState() => _GrlRegister4ViewState();
}

class _GrlRegister4ViewState extends State<GrlRegister4View> {
  final formKey = GlobalKey<FormState>();
  
  String businessName = "";
  String businessType = "";
  String industryType = "";
  String registrationNumber = "";
  String taxId = "";
  String businessAddress = "";
  String businessPhone = "";
  String businessEmail = "";
  String website = "";
  String description = "";
  String businessLicense = "";
  List<String> businessDocuments = [];
  bool agreeToBusinessTerms = false;
  bool isLoading = false;

  List<Map<String, dynamic>> businessTypes = [
    {"label": "Sole Proprietorship", "value": "sole_proprietorship"},
    {"label": "Partnership", "value": "partnership"},
    {"label": "Corporation", "value": "corporation"},
    {"label": "Limited Liability Company (LLC)", "value": "llc"},
    {"label": "Non-Profit Organization", "value": "non_profit"},
    {"label": "Freelancer/Consultant", "value": "freelancer"},
  ];

  List<Map<String, dynamic>> industries = [
    {"label": "Technology", "value": "technology"},
    {"label": "Healthcare", "value": "healthcare"},
    {"label": "Finance", "value": "finance"},
    {"label": "Education", "value": "education"},
    {"label": "Retail", "value": "retail"},
    {"label": "Manufacturing", "value": "manufacturing"},
    {"label": "Real Estate", "value": "real_estate"},
    {"label": "Food & Beverage", "value": "food_beverage"},
    {"label": "Transportation", "value": "transportation"},
    {"label": "Entertainment", "value": "entertainment"},
    {"label": "Consulting", "value": "consulting"},
    {"label": "Other", "value": "other"},
  ];

  Future<void> _submitBusinessRegistration() async {
    if (!formKey.currentState!.validate()) return;
    
    if (!agreeToBusinessTerms) {
      se("Please agree to the business terms and conditions");
      return;
    }
    
    isLoading = true;
    setState(() {});
    
    await Future.delayed(Duration(seconds: 3));
    
    isLoading = false;
    setState(() {});
    
    ss("Business registration submitted successfully! Your application is under review.");
    //navigateTo('GrlBusinessDashboardView')
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(),
              SizedBox(height: spMd),
              Text(
                "Submitting your business registration...",
                style: TextStyle(
                  fontSize: 16,
                  color: primaryColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: spSm),
              Text(
                "This may take a few moments",
                style: TextStyle(
                  fontSize: 14,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Business Registration"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Form(
          key: formKey,
          child: Column(
            spacing: spMd,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header Section
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(spLg),
                decoration: BoxDecoration(
                  color: primaryColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusLg),
                ),
                child: Column(
                  spacing: spSm,
                  children: [
                    Icon(
                      Icons.business,
                      size: 64,
                      color: primaryColor,
                    ),
                    Text(
                      "Register Your Business",
                      style: TextStyle(
                        fontSize: fsH3,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "Join our business network and unlock professional opportunities. Connect with clients, partners, and grow your business.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: disabledBoldColor,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),

              // Business Information
              Container(
                padding: EdgeInsets.all(spLg),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusLg),
                  boxShadow: [shadowMd],
                ),
                child: Column(
                  spacing: spMd,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.business_center, color: primaryColor, size: 24),
                        SizedBox(width: spSm),
                        Text(
                          "Business Information",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                    
                    QTextField(
                      label: "Business Name",
                      value: businessName,
                      hint: "Enter your business or company name",
                      validator: Validator.required,
                      onChanged: (value) {
                        businessName = value;
                        setState(() {});
                      },
                    ),
                    
                    Row(
                      spacing: spSm,
                      children: [
                        Expanded(
                          child: QDropdownField(
                            label: "Business Type",
                            items: businessTypes,
                            value: businessType,
                            onChanged: (value, label) {
                              businessType = value;
                              setState(() {});
                            },
                          ),
                        ),
                        Expanded(
                          child: QDropdownField(
                            label: "Industry",
                            items: industries,
                            value: industryType,
                            onChanged: (value, label) {
                              industryType = value;
                              setState(() {});
                            },
                          ),
                        ),
                      ],
                    ),
                    
                    QMemoField(
                      label: "Business Description",
                      value: description,
                      hint: "Describe your business, services, and what makes you unique...",
                      validator: Validator.required,
                      onChanged: (value) {
                        description = value;
                        setState(() {});
                      },
                    ),
                  ],
                ),
              ),

              // Legal Information
              Container(
                padding: EdgeInsets.all(spLg),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusLg),
                  boxShadow: [shadowMd],
                ),
                child: Column(
                  spacing: spMd,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.gavel, color: primaryColor, size: 24),
                        SizedBox(width: spSm),
                        Text(
                          "Legal Information",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                    
                    QTextField(
                      label: "Business Registration Number",
                      value: registrationNumber,
                      hint: "Enter your business registration number",
                      validator: Validator.required,
                      onChanged: (value) {
                        registrationNumber = value;
                        setState(() {});
                      },
                    ),
                    
                    QTextField(
                      label: "Tax ID / EIN",
                      value: taxId,
                      hint: "Enter your tax identification number",
                      validator: Validator.required,
                      onChanged: (value) {
                        taxId = value;
                        setState(() {});
                      },
                    ),
                    
                    QImagePicker(
                      label: "Business License",
                      value: businessLicense,
                      hint: "Upload your business license document",
                      validator: Validator.required,
                      onChanged: (value) {
                        businessLicense = value;
                        setState(() {});
                      },
                    ),

                    QMultiImagePicker(
                      label: "Additional Documents",
                      value: businessDocuments,
                      hint: "Upload any additional business documents",
                      onChanged: (value) {
                        businessDocuments = value;
                        setState(() {});
                      },
                    ),
                  ],
                ),
              ),

              // Contact Information
              Container(
                padding: EdgeInsets.all(spLg),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusLg),
                  boxShadow: [shadowMd],
                ),
                child: Column(
                  spacing: spMd,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.contact_phone, color: primaryColor, size: 24),
                        SizedBox(width: spSm),
                        Text(
                          "Contact Information",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                    
                    QTextField(
                      label: "Business Address",
                      value: businessAddress,
                      hint: "Enter your business address",
                      validator: Validator.required,
                      onChanged: (value) {
                        businessAddress = value;
                        setState(() {});
                      },
                    ),
                    
                    Row(
                      spacing: spSm,
                      children: [
                        Expanded(
                          child: QTextField(
                            label: "Business Phone",
                            value: businessPhone,
                            hint: "Enter business phone number",
                            validator: Validator.required,
                            onChanged: (value) {
                              businessPhone = value;
                              setState(() {});
                            },
                          ),
                        ),
                        Expanded(
                          child: QTextField(
                            label: "Business Email",
                            value: businessEmail,
                            hint: "Enter business email",
                            validator: Validator.email,
                            onChanged: (value) {
                              businessEmail = value;
                              setState(() {});
                            },
                          ),
                        ),
                      ],
                    ),
                    
                    QTextField(
                      label: "Website (Optional)",
                      value: website,
                      hint: "https://www.yourwebsite.com",
                      onChanged: (value) {
                        website = value;
                        setState(() {});
                      },
                    ),
                  ],
                ),
              ),

              // Verification Notice
              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: warningColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                  border: Border.all(color: warningColor.withAlpha(40)),
                ),
                child: Column(
                  spacing: spSm,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.verified_user, color: warningColor, size: 20),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Text(
                            "Business Verification Process",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: warningColor,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Text(
                      "Your business registration will be reviewed by our team within 2-3 business days. You'll receive an email notification once verified.",
                      style: TextStyle(
                        fontSize: 12,
                        color: warningColor,
                      ),
                    ),
                  ],
                ),
              ),

              // Business Features Preview
              Container(
                padding: EdgeInsets.all(spLg),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusLg),
                  boxShadow: [shadowMd],
                ),
                child: Column(
                  spacing: spMd,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "What You'll Get",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    
                    Row(
                      children: [
                        Icon(Icons.check_circle, color: successColor, size: 20),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Text(
                            "Business profile with verified badge",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                    
                    Row(
                      children: [
                        Icon(Icons.check_circle, color: successColor, size: 20),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Text(
                            "Access to business networking features",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                    
                    Row(
                      children: [
                        Icon(Icons.check_circle, color: successColor, size: 20),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Text(
                            "Lead generation and client management tools",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                    
                    Row(
                      children: [
                        Icon(Icons.check_circle, color: successColor, size: 20),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Text(
                            "Analytics and business insights",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Terms Agreement
              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusLg),
                  boxShadow: [shadowSm],
                ),
                child: QSwitch(
                  items: [
                    {
                      "label": "I agree to the Business Terms and Conditions, Privacy Policy, and verify that all information provided is accurate",
                      "value": true,
                      "checked": agreeToBusinessTerms,
                    }
                  ],
                  value: [if (agreeToBusinessTerms) {"label": "I agree to the Business Terms and Conditions, Privacy Policy, and verify that all information provided is accurate", "value": true, "checked": true}],
                  onChanged: (values, ids) {
                    agreeToBusinessTerms = values.isNotEmpty;
                    setState(() {});
                  },
                ),
              ),

              // Submit Button
              Container(
                width: double.infinity,
                child: QButton(
                  label: "Submit Business Registration",
                  size: bs.md,
                  onPressed: _submitBusinessRegistration,
                ),
              ),

              // Support Information
              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: infoColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                  border: Border.all(color: infoColor.withAlpha(40)),
                ),
                child: Column(
                  spacing: spSm,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.support_agent, color: infoColor, size: 20),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Text(
                            "Need Help?",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: infoColor,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Text(
                      "If you have questions about the registration process, contact our business support team at business@company.com or call 1-800-BUSINESS",
                      style: TextStyle(
                        fontSize: 12,
                        color: infoColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
