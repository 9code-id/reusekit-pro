import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class FdaEditProfileView extends StatefulWidget {
  const FdaEditProfileView({super.key});

  @override
  State<FdaEditProfileView> createState() => _FdaEditProfileViewState();
}

class _FdaEditProfileViewState extends State<FdaEditProfileView> {
  final formKey = GlobalKey<FormState>();
  
  String firstName = "John";
  String lastName = "Doe";
  String email = "john.doe@email.com";
  String phone = "+1 234 567 8900";
  String dateOfBirth = "1990-05-15";
  String gender = "male";
  String profileImage = "https://picsum.photos/150/150?random=1&keyword=person";
  
  // Address Information
  String streetAddress = "123 Main Street";
  String city = "New York";
  String state = "NY";
  String zipCode = "10001";
  String country = "United States";
  
  // Preferences
  List<String> dietaryRestrictions = ["vegetarian"];
  String preferredCuisine = "italian";
  bool emailNotifications = true;
  bool pushNotifications = true;
  bool smsNotifications = false;
  bool marketingEmails = true;

  final List<Map<String, dynamic>> genderOptions = [
    {"label": "Male", "value": "male"},
    {"label": "Female", "value": "female"},
    {"label": "Other", "value": "other"},
    {"label": "Prefer not to say", "value": "not_specified"},
  ];

  final List<Map<String, dynamic>> cuisineOptions = [
    {"label": "Italian", "value": "italian"},
    {"label": "Chinese", "value": "chinese"},
    {"label": "Mexican", "value": "mexican"},
    {"label": "Indian", "value": "indian"},
    {"label": "Thai", "value": "thai"},
    {"label": "Japanese", "value": "japanese"},
    {"label": "American", "value": "american"},
    {"label": "Mediterranean", "value": "mediterranean"},
  ];

  final List<Map<String, dynamic>> dietaryOptions = [
    {"label": "Vegetarian", "value": "vegetarian", "checked": false},
    {"label": "Vegan", "value": "vegan", "checked": false},
    {"label": "Gluten-Free", "value": "gluten_free", "checked": false},
    {"label": "Dairy-Free", "value": "dairy_free", "checked": false},
    {"label": "Nut-Free", "value": "nut_free", "checked": false},
    {"label": "Keto", "value": "keto", "checked": false},
    {"label": "Low-Carb", "value": "low_carb", "checked": false},
    {"label": "Halal", "value": "halal", "checked": false},
  ];

  @override
  void initState() {
    super.initState();
    _initializeDietaryRestrictions();
  }

