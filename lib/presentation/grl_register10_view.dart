import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlRegister10View extends StatefulWidget {
  @override
  State<GrlRegister10View> createState() => _GrlRegister10ViewState();
}

class _GrlRegister10ViewState extends State<GrlRegister10View> {
  final formKey = GlobalKey<FormState>();
  
  String driverName = "";
  String driverEmail = "";
  String licenseNumber = "";
  String licenseExpiry = "";
  String vehicleType = "";
  String vehicleMake = "";
  String vehicleModel = "";
  String vehicleYear = "";
  String vehiclePlate = "";
  String vehicleColor = "";
  String insurance = "";
  String insuranceExpiry = "";
  String experience = "";
  String profileImage = "";
  String vehicleImage = "";
  List<String> drivingDocuments = [];
  List<String> serviceAreas = [];
  String emergencyContact = "";
  String emergencyPhone = "";
  bool backgroundCheckConsent = false;
  bool flexibleHours = false;
  bool weekendAvailable = false;
  bool nightShiftAvailable = false;
  List<String> workingDays = [];
  String preferredWorkingHours = "";
  bool isLoading = false;

  List<Map<String, dynamic>> vehicleTypes = [
    {"label": "Sedan", "value": "sedan"},
    {"label": "SUV", "value": "suv"},
    {"label": "Hatchback", "value": "hatchback"},
    {"label": "Coupe", "value": "coupe"},
    {"label": "Truck", "value": "truck"},
    {"label": "Van", "value": "van"},
    {"label": "Motorcycle", "value": "motorcycle"},
    {"label": "Other", "value": "other"},
  ];

  List<Map<String, dynamic>> experienceRanges = [
    {"label": "Less than 1 year", "value": "0-1"},
    {"label": "1-3 years", "value": "1-3"},
    {"label": "4-7 years", "value": "4-7"},
    {"label": "8-15 years", "value": "8-15"},
    {"label": "15+ years", "value": "15+"},
  ];

  List<Map<String, dynamic>> workingHoursOptions = [
    {"label": "Morning (6 AM - 12 PM)", "value": "morning"},
    {"label": "Afternoon (12 PM - 6 PM)", "value": "afternoon"},
    {"label": "Evening (6 PM - 12 AM)", "value": "evening"},
    {"label": "Night (12 AM - 6 AM)", "value": "night"},
    {"label": "Flexible", "value": "flexible"},
  ];

