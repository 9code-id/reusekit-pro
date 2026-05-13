import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class SpaEditAddressView extends StatefulWidget {
  const SpaEditAddressView({Key? key}) : super(key: key);

  @override
  State<SpaEditAddressView> createState() => _SpaEditAddressViewState();
}

class _SpaEditAddressViewState extends State<SpaEditAddressView> {
  final formKey = GlobalKey<FormState>();
  
  // Pre-populated data (would come from navigation parameters)
  String addressLabel = "Home";
  String fullName = "Sarah Johnson";
  String phoneNumber = "+1 (555) 123-4567";
  String addressLine1 = "123 Oak Street";
  String addressLine2 = "";
  String city = "New York";
  String state = "NY";
  String zipCode = "10001";
  String country = "United States";
  String addressType = "home";
  bool isDefault = true;
  String specialInstructions = "Ring the doorbell twice";
  
  // Location coordinates
  double? latitude = 40.7128;
  double? longitude = -74.0060;
  
  // Track changes
  bool hasChanges = false;
  
  List<Map<String, dynamic>> addressTypes = [
    {"label": "Home", "value": "home", "icon": Icons.home},
    {"label": "Work", "value": "work", "icon": Icons.work},
    {"label": "Family", "value": "family", "icon": Icons.family_restroom},
    {"label": "Vacation", "value": "vacation", "icon": Icons.beach_access},
    {"label": "Other", "value": "other", "icon": Icons.location_on},
  ];

