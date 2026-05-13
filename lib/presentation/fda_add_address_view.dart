import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class FdaAddAddressView extends StatefulWidget {
  const FdaAddAddressView({super.key});

  @override
  State<FdaAddAddressView> createState() => _FdaAddAddressViewState();
}

class _FdaAddAddressViewState extends State<FdaAddAddressView> {
  final formKey = GlobalKey<FormState>();
  
  String addressType = "Home";
  String addressTitle = "";
  String streetAddress = "";
  String apartment = "";
  String city = "";
  String state = "";
  String zipCode = "";
  String country = "United States";
  String instructions = "";
  String contactPerson = "";
  String contactPhone = "";
  bool isDefault = false;
  
  // For location selection
  bool useCurrentLocation = false;
  double? selectedLat;
  double? selectedLng;
  
  final List<Map<String, dynamic>> addressTypes = [
    {"label": "Home", "value": "Home", "icon": Icons.home},
    {"label": "Work", "value": "Work", "icon": Icons.business},
    {"label": "Other", "value": "Other", "icon": Icons.location_on},
  ];
  
  final List<Map<String, dynamic>> countries = [
    {"label": "United States", "value": "United States"},
    {"label": "Canada", "value": "Canada"},
    {"label": "United Kingdom", "value": "United Kingdom"},
    {"label": "Australia", "value": "Australia"},
  ];
  
