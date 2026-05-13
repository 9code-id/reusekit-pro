import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class LcaFirmSetupView extends StatefulWidget {
  const LcaFirmSetupView({Key? key}) : super(key: key);

  @override
  State<LcaFirmSetupView> createState() => _LcaFirmSetupViewState();
}

class _LcaFirmSetupViewState extends State<LcaFirmSetupView> {
  String firmName = "";
  String firmType = "law_firm";
  String registrationNumber = "";
  String taxId = "";
  String address = "";
  String city = "";
  String state = "";
  String zipCode = "";
  String country = "United States";
  String phone = "";
  String email = "";
  String website = "";
  String practiceAreas = "";
  String foundedYear = "";
  String employeeCount = "1-10";
  String primaryContact = "";
  String contactTitle = "";
  String contactEmail = "";
  String contactPhone = "";
  String firmLogo = "";
  String businessLicense = "";
  String insuranceCert = "";
  
  bool agreeToTerms = false;
  bool agreeToPrivacy = false;
  bool agreeToCompliance = false;
  
  int currentStep = 0;
  final formKey = GlobalKey<FormState>();

  List<Map<String, dynamic>> firmTypes = [
    {"label": "Law Firm", "value": "law_firm"},
    {"label": "Solo Practice", "value": "solo_practice"},
    {"label": "Legal Corporation", "value": "legal_corp"},
    {"label": "Partnership", "value": "partnership"},
    {"label": "Legal Clinic", "value": "legal_clinic"},
  ];

  List<Map<String, dynamic>> employeeCounts = [
    {"label": "1-10 employees", "value": "1-10"},
    {"label": "11-50 employees", "value": "11-50"},
    {"label": "51-200 employees", "value": "51-200"},
    {"label": "200+ employees", "value": "200+"},
  ];

