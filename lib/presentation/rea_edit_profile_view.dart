import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class ReaEditProfileView extends StatefulWidget {
  const ReaEditProfileView({super.key});

  @override
  State<ReaEditProfileView> createState() => _ReaEditProfileViewState();
}

class _ReaEditProfileViewState extends State<ReaEditProfileView> {
  String firstName = "John";
  String lastName = "Doe";
  String email = "john.doe@email.com";
  String phoneNumber = "+1 234 567 8900";
  String dateOfBirth = "1990-01-15";
  String occupation = "Software Engineer";
  String annualIncome = "75000";
  String address = "123 Main Street";
  String city = "New York";
  String state = "NY";
  String zipCode = "10001";
  String aboutMe = "Looking for investment properties in prime locations";
  String profileImage = "https://picsum.photos/200/200?random=1&keyword=person";
  bool emailNotifications = true;
  bool smsNotifications = false;
  bool marketingNotifications = true;

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
            onPressed: _saveProfile,
          ),
          SizedBox(width: spSm),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Form(
          key: formKey,
          child: Column(
            spacing: spMd,
            children: [
              _buildProfileImageSection(),
              _buildPersonalInfoSection(),
              _buildContactInfoSection(),
              _buildLocationSection(),
              _buildProfessionalInfoSection(),
              _buildPreferencesSection(),
              _buildNotificationSection(),
              SizedBox(height: spLg),
              _buildActionButtons(),
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
        children: [
          Text(
            "Profile Picture",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),
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
                  border: Border.all(
                    color: primaryColor,
                    width: 3,
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: Container(
                  padding: EdgeInsets.all(spXs),
                  decoration: BoxDecoration(
                    color: primaryColor,
                    shape: BoxShape.circle,
                    boxShadow: [shadowSm],
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
          QButton(
            label: "Change Photo",
            size: bs.sm,
            onPressed: () {},
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
        children: [
          Text(
            "Personal Information",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),
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
          SizedBox(height: spMd),
          QDatePicker(
            label: "Date of Birth",
            value: DateTime.parse(dateOfBirth),
            onChanged: (value) {
              dateOfBirth = value.toString().split(' ')[0];
              setState(() {});
            },
          ),
          SizedBox(height: spMd),
          QMemoField(
            label: "About Me",
            value: aboutMe,
            hint: "Tell us about your real estate preferences and goals",
            onChanged: (value) {
              aboutMe = value;
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
        children: [
          Text(
            "Contact Information",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),
          QTextField(
            label: "Email Address",
            value: email,
            validator: Validator.email,
            onChanged: (value) {
              email = value;
              setState(() {});
            },
          ),
          SizedBox(height: spMd),
          QTextField(
            label: "Phone Number",
            value: phoneNumber,
            validator: Validator.required,
            onChanged: (value) {
              phoneNumber = value;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  Widget _buildLocationSection() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Location",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),
          QTextField(
            label: "Address",
            value: address,
            validator: Validator.required,
            onChanged: (value) {
              address = value;
              setState(() {});
            },
          ),
          SizedBox(height: spMd),
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
              SizedBox(width: spSm),
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
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildProfessionalInfoSection() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Professional Information",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),
          QTextField(
            label: "Occupation",
            value: occupation,
            validator: Validator.required,
            onChanged: (value) {
              occupation = value;
              setState(() {});
            },
          ),
          SizedBox(height: spMd),
          QNumberField(
            label: "Annual Income (\$)",
            value: annualIncome,
            validator: Validator.required,
            onChanged: (value) {
              annualIncome = value;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  Widget _buildPreferencesSection() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Investment Preferences",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),
          Row(
            children: [
              Icon(
                Icons.business,
                color: primaryColor,
                size: 24,
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Property Types",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "Residential, Commercial, Investment",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.arrow_forward_ios,
                color: disabledBoldColor,
                size: 16,
              ),
            ],
          ),
          SizedBox(height: spMd),
          Row(
            children: [
              Icon(
                Icons.location_on,
                color: primaryColor,
                size: 24,
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Preferred Locations",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "Manhattan, Brooklyn, Queens",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.arrow_forward_ios,
                color: disabledBoldColor,
                size: 16,
              ),
            ],
          ),
          SizedBox(height: spMd),
          Row(
            children: [
              Icon(
                Icons.attach_money,
                color: primaryColor,
                size: 24,
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Budget Range",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "\$500K - \$1.5M",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.arrow_forward_ios,
                color: disabledBoldColor,
                size: 16,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildNotificationSection() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Notification Preferences",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),
          Row(
            children: [
              Expanded(
                child: QSwitch(
                  items: [
                    {
                      "label": "Email Notifications",
                      "value": true,
                      "checked": emailNotifications,
                    }
                  ],
                  value: [
                    if (emailNotifications)
                      {
                        "label": "Email Notifications",
                        "value": true,
                        "checked": true
                      }
                  ],
                  onChanged: (values, ids) {
                    emailNotifications = values.isNotEmpty;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              Expanded(
                child: QSwitch(
                  items: [
                    {
                      "label": "SMS Notifications",
                      "value": true,
                      "checked": smsNotifications,
                    }
                  ],
                  value: [
                    if (smsNotifications)
                      {
                        "label": "SMS Notifications",
                        "value": true,
                        "checked": true
                      }
                  ],
                  onChanged: (values, ids) {
                    smsNotifications = values.isNotEmpty;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              Expanded(
                child: QSwitch(
                  items: [
                    {
                      "label": "Marketing Communications",
                      "value": true,
                      "checked": marketingNotifications,
                    }
                  ],
                  value: [
                    if (marketingNotifications)
                      {
                        "label": "Marketing Communications",
                        "value": true,
                        "checked": true
                      }
                  ],
                  onChanged: (values, ids) {
                    marketingNotifications = values.isNotEmpty;
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

  Widget _buildActionButtons() {
    return Column(
      spacing: spSm,
      children: [
        Container(
          width: double.infinity,
          child: QButton(
            label: "Save Changes",
            onPressed: _saveProfile,
          ),
        ),
        Container(
          width: double.infinity,
          child: QButton(
            label: "Delete Account",
            color: dangerColor,
            size: bs.sm,
            onPressed: _deleteAccount,
          ),
        ),
      ],
    );
  }

  void _saveProfile() async {
    if (formKey.currentState!.validate()) {
      showLoading();
      await Future.delayed(Duration(seconds: 2));
      hideLoading();
      ss("Profile updated successfully");
      back();
    }
  }

  void _deleteAccount() async {
    bool isConfirmed = await confirm("Are you sure you want to delete your account? This action cannot be undone.");
    if (isConfirmed) {
      showLoading();
      await Future.delayed(Duration(seconds: 2));
      hideLoading();
      ss("Account deleted successfully");
      back();
    }
  }
}
