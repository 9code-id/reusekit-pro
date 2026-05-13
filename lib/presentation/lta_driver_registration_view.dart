import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class LtaDriverRegistrationView extends StatefulWidget {
  const LtaDriverRegistrationView({super.key});

  @override
  State<LtaDriverRegistrationView> createState() => _LtaDriverRegistrationViewState();
}

class _LtaDriverRegistrationViewState extends State<LtaDriverRegistrationView> {
  final formKey = GlobalKey<FormState>();
  int currentStep = 0;
  
  // Personal Information
  String fullName = "";
  String email = "";
  String phone = "";
  String dateOfBirth = "";
  String address = "";
  String emergencyContact = "";
  String emergencyPhone = "";
  
  // License Information
  String licenseNumber = "";
  String licenseType = "";
  String licenseExpiry = "";
  String licenseIssuingState = "";
  
  // Experience Information
  String yearsOfExperience = "";
  String previousEmployer = "";
  String drivingRecord = "";
  
  // Documents
  String profilePhoto = "";
  String licensePhoto = "";
  String backgroundCheck = "";
  
  bool agreeToTerms = false;

  List<Map<String, dynamic>> licenseTypes = [
    {"label": "Class A - Heavy Trucks", "value": "class_a"},
    {"label": "Class B - Large Trucks", "value": "class_b"},
    {"label": "Class C - Regular Vehicle", "value": "class_c"},
    {"label": "CDL - Commercial", "value": "cdl"},
  ];

  List<Map<String, dynamic>> experienceOptions = [
    {"label": "Less than 1 year", "value": "0-1"},
    {"label": "1-3 years", "value": "1-3"},
    {"label": "3-5 years", "value": "3-5"},
    {"label": "5-10 years", "value": "5-10"},
    {"label": "More than 10 years", "value": "10+"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Driver Registration"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          children: [
            // Progress Header
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spLg),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [primaryColor, successColor],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(radiusMd),
              ),
              child: Column(
                children: [
                  Icon(
                    Icons.local_shipping,
                    size: 50,
                    color: Colors.white,
                  ),
                  
                  SizedBox(height: spMd),
                  
                  Text(
                    "Become a Driver",
                    style: TextStyle(
                      fontSize: fsH4,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  
                  Text(
                    "Join our professional driver network",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white.withAlpha(200),
                    ),
                  ),
                  
                  SizedBox(height: spLg),
                  
                  // Progress Indicator
                  Row(
                    children: List.generate(4, (index) {
                      return Expanded(
                        child: Container(
                          margin: EdgeInsets.symmetric(horizontal: spXs),
                          height: 4,
                          decoration: BoxDecoration(
                            color: index <= currentStep 
                                ? Colors.white 
                                : Colors.white.withAlpha(100),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                        ),
                      );
                    }),
                  ),
                  
                  SizedBox(height: spSm),
                  
                  Text(
                    "Step ${currentStep + 1} of 4",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white.withAlpha(200),
                    ),
                  ),
                ],
              ),
            ),
            
            SizedBox(height: spLg),
            
