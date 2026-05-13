import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class SmaProfileSetupView extends StatefulWidget {
  const SmaProfileSetupView({super.key});

  @override
  State<SmaProfileSetupView> createState() => _SmaProfileSetupViewState();
}

class _SmaProfileSetupViewState extends State<SmaProfileSetupView> {
  final formKey = GlobalKey<FormState>();
  
  String firstName = "";
  String lastName = "";
  String email = "";
  String phone = "";
  String bio = "";
  String dateOfBirth = "";
  String gender = "";
  String location = "";
  String occupation = "";
  String website = "";
  String relationship = "";
  
  List<Map<String, dynamic>> genderOptions = [
    {"label": "Male", "value": "male"},
    {"label": "Female", "value": "female"},
    {"label": "Other", "value": "other"},
    {"label": "Prefer not to say", "value": "prefer_not_to_say"},
  ];
  
  List<Map<String, dynamic>> relationshipOptions = [
    {"label": "Single", "value": "single"},
    {"label": "In a relationship", "value": "in_relationship"},
    {"label": "Married", "value": "married"},
    {"label": "It's complicated", "value": "complicated"},
    {"label": "Prefer not to say", "value": "prefer_not_to_say"},
  ];
  
  bool isPublicProfile = true;
  bool allowMessages = true;
  bool allowFriendRequests = true;
  bool showOnlineStatus = false;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile Setup"),
        actions: [
          IconButton(
            icon: Icon(Icons.help),
            onPressed: () {},
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
              _buildProgressIndicator(),
              _buildBasicInfo(),
              _buildPersonalDetails(),
              _buildContactInfo(),
              _buildPrivacySettings(),
              _buildActionButtons(),
            ],
          ),
        ),
      ),
    );
  }
  
  Widget _buildProgressIndicator() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Setup Progress",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Text(
                "Step 1 of 4",
                style: TextStyle(
                  fontSize: 14,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
          Container(
            height: 8,
            decoration: BoxDecoration(
              color: disabledOutlineBorderColor,
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: FractionallySizedBox(
              alignment: Alignment.centerLeft,
              widthFactor: 0.25,
              child: Container(
                decoration: BoxDecoration(
                  color: primaryColor,
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildBasicInfo() {
    return Container(
      padding: EdgeInsets.all(spSm),
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
            hint: "+1 (555) 123-4567",
            onChanged: (value) {
              phone = value;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }
  
  Widget _buildPersonalDetails() {
    return Container(
      padding: EdgeInsets.all(spSm),
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
            "Personal Details",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          QMemoField(
            label: "Bio",
            value: bio,
            hint: "Tell us about yourself...",
            onChanged: (value) {
              bio = value;
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
          QDropdownField(
            label: "Gender",
            items: genderOptions,
            value: gender,
            onChanged: (value, label) {
              gender = value;
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
    );
  }
  
  Widget _buildContactInfo() {
    return Container(
      padding: EdgeInsets.all(spSm),
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
            "Additional Information",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          QTextField(
            label: "Occupation",
            value: occupation,
            hint: "What do you do?",
            onChanged: (value) {
              occupation = value;
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
          QDropdownField(
            label: "Relationship Status",
            items: relationshipOptions,
            value: relationship,
            onChanged: (value, label) {
              relationship = value;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }
  
  Widget _buildPrivacySettings() {
    return Container(
      padding: EdgeInsets.all(spSm),
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
          _buildPrivacyOption(
            "Public Profile",
            "Anyone can see your profile",
            isPublicProfile,
            (value) {
              isPublicProfile = value;
              setState(() {});
            },
          ),
          _buildPrivacyOption(
            "Allow Messages",
            "People can send you direct messages",
            allowMessages,
            (value) {
              allowMessages = value;
              setState(() {});
            },
          ),
          _buildPrivacyOption(
            "Allow Friend Requests",
            "People can send you friend requests",
            allowFriendRequests,
            (value) {
              allowFriendRequests = value;
              setState(() {});
            },
          ),
          _buildPrivacyOption(
            "Show Online Status",
            "Others can see when you're online",
            showOnlineStatus,
            (value) {
              showOnlineStatus = value;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }
  
  Widget _buildPrivacyOption(String title, String description, bool value, Function(bool) onChanged) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
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
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 14,
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
  
  Widget _buildActionButtons() {
    return Column(
      spacing: spSm,
      children: [
        Container(
          width: double.infinity,
          child: QButton(
            label: "Continue",
            onPressed: () {
              if (formKey.currentState!.validate()) {
                ss("Profile information saved!");
                //navigateTo('ProfilePhotoView')
              }
            },
          ),
        ),
        Container(
          width: double.infinity,
          child: QButton(
            label: "Skip for Now",
            onPressed: () {
              //navigateTo('HomeFeedView')
            },
          ),
        ),
      ],
    );
  }
}
