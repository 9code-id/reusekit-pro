import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';
import 'dart:async';

class GrlOtp8View extends StatefulWidget {
  @override
  State<GrlOtp8View> createState() => _GrlOtp8ViewState();
}

class _GrlOtp8ViewState extends State<GrlOtp8View> {
  String businessName = "Tech Solutions Inc.";
  String businessEmail = "admin@techsolutions.com";
  String businessPhone = "+1 (555) 987-6543";
  String verificationCode = "";
  
  String currentStep = "document_upload";
  bool isVerifying = false;
  bool isApproved = false;
  int reviewTimeHours = 24;

  List<Map<String, dynamic>> documents = [
    {
      "name": "Business Registration Certificate",
      "status": "uploaded",
      "required": true,
      "description": "Official business registration document",
    },
    {
      "name": "Tax Identification Number",
      "status": "uploaded", 
      "required": true,
      "description": "Tax ID or EIN certificate",
    },
    {
      "name": "Business License",
      "status": "pending",
      "required": true,
      "description": "Operating license for your business type",
    },
    {
      "name": "Bank Account Verification",
      "status": "pending",
      "required": false,
      "description": "Business bank account statement",
    },
  ];

  List<Map<String, dynamic>> verificationSteps = [
    {
      "id": "document_upload",
      "title": "Document Upload",
      "description": "Upload required business documents",
      "icon": Icons.upload_file,
      "status": "current",
    },
    {
      "id": "verification_code",
      "title": "Phone Verification",
      "description": "Verify your business phone number",
      "icon": Icons.verified,
      "status": "pending",
    },
    {
      "id": "manual_review",
      "title": "Manual Review",
      "description": "Our team reviews your application",
      "icon": Icons.rate_review,
      "status": "pending",
    },
    {
      "id": "approval",
      "title": "Approval",
      "description": "Get verified business account",
      "icon": Icons.verified_user,
      "status": "pending",
    },
  ];

  @override
  void initState() {
    super.initState();
    _checkDocumentStatus();
  }

  void _checkDocumentStatus() {
    int uploadedCount = documents.where((doc) => doc["status"] == "uploaded").length;
    int requiredCount = documents.where((doc) => doc["required"] == true).length;
    
    if (uploadedCount >= requiredCount) {
      currentStep = "verification_code";
      _updateStepStatuses();
    }
  }

  void _updateStepStatuses() {
    for (int i = 0; i < verificationSteps.length; i++) {
      if (verificationSteps[i]["id"] == currentStep) {
        verificationSteps[i]["status"] = "current";
      } else if (i < verificationSteps.indexWhere((step) => step["id"] == currentStep)) {
        verificationSteps[i]["status"] = "completed";
      } else {
        verificationSteps[i]["status"] = "pending";
      }
    }
    setState(() {});
  }

  void _uploadDocument(int index) {
    documents[index]["status"] = "uploaded";
    setState(() {});
    _checkDocumentStatus();
    si("${documents[index]["name"]} uploaded successfully");
  }

  void _sendVerificationCode() async {
    showLoading();
    await Future.delayed(Duration(seconds: 2));
    hideLoading();
    
    si("Verification code sent to ${businessPhone}");
  }

  void _verifyPhoneCode() async {
    if (verificationCode.length < 6) {
      se("Please enter the complete verification code");
      return;
    }

    isVerifying = true;
    setState(() {});

    await Future.delayed(Duration(seconds: 2));

    isVerifying = false;
    setState(() {});

    if (verificationCode == "123456") {
      currentStep = "manual_review";
      _updateStepStatuses();
      _startReviewProcess();
      ss("Phone number verified successfully!");
    } else {
      se("Invalid verification code. Please try again.");
      verificationCode = "";
      setState(() {});
    }
  }

