import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GeaAccountView extends StatefulWidget {
  const GeaAccountView({super.key});

  @override
  State<GeaAccountView> createState() => _GeaAccountViewState();
}

class _GeaAccountViewState extends State<GeaAccountView> {
  final formKey = GlobalKey<FormState>();
  
  // Profile Information
  String firstName = "John";
  String lastName = "Doe";
  String email = "john.doe@example.com";
  String phone = "+1 (555) 123-4567";
  String dateOfBirth = "1990-05-15";
  String gender = "Male";
  String profileImage = "https://picsum.photos/150/150?random=1&keyword=person";
  
  // Address Information
  String street = "123 Main Street";
  String city = "New York";
  String state = "NY";
  String zipCode = "10001";
  String country = "United States";
  
  // Account Settings
  String timezone = "UTC-5 (EST)";
  String currency = "USD";
  String subscriptionPlan = "Premium";
  bool emailVerified = true;
  bool phoneVerified = false;
  bool twoFactorEnabled = false;

  List<Map<String, dynamic>> genderOptions = [
    {"label": "Male", "value": "Male"},
    {"label": "Female", "value": "Female"},
    {"label": "Other", "value": "Other"},
    {"label": "Prefer not to say", "value": "Prefer not to say"},
  ];

  List<Map<String, dynamic>> timezoneOptions = [
    {"label": "UTC-8 (PST)", "value": "UTC-8 (PST)"},
    {"label": "UTC-5 (EST)", "value": "UTC-5 (EST)"},
    {"label": "UTC+0 (GMT)", "value": "UTC+0 (GMT)"},
    {"label": "UTC+8 (CST)", "value": "UTC+8 (CST)"},
  ];

  List<Map<String, dynamic>> currencyOptions = [
    {"label": "USD - US Dollar", "value": "USD"},
    {"label": "EUR - Euro", "value": "EUR"},
    {"label": "GBP - British Pound", "value": "GBP"},
    {"label": "IDR - Indonesian Rupiah", "value": "IDR"},
  ];

