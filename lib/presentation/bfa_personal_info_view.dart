import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class BfaPersonalInfoView extends StatefulWidget {
  const BfaPersonalInfoView({super.key});

  @override
  State<BfaPersonalInfoView> createState() => _BfaPersonalInfoViewState();
}

class _BfaPersonalInfoViewState extends State<BfaPersonalInfoView> {
  final formKey = GlobalKey<FormState>();
  
  String firstName = "John";
  String lastName = "Doe";
  String email = "john.doe@email.com";
  String phoneNumber = "+1 (555) 123-4567";
  DateTime dateOfBirth = DateTime(1988, 5, 15);
  String gender = "Male";
  String maritalStatus = "Single";
  String nationality = "United States";
  String socialSecurityNumber = "***-**-1234";
  String employmentStatus = "Employed";
  String occupation = "Software Engineer";
  String employer = "Tech Solutions Inc.";
  double annualIncome = 85000.0;
  bool marketingEmails = true;
  bool securityAlerts = true;
  bool productUpdates = false;

  List<Map<String, dynamic>> genderOptions = [
    {"label": "Male", "value": "Male"},
    {"label": "Female", "value": "Female"},
    {"label": "Other", "value": "Other"},
    {"label": "Prefer not to say", "value": "Prefer not to say"},
  ];

  List<Map<String, dynamic>> maritalStatusOptions = [
    {"label": "Single", "value": "Single"},
    {"label": "Married", "value": "Married"},
    {"label": "Divorced", "value": "Divorced"},
    {"label": "Widowed", "value": "Widowed"},
  ];

  List<Map<String, dynamic>> nationalityOptions = [
    {"label": "United States", "value": "United States"},
    {"label": "Canada", "value": "Canada"},
    {"label": "United Kingdom", "value": "United Kingdom"},
    {"label": "Australia", "value": "Australia"},
    {"label": "Other", "value": "Other"},
  ];

  List<Map<String, dynamic>> employmentOptions = [
    {"label": "Employed", "value": "Employed"},
    {"label": "Self-Employed", "value": "Self-Employed"},
    {"label": "Unemployed", "value": "Unemployed"},
    {"label": "Retired", "value": "Retired"},
    {"label": "Student", "value": "Student"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Personal Information"),
      ),
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: Column(
            spacing: spMd,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [primaryColor, primaryColor.withAlpha(180)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(radiusLg),
                ),
                child: Column(
                  spacing: spSm,
                  children: [
                    Icon(
                      Icons.person,
                      color: Colors.white,
                      size: 32,
                    ),
                    Text(
                      "Profile Information",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      "Keep your personal information up to date",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white.withAlpha(230),
                      ),
                    ),
                  ],
                ),
              ),