  List<Map<String, dynamic>> countries = [
    {"label": "United States", "value": "United States"},
    {"label": "Canada", "value": "Canada"},
    {"label": "United Kingdom", "value": "United Kingdom"},
    {"label": "Australia", "value": "Australia"},
    {"label": "Germany", "value": "Germany"},
    {"label": "France", "value": "France"},
    {"label": "Italy", "value": "Italy"},
    {"label": "Spain", "value": "Spain"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Address"),
        actions: [
          QButton(
            label: "Save",
            size: bs.sm,
            onPressed: hasChanges ? () => _saveChanges() : null,
          ),
        ],
      ),
      body: Form(
        key: formKey,
        child: Column(
          children: [
            // Change Indicator
            if (hasChanges)
              Container(
                padding: EdgeInsets.all(spSm),
                color: warningColor.withAlpha(25),
                child: Row(
                  children: [
                    Icon(
                      Icons.edit,
                      color: warningColor,
                      size: 16,
                    ),
                    SizedBox(width: spSm),
                    Text(
                      "You have unsaved changes",
                      style: TextStyle(
                        fontSize: 14,
                        color: warningColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Spacer(),
                    QButton(
                      label: "Discard",
                      size: bs.sm,
                      color: dangerColor,
                      onPressed: () => _discardChanges(),
                    ),
                  ],
                ),
              ),

            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(spMd),
                child: Column(
                  spacing: spMd,
                  children: [
                    // Current Address Display
                    _buildCurrentAddressCard(),

                    // Address Label Section
                    _buildFormSection(
                      title: "Address Label",
                      icon: Icons.label,
                      child: Column(
                        spacing: spSm,
                        children: [
                          QTextField(
                            label: "Address Label",
                            value: addressLabel,
                            hint: "e.g., Home, Office, Mom's House",
                            validator: Validator.required,
                            onChanged: (value) {
                              _trackChanges(() {
                                addressLabel = value;
                              });
                            },
                          ),
                        ],
                      ),
                    ),

                    // Address Type Selection
                    _buildFormSection(
                      title: "Address Type",
                      icon: Icons.category,
                      child: Column(
                        spacing: spSm,
                        children: [
                          QCategoryPicker(
                            items: addressTypes.map((type) => {
                              "label": type["label"],
                              "value": type["value"],
                            }).toList(),
                            value: addressType,
                            onChanged: (index, label, value, item) {
                              _trackChanges(() {
                                addressType = value;
                              });
                            },
                          ),
                        ],
                      ),
                    ),

                    // Contact Information
                    _buildFormSection(
                      title: "Contact Information",
                      icon: Icons.person,
                      child: Column(
                        spacing: spSm,
                        children: [
                          QTextField(
                            label: "Full Name",
                            value: fullName,
                            hint: "Recipient name for deliveries",
                            validator: Validator.required,
                            onChanged: (value) {
                              _trackChanges(() {
                                fullName = value;
                              });
                            },
                          ),
                          QTextField(
                            label: "Phone Number",
                            value: phoneNumber,
                            hint: "+1 (555) 123-4567",
                            validator: Validator.required,
                            onChanged: (value) {
                              _trackChanges(() {
                                phoneNumber = value;
                              });
                            },
                          ),
                        ],
                      ),
                    ),

                    // Address Details
                    _buildFormSection(
                      title: "Address Details",
                      icon: Icons.location_on,
                      child: Column(
                        spacing: spSm,
                        children: [
                          QTextField(
                            label: "Street Address",
                            value: addressLine1,
                            hint: "123 Main Street",
                            validator: Validator.required,
                            onChanged: (value) {
                              _trackChanges(() {
                                addressLine1 = value;
                              });
                            },
                          ),
                          QTextField(
                            label: "Apartment, Suite, etc. (Optional)",
                            value: addressLine2,
                            hint: "Apt 4B, Suite 200",
                            onChanged: (value) {
                              _trackChanges(() {
                                addressLine2 = value;
                              });
                            },
                          ),
                          Row(
                            children: [
                              Expanded(
                                flex: 2,
                                child: QTextField(
                                  label: "City",
                                  value: city,
                                  hint: "New York",
                                  validator: Validator.required,
                                  onChanged: (value) {
                                    _trackChanges(() {
                                      city = value;
                                    });
                                  },
                                ),
                              ),
                              SizedBox(width: spSm),
                              Expanded(
                                child: QTextField(
                                  label: "State",
                                  value: state,
                                  hint: "NY",
                                  validator: Validator.required,
                                  onChanged: (value) {
                                    _trackChanges(() {
                                      state = value;
                                    });
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
                                  hint: "10001",
                                  validator: Validator.required,
                                  onChanged: (value) {
                                    _trackChanges(() {
                                      zipCode = value;
                                    });
                                  },
                                ),
                              ),
                              SizedBox(width: spSm),
                              Expanded(
                                flex: 2,
                                child: QDropdownField(
                                  label: "Country",
                                  items: countries,
                                  value: country,
                                  onChanged: (value, label) {
                                    _trackChanges(() {
                                      country = value;
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    // Map Location
                    _buildFormSection(
                      title: "Location on Map",
                      icon: Icons.map,
                      child: Column(
                        spacing: spSm,
                        children: [
                          Container(
                            height: 200,
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.circular(radiusMd),
                              border: Border.all(color: Colors.grey[300]!),
                            ),
                            child: Stack(
                              children: [
                                Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.location_on,
                                        size: 48,
                                        color: primaryColor,
                                      ),
                                      SizedBox(height: spSm),
                                      Text(
                                        "Current Location",
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: primaryColor,
                                        ),
                                      ),
                                      if (latitude != null && longitude != null)
                                        Text(
                                          "${latitude!.toStringAsFixed(4)}, ${longitude!.toStringAsFixed(4)}",
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: disabledBoldColor,
                                          ),
                                        ),
                                    ],
                                  ),
                                ),
                                Positioned(
                                  bottom: spSm,
                                  right: spSm,
                                  child: QButton(
                                    label: "Update Location",
                                    size: bs.sm,
                                    icon: Icons.edit_location,
                                    onPressed: () {
                                      _updateLocationOnMap();
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Special Instructions
                    _buildFormSection(
                      title: "Special Instructions",
                      icon: Icons.info,
                      child: Column(
                        spacing: spSm,
                        children: [
                          QMemoField(
                            label: "Delivery Instructions",
                            value: specialInstructions,
                            hint: "e.g., Ring doorbell twice, Leave at front door, Ask for Sarah at reception...",
                            onChanged: (value) {
                              _trackChanges(() {
                                specialInstructions = value;
                              });
                            },
                          ),
                        ],
                      ),
                    ),

                    // Address Settings
                    _buildFormSection(
                      title: "Address Settings",
                      icon: Icons.settings,
                      child: Column(
                        spacing: spSm,
                        children: [
                          QSwitch(
                            items: [
                              {
                                "label": "Set as default address",
                                "value": "default",
                                "checked": isDefault,
                              }
                            ],
                            value: isDefault
                                ? [
                                    {
                                      "label": "Set as default address",
                                      "value": "default",
                                      "checked": true,
                                    }
                                  ]
                                : [],
                            onChanged: (values, ids) {
                              _trackChanges(() {
                                isDefault = values.isNotEmpty;
                              });
                            },
                          ),
                          if (isDefault)
                            Container(
                              padding: EdgeInsets.all(spSm),
                              decoration: BoxDecoration(
                                color: primaryColor.withAlpha(25),
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.star,
                                    color: primaryColor,
                                    size: 16,
                                  ),
                                  SizedBox(width: spSm),
                                  Text(
                                    "This address will be used as your default delivery location",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: primaryColor,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                        ],
                      ),
                    ),

                    // Danger Zone
                    Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: dangerColor.withAlpha(25),
                        borderRadius: BorderRadius.circular(radiusMd),
                        border: Border.all(
                          color: dangerColor.withAlpha(100),
                          width: 1,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.warning,
                                color: dangerColor,
                                size: 20,
                              ),
                              SizedBox(width: spSm),
                              Text(
                                "Danger Zone",
                                style: TextStyle(
                                  fontSize: fsH6,
                                  fontWeight: FontWeight.bold,
                                  color: dangerColor,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: spSm),
                          QButton(
                            label: "Delete Address",
                            size: bs.sm,
                            color: dangerColor,
                            icon: Icons.delete_forever,
                            onPressed: isDefault ? null : () => _deleteAddress(),
                          ),
                          if (isDefault) ...[
                            SizedBox(height: spXs),
                            Text(
                              "Cannot delete default address. Set another address as default first.",
                              style: TextStyle(
                                fontSize: 12,
                                color: dangerColor,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Bottom Actions
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [shadowSm],
              ),
              child: Row(
                children: [
                  Expanded(
                    child: QButton(
                      label: "Cancel",
                      size: bs.md,
                      color: secondaryColor,
                      onPressed: () {
                        _handleCancel();
                      },
                    ),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    flex: 2,
                    child: QButton(
                      label: hasChanges ? "Save Changes" : "No Changes",
                      size: bs.md,
                      color: hasChanges ? primaryColor : disabledColor,
                      onPressed: hasChanges ? () => _saveChanges() : null,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCurrentAddressCard() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
        border: Border.all(color: primaryColor, width: 2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.edit_location,
                color: primaryColor,
                size: 20,
              ),
              SizedBox(width: spSm),
              Text(
                "Editing Address",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Spacer(),
              if (hasChanges)
                Container(
                  padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                  decoration: BoxDecoration(
                    color: warningColor,
                    borderRadius: BorderRadius.circular(radiusXs),
                  ),
                  child: Text(
                    "MODIFIED",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
            ],
          ),
          SizedBox(height: spSm),
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.grey[50],
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spXs,
              children: [
                Row(
                  children: [
                    Icon(
                      _getAddressTypeIcon(addressType),
                      color: _getAddressTypeColor(addressType),
                      size: 16,
                    ),
                    SizedBox(width: spSm),
                    Text(
                      addressLabel,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    if (isDefault) ...[
                      SizedBox(width: spSm),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 1),
                        decoration: BoxDecoration(
                          color: primaryColor,
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Text(
                          "DEFAULT",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 9,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
                Text(fullName, style: TextStyle(fontSize: 12)),
                Text("$addressLine1${addressLine2.isNotEmpty ? ", $addressLine2" : ""}", style: TextStyle(fontSize: 12)),
                Text("$city, $state $zipCode", style: TextStyle(fontSize: 12)),
                Text(phoneNumber, style: TextStyle(fontSize: 12, color: infoColor)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFormSection({
    required String title,
    required IconData icon,
    required Widget child,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.grey[50],
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(radiusMd),
              ),
            ),
            child: Row(
              children: [
                Icon(
                  icon,
                  color: primaryColor,
                  size: 20,
                ),
                SizedBox(width: spSm),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(spSm),
            child: child,
          ),
        ],
      ),
    );
  }

  IconData _getAddressTypeIcon(String type) {
    switch (type) {
      case "home":
        return Icons.home;
      case "work":
        return Icons.work;
      case "family":
        return Icons.family_restroom;
      case "vacation":
        return Icons.beach_access;
      default:
        return Icons.location_on;
    }
  }

  Color _getAddressTypeColor(String type) {
    switch (type) {
      case "home":
        return primaryColor;
      case "work":
        return infoColor;
      case "family":
        return successColor;
      case "vacation":
        return warningColor;
      default:
        return disabledBoldColor;
    }
  }

  void _trackChanges(VoidCallback callback) {
    callback();
    hasChanges = true;
    setState(() {});
  }

  void _updateLocationOnMap() {
    // Simulate location update
    _trackChanges(() {
      latitude = (latitude ?? 40.7128) + (1.0 - 2.0) * 0.01;
      longitude = (longitude ?? -74.0060) + (1.0 - 2.0) * 0.01;
    });
    si("Location updated on map");
  }

  void _discardChanges() async {
    bool isConfirmed = await confirm("Are you sure you want to discard all changes?");
    if (isConfirmed) {
      // Reset to original values (would load from original data)
      setState(() {
        hasChanges = false;
        // Reset all fields to original values here
      });
      si("Changes discarded");
    }
  }

  void _handleCancel() async {
    if (hasChanges) {
      bool isConfirmed = await confirm("You have unsaved changes. Are you sure you want to cancel?");
      if (isConfirmed) {
        back();
      }
    } else {
      back();
    }
  }

  void _saveChanges() {
    if (formKey.currentState!.validate()) {
      // Save changes logic here
      hasChanges = false;
      setState(() {});
      ss("Address updated successfully!");
      back();
    } else {
      se("Please fill in all required fields");
    }
  }

  void _deleteAddress() async {
    bool isConfirmed = await confirm("Are you sure you want to delete this address? This action cannot be undone.");
    if (isConfirmed) {
      // Delete address logic here
      ss("Address deleted successfully!");
      back();
    }
  }
}
