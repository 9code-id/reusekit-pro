import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class DlaDriverProfileView extends StatefulWidget {
  const DlaDriverProfileView({super.key});

  @override
  State<DlaDriverProfileView> createState() => _DlaDriverProfileViewState();
}

class _DlaDriverProfileViewState extends State<DlaDriverProfileView> {
  final formKey = GlobalKey<FormState>();
  bool loading = false;
  bool isEditing = false;

  // Personal Information
  String firstName = "Mike";
  String lastName = "Johnson";
  String email = "mike.johnson@delivery.com";
  String phone = "+1 234 567 8890";
  String emergencyContact = "+1 234 567 8891";
  String emergencyContactName = "Sarah Johnson";
  String dateOfBirth = "1990-05-15";
  String profileImage = "https://picsum.photos/150/150?random=1&keyword=person";

  // Address Information
  String street = "123 Main Street";
  String city = "Downtown";
  String state = "CA";
  String zipCode = "90210";
  String country = "United States";

  // Vehicle Information
  String vehicleType = "motorcycle";
  String vehicleBrand = "Honda";
  String vehicleModel = "CBR 150R";
  String vehicleYear = "2022";
  String vehicleColor = "Red";
  String licensePlate = "ABC 1234";

  // Documents
  String driverLicense = "DL123456789";
  String licenseExpiry = "2026-12-31";
  String insuranceNumber = "INS987654321";
  String insuranceExpiry = "2025-06-30";
  String registrationNumber = "REG456789012";
  String registrationExpiry = "2025-03-15";

  // Bank Information
  String bankName = "Chase Bank";
  String accountNumber = "****1234";
  String routingNumber = "****5678";
  String accountHolderName = "Mike Johnson";

  // Preferences
  String preferredLanguage = "english";
  bool notificationsEnabled = true;
  bool locationSharingEnabled = true;
  bool callsEnabled = true;
  bool messagesEnabled = true;

  List<Map<String, dynamic>> vehicleTypes = [
    {"label": "Motorcycle", "value": "motorcycle"},
    {"label": "Car", "value": "car"},
    {"label": "Van", "value": "van"},
    {"label": "Bicycle", "value": "bicycle"},
  ];

  List<Map<String, dynamic>> languages = [
    {"label": "English", "value": "english"},
    {"label": "Spanish", "value": "spanish"},
    {"label": "French", "value": "french"},
    {"label": "German", "value": "german"},
  ];

  List<Map<String, dynamic>> states = [
    {"label": "California", "value": "CA"},
    {"label": "New York", "value": "NY"},
    {"label": "Texas", "value": "TX"},
    {"label": "Florida", "value": "FL"},
  ];

