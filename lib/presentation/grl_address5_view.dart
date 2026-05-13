import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlAddress5View extends StatefulWidget {
  @override
  State<GrlAddress5View> createState() => _GrlAddress5ViewState();
}

class _GrlAddress5ViewState extends State<GrlAddress5View> {
  final formKey = GlobalKey<FormState>();
  
  String addressTitle = "";
  String fullName = "";
  String phoneNumber = "";
  String streetAddress = "";
  String apartment = "";
  String city = "";
  String state = "";
  String zipCode = "";
  String country = "United States";
  String addressType = "home";
  bool isDefaultAddress = false;
  bool saveToFavorites = true;

  List<Map<String, dynamic>> countryItems = [
    {"label": "United States", "value": "United States"},
    {"label": "Canada", "value": "Canada"},
    {"label": "United Kingdom", "value": "United Kingdom"},
    {"label": "Australia", "value": "Australia"},
    {"label": "Germany", "value": "Germany"},
    {"label": "France", "value": "France"},
    {"label": "Japan", "value": "Japan"},
    {"label": "Singapore", "value": "Singapore"},
  ];

  List<Map<String, dynamic>> stateItems = [
    {"label": "New York", "value": "NY"},
    {"label": "California", "value": "CA"},
    {"label": "Texas", "value": "TX"},
    {"label": "Florida", "value": "FL"},
    {"label": "Illinois", "value": "IL"},
    {"label": "Pennsylvania", "value": "PA"},
    {"label": "Ohio", "value": "OH"},
    {"label": "Georgia", "value": "GA"},
  ];

  List<Map<String, dynamic>> addressTypeItems = [
    {"label": "Home", "value": "home"},
    {"label": "Work/Office", "value": "work"},
    {"label": "Family", "value": "family"},
    {"label": "Other", "value": "other"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add New Address"),
        actions: [
          IconButton(
            icon: Icon(Icons.location_searching),
            onPressed: () {
              _getCurrentLocation();
            },
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
              // Address Title Section
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [primaryColor, primaryColor.withAlpha(180)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(radiusLg),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.add_location,
                          color: Colors.white,
                          size: 24,
                        ),
                        SizedBox(width: spSm),
                        Text(
                          "Address Information",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "Create a new delivery address for your orders",
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),

              // Address Title
              QTextField(
                label: "Address Title",
                value: addressTitle,
                hint: "e.g., Home, Office, Mom's House",
                validator: Validator.required,
                onChanged: (value) {
                  addressTitle = value;
                  setState(() {});
                },
              ),

              // Address Type
              QDropdownField(
                label: "Address Type",
                items: addressTypeItems,
                value: addressType,
                onChanged: (value, label) {
                  addressType = value;
                  setState(() {});
                },
              ),

              // Contact Information Section
              Text(
                "Contact Information",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),

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
                hint: "+1 (555) 123-4567",
                validator: Validator.required,
                onChanged: (value) {
                  phoneNumber = value;
                  setState(() {});
                },
              ),

              // Address Details Section
              Text(
                "Address Details",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),

              QTextField(
                label: "Street Address",
                value: streetAddress,
                hint: "123 Main Street",
                validator: Validator.required,
                onChanged: (value) {
                  streetAddress = value;
                  setState(() {});
                },
              ),

              QTextField(
                label: "Apartment, Suite, etc. (Optional)",
                value: apartment,
                hint: "Apt 4B, Suite 200",
                onChanged: (value) {
                  apartment = value;
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
                      hint: "New York",
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
                      items: stateItems,
                      value: state,
                      onChanged: (value, label) {
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
                      hint: "12345",
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
                    child: QDropdownField(
                      label: "Country",
                      items: countryItems,
                      value: country,
                      onChanged: (value, label) {
                        country = value;
                        setState(() {});
                      },
                    ),
                  ),
                ],
              ),

              // Options Section
              Text(
                "Address Options",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),

              // Default Address Switch
              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusLg),
                  boxShadow: [shadowSm],
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.star,
                      color: primaryColor,
                      size: 20,
                    ),
                    SizedBox(width: spMd),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Set as Default Address",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            "Use this address as your primary delivery location",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Switch(
                      value: isDefaultAddress,
                      onChanged: (value) {
                        isDefaultAddress = value;
                        setState(() {});
                      },
                      activeColor: primaryColor,
                    ),
                  ],
                ),
              ),

              // Save to Favorites Switch
              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusLg),
                  boxShadow: [shadowSm],
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.favorite,
                      color: dangerColor,
                      size: 20,
                    ),
                    SizedBox(width: spMd),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Save to Favorites",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            "Quick access to this address in the future",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Switch(
                      value: saveToFavorites,
                      onChanged: (value) {
                        saveToFavorites = value;
                        setState(() {});
                      },
                      activeColor: dangerColor,
                    ),
                  ],
                ),
              ),

              // Address Preview
              if (streetAddress.isNotEmpty || city.isNotEmpty)
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: successColor.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusLg),
                    border: Border.all(
                      color: successColor.withAlpha(80),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.preview,
                            color: successColor,
                            size: 20,
                          ),
                          SizedBox(width: spSm),
                          Text(
                            "Address Preview",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: successColor,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spSm),
                      if (addressTitle.isNotEmpty)
                        Text(
                          addressTitle,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      if (fullName.isNotEmpty)
                        Text(
                          fullName,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      if (streetAddress.isNotEmpty)
                        Text(
                          "${streetAddress}${apartment.isNotEmpty ? ', $apartment' : ''}",
                          style: TextStyle(fontSize: 14),
                        ),
                      if (city.isNotEmpty || state.isNotEmpty || zipCode.isNotEmpty)
                        Text(
                          "${city}${state.isNotEmpty ? ', $state' : ''}${zipCode.isNotEmpty ? ' $zipCode' : ''}",
                          style: TextStyle(fontSize: 14),
                        ),
                      if (country.isNotEmpty)
                        Text(
                          country,
                          style: TextStyle(fontSize: 14),
                        ),
                      if (phoneNumber.isNotEmpty)
                        Text(
                          phoneNumber,
                          style: TextStyle(
                            fontSize: 14,
                            color: primaryColor,
                          ),
                        ),
                    ],
                  ),
                ),

              SizedBox(height: spLg),

              // Save Button
              Container(
                width: double.infinity,
                child: QButton(
                  label: "Save Address",
                  size: bs.md,
                  icon: Icons.save,
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      _saveAddress();
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _getCurrentLocation() async {
    // Simulate getting current location
    streetAddress = "Current Location Street";
    city = "Current City";
    state = "NY";
    zipCode = "12345";
    setState(() {});
    si("Current location detected and filled automatically");
  }

  void _saveAddress() async {
    try {
      // Simulate API call
      await Future.delayed(Duration(seconds: 1));
      
      ss("Address saved successfully!");
      // back();
    } catch (e) {
      se("Failed to save address. Please try again.");
    }
  }
}