  List<Map<String, dynamic>> accountActivity = [
    {
      "activity": "Password changed",
      "date": "2024-12-15",
      "time": "14:30",
      "location": "New York, US",
      "device": "iPhone 15 Pro",
    },
    {
      "activity": "Login from new device",
      "date": "2024-12-14",
      "time": "09:15",
      "location": "New York, US",
      "device": "MacBook Pro",
    },
    {
      "activity": "Profile updated",
      "date": "2024-12-12",
      "time": "16:45",
      "location": "New York, US",
      "device": "iPhone 15 Pro",
    },
    {
      "activity": "Two-factor authentication enabled",
      "date": "2024-12-10",
      "time": "11:20",
      "location": "New York, US",
      "device": "iPad Pro",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Account"),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              _signOut();
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Form(
          key: formKey,
          child: Column(
            spacing: spMd,
            children: [
              // Profile Header
              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  spacing: spSm,
                  children: [
                    // Profile Image
                    Center(
                      child: Stack(
                        children: [
                          CircleAvatar(
                            radius: 50,
                            backgroundImage: NetworkImage(profileImage),
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: GestureDetector(
                              onTap: () {
                                _changeProfileImage();
                              },
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
                                  size: 16,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Account Status
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      spacing: spSm,
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: spXs,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: successColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            spacing: 4,
                            children: [
                              Icon(
                                Icons.verified,
                                color: successColor,
                                size: 14,
                              ),
                              Text(
                                "Verified",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: successColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: spXs,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: warningColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            subscriptionPlan,
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: warningColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Personal Information
              Container(
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
                    Row(
                      children: [
                        Icon(
                          Icons.person,
                          color: primaryColor,
                          size: 20,
                        ),
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
                  ],
                ),
              ),

              // Address Information
              Container(
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
                    Row(
                      children: [
                        Icon(
                          Icons.location_on,
                          color: primaryColor,
                          size: 20,
                        ),
                        SizedBox(width: spSm),
                        Text(
                          "Address Information",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                    QTextField(
                      label: "Street Address",
                      value: street,
                      validator: Validator.required,
                      onChanged: (value) {
                        street = value;
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
                            validator: Validator.required,
                            onChanged: (value) {
                              city = value;
                              setState(() {});
                            },
                          ),
                        ),
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
                      spacing: spSm,
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
                        Expanded(
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
                  ],
                ),
              ),

              // Account Preferences
              Container(
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
                    Row(
                      children: [
                        Icon(
                          Icons.tune,
                          color: primaryColor,
                          size: 20,
                        ),
                        SizedBox(width: spSm),
                        Text(
                          "Account Preferences",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                    QDropdownField(
                      label: "Timezone",
                      items: timezoneOptions,
                      value: timezone,
                      onChanged: (value, label) {
                        timezone = value;
                        setState(() {});
                      },
                    ),
                    QDropdownField(
                      label: "Currency",
                      items: currencyOptions,
                      value: currency,
                      onChanged: (value, label) {
                        currency = value;
                        setState(() {});
                      },
                    ),
                  ],
                ),
              ),

              // Security Status
              Container(
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
                    Row(
                      children: [
                        Icon(
                          Icons.security,
                          color: primaryColor,
                          size: 20,
                        ),
                        SizedBox(width: spSm),
                        Text(
                          "Security Status",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                    _buildSecurityItem(
                      "Email Verification",
                      emailVerified ? "Verified" : "Not Verified",
                      emailVerified ? successColor : warningColor,
                      emailVerified ? Icons.verified : Icons.warning,
                      () {
                        if (!emailVerified) _verifyEmail();
                      },
                    ),
                    _buildSecurityItem(
                      "Phone Verification",
                      phoneVerified ? "Verified" : "Not Verified",
                      phoneVerified ? successColor : warningColor,
                      phoneVerified ? Icons.verified : Icons.warning,
                      () {
                        if (!phoneVerified) _verifyPhone();
                      },
                    ),
                    _buildSecurityItem(
                      "Two-Factor Authentication",
                      twoFactorEnabled ? "Enabled" : "Disabled",
                      twoFactorEnabled ? successColor : dangerColor,
                      twoFactorEnabled ? Icons.shield : Icons.shield_outlined,
                      () {
                        _toggleTwoFactor();
                      },
                    ),
                    Container(
                      width: double.infinity,
                      child: QButton(
                        label: "Change Password",
                        onPressed: () {
                          _changePassword();
                        },
                      ),
                    ),
                  ],
                ),
              ),

              // Recent Activity
              Container(
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
                    Row(
                      children: [
                        Icon(
                          Icons.history,
                          color: primaryColor,
                          size: 20,
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Text(
                            "Recent Activity",
                            style: TextStyle(
                              fontSize: fsH6,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                        ),
                        QButton(
                          label: "View All",
                          size: bs.sm,
                          onPressed: () {
                            _viewAllActivity();
                          },
                        ),
                      ],
                    ),
                    ...accountActivity.take(3).map((activity) {
                      return Container(
                        padding: EdgeInsets.all(spXs),
                        margin: EdgeInsets.only(bottom: spXs),
                        decoration: BoxDecoration(
                          color: Colors.grey[50],
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: 4,
                          children: [
                            Text(
                              "${activity["activity"]}",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: primaryColor,
                              ),
                            ),
                            Row(
                              children: [
                                Text(
                                  "${activity["date"]} at ${activity["time"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                SizedBox(width: spSm),
                                Text(
                                  "${activity["device"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              "${activity["location"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
                  ],
                ),
              ),

              // Action Buttons
              Column(
                spacing: spSm,
                children: [
                  Container(
                    width: double.infinity,
                    child: QButton(
                      label: "Save Changes",
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          _saveChanges();
                        }
                      },
                    ),
                  ),
                  Row(
                    spacing: spSm,
                    children: [
                      Expanded(
                        child: QButton(
                          label: "Export Data",
                          onPressed: () {
                            _exportAccountData();
                          },
                        ),
                      ),
                      Expanded(
                        child: QButton(
                          label: "Delete Account",
                          onPressed: () {
                            _deleteAccount();
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSecurityItem(String title, String status, Color statusColor, IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(spXs),
        decoration: BoxDecoration(
          color: Colors.grey[50],
          borderRadius: BorderRadius.circular(radiusSm),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: statusColor,
              size: 20,
            ),
            SizedBox(width: spSm),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: primaryColor,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: spXs,
                vertical: 4,
              ),
              decoration: BoxDecoration(
                color: statusColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusXs),
              ),
              child: Text(
                status,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: statusColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _changeProfileImage() {
    si("Opening image picker...");
  }

  void _verifyEmail() {
    si("Verification email sent!");
  }

  void _verifyPhone() {
    si("SMS verification code sent!");
  }

  void _toggleTwoFactor() async {
    if (twoFactorEnabled) {
      bool isConfirmed = await confirm("Disable two-factor authentication? This will make your account less secure.");
      if (isConfirmed) {
        twoFactorEnabled = false;
        setState(() {});
        sw("Two-factor authentication disabled");
      }
    } else {
      si("Setting up two-factor authentication...");
      twoFactorEnabled = true;
      setState(() {});
    }
  }

  void _changePassword() {
    si("Opening change password form...");
  }

  void _viewAllActivity() {
    si("Opening activity history...");
  }

  void _saveChanges() {
    ss("Account information updated successfully!");
  }

  void _exportAccountData() {
    si("Preparing account data export...");
  }

  void _deleteAccount() async {
    bool isConfirmed = await confirm("Permanently delete your account? This action cannot be undone and all your data will be lost.");
    if (isConfirmed) {
      sw("Account deletion process initiated. You'll receive a confirmation email.");
    }
  }

  void _signOut() async {
    bool isConfirmed = await confirm("Sign out of your account?");
    if (isConfirmed) {
      si("Signing out...");
    }
  }
}
