import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class MhaEditProfileView extends StatefulWidget {
  const MhaEditProfileView({super.key});

  @override
  State<MhaEditProfileView> createState() => _MhaEditProfileViewState();
}

class _MhaEditProfileViewState extends State<MhaEditProfileView> {
  final formKey = GlobalKey<FormState>();
  
  String firstName = "John";
  String lastName = "Doe";
  String email = "john.doe@email.com";
  String phone = "+1 234 567 8900";
  String dateOfBirth = "1990-01-15";
  String gender = "Male";
  String bloodType = "O+";
  String address = "123 Main Street, City, State 12345";
  String emergencyContact = "+1 987 654 3210";
  String emergencyContactName = "Jane Doe";
  String profileImage = "https://picsum.photos/150/150?random=1&keyword=person";
  bool notifications = true;
  bool healthReminders = true;
  bool medicationAlerts = true;

  final List<Map<String, dynamic>> genderOptions = [
    {"label": "Male", "value": "Male"},
    {"label": "Female", "value": "Female"},
    {"label": "Other", "value": "Other"},
  ];

  final List<Map<String, dynamic>> bloodTypeOptions = [
    {"label": "A+", "value": "A+"},
    {"label": "A-", "value": "A-"},
    {"label": "B+", "value": "B+"},
    {"label": "B-", "value": "B-"},
    {"label": "AB+", "value": "AB+"},
    {"label": "AB-", "value": "AB-"},
    {"label": "O+", "value": "O+"},
    {"label": "O-", "value": "O-"},
  ];

  void _saveProfile() async {
    if (formKey.currentState!.validate()) {
      showLoading();
      await Future.delayed(Duration(seconds: 2));
      hideLoading();
      ss("Profile updated successfully");
      back();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Profile"),
        actions: [
          IconButton(
            icon: Icon(Icons.check),
            onPressed: _saveProfile,
          ),
        ],
      ),
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: Column(
            spacing: spMd,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Profile Image Section
              Center(
                child: Column(
                  children: [
                    Container(
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(radiusLg),
                        border: Border.all(
                          color: primaryColor,
                          width: 3,
                        ),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(radiusLg),
                        child: Image.network(
                          profileImage,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SizedBox(height: spSm),
                    QButton(
                      label: "Change Photo",
                      size: bs.sm,
                      icon: Icons.camera_alt,
                      onPressed: () {
                        // Handle image picker
                      },
                    ),
                  ],
                ),
              ),

              // Personal Information
              Text(
                "Personal Information",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              
              Row(
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
                  SizedBox(width: spSm),
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
                label: "Email",
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

              QDatePicker(
                label: "Date of Birth",
                value: DateTime.parse(dateOfBirth),
                onChanged: (value) {
                  dateOfBirth = value.toString().split(' ')[0];
                  setState(() {});
                },
              ),

              Row(
                children: [
                  Expanded(
                    child: QDropdownField(
                      label: "Gender",
                      items: genderOptions,
                      value: gender,
                      onChanged: (value, label) {
                        gender = value;
                        setState(() {});
                      },
                    ),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: QDropdownField(
                      label: "Blood Type",
                      items: bloodTypeOptions,
                      value: bloodType,
                      onChanged: (value, label) {
                        bloodType = value;
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

              // Emergency Contact
              Text(
                "Emergency Contact",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),

              QTextField(
                label: "Emergency Contact Name",
                value: emergencyContactName,
                validator: Validator.required,
                onChanged: (value) {
                  emergencyContactName = value;
                  setState(() {});
                },
              ),

              QTextField(
                label: "Emergency Contact Phone",
                value: emergencyContact,
                validator: Validator.required,
                onChanged: (value) {
                  emergencyContact = value;
                  setState(() {});
                },
              ),

              // Notification Settings
              Text(
                "Notification Preferences",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),

              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.grey.withAlpha(25),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Column(
                  spacing: spSm,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.notifications,
                          color: primaryColor,
                          size: 20,
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Text(
                            "Push Notifications",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        Switch(
                          value: notifications,
                          onChanged: (value) {
                            notifications = value;
                            setState(() {});
                          },
                        ),
                      ],
                    ),
                    Divider(height: 1),
                    Row(
                      children: [
                        Icon(
                          Icons.health_and_safety,
                          color: primaryColor,
                          size: 20,
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Text(
                            "Health Reminders",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        Switch(
                          value: healthReminders,
                          onChanged: (value) {
                            healthReminders = value;
                            setState(() {});
                          },
                        ),
                      ],
                    ),
                    Divider(height: 1),
                    Row(
                      children: [
                        Icon(
                          Icons.medication,
                          color: primaryColor,
                          size: 20,
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Text(
                            "Medication Alerts",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        Switch(
                          value: medicationAlerts,
                          onChanged: (value) {
                            medicationAlerts = value;
                            setState(() {});
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              SizedBox(height: spLg),
              Container(
                width: double.infinity,
                child: QButton(
                  label: "Save Changes",
                  size: bs.md,
                  onPressed: _saveProfile,
                ),
              ),

              Container(
                width: double.infinity,
                child: QButton(
                  label: "Cancel",
                  size: bs.md,
                  onPressed: () {
                    back();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
