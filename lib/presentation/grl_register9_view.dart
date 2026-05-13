import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlRegister9View extends StatefulWidget {
  @override
  State<GrlRegister9View> createState() => _GrlRegister9ViewState();
}

class _GrlRegister9ViewState extends State<GrlRegister9View> {
  final formKey = GlobalKey<FormState>();
  
  String doctorName = "";
  String doctorEmail = "";
  String licenseNumber = "";
  String specialty = "";
  String subSpecialty = "";
  String hospitalAffiliation = "";
  String yearsOfExperience = "";
  String consultationFee = "";
  String education = "";
  String bio = "";
  String profileImage = "";
  List<String> certifications = [];
  List<String> qualifications = [];
  String availability = "";
  String preferredLanguages = "";
  bool telemedicineAvailable = false;
  bool inPersonConsultation = false;
  bool emergencyAvailable = false;
  List<String> workingDays = [];
  String workingHoursStart = "";
  String workingHoursEnd = "";
  bool isLoading = false;

  List<Map<String, dynamic>> specialties = [
    {"label": "Internal Medicine", "value": "internal_medicine"},
    {"label": "Cardiology", "value": "cardiology"},
    {"label": "Neurology", "value": "neurology"},
    {"label": "Orthopedics", "value": "orthopedics"},
    {"label": "Pediatrics", "value": "pediatrics"},
    {"label": "Gynecology", "value": "gynecology"},
    {"label": "Dermatology", "value": "dermatology"},
    {"label": "Psychiatry", "value": "psychiatry"},
    {"label": "Radiology", "value": "radiology"},
    {"label": "Surgery", "value": "surgery"},
    {"label": "Emergency Medicine", "value": "emergency"},
    {"label": "Family Medicine", "value": "family"},
  ];

  List<Map<String, dynamic>> experienceRanges = [
    {"label": "1-3 years", "value": "1-3"},
    {"label": "4-7 years", "value": "4-7"},
    {"label": "8-15 years", "value": "8-15"},
    {"label": "16-25 years", "value": "16-25"},
    {"label": "25+ years", "value": "25+"},
  ];

  List<Map<String, dynamic>> availabilityOptions = [
    {"label": "Full-time", "value": "fulltime"},
    {"label": "Part-time", "value": "parttime"},
    {"label": "Weekends only", "value": "weekends"},
    {"label": "Evenings only", "value": "evenings"},
    {"label": "On-call", "value": "oncall"},
  ];

  List<Map<String, dynamic>> languageOptions = [
    {"label": "English", "value": "english"},
    {"label": "Spanish", "value": "spanish"},
    {"label": "French", "value": "french"},
    {"label": "German", "value": "german"},
    {"label": "Mandarin", "value": "mandarin"},
    {"label": "Arabic", "value": "arabic"},
    {"label": "Hindi", "value": "hindi"},
    {"label": "Portuguese", "value": "portuguese"},
  ];

  List<Map<String, dynamic>> weekDays = [
    {"label": "Monday", "value": "monday", "checked": false},
    {"label": "Tuesday", "value": "tuesday", "checked": false},
    {"label": "Wednesday", "value": "wednesday", "checked": false},
    {"label": "Thursday", "value": "thursday", "checked": false},
    {"label": "Friday", "value": "friday", "checked": false},
    {"label": "Saturday", "value": "saturday", "checked": false},
    {"label": "Sunday", "value": "sunday", "checked": false},
  ];