              Text(
                "Basic Information",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                ),
              ),

              Container(
                width: double.infinity,
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusLg),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  spacing: spMd,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: QTextField(
                            label: "First Name",
                            value: firstName,
                            validator: Validator.required,
                            onChanged: (value) {
                              firstName = value;
                              setState(() {});
                            },
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: QTextField(
                            label: "Last Name",
                            value: lastName,
                            validator: Validator.required,
                            onChanged: (value) {
                              lastName = value;
                              setState(() {});
                            },
                          ),
                        ),
                      ],
                    ),

                    QTextField(
                      label: "Email Address",
                      value: email,
                      validator: Validator.email,
                      onChanged: (value) {
                        email = value;
                        setState(() {});
                      },
                    ),

                    QTextField(
                      label: "Phone Number",
                      value: phoneNumber,
                      validator: Validator.required,
                      onChanged: (value) {
                        phoneNumber = value;
                        setState(() {});
                      },
                    ),

                    QDatePicker(
                      label: "Date of Birth",
                      value: dateOfBirth,
                      onChanged: (value) {
                        dateOfBirth = value;
                        setState(() {});
                      },
                    ),

                    Row(
                      children: [
                        Expanded(
                          child: QDropdownField(
                            label: "Gender",
                            items: genderOptions,
                            value: gender,
                            onChanged: (value, label) {
                              gender = value;
                              setState(() {});
                            },
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: QDropdownField(
                            label: "Marital Status",
                            items: maritalStatusOptions,
                            value: maritalStatus,
                            onChanged: (value, label) {
                              maritalStatus = value;
                              setState(() {});
                            },
                          ),
                        ),
                      ],
                    ),

                    QDropdownField(
                      label: "Nationality",
                      items: nationalityOptions,
                      value: nationality,
                      onChanged: (value, label) {
                        nationality = value;
                        setState(() {});
                      },
                    ),
                  ],
                ),
              ),

              Text(
                "Identification",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                ),
              ),

              Container(
                width: double.infinity,
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusLg),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  spacing: spMd,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.security,
                          color: primaryColor,
                          size: 20,
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: QTextField(
                            label: "Social Security Number",
                            value: socialSecurityNumber,
                            hint: "XXX-XX-XXXX",
                            validator: Validator.required,
                            onChanged: (value) {
                              socialSecurityNumber = value;
                              setState(() {});
                            },
                          ),
                        ),
                      ],
                    ),

                    Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: infoColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.info_outline,
                            color: infoColor,
                            size: 16,
                          ),
                          SizedBox(width: spXs),
                          Expanded(
                            child: Text(
                              "Your SSN is encrypted and securely stored. It's required for identity verification and credit monitoring.",
                              style: TextStyle(
                                color: disabledBoldColor,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              Text(
                "Employment Information",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                ),
              ),

              Container(
                width: double.infinity,
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusLg),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  spacing: spMd,
                  children: [
                    QDropdownField(
                      label: "Employment Status",
                      items: employmentOptions,
                      value: employmentStatus,
                      onChanged: (value, label) {
                        employmentStatus = value;
                        setState(() {});
                      },
                    ),

                    if (employmentStatus == "Employed" || employmentStatus == "Self-Employed") ...[
                      QTextField(
                        label: "Occupation",
                        value: occupation,
                        onChanged: (value) {
                          occupation = value;
                          setState(() {});
                        },
                      ),

                      if (employmentStatus == "Employed")
                        QTextField(
                          label: "Employer",
                          value: employer,
                          onChanged: (value) {
                            employer = value;
                            setState(() {});
                          },
                        ),

                      QNumberField(
                        label: "Annual Income (\$)",
                        value: annualIncome.toString(),
                        onChanged: (value) {
                          annualIncome = double.tryParse(value) ?? 0.0;
                          setState(() {});
                        },
                      ),
                    ],
                  ],
                ),
              ),

              Text(
                "Communication Preferences",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                ),
              ),

              Container(
                width: double.infinity,
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
                          "label": "Marketing Emails",
                          "value": true,
                          "checked": marketingEmails,
                        }
                      ],
                      value: marketingEmails ? [{"label": "Marketing Emails", "value": true, "checked": true}] : [],
                      onChanged: (values, ids) {
                        marketingEmails = values.isNotEmpty;
                        setState(() {});
                      },
                    ),

                    QSwitch(
                      items: [
                        {
                          "label": "Security Alerts",
                          "value": true,
                          "checked": securityAlerts,
                        }
                      ],
                      value: securityAlerts ? [{"label": "Security Alerts", "value": true, "checked": true}] : [],
                      onChanged: (values, ids) {
                        securityAlerts = values.isNotEmpty;
                        setState(() {});
                      },
                    ),

                    QSwitch(
                      items: [
                        {
                          "label": "Product Updates",
                          "value": true,
                          "checked": productUpdates,
                        }
                      ],
                      value: productUpdates ? [{"label": "Product Updates", "value": true, "checked": true}] : [],
                      onChanged: (values, ids) {
                        productUpdates = values.isNotEmpty;
                        setState(() {});
                      },
                    ),

                    Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: warningColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.warning_amber,
                            color: warningColor,
                            size: 16,
                          ),
                          SizedBox(width: spXs),
                          Expanded(
                            child: Text(
                              "Security alerts are recommended and cannot be disabled for your account protection.",
                              style: TextStyle(
                                color: disabledBoldColor,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              Container(
                width: double.infinity,
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: successColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusLg),
                  border: Border.all(color: successColor.withAlpha(60)),
                ),
                child: Column(
                  spacing: spSm,
                  children: [
                    Icon(
                      Icons.verified_user,
                      color: successColor,
                      size: 24,
                    ),
                    Text(
                      "Account Verification Status",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: successColor,
                      ),
                    ),
                    Column(
                      spacing: spXs,
                      children: [
                        _buildVerificationItem("Email Verified", true),
                        _buildVerificationItem("Phone Verified", true),
                        _buildVerificationItem("Identity Verified", true),
                        _buildVerificationItem("Bank Account Linked", false),
                      ],
                    ),
                  ],
                ),
              ),

              Container(
                width: double.infinity,
                child: QButton(
                  label: "Save Changes",
                  icon: Icons.save,
                  size: bs.md,
                  onPressed: () async {
                    if (formKey.currentState!.validate()) {
                      showLoading();
                      await Future.delayed(Duration(seconds: 2));
                      hideLoading();
                      ss("Personal information updated successfully!");
                    }
                  },
                ),
              ),

              Row(
                children: [
                  Expanded(
                    child: QButton(
                      label: "Export Data",
                      icon: Icons.download,
                      size: bs.sm,
                      onPressed: () {
                        si("Data export initiated. You'll receive an email shortly.");
                      },
                    ),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: QButton(
                      label: "Delete Account",
                      icon: Icons.delete,
                      size: bs.sm,
                      onPressed: () async {
                        bool isConfirmed = await confirm("Are you sure you want to delete your account? This action cannot be undone.");
                        if (isConfirmed) {
                          sw("Account deletion request submitted. Customer service will contact you within 24 hours.");
                        }
                      },
                    ),
                  ),
                ],
              ),

              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: disabledColor.withAlpha(30),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Column(
                  spacing: spXs,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.lock,
                          color: disabledBoldColor,
                          size: 16,
                        ),
                        SizedBox(width: spXs),
                        Text(
                          "Privacy & Security",
                          style: TextStyle(
                            color: disabledBoldColor,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      "Your personal information is encrypted and protected according to industry standards. We never share your data with third parties without your explicit consent.",
                      style: TextStyle(
                        color: disabledBoldColor,
                        fontSize: 10,
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

  Widget _buildVerificationItem(String label, bool isVerified) {
    return Row(
      children: [
        Icon(
          isVerified ? Icons.check_circle : Icons.radio_button_unchecked,
          color: isVerified ? successColor : disabledBoldColor,
          size: 16,
        ),
        SizedBox(width: spSm),
        Expanded(
          child: Text(
            label,
            style: TextStyle(
              color: disabledBoldColor,
              fontSize: 14,
            ),
          ),
        ),
        if (!isVerified)
          GestureDetector(
            onTap: () {
              si("Verification process initiated for $label");
            },
            child: Text(
              "Verify",
              style: TextStyle(
                color: primaryColor,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
      ],
    );
  }
}
