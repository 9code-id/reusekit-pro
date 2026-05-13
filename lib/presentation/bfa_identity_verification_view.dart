import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class BfaIdentityVerificationView extends StatefulWidget {
  const BfaIdentityVerificationView({super.key});

  @override
  State<BfaIdentityVerificationView> createState() => _BfaIdentityVerificationViewState();
}

class _BfaIdentityVerificationViewState extends State<BfaIdentityVerificationView> {
  int currentStep = 0;
  bool loading = false;
  String selectedVerificationMethod = "otp";

  List<Map<String, dynamic>> verificationMethods = [
    {
      "title": "OTP Verification",
      "description": "Verify via SMS and Email OTP",
      "icon": Icons.sms,
      "value": "otp",
      "color": primaryColor,
      "status": "available",
    },
    {
      "title": "Video Call",
      "description": "Live video verification with agent",
      "icon": Icons.video_call,
      "value": "video",
      "color": successColor,
      "status": "available",
    },
    {
      "title": "Biometric Match",
      "description": "Match with Aadhar biometric database",
      "icon": Icons.fingerprint,
      "value": "biometric",
      "color": infoColor,
      "status": "processing",
    },
  ];

  List<Map<String, dynamic>> verificationSteps = [
    {
      "title": "Document Analysis",
      "description": "AI analysis of uploaded documents",
      "status": "completed",
      "details": "All documents successfully analyzed",
    },
    {
      "title": "Information Matching",
      "description": "Cross-verification of personal details",
      "status": "completed",
      "details": "Personal information matches across documents",
    },
    {
      "title": "Database Verification",
      "description": "Verification with government databases",
      "status": "processing",
      "details": "Checking against official records",
    },
    {
      "title": "Live Verification",
      "description": "Real-time identity confirmation",
      "status": "pending",
      "details": "Waiting for live verification",
    },
  ];

  String mobileOtp = "";
  String emailOtp = "";
  String mobileNumber = "+91 98765-43210";
  String emailAddress = "user@example.com";

  void _selectVerificationMethod(String method) {
    selectedVerificationMethod = method;
    setState(() {});
  }

  Future<void> _startOtpVerification() async {
    loading = true;
    setState(() {});

    await Future.delayed(Duration(seconds: 2));

    loading = false;
    currentStep = 1;
    setState(() {});

    ss("OTP sent to your mobile and email");
  }

  Future<void> _verifyOtp() async {
    if (mobileOtp.length != 6 || emailOtp.length != 6) {
      se("Please enter both OTP codes");
      return;
    }

    loading = true;
    setState(() {});

    await Future.delayed(Duration(seconds: 2));

    loading = false;
    currentStep = 2;
    setState(() {});

    // Update verification steps
    verificationSteps[2]["status"] = "completed";
    verificationSteps[3]["status"] = "completed";

    ss("Identity verification completed successfully");
  }

