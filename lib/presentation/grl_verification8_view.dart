import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlVerification8View extends StatefulWidget {
  @override
  State<GrlVerification8View> createState() => _GrlVerification8ViewState();
}

class _GrlVerification8ViewState extends State<GrlVerification8View> {
  String businessName = "";
  String businessType = "";
  String taxId = "";
  String registrationNumber = "";
  String businessAddress = "";
  String businessPhone = "";
  String businessEmail = "";
  String businessWebsite = "";
  String contactPersonName = "";
  String contactPersonTitle = "";
  String businessLicensePath = "";
  String taxCertificatePath = "";
  String bankStatementPath = "";
  int currentStep = 0;
  bool termsAccepted = false;
  
  final formKey = GlobalKey<FormState>();
  
  List<Map<String, dynamic>> businessTypes = [
    {"label": "Sole Proprietorship", "value": "sole_proprietorship"},
    {"label": "Partnership", "value": "partnership"},
    {"label": "Limited Liability Company (LLC)", "value": "llc"},
    {"label": "Corporation", "value": "corporation"},
    {"label": "Non-Profit Organization", "value": "non_profit"},
    {"label": "Other", "value": "other"},
  ];

  List<String> verificationSteps = [
    "Business Info",
    "Contact Details",
    "Documents",
    "Review & Submit",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Business Verification"),
      ),
      body: Column(
        children: [
          // Progress Indicator
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [shadowSm],
            ),
            child: Column(
              children: [
                Row(
                  children: List.generate(verificationSteps.length, (index) {
                    bool isActive = index <= currentStep;
                    bool isCompleted = index < currentStep;
                    
                    return Expanded(
                      child: Row(
                        children: [
                          Container(
                            width: 30,
                            height: 30,
                            decoration: BoxDecoration(
                              color: isCompleted 
                                  ? successColor 
                                  : isActive 
                                      ? primaryColor 
                                      : disabledColor,
                              borderRadius: BorderRadius.circular(radiusLg),
                            ),
                            child: Center(
                              child: isCompleted
                                  ? Icon(
                                      Icons.check,
                                      color: Colors.white,
                                      size: 16,
                                    )
                                  : Text(
                                      "${index + 1}",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12,
                                      ),
                                    ),
                            ),
                          ),
                          if (index < verificationSteps.length - 1)
                            Expanded(
                              child: Container(
                                height: 2,
                                color: index < currentStep ? successColor : disabledColor,
                              ),
                            ),
                        ],
                      ),
                    );
                  }),
                ),
                SizedBox(height: spMd),
                Text(
                  verificationSteps[currentStep],
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
              ],
            ),
          ),
          
