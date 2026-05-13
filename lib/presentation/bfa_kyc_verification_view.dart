import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class BfaKycVerificationView extends StatefulWidget {
  const BfaKycVerificationView({super.key});

  @override
  State<BfaKycVerificationView> createState() => _BfaKycVerificationViewState();
}

class _BfaKycVerificationViewState extends State<BfaKycVerificationView> {
  int currentStep = 0;
  bool loading = false;

  List<Map<String, dynamic>> kycSteps = [
    {
      "title": "Personal Details",
      "description": "Verify your personal information",
      "icon": Icons.person,
      "status": "completed", // completed, current, pending
      "color": successColor,
    },
    {
      "title": "Document Upload",
      "description": "Upload required documents",
      "icon": Icons.upload_file,
      "status": "current",
      "color": primaryColor,
    },
    {
      "title": "Identity Verification",
      "description": "Verify your identity documents",
      "icon": Icons.verified_user,
      "status": "pending",
      "color": disabledColor,
    },
    {
      "title": "Final Review",
      "description": "Review and submit for approval",
      "icon": Icons.check_circle,
      "status": "pending",
      "color": disabledColor,
    },
  ];

  List<Map<String, dynamic>> documents = [
    {
      "name": "Aadhar Card",
      "description": "Government issued identity proof",
      "icon": Icons.credit_card,
      "required": true,
      "uploaded": false,
      "status": "pending", // pending, uploaded, verified, rejected
    },
    {
      "name": "PAN Card",
      "description": "Permanent Account Number card",
      "icon": Icons.credit_card,
      "required": true,
      "uploaded": false,
      "status": "pending",
    },
    {
      "name": "Bank Statement",
      "description": "Last 3 months bank statement",
      "icon": Icons.description,
      "required": true,
      "uploaded": false,
      "status": "pending",
    },
    {
      "name": "Salary Slip",
      "description": "Latest salary slip or ITR",
      "icon": Icons.receipt,
      "required": false,
      "uploaded": false,
      "status": "pending",
    },
  ];

  List<Map<String, dynamic>> verificationChecks = [
    {
      "title": "Document Quality Check",
      "description": "Ensuring documents are clear and readable",
      "status": "pending", // pending, processing, completed, failed
      "icon": Icons.image_search,
    },
    {
      "title": "Information Verification",
      "description": "Matching details across documents",
      "status": "pending",
      "icon": Icons.fact_check,
    },
    {
      "title": "Database Verification",
      "description": "Validating against government databases",
      "status": "pending",
      "icon": Icons.cloud_sync,
    },
    {
      "title": "Final Approval",
      "description": "Manual review by our team",
      "status": "pending",
      "icon": Icons.approval,
    },
  ];

  Future<void> _uploadDocument(int index) async {
    loading = true;
    setState(() {});

    await Future.delayed(Duration(seconds: 2));

    documents[index]["uploaded"] = true;
    documents[index]["status"] = "uploaded";

    loading = false;
    setState(() {});

    ss("${documents[index]["name"]} uploaded successfully");

    // Check if all required documents are uploaded
    bool allRequiredUploaded = documents
        .where((doc) => doc["required"] as bool)
        .every((doc) => doc["uploaded"] as bool);

    if (allRequiredUploaded && currentStep == 1) {
      currentStep = 2;
      setState(() {});
    }
  }

  Future<void> _startVerification() async {
    loading = true;
    setState(() {});

    // Simulate verification process
    for (int i = 0; i < verificationChecks.length; i++) {
      await Future.delayed(Duration(seconds: 2));
      verificationChecks[i]["status"] = "processing";
      setState(() {});
      
      await Future.delayed(Duration(seconds: 2));
      verificationChecks[i]["status"] = "completed";
      setState(() {});
    }

    loading = false;
    currentStep = 3;
    setState(() {});

    ss("KYC verification completed successfully");
  }

