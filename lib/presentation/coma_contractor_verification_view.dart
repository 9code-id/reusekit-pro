import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class ComaContractorVerificationView extends StatefulWidget {
  const ComaContractorVerificationView({super.key});

  @override
  State<ComaContractorVerificationView> createState() => _ComaContractorVerificationViewState();
}

class _ComaContractorVerificationViewState extends State<ComaContractorVerificationView> {
  final formKey = GlobalKey<FormState>();
  
  String selectedVerificationType = "license";
  String licenseNumber = "";
  String bondNumber = "";
  String insuranceProvider = "";
  String insurancePolicy = "";
  String licenseDocument = "";
  String bondDocument = "";
  String insuranceDocument = "";
  String businessCertificate = "";
  String experienceYears = "1-5";
  String specializations = "general";
  bool loading = false;
  bool verified = false;

  List<Map<String, dynamic>> verificationTypes = [
    {"label": "Professional License", "value": "license"},
    {"label": "Bonding & Insurance", "value": "bonding"},
    {"label": "Business Registration", "value": "business"},
    {"label": "Experience Portfolio", "value": "experience"},
  ];

  List<Map<String, dynamic>> experienceOptions = [
    {"label": "1-5 years", "value": "1-5"},
    {"label": "6-10 years", "value": "6-10"},
    {"label": "11-20 years", "value": "11-20"},
    {"label": "20+ years", "value": "20+"},
  ];

