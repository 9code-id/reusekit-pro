import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class HhaGuestRegistrationView extends StatefulWidget {
  const HhaGuestRegistrationView({super.key});

  @override
  State<HhaGuestRegistrationView> createState() => _HhaGuestRegistrationViewState();
}

class _HhaGuestRegistrationViewState extends State<HhaGuestRegistrationView> {
  final formKey = GlobalKey<FormState>();
  
  String firstName = "";
  String lastName = "";
  String email = "";
  String phone = "";
  String nationality = "";
  String idType = "";
  String idNumber = "";
  String address = "";
  String emergencyContactName = "";
  String emergencyContactPhone = "";
  String specialRequests = "";
  bool hasVehicle = false;
  String vehicleNumber = "";
  bool agreeToTerms = false;

  List<Map<String, dynamic>> idTypeItems = [
    {"label": "Passport", "value": "passport"},
    {"label": "National ID", "value": "national_id"},
    {"label": "Driver's License", "value": "drivers_license"},
    {"label": "Other", "value": "other"},
  ];

  List<Map<String, dynamic>> nationalityItems = [
    {"label": "Indonesia", "value": "indonesia"},
    {"label": "Singapore", "value": "singapore"},
    {"label": "Malaysia", "value": "malaysia"},
    {"label": "Thailand", "value": "thailand"},
    {"label": "Philippines", "value": "philippines"},
    {"label": "Vietnam", "value": "vietnam"},
    {"label": "Other", "value": "other"},
  ];

  void _submitRegistration() async {
    if (formKey.currentState!.validate()) {
      if (!agreeToTerms) {
        se("Please agree to terms and conditions");
        return;
      }

      showLoading();
      // Simulate API call
      await Future.delayed(Duration(seconds: 2));
      hideLoading();

      ss("Guest registration completed successfully");
      // Navigate to guest profile or dashboard
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Guest Registration"),
        actions: [
          TextButton(
            onPressed: () {
              // Navigate to sign in
            },
            child: Text(
              "Sign In",
              style: TextStyle(
                color: primaryColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: spMd,
            children: [
              // Header Section
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: primaryColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusMd),
                ),
                child: Column(
                  children: [
                    Icon(
                      Icons.hotel,
                      size: 48,
                      color: primaryColor,
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "Welcome to Grand Hotel",
                      style: TextStyle(
                        fontSize: fsH4,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "Please complete your registration to access all hotel services",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),

              // Personal Information Section
              Text(
                "Personal Information",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),

              Row(
                spacing: spSm,
                children: [
                  Expanded(
                    child: QTextField(
                      label: "First Name",
                      value: firstName,
                      validator: Validator.required,
                      onChanged: (value) {
                        firstName = value;
                        setState(() {});
                      },
                    ),
                  ),
                  Expanded(
                    child: QTextField(
                      label: "Last Name",
                      value: lastName,
                      validator: Validator.required,
                      onChanged: (value) {
                        lastName = value;
                        setState(() {});
                      },
                    ),
                  ),
                ],
              ),

              QTextField(
                label: "Email Address",
                value: email,
                validator: Validator.email,
                onChanged: (value) {
                  email = value;
                  setState(() {});
                },
              ),

              QTextField(
                label: "Phone Number",
                value: phone,
                validator: Validator.required,
                onChanged: (value) {
                  phone = value;
                  setState(() {});
                },
              ),

              QDropdownField(
                label: "Nationality",
                items: nationalityItems,
                value: nationality,
                onChanged: (value, label) {
                  nationality = value;
                  setState(() {});
                },
              ),

              // Identification Section
              Text(
                "Identification",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),

              Row(
                spacing: spSm,
                children: [
                  Expanded(
                    child: QDropdownField(
                      label: "ID Type",
                      items: idTypeItems,
                      value: idType,
                      onChanged: (value, label) {
                        idType = value;
                        setState(() {});
                      },
                    ),
                  ),
                  Expanded(
                    child: QTextField(
                      label: "ID Number",
                      value: idNumber,
                      validator: Validator.required,
                      onChanged: (value) {
                        idNumber = value;
                        setState(() {});
                      },
                    ),
                  ),
                ],
              ),

              QMemoField(
                label: "Address",
                value: address,
                validator: Validator.required,
                onChanged: (value) {
                  address = value;
                  setState(() {});
                },
              ),

              // Emergency Contact Section
              Text(
                "Emergency Contact",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),

              Row(
                spacing: spSm,
                children: [
                  Expanded(
                    child: QTextField(
                      label: "Contact Name",
                      value: emergencyContactName,
                      validator: Validator.required,
                      onChanged: (value) {
                        emergencyContactName = value;
                        setState(() {});
                      },
                    ),
                  ),
                  Expanded(
                    child: QTextField(
                      label: "Contact Phone",
                      value: emergencyContactPhone,
                      validator: Validator.required,
                      onChanged: (value) {
                        emergencyContactPhone = value;
                        setState(() {});
                      },
                    ),
                  ),
                ],
              ),

              // Vehicle Information Section
              Text(
                "Vehicle Information (Optional)",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),

              QSwitch(
                items: [
                  {
                    "label": "I have a vehicle",
                    "value": true,
                    "checked": hasVehicle,
                  }
                ],
                value: hasVehicle ? [{"label": "I have a vehicle", "value": true, "checked": true}] : [],
                onChanged: (values, ids) {
                  hasVehicle = values.isNotEmpty;
                  setState(() {});
                },
              ),

              if (hasVehicle)
                QTextField(
                  label: "Vehicle License Number",
                  value: vehicleNumber,
                  onChanged: (value) {
                    vehicleNumber = value;
                    setState(() {});
                  },
                ),

              // Special Requests Section
              QMemoField(
                label: "Special Requests",
                value: specialRequests,
                hint: "Any special requirements or preferences during your stay",
                onChanged: (value) {
                  specialRequests = value;
                  setState(() {});
                },
              ),

              // Terms and Conditions
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  border: Border.all(color: disabledOutlineBorderColor),
                  borderRadius: BorderRadius.circular(radiusMd),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spSm,
                  children: [
                    Text(
                      "Terms and Conditions",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "By registering as a guest, you agree to:",
                      style: TextStyle(color: disabledBoldColor),
                    ),
                    Text(
                      "• Provide accurate and complete information\n• Follow hotel policies and regulations\n• Be responsible for any damages or losses\n• Allow verification of identification documents",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                    QSwitch(
                      items: [
                        {
                          "label": "I agree to the terms and conditions",
                          "value": true,
                          "checked": agreeToTerms,
                        }
                      ],
                      value: agreeToTerms ? [{"label": "I agree to the terms and conditions", "value": true, "checked": true}] : [],
                      onChanged: (values, ids) {
                        agreeToTerms = values.isNotEmpty;
                        setState(() {});
                      },
                    ),
                  ],
                ),
              ),

              // Registration Button
              Container(
                width: double.infinity,
                child: QButton(
                  label: "Complete Registration",
                  size: bs.md,
                  onPressed: _submitRegistration,
                ),
              ),

              // Sign In Link
              Center(
                child: GestureDetector(
                  onTap: () {
                    // Navigate to sign in
                  },
                  child: RichText(
                    text: TextSpan(
                      text: "Already have an account? ",
                      style: TextStyle(
                        color: disabledBoldColor,
                        fontSize: 14,
                      ),
                      children: [
                        TextSpan(
                          text: "Sign In",
                          style: TextStyle(
                            color: primaryColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
