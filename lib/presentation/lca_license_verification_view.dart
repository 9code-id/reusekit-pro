import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class LcaLicenseVerificationView extends StatefulWidget {
  const LcaLicenseVerificationView({Key? key}) : super(key: key);

  @override
  State<LcaLicenseVerificationView> createState() => _LcaLicenseVerificationViewState();
}

class _LcaLicenseVerificationViewState extends State<LcaLicenseVerificationView> {
  String licenseNumber = "";
  String jurisdiction = "";
  String issueDate = "";
  String expirationDate = "";
  String licenseType = "attorney";
  String specializations = "";
  String disciplinaryHistory = "none";
  String verificationMethod = "automatic";
  String uploadedLicense = "";
  String barAssociation = "";
  String additionalCertifications = "";
  
  bool isVerified = false;
  bool isProcessing = false;
  String verificationStatus = "pending";
  String verificationMessage = "";
  
  List<Map<String, dynamic>> licenseTypes = [
    {"label": "Attorney/Lawyer", "value": "attorney"},
    {"label": "Paralegal", "value": "paralegal"},
    {"label": "Legal Assistant", "value": "legal_assistant"},
    {"label": "Notary Public", "value": "notary"},
    {"label": "Legal Consultant", "value": "consultant"},
  ];

  List<Map<String, dynamic>> jurisdictions = [
    {"label": "California", "value": "CA"},
    {"label": "New York", "value": "NY"},
    {"label": "Texas", "value": "TX"},
    {"label": "Florida", "value": "FL"},
    {"label": "Illinois", "value": "IL"},
    {"label": "Pennsylvania", "value": "PA"},
    {"label": "Ohio", "value": "OH"},
    {"label": "Other", "value": "other"},
  ];

  List<Map<String, dynamic>> disciplinaryOptions = [
    {"label": "No disciplinary history", "value": "none"},
    {"label": "Minor sanctions", "value": "minor"},
    {"label": "Suspension (resolved)", "value": "suspension"},
    {"label": "Other (explain below)", "value": "other"},
  ];

