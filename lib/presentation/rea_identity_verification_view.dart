import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class ReaIdentityVerificationView extends StatefulWidget {
  const ReaIdentityVerificationView({super.key});

  @override
  State<ReaIdentityVerificationView> createState() => _ReaIdentityVerificationViewState();
}

class _ReaIdentityVerificationViewState extends State<ReaIdentityVerificationView> {
  String selectedDocumentType = "driver_license";
  String documentNumber = "";
  String issuingAuthority = "";
  String expiryDate = "";
  String documentImage = "";
  String selfieImage = "";
  bool isProcessing = false;
  String verificationStatus = "pending";

  List<Map<String, dynamic>> documentTypes = [
    {
      "value": "driver_license",
      "label": "Driver's License",
      "icon": Icons.credit_card,
      "description": "Valid government-issued driver's license",
    },
    {
      "value": "passport",
      "label": "Passport",
      "icon": Icons.flight_takeoff,
      "description": "Valid passport from any country",
    },
    {
      "value": "national_id",
      "label": "National ID",
      "icon": Icons.badge,
      "description": "Government-issued national identity card",
    },
    {
      "value": "voter_id",
      "label": "Voter ID",
      "icon": Icons.how_to_vote,
      "description": "Valid voter registration card",
    },
  ];

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Identity Verification"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Form(
          key: formKey,
          child: Column(
            spacing: spMd,
            children: [
              _buildStatusCard(),
              _buildDocumentTypeSelection(),
              _buildDocumentForm(),
              _buildDocumentUpload(),
              _buildSelfieUpload(),
              _buildVerificationSteps(),
              _buildSubmitButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatusCard() {
    Color statusColor = _getStatusColor();
    IconData statusIcon = _getStatusIcon();
    String statusText = _getStatusText();

    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: statusColor.withAlpha(20),
        borderRadius: BorderRadius.circular(radiusMd),
        border: Border.all(
          color: statusColor,
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Icon(
            statusIcon,
            color: statusColor,
            size: 24,
          ),
          SizedBox(width: spMd),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Verification Status",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: statusColor,
                  ),
                ),
                SizedBox(height: spXs),
                Text(
                  statusText,
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
    );
  }

  Widget _buildDocumentTypeSelection() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Select Document Type",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),
          Column(
            children: documentTypes.map((docType) {
              return _buildDocumentTypeItem(docType);
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildDocumentTypeItem(Map<String, dynamic> docType) {
    bool isSelected = selectedDocumentType == docType["value"];

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedDocumentType = docType["value"];
        });
      },
      child: Container(
        margin: EdgeInsets.only(bottom: spSm),
        padding: EdgeInsets.all(spMd),
        decoration: BoxDecoration(
          color: isSelected ? primaryColor.withAlpha(20) : Colors.grey.shade50,
          borderRadius: BorderRadius.circular(radiusSm),
          border: Border.all(
            color: isSelected ? primaryColor : disabledOutlineBorderColor,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: isSelected ? primaryColor : disabledColor,
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Icon(
                docType["icon"],
                color: Colors.white,
                size: 20,
              ),
            ),
            SizedBox(width: spMd),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    docType["label"],
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: isSelected ? primaryColor : primaryColor,
                    ),
                  ),
                  SizedBox(height: spXs),
                  Text(
                    docType["description"],
                    style: TextStyle(
                      fontSize: 14,
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ),
            ),
            if (isSelected)
              Icon(
                Icons.check_circle,
                color: primaryColor,
                size: 24,
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildDocumentForm() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Document Details",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),
          QTextField(
            label: "Document Number",
            value: documentNumber,
            hint: "Enter your document number",
            validator: Validator.required,
            onChanged: (value) {
              documentNumber = value;
              setState(() {});
            },
          ),
          SizedBox(height: spMd),
          QTextField(
            label: "Issuing Authority",
            value: issuingAuthority,
            hint: "e.g., State DMV, Passport Office",
            validator: Validator.required,
            onChanged: (value) {
              issuingAuthority = value;
              setState(() {});
            },
          ),
          SizedBox(height: spMd),
          QDatePicker(
            label: "Expiry Date",
            value: expiryDate.isNotEmpty ? DateTime.parse(expiryDate) : DateTime.now(),
            onChanged: (value) {
              expiryDate = value.toString().split(' ')[0];
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
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Upload Document",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),
          GestureDetector(
            onTap: _uploadDocumentImage,
            child: Container(
              height: 200,
              decoration: BoxDecoration(
                color: disabledColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusSm),
                border: Border.all(
                  color: disabledOutlineBorderColor,
                  style: BorderStyle.solid,
                  width: 2,
                ),
              ),
              child: documentImage.isEmpty
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.cloud_upload,
                          size: 48,
                          color: disabledBoldColor,
                        ),
                        SizedBox(height: spSm),
                        Text(
                          "Tap to upload document image",
                          style: TextStyle(
                            fontSize: 16,
                            color: disabledBoldColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "JPG, PNG (max 5MB)",
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    )
                  : ClipRRect(
                      borderRadius: BorderRadius.circular(radiusSm),
                      child: Image.network(
                        documentImage,
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: double.infinity,
                      ),
                    ),
            ),
          ),
          if (documentImage.isNotEmpty) ...[
            SizedBox(height: spSm),
            Row(
              children: [
                Icon(
                  Icons.check_circle,
                  color: successColor,
                  size: 16,
                ),
                SizedBox(width: spXs),
                Text(
                  "Document uploaded successfully",
                  style: TextStyle(
                    fontSize: 14,
                    color: successColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Spacer(),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      documentImage = "";
                    });
                  },
                  child: Text(
                    "Remove",
                    style: TextStyle(
                      fontSize: 14,
                      color: dangerColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildSelfieUpload() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Take Selfie",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spXs),
          Text(
            "Take a clear selfie for identity verification",
            style: TextStyle(
              fontSize: 14,
              color: disabledBoldColor,
            ),
          ),
          SizedBox(height: spMd),
          GestureDetector(
            onTap: _takeSelfie,
            child: Container(
              height: 150,
              decoration: BoxDecoration(
                color: disabledColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusSm),
                border: Border.all(
                  color: disabledOutlineBorderColor,
                  style: BorderStyle.solid,
                  width: 2,
                ),
              ),
              child: selfieImage.isEmpty
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.camera_alt,
                          size: 40,
                          color: disabledBoldColor,
                        ),
                        SizedBox(height: spSm),
                        Text(
                          "Tap to take selfie",
                          style: TextStyle(
                            fontSize: 16,
                            color: disabledBoldColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    )
                  : ClipRRect(
                      borderRadius: BorderRadius.circular(radiusSm),
                      child: Image.network(
                        selfieImage,
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: double.infinity,
                      ),
                    ),
            ),
          ),
          if (selfieImage.isNotEmpty) ...[
            SizedBox(height: spSm),
            Row(
              children: [
                Icon(
                  Icons.check_circle,
                  color: successColor,
                  size: 16,
                ),
                SizedBox(width: spXs),
                Text(
                  "Selfie captured successfully",
                  style: TextStyle(
                    fontSize: 14,
                    color: successColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Spacer(),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      selfieImage = "";
                    });
                  },
                  child: Text(
                    "Retake",
                    style: TextStyle(
                      fontSize: 14,
                      color: primaryColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildVerificationSteps() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: infoColor.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusMd),
        border: Border.all(
          color: infoColor.withAlpha(30),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Verification Process",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),
          _buildStepItem(
            number: 1,
            title: "Document Review",
            description: "Our system automatically verifies document authenticity",
          ),
          _buildStepItem(
            number: 2,
            title: "Identity Matching",
            description: "Your selfie is matched with the document photo",
          ),
          _buildStepItem(
            number: 3,
            title: "Manual Review",
            description: "If needed, our team will manually review your submission",
          ),
          _buildStepItem(
            number: 4,
            title: "Completion",
            description: "You'll receive confirmation once verification is complete",
          ),
        ],
      ),
    );
  }

  Widget _buildStepItem({
    required int number,
    required String title,
    required String description,
  }) {
    return Container(
      margin: EdgeInsets.only(bottom: spMd),
      child: Row(
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: primaryColor,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                "$number",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          SizedBox(width: spMd),
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
                    fontSize: 13,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSubmitButton() {
    bool canSubmit = documentNumber.isNotEmpty && 
                    issuingAuthority.isNotEmpty && 
                    expiryDate.isNotEmpty && 
                    documentImage.isNotEmpty && 
                    selfieImage.isNotEmpty;

    return Column(
      spacing: spSm,
      children: [
        Container(
          width: double.infinity,
          child: QButton(
            label: isProcessing ? "Processing..." : "Submit for Verification",
            onPressed: canSubmit && !isProcessing ? _submitVerification : null,
          ),
        ),
        Text(
          "Processing typically takes 5-10 minutes",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 14,
            color: disabledBoldColor,
          ),
        ),
      ],
    );
  }

  Color _getStatusColor() {
    switch (verificationStatus) {
      case "verified":
        return successColor;
      case "processing":
        return warningColor;
      case "rejected":
        return dangerColor;
      default:
        return infoColor;
    }
  }

  IconData _getStatusIcon() {
    switch (verificationStatus) {
      case "verified":
        return Icons.verified_user;
      case "processing":
        return Icons.hourglass_empty;
      case "rejected":
        return Icons.error;
      default:
        return Icons.info;
    }
  }

  String _getStatusText() {
    switch (verificationStatus) {
      case "verified":
        return "Your identity has been successfully verified";
      case "processing":
        return "Your identity verification is being processed";
      case "rejected":
        return "Identity verification was rejected. Please try again";
      default:
        return "Complete the form below to verify your identity";
    }
  }

  void _uploadDocumentImage() async {
    setState(() {
      documentImage = "https://picsum.photos/400/200?random=1&keyword=document";
    });
    ss("Document image uploaded successfully");
  }

  void _takeSelfie() async {
    setState(() {
      selfieImage = "https://picsum.photos/300/300?random=2&keyword=person";
    });
    ss("Selfie captured successfully");
  }

  void _submitVerification() async {
    if (formKey.currentState!.validate()) {
      setState(() {
        isProcessing = true;
        verificationStatus = "processing";
      });

      showLoading();
      await Future.delayed(Duration(seconds: 3));
      hideLoading();

      setState(() {
        isProcessing = false;
        verificationStatus = "verified";
      });

      ss("Identity verification submitted successfully!");
      
      // Simulate verification completion
      await Future.delayed(Duration(seconds: 2));
      back();
    }
  }
}
