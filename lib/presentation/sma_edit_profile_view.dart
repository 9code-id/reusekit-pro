import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class SmaEditProfileView extends StatefulWidget {
  const SmaEditProfileView({super.key});

  @override
  State<SmaEditProfileView> createState() => _SmaEditProfileViewState();
}

class _SmaEditProfileViewState extends State<SmaEditProfileView> {
  String profileImage = "https://picsum.photos/300/300?random=1&keyword=profile";
  String fullName = "John Doe";
  String username = "johndoe";
  String bio = "Digital creator | Coffee lover | Travel enthusiast";
  String email = "john.doe@example.com";
  String phone = "+1 (555) 123-4567";
  String website = "https://johndoe.com";
  String location = "New York, USA";
  String dateOfBirth = "1990-01-15";
  String gender = "Male";
  bool isPrivateAccount = false;
  bool showOnlineStatus = true;
  bool allowTagging = true;

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Profile"),
        actions: [
          QButton(
            label: "Save",
            size: bs.sm,
            onPressed: () {
              if (formKey.currentState!.validate()) {
                ss("Profile updated successfully");
                back();
              }
            },
          ),
        ],
      ),
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: Column(
            spacing: spMd,
            children: [
              // Profile Image Section
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  children: [
                    Stack(
                      children: [
                        Container(
                          width: 120,
                          height: 120,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              image: NetworkImage(profileImage),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: primaryColor,
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: Colors.white,
                                width: 2,
                              ),
                            ),
                            child: Icon(
                              Icons.camera_alt,
                              color: Colors.white,
                              size: 20,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "Change Profile Photo",
                      style: TextStyle(
                        fontSize: 14,
                        color: primaryColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),

              // Basic Information
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spSm,
                  children: [
                    Text(
                      "Basic Information",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    
                    QTextField(
                      label: "Full Name",
                      value: fullName,
                      validator: Validator.required,
                      onChanged: (value) {
                        fullName = value;
                        setState(() {});
                      },
                    ),
                    
                    QTextField(
                      label: "Username",
                      value: username,
                      validator: Validator.required,
                      onChanged: (value) {
                        username = value;
                        setState(() {});
                      },
                    ),
                    
                    QMemoField(
                      label: "Bio",
                      value: bio,
                      hint: "Tell people about yourself",
                      onChanged: (value) {
                        bio = value;
                        setState(() {});
                      },
                    ),
                  ],
                ),
              ),

              // Contact Information
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spSm,
                  children: [
                    Text(
                      "Contact Information",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
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
                      onChanged: (value) {
                        phone = value;
                        setState(() {});
                      },
                    ),
                    
                    QTextField(
                      label: "Website",
                      value: website,
                      hint: "https://yourwebsite.com",
                      onChanged: (value) {
                        website = value;
                        setState(() {});
                      },
                    ),
                    
                    QTextField(
                      label: "Location",
                      value: location,
                      hint: "City, Country",
                      onChanged: (value) {
                        location = value;
                        setState(() {});
                      },
                    ),
                  ],
                ),
              ),

              // Personal Information
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spSm,
                  children: [
                    Text(
                      "Personal Information",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    
                    QDatePicker(
                      label: "Date of Birth",
                      value: DateTime.parse(dateOfBirth),
                      onChanged: (value) {
                        dateOfBirth = value.toString().split(' ')[0];
                        setState(() {});
                      },
                    ),
                    
                    QDropdownField(
                      label: "Gender",
                      items: [
                        {"label": "Male", "value": "Male"},
                        {"label": "Female", "value": "Female"},
                        {"label": "Other", "value": "Other"},
                        {"label": "Prefer not to say", "value": "Prefer not to say"},
                      ],
                      value: gender,
                      onChanged: (value, label) {
                        gender = value;
                        setState(() {});
                      },
                    ),
                  ],
                ),
              ),

              // Privacy Settings
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spSm,
                  children: [
                    Text(
                      "Privacy Settings",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    
                    QSwitch(
                      items: [
                        {
                          "label": "Private Account",
                          "value": true,
                          "checked": isPrivateAccount,
                        }
                      ],
                      value: [
                        if (isPrivateAccount)
                          {
                            "label": "Private Account",
                            "value": true,
                            "checked": true
                          }
                      ],
                      onChanged: (values, ids) {
                        isPrivateAccount = values.isNotEmpty;
                        setState(() {});
                      },
                    ),
                    
                    QSwitch(
                      items: [
                        {
                          "label": "Show Online Status",
                          "value": true,
                          "checked": showOnlineStatus,
                        }
                      ],
                      value: [
                        if (showOnlineStatus)
                          {
                            "label": "Show Online Status",
                            "value": true,
                            "checked": true
                          }
                      ],
                      onChanged: (values, ids) {
                        showOnlineStatus = values.isNotEmpty;
                        setState(() {});
                      },
                    ),
                    
                    QSwitch(
                      items: [
                        {
                          "label": "Allow Tagging",
                          "value": true,
                          "checked": allowTagging,
                        }
                      ],
                      value: [
                        if (allowTagging)
                          {
                            "label": "Allow Tagging",
                            "value": true,
                            "checked": true
                          }
                      ],
                      onChanged: (values, ids) {
                        allowTagging = values.isNotEmpty;
                        setState(() {});
                      },
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