  void _initializeDietaryRestrictions() {
    for (var option in dietaryOptions) {
      option["checked"] = dietaryRestrictions.contains(option["value"]);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Profile"),
        actions: [
          TextButton(
            onPressed: _saveProfile,
            child: Text(
              "Save",
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
              // Profile Picture Section
              Center(
                child: Column(
                  children: [
                    Stack(
                      children: [
                        Container(
                          width: 120,
                          height: 120,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(radiusLg),
                            border: Border.all(color: primaryColor, width: 3),
                            boxShadow: [shadowMd],
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(radiusLg),
                            child: Image.network(
                              profileImage,
                              width: 120,
                              height: 120,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: GestureDetector(
                            onTap: _changeProfilePicture,
                            child: Container(
                              padding: EdgeInsets.all(spSm),
                              decoration: BoxDecoration(
                                color: primaryColor,
                                borderRadius: BorderRadius.circular(radiusLg),
                                border: Border.all(color: Colors.white, width: 2),
                              ),
                              child: Icon(
                                Icons.camera_alt,
                                color: Colors.white,
                                size: 20,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "Tap to change photo",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),

              // Personal Information
              Text(
                "Personal Information",
                style: TextStyle(
                  fontSize: fsH5,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),

              QTextField(
                label: "First Name",
                value: firstName,
                validator: Validator.required,
                onChanged: (value) {
                  firstName = value;
                  setState(() {});
                },
              ),

              QTextField(
                label: "Last Name",
                value: lastName,
                validator: Validator.required,
                onChanged: (value) {
                  lastName = value;
                  setState(() {});
                },
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
                  dateOfBirth = value.toString().split(' ')[0];
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

              // Address Information
              Text(
                "Address Information",
                style: TextStyle(
                  fontSize: fsH5,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),

              QTextField(
                label: "Street Address",
                value: streetAddress,
                validator: Validator.required,
                onChanged: (value) {
                  streetAddress = value;
                  setState(() {});
                },
              ),

              Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: QTextField(
                      label: "City",
                      value: city,
                      validator: Validator.required,
                      onChanged: (value) {
                        city = value;
                        setState(() {});
                      },
                    ),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: QTextField(
                      label: "State",
                      value: state,
                      validator: Validator.required,
                      onChanged: (value) {
                        state = value;
                        setState(() {});
                      },
                    ),
                  ),
                ],
              ),

              Row(
                children: [
                  Expanded(
                    child: QTextField(
                      label: "ZIP Code",
                      value: zipCode,
                      validator: Validator.required,
                      onChanged: (value) {
                        zipCode = value;
                        setState(() {});
                      },
                    ),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    flex: 2,
                    child: QTextField(
                      label: "Country",
                      value: country,
                      validator: Validator.required,
                      onChanged: (value) {
                        country = value;
                        setState(() {});
                      },
                    ),
                  ),
                ],
              ),

              // Food Preferences
              Text(
                "Food Preferences",
                style: TextStyle(
                  fontSize: fsH5,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),

              QDropdownField(
                label: "Preferred Cuisine",
                items: cuisineOptions,
                value: preferredCuisine,
                onChanged: (value, label) {
                  preferredCuisine = value;
                  setState(() {});
                },
              ),

              // Dietary Restrictions
              Text(
                "Dietary Restrictions",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              
              QSwitch(
                items: dietaryOptions,
                value: dietaryOptions.where((item) => item["checked"] == true).toList(),
                onChanged: (values, ids) {
                  // Reset all to false
                  for (var option in dietaryOptions) {
                    option["checked"] = false;
                  }
                  // Set selected to true
                  for (var value in values) {
                    final option = dietaryOptions.firstWhere((item) => item["value"] == value["value"]);
                    option["checked"] = true;
                  }
                  // Update dietaryRestrictions list
                  dietaryRestrictions = values.map<String>((item) => item["value"] as String).toList();
                  setState(() {});
                },
              ),

              // Notification Preferences
              Text(
                "Notification Preferences",
                style: TextStyle(
                  fontSize: fsH5,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),

              _buildNotificationSetting(
                "Email Notifications",
                "Receive updates about your orders",
                emailNotifications,
                (value) {
                  emailNotifications = value;
                  setState(() {});
                },
              ),

              _buildNotificationSetting(
                "Push Notifications",
                "Get real-time updates on your device",
                pushNotifications,
                (value) {
                  pushNotifications = value;
                  setState(() {});
                },
              ),

              _buildNotificationSetting(
                "SMS Notifications",
                "Receive text messages for important updates",
                smsNotifications,
                (value) {
                  smsNotifications = value;
                  setState(() {});
                },
              ),

              _buildNotificationSetting(
                "Marketing Emails",
                "Get deals and promotions via email",
                marketingEmails,
                (value) {
                  marketingEmails = value;
                  setState(() {});
                },
              ),

              SizedBox(height: spLg),

              // Action Buttons
              Column(
                spacing: spSm,
                children: [
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
                      label: "Reset to Default",
                      size: bs.md,
                      onPressed: _resetProfile,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNotificationSetting(String title, String subtitle, bool value, Function(bool) onChanged) {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: disabledOutlineBorderColor),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spXs),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeColor: primaryColor,
          ),
        ],
      ),
    );
  }

  void _changeProfilePicture() {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(radiusMd)),
      ),
      builder: (context) {
        return Container(
          padding: EdgeInsets.all(spMd),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Change Profile Picture",
                style: TextStyle(
                  fontSize: fsH5,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              SizedBox(height: spMd),
              Row(
                children: [
                  Expanded(
                    child: QButton(
                      label: "Camera",
                      icon: Icons.camera_alt,
                      size: bs.md,
                      onPressed: () {
                        Navigator.pop(context);
                        si("Opening camera...");
                      },
                    ),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: QButton(
                      label: "Gallery",
                      icon: Icons.photo_library,
                      size: bs.md,
                      onPressed: () {
                        Navigator.pop(context);
                        si("Opening gallery...");
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: spSm),
              Container(
                width: double.infinity,
                child: QButton(
                  label: "Remove Photo",
                  size: bs.sm,
                  onPressed: () {
                    Navigator.pop(context);
                    profileImage = "https://picsum.photos/150/150?random=99&keyword=placeholder";
                    setState(() {});
                    si("Profile photo removed");
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _saveProfile() {
    if (formKey.currentState!.validate()) {
      showLoading();
      
      // Simulate API call
      Future.delayed(Duration(seconds: 2), () {
        hideLoading();
        ss("Profile updated successfully!");
        back();
      });
    }
  }

  void _resetProfile() async {
    bool isConfirmed = await confirm("Reset all changes to default values?");
    if (isConfirmed) {
      firstName = "John";
      lastName = "Doe";
      email = "john.doe@email.com";
      phone = "+1 234 567 8900";
      dateOfBirth = "1990-05-15";
      gender = "male";
      profileImage = "https://picsum.photos/150/150?random=1&keyword=person";
      streetAddress = "123 Main Street";
      city = "New York";
      state = "NY";
      zipCode = "10001";
      country = "United States";
      dietaryRestrictions = ["vegetarian"];
      preferredCuisine = "italian";
      emailNotifications = true;
      pushNotifications = true;
      smsNotifications = false;
      marketingEmails = true;
      
      _initializeDietaryRestrictions();
      setState(() {});
      si("Profile reset to default values");
    }
  }
}