  Future<void> _submitDoctorRegistration() async {
    if (!formKey.currentState!.validate()) return;
    
    if (workingDays.isEmpty) {
      se("Please select at least one working day");
      return;
    }
    
    isLoading = true;
    setState(() {});
    
    await Future.delayed(Duration(seconds: 3));
    
    isLoading = false;
    setState(() {});
    
    ss("Doctor registration submitted successfully! Your credentials will be verified within 48 hours.");
    //navigateTo('GrlDoctorDashboardView')
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(),
              SizedBox(height: spMd),
              Text(
                "Submitting doctor registration...",
                style: TextStyle(
                  fontSize: 16,
                  color: primaryColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: spSm),
              Text(
                "Verifying medical credentials",
                style: TextStyle(
                  fontSize: 14,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Doctor Registration"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Form(
          key: formKey,
          child: Column(
            spacing: spMd,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header Section
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(spLg),
                decoration: BoxDecoration(
                  color: primaryColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusLg),
                ),
                child: Column(
                  spacing: spSm,
                  children: [
                    Icon(
                      Icons.medical_services,
                      size: 64,
                      color: primaryColor,
                    ),
                    Text(
                      "Medical Professional Registration",
                      style: TextStyle(
                        fontSize: fsH3,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "Join our healthcare network and provide medical consultations to patients worldwide. Your credentials will be thoroughly verified for patient safety.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: disabledBoldColor,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),

              // Personal Information
              Container(
                padding: EdgeInsets.all(spLg),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusLg),
                  boxShadow: [shadowMd],
                ),
                child: Column(
                  spacing: spMd,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.person, color: primaryColor, size: 24),
                        SizedBox(width: spSm),
                        Text(
                          "Personal Information",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                    
                    QImagePicker(
                      label: "Professional Photo",
                      value: profileImage,
                      hint: "Upload a professional medical headshot",
                      validator: Validator.required,
                      onChanged: (value) {
                        profileImage = value;
                        setState(() {});
                      },
                    ),
                    
                    QTextField(
                      label: "Full Name (Dr.)",
                      value: doctorName,
                      hint: "Dr. John Smith",
                      validator: Validator.required,
                      onChanged: (value) {
                        doctorName = value;
                        setState(() {});
                      },
                    ),
                    
                    QTextField(
                      label: "Professional Email",
                      value: doctorEmail,
                      hint: "Enter your professional email address",
                      validator: Validator.email,
                      onChanged: (value) {
                        doctorEmail = value;
                        setState(() {});
                      },
                    ),
                  ],
                ),
              ),

              // Medical Credentials
              Container(
                padding: EdgeInsets.all(spLg),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusLg),
                  boxShadow: [shadowMd],
                ),
                child: Column(
                  spacing: spMd,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.verified_user, color: primaryColor, size: 24),
                        SizedBox(width: spSm),
                        Text(
                          "Medical Credentials",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                    
                    QTextField(
                      label: "Medical License Number",
                      value: licenseNumber,
                      hint: "Enter your medical license number",
                      validator: Validator.required,
                      onChanged: (value) {
                        licenseNumber = value;
                        setState(() {});
                      },
                    ),
                    
                    Row(
                      spacing: spSm,
                      children: [
                        Expanded(
                          child: QDropdownField(
                            label: "Primary Specialty",
                            items: specialties,
                            value: specialty,
                            onChanged: (value, label) {
                              specialty = value;
                              setState(() {});
                            },
                          ),
                        ),
                        Expanded(
                          child: QDropdownField(
                            label: "Years of Experience",
                            items: experienceRanges,
                            value: yearsOfExperience,
                            onChanged: (value, label) {
                              yearsOfExperience = value;
                              setState(() {});
                            },
                          ),
                        ),
                      ],
                    ),
                    
                    QTextField(
                      label: "Sub-Specialty (Optional)",
                      value: subSpecialty,
                      hint: "e.g., Interventional Cardiology, Pediatric Surgery",
                      onChanged: (value) {
                        subSpecialty = value;
                        setState(() {});
                      },
                    ),
                    
                    QTextField(
                      label: "Hospital/Clinic Affiliation",
                      value: hospitalAffiliation,
                      hint: "Current hospital or clinic affiliation",
                      validator: Validator.required,
                      onChanged: (value) {
                        hospitalAffiliation = value;
                        setState(() {});
                      },
                    ),
                  ],
                ),
              ),

              // Education and Qualifications
              Container(
                padding: EdgeInsets.all(spLg),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusLg),
                  boxShadow: [shadowMd],
                ),
                child: Column(
                  spacing: spMd,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.school, color: primaryColor, size: 24),
                        SizedBox(width: spSm),
                        Text(
                          "Education & Qualifications",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                    
                    QMemoField(
                      label: "Medical Education",
                      value: education,
                      hint: "List your medical school, residency, fellowship details...",
                      validator: Validator.required,
                      onChanged: (value) {
                        education = value;
                        setState(() {});
                      },
                    ),
                    
                    QMultiImagePicker(
                      label: "Medical Certificates",
                      value: certifications,
                      hint: "Upload medical license, board certifications, etc.",
                      validator: (files) {
                        if (files == null || files.isEmpty) {
                          return "Please upload at least one medical certificate";
                        }
                        return null;
                      },
                      onChanged: (value) {
                        certifications = value;
                        setState(() {});
                      },
                    ),
                    
                    QMultiImagePicker(
                      label: "Additional Qualifications",
                      value: qualifications,
                      hint: "Upload additional certifications, awards, etc.",
                      onChanged: (value) {
                        qualifications = value;
                        setState(() {});
                      },
                    ),
                  ],
                ),
              ),

              // Professional Profile
              Container(
                padding: EdgeInsets.all(spLg),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusLg),
                  boxShadow: [shadowMd],
                ),
                child: Column(
                  spacing: spMd,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.description, color: primaryColor, size: 24),
                        SizedBox(width: spSm),
                        Text(
                          "Professional Profile",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                    
                    QMemoField(
                      label: "Professional Bio",
                      value: bio,
                      hint: "Describe your medical expertise, approach to patient care, and areas of interest...",
                      validator: Validator.required,
                      onChanged: (value) {
                        bio = value;
                        setState(() {});
                      },
                    ),
                    
                    QNumberField(
                      label: "Consultation Fee (USD)",
                      value: consultationFee,
                      hint: "e.g., 150",
                      validator: Validator.required,
                      onChanged: (value) {
                        consultationFee = value;
                        setState(() {});
                      },
                    ),
                    
                    QDropdownField(
                      label: "Preferred Languages",
                      items: languageOptions,
                      value: preferredLanguages,
                      onChanged: (value, label) {
                        preferredLanguages = value;
                        setState(() {});
                      },
                    ),
                  ],
                ),
              ),

              // Availability & Schedule
              Container(
                padding: EdgeInsets.all(spLg),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusLg),
                  boxShadow: [shadowMd],
                ),
                child: Column(
                  spacing: spMd,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.schedule, color: primaryColor, size: 24),
                        SizedBox(width: spSm),
                        Text(
                          "Availability & Schedule",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                    
                    QDropdownField(
                      label: "General Availability",
                      items: availabilityOptions,
                      value: availability,
                      onChanged: (value, label) {
                        availability = value;
                        setState(() {});
                      },
                    ),
                    
                    Text(
                      "Working Days",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                    
                    QSwitch(
                      items: weekDays,
                      value: weekDays.where((item) => item["checked"] == true).toList(),
                      onChanged: (values, ids) {
                        workingDays = values.map((item) => item["value"].toString()).toList();
                        for (var day in weekDays) {
                          day["checked"] = values.any((v) => v["value"] == day["value"]);
                        }
                        setState(() {});
                      },
                    ),
                    
                    Row(
                      spacing: spSm,
                      children: [
                        Expanded(
                          child: QTimePicker(
                            label: "Working Hours Start",
                            value: workingHoursStart.isNotEmpty ? TimeOfDay.fromDateTime(DateTime.parse("2024-01-01 $workingHoursStart")) : TimeOfDay(hour: 9, minute: 0),
                            onChanged: (value) {
                              workingHoursStart = value!.kkmm;
                              setState(() {});
                            },
                          ),
                        ),
                        Expanded(
                          child: QTimePicker(
                            label: "Working Hours End",
                            value: workingHoursEnd.isNotEmpty ? TimeOfDay.fromDateTime(DateTime.parse("2024-01-01 $workingHoursEnd")) : TimeOfDay(hour: 17, minute: 0),
                            onChanged: (value) {
                              workingHoursEnd = value!.kkmm;
                              setState(() {});
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Service Options
              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusLg),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  spacing: spMd,
                  children: [
                    QSwitch(
                      items: [
                        {
                          "label": "Available for telemedicine consultations",
                          "value": true,
                          "checked": telemedicineAvailable,
                        }
                      ],
                      value: [if (telemedicineAvailable) {"label": "Available for telemedicine consultations", "value": true, "checked": true}],
                      onChanged: (values, ids) {
                        telemedicineAvailable = values.isNotEmpty;
                        setState(() {});
                      },
                    ),
                    
                    QSwitch(
                      items: [
                        {
                          "label": "Available for in-person consultations",
                          "value": true,
                          "checked": inPersonConsultation,
                        }
                      ],
                      value: [if (inPersonConsultation) {"label": "Available for in-person consultations", "value": true, "checked": true}],
                      onChanged: (values, ids) {
                        inPersonConsultation = values.isNotEmpty;
                        setState(() {});
                      },
                    ),
                    
                    QSwitch(
                      items: [
                        {
                          "label": "Available for emergency consultations",
                          "value": true,
                          "checked": emergencyAvailable,
                        }
                      ],
                      value: [if (emergencyAvailable) {"label": "Available for emergency consultations", "value": true, "checked": true}],
                      onChanged: (values, ids) {
                        emergencyAvailable = values.isNotEmpty;
                        setState(() {});
                      },
                    ),
                  ],
                ),
              ),

              // Medical Platform Benefits
              Container(
                padding: EdgeInsets.all(spLg),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusLg),
                  boxShadow: [shadowMd],
                ),
                child: Column(
                  spacing: spMd,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Platform Benefits",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    
                    Row(
                      children: [
                        Icon(Icons.check_circle, color: successColor, size: 20),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Text(
                            "Verified medical professional badge",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                    
                    Row(
                      children: [
                        Icon(Icons.check_circle, color: successColor, size: 20),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Text(
                            "Access to secure patient management system",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                    
                    Row(
                      children: [
                        Icon(Icons.check_circle, color: successColor, size: 20),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Text(
                            "HIPAA-compliant telemedicine platform",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                    
                    Row(
                      children: [
                        Icon(Icons.check_circle, color: successColor, size: 20),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Text(
                            "Automated billing and payment processing",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                    
                    Row(
                      children: [
                        Icon(Icons.check_circle, color: successColor, size: 20),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Text(
                            "Professional liability insurance coverage",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Verification Notice
              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: warningColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                  border: Border.all(color: warningColor.withAlpha(40)),
                ),
                child: Column(
                  spacing: spSm,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.security, color: warningColor, size: 20),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Text(
                            "Credential Verification Process",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: warningColor,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Text(
                      "Your medical credentials will undergo thorough verification including license verification, board certification checks, and background screening. This process takes 24-48 hours for patient safety.",
                      style: TextStyle(
                        fontSize: 12,
                        color: warningColor,
                      ),
                    ),
                  ],
                ),
              ),

              // Submit Button
              Container(
                width: double.infinity,
                child: QButton(
                  label: "Submit Doctor Registration",
                  size: bs.md,
                  onPressed: _submitDoctorRegistration,
                ),
              ),

              // Medical Support
              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: infoColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                  border: Border.all(color: infoColor.withAlpha(40)),
                ),
                child: Column(
                  spacing: spSm,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.support_agent, color: infoColor, size: 20),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Text(
                            "Medical Professional Support",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: infoColor,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Text(
                      "For assistance with registration or questions about our medical platform, contact our medical affairs team at doctors@company.com or call 1-800-MEDICAL",
                      style: TextStyle(
                        fontSize: 12,
                        color: infoColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
