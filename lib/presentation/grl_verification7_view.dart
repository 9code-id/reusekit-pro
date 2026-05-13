import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlVerification7View extends StatefulWidget {
  @override
  State<GrlVerification7View> createState() => _GrlVerification7ViewState();
}

class _GrlVerification7ViewState extends State<GrlVerification7View> {
  String selectedDocumentType = "";
  String documentNumber = "";
  String fullName = "";
  String dateOfBirth = "";
  String address = "";
  String nationality = "";
  String frontImagePath = "";
  String backImagePath = "";
  String selfieImagePath = "";
  bool termsAccepted = false;
  int currentStep = 0;
  
  final formKey = GlobalKey<FormState>();
  
  List<Map<String, dynamic>> documentTypes = [
    {
      "title": "Driver's License",
      "description": "Government issued driver's license",
      "icon": Icons.drive_eta,
      "value": "drivers_license",
    },
    {
      "title": "Passport",
      "description": "International passport document",
      "icon": Icons.flight,
      "value": "passport",
    },
    {
      "title": "National ID Card",
      "description": "National identification card",
      "icon": Icons.badge,
      "value": "national_id",
    },
    {
      "title": "Residence Permit",
      "description": "Legal residence permit",
      "icon": Icons.home,
      "value": "residence_permit",
    },
  ];