  Future<void> _startVideoVerification() async {
    loading = true;
    setState(() {});

    await Future.delayed(Duration(seconds: 3));

    loading = false;
    currentStep = 2;
    setState(() {});

    ss("Video verification completed successfully");
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "completed":
        return successColor;
      case "processing":
        return warningColor;
      case "pending":
        return disabledColor;
      case "failed":
        return dangerColor;
      default:
        return disabledColor;
    }
  }

  IconData _getStatusIcon(String status) {
    switch (status) {
      case "completed":
        return Icons.check_circle;
      case "processing":
        return Icons.sync;
      case "pending":
        return Icons.pending;
      case "failed":
        return Icons.error;
      default:
        return Icons.help;
    }
  }

  Widget _buildVerificationMethodSelection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Choose Verification Method",
          style: TextStyle(
            fontSize: fsH5,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        SizedBox(height: spMd),
        Text(
          "Select how you would like to complete your identity verification",
          style: TextStyle(
            fontSize: 14,
            color: disabledBoldColor,
          ),
        ),
        SizedBox(height: spXl),

        ...verificationMethods.map((method) {
          bool isSelected = selectedVerificationMethod == method["value"];
          bool isAvailable = method["status"] == "available";

          return Container(
            margin: EdgeInsets.only(bottom: spMd),
            child: GestureDetector(
              onTap: isAvailable ? () => _selectVerificationMethod(method["value"] as String) : null,
              child: Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: isSelected 
                      ? (method["color"] as Color).withAlpha(10) 
                      : isAvailable 
                          ? Colors.white 
                          : disabledColor.withAlpha(20),
                  border: Border.all(
                    color: isSelected 
                        ? (method["color"] as Color) 
                        : isAvailable 
                            ? disabledOutlineBorderColor 
                            : disabledColor,
                    width: isSelected ? 2 : 1,
                  ),
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: isSelected ? [shadowSm] : [],
                ),
                child: Row(
                  children: [
                    Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        color: isAvailable ? (method["color"] as Color) : disabledColor,
                        borderRadius: BorderRadius.circular(radiusMd),
                      ),
                      child: Icon(
                        method["icon"] as IconData,
                        color: Colors.white,
                        size: 28,
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
                                  "${method["title"]}",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: isAvailable ? primaryColor : disabledBoldColor,
                                  ),
                                ),
                              ),
                              if (!isAvailable)
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                                  decoration: BoxDecoration(
                                    color: warningColor.withAlpha(20),
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                  child: Text(
                                    "PROCESSING",
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: warningColor,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                            ],
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "${method["description"]}",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    ),

                    if (isSelected && isAvailable)
                      Icon(
                        Icons.check_circle,
                        color: method["color"] as Color,
                        size: 24,
                      ),
                  ],
                ),
              ),
            ),
          );
        }).toList(),

        SizedBox(height: spXl),

        Container(
          width: double.infinity,
          child: QButton(
            label: loading ? "Starting Verification..." : "Start Verification",
            size: bs.md,
            onPressed: loading ? null : () {
              if (selectedVerificationMethod == "otp") {
                _startOtpVerification();
              } else if (selectedVerificationMethod == "video") {
                _startVideoVerification();
              }
            },
          ),
        ),
      ],
    );
  }

  Widget _buildOtpVerification() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "OTP Verification",
          style: TextStyle(
            fontSize: fsH5,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        SizedBox(height: spMd),
        Text(
          "Enter the OTP codes sent to your registered mobile and email",
          style: TextStyle(
            fontSize: 14,
            color: disabledBoldColor,
          ),
        ),
        SizedBox(height: spXl),

        // Mobile OTP
        Container(
          padding: EdgeInsets.all(spMd),
          decoration: BoxDecoration(
            color: primaryColor.withAlpha(10),
            borderRadius: BorderRadius.circular(radiusMd),
            border: Border.all(color: primaryColor.withAlpha(50)),
          ),
          child: Row(
            children: [
              Icon(
                Icons.sms,
                color: primaryColor,
                size: 24,
              ),
              SizedBox(width: spMd),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Mobile OTP",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "Sent to $mobileNumber",
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
        ),

        SizedBox(height: spMd),

        QTextField(
          label: "Enter Mobile OTP",
          value: mobileOtp,
          hint: "6-digit OTP",
          validator: Validator.required,
          onChanged: (value) {
            mobileOtp = value;
            setState(() {});
          },
        ),

        SizedBox(height: spXl),

        // Email OTP
        Container(
          padding: EdgeInsets.all(spMd),
          decoration: BoxDecoration(
            color: successColor.withAlpha(10),
            borderRadius: BorderRadius.circular(radiusMd),
            border: Border.all(color: successColor.withAlpha(50)),
          ),
          child: Row(
            children: [
              Icon(
                Icons.email,
                color: successColor,
                size: 24,
              ),
              SizedBox(width: spMd),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Email OTP",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: successColor,
                      ),
                    ),
                    Text(
                      "Sent to $emailAddress",
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
        ),

        SizedBox(height: spMd),

        QTextField(
          label: "Enter Email OTP",
          value: emailOtp,
          hint: "6-digit OTP",
          validator: Validator.required,
          onChanged: (value) {
            emailOtp = value;
            setState(() {});
          },
        ),

        SizedBox(height: spXl),

        Row(
          children: [
            Expanded(
              child: Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  border: Border.all(color: disabledBoldColor),
                  borderRadius: BorderRadius.circular(radiusMd),
                ),
                child: GestureDetector(
                  onTap: () {
                    si("OTP resent successfully");
                  },
                  child: Text(
                    "Resend OTP",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      color: disabledBoldColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(width: spMd),
            Expanded(
              child: QButton(
                label: loading ? "Verifying..." : "Verify OTP",
                size: bs.md,
                onPressed: loading ? null : _verifyOtp,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildVerificationComplete() {
    return Column(
      children: [
        Container(
          width: 120,
          height: 120,
          decoration: BoxDecoration(
            color: successColor.withAlpha(20),
            borderRadius: BorderRadius.circular(radiusXl),
          ),
          child: Icon(
            Icons.verified_user,
            size: 60,
            color: successColor,
          ),
        ),

        SizedBox(height: spXl),

        Text(
          "Identity Verified!",
          style: TextStyle(
            fontSize: fsH3,
            fontWeight: FontWeight.bold,
            color: successColor,
          ),
        ),

        SizedBox(height: spMd),

        Text(
          "Your identity has been successfully verified. You can now access all banking features.",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 16,
            color: disabledBoldColor,
            height: 1.5,
          ),
        ),

        SizedBox(height: sp2xl),

        // Verification Steps Summary
        ...verificationSteps.map((step) {
          Color statusColor = _getStatusColor(step["status"] as String);
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
                  Icon(
                    _getStatusIcon(step["status"] as String),
                    color: statusColor,
                    size: 24,
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
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "${step["details"]}",
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
            ),
          );
        }).toList(),

        SizedBox(height: sp2xl),

        Container(
          width: double.infinity,
          child: QButton(
            label: "Continue to Dashboard",
            size: bs.md,
            onPressed: () {
              // navigateTo(BfaHomeView());
            },
          ),
        ),

        SizedBox(height: spMd),

        Container(
          width: double.infinity,
          child: Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              border: Border.all(color: primaryColor),
              borderRadius: BorderRadius.circular(radiusMd),
            ),
            child: GestureDetector(
              onTap: () {
                // navigateTo(BfaAccountDetailsView());
              },
              child: Text(
                "View Account Details",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: primaryColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Identity Verification"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            if (currentStep > 0) {
              currentStep--;
              setState(() {});
            } else {
              back();
            }
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spLg),
        child: Column(
          children: [
            // Progress Indicator
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: primaryColor.withAlpha(10),
                borderRadius: BorderRadius.circular(radiusMd),
              ),
              child: Row(
                children: List.generate(3, (index) {
                  bool isActive = index <= currentStep;
                  bool isCurrent = index == currentStep;

                  return Expanded(
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: spXs),
                      child: Column(
                        children: [
                          Container(
                            width: 30,
                            height: 30,
                            decoration: BoxDecoration(
                              color: isActive ? primaryColor : disabledColor,
                              shape: BoxShape.circle,
                              border: isCurrent ? Border.all(color: primaryColor, width: 3) : null,
                            ),
                            child: Center(
                              child: Text(
                                "${index + 1}",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: spSm),
                          Text(
                            index == 0 ? "Method" : index == 1 ? "Verify" : "Complete",
                            style: TextStyle(
                              fontSize: 12,
                              color: isActive ? primaryColor : disabledBoldColor,
                              fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
              ),
            ),

            SizedBox(height: sp2xl),

            // Content based on current step
            if (currentStep == 0) _buildVerificationMethodSelection(),
            if (currentStep == 1) _buildOtpVerification(),
            if (currentStep == 2) _buildVerificationComplete(),
          ],
        ),
      ),
    );
  }
}
