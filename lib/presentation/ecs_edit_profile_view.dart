import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class EcsEditProfileView extends StatefulWidget {
  const EcsEditProfileView({super.key});

  @override
  State<EcsEditProfileView> createState() => _EcsEditProfileViewState();
}

class _EcsEditProfileViewState extends State<EcsEditProfileView> {
  final formKey = GlobalKey<FormState>();
  
  String firstName = "John";
  String lastName = "Doe";
  String email = "john.doe@email.com";
  String phone = "+1 234 567 8900";
  String dateOfBirth = "1990-01-15";
  String gender = "Male";
  String profileImage = "";
  bool emailNotifications = true;
  bool smsNotifications = false;
  bool pushNotifications = true;

  List<Map<String, dynamic>> genderOptions = [
    {"label": "Male", "value": "Male"},
    {"label": "Female", "value": "Female"},
    {"label": "Other", "value": "Other"},
    {"label": "Prefer not to say", "value": "Prefer not to say"},
  ];

  bool loading = false;

  void _saveProfile() async {
    if (formKey.currentState!.validate()) {
      loading = true;
      setState(() {});

      // Simulate API call
      await Future.delayed(Duration(seconds: 2));

      loading = false;
      setState(() {});

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
          QButton(
            label: "Save",
            size: bs.sm,
            onPressed: loading ? null : _saveProfile,
          ),
        ],
      ),
      body: loading
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                spacing: spMd,
                children: [
                  CircularProgressIndicator(),
                  Text(
                    "Updating profile...",
                    style: TextStyle(
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ),
            )
          : Form(
              key: formKey,
              child: SingleChildScrollView(
                padding: EdgeInsets.all(spMd),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spMd,
                  children: [
                    // Profile Picture Section
                    Text(
                      "Profile Picture",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(spMd),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(radiusMd),
                        boxShadow: [shadowSm],
                      ),
                      child: Column(
                        children: [
                          Container(
                            width: 120,
                            height: 120,
                            decoration: BoxDecoration(
                              color: primaryColor.withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusLg),
                              border: Border.all(
                                color: primaryColor,
                                width: 2,
                              ),
                            ),
                            child: Icon(
                              Icons.person,
                              size: 60,
                              color: primaryColor,
                            ),
                          ),
                          SizedBox(height: spMd),
                          QButton(
                            label: "Change Photo",
                            size: bs.sm,
                            onPressed: () {
                              // Open image picker
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
                    Container(
                      padding: EdgeInsets.all(spMd),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(radiusMd),
                        boxShadow: [shadowSm],
                      ),
                      child: Column(
                        spacing: spMd,
                        children: [
                          Row(
                            spacing: spMd,
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
                          QDatePicker(
                            label: "Date of Birth",
                            value: DateTime.parse(dateOfBirth),
                            onChanged: (value) {
                              dateOfBirth = value.toIso8601String().split('T')[0];
                              setState(() {});
                            },
                          ),
                          QDropdownField(
                            label: "Gender",
                            items: genderOptions,
                            value: gender,
                            onChanged: (value, label) {
                              gender = value;
                              setState(() {});
                            },
                          ),
                        ],
                      ),
                    ),

                    // Notification Preferences
                    Text(
                      "Notification Preferences",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(spMd),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(radiusMd),
                        boxShadow: [shadowSm],
                      ),
                      child: Column(
                        spacing: spMd,
                        children: [
                          // Email Notifications
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  spacing: spXs,
                                  children: [
                                    Text(
                                      "Email Notifications",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        color: primaryColor,
                                      ),
                                    ),
                                    Text(
                                      "Receive order updates and promotions via email",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Switch(
                                value: emailNotifications,
                                onChanged: (value) {
                                  emailNotifications = value;
                                  setState(() {});
                                },
                              ),
                            ],
                          ),
                          Divider(color: disabledOutlineBorderColor),
                          // SMS Notifications
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  spacing: spXs,
                                  children: [
                                    Text(
                                      "SMS Notifications",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        color: primaryColor,
                                      ),
                                    ),
                                    Text(
                                      "Receive important updates via SMS",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Switch(
                                value: smsNotifications,
                                onChanged: (value) {
                                  smsNotifications = value;
                                  setState(() {});
                                },
                              ),
                            ],
                          ),
                          Divider(color: disabledOutlineBorderColor),
                          // Push Notifications
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  spacing: spXs,
                                  children: [
                                    Text(
                                      "Push Notifications",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        color: primaryColor,
                                      ),
                                    ),
                                    Text(
                                      "Receive app notifications on your device",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Switch(
                                value: pushNotifications,
                                onChanged: (value) {
                                  pushNotifications = value;
                                  setState(() {});
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    // Account Actions
                    Text(
                      "Account Actions",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(radiusMd),
                        boxShadow: [shadowSm],
                      ),
                      child: Column(
                        children: [
                          GestureDetector(
                            onTap: () {
                              //navigateTo('change_password')
                            },
                            child: Container(
                              padding: EdgeInsets.all(spMd),
                              decoration: BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                    color: disabledOutlineBorderColor,
                                    width: 1,
                                  ),
                                ),
                              ),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.lock,
                                    color: primaryColor,
                                    size: 20,
                                  ),
                                  SizedBox(width: spMd),
                                  Expanded(
                                    child: Text(
                                      "Change Password",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        color: primaryColor,
                                      ),
                                    ),
                                  ),
                                  Icon(
                                    Icons.chevron_right,
                                    color: disabledBoldColor,
                                    size: 20,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () async {
                              bool isConfirmed = await confirm("Are you sure you want to delete your account? This action cannot be undone.");
                              if (isConfirmed) {
                                //navigateTo('delete_account_confirmation')
                              }
                            },
                            child: Container(
                              padding: EdgeInsets.all(spMd),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.delete_forever,
                                    color: dangerColor,
                                    size: 20,
                                  ),
                                  SizedBox(width: spMd),
                                  Expanded(
                                    child: Text(
                                      "Delete Account",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        color: dangerColor,
                                      ),
                                    ),
                                  ),
                                  Icon(
                                    Icons.chevron_right,
                                    color: disabledBoldColor,
                                    size: 20,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Save Button
                    Container(
                      width: double.infinity,
                      child: QButton(
                        label: "Save Changes",
                        size: bs.md,
                        onPressed: _saveProfile,
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