  List<Map<String, dynamic>> verificationMethods = [
    {"label": "Automatic Verification", "value": "automatic"},
    {"label": "Manual Review", "value": "manual"},
    {"label": "Document Upload Only", "value": "upload"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("License Verification"),
        actions: [
          IconButton(
            icon: Icon(Icons.help),
            onPressed: () => _showHelpDialog(),
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
            if (isVerified) _buildVerificationSuccess(),
            if (!isVerified) ...[
              _buildVerificationForm(),
              SizedBox(height: spLg),
              _buildDocumentUpload(),
              SizedBox(height: spLg),
              _buildAdditionalInfo(),
            ],
            SizedBox(height: spLg),
            _buildVerificationStatus(),
            SizedBox(height: spLg),
            _buildActionButtons(),
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
                child: Icon(Icons.verified_user, color: primaryColor, size: 24),
              ),
              SizedBox(width: spMd),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Professional License Verification",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "Legal Case Assistant Compliance",
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
            "Verify your professional license to access the Legal Case Assistant platform. We use secure, encrypted verification systems that comply with bar association requirements.",
            style: TextStyle(
              fontSize: 14,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVerificationSuccess() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: successColor.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusLg),
        border: Border.all(color: successColor.withAlpha(50)),
      ),
      child: Column(
        children: [
          Icon(Icons.check_circle, color: successColor, size: 48),
          SizedBox(height: spMd),
          Text(
            "License Verified Successfully",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: successColor,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: spSm),
          Text(
            "Your professional license has been verified and approved. You now have full access to the Legal Case Assistant platform.",
            style: TextStyle(
              fontSize: 14,
              color: disabledBoldColor,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: spMd),
          Container(
            width: double.infinity,
            child: QButton(
              label: "Continue to Dashboard",
              size: bs.md,
              onPressed: () {
                // Navigate to dashboard
                //navigateTo('');
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVerificationForm() {
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
            "License Information",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          QDropdownField(
            label: "License Type",
            items: licenseTypes,
            value: licenseType,
            onChanged: (value, label) {
              licenseType = value;
              setState(() {});
            },
          ),
          QTextField(
            label: "License Number",
            value: licenseNumber,
            hint: "Enter your license number",
            validator: Validator.required,
            onChanged: (value) {
              licenseNumber = value;
              setState(() {});
            },
          ),
          QDropdownField(
            label: "Jurisdiction",
            items: jurisdictions,
            value: jurisdiction,
            onChanged: (value, label) {
              jurisdiction = value;
              setState(() {});
            },
          ),
          Row(
            children: [
              Expanded(
                child: QDatePicker(
                  label: "Issue Date",
                  value: issueDate.isNotEmpty ? DateTime.parse(issueDate) : DateTime.now(),
                  onChanged: (value) {
                    issueDate = value.toString();
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QDatePicker(
                  label: "Expiration Date",
                  value: expirationDate.isNotEmpty ? DateTime.parse(expirationDate) : DateTime.now().add(Duration(days: 365)),
                  onChanged: (value) {
                    expirationDate = value.toString();
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
          QTextField(
            label: "Bar Association",
            value: barAssociation,
            hint: "State bar association name",
            onChanged: (value) {
              barAssociation = value;
              setState(() {});
            },
          ),
          QMemoField(
            label: "Specializations",
            value: specializations,
            hint: "List your areas of specialization (e.g., Corporate Law, Criminal Defense)",
            onChanged: (value) {
              specializations = value;
              setState(() {});
            },
          ),
          QDropdownField(
            label: "Disciplinary History",
            items: disciplinaryOptions,
            value: disciplinaryHistory,
            onChanged: (value, label) {
              disciplinaryHistory = value;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  Widget _buildDocumentUpload() {
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
            "Document Verification",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          QDropdownField(
            label: "Verification Method",
            items: verificationMethods,
            value: verificationMethod,
            onChanged: (value, label) {
              verificationMethod = value;
              setState(() {});
            },
          ),
          if (verificationMethod != "automatic") ...[
            QImagePicker(
              label: "License Document",
              value: uploadedLicense,
              hint: "Upload a clear photo of your license",
              validator: Validator.required,
              onChanged: (value) {
                uploadedLicense = value;
                setState(() {});
              },
            ),
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: infoColor.withAlpha(10),
                borderRadius: BorderRadius.circular(radiusMd),
                border: Border.all(color: infoColor.withAlpha(50)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.info, color: infoColor, size: 16),
                      SizedBox(width: spSm),
                      Text(
                        "Document Requirements",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: infoColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "• Clear, high-resolution image\n• All text must be readable\n• No shadows or glare\n• Full document visible\n• Valid, non-expired license",
                    style: TextStyle(
                      fontSize: 11,
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ),
            ),
          ],
          if (verificationMethod == "automatic") ...[
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: successColor.withAlpha(10),
                borderRadius: BorderRadius.circular(radiusMd),
                border: Border.all(color: successColor.withAlpha(50)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.auto_awesome, color: successColor, size: 20),
                      SizedBox(width: spSm),
                      Text(
                        "Automatic Verification",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: successColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "We'll automatically verify your license with the appropriate bar association. This process usually takes 1-2 business days and provides the most reliable verification.",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildAdditionalInfo() {
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
            "Additional Information",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          QMemoField(
            label: "Additional Certifications",
            value: additionalCertifications,
            hint: "List any additional legal certifications or qualifications",
            onChanged: (value) {
              additionalCertifications = value;
              setState(() {});
            },
          ),
          _buildPrivacyNotice(),
        ],
      ),
    );
  }

  Widget _buildPrivacyNotice() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: warningColor.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusMd),
        border: Border.all(color: warningColor.withAlpha(50)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.privacy_tip, color: warningColor, size: 20),
              SizedBox(width: spSm),
              Text(
                "Privacy & Security Notice",
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
            "• Your license information is encrypted and stored securely\n• We only verify with official bar associations\n• Information is used solely for platform access verification\n• You can update or remove your data at any time\n• Full compliance with legal data protection requirements",
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVerificationStatus() {
    Color statusColor;
    IconData statusIcon;
    String statusText;
    
    switch (verificationStatus) {
      case "pending":
        statusColor = warningColor;
        statusIcon = Icons.pending;
        statusText = "Verification Pending";
        break;
      case "processing":
        statusColor = infoColor;
        statusIcon = Icons.hourglass_empty;
        statusText = "Processing Verification";
        break;
      case "verified":
        statusColor = successColor;
        statusIcon = Icons.verified;
        statusText = "License Verified";
        break;
      case "failed":
        statusColor = dangerColor;
        statusIcon = Icons.error;
        statusText = "Verification Failed";
        break;
      default:
        statusColor = disabledColor;
        statusIcon = Icons.help;
        statusText = "Status Unknown";
    }

    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: statusColor.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusLg),
        border: Border.all(color: statusColor.withAlpha(50)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: statusColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusLg),
                ),
                child: Icon(statusIcon, color: statusColor, size: 24),
              ),
              SizedBox(width: spMd),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      statusText,
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: statusColor,
                      ),
                    ),
                    if (verificationMessage.isNotEmpty)
                      Text(
                        verificationMessage,
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
          if (verificationStatus == "processing") ...[
            SizedBox(height: spMd),
            LinearProgressIndicator(
              backgroundColor: statusColor.withAlpha(30),
              valueColor: AlwaysStoppedAnimation<Color>(statusColor),
            ),
            SizedBox(height: spSm),
            Text(
              "Estimated completion: 1-2 business days",
              style: TextStyle(
                fontSize: 12,
                color: disabledBoldColor,
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildActionButtons() {
    if (isVerified) {
      return Row(
        children: [
          Expanded(
            child: QButton(
              label: "View Certificate",
              size: bs.md,
              onPressed: () => _viewCertificate(),
            ),
          ),
          SizedBox(width: spSm),
          Expanded(
            child: QButton(
              label: "Continue",
              size: bs.md,
              onPressed: () {
                // Navigate to next step
                //navigateTo('');
              },
            ),
          ),
        ],
      );
    }

    return Row(
      children: [
        Expanded(
          child: QButton(
            label: "Save Draft",
            size: bs.md,
            onPressed: () => _saveDraft(),
          ),
        ),
        SizedBox(width: spSm),
        Expanded(
          child: QButton(
            label: isProcessing ? "Processing..." : "Submit for Verification",
            size: bs.md,
            onPressed: isProcessing ? null : () => _submitVerification(),
          ),
        ),
      ],
    );
  }

  void _submitVerification() {
    if (licenseNumber.isEmpty || jurisdiction.isEmpty) {
      se("Please fill in all required license information");
      return;
    }

    if (verificationMethod != "automatic" && uploadedLicense.isEmpty) {
      se("Please upload your license document");
      return;
    }

    setState(() {
      isProcessing = true;
      verificationStatus = "processing";
      verificationMessage = "Contacting bar association for verification...";
    });

    showLoading();
    
    // Simulate verification process
    Future.delayed(Duration(seconds: 3), () {
      hideLoading();
      
      setState(() {
        isProcessing = false;
        
        // Simulate random verification result
        if (licenseNumber == "12345") {
          verificationStatus = "verified";
          isVerified = true;
          verificationMessage = "License verified with California State Bar";
          ss("License verification successful!");
        } else {
          verificationStatus = "failed";
          verificationMessage = "Unable to verify license. Please check your information or contact support.";
          se("Verification failed. Please review your information.");
        }
      });
    });
  }

  void _saveDraft() {
    ss("Draft saved successfully");
  }

  void _viewCertificate() {
    si("Opening verification certificate");
    // Show certificate or navigate to certificate view
  }

  void _showHelpDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Verification Help"),
        content: Text(
          "If you're having trouble with verification:\n\n"
          "• Ensure your license is current and active\n"
          "• Double-check all information matches your official records\n"
          "• For automatic verification, allow 1-2 business days\n"
          "• Contact support if you continue to have issues\n\n"
          "Email: support@legalcaseassistant.com\n"
          "Phone: 1-800-LCA-HELP"
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Close"),
          ),
        ],
      ),
    );
  }
}
