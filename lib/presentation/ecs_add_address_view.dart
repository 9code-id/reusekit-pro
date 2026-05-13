import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class EcsAddAddressView extends StatefulWidget {
  const EcsAddAddressView({super.key});

  @override
  State<EcsAddAddressView> createState() => _EcsAddAddressViewState();
}

class _EcsAddAddressViewState extends State<EcsAddAddressView> {
  final formKey = GlobalKey<FormState>();
  
  String addressType = "Home";
  String fullName = "";
  String phoneNumber = "";
  String addressLine1 = "";
  String addressLine2 = "";
  String city = "";
  String state = "";
  String zipCode = "";
  String country = "United States";
  bool isDefault = false;
  bool saveForFuture = true;

  List<Map<String, dynamic>> addressTypeOptions = [
    {"label": "Home", "value": "Home"},
    {"label": "Office", "value": "Office"},
    {"label": "Other", "value": "Other"},
  ];

  List<Map<String, dynamic>> countryOptions = [
    {"label": "United States", "value": "United States"},
    {"label": "Canada", "value": "Canada"},
    {"label": "United Kingdom", "value": "United Kingdom"},
    {"label": "Australia", "value": "Australia"},
    {"label": "Germany", "value": "Germany"},
    {"label": "France", "value": "France"},
    {"label": "Japan", "value": "Japan"},
    {"label": "Other", "value": "Other"},
  ];

  bool loading = false;

  void _saveAddress() async {
    if (formKey.currentState!.validate()) {
      loading = true;
      setState(() {});

      // Simulate API call
      await Future.delayed(Duration(seconds: 2));

      loading = false;
      setState(() {});

      ss("Address saved successfully");
      back();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add New Address"),
        actions: [
          QButton(
            label: "Save",
            size: bs.sm,
            onPressed: loading ? null : _saveAddress,
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
                    "Saving address...",
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
                    // Address Type Section
                    Text(
                      "Address Type",
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
                      child: QCategoryPicker(
                        items: addressTypeOptions,
                        value: addressType,
                        onChanged: (index, label, value, item) {
                          addressType = value;
                          setState(() {});
                        },
                      ),
                    ),

                    // Contact Information
                    Text(
                      "Contact Information",
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
                          QTextField(
                            label: "Full Name",
                            value: fullName,
                            hint: "Enter recipient's full name",
                            validator: Validator.required,
                            onChanged: (value) {
                              fullName = value;
                              setState(() {});
                            },
                          ),
                          QTextField(
                            label: "Phone Number",
                            value: phoneNumber,
                            hint: "+1 234 567 8900",
                            validator: Validator.required,
                            onChanged: (value) {
                              phoneNumber = value;
                              setState(() {});
                            },
                          ),
                        ],
                      ),
                    ),

                    // Address Details
                    Text(
                      "Address Details",
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
                          QTextField(
                            label: "Address Line 1",
                            value: addressLine1,
                            hint: "Street address, P.O. box, company name",
                            validator: Validator.required,
                            onChanged: (value) {
                              addressLine1 = value;
                              setState(() {});
                            },
                          ),
                          QTextField(
                            label: "Address Line 2",
                            value: addressLine2,
                            hint: "Apartment, suite, unit, building, floor, etc.",
                            onChanged: (value) {
                              addressLine2 = value;
                              setState(() {});
                            },
                          ),
                          Row(
                            spacing: spMd,
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
                            spacing: spMd,
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
                                flex: 2,
                                child: QDropdownField(
                                  label: "Country",
                                  items: countryOptions,
                                  value: country,
                                  onChanged: (value, label) {
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

                    // Additional Options
                    Text(
                      "Additional Options",
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
                          // Set as Default
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  spacing: spXs,
                                  children: [
                                    Text(
                                      "Set as Default Address",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        color: primaryColor,
                                      ),
                                    ),
                                    Text(
                                      "Use this address as your default delivery location",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Switch(
                                value: isDefault,
                                onChanged: (value) {
                                  isDefault = value;
                                  setState(() {});
                                },
                              ),
                            ],
                          ),
                          Divider(color: disabledOutlineBorderColor),
                          // Save for Future
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  spacing: spXs,
                                  children: [
                                    Text(
                                      "Save for Future Orders",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        color: primaryColor,
                                      ),
                                    ),
                                    Text(
                                      "Save this address to your address book for easy reuse",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Switch(
                                value: saveForFuture,
                                onChanged: (value) {
                                  saveForFuture = value;
                                  setState(() {});
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    // Map Preview Section
                    Text(
                      "Location Preview",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Container(
                      height: 200,
                      decoration: BoxDecoration(
                        color: disabledColor,
                        borderRadius: BorderRadius.circular(radiusMd),
                        boxShadow: [shadowSm],
                      ),
                      child: Stack(
                        children: [
                          Container(
                            width: double.infinity,
                            height: double.infinity,
                            decoration: BoxDecoration(
                              color: primaryColor.withAlpha(10),
                              borderRadius: BorderRadius.circular(radiusMd),
                            ),
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                spacing: spSm,
                                children: [
                                  Icon(
                                    Icons.location_on,
                                    size: 48,
                                    color: primaryColor,
                                  ),
                                  Text(
                                    "Map Preview",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: primaryColor,
                                    ),
                                  ),
                                  Text(
                                    "Location will be shown here",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Positioned(
                            top: spSm,
                            right: spSm,
                            child: QButton(
                              icon: Icons.my_location,
                              size: bs.sm,
                              onPressed: () {
                                // Use current location
                              },
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Action Buttons
                    Row(
                      spacing: spMd,
                      children: [
                        Expanded(
                          child: Container(
                            child: GestureDetector(
                              onTap: () {
                                back();
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(vertical: 16),
                                decoration: BoxDecoration(
                                  color: disabledColor,
                                  borderRadius: BorderRadius.circular(radiusSm),
                                ),
                                child: Text(
                                  "Cancel",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: QButton(
                            label: "Save Address",
                            size: bs.md,
                            onPressed: _saveAddress,
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
}
