import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class ReaKycVerificationView extends StatefulWidget {
  const ReaKycVerificationView({super.key});

  @override
  State<ReaKycVerificationView> createState() => _ReaKycVerificationViewState();
}

class _ReaKycVerificationViewState extends State<ReaKycVerificationView> {
  int currentStep = 0;
  bool isIdentityVerified = false;
  bool isIncomeVerified = false;
  bool isAddressVerified = false;
  bool isBankVerified = false;

  List<Map<String, dynamic>> documents = [
    {
      "type": "Government ID",
      "description": "Upload your driver's license or passport",
      "icon": Icons.badge,
      "status": "pending",
      "required": true,
    },
    {
      "type": "Income Proof",
      "description": "Upload salary slips or tax returns",
      "icon": Icons.attach_money,
      "status": "pending",
      "required": true,
    },
    {
      "type": "Address Proof",
      "description": "Upload utility bill or bank statement",
      "icon": Icons.location_on,
      "status": "pending",
      "required": true,
    },
    {
      "type": "Bank Statement",
      "description": "Upload last 3 months bank statements",
      "icon": Icons.account_balance,
      "status": "pending",
      "required": false,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("KYC Verification"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            _buildProgressIndicator(),
            _buildVerificationStatus(),
            _buildDocumentList(),
            _buildInstructionsSection(),
            _buildBenefitsSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildProgressIndicator() {
    int completedSteps = documents.where((doc) => doc["status"] == "verified").length;
    double progress = completedSteps / documents.length;

    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Icon(
                Icons.verified_user,
                color: primaryColor,
                size: 24,
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Text(
                  "Verification Progress",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
              ),
              Text(
                "${(progress * 100).toInt()}%",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          SizedBox(height: spMd),
          Container(
            height: 8,
            decoration: BoxDecoration(
              color: disabledColor,
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: FractionallySizedBox(
              alignment: Alignment.centerLeft,
              widthFactor: progress,
              child: Container(
                decoration: BoxDecoration(
                  color: successColor,
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
              ),
            ),
          ),
          SizedBox(height: spSm),
          Text(
            "$completedSteps of ${documents.length} documents verified",
            style: TextStyle(
              fontSize: 14,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVerificationStatus() {
    bool isFullyVerified = documents.every((doc) => doc["status"] == "verified" || !doc["required"]);
    
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: isFullyVerified ? successColor.withAlpha(20) : warningColor.withAlpha(20),
        borderRadius: BorderRadius.circular(radiusMd),
        border: Border.all(
          color: isFullyVerified ? successColor : warningColor,
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Icon(
            isFullyVerified ? Icons.check_circle : Icons.access_time,
            color: isFullyVerified ? successColor : warningColor,
            size: 24,
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  isFullyVerified ? "Verification Complete" : "Verification in Progress",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: isFullyVerified ? successColor : warningColor,
                  ),
                ),
                SizedBox(height: spXs),
                Text(
                  isFullyVerified 
                    ? "Your account is fully verified. You can now access all features."
                    : "Please complete all required document uploads to verify your account.",
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

  Widget _buildDocumentList() {
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
            "Required Documents",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),
          Column(
            children: documents.map((document) {
              return _buildDocumentItem(document);
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildDocumentItem(Map<String, dynamic> document) {
    Color statusColor = _getStatusColor(document["status"]);
    IconData statusIcon = _getStatusIcon(document["status"]);
    String statusText = _getStatusText(document["status"]);

    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: statusColor.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(
          color: statusColor.withAlpha(30),
          width: 1,
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: primaryColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Icon(
                  document["icon"],
                  color: primaryColor,
                  size: 24,
                ),
              ),
              SizedBox(width: spMd),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          document["type"],
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: primaryColor,
                          ),
                        ),
                        if (document["required"]) ...[
                          SizedBox(width: spXs),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: spXs,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: dangerColor,
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Text(
                              "Required",
                              style: TextStyle(
                                fontSize: 10,
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                    SizedBox(height: spXs),
                    Text(
                      document["description"],
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                children: [
                  Icon(
                    statusIcon,
                    color: statusColor,
                    size: 20,
                  ),
                  SizedBox(height: spXs),
                  Text(
                    statusText,
                    style: TextStyle(
                      fontSize: 12,
                      color: statusColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: spMd),
          Row(
            children: [
              Expanded(
                child: QButton(
                  label: document["status"] == "verified" ? "View Document" : "Upload Document",
                  size: bs.sm,
                  onPressed: () => _handleDocumentAction(document),
                ),
              ),
              if (document["status"] == "verified") ...[
                SizedBox(width: spSm),
                QButton(
                  icon: Icons.refresh,
                  size: bs.sm,
                  onPressed: () => _reuploadDocument(document),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInstructionsSection() {
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
            "Upload Guidelines",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),
          _buildInstructionItem(
            icon: Icons.photo_camera,
            title: "Clear Images",
            description: "Ensure documents are clearly visible and not blurry",
          ),
          _buildInstructionItem(
            icon: Icons.crop_free,
            title: "Full Document",
            description: "Capture the entire document within the frame",
          ),
          _buildInstructionItem(
            icon: Icons.file_upload,
            title: "Supported Formats",
            description: "Upload JPG, PNG, or PDF files (max 5MB)",
          ),
          _buildInstructionItem(
            icon: Icons.security,
            title: "Secure Processing",
            description: "All documents are encrypted and securely processed",
          ),
        ],
      ),
    );
  }

  Widget _buildInstructionItem({
    required IconData icon,
    required String title,
    required String description,
  }) {
    return Container(
      margin: EdgeInsets.only(bottom: spMd),
      child: Row(
        children: [
          Icon(
            icon,
            color: primaryColor,
            size: 20,
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

  Widget _buildBenefitsSection() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: primaryColor.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusMd),
        border: Border.all(
          color: primaryColor.withAlpha(30),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Benefits of Verification",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),
          _buildBenefitItem("Access to premium properties and exclusive listings"),
          _buildBenefitItem("Higher trust score with sellers and agents"),
          _buildBenefitItem("Faster loan pre-approval process"),
          _buildBenefitItem("Priority customer support"),
          _buildBenefitItem("Advanced property analytics and insights"),
        ],
      ),
    );
  }

  Widget _buildBenefitItem(String benefit) {
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      child: Row(
        children: [
          Icon(
            Icons.check_circle,
            color: successColor,
            size: 16,
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Text(
              benefit,
              style: TextStyle(
                fontSize: 14,
                color: primaryColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "verified":
        return successColor;
      case "pending":
        return warningColor;
      case "rejected":
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  IconData _getStatusIcon(String status) {
    switch (status) {
      case "verified":
        return Icons.check_circle;
      case "pending":
        return Icons.access_time;
      case "rejected":
        return Icons.cancel;
      default:
        return Icons.upload_file;
    }
  }

  String _getStatusText(String status) {
    switch (status) {
      case "verified":
        return "Verified";
      case "pending":
        return "Pending";
      case "rejected":
        return "Rejected";
      default:
        return "Upload";
    }
  }

  void _handleDocumentAction(Map<String, dynamic> document) {
    if (document["status"] == "verified") {
      // View document
      si("Viewing ${document["type"]}");
    } else {
      // Upload document
      _uploadDocument(document);
    }
  }

  void _uploadDocument(Map<String, dynamic> document) async {
    showLoading();
    await Future.delayed(Duration(seconds: 2));
    
    setState(() {
      document["status"] = "pending";
    });
    
    hideLoading();
    ss("${document["type"]} uploaded successfully. Verification in progress.");
    
    // Simulate verification process
    await Future.delayed(Duration(seconds: 3));
    setState(() {
      document["status"] = "verified";
    });
    ss("${document["type"]} verified successfully!");
  }

  void _reuploadDocument(Map<String, dynamic> document) async {
    bool isConfirmed = await confirm("Are you sure you want to reupload this document?");
    if (isConfirmed) {
      _uploadDocument(document);
    }
  }
}
