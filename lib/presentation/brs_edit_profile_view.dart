import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class BrsEditProfileView extends StatefulWidget {
  const BrsEditProfileView({super.key});

  @override
  State<BrsEditProfileView> createState() => _BrsEditProfileViewState();
}

class _BrsEditProfileViewState extends State<BrsEditProfileView> {
  final formKey = GlobalKey<FormState>();
  bool loading = false;
  
  String firstName = "John";
  String lastName = "Anderson";
  String email = "john.anderson@email.com";
  String phone = "+1 234 567 8900";
  String dateOfBirth = "1990-05-15";
  String gender = "male";
  String address = "123 Main Street";
  String city = "New York";
  String zipCode = "10001";
  String profileImage = "https://picsum.photos/120/120?random=200&keyword=person";

  List<Map<String, dynamic>> genderOptions = [
    {"label": "Male", "value": "male"},
    {"label": "Female", "value": "female"},
    {"label": "Other", "value": "other"},
    {"label": "Prefer not to say", "value": "not_specified"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Profile"),
        actions: [
          QButton(
            label: "Save",
            size: bs.sm,
            onPressed: _saveProfile,
          ),
        ],
      ),
      body: loading 
        ? Center(child: CircularProgressIndicator())
        : Form(
            key: formKey,
            child: SingleChildScrollView(
              padding: EdgeInsets.all(spMd),
              child: Column(
                spacing: spMd,
                children: [
                  _buildProfileImageSection(),
                  _buildPersonalInfoSection(),
                  _buildContactInfoSection(),
                  _buildAddressSection(),
                  _buildSaveButton(),
                ],
              ),
            ),
          ),
    );
  }

  Widget _buildProfileImageSection() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        children: [
          Text(
            "Profile Picture",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(radiusLg),
                child: Image.network(
                  profileImage,
                  width: 100,
                  height: 100,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: GestureDetector(
                  onTap: _changeProfileImage,
                  child: Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      color: primaryColor,
                      borderRadius: BorderRadius.circular(radiusLg),
                      border: Border.all(
                        color: Colors.white,
                        width: 2,
                      ),
                    ),
                    child: Icon(
                      Icons.camera_alt,
                      color: Colors.white,
                      size: 16,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Text(
            "Tap to change profile picture",
            style: TextStyle(
              fontSize: 14,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPersonalInfoSection() {
    return Container(
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
          QDatePicker(
            label: 'Date of Birth',
            value: DateTime.parse(dateOfBirth),
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
        ],
      ),
    );
  }

  Widget _buildContactInfoSection() {
    return Container(
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
        ],
      ),
    );
  }

  Widget _buildAddressSection() {
    return Container(
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
            "Address Information",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          QTextField(
            label: "Street Address",
            value: address,
            onChanged: (value) {
              address = value;
              setState(() {});
            },
          ),
          Row(
            spacing: spSm,
            children: [
              Expanded(
                flex: 2,
                child: QTextField(
                  label: "City",
                  value: city,
                  onChanged: (value) {
                    city = value;
                    setState(() {});
                  },
                ),
              ),
              Expanded(
                child: QTextField(
                  label: "ZIP Code",
                  value: zipCode,
                  onChanged: (value) {
                    zipCode = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSaveButton() {
    return Column(
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
            label: "Cancel",
            size: bs.md,
            color: disabledBoldColor,
            onPressed: () => back(),
          ),
        ),
      ],
    );
  }

  void _changeProfileImage() async {
    si("Profile image change functionality");
    // Implement image picker functionality
  }

  void _saveProfile() async {
    if (!formKey.currentState!.validate()) {
      se("Please fill all required fields correctly");
      return;
    }

    bool isConfirmed = await confirm("Are you sure you want to save these changes?");
    if (!isConfirmed) return;

    loading = true;
    setState(() {});

    // Simulate API call
    await Future.delayed(Duration(seconds: 2));

    loading = false;
    setState(() {});

    ss("Profile updated successfully!");
    await Future.delayed(Duration(milliseconds: 500));
    back();
  }
}
