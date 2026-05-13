import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class EcsEditAddressView extends StatefulWidget {
  const EcsEditAddressView({super.key});

  @override
  State<EcsEditAddressView> createState() => _EcsEditAddressViewState();
}

class _EcsEditAddressViewState extends State<EcsEditAddressView> {
  final formKey = GlobalKey<FormState>();
  String fullName = "John Doe";
  String phoneNumber = "+1 234 567 8900";
  String addressLine1 = "123 Main Street";
  String addressLine2 = "Apartment 4B";
  String city = "New York";
  String state = "NY";
  String zipCode = "10001";
  String country = "United States";
  String addressLabel = "Home";
  bool isDefaultAddress = true;
  bool loading = false;

  List<Map<String, dynamic>> addressTypes = [
    {"label": "Home", "value": "home"},
    {"label": "Work", "value": "work"},
    {"label": "Other", "value": "other"},
  ];

  List<Map<String, dynamic>> countries = [
    {"label": "United States", "value": "us"},
    {"label": "Canada", "value": "ca"},
    {"label": "United Kingdom", "value": "uk"},
    {"label": "Australia", "value": "au"},
    {"label": "Germany", "value": "de"},
  ];

  void _saveAddress() async {
    if (!formKey.currentState!.validate()) return;

    loading = true;
    setState(() {});

    // Simulate API call
    await Future.delayed(Duration(seconds: 2));

    loading = false;
    setState(() {});

    ss("Address updated successfully");
    back();
  }

  void _deleteAddress() async {
    bool isConfirmed = await confirm("Are you sure you want to delete this address?");
    if (!isConfirmed) return;

    loading = true;
    setState(() {});

    // Simulate API call
    await Future.delayed(Duration(seconds: 1));

    loading = false;
    setState(() {});

    ss("Address deleted successfully");
    back();
  }

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return Scaffold(
        appBar: AppBar(
          title: Text("Edit Address"),
        ),
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Address"),
        actions: [
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: _deleteAddress,
          ),
        ],
      ),
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: Column(
            spacing: spSm,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Address Type Selection
              QDropdownField(
                label: "Address Type",
                items: addressTypes,
                value: addressLabel.toLowerCase(),
                validator: Validator.required,
                onChanged: (value, label) {
                  addressLabel = label ?? "";
                  setState(() {});
                },
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
                label: "Phone Number",
                value: phoneNumber,
                validator: Validator.required,
                onChanged: (value) {
                  phoneNumber = value;
                  setState(() {});
                },
              ),

              // Address Information
              Text(
                "Address Details",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),

              QTextField(
                label: "Address Line 1",
                value: addressLine1,
                validator: Validator.required,
                onChanged: (value) {
                  addressLine1 = value;
                  setState(() {});
                },
              ),

              QTextField(
                label: "Address Line 2 (Optional)",
                value: addressLine2,
                onChanged: (value) {
                  addressLine2 = value;
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
                    flex: 2,
                    child: QDropdownField(
                      label: "Country",
                      items: countries,
                      value: "us",
                      validator: Validator.required,
                      onChanged: (value, label) {
                        country = label ?? "";
                        setState(() {});
                      },
                    ),
                  ),
                ],
              ),

              // Address Options
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.grey[50],
                  borderRadius: BorderRadius.circular(radiusSm),
                  border: Border.all(color: disabledOutlineBorderColor),
                ),
                child: Column(
                  spacing: spSm,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.info_outline,
                          color: infoColor,
                          size: 20,
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Text(
                            "Address Options",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: primaryColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                    
                    QSwitch(
                      items: [
                        {
                          "label": "Set as default address",
                          "value": true,
                          "checked": isDefaultAddress,
                        }
                      ],
                      value: [
                        if (isDefaultAddress)
                          {
                            "label": "Set as default address",
                            "value": true,
                            "checked": true
                          }
                      ],
                      onChanged: (values, ids) {
                        setState(() {
                          isDefaultAddress = values.isNotEmpty;
                        });
                      },
                    ),
                  ],
                ),
              ),

              SizedBox(height: spLg),

              // Action Buttons
              Column(
                spacing: spSm,
                children: [
                  Container(
                    width: double.infinity,
                    child: QButton(
                      label: "Save Address",
                      size: bs.md,
                      onPressed: _saveAddress,
                    ),
                  ),
                  
                  Container(
                    width: double.infinity,
                    child: QButton(
                      label: "Delete Address",
                      color: dangerColor,
                      size: bs.md,
                      onPressed: _deleteAddress,
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