  List<Map<String, dynamic>> areaOptions = [
    {"label": "Downtown", "value": "downtown", "checked": false},
    {"label": "Airport", "value": "airport", "checked": false},
    {"label": "Business District", "value": "business", "checked": false},
    {"label": "Residential Areas", "value": "residential", "checked": false},
    {"label": "Shopping Centers", "value": "shopping", "checked": false},
    {"label": "Hotels & Tourism", "value": "hotels", "checked": false},
    {"label": "Medical Centers", "value": "medical", "checked": false},
    {"label": "University Area", "value": "university", "checked": false},
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

  Future<void> _submitDriverRegistration() async {
    if (!formKey.currentState!.validate()) return;
    
    if (!backgroundCheckConsent) {
      se("Please consent to background check for driver safety verification");
      return;
    }
    
    if (serviceAreas.isEmpty) {
      se("Please select at least one service area");
      return;
    }
    
    if (workingDays.isEmpty) {
      se("Please select at least one working day");
      return;
    }
    
    isLoading = true;
    setState(() {});
    
    await Future.delayed(Duration(seconds: 3));
    
    isLoading = false;
    setState(() {});
    
    ss("Driver registration submitted successfully! Your application will be reviewed within 24 hours.");
    //navigateTo('GrlDriverDashboardView')
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
                "Submitting driver registration...",
                style: TextStyle(
                  fontSize: 16,
                  color: primaryColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: spSm),
              Text(
                "Processing your application",
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
        title: Text("Driver Registration"),
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
                      Icons.local_taxi,
                      size: 64,
                      color: primaryColor,
                    ),
                    Text(
                      "Become a Driver Partner",
                      style: TextStyle(
                        fontSize: fsH3,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "Join our driver network and start earning by providing safe and reliable transportation services. Set your own schedule and grow your income.",
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
                      label: "Profile Photo",
                      value: profileImage,
                      hint: "Upload a clear photo of yourself",
                      validator: Validator.required,
                      onChanged: (value) {
                        profileImage = value;
                        setState(() {});
                      },
                    ),
                    
                    QTextField(
                      label: "Full Name",
                      value: driverName,
                      hint: "Enter your full name as on license",
                      validator: Validator.required,
                      onChanged: (value) {
                        driverName = value;
                        setState(() {});
                      },
                    ),
                    
                    QTextField(
                      label: "Email Address",
                      value: driverEmail,
                      hint: "Enter your email address",
                      validator: Validator.email,
                      onChanged: (value) {
                        driverEmail = value;
                        setState(() {});
                      },
                    ),
                    
                    Row(
                      spacing: spSm,
                      children: [
                        Expanded(
                          child: QTextField(
                            label: "Emergency Contact Name",
                            value: emergencyContact,
                            hint: "Emergency contact person",
                            validator: Validator.required,
                            onChanged: (value) {
                              emergencyContact = value;
                              setState(() {});
                            },
                          ),
                        ),
                        Expanded(
                          child: QTextField(
                            label: "Emergency Phone",
                            value: emergencyPhone,
                            hint: "Emergency contact number",
                            validator: Validator.required,
                            onChanged: (value) {
                              emergencyPhone = value;
                              setState(() {});
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Driving License Information
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
                        Icon(Icons.credit_card, color: primaryColor, size: 24),
                        SizedBox(width: spSm),
                        Text(
                          "Driving License Information",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                    
                    QTextField(
                      label: "Driver License Number",
                      value: licenseNumber,
                      hint: "Enter your driver license number",
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
                          child: QDatePicker(
                            label: "License Expiry Date",
                            value: licenseExpiry.isNotEmpty ? DateTime.parse(licenseExpiry) : DateTime.now().add(Duration(days: 365)),
                            onChanged: (value) {
                              licenseExpiry = value.toString();
                              setState(() {});
                            },
                          ),
                        ),
                        Expanded(
                          child: QDropdownField(
                            label: "Driving Experience",
                            items: experienceRanges,
                            value: experience,
                            onChanged: (value, label) {
                              experience = value;
                              setState(() {});
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Vehicle Information
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
                        Icon(Icons.directions_car, color: primaryColor, size: 24),
                        SizedBox(width: spSm),
                        Text(
                          "Vehicle Information",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                    
                    QImagePicker(
                      label: "Vehicle Photo",
                      value: vehicleImage,
                      hint: "Upload a clear photo of your vehicle",
                      validator: Validator.required,
                      onChanged: (value) {
                        vehicleImage = value;
                        setState(() {});
                      },
                    ),
                    
                    Row(
                      spacing: spSm,
                      children: [
                        Expanded(
                          child: QDropdownField(
                            label: "Vehicle Type",
                            items: vehicleTypes,
                            value: vehicleType,
                            onChanged: (value, label) {
                              vehicleType = value;
                              setState(() {});
                            },
                          ),
                        ),
                        Expanded(
                          child: QTextField(
                            label: "Vehicle Year",
                            value: vehicleYear,
                            hint: "e.g., 2020",
                            validator: Validator.required,
                            onChanged: (value) {
                              vehicleYear = value;
                              setState(() {});
                            },
                          ),
                        ),
                      ],
                    ),
                    
                    Row(
                      spacing: spSm,
                      children: [
                        Expanded(
                          child: QTextField(
                            label: "Vehicle Make",
                            value: vehicleMake,
                            hint: "e.g., Toyota, Honda",
                            validator: Validator.required,
                            onChanged: (value) {
                              vehicleMake = value;
                              setState(() {});
                            },
                          ),
                        ),
                        Expanded(
                          child: QTextField(
                            label: "Vehicle Model",
                            value: vehicleModel,
                            hint: "e.g., Camry, Civic",
                            validator: Validator.required,
                            onChanged: (value) {
                              vehicleModel = value;
                              setState(() {});
                            },
                          ),
                        ),
                      ],
                    ),
                    
                    Row(
                      spacing: spSm,
                      children: [
                        Expanded(
                          child: QTextField(
                            label: "License Plate",
                            value: vehiclePlate,
                            hint: "Vehicle license plate number",
                            validator: Validator.required,
                            onChanged: (value) {
                              vehiclePlate = value;
                              setState(() {});
                            },
                          ),
                        ),
                        Expanded(
                          child: QTextField(
                            label: "Vehicle Color",
                            value: vehicleColor,
                            hint: "e.g., White, Black, Silver",
                            validator: Validator.required,
                            onChanged: (value) {
                              vehicleColor = value;
                              setState(() {});
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Insurance Information
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
                        Icon(Icons.security, color: primaryColor, size: 24),
                        SizedBox(width: spSm),
                        Text(
                          "Insurance Information",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                    
                    QTextField(
                      label: "Insurance Company",
                      value: insurance,
                      hint: "Name of your insurance company",
                      validator: Validator.required,
                      onChanged: (value) {
                        insurance = value;
                        setState(() {});
                      },
                    ),
                    
                    QDatePicker(
                      label: "Insurance Expiry Date",
                      value: insuranceExpiry.isNotEmpty ? DateTime.parse(insuranceExpiry) : DateTime.now().add(Duration(days: 365)),
                      onChanged: (value) {
                        insuranceExpiry = value.toString();
                        setState(() {});
                      },
                    ),
                    
                    QMultiImagePicker(
                      label: "Driving Documents",
                      value: drivingDocuments,
                      hint: "Upload license, registration, insurance documents",
                      validator: (files) {
                        if (files == null || files.isEmpty) {
                          return "Please upload required driving documents";
                        }
                        return null;
                      },
                      onChanged: (value) {
                        drivingDocuments = value;
                        setState(() {});
                      },
                    ),
                  ],
                ),
              ),

              // Service Areas
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
                        Icon(Icons.location_on, color: primaryColor, size: 24),
                        SizedBox(width: spSm),
                        Text(
                          "Service Areas",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                    
                    Text(
                      "Select the areas where you're willing to provide service",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                    
                    QSwitch(
                      items: areaOptions,
                      value: areaOptions.where((item) => item["checked"] == true).toList(),
                      onChanged: (values, ids) {
                        serviceAreas = values.map((item) => item["value"].toString()).toList();
                        for (var area in areaOptions) {
                          area["checked"] = values.any((v) => v["value"] == area["value"]);
                        }
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
                      label: "Preferred Working Hours",
                      items: workingHoursOptions,
                      value: preferredWorkingHours,
                      onChanged: (value, label) {
                        preferredWorkingHours = value;
                        setState(() {});
                      },
                    ),
                    
                    Text(
                      "Available Days",
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
                  ],
                ),
              ),

              // Work Preferences
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
                          "label": "I'm available for flexible hours",
                          "value": true,
                          "checked": flexibleHours,
                        }
                      ],
                      value: [if (flexibleHours) {"label": "I'm available for flexible hours", "value": true, "checked": true}],
                      onChanged: (values, ids) {
                        flexibleHours = values.isNotEmpty;
                        setState(() {});
                      },
                    ),
                    
                    QSwitch(
                      items: [
                        {
                          "label": "I'm available for weekend shifts",
                          "value": true,
                          "checked": weekendAvailable,
                        }
                      ],
                      value: [if (weekendAvailable) {"label": "I'm available for weekend shifts", "value": true, "checked": true}],
                      onChanged: (values, ids) {
                        weekendAvailable = values.isNotEmpty;
                        setState(() {});
                      },
                    ),
                    
                    QSwitch(
                      items: [
                        {
                          "label": "I'm available for night shifts",
                          "value": true,
                          "checked": nightShiftAvailable,
                        }
                      ],
                      value: [if (nightShiftAvailable) {"label": "I'm available for night shifts", "value": true, "checked": true}],
                      onChanged: (values, ids) {
                        nightShiftAvailable = values.isNotEmpty;
                        setState(() {});
                      },
                    ),
                  ],
                ),
              ),

              // Background Check Consent
              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusLg),
                  boxShadow: [shadowSm],
                ),
                child: QSwitch(
                  items: [
                    {
                      "label": "I consent to background check and vehicle inspection for safety verification",
                      "value": true,
                      "checked": backgroundCheckConsent,
                    }
                  ],
                  value: [if (backgroundCheckConsent) {"label": "I consent to background check and vehicle inspection for safety verification", "value": true, "checked": true}],
                  onChanged: (values, ids) {
                    backgroundCheckConsent = values.isNotEmpty;
                    setState(() {});
                  },
                ),
              ),

              // Driver Benefits
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
                      "Driver Benefits",
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
                            "Flexible schedule - work when you want",
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
                            "Weekly earnings with instant cash-out option",
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
                            "Driver insurance coverage during trips",
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
                            "24/7 driver support and roadside assistance",
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
                            "Performance bonuses and driver rewards",
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

              // Review Process Notice
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
                        Icon(Icons.schedule, color: warningColor, size: 20),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Text(
                            "Application Review Process",
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
                      "Your application will be reviewed within 24 hours. This includes background check, document verification, and vehicle inspection scheduling. You'll be notified via email about your approval status.",
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
                  label: "Submit Driver Application",
                  size: bs.md,
                  onPressed: _submitDriverRegistration,
                ),
              ),

              // Support Information
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
                            "Driver Support",
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
                      "Questions about becoming a driver? Contact our driver support team at drivers@company.com or call 1-800-DRIVERS for assistance with your application.",
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
