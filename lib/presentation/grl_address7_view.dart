import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlAddress7View extends StatefulWidget {
  @override
  State<GrlAddress7View> createState() => _GrlAddress7ViewState();
}

class _GrlAddress7ViewState extends State<GrlAddress7View> {
  final formKey = GlobalKey<FormState>();
  
  String addressTitle = "Home Sweet Home";
  String fullName = "John Doe";
  String phoneNumber = "+1 (555) 123-4567";
  String streetAddress = "123 Main Street";
  String apartment = "Apt 4B";
  String city = "New York";
  String state = "NY";
  String zipCode = "10001";
  String country = "United States";
  String addressType = "home";
  bool isDefaultAddress = true;
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
        title: Text("Edit Address"),
        actions: [
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              _deleteAddress();
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
              // Address Status Card
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [infoColor, infoColor.withAlpha(180)],
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
                          Icons.edit_location,
                          color: Colors.white,
                          size: 24,
                        ),
                        SizedBox(width: spSm),
                        Text(
                          "Edit Address Information",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spSm),
                    Row(
                      children: [
                        if (isDefaultAddress)
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: spSm,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white.withAlpha(40),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Text(
                              "DEFAULT ADDRESS",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        if (saveToFavorites && isDefaultAddress)
                          SizedBox(width: spSm),
                        if (saveToFavorites)
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: spSm,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white.withAlpha(40),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Text(
                              "FAVORITE",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ],
                ),
              ),

              // Quick Actions
              Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(spMd),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(radiusLg),
                        boxShadow: [shadowSm],
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.my_location,
                            color: primaryColor,
                            size: 20,
                          ),
                          SizedBox(width: spSm),
                          Expanded(
                            child: Text(
                              "Use Current Location",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          Switch(
                            value: false,
                            onChanged: (value) {
                              if (value) {
                                _getCurrentLocation();
                              }
                            },
                            activeColor: primaryColor,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
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

              // Address Options Section
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

              // Usage Statistics
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusLg),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Usage Statistics",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spSm),
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            children: [
                              Text(
                                "45",
                                style: TextStyle(
                                  fontSize: fsH5,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                              Text(
                                "Times Used",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              Text(
                                "2 days ago",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: successColor,
                                ),
                              ),
                              Text(
                                "Last Used",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              Text(
                                "6 months ago",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: infoColor,
                                ),
                              ),
                              Text(
                                "Created",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Address Preview
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
                          "Updated Address Preview",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: successColor,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spSm),
                    Text(
                      addressTitle,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      fullName,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      "${streetAddress}${apartment.isNotEmpty ? ', $apartment' : ''}",
                      style: TextStyle(fontSize: 14),
                    ),
                    Text(
                      "${city}, ${state} ${zipCode}",
                      style: TextStyle(fontSize: 14),
                    ),
                    Text(
                      country,
                      style: TextStyle(fontSize: 14),
                    ),
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

              // Action Buttons
              Row(
                children: [
                  Expanded(
                    child: QButton(
                      label: "Cancel",
                      size: bs.md,
                      onPressed: () {
                        // back();
                      },
                    ),
                  ),
                  SizedBox(width: spMd),
                  Expanded(
                    flex: 2,
                    child: QButton(
                      label: "Save Changes",
                      size: bs.md,
                      icon: Icons.save,
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          _saveChanges();
                        }
                      },
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

  void _getCurrentLocation() async {
    // Simulate getting current location
    streetAddress = "Current Location Street";
    city = "Current City";
    state = "NY";
    zipCode = "12345";
    setState(() {});
    si("Current location detected and address updated");
  }

  void _saveChanges() async {
    try {
      showLoading();
      
      // Simulate API call
      await Future.delayed(Duration(seconds: 2));
      
      hideLoading();
      ss("Address updated successfully!");
      // back();
    } catch (e) {
      hideLoading();
      se("Failed to update address. Please try again.");
    }
  }

  void _deleteAddress() async {
    bool isConfirmed = await confirm("Are you sure you want to delete this address? This action cannot be undone.");
    
    if (isConfirmed) {
      try {
        showLoading();
        
        // Simulate API call
        await Future.delayed(Duration(seconds: 1));
        
        hideLoading();
        ss("Address deleted successfully!");
        // back();
      } catch (e) {
        hideLoading();
        se("Failed to delete address. Please try again.");
      }
    }
  }
}