  final List<Map<String, dynamic>> states = [
    {"label": "New York", "value": "NY"},
    {"label": "California", "value": "CA"},
    {"label": "Texas", "value": "TX"},
    {"label": "Florida", "value": "FL"},
    {"label": "Illinois", "value": "IL"},
    {"label": "Pennsylvania", "value": "PA"},
    {"label": "Ohio", "value": "OH"},
    {"label": "Georgia", "value": "GA"},
    {"label": "North Carolina", "value": "NC"},
    {"label": "Michigan", "value": "MI"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add New Address"),
        actions: [
          GestureDetector(
            onTap: () {
              _saveAddress();
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: spSm),
              child: Center(
                child: Text(
                  "Save",
                  style: TextStyle(
                    color: primaryColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Address Type Selection
              Text(
                "Address Type",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: spSm),
              
              Row(
                children: addressTypes.map((type) {
                  final isSelected = addressType == type["value"];
                  return Expanded(
                    child: GestureDetector(
                      onTap: () {
                        addressType = type["value"] as String;
                        if (addressTitle.isEmpty) {
                          addressTitle = type["label"] as String;
                        }
                        setState(() {});
                      },
                      child: Container(
                        margin: EdgeInsets.only(
                          right: type == addressTypes.last ? 0 : spXs,
                        ),
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: isSelected ? primaryColor : Colors.white,
                          borderRadius: BorderRadius.circular(radiusMd),
                          border: Border.all(
                            color: isSelected ? primaryColor : disabledOutlineBorderColor,
                          ),
                        ),
                        child: Column(
                          children: [
                            Icon(
                              type["icon"] as IconData,
                              color: isSelected ? Colors.white : disabledBoldColor,
                              size: 28,
                            ),
                            SizedBox(height: spXs),
                            Text(
                              "${type["label"]}",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: isSelected ? Colors.white : disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
              
              SizedBox(height: spMd),
              
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
              
              SizedBox(height: spSm),
              
              // Location Section
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.grey[50],
                  borderRadius: BorderRadius.circular(radiusMd),
                  border: Border.all(color: disabledOutlineBorderColor),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Location",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: spSm),
                    
                    Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              useCurrentLocation = true;
                              _getCurrentLocation();
                              setState(() {});
                            },
                            child: Container(
                              padding: EdgeInsets.all(spSm),
                              decoration: BoxDecoration(
                                color: useCurrentLocation ? primaryColor : Colors.white,
                                borderRadius: BorderRadius.circular(radiusSm),
                                border: Border.all(
                                  color: useCurrentLocation ? primaryColor : disabledOutlineBorderColor,
                                ),
                              ),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.my_location,
                                    color: useCurrentLocation ? Colors.white : primaryColor,
                                    size: 20,
                                  ),
                                  SizedBox(width: spXs),
                                  Text(
                                    "Use Current Location",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: useCurrentLocation ? Colors.white : primaryColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              useCurrentLocation = false;
                              _selectOnMap();
                              setState(() {});
                            },
                            child: Container(
                              padding: EdgeInsets.all(spSm),
                              decoration: BoxDecoration(
                                color: !useCurrentLocation && (selectedLat != null) ? primaryColor : Colors.white,
                                borderRadius: BorderRadius.circular(radiusSm),
                                border: Border.all(
                                  color: !useCurrentLocation && (selectedLat != null) ? primaryColor : disabledOutlineBorderColor,
                                ),
                              ),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.map,
                                    color: !useCurrentLocation && (selectedLat != null) ? Colors.white : primaryColor,
                                    size: 20,
                                  ),
                                  SizedBox(width: spXs),
                                  Text(
                                    "Select on Map",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: !useCurrentLocation && (selectedLat != null) ? Colors.white : primaryColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    
                    if (useCurrentLocation || selectedLat != null) ...[
                      SizedBox(height: spSm),
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(spXs),
                        decoration: BoxDecoration(
                          color: successColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.check_circle,
                              color: successColor,
                              size: 16,
                            ),
                            SizedBox(width: spXs),
                            Text(
                              useCurrentLocation ? "Current location detected" : "Location selected on map",
                              style: TextStyle(
                                fontSize: 12,
                                color: successColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              
              SizedBox(height: spMd),
              
              // Address Details
              Text(
                "Address Details",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: spSm),
              
              // Street Address
              QTextField(
                label: "Street Address",
                value: streetAddress,
                hint: "Enter your street address",
                validator: Validator.required,
                onChanged: (value) {
                  streetAddress = value;
                  setState(() {});
                },
              ),
              
              SizedBox(height: spSm),
              
              // Apartment/Unit
              QTextField(
                label: "Apartment, suite, etc. (Optional)",
                value: apartment,
                hint: "Apt, Suite, Floor, etc.",
                onChanged: (value) {
                  apartment = value;
                  setState(() {});
                },
              ),
              
              SizedBox(height: spSm),
              
              // City and State
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
              
              // ZIP Code and Country
              Row(
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
                  SizedBox(width: spSm),
                  Expanded(
                    flex: 2,
                    child: QDropdownField(
                      label: "Country",
                      items: countries,
                      value: country,
                      onChanged: (value, label) {
                        country = value;
                        setState(() {});
                      },
                    ),
                  ),
                ],
              ),
              
              SizedBox(height: spMd),
              
              // Contact Information
              Text(
                "Contact Information",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: spSm),
              
              // Contact Person
              QTextField(
                label: "Contact Person",
                value: contactPerson,
                hint: "Name of person to contact",
                validator: Validator.required,
                onChanged: (value) {
                  contactPerson = value;
                  setState(() {});
                },
              ),
              
              SizedBox(height: spSm),
              
              // Contact Phone
              QTextField(
                label: "Contact Phone",
                value: contactPhone,
                hint: "Phone number for delivery contact",
                validator: Validator.required,
                onChanged: (value) {
                  contactPhone = value;
                  setState(() {});
                },
              ),
              
              SizedBox(height: spMd),
              
              // Delivery Instructions
              Text(
                "Delivery Instructions (Optional)",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: spSm),
              
              QMemoField(
                label: "Special Instructions",
                value: instructions,
                hint: "e.g., Ring doorbell twice, Leave at door, Call when arrived",
                onChanged: (value) {
                  instructions = value;
                  setState(() {});
                },
              ),
              
              SizedBox(height: spMd),
              
              // Quick Instructions
              Text(
                "Quick Instructions",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: spSm),
              
              QHorizontalScroll(
                children: [
                  "Ring doorbell",
                  "Leave at door",
                  "Call when arrived",
                  "Meet at lobby",
                  "Use side entrance",
                  "Don't ring doorbell"
                ].map((instruction) {
                  return GestureDetector(
                    onTap: () {
                      if (instructions.isEmpty) {
                        instructions = instruction;
                      } else {
                        instructions += ", $instruction";
                      }
                      setState(() {});
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: spSm,
                        vertical: spXs,
                      ),
                      margin: EdgeInsets.only(right: spXs),
                      decoration: BoxDecoration(
                        color: primaryColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusSm),
                        border: Border.all(color: primaryColor),
                      ),
                      child: Text(
                        instruction,
                        style: TextStyle(
                          fontSize: 14,
                          color: primaryColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
              
              SizedBox(height: spMd),
              
              // Set as Default
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.star,
                      color: isDefault ? warningColor : disabledBoldColor,
                      size: 24,
                    ),
                    SizedBox(width: spSm),
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
                              fontSize: 14,
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
                      activeColor: primaryColor,
                    ),
                  ],
                ),
              ),
              
              SizedBox(height: spMd),
              
              // Save Button
              Container(
                width: double.infinity,
                child: QButton(
                  label: "Save Address",
                  onPressed: () {
                    _saveAddress();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _getCurrentLocation() {
    // Simulate getting current location
    selectedLat = 40.7589;
    selectedLng = -73.9851;
    
    // Auto-fill address details based on location
    streetAddress = "456 Oak Avenue";
    city = "New York";
    state = "NY";
    zipCode = "10001";
    
    ss("Current location detected!");
  }

  void _selectOnMap() {
    // Simulate map selection
    selectedLat = 40.7505;
    selectedLng = -73.9934;
    
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          height: 300,
          padding: EdgeInsets.all(spMd),
          child: Column(
            children: [
              Text(
                "Select Location on Map",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: spSm),
              
              // Mock Map
              Expanded(
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(radiusMd),
                    image: DecorationImage(
                      image: NetworkImage("https://picsum.photos/400/200?random=91&keyword=map"),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Center(
                    child: Icon(
                      Icons.location_on,
                      color: dangerColor,
                      size: 40,
                    ),
                  ),
                ),
              ),
              
              SizedBox(height: spSm),
              
              Container(
                width: double.infinity,
                child: QButton(
                  label: "Confirm Location",
                  onPressed: () {
                    Navigator.pop(context);
                    ss("Location selected successfully!");
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _saveAddress() {
    if (formKey.currentState!.validate()) {
      if (selectedLat == null && !useCurrentLocation) {
        se("Please select a location on the map or use current location");
        return;
      }
      
      // Save address
      ss("Address saved successfully!");
      // Navigate back
    }
  }
}