          // Content
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(spMd),
              child: _buildCurrentStep(),
            ),
          ),
          
          // Navigation Buttons
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [shadowSm],
            ),
            child: Row(
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
                if (currentStep > 0) SizedBox(width: spMd),
                Expanded(
                  child: QButton(
                    label: currentStep == verificationSteps.length - 1 ? "Submit" : "Next",
                    size: bs.md,
                    onPressed: _canProceed() ? () async {
                      if (currentStep == verificationSteps.length - 1) {
                        await _submitVerification();
                      } else {
                        currentStep++;
                        setState(() {});
                      }
                    } : null,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCurrentStep() {
    switch (currentStep) {
      case 0:
        return _buildBusinessInfoStep();
      case 1:
        return _buildContactDetailsStep();
      case 2:
        return _buildDocumentsStep();
      case 3:
        return _buildReviewStep();
      default:
        return Container();
    }
  }

  Widget _buildBusinessInfoStep() {
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spLg),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [primaryColor, primaryColor.withAlpha(180)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(radiusLg),
            ),
            child: Column(
              children: [
                Icon(
                  Icons.business,
                  size: 48,
                  color: Colors.white,
                ),
                SizedBox(height: spMd),
                Text(
                  "Business Information",
                  style: TextStyle(
                    fontSize: fsH5,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: spSm),
                Text(
                  "Enter your business details for verification",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white70,
                  ),
                ),
              ],
            ),
          ),
          
          SizedBox(height: spLg),
          
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
          
          SizedBox(height: spMd),
          
          QDropdownField(
            label: "Business Type",
            items: businessTypes,
            value: businessType,
            onChanged: (value, label) {
              businessType = value;
              setState(() {});
            },
          ),
          
          SizedBox(height: spMd),
          
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
          
          SizedBox(height: spMd),
          
          QTextField(
            label: "Business Registration Number",
            value: registrationNumber,
            hint: "Enter registration number",
            validator: Validator.required,
            onChanged: (value) {
              registrationNumber = value;
              setState(() {});
            },
          ),
          
          SizedBox(height: spMd),
          
          QMemoField(
            label: "Business Address",
            value: businessAddress,
            hint: "Enter complete business address",
            validator: Validator.required,
            onChanged: (value) {
              businessAddress = value;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  Widget _buildContactDetailsStep() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(spLg),
          decoration: BoxDecoration(
            color: infoColor.withAlpha(20),
            borderRadius: BorderRadius.circular(radiusLg),
          ),
          child: Column(
            children: [
              Icon(
                Icons.contacts,
                size: 48,
                color: infoColor,
              ),
              SizedBox(height: spMd),
              Text(
                "Contact Information",
                style: TextStyle(
                  fontSize: fsH5,
                  fontWeight: FontWeight.bold,
                  color: infoColor,
                ),
              ),
              SizedBox(height: spSm),
              Text(
                "Provide contact details for your business",
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
        
        Text(
          "Business Contact",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        
        SizedBox(height: spMd),
        
        QTextField(
          label: "Business Phone",
          value: businessPhone,
          hint: "Enter business phone number",
          validator: Validator.required,
          onChanged: (value) {
            businessPhone = value;
            setState(() {});
          },
        ),
        
        SizedBox(height: spMd),
        
        QTextField(
          label: "Business Email",
          value: businessEmail,
          hint: "Enter business email address",
          validator: Validator.email,
          onChanged: (value) {
            businessEmail = value;
            setState(() {});
          },
        ),
        
        SizedBox(height: spMd),
        
        QTextField(
          label: "Business Website",
          value: businessWebsite,
          hint: "Enter website URL (optional)",
          onChanged: (value) {
            businessWebsite = value;
            setState(() {});
          },
        ),
        
        SizedBox(height: spLg),
        
        Text(
          "Primary Contact Person",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        
        SizedBox(height: spMd),
        
        QTextField(
          label: "Contact Person Name",
          value: contactPersonName,
          hint: "Enter full name",
          validator: Validator.required,
          onChanged: (value) {
            contactPersonName = value;
            setState(() {});
          },
        ),
        
        SizedBox(height: spMd),
        
        QTextField(
          label: "Title / Position",
          value: contactPersonTitle,
          hint: "Enter job title",
          validator: Validator.required,
          onChanged: (value) {
            contactPersonTitle = value;
            setState(() {});
          },
        ),
      ],
    );
  }

  Widget _buildDocumentsStep() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(spLg),
          decoration: BoxDecoration(
            color: warningColor.withAlpha(20),
            borderRadius: BorderRadius.circular(radiusLg),
          ),
          child: Column(
            children: [
              Icon(
                Icons.upload_file,
                size: 48,
                color: warningColor,
              ),
              SizedBox(height: spMd),
              Text(
                "Required Documents",
                style: TextStyle(
                  fontSize: fsH5,
                  fontWeight: FontWeight.bold,
                  color: warningColor,
                ),
              ),
              SizedBox(height: spSm),
              Text(
                "Upload official business documents for verification",
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
        
        // Document Requirements
        Container(
          padding: EdgeInsets.all(spMd),
          decoration: BoxDecoration(
            color: infoColor.withAlpha(20),
            borderRadius: BorderRadius.circular(radiusLg),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.info,
                    color: infoColor,
                    size: 20,
                  ),
                  SizedBox(width: spMd),
                  Text(
                    "Document Requirements",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: infoColor,
                    ),
                  ),
                ],
              ),
              SizedBox(height: spSm),
              Text(
                "• Documents must be clear and legible\n• File formats: PDF, JPG, PNG\n• Maximum file size: 10MB\n• Documents should be recent (within 3 months)",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
        ),
        
        SizedBox(height: spMd),
        
        // Business License
        QImagePicker(
          label: "Business License",
          value: businessLicensePath,
          hint: "Upload business license/registration certificate",
          onChanged: (value) {
            businessLicensePath = value;
            setState(() {});
          },
        ),
        
        SizedBox(height: spMd),
        
        // Tax Certificate
        QImagePicker(
          label: "Tax Certificate",
          value: taxCertificatePath,
          hint: "Upload tax registration certificate",
          onChanged: (value) {
            taxCertificatePath = value;
            setState(() {});
          },
        ),
        
        SizedBox(height: spMd),
        
        // Bank Statement
        QImagePicker(
          label: "Bank Statement",
          value: bankStatementPath,
          hint: "Upload recent business bank statement",
          onChanged: (value) {
            bankStatementPath = value;
            setState(() {});
          },
        ),
        
        SizedBox(height: spMd),
        
        // Terms and Conditions
        QSwitch(
          items: [
            {
              "label": "I certify that all information provided is accurate and complete",
              "value": true,
              "checked": termsAccepted,
            }
          ],
          value: [
            if (termsAccepted)
              {"label": "I certify that all information provided is accurate and complete", "value": true, "checked": true}
          ],
          onChanged: (values, ids) {
            termsAccepted = values.isNotEmpty;
            setState(() {});
          },
        ),
      ],
    );
  }

  Widget _buildReviewStep() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(spLg),
          decoration: BoxDecoration(
            color: successColor.withAlpha(20),
            borderRadius: BorderRadius.circular(radiusLg),
          ),
          child: Column(
            children: [
              Icon(
                Icons.check_circle,
                size: 48,
                color: successColor,
              ),
              SizedBox(height: spMd),
              Text(
                "Review & Submit",
                style: TextStyle(
                  fontSize: fsH5,
                  fontWeight: FontWeight.bold,
                  color: successColor,
                ),
              ),
              SizedBox(height: spSm),
              Text(
                "Please review your information before submitting",
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
        
        // Business Information Summary
        _buildSummarySection(
          "Business Information",
          [
            {"label": "Business Name", "value": businessName},
            {"label": "Business Type", "value": businessType.replaceAll("_", " ").toUpperCase()},
            {"label": "Tax ID", "value": taxId},
            {"label": "Registration Number", "value": registrationNumber},
            {"label": "Address", "value": businessAddress},
          ],
          Icons.business,
        ),
        
        SizedBox(height: spMd),
        
        // Contact Information Summary
        _buildSummarySection(
          "Contact Information",
          [
            {"label": "Business Phone", "value": businessPhone},
            {"label": "Business Email", "value": businessEmail},
            {"label": "Website", "value": businessWebsite.isEmpty ? "Not provided" : businessWebsite},
            {"label": "Contact Person", "value": contactPersonName},
            {"label": "Title", "value": contactPersonTitle},
          ],
          Icons.contacts,
        ),
        
        SizedBox(height: spMd),
        
        // Documents Summary
        _buildSummarySection(
          "Documents",
          [
            {"label": "Business License", "value": businessLicensePath.isNotEmpty ? "Uploaded" : "Not uploaded"},
            {"label": "Tax Certificate", "value": taxCertificatePath.isNotEmpty ? "Uploaded" : "Not uploaded"},
            {"label": "Bank Statement", "value": bankStatementPath.isNotEmpty ? "Uploaded" : "Not uploaded"},
          ],
          Icons.upload_file,
        ),
        
        SizedBox(height: spLg),
        
        // Final Agreement
        Container(
          padding: EdgeInsets.all(spMd),
          decoration: BoxDecoration(
            color: warningColor.withAlpha(20),
            borderRadius: BorderRadius.circular(radiusLg),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.warning,
                    color: warningColor,
                    size: 20,
                  ),
                  SizedBox(width: spMd),
                  Text(
                    "Important Notice",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: warningColor,
                    ),
                  ),
                ],
              ),
              SizedBox(height: spSm),
              Text(
                "By submitting this application, you confirm that:\n• All information provided is accurate and complete\n• You have the authority to represent this business\n• You agree to our terms and conditions\n• You understand that false information may result in account suspension",
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

  Widget _buildSummarySection(String title, List<Map<String, String>> items, IconData icon) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(20),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(radiusLg),
                topRight: Radius.circular(radiusLg),
              ),
            ),
            child: Row(
              children: [
                Icon(
                  icon,
                  color: primaryColor,
                  size: 20,
                ),
                SizedBox(width: spMd),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(spMd),
            child: Column(
              children: items.map((item) => Padding(
                padding: EdgeInsets.only(bottom: spSm),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 120,
                      child: Text(
                        "${item["label"]}:",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        "${item["value"]}",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              )).toList(),
            ),
          ),
        ],
      ),
    );
  }

  bool _canProceed() {
    switch (currentStep) {
      case 0:
        return businessName.isNotEmpty && 
               businessType.isNotEmpty && 
               taxId.isNotEmpty && 
               registrationNumber.isNotEmpty && 
               businessAddress.isNotEmpty;
      case 1:
        return businessPhone.isNotEmpty && 
               businessEmail.isNotEmpty && 
               contactPersonName.isNotEmpty && 
               contactPersonTitle.isNotEmpty;
      case 2:
        return businessLicensePath.isNotEmpty && 
               taxCertificatePath.isNotEmpty && 
               bankStatementPath.isNotEmpty && 
               termsAccepted;
      case 3:
        return true;
      default:
        return false;
    }
  }

  Future<void> _submitVerification() async {
    showLoading();
    
    // Simulate API call
    await Future.delayed(Duration(seconds: 3));
    
    hideLoading();
    ss("Business verification submitted successfully!");
    
    // navigateTo(VerificationStatusView());
  }
}
