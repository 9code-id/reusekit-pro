import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlRegister7View extends StatefulWidget {
  @override
  State<GrlRegister7View> createState() => _GrlRegister7ViewState();
}

class _GrlRegister7ViewState extends State<GrlRegister7View> {
  final formKey = GlobalKey<FormState>();
  
  String organizationName = "";
  String organizationType = "";
  String missionStatement = "";
  String contactPerson = "";
  String organizationEmail = "";
  String organizationPhone = "";
  String website = "";
  String address = "";
  String taxExemptNumber = "";
  String registrationNumber = "";
  String bankAccount = "";
  String organizationLogo = "";
  List<String> organizationDocuments = [];
  List<String> causeCategories = [];
  String targetAudience = "";
  bool isRegisteredNonProfit = false;
  bool acceptDonations = false;
  bool volunteerProgram = false;
  bool isLoading = false;

  List<Map<String, dynamic>> organizationTypes = [
    {"label": "Non-Profit Organization", "value": "nonprofit"},
    {"label": "Charitable Foundation", "value": "foundation"},
    {"label": "Community Group", "value": "community"},
    {"label": "Religious Organization", "value": "religious"},
    {"label": "Educational Institution", "value": "educational"},
    {"label": "Health Organization", "value": "health"},
    {"label": "Environmental Group", "value": "environmental"},
    {"label": "Social Service Organization", "value": "social"},
  ];

  List<Map<String, dynamic>> causes = [
    {"label": "Education", "value": "education", "checked": false},
    {"label": "Healthcare", "value": "healthcare", "checked": false},
    {"label": "Environment", "value": "environment", "checked": false},
    {"label": "Poverty Alleviation", "value": "poverty", "checked": false},
    {"label": "Children & Youth", "value": "children", "checked": false},
    {"label": "Elderly Care", "value": "elderly", "checked": false},
    {"label": "Animal Welfare", "value": "animals", "checked": false},
    {"label": "Human Rights", "value": "rights", "checked": false},
    {"label": "Disaster Relief", "value": "disaster", "checked": false},
    {"label": "Community Development", "value": "community", "checked": false},
    {"label": "Arts & Culture", "value": "arts", "checked": false},
    {"label": "Technology Access", "value": "technology", "checked": false},
  ];

  List<Map<String, dynamic>> targetAudiences = [
    {"label": "General Public", "value": "general"},
    {"label": "Children (0-12)", "value": "children"},
    {"label": "Teenagers (13-19)", "value": "teens"},
    {"label": "Young Adults (20-35)", "value": "young_adults"},
    {"label": "Adults (36-65)", "value": "adults"},
    {"label": "Seniors (65+)", "value": "seniors"},
    {"label": "Families", "value": "families"},
    {"label": "Low-Income Communities", "value": "low_income"},
  ];