  void _startReviewProcess() async {
    si("Your application has been submitted for review");
    
    // Simulate review process
    await Future.delayed(Duration(seconds: 5));
    
    currentStep = "approval";
    isApproved = true;
    _updateStepStatuses();
    ss("Congratulations! Your business account has been approved.");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Business Verification"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spLg,
          children: [
            // Business Info Header
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spLg),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    isApproved 
                        ? successColor.withAlpha(15)
                        : primaryColor.withAlpha(15),
                    isApproved 
                        ? successColor.withAlpha(5)
                        : primaryColor.withAlpha(5),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(radiusLg),
                border: Border.all(
                  color: isApproved 
                      ? successColor.withAlpha(30)
                      : primaryColor.withAlpha(30),
                  width: 1,
                ),
              ),
              child: Column(
                spacing: spMd,
                children: [
                  Container(
                    height: 80,
                    width: 80,
                    decoration: BoxDecoration(
                      color: isApproved ? successColor : primaryColor,
                      borderRadius: BorderRadius.circular(radiusXl),
                      boxShadow: [shadowMd],
                    ),
                    child: Icon(
                      isApproved ? Icons.verified_user : Icons.business,
                      size: 40,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    businessName,
                    style: TextStyle(
                      fontSize: fsH4,
                      fontWeight: FontWeight.bold,
                      color: isApproved ? successColor : primaryColor,
                    ),
                  ),
                  Column(
                    spacing: spXs,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.email,
                            size: 16,
                            color: disabledBoldColor,
                          ),
                          SizedBox(width: spXs),
                          Text(
                            businessEmail,
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.phone,
                            size: 16,
                            color: disabledBoldColor,
                          ),
                          SizedBox(width: spXs),
                          Text(
                            businessPhone,
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Verification Steps Progress
            Container(
              width: double.infinity,
              child: Column(
                spacing: spSm,
                children: [
                  Text(
                    "Verification Progress",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  ...verificationSteps.map((step) {
                    String status = step["status"];
                    bool isCurrent = status == "current";
                    bool isCompleted = status == "completed";
                    bool isPending = status == "pending";

                    return Container(
                      padding: EdgeInsets.all(spMd),
                      decoration: BoxDecoration(
                        color: isCompleted 
                            ? successColor.withAlpha(10)
                            : isCurrent 
                                ? primaryColor.withAlpha(10)
                                : Colors.grey[50],
                        borderRadius: BorderRadius.circular(radiusSm),
                        border: Border.all(
                          color: isCompleted 
                              ? successColor.withAlpha(50)
                              : isCurrent 
                                  ? primaryColor.withAlpha(50)
                                  : disabledOutlineBorderColor,
                          width: 1,
                        ),
                      ),
                      child: Row(
                        children: [
                          Container(
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                              color: isCompleted 
                                  ? successColor 
                                  : isCurrent 
                                      ? primaryColor 
                                      : disabledColor,
                              borderRadius: BorderRadius.circular(radiusLg),
                            ),
                            child: Icon(
                              isCompleted 
                                  ? Icons.check 
                                  : step["icon"],
                              size: 20,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(width: spMd),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  step["title"],
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: isCompleted 
                                        ? successColor 
                                        : isCurrent 
                                            ? primaryColor 
                                            : disabledBoldColor,
                                  ),
                                ),
                                Text(
                                  step["description"],
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          if (isCurrent && isVerifying)
                            Container(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
                              ),
                            ),
                        ],
                      ),
                    );
                  }).toList(),
                ],
              ),
            ),

            // Document Upload Section
            if (currentStep == "document_upload")
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(spLg),
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
                          Icons.upload_file,
                          size: 20,
                          color: primaryColor,
                        ),
                        SizedBox(width: spXs),
                        Text(
                          "Required Documents",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                    ...documents.map((doc) {
                      bool isUploaded = doc["status"] == "uploaded";
                      bool isRequired = doc["required"];
                      
                      return Container(
                        padding: EdgeInsets.all(spMd),
                        decoration: BoxDecoration(
                          color: isUploaded 
                              ? successColor.withAlpha(10)
                              : Colors.grey[50],
                          borderRadius: BorderRadius.circular(radiusSm),
                          border: Border.all(
                            color: isUploaded 
                                ? successColor.withAlpha(50)
                                : disabledOutlineBorderColor,
                            width: 1,
                          ),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              isUploaded ? Icons.check_circle : Icons.description,
                              size: 24,
                              color: isUploaded ? successColor : disabledBoldColor,
                            ),
                            SizedBox(width: spMd),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        doc["name"],
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          color: primaryColor,
                                        ),
                                      ),
                                      if (isRequired)
                                        Container(
                                          margin: EdgeInsets.only(left: spXs),
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
                                  ),
                                  Text(
                                    doc["description"],
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            if (!isUploaded)
                              QButton(
                                label: "Upload",
                                size: bs.sm,
                                onPressed: () => _uploadDocument(documents.indexOf(doc)),
                              ),
                          ],
                        ),
                      );
                    }).toList(),
                  ],
                ),
              ),

            // Phone Verification Section
            if (currentStep == "verification_code")
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(spLg),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusLg),
                  boxShadow: [shadowMd],
                ),
                child: Column(
                  spacing: spMd,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.verified,
                          size: 20,
                          color: primaryColor,
                        ),
                        SizedBox(width: spXs),
                        Text(
                          "Phone Verification",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                    Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: primaryColor.withAlpha(10),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.info_outline,
                            size: 16,
                            color: primaryColor,
                          ),
                          SizedBox(width: spXs),
                          Expanded(
                            child: Text(
                              "We'll send a verification code to: ${businessPhone}",
                              style: TextStyle(
                                fontSize: 12,
                                color: primaryColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      child: QButton(
                        label: "Send Verification Code",
                        size: bs.md,
                        onPressed: _sendVerificationCode,
                      ),
                    ),
                    QTextField(
                      label: "Enter verification code",
                      value: verificationCode,
                      hint: "6-digit code",
                      onChanged: (value) {
                        verificationCode = value;
                        setState(() {});
                      },
                    ),
                    Container(
                      width: double.infinity,
                      child: QButton(
                        label: isVerifying ? "Verifying..." : "Verify Phone",
                        size: bs.md,
                        onPressed: isVerifying ? null : _verifyPhoneCode,
                      ),
                    ),
                  ],
                ),
              ),

            // Manual Review Section
            if (currentStep == "manual_review")
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(spLg),
                decoration: BoxDecoration(
                  color: infoColor.withAlpha(10),
                  borderRadius: BorderRadius.circular(radiusLg),
                  border: Border.all(
                    color: infoColor.withAlpha(30),
                    width: 1,
                  ),
                ),
                child: Column(
                  spacing: spMd,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.rate_review,
                          size: 24,
                          color: infoColor,
                        ),
                        SizedBox(width: spSm),
                        Text(
                          "Under Review",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: infoColor,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      "Your business verification is currently under review by our team. This process typically takes up to ${reviewTimeHours} hours.",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                    Container(
                      width: 60,
                      height: 60,
                      child: CircularProgressIndicator(
                        strokeWidth: 4,
                        valueColor: AlwaysStoppedAnimation<Color>(infoColor),
                      ),
                    ),
                  ],
                ),
              ),

            // Approval Section
            if (isApproved)
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(spLg),
                decoration: BoxDecoration(
                  color: successColor.withAlpha(10),
                  borderRadius: BorderRadius.circular(radiusLg),
                  border: Border.all(
                    color: successColor.withAlpha(50),
                    width: 1,
                  ),
                ),
                child: Column(
                  spacing: spMd,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.celebration,
                          size: 24,
                          color: successColor,
                        ),
                        SizedBox(width: spSm),
                        Text(
                          "Business Verified!",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: successColor,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      "Congratulations! Your business account has been successfully verified. You now have access to all business features and can start using your verified account.",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      child: QButton(
                        label: "Access Business Dashboard",
                        size: bs.md,
                        color: successColor,
                        onPressed: () {
                          // Navigate to business dashboard
                        },
                      ),
                    ),
                  ],
                ),
              ),

            // Benefits Section
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: primaryColor.withAlpha(10),
                borderRadius: BorderRadius.circular(radiusSm),
                border: Border.all(
                  color: primaryColor.withAlpha(30),
                  width: 1,
                ),
              ),
              child: Column(
                spacing: spSm,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.business_center,
                        size: 18,
                        color: primaryColor,
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "Business Account Benefits",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: spXs,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.verified,
                            size: 14,
                            color: successColor,
                          ),
                          SizedBox(width: spXs),
                          Text(
                            "Verified business badge",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.analytics,
                            size: 14,
                            color: successColor,
                          ),
                          SizedBox(width: spXs),
                          Text(
                            "Advanced analytics and insights",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.support,
                            size: 14,
                            color: successColor,
                          ),
                          SizedBox(width: spXs),
                          Text(
                            "Priority customer support",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