  Future<void> _submitKyc() async {
    loading = true;
    setState(() {});

    await Future.delayed(Duration(seconds: 3));

    loading = false;
    setState(() {});

    ss("KYC submitted for final approval. You will be notified within 24-48 hours.");
    // navigateTo(BfaHomeView());
  }

  Widget _buildStepIndicator() {
    return Container(
      padding: EdgeInsets.all(spLg),
      child: Column(
        children: List.generate(kycSteps.length, (index) {
          final step = kycSteps[index];
          bool isActive = index <= currentStep;
          bool isCurrent = index == currentStep;

          return Container(
            margin: EdgeInsets.only(bottom: index < kycSteps.length - 1 ? spMd : 0),
            child: Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: step["color"] as Color,
                    shape: BoxShape.circle,
                    border: isCurrent ? Border.all(color: primaryColor, width: 3) : null,
                  ),
                  child: Icon(
                    step["icon"] as IconData,
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
                        "${step["title"]}",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: isActive ? primaryColor : disabledBoldColor,
                        ),
                      ),
                      Text(
                        "${step["description"]}",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ),

                Container(
                  padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                  decoration: BoxDecoration(
                    color: (step["color"] as Color).withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusXs),
                  ),
                  child: Text(
                    "${step["status"]}".toUpperCase(),
                    style: TextStyle(
                      fontSize: 10,
                      color: step["color"] as Color,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }

  Widget _buildDocumentUpload() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Document Upload",
          style: TextStyle(
            fontSize: fsH5,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        SizedBox(height: spMd),
        Text(
          "Upload clear and readable images of your documents",
          style: TextStyle(
            fontSize: 14,
            color: disabledBoldColor,
          ),
        ),
        SizedBox(height: spXl),

        ...documents.map((doc) {
          bool isUploaded = doc["uploaded"] as bool;
          bool isRequired = doc["required"] as bool;
          
          return Container(
            margin: EdgeInsets.only(bottom: spMd),
            child: Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: isUploaded ? successColor.withAlpha(10) : Colors.white,
                border: Border.all(
                  color: isUploaded ? successColor : disabledOutlineBorderColor,
                ),
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: isUploaded ? [shadowSm] : [],
              ),
              child: Row(
                children: [
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: isUploaded ? successColor : primaryColor,
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Icon(
                      isUploaded ? Icons.check_circle : (doc["icon"] as IconData),
                      color: Colors.white,
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
                            Expanded(
                              child: Text(
                                "${doc["name"]}",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: primaryColor,
                                ),
                              ),
                            ),
                            if (isRequired)
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                decoration: BoxDecoration(
                                  color: dangerColor.withAlpha(20),
                                  borderRadius: BorderRadius.circular(radiusXxs),
                                ),
                                child: Text(
                                  "REQUIRED",
                                  style: TextStyle(
                                    fontSize: 8,
                                    color: dangerColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                          ],
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "${doc["description"]}",
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(width: spMd),

                  QButton(
                    label: isUploaded ? "Uploaded" : "Upload",
                    size: bs.sm,
                    color: isUploaded ? successColor : primaryColor,
                    onPressed: isUploaded ? null : () => _uploadDocument(documents.indexOf(doc)),
                  ),
                ],
              ),
            ),
          );
        }).toList(),

        SizedBox(height: spXl),

        Container(
          padding: EdgeInsets.all(spMd),
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
                  Icon(
                    Icons.info,
                    color: infoColor,
                    size: 20,
                  ),
                  SizedBox(width: spSm),
                  Text(
                    "Document Guidelines",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: infoColor,
                    ),
                  ),
                ],
              ),
              SizedBox(height: spMd),
              Text(
                "• Ensure documents are clear and all text is readable\n"
                "• Upload original documents (not photocopies)\n"
                "• File size should be less than 5MB\n"
                "• Supported formats: JPG, PNG, PDF\n"
                "• Avoid glare and shadows in photos",
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

  Widget _buildVerificationProcess() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Identity Verification",
          style: TextStyle(
            fontSize: fsH5,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        SizedBox(height: spMd),
        Text(
          "We are verifying your documents. This process may take a few minutes.",
          style: TextStyle(
            fontSize: 14,
            color: disabledBoldColor,
          ),
        ),
        SizedBox(height: spXl),

        ...verificationChecks.map((check) {
          String status = check["status"] as String;
          Color statusColor = status == "completed" 
              ? successColor 
              : status == "processing" 
                  ? warningColor 
                  : status == "failed" 
                      ? dangerColor 
                      : disabledColor;

          IconData statusIcon = status == "completed" 
              ? Icons.check_circle 
              : status == "processing" 
                  ? Icons.sync 
                  : status == "failed" 
                      ? Icons.error 
                      : Icons.pending;

          return Container(
            margin: EdgeInsets.only(bottom: spMd),
            child: Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: statusColor.withAlpha(10),
                border: Border.all(color: statusColor.withAlpha(50)),
                borderRadius: BorderRadius.circular(radiusMd),
              ),
              child: Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: statusColor,
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Icon(
                      check["icon"] as IconData,
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
                          "${check["title"]}",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "${check["description"]}",
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),

                  Icon(
                    statusIcon,
                    color: statusColor,
                    size: 24,
                  ),
                ],
              ),
            ),
          );
        }).toList(),

        SizedBox(height: spXl),

        if (!loading && verificationChecks.every((check) => check["status"] == "pending"))
          Container(
            width: double.infinity,
            child: QButton(
              label: "Start Verification",
              size: bs.md,
              onPressed: _startVerification,
            ),
          ),

        if (loading)
          Center(
            child: Column(
              children: [
                CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
                ),
                SizedBox(height: spLg),
                Text(
                  "Verifying your documents...",
                  style: TextStyle(
                    fontSize: 16,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }

  Widget _buildFinalReview() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Final Review",
          style: TextStyle(
            fontSize: fsH5,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        SizedBox(height: spMd),
        Text(
          "Review your information before final submission",
          style: TextStyle(
            fontSize: 14,
            color: disabledBoldColor,
          ),
        ),
        SizedBox(height: spXl),

        Container(
          padding: EdgeInsets.all(spLg),
          decoration: BoxDecoration(
            color: successColor.withAlpha(10),
            borderRadius: BorderRadius.circular(radiusMd),
            border: Border.all(color: successColor.withAlpha(50)),
          ),
          child: Column(
            children: [
              Icon(
                Icons.verified_user,
                size: 60,
                color: successColor,
              ),
              SizedBox(height: spMd),
              Text(
                "Verification Complete!",
                style: TextStyle(
                  fontSize: fsH4,
                  fontWeight: FontWeight.bold,
                  color: successColor,
                ),
              ),
              SizedBox(height: spSm),
              Text(
                "Your documents have been successfully verified. You can now submit your KYC for final approval.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
        ),

        SizedBox(height: spXl),

        Container(
          width: double.infinity,
          child: QButton(
            label: loading ? "Submitting..." : "Submit KYC",
            size: bs.md,
            onPressed: loading ? null : _submitKyc,
          ),
        ),

        SizedBox(height: spXl),

        Container(
          padding: EdgeInsets.all(spMd),
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
                  Icon(
                    Icons.schedule,
                    color: infoColor,
                    size: 20,
                  ),
                  SizedBox(width: spSm),
                  Text(
                    "What happens next?",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: infoColor,
                    ),
                  ),
                ],
              ),
              SizedBox(height: spMd),
              Text(
                "• Your KYC will be reviewed by our compliance team\n"
                "• You will receive updates via SMS and email\n"
                "• Approval typically takes 24-48 hours\n"
                "• You can start using basic banking features immediately\n"
                "• Full features will be unlocked after approval",
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("KYC Verification"),
      ),
      body: Column(
        children: [
          // Step Indicator
          _buildStepIndicator(),

          Divider(),

          // Content
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(spLg),
              child: Column(
                children: [
                  if (currentStep == 1) _buildDocumentUpload(),
                  if (currentStep == 2) _buildVerificationProcess(),
                  if (currentStep == 3) _buildFinalReview(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