  List<Map<String, dynamic>> specializationOptions = [
    {"label": "General Construction", "value": "general"},
    {"label": "Electrical", "value": "electrical"},
    {"label": "Plumbing", "value": "plumbing"},
    {"label": "HVAC", "value": "hvac"},
    {"label": "Roofing", "value": "roofing"},
    {"label": "Flooring", "value": "flooring"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Contractor Verification"),
      ),
      body: loading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: EdgeInsets.all(spMd),
              child: Form(
                key: formKey,
                child: Column(
                  spacing: spMd,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header
                    if (!verified) ...[
                      Column(
                        spacing: spSm,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.verified_user,
                                size: 32,
                                color: primaryColor,
                              ),
                              SizedBox(width: spSm),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Contractor Verification",
                                      style: TextStyle(
                                        fontSize: fsH2,
                                        fontWeight: FontWeight.bold,
                                        color: primaryColor,
                                      ),
                                    ),
                                    Text(
                                      "Verify your credentials to build trust",
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),

                      // Verification Process Steps
                      Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: infoColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusMd),
                          border: Border.all(color: infoColor.withAlpha(50)),
                        ),
                        child: Column(
                          spacing: spSm,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Verification Process",
                              style: TextStyle(
                                fontSize: fsH6,
                                fontWeight: FontWeight.bold,
                                color: infoColor,
                              ),
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.upload_file,
                                  color: infoColor,
                                  size: 16,
                                ),
                                SizedBox(width: spXs),
                                Text(
                                  "1. Upload required documents",
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
                                  Icons.search,
                                  color: infoColor,
                                  size: 16,
                                ),
                                SizedBox(width: spXs),
                                Text(
                                  "2. Documents reviewed within 24-48 hours",
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
                                  Icons.check_circle,
                                  color: infoColor,
                                  size: 16,
                                ),
                                SizedBox(width: spXs),
                                Text(
                                  "3. Receive verification badge",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),

                      // Professional License Section
                      Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(radiusMd),
                          boxShadow: [shadowSm],
                        ),
                        child: Column(
                          spacing: spSm,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.badge,
                                  color: primaryColor,
                                  size: 20,
                                ),
                                SizedBox(width: spSm),
                                Text(
                                  "Professional License",
                                  style: TextStyle(
                                    fontSize: fsH6,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                              ],
                            ),
                            QTextField(
                              label: "License Number",
                              value: licenseNumber,
                              validator: Validator.required,
                              hint: "Enter your contractor license number",
                              onChanged: (value) {
                                licenseNumber = value;
                                setState(() {});
                              },
                            ),
                            QImagePicker(
                              label: "License Document",
                              value: licenseDocument,
                              hint: "Upload a clear photo of your license",
                              validator: Validator.required,
                              onChanged: (value) {
                                licenseDocument = value;
                                setState(() {});
                              },
                            ),
                          ],
                        ),
                      ),

                      // Insurance & Bonding Section
                      Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(radiusMd),
                          boxShadow: [shadowSm],
                        ),
                        child: Column(
                          spacing: spSm,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.security,
                                  color: primaryColor,
                                  size: 20,
                                ),
                                SizedBox(width: spSm),
                                Text(
                                  "Insurance & Bonding",
                                  style: TextStyle(
                                    fontSize: fsH6,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                              ],
                            ),
                            QTextField(
                              label: "Insurance Provider",
                              value: insuranceProvider,
                              validator: Validator.required,
                              hint: "Name of your insurance company",
                              onChanged: (value) {
                                insuranceProvider = value;
                                setState(() {});
                              },
                            ),
                            QTextField(
                              label: "Policy Number",
                              value: insurancePolicy,
                              validator: Validator.required,
                              hint: "Your insurance policy number",
                              onChanged: (value) {
                                insurancePolicy = value;
                                setState(() {});
                              },
                            ),
                            QImagePicker(
                              label: "Insurance Certificate",
                              value: insuranceDocument,
                              hint: "Upload insurance certificate",
                              validator: Validator.required,
                              onChanged: (value) {
                                insuranceDocument = value;
                                setState(() {});
                              },
                            ),
                            QTextField(
                              label: "Bond Number (Optional)",
                              value: bondNumber,
                              hint: "Surety bond number if applicable",
                              onChanged: (value) {
                                bondNumber = value;
                                setState(() {});
                              },
                            ),
                          ],
                        ),
                      ),

                      // Business Registration
                      Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(radiusMd),
                          boxShadow: [shadowSm],
                        ),
                        child: Column(
                          spacing: spSm,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.business,
                                  color: primaryColor,
                                  size: 20,
                                ),
                                SizedBox(width: spSm),
                                Text(
                                  "Business Registration",
                                  style: TextStyle(
                                    fontSize: fsH6,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                              ],
                            ),
                            QImagePicker(
                              label: "Business Certificate",
                              value: businessCertificate,
                              hint: "Upload business registration certificate",
                              validator: Validator.required,
                              onChanged: (value) {
                                businessCertificate = value;
                                setState(() {});
                              },
                            ),
                          ],
                        ),
                      ),

                      // Experience & Specialization
                      Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(radiusMd),
                          boxShadow: [shadowSm],
                        ),
                        child: Column(
                          spacing: spSm,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.work,
                                  color: primaryColor,
                                  size: 20,
                                ),
                                SizedBox(width: spSm),
                                Text(
                                  "Experience & Expertise",
                                  style: TextStyle(
                                    fontSize: fsH6,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                              ],
                            ),
                            QDropdownField(
                              label: "Years of Experience",
                              items: experienceOptions,
                              value: experienceYears,
                              onChanged: (value, label) {
                                experienceYears = value;
                                setState(() {});
                              },
                            ),
                            QDropdownField(
                              label: "Primary Specialization",
                              items: specializationOptions,
                              value: specializations,
                              onChanged: (value, label) {
                                specializations = value;
                                setState(() {});
                              },
                            ),
                          ],
                        ),
                      ),

                      // Submit Verification Button
                      Container(
                        width: double.infinity,
                        child: QButton(
                          label: "Submit for Verification",
                          size: bs.md,
                          onPressed: () async {
                            if (formKey.currentState!.validate()) {
                              loading = true;
                              setState(() {});
                              
                              await Future.delayed(Duration(seconds: 3));
                              
                              loading = false;
                              verified = true;
                              setState(() {});
                              
                              ss("Verification documents submitted successfully");
                            }
                          },
                        ),
                      ),
                    ],

                    // Verification Submitted State
                    if (verified) ...[
                      Column(
                        spacing: spSm,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.pending_actions,
                            size: 80,
                            color: warningColor,
                          ),
                          Text(
                            "Verification Submitted",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: fsH1,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          Text(
                            "Your documents are being reviewed",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 16,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),

                      Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: warningColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusMd),
                          border: Border.all(color: warningColor.withAlpha(50)),
                        ),
                        child: Column(
                          spacing: spSm,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.schedule,
                                  color: warningColor,
                                  size: 20,
                                ),
                                SizedBox(width: spSm),
                                Text(
                                  "Review in Progress",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: warningColor,
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              "Our verification team is reviewing your submitted documents. You'll receive an email notification once the review is complete. This typically takes 24-48 hours.",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),

                      Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(radiusMd),
                          boxShadow: [shadowSm],
                        ),
                        child: Column(
                          spacing: spSm,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "What's Next?",
                              style: TextStyle(
                                fontSize: fsH6,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.email,
                                  color: primaryColor,
                                  size: 16,
                                ),
                                SizedBox(width: spXs),
                                Expanded(
                                  child: Text(
                                    "Check your email for verification updates",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.star,
                                  color: primaryColor,
                                  size: 16,
                                ),
                                SizedBox(width: spXs),
                                Expanded(
                                  child: Text(
                                    "Once verified, you'll receive a trust badge",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.trending_up,
                                  color: primaryColor,
                                  size: 16,
                                ),
                                SizedBox(width: spXs),
                                Expanded(
                                  child: Text(
                                    "Verified contractors get more project opportunities",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),

                      Row(
                        children: [
                          Expanded(
                            child: QButton(
                              label: "Continue to Dashboard",
                              size: bs.md,
                              onPressed: () {
                                // Navigate to dashboard
                              },
                            ),
                          ),
                          SizedBox(width: spSm),
                          QButton(
                            label: "Support",
                            size: bs.md,
                            onPressed: () {
                              // Contact support
                            },
                          ),
                        ],
                      ),
                    ],
                  ],
                ),
              ),
            ),
    );
  }
}