  Widget _buildSection(String title, List<Widget> children) {
    return Container(
      margin: EdgeInsets.only(bottom: spMd),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusSm),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: spSm),
          ...children,
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value, {IconData? icon}) {
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      child: Row(
        children: [
          if (icon != null) ...[
            Icon(
              icon,
              size: 16,
              color: primaryColor,
            ),
            SizedBox(width: spSm),
          ],
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: spXs),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Driver Profile"),
        actions: [
          IconButton(
            icon: Icon(isEditing ? Icons.save : Icons.edit),
            onPressed: () {
              if (isEditing) {
                if (formKey.currentState!.validate()) {
                  ss("Profile updated successfully!");
                  isEditing = false;
                  setState(() {});
                }
              } else {
                isEditing = true;
                setState(() {});
              }
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              // Profile Image Section
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusSm),
                  boxShadow: [shadowSm],
                ),
                child: Center(
                  child: Column(
                    children: [
                      Stack(
                        children: [
                          CircleAvatar(
                            radius: 60,
                            backgroundImage: NetworkImage(profileImage),
                          ),
                          if (isEditing) ...[
                            Positioned(
                              bottom: 0,
                              right: 0,
                              child: Container(
                                padding: EdgeInsets.all(spXs),
                                decoration: BoxDecoration(
                                  color: primaryColor,
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  Icons.camera_alt,
                                  color: Colors.white,
                                  size: 20,
                                ),
                              ),
                            ),
                          ],
                        ],
                      ),
                      SizedBox(height: spSm),
                      Text(
                        "$firstName $lastName",
                        style: TextStyle(
                          fontSize: fsH5,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "Driver ID: DRV001",
                        style: TextStyle(
                          color: disabledBoldColor,
                        ),
                      ),
                      SizedBox(height: spSm),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                        decoration: BoxDecoration(
                          color: successColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Text(
                          "Verified Driver",
                          style: TextStyle(
                            fontSize: 12,
                            color: successColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Personal Information
              _buildSection(
                "Personal Information",
                [
                  if (isEditing) ...[
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
                    SizedBox(height: spSm),
                    QTextField(
                      label: "Email",
                      value: email,
                      validator: Validator.email,
                      onChanged: (value) {
                        email = value;
                        setState(() {});
                      },
                    ),
                    SizedBox(height: spSm),
                    QTextField(
                      label: "Phone Number",
                      value: phone,
                      validator: Validator.required,
                      onChanged: (value) {
                        phone = value;
                        setState(() {});
                      },
                    ),
                    SizedBox(height: spSm),
                    QDatePicker(
                      label: "Date of Birth",
                      value: DateTime.parse(dateOfBirth),
                      onChanged: (value) {
                        dateOfBirth = "${value.year}-${value.month.toString().padLeft(2, '0')}-${value.day.toString().padLeft(2, '0')}";
                        setState(() {});
                      },
                    ),
                  ] else ...[
                    _buildInfoRow("Full Name", "$firstName $lastName", icon: Icons.person),
                    _buildInfoRow("Email", email, icon: Icons.email),
                    _buildInfoRow("Phone", phone, icon: Icons.phone),
                    _buildInfoRow("Date of Birth", dateOfBirth, icon: Icons.cake),
                  ],
                ],
              ),

              // Emergency Contact
              _buildSection(
                "Emergency Contact",
                [
                  if (isEditing) ...[
                    QTextField(
                      label: "Emergency Contact Name",
                      value: emergencyContactName,
                      validator: Validator.required,
                      onChanged: (value) {
                        emergencyContactName = value;
                        setState(() {});
                      },
                    ),
                    SizedBox(height: spSm),
                    QTextField(
                      label: "Emergency Contact Phone",
                      value: emergencyContact,
                      validator: Validator.required,
                      onChanged: (value) {
                        emergencyContact = value;
                        setState(() {});
                      },
                    ),
                  ] else ...[
                    _buildInfoRow("Contact Name", emergencyContactName, icon: Icons.contact_emergency),
                    _buildInfoRow("Contact Phone", emergencyContact, icon: Icons.phone),
                  ],
                ],
              ),

              // Address Information
              _buildSection(
                "Address",
                [
                  if (isEditing) ...[
                    QTextField(
                      label: "Street Address",
                      value: street,
                      validator: Validator.required,
                      onChanged: (value) {
                        street = value;
                        setState(() {});
                      },
                    ),
                    SizedBox(height: spSm),
                    Row(
                      children: [
                        Expanded(
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
                          child: QDropdownField(
                            label: "State",
                            items: states,
                            value: state,
                            onChanged: (value, label) {
                              state = value;
                              setState(() {});
                            },
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spSm),
                    QTextField(
                      label: "ZIP Code",
                      value: zipCode,
                      validator: Validator.required,
                      onChanged: (value) {
                        zipCode = value;
                        setState(() {});
                      },
                    ),
                  ] else ...[
                    _buildInfoRow("Street", street, icon: Icons.location_on),
                    _buildInfoRow("City, State", "$city, $state $zipCode"),
                    _buildInfoRow("Country", country),
                  ],
                ],
              ),

              // Vehicle Information
              _buildSection(
                "Vehicle Information",
                [
                  if (isEditing) ...[
                    QDropdownField(
                      label: "Vehicle Type",
                      items: vehicleTypes,
                      value: vehicleType,
                      onChanged: (value, label) {
                        vehicleType = value;
                        setState(() {});
                      },
                    ),
                    SizedBox(height: spSm),
                    Row(
                      children: [
                        Expanded(
                          child: QTextField(
                            label: "Brand",
                            value: vehicleBrand,
                            validator: Validator.required,
                            onChanged: (value) {
                              vehicleBrand = value;
                              setState(() {});
                            },
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: QTextField(
                            label: "Model",
                            value: vehicleModel,
                            validator: Validator.required,
                            onChanged: (value) {
                              vehicleModel = value;
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
                          child: QTextField(
                            label: "Year",
                            value: vehicleYear,
                            validator: Validator.required,
                            onChanged: (value) {
                              vehicleYear = value;
                              setState(() {});
                            },
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: QTextField(
                            label: "Color",
                            value: vehicleColor,
                            validator: Validator.required,
                            onChanged: (value) {
                              vehicleColor = value;
                              setState(() {});
                            },
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spSm),
                    QTextField(
                      label: "License Plate",
                      value: licensePlate,
                      validator: Validator.required,
                      onChanged: (value) {
                        licensePlate = value;
                        setState(() {});
                      },
                    ),
                  ] else ...[
                    _buildInfoRow("Vehicle Type", vehicleType.toUpperCase(), icon: Icons.motorcycle),
                    _buildInfoRow("Vehicle", "$vehicleBrand $vehicleModel ($vehicleYear)"),
                    _buildInfoRow("Color", vehicleColor),
                    _buildInfoRow("License Plate", licensePlate),
                  ],
                ],
              ),

              // Documents
              _buildSection(
                "Documents",
                [
                  if (isEditing) ...[
                    QTextField(
                      label: "Driver License Number",
                      value: driverLicense,
                      validator: Validator.required,
                      onChanged: (value) {
                        driverLicense = value;
                        setState(() {});
                      },
                    ),
                    SizedBox(height: spSm),
                    QDatePicker(
                      label: "License Expiry",
                      value: DateTime.parse(licenseExpiry),
                      onChanged: (value) {
                        licenseExpiry = "${value.year}-${value.month.toString().padLeft(2, '0')}-${value.day.toString().padLeft(2, '0')}";
                        setState(() {});
                      },
                    ),
                    SizedBox(height: spSm),
                    QTextField(
                      label: "Insurance Number",
                      value: insuranceNumber,
                      validator: Validator.required,
                      onChanged: (value) {
                        insuranceNumber = value;
                        setState(() {});
                      },
                    ),
                    SizedBox(height: spSm),
                    QDatePicker(
                      label: "Insurance Expiry",
                      value: DateTime.parse(insuranceExpiry),
                      onChanged: (value) {
                        insuranceExpiry = "${value.year}-${value.month.toString().padLeft(2, '0')}-${value.day.toString().padLeft(2, '0')}";
                        setState(() {});
                      },
                    ),
                  ] else ...[
                    _buildInfoRow("Driver License", driverLicense, icon: Icons.credit_card),
                    _buildInfoRow("License Expiry", licenseExpiry),
                    _buildInfoRow("Insurance Number", insuranceNumber, icon: Icons.security),
                    _buildInfoRow("Insurance Expiry", insuranceExpiry),
                    _buildInfoRow("Registration", registrationNumber, icon: Icons.description),
                    _buildInfoRow("Registration Expiry", registrationExpiry),
                  ],
                ],
              ),

              // Bank Information
              _buildSection(
                "Bank Information",
                [
                  if (isEditing) ...[
                    QTextField(
                      label: "Bank Name",
                      value: bankName,
                      validator: Validator.required,
                      onChanged: (value) {
                        bankName = value;
                        setState(() {});
                      },
                    ),
                    SizedBox(height: spSm),
                    QTextField(
                      label: "Account Holder Name",
                      value: accountHolderName,
                      validator: Validator.required,
                      onChanged: (value) {
                        accountHolderName = value;
                        setState(() {});
                      },
                    ),
                  ] else ...[
                    _buildInfoRow("Bank Name", bankName, icon: Icons.account_balance),
                    _buildInfoRow("Account Number", accountNumber),
                    _buildInfoRow("Routing Number", routingNumber),
                    _buildInfoRow("Account Holder", accountHolderName),
                  ],
                ],
              ),

              // Preferences
              _buildSection(
                "Preferences",
                [
                  if (isEditing) ...[
                    QDropdownField(
                      label: "Preferred Language",
                      items: languages,
                      value: preferredLanguage,
                      onChanged: (value, label) {
                        preferredLanguage = value;
                        setState(() {});
                      },
                    ),
                    SizedBox(height: spSm),
                    QSwitch(
                      label: "Notifications",
                      items: [
                        {
                          "label": "Enable push notifications",
                          "value": true,
                          "checked": notificationsEnabled,
                        }
                      ],
                      value: [
                        if (notificationsEnabled)
                          {
                            "label": "Enable push notifications",
                            "value": true,
                            "checked": true
                          }
                      ],
                      onChanged: (values, ids) {
                        notificationsEnabled = values.isNotEmpty;
                        setState(() {});
                      },
                    ),
                    SizedBox(height: spSm),
                    QSwitch(
                      label: "Location Sharing",
                      items: [
                        {
                          "label": "Share location while working",
                          "value": true,
                          "checked": locationSharingEnabled,
                        }
                      ],
                      value: [
                        if (locationSharingEnabled)
                          {
                            "label": "Share location while working",
                            "value": true,
                            "checked": true
                          }
                      ],
                      onChanged: (values, ids) {
                        locationSharingEnabled = values.isNotEmpty;
                        setState(() {});
                      },
                    ),
                  ] else ...[
                    _buildInfoRow("Language", preferredLanguage.toUpperCase(), icon: Icons.language),
                    _buildInfoRow("Notifications", notificationsEnabled ? "Enabled" : "Disabled"),
                    _buildInfoRow("Location Sharing", locationSharingEnabled ? "Enabled" : "Disabled"),
                    _buildInfoRow("Calls", callsEnabled ? "Enabled" : "Disabled"),
                    _buildInfoRow("Messages", messagesEnabled ? "Enabled" : "Disabled"),
                  ],
                ],
              ),

              if (isEditing) ...[
                SizedBox(height: spLg),
                Container(
                  width: double.infinity,
                  child: QButton(
                    label: "Save Changes",
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        showLoading();
                        Future.delayed(Duration(seconds: 2), () {
                          hideLoading();
                          ss("Profile updated successfully!");
                          isEditing = false;
                          setState(() {});
                        });
                      }
                    },
                  ),
                ),
                SizedBox(height: spSm),
                Container(
                  width: double.infinity,
                  child: QButton(
                    label: "Cancel",
                    color: disabledBoldColor,
                    onPressed: () {
                      isEditing = false;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