  List<String> verificationSteps = [
    "Document Type",
    "Personal Info",
    "Upload Documents",
    "Verification",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Identity Verification"),
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
        return _buildDocumentTypeStep();
      case 1:
        return _buildPersonalInfoStep();
      case 2:
        return _buildUploadDocumentsStep();
      case 3:
        return _buildVerificationStep();
      default:
        return Container();
    }
  }

  Widget _buildDocumentTypeStep() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(spLg),
          decoration: BoxDecoration(
            color: primaryColor.withAlpha(20),
            borderRadius: BorderRadius.circular(radiusLg),
          ),
          child: Column(
            children: [
              Icon(
                Icons.description,
                size: 48,
                color: primaryColor,
              ),
              SizedBox(height: spMd),
              Text(
                "Select Document Type",
                style: TextStyle(
                  fontSize: fsH5,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              SizedBox(height: spSm),
              Text(
                "Choose the type of document you want to use for verification",
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
        
        // Document Types
        ...documentTypes.map((docType) => Container(
          margin: EdgeInsets.only(bottom: spMd),
          child: GestureDetector(
            onTap: () {
              selectedDocumentType = docType["value"];
              setState(() {});
            },
            child: Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                border: Border.all(
                  color: selectedDocumentType == docType["value"] 
                      ? primaryColor 
                      : disabledOutlineBorderColor,
                  width: selectedDocumentType == docType["value"] ? 2 : 1,
                ),
                boxShadow: selectedDocumentType == docType["value"] ? [shadowMd] : [shadowSm],
              ),
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(spMd),
                    decoration: BoxDecoration(
                      color: selectedDocumentType == docType["value"] 
                          ? primaryColor 
                          : disabledColor,
                      borderRadius: BorderRadius.circular(radiusLg),
                    ),
                    child: Icon(
                      docType["icon"] as IconData,
                      color: Colors.white,
                      size: 24,
                    ),
                  ),
                  SizedBox(width: spMd),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${docType["title"]}",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: selectedDocumentType == docType["value"] 
                                ? primaryColor 
                                : Colors.black,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "${docType["description"]}",
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 20,
                    height: 20,
                    decoration: BoxDecoration(
                      color: selectedDocumentType == docType["value"] 
                          ? primaryColor 
                          : Colors.transparent,
                      border: Border.all(
                        color: selectedDocumentType == docType["value"] 
                            ? primaryColor 
                            : disabledBoldColor,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(radiusLg),
                    ),
                    child: selectedDocumentType == docType["value"]
                        ? Icon(
                            Icons.check,
                            size: 12,
                            color: Colors.white,
                          )
                        : null,
                  ),
                ],
              ),
            ),
          ),
        )).toList(),
      ],
    );
  }

  Widget _buildPersonalInfoStep() {
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
              color: infoColor.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusLg),
            ),
            child: Column(
              children: [
                Icon(
                  Icons.person,
                  size: 48,
                  color: infoColor,
                ),
                SizedBox(height: spMd),
                Text(
                  "Personal Information",
                  style: TextStyle(
                    fontSize: fsH5,
                    fontWeight: FontWeight.bold,
                    color: infoColor,
                  ),
                ),
                SizedBox(height: spSm),
                Text(
                  "Enter your personal details as shown on your document",
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
          
          QTextField(
            label: "Full Name",
            value: fullName,
            hint: "Enter your full name as on document",
            validator: Validator.required,
            onChanged: (value) {
              fullName = value;
              setState(() {});
            },
          ),
          
          SizedBox(height: spMd),
          
          QTextField(
            label: "Document Number",
            value: documentNumber,
            hint: "Enter document number",
            validator: Validator.required,
            onChanged: (value) {
              documentNumber = value;
              setState(() {});
            },
          ),
          
          SizedBox(height: spMd),
          
          QDatePicker(
            label: "Date of Birth",
            value: dateOfBirth.isNotEmpty ? DateTime.parse(dateOfBirth) : DateTime.now(),
            onChanged: (value) {
              dateOfBirth = value.toIso8601String();
              setState(() {});
            },
          ),
          
          SizedBox(height: spMd),
          
          QTextField(
            label: "Nationality",
            value: nationality,
            hint: "Enter your nationality",
            validator: Validator.required,
            onChanged: (value) {
              nationality = value;
              setState(() {});
            },
          ),
          
          SizedBox(height: spMd),
          
          QMemoField(
            label: "Address",
            value: address,
            hint: "Enter your current address",
            validator: Validator.required,
            onChanged: (value) {
              address = value;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  Widget _buildUploadDocumentsStep() {
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
                Icons.camera_alt,
                size: 48,
                color: warningColor,
              ),
              SizedBox(height: spMd),
              Text(
                "Upload Documents",
                style: TextStyle(
                  fontSize: fsH5,
                  fontWeight: FontWeight.bold,
                  color: warningColor,
                ),
              ),
              SizedBox(height: spSm),
              Text(
                "Please upload clear photos of your document",
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
        
        // Upload Instructions
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
                    "Photo Guidelines",
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
                "• Ensure good lighting\n• Keep documents flat\n• All text must be clearly visible\n• No glare or shadows\n• Use high resolution",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
        ),
        
        SizedBox(height: spMd),
        
        // Document Front
        QImagePicker(
          label: "Document Front Side",
          value: frontImagePath,
          hint: "Upload front side of document",
          onChanged: (value) {
            frontImagePath = value;
            setState(() {});
          },
        ),
        
        SizedBox(height: spMd),
        
        // Document Back (if needed)
        if (selectedDocumentType != "passport") ...[
          QImagePicker(
            label: "Document Back Side",
            value: backImagePath,
            hint: "Upload back side of document",
            onChanged: (value) {
              backImagePath = value;
              setState(() {});
            },
          ),
          
          SizedBox(height: spMd),
        ],
        
        // Selfie with Document
        QImagePicker(
          label: "Selfie with Document",
          value: selfieImagePath,
          hint: "Take a selfie holding your document",
          onChanged: (value) {
            selfieImagePath = value;
            setState(() {});
          },
        ),
        
        SizedBox(height: spMd),
        
        // Terms and Conditions
        QSwitch(
          items: [
            {
              "label": "I agree to the Terms and Conditions",
              "value": true,
              "checked": termsAccepted,
            }
          ],
          value: [
            if (termsAccepted)
              {"label": "I agree to the Terms and Conditions", "value": true, "checked": true}
          ],
          onChanged: (values, ids) {
            termsAccepted = values.isNotEmpty;
            setState(() {});
          },
        ),
      ],
    );
  }

  Widget _buildVerificationStep() {
    return Column(
      children: [
        SizedBox(height: spLg),
        
        // Processing Animation
        Container(
          width: 120,
          height: 120,
          decoration: BoxDecoration(
            color: primaryColor.withAlpha(20),
            borderRadius: BorderRadius.circular(radiusLg),
          ),
          child: Center(
            child: Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: primaryColor,
                borderRadius: BorderRadius.circular(radiusLg),
              ),
              child: Icon(
                Icons.verified_user,
                size: 40,
                color: Colors.white,
              ),
            ),
          ),
        ),
        
        SizedBox(height: spLg),
        
        Text(
          "Verification in Progress",
          style: TextStyle(
            fontSize: fsH4,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        
        SizedBox(height: spMd),
        
        Text(
          "We're reviewing your documents. This process usually takes 1-2 business days.",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 14,
            color: disabledBoldColor,
          ),
        ),
        
        SizedBox(height: spLg),
        
        // Verification Status
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(spMd),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(radiusLg),
            boxShadow: [shadowSm],
          ),
          child: Column(
            children: [
              _buildStatusItem("Document Type", selectedDocumentType.replaceAll("_", " ").toUpperCase(), Icons.description, successColor),
              Divider(height: 1, color: disabledColor),
              _buildStatusItem("Personal Info", "Completed", Icons.person, successColor),
              Divider(height: 1, color: disabledColor),
              _buildStatusItem("Documents", "Uploaded", Icons.camera_alt, successColor),
              Divider(height: 1, color: disabledColor),
              _buildStatusItem("Verification", "In Progress", Icons.hourglass_empty, warningColor),
            ],
          ),
        ),
        
        SizedBox(height: spLg),
        
        // Next Steps
        Container(
          width: double.infinity,
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
                    "What's Next?",
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
                "• We'll review your documents within 1-2 business days\n• You'll receive an email notification once verification is complete\n• If additional information is needed, we'll contact you",
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

  Widget _buildStatusItem(String title, String status, IconData icon, Color color) {
    return Padding(
      padding: EdgeInsets.all(spMd),
      child: Row(
        children: [
          Icon(
            icon,
            color: color,
            size: 20,
          ),
          SizedBox(width: spMd),
          Expanded(
            child: Text(
              title,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Text(
            status,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  bool _canProceed() {
    switch (currentStep) {
      case 0:
        return selectedDocumentType.isNotEmpty;
      case 1:
        return fullName.isNotEmpty && 
               documentNumber.isNotEmpty && 
               dateOfBirth.isNotEmpty && 
               nationality.isNotEmpty && 
               address.isNotEmpty;
      case 2:
        return frontImagePath.isNotEmpty && 
               selfieImagePath.isNotEmpty && 
               termsAccepted &&
               (selectedDocumentType == "passport" || backImagePath.isNotEmpty);
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
    ss("Verification submitted successfully!");
    
    // navigateTo(VerificationStatusView());
  }
}