  List<Map<String, dynamic>> countries = [
    {"label": "United States", "value": "United States"},
    {"label": "Canada", "value": "Canada"},
    {"label": "United Kingdom", "value": "United Kingdom"},
    {"label": "Australia", "value": "Australia"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Law Firm Setup"),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () => _saveDraft(),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(),
            SizedBox(height: spLg),
            _buildProgressIndicator(),
            SizedBox(height: spLg),
            _buildCurrentStep(),
            SizedBox(height: spLg),
            _buildNavigationButtons(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: primaryColor.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusLg),
        border: Border.all(color: primaryColor.withAlpha(50)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: primaryColor.withAlpha(30),
                  borderRadius: BorderRadius.circular(radiusMd),
                ),
                child: Icon(Icons.business, color: primaryColor, size: 24),
              ),
              SizedBox(width: spMd),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Legal Case Assistant",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "Law Firm Registration",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: spMd),
          Text(
            "Complete your law firm setup to access the Legal Case Assistant platform. All information is securely encrypted and compliant with legal data protection standards.",
            style: TextStyle(
              fontSize: 14,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProgressIndicator() {
    List<String> stepTitles = ["Basic Info", "Contact", "Documents", "Review"];
    
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Setup Progress",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),
          Row(
            children: List.generate(4, (index) {
              bool isActive = currentStep >= index;
              bool isCurrent = currentStep == index;
              
              return Expanded(
                child: Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 32,
                          height: 32,
                          decoration: BoxDecoration(
                            color: isActive ? primaryColor : disabledColor,
                            borderRadius: BorderRadius.circular(radiusLg),
                            border: isCurrent ? Border.all(color: primaryColor, width: 3) : null,
                          ),
                          child: Center(
                            child: Text(
                              "${index + 1}",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        if (index < 3)
                          Expanded(
                            child: Container(
                              height: 2,
                              color: currentStep > index ? primaryColor : disabledColor,
                            ),
                          ),
                      ],
                    ),
                    SizedBox(height: spXs),
                    Text(
                      stepTitles[index],
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: isCurrent ? FontWeight.bold : FontWeight.normal,
                        color: isActive ? primaryColor : disabledBoldColor,
                      ),
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

  Widget _buildCurrentStep() {
    switch (currentStep) {
      case 0:
        return _buildBasicInfoStep();
      case 1:
        return _buildContactStep();
      case 2:
        return _buildDocumentsStep();
      case 3:
        return _buildReviewStep();
      default:
        return _buildBasicInfoStep();
    }
  }

  Widget _buildBasicInfoStep() {
    return Form(
      key: formKey,
      child: Container(
        padding: EdgeInsets.all(spMd),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(radiusLg),
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
              label: "Law Firm Name",
              value: firmName,
              hint: "Enter your firm's legal name",
              validator: Validator.required,
              onChanged: (value) {
                firmName = value;
                setState(() {});
              },
            ),
            QDropdownField(
              label: "Firm Type",
              items: firmTypes,
              value: firmType,
              onChanged: (value, label) {
                firmType = value;
                setState(() {});
              },
            ),
            Row(
              children: [
                Expanded(
                  child: QTextField(
                    label: "Registration Number",
                    value: registrationNumber,
                    hint: "State bar number",
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
                    label: "Tax ID / EIN",
                    value: taxId,
                    hint: "Federal tax ID",
                    onChanged: (value) {
                      taxId = value;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),
            QTextField(
              label: "Founded Year",
              value: foundedYear,
              hint: "Year firm was established",
              onChanged: (value) {
                foundedYear = value;
                setState(() {});
              },
            ),
            QDropdownField(
              label: "Employee Count",
              items: employeeCounts,
              value: employeeCount,
              onChanged: (value, label) {
                employeeCount = value;
                setState(() {});
              },
            ),
            QMemoField(
              label: "Practice Areas",
              value: practiceAreas,
              hint: "Describe your firm's areas of legal practice",
              onChanged: (value) {
                practiceAreas = value;
                setState(() {});
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContactStep() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
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
          QTextField(
            label: "Business Address",
            value: address,
            hint: "Street address",
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
                  label: "State",
                  value: state,
                  hint: "State/Province",
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
                  hint: "Postal code",
                  validator: Validator.required,
                  onChanged: (value) {
                    zipCode = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QDropdownField(
                  label: "Country",
                  items: countries,
                  value: country,
                  onChanged: (value, label) {
                    country = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
          QTextField(
            label: "Business Phone",
            value: phone,
            hint: "Main office phone number",
            validator: Validator.required,
            onChanged: (value) {
              phone = value;
              setState(() {});
            },
          ),
          QTextField(
            label: "Business Email",
            value: email,
            hint: "Main office email",
            validator: Validator.email,
            onChanged: (value) {
              email = value;
              setState(() {});
            },
          ),
          QTextField(
            label: "Website",
            value: website,
            hint: "Firm website URL",
            onChanged: (value) {
              website = value;
              setState(() {});
            },
          ),
          _buildPrimaryContactSection(),
        ],
      ),
    );
  }

  Widget _buildPrimaryContactSection() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: primaryColor.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusMd),
        border: Border.all(color: primaryColor.withAlpha(50)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          Text(
            "Primary Contact Person",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          QTextField(
            label: "Contact Name",
            value: primaryContact,
            hint: "Managing partner or contact person",
            validator: Validator.required,
            onChanged: (value) {
              primaryContact = value;
              setState(() {});
            },
          ),
          QTextField(
            label: "Contact Title",
            value: contactTitle,
            hint: "Position or title",
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
                  hint: "Direct email",
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
                  hint: "Direct phone",
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
    );
  }

  Widget _buildDocumentsStep() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          Text(
            "Documents & Verification",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          QImagePicker(
            label: "Firm Logo",
            value: firmLogo,
            hint: "Upload your firm's logo",
            onChanged: (value) {
              firmLogo = value;
              setState(() {});
            },
          ),
          QImagePicker(
            label: "Business License",
            value: businessLicense,
            hint: "Upload business license document",
            validator: Validator.required,
            onChanged: (value) {
              businessLicense = value;
              setState(() {});
            },
          ),
          QImagePicker(
            label: "Professional Liability Insurance",
            value: insuranceCert,
            hint: "Upload insurance certificate",
            validator: Validator.required,
            onChanged: (value) {
              insuranceCert = value;
              setState(() {});
            },
          ),
          _buildComplianceSection(),
        ],
      ),
    );
  }

  Widget _buildComplianceSection() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: warningColor.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusMd),
        border: Border.all(color: warningColor.withAlpha(50)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          Row(
            children: [
              Icon(Icons.gavel, color: warningColor, size: 20),
              SizedBox(width: spSm),
              Text(
                "Legal Compliance",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: warningColor,
                ),
              ),
            ],
          ),
          _buildComplianceItem(
            "Terms of Service",
            "I agree to the LCA Terms of Service and understand the platform usage requirements.",
            agreeToTerms,
            (value) => setState(() => agreeToTerms = value),
          ),
          _buildComplianceItem(
            "Privacy Policy",
            "I acknowledge the Privacy Policy and data handling practices for legal information.",
            agreeToPrivacy,
            (value) => setState(() => agreeToPrivacy = value),
          ),
          _buildComplianceItem(
            "Professional Compliance",
            "I certify that this firm meets all professional licensing and ethical requirements.",
            agreeToCompliance,
            (value) => setState(() => agreeToCompliance = value),
          ),
        ],
      ),
    );
  }

  Widget _buildComplianceItem(String title, String description, bool value, Function(bool) onChanged) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Switch(
          value: value,
          onChanged: onChanged,
          activeColor: warningColor,
        ),
        SizedBox(width: spSm),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: primaryColor,
                ),
              ),
              SizedBox(height: spXs),
              Text(
                description,
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
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          Text(
            "Review & Submit",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          _buildReviewSection("Basic Information", [
            "Firm Name: $firmName",
            "Type: ${firmTypes.firstWhere((type) => type['value'] == firmType)['label']}",
            "Registration: $registrationNumber",
            "Founded: $foundedYear",
          ]),
          _buildReviewSection("Contact Details", [
            "Address: $address, $city, $state $zipCode",
            "Phone: $phone",
            "Email: $email",
            "Contact: $primaryContact",
          ]),
          _buildReviewSection("Documents", [
            "Logo: ${firmLogo.isNotEmpty ? 'Uploaded' : 'Not uploaded'}",
            "License: ${businessLicense.isNotEmpty ? 'Uploaded' : 'Not uploaded'}",
            "Insurance: ${insuranceCert.isNotEmpty ? 'Uploaded' : 'Not uploaded'}",
          ]),
          _buildSubmissionStatus(),
        ],
      ),
    );
  }

  Widget _buildReviewSection(String title, List<String> items) {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(radiusMd),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          ...items.map((item) => Padding(
            padding: EdgeInsets.only(bottom: spXs),
            child: Text(
              "• $item",
              style: TextStyle(
                fontSize: 12,
                color: disabledBoldColor,
              ),
            ),
          )),
        ],
      ),
    );
  }

  Widget _buildSubmissionStatus() {
    bool allCompliant = agreeToTerms && agreeToPrivacy && agreeToCompliance;
    bool hasRequiredDocs = businessLicense.isNotEmpty && insuranceCert.isNotEmpty;
    bool canSubmit = allCompliant && hasRequiredDocs && firmName.isNotEmpty;

    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: canSubmit ? successColor.withAlpha(10) : dangerColor.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusMd),
        border: Border.all(
          color: canSubmit ? successColor.withAlpha(50) : dangerColor.withAlpha(50),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                canSubmit ? Icons.check_circle : Icons.warning,
                color: canSubmit ? successColor : dangerColor,
                size: 20,
              ),
              SizedBox(width: spSm),
              Text(
                canSubmit ? "Ready to Submit" : "Missing Requirements",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: canSubmit ? successColor : dangerColor,
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          if (!canSubmit) ...[
            if (!allCompliant)
              Text(
                "• Please agree to all compliance requirements",
                style: TextStyle(fontSize: 12, color: dangerColor),
              ),
            if (!hasRequiredDocs)
              Text(
                "• Upload required documents (License & Insurance)",
                style: TextStyle(fontSize: 12, color: dangerColor),
              ),
            if (firmName.isEmpty)
              Text(
                "• Firm name is required",
                style: TextStyle(fontSize: 12, color: dangerColor),
              ),
          ] else
            Text(
              "Your application will be reviewed within 2-3 business days. You'll receive email confirmation upon approval.",
              style: TextStyle(fontSize: 12, color: successColor),
            ),
        ],
      ),
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
              onPressed: () => _previousStep(),
            ),
          ),
        if (currentStep > 0) SizedBox(width: spSm),
        Expanded(
          child: QButton(
            label: currentStep == 3 ? "Submit Application" : "Next",
            size: bs.md,
            onPressed: () => currentStep == 3 ? _submitApplication() : _nextStep(),
          ),
        ),
      ],
    );
  }

  void _previousStep() {
    if (currentStep > 0) {
      setState(() {
        currentStep--;
      });
    }
  }

  void _nextStep() {
    if (_validateCurrentStep()) {
      setState(() {
        currentStep++;
      });
    }
  }

  bool _validateCurrentStep() {
    switch (currentStep) {
      case 0:
        return firmName.isNotEmpty && registrationNumber.isNotEmpty;
      case 1:
        return address.isNotEmpty && city.isNotEmpty && state.isNotEmpty && 
               phone.isNotEmpty && email.isNotEmpty && primaryContact.isNotEmpty;
      case 2:
        return businessLicense.isNotEmpty && insuranceCert.isNotEmpty && 
               agreeToTerms && agreeToPrivacy && agreeToCompliance;
      default:
        return true;
    }
  }

  void _saveDraft() {
    ss("Draft saved successfully");
  }

  void _submitApplication() {
    if (!_validateCurrentStep()) {
      se("Please complete all required fields");
      return;
    }

    showLoading();
    // Simulate API call
    Future.delayed(Duration(seconds: 3), () {
      hideLoading();
      ss("Application submitted successfully! Check your email for confirmation.");
      // Navigate to success screen
      //navigateTo('');
    });
  }
}
