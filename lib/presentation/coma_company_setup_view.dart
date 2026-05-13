import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class ComaCompanySetupView extends StatefulWidget {
  const ComaCompanySetupView({super.key});

  @override
  State<ComaCompanySetupView> createState() => _ComaCompanySetupViewState();
}

class _ComaCompanySetupViewState extends State<ComaCompanySetupView> {
  final formKey = GlobalKey<FormState>();
  
  String companyName = "";
  String businessType = "construction";
  String companySize = "1-10";
  String address = "";
  String city = "";
  String state = "";
  String zipCode = "";
  String phone = "";
  String website = "";
  String licenseNumber = "";
  String taxId = "";
  String companyLogo = "";
  bool loading = false;

  List<Map<String, dynamic>> businessTypes = [
    {"label": "General Construction", "value": "construction"},
    {"label": "Residential Construction", "value": "residential"},
    {"label": "Commercial Construction", "value": "commercial"},
    {"label": "Infrastructure", "value": "infrastructure"},
    {"label": "Renovation & Remodeling", "value": "renovation"},
    {"label": "Specialty Contracting", "value": "specialty"},
  ];

  List<Map<String, dynamic>> companySizes = [
    {"label": "1-10 employees", "value": "1-10"},
    {"label": "11-50 employees", "value": "11-50"},
    {"label": "51-200 employees", "value": "51-200"},
    {"label": "201-1000 employees", "value": "201-1000"},
    {"label": "1000+ employees", "value": "1000+"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Company Setup"),
      ),
      body: loading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: EdgeInsets.all(spMd),
              child: Form(
                key: formKey,
                child: Column(
                  spacing: spMd,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header
                    Column(
                      spacing: spSm,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Setup Your Company",
                          style: TextStyle(
                            fontSize: fsH1,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "Complete your company profile to get started with project management",
                          style: TextStyle(
                            fontSize: 16,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),

                    // Company Logo
                    Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(radiusMd),
                        boxShadow: [shadowSm],
                      ),
                      child: Column(
                        spacing: spSm,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
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
                        ],
                      ),
                    ),

                    // Basic Information
                    Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(radiusMd),
                        boxShadow: [shadowSm],
                      ),
                      child: Column(
                        spacing: spSm,
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
                          QTextField(
                            label: "Company Name",
                            value: companyName,
                            validator: Validator.required,
                            onChanged: (value) {
                              companyName = value;
                              setState(() {});
                            },
                          ),
                          QDropdownField(
                            label: "Business Type",
                            items: businessTypes,
                            value: businessType,
                            validator: Validator.required,
                            onChanged: (value, label) {
                              businessType = value;
                              setState(() {});
                            },
                          ),
                          QDropdownField(
                            label: "Company Size",
                            items: companySizes,
                            value: companySize,
                            validator: Validator.required,
                            onChanged: (value, label) {
                              companySize = value;
                              setState(() {});
                            },
                          ),
                        ],
                      ),
                    ),

                    // Address Information
                    Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(radiusMd),
                        boxShadow: [shadowSm],
                      ),
                      child: Column(
                        spacing: spSm,
                        crossAxisAlignment: CrossAxisAlignment.start,
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
                            value: address,
                            validator: Validator.required,
                            onChanged: (value) {
                              address = value;
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
                                  validator: Validator.required,
                                  onChanged: (value) {
                                    state = value;
                                    setState(() {});
                                  },
                                ),
                              ),
                            ],
                          ),
                          QTextField(
                            label: "ZIP Code",
                            value: zipCode,
                            validator: Validator.required,
                            onChanged: (value) {
                              zipCode = value;
                              setState(() {});
                            },
                          ),
                        ],
                      ),
                    ),

                    // Contact Information
                    Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(radiusMd),
                        boxShadow: [shadowSm],
                      ),
                      child: Column(
                        spacing: spSm,
                        crossAxisAlignment: CrossAxisAlignment.start,
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
                            value: phone,
                            validator: Validator.required,
                            onChanged: (value) {
                              phone = value;
                              setState(() {});
                            },
                          ),
                          QTextField(
                            label: "Website (Optional)",
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

                    // Legal Information
                    Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(radiusMd),
                        boxShadow: [shadowSm],
                      ),
                      child: Column(
                        spacing: spSm,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Legal Information",
                            style: TextStyle(
                              fontSize: fsH6,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          QTextField(
                            label: "License Number",
                            value: licenseNumber,
                            validator: Validator.required,
                            hint: "Construction license number",
                            onChanged: (value) {
                              licenseNumber = value;
                              setState(() {});
                            },
                          ),
                          QTextField(
                            label: "Tax ID / EIN",
                            value: taxId,
                            validator: Validator.required,
                            hint: "Federal tax identification number",
                            onChanged: (value) {
                              taxId = value;
                              setState(() {});
                            },
                          ),
                        ],
                      ),
                    ),

                    // Setup Information
                    Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: successColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusMd),
                        border: Border.all(color: successColor.withAlpha(50)),
                      ),
                      child: Column(
                        spacing: spXs,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.check_circle_outline,
                                color: successColor,
                                size: 20,
                              ),
                              SizedBox(width: spSm),
                              Text(
                                "What happens next?",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: successColor,
                                ),
                              ),
                            ],
                          ),
                          Text(
                            "After completing setup, you'll be able to:\n• Create and manage construction projects\n• Invite team members and contractors\n• Track project progress and milestones\n• Generate reports and invoices",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Complete Setup Button
                    Container(
                      width: double.infinity,
                      child: QButton(
                        label: "Complete Company Setup",
                        size: bs.md,
                        onPressed: () async {
                          if (formKey.currentState!.validate()) {
                            loading = true;
                            setState(() {});
                            
                            await Future.delayed(Duration(seconds: 3));
                            
                            loading = false;
                            setState(() {});
                            
                            ss("Company setup completed successfully");
                            // ss('Next page'));
                          }
                        },
                      ),
                    ),

                    // Skip Setup Link
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Want to complete this later? ",
                          style: TextStyle(
                            color: disabledBoldColor,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            // Skip to dashboard
                          },
                          child: Text(
                            "Skip Setup",
                            style: TextStyle(
                              color: primaryColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