            // Form Content
            Container(
              padding: EdgeInsets.all(spLg),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowMd],
              ),
              child: Form(
                key: formKey,
                child: _buildCurrentStep(),
              ),
            ),
            
            SizedBox(height: spLg),
            
            // Navigation Buttons
            Row(
              children: [
                if (currentStep > 0) ...[
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
                  SizedBox(width: spMd),
                ],
                Expanded(
                  flex: currentStep > 0 ? 1 : 2,
                  child: QButton(
                    label: currentStep == 3 ? "Submit Application" : "Next",
                    size: bs.md,
                    icon: currentStep == 3 ? Icons.send : Icons.arrow_forward,
                    onPressed: () {
                      if (currentStep == 3) {
                        // Submit application
                        if (formKey.currentState!.validate() && agreeToTerms) {
                          showLoading();
                          Future.delayed(Duration(seconds: 3), () {
                            hideLoading();
                            ss("Application submitted successfully!");
                            // ss('Next page'));
                          });
                        } else if (!agreeToTerms) {
                          se("Please agree to the terms and conditions");
                        }
                      } else {
                        if (formKey.currentState!.validate()) {
                          currentStep++;
                          setState(() {});
                        }
                      }
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCurrentStep() {
    switch (currentStep) {
      case 0:
        return _buildPersonalInformation();
      case 1:
        return _buildLicenseInformation();
      case 2:
        return _buildExperienceInformation();
      case 3:
        return _buildDocumentUpload();
      default:
        return Container();
    }
  }

  Widget _buildPersonalInformation() {
    return Column(
      spacing: spMd,
      children: [
        Text(
          "Personal Information",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        
        QTextField(
          label: "Full Name",
          value: fullName,
          hint: "Enter your full legal name",
          validator: Validator.required,
          onChanged: (value) {
            fullName = value;
            setState(() {});
          },
        ),
        
        QTextField(
          label: "Email Address",
          value: email,
          hint: "Enter your email",
          validator: Validator.email,
          onChanged: (value) {
            email = value;
            setState(() {});
          },
        ),
        
        QTextField(
          label: "Phone Number",
          value: phone,
          hint: "Enter your phone number",
          validator: Validator.required,
          onChanged: (value) {
            phone = value;
            setState(() {});
          },
        ),
        
        QDatePicker(
          label: "Date of Birth",
          value: dateOfBirth.isNotEmpty ? DateTime.parse(dateOfBirth) : DateTime.now(),
          onChanged: (value) {
            dateOfBirth = value.toString();
            setState(() {});
          },
        ),
        
        QMemoField(
          label: "Home Address",
          value: address,
          hint: "Enter your complete address",
          validator: Validator.required,
          onChanged: (value) {
            address = value;
            setState(() {});
          },
        ),
        
        Text(
          "Emergency Contact",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        
        QTextField(
          label: "Emergency Contact Name",
          value: emergencyContact,
          hint: "Enter emergency contact person",
          validator: Validator.required,
          onChanged: (value) {
            emergencyContact = value;
            setState(() {});
          },
        ),
        
        QTextField(
          label: "Emergency Contact Phone",
          value: emergencyPhone,
          hint: "Enter emergency contact phone",
          validator: Validator.required,
          onChanged: (value) {
            emergencyPhone = value;
            setState(() {});
          },
        ),
      ],
    );
  }

  Widget _buildLicenseInformation() {
    return Column(
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
        
        QTextField(
          label: "Driver License Number",
          value: licenseNumber,
          hint: "Enter your license number",
          validator: Validator.required,
          onChanged: (value) {
            licenseNumber = value;
            setState(() {});
          },
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
        
        QDatePicker(
          label: "License Expiry Date",
          value: licenseExpiry.isNotEmpty ? DateTime.parse(licenseExpiry) : DateTime.now(),
          onChanged: (value) {
            licenseExpiry = value.toString();
            setState(() {});
          },
        ),
        
        QTextField(
          label: "License Issuing State",
          value: licenseIssuingState,
          hint: "State where license was issued",
          validator: Validator.required,
          onChanged: (value) {
            licenseIssuingState = value;
            setState(() {});
          },
        ),
        
        Container(
          padding: EdgeInsets.all(spMd),
          decoration: BoxDecoration(
            color: infoColor.withAlpha(20),
            borderRadius: BorderRadius.circular(radiusSm),
          ),
          child: Row(
            children: [
              Icon(
                Icons.info,
                color: infoColor,
                size: 20,
              ),
              SizedBox(width: spMd),
              Expanded(
                child: Text(
                  "Make sure your license is valid and not expired. We will verify this information.",
                  style: TextStyle(
                    fontSize: 12,
                    color: infoColor,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildExperienceInformation() {
    return Column(
      spacing: spMd,
      children: [
        Text(
          "Driving Experience",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        
        QDropdownField(
          label: "Years of Driving Experience",
          items: experienceOptions,
          value: yearsOfExperience,
          onChanged: (value, label) {
            yearsOfExperience = value;
            setState(() {});
          },
        ),
        
        QTextField(
          label: "Previous Employer (if any)",
          value: previousEmployer,
          hint: "Enter previous company name",
          onChanged: (value) {
            previousEmployer = value;
            setState(() {});
          },
        ),
        
        QMemoField(
          label: "Driving Record & Violations",
          value: drivingRecord,
          hint: "List any traffic violations or accidents in the past 5 years",
          onChanged: (value) {
            drivingRecord = value;
            setState(() {});
          },
        ),
        
        Container(
          padding: EdgeInsets.all(spMd),
          decoration: BoxDecoration(
            color: warningColor.withAlpha(20),
            borderRadius: BorderRadius.circular(radiusSm),
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
                "Please be honest about your driving record. We will conduct a background check and verify all information provided.",
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

  Widget _buildDocumentUpload() {
    return Column(
      spacing: spMd,
      children: [
        Text(
          "Document Upload",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        
        QImagePicker(
          label: "Profile Photo",
          value: profilePhoto,
          hint: "Upload a clear photo of yourself",
          validator: Validator.required,
          onChanged: (value) {
            profilePhoto = value;
            setState(() {});
          },
        ),
        
        QImagePicker(
          label: "Driver License Photo",
          value: licensePhoto,
          hint: "Upload front side of your license",
          validator: Validator.required,
          onChanged: (value) {
            licensePhoto = value;
            setState(() {});
          },
        ),
        
        QAttachmentPicker(
          label: "Background Check Documents",
          value: backgroundCheck.isNotEmpty ? [backgroundCheck] : [],
          hint: "Upload any background check documents",
          onChanged: (value) {
            backgroundCheck = value.isNotEmpty ? value.first : "";
            setState(() {});
          },
        ),
        
        QSwitch(
          items: [
            {
              "label": "I agree to the Driver Terms and Conditions and authorize background verification",
              "value": true,
              "checked": agreeToTerms,
            }
          ],
          value: [
            if (agreeToTerms)
              {
                "label": "I agree to the Driver Terms and Conditions and authorize background verification",
                "value": true,
                "checked": true
              }
          ],
          onChanged: (values, ids) {
            setState(() {
              agreeToTerms = values.isNotEmpty;
            });
          },
        ),
        
        Container(
          padding: EdgeInsets.all(spMd),
          decoration: BoxDecoration(
            color: successColor.withAlpha(20),
            borderRadius: BorderRadius.circular(radiusSm),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Application Review Process",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: successColor,
                ),
              ),
              SizedBox(height: spSm),
              Text(
                "After submission, your application will be reviewed within 2-3 business days. We will contact you via email with the next steps.",
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
}
