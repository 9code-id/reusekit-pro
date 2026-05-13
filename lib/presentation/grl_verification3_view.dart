import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlVerification3View extends StatefulWidget {
  @override
  State<GrlVerification3View> createState() => _GrlVerification3ViewState();
}

class _GrlVerification3ViewState extends State<GrlVerification3View> {
  String selectedDocumentType = 'passport';
  String documentNumber = '';
  String fullName = '';
  String dateOfBirth = '';
  String nationality = '';
  String frontImagePath = '';
  String backImagePath = '';
  String selfieImagePath = '';
  bool agreeToTerms = false;
  
  List<Map<String, dynamic>> documentTypes = [
    {
      "label": "Passport",
      "value": "passport",
      "icon": Icons.book,
      "description": "International passport document",
    },
    {
      "label": "Driver's License",
      "value": "drivers_license", 
      "icon": Icons.drive_eta,
      "description": "Government-issued driver's license",
    },
    {
      "label": "National ID Card",
      "value": "national_id",
      "icon": Icons.credit_card,
      "description": "National identity card",
    },
    {
      "label": "Other Government ID",
      "value": "other_id",
      "icon": Icons.badge,
      "description": "Other government-issued identification",
    },
  ];

  List<Map<String, dynamic>> verificationSteps = [
    {
      "title": "Document Photos",
      "description": "Take clear photos of your ID document",
      "icon": Icons.photo_camera,
      "completed": false,
    },
    {
      "title": "Personal Information",
      "description": "Enter your personal details",
      "icon": Icons.person,
      "completed": false,
    },
    {
      "title": "Selfie Verification",
      "description": "Take a selfie for identity confirmation",
      "icon": Icons.face,
      "completed": false,
    },
    {
      "title": "Review & Submit",
      "description": "Review all information before submission",
      "icon": Icons.check_circle,
      "completed": false,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Identity Verification"),
        actions: [
          IconButton(
            icon: Icon(Icons.help_outline),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Section
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
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
                  Container(
                    padding: EdgeInsets.all(spMd),
                    decoration: BoxDecoration(
                      color: Colors.white.withAlpha(51),
                      borderRadius: BorderRadius.circular(radiusLg),
                    ),
                    child: Icon(
                      Icons.verified_user,
                      color: Colors.white,
                      size: 48,
                    ),
                  ),
                  SizedBox(height: spMd),
                  Text(
                    "Verify Your Identity",
                    style: TextStyle(
                      fontSize: fsH4,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "We need to verify your identity to ensure account security and comply with regulations",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white70,
                    ),
                  ),
                ],
              ),
            ),
            
            SizedBox(height: spMd),
            
            // Verification Progress
            Container(
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
                    "Verification Process",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spMd),
                  ...verificationSteps.map((step) => Container(
                    margin: EdgeInsets.only(bottom: spMd),
                    child: Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: (step["completed"] as bool ? successColor : disabledColor).withAlpha(51),
                            borderRadius: BorderRadius.circular(radiusLg),
                          ),
                          child: Icon(
                            step["completed"] as bool ? Icons.check : (step["icon"] as IconData),
                            color: step["completed"] as bool ? successColor : disabledBoldColor,
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
                                  fontSize: fsH6,
                                  fontWeight: FontWeight.bold,
                                  color: step["completed"] as bool ? successColor : Colors.black,
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
                      ],
                    ),
                  )).toList(),
                ],
              ),
            ),
            
            SizedBox(height: spMd),
            
            // Document Type Selection
            Container(
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
                    "Select Document Type",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spMd),
                  QDropdownField(
                    label: "ID Document Type",
                    items: documentTypes,
                    value: selectedDocumentType,
                    onChanged: (value, label) {
                      selectedDocumentType = value;
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),
            
            SizedBox(height: spMd),
            
            // Document Photos
            Container(
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
                    "Document Photos",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "Take clear photos of both sides of your document",
                    style: TextStyle(
                      fontSize: 14,
                      color: disabledBoldColor,
                    ),
                  ),
                  SizedBox(height: spMd),
                  
                  Row(
                    children: [
                      Expanded(
                        child: _buildPhotoUpload(
                          "Front Side",
                          frontImagePath,
                          Icons.photo_camera_front,
                          () {
                            // Simulate image selection
                            frontImagePath = "front_image_selected.jpg";
                            setState(() {});
                            ss("Front side photo captured");
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: _buildPhotoUpload(
                          "Back Side",
                          backImagePath,
                          Icons.photo_camera_back,
                          () {
                            // Simulate image selection
                            backImagePath = "back_image_selected.jpg";
                            setState(() {});
                            ss("Back side photo captured");
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            
            SizedBox(height: spMd),
            
            // Personal Information
            Container(
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
                    "Personal Information",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spMd),
                  
                  QTextField(
                    label: "Full Name (as shown on document)",
                    value: fullName,
                    hint: "Enter your full legal name",
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
                    onChanged: (value) {
                      documentNumber = value;
                      setState(() {});
                    },
                  ),
                  
                  SizedBox(height: spMd),
                  
                  Row(
                    children: [
                      Expanded(
                        child: QDatePicker(
                          label: "Date of Birth",
                          value: dateOfBirth.isNotEmpty ? DateTime.parse(dateOfBirth) : DateTime.now(),
                          onChanged: (value) {
                            dateOfBirth = value.toString();
                            setState(() {});
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QTextField(
                          label: "Nationality",
                          value: nationality,
                          hint: "Your nationality",
                          onChanged: (value) {
                            nationality = value;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            
            SizedBox(height: spMd),
            
            // Selfie Verification
            Container(
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
                    "Selfie Verification",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "Take a selfie to confirm your identity matches the document",
                    style: TextStyle(
                      fontSize: 14,
                      color: disabledBoldColor,
                    ),
                  ),
                  SizedBox(height: spMd),
                  
                  _buildPhotoUpload(
                    "Take Selfie",
                    selfieImagePath,
                    Icons.face,
                    () {
                      // Simulate selfie capture
                      selfieImagePath = "selfie_captured.jpg";
                      setState(() {});
                      ss("Selfie captured successfully");
                    },
                  ),
                ],
              ),
            ),
            
            SizedBox(height: spMd),
            
            // Terms Agreement
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Checkbox(
                        value: agreeToTerms,
                        onChanged: (value) {
                          agreeToTerms = value ?? false;
                          setState(() {});
                        },
                        activeColor: primaryColor,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "I agree to the verification terms",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(height: spXs),
                            RichText(
                              text: TextSpan(
                                text: "By submitting, I agree to the ",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: disabledBoldColor,
                                ),
                                children: [
                                  TextSpan(
                                    text: "Terms of Service",
                                    style: TextStyle(
                                      color: primaryColor,
                                      fontWeight: FontWeight.w600,
                                      decoration: TextDecoration.underline,
                                    ),
                                  ),
                                  TextSpan(text: " and "),
                                  TextSpan(
                                    text: "Privacy Policy",
                                    style: TextStyle(
                                      color: primaryColor,
                                      fontWeight: FontWeight.w600,
                                      decoration: TextDecoration.underline,
                                    ),
                                  ),
                                  TextSpan(text: " and authorize the processing of my personal data for verification purposes."),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            
            SizedBox(height: spMd),
            
            // Submit Button
            Container(
              width: double.infinity,
              child: QButton(
                label: "Submit for Verification",
                size: bs.md,
                onPressed: _canSubmit() ? _submitVerification : null,
              ),
            ),
            
            SizedBox(height: spMd),
            
            // Important Notice
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: warningColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusLg),
                border: Border.all(color: warningColor.withAlpha(102)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.info,
                        color: warningColor,
                        size: 20,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "Important Notice",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: warningColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "• Verification typically takes 1-3 business days\n• Ensure photos are clear and all text is readable\n• Document must be valid and not expired\n• Personal information must match the document exactly\n• False information may result in account suspension",
                    style: TextStyle(
                      fontSize: 14,
                      color: disabledBoldColor,
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPhotoUpload(String title, String imagePath, IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 120,
        decoration: BoxDecoration(
          color: imagePath.isEmpty ? disabledColor.withAlpha(51) : successColor.withAlpha(51),
          borderRadius: BorderRadius.circular(radiusLg),
          border: Border.all(
            color: imagePath.isEmpty ? disabledColor : successColor,
            style: BorderStyle.solid,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              imagePath.isEmpty ? icon : Icons.check_circle,
              color: imagePath.isEmpty ? disabledBoldColor : successColor,
              size: 32,
            ),
            SizedBox(height: spSm),
            Text(
              imagePath.isEmpty ? title : "Photo Captured",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: imagePath.isEmpty ? disabledBoldColor : successColor,
              ),
            ),
            if (imagePath.isEmpty)
              Text(
                "Tap to capture",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
          ],
        ),
      ),
    );
  }

  bool _canSubmit() {
    return frontImagePath.isNotEmpty &&
           backImagePath.isNotEmpty &&
           selfieImagePath.isNotEmpty &&
           fullName.isNotEmpty &&
           documentNumber.isNotEmpty &&
           dateOfBirth.isNotEmpty &&
           nationality.isNotEmpty &&
           agreeToTerms;
  }

  void _submitVerification() async {
    showLoading();
    
    // Simulate API submission
    await Future.delayed(Duration(seconds: 3));
    
    hideLoading();
    
    ss("Verification documents submitted successfully! You'll receive an update within 1-3 business days.");
    
    // Navigate to verification pending view
    // navigateTo(VerificationPendingView());
  }
}