  Future<void> _submitOrganizationRegistration() async {
    if (!formKey.currentState!.validate()) return;
    
    if (causeCategories.isEmpty) {
      se("Please select at least one cause category");
      return;
    }
    
    isLoading = true;
    setState(() {});
    
    await Future.delayed(Duration(seconds: 3));
    
    isLoading = false;
    setState(() {});
    
    ss("Organization registration submitted successfully! Your application is under review.");
    //navigateTo('GrlOrganizationDashboardView')
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
                "Submitting organization registration...",
                style: TextStyle(
                  fontSize: 16,
                  color: primaryColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: spSm),
              Text(
                "Processing your application",
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
        title: Text("Organization Registration"),
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
                      Icons.groups,
                      size: 64,
                      color: primaryColor,
                    ),
                    Text(
                      "Register Your Organization",
                      style: TextStyle(
                        fontSize: fsH3,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "Join our network of organizations making a difference. Connect with volunteers, donors, and partner organizations to amplify your impact.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: disabledBoldColor,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),

              // Organization Information
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
                        Icon(Icons.account_balance, color: primaryColor, size: 24),
                        SizedBox(width: spSm),
                        Text(
                          "Organization Information",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                    
                    QImagePicker(
                      label: "Organization Logo",
                      value: organizationLogo,
                      hint: "Upload your organization's logo",
                      onChanged: (value) {
                        organizationLogo = value;
                        setState(() {});
                      },
                    ),
                    
                    QTextField(
                      label: "Organization Name",
                      value: organizationName,
                      hint: "Enter your organization's official name",
                      validator: Validator.required,
                      onChanged: (value) {
                        organizationName = value;
                        setState(() {});
                      },
                    ),
                    
                    QDropdownField(
                      label: "Organization Type",
                      items: organizationTypes,
                      value: organizationType,
                      onChanged: (value, label) {
                        organizationType = value;
                        setState(() {});
                      },
                    ),
                    
                    QMemoField(
                      label: "Mission Statement",
                      value: missionStatement,
                      hint: "Describe your organization's mission and goals...",
                      validator: Validator.required,
                      onChanged: (value) {
                        missionStatement = value;
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
                      label: "Primary Contact Person",
                      value: contactPerson,
                      hint: "Name of primary contact person",
                      validator: Validator.required,
                      onChanged: (value) {
                        contactPerson = value;
                        setState(() {});
                      },
                    ),
                    
                    Row(
                      spacing: spSm,
                      children: [
                        Expanded(
                          child: QTextField(
                            label: "Organization Email",
                            value: organizationEmail,
                            hint: "Official email address",
                            validator: Validator.email,
                            onChanged: (value) {
                              organizationEmail = value;
                              setState(() {});
                            },
                          ),
                        ),
                        Expanded(
                          child: QTextField(
                            label: "Phone Number",
                            value: organizationPhone,
                            hint: "Contact phone number",
                            validator: Validator.required,
                            onChanged: (value) {
                              organizationPhone = value;
                              setState(() {});
                            },
                          ),
                        ),
                      ],
                    ),
                    
                    QTextField(
                      label: "Website (Optional)",
                      value: website,
                      hint: "https://www.yourorganization.org",
                      onChanged: (value) {
                        website = value;
                        setState(() {});
                      },
                    ),
                    
                    QTextField(
                      label: "Organization Address",
                      value: address,
                      hint: "Complete address of your organization",
                      validator: Validator.required,
                      onChanged: (value) {
                        address = value;
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
                      label: "Registration Number",
                      value: registrationNumber,
                      hint: "Official registration number",
                      validator: Validator.required,
                      onChanged: (value) {
                        registrationNumber = value;
                        setState(() {});
                      },
                    ),
                    
                    QTextField(
                      label: "Tax Exempt Number (if applicable)",
                      value: taxExemptNumber,
                      hint: "Tax exemption number",
                      onChanged: (value) {
                        taxExemptNumber = value;
                        setState(() {});
                      },
                    ),
                    
                    QTextField(
                      label: "Bank Account (for donations)",
                      value: bankAccount,
                      hint: "Bank account details for receiving donations",
                      onChanged: (value) {
                        bankAccount = value;
                        setState(() {});
                      },
                    ),
                    
                    QMultiImagePicker(
                      label: "Legal Documents",
                      value: organizationDocuments,
                      hint: "Upload registration certificates, tax documents, etc.",
                      validator: (files) {
                        if (files == null || files.isEmpty) {
                          return "Please upload at least one legal document";
                        }
                        return null;
                      },
                      onChanged: (value) {
                        organizationDocuments = value;
                        setState(() {});
                      },
                    ),
                  ],
                ),
              ),

              // Cause Categories
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
                        Icon(Icons.favorite, color: primaryColor, size: 24),
                        SizedBox(width: spSm),
                        Text(
                          "Cause Categories",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                    
                    Text(
                      "Select the cause categories that align with your organization's mission",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                    
                    QSwitch(
                      items: causes,
                      value: causes.where((item) => item["checked"] == true).toList(),
                      onChanged: (values, ids) {
                        causeCategories = values.map((item) => item["value"].toString()).toList();
                        for (var cause in causes) {
                          cause["checked"] = values.any((v) => v["value"] == cause["value"]);
                        }
                        setState(() {});
                      },
                    ),
                  ],
                ),
              ),

              // Target Audience
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
                        Icon(Icons.group, color: primaryColor, size: 24),
                        SizedBox(width: spSm),
                        Text(
                          "Target Audience",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                    
                    QDropdownField(
                      label: "Primary Target Audience",
                      items: targetAudiences,
                      value: targetAudience,
                      onChanged: (value, label) {
                        targetAudience = value;
                        setState(() {});
                      },
                    ),
                  ],
                ),
              ),

              // Programs and Services
              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusLg),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  spacing: spMd,
                  children: [
                    QSwitch(
                      items: [
                        {
                          "label": "We are a registered non-profit organization with legal status",
                          "value": true,
                          "checked": isRegisteredNonProfit,
                        }
                      ],
                      value: [if (isRegisteredNonProfit) {"label": "We are a registered non-profit organization with legal status", "value": true, "checked": true}],
                      onChanged: (values, ids) {
                        isRegisteredNonProfit = values.isNotEmpty;
                        setState(() {});
                      },
                    ),
                    
                    QSwitch(
                      items: [
                        {
                          "label": "We accept donations from individuals and organizations",
                          "value": true,
                          "checked": acceptDonations,
                        }
                      ],
                      value: [if (acceptDonations) {"label": "We accept donations from individuals and organizations", "value": true, "checked": true}],
                      onChanged: (values, ids) {
                        acceptDonations = values.isNotEmpty;
                        setState(() {});
                      },
                    ),
                    
                    QSwitch(
                      items: [
                        {
                          "label": "We have volunteer programs and opportunities",
                          "value": true,
                          "checked": volunteerProgram,
                        }
                      ],
                      value: [if (volunteerProgram) {"label": "We have volunteer programs and opportunities", "value": true, "checked": true}],
                      onChanged: (values, ids) {
                        volunteerProgram = values.isNotEmpty;
                        setState(() {});
                      },
                    ),
                  ],
                ),
              ),

              // Organization Benefits
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
                            "Verified organization profile with trust badge",
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
                            "Access to volunteer and donor networks",
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
                            "Fundraising and donation management tools",
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
                            "Event promotion and volunteer coordination",
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
                            "Impact tracking and reporting features",
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
                            "Verification Process",
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
                      "Your organization will be reviewed by our verification team within 3-5 business days. We may contact you for additional information if needed.",
                      style: TextStyle(
                        fontSize: 12,
                        color: warningColor,
                      ),
                    ),
                  ],
                ),
              ),

              // Submit Button
              Container(
                width: double.infinity,
                child: QButton(
                  label: "Submit Organization Registration",
                  size: bs.md,
                  onPressed: _submitOrganizationRegistration,
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
                            "Need Assistance?",
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
                      "If you need help with the registration process or have questions about our organization program, contact us at organizations@company.com",
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
