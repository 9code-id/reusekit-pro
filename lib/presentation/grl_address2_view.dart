import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlAddress2View extends StatefulWidget {
  final Map<String, dynamic>? address;
  
  const GrlAddress2View({Key? key, this.address}) : super(key: key);

  @override
  State<GrlAddress2View> createState() => _GrlAddress2ViewState();
}

class _GrlAddress2ViewState extends State<GrlAddress2View> {
  final formKey = GlobalKey<FormState>();
  
  String addressLabel = '';
  String fullName = '';
  String phoneNumber = '';
  String streetAddress = '';
  String apartment = '';
  String city = '';
  String state = '';
  String zipCode = '';
  String country = 'United States';
  String addressType = 'home';
  bool isDefaultAddress = false;
  bool saveToPhoneBook = false;
  
  List<Map<String, dynamic>> addressTypes = [
    {'label': 'Home', 'value': 'home', 'icon': Icons.home},
    {'label': 'Office', 'value': 'office', 'icon': Icons.business},
    {'label': 'Family', 'value': 'family', 'icon': Icons.family_restroom},
    {'label': 'Other', 'value': 'other', 'icon': Icons.location_on},
  ];
  
  List<Map<String, dynamic>> countries = [
    {'label': 'United States', 'value': 'United States', 'code': 'US'},
    {'label': 'Canada', 'value': 'Canada', 'code': 'CA'},
    {'label': 'United Kingdom', 'value': 'United Kingdom', 'code': 'UK'},
    {'label': 'Australia', 'value': 'Australia', 'code': 'AU'},
    {'label': 'Germany', 'value': 'Germany', 'code': 'DE'},
    {'label': 'France', 'value': 'France', 'code': 'FR'},
    {'label': 'Japan', 'value': 'Japan', 'code': 'JP'},
    {'label': 'India', 'value': 'India', 'code': 'IN'},
  ];

  @override
  void initState() {
    super.initState();
    _initializeForm();
  }

  void _initializeForm() {
    if (widget.address != null) {
      final addr = widget.address!;
      addressLabel = addr["label"] ?? '';
      fullName = addr["name"] ?? '';
      phoneNumber = addr["phone"] ?? '';
      streetAddress = addr["address"] ?? '';
      city = addr["city"] ?? '';
      state = addr["state"] ?? '';
      zipCode = addr["zipCode"] ?? '';
      country = addr["country"] ?? 'United States';
      addressType = addr["type"] ?? 'home';
      isDefaultAddress = addr["isDefault"] ?? false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.address != null ? "Edit Address" : "Add New Address"),
        actions: [
          if (widget.address != null)
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: () async {
                bool isConfirmed = await confirm("Are you sure you want to delete this address?");
                if (isConfirmed) {
                  back();
                  ss("Address deleted successfully");
                }
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
              // Address Label Section
              _buildSectionHeader("Address Label", Icons.label),
              QTextField(
                label: "Address Label",
                value: addressLabel,
                hint: "e.g., Home, Office, Mom's House",
                validator: Validator.required,
                onChanged: (value) {
                  addressLabel = value;
                  setState(() {});
                },
              ),
              
              // Address Type Selection
              _buildSectionHeader("Address Type", Icons.category),
              Container(
                width: double.infinity,
                child: Wrap(
                  spacing: spSm,
                  runSpacing: spSm,
                  children: addressTypes.map((type) => GestureDetector(
                    onTap: () {
                      addressType = type['value'];
                      setState(() {});
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: spMd, vertical: spSm),
                      decoration: BoxDecoration(
                        color: addressType == type['value'] ? primaryColor : Colors.white,
                        borderRadius: BorderRadius.circular(radiusLg),
                        border: Border.all(
                          color: addressType == type['value'] ? primaryColor : disabledOutlineBorderColor,
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            type['icon'],
                            size: 18,
                            color: addressType == type['value'] ? Colors.white : primaryColor,
                          ),
                          SizedBox(width: spSm),
                          Text(
                            type['label'],
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: addressType == type['value'] ? Colors.white : primaryColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  )).toList(),
                ),
              ),
              
              // Contact Information Section
              _buildSectionHeader("Contact Information", Icons.person),
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
              
              // Address Details Section
              _buildSectionHeader("Address Details", Icons.location_on),
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
                spacing: spSm,
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
                  Expanded(
                    child: QTextField(
                      label: "State",
                      value: state,
                      hint: "NY",
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
                      hint: "10001",
                      validator: Validator.required,
                      onChanged: (value) {
                        zipCode = value;
                        setState(() {});
                      },
                    ),
                  ),
                  Expanded(
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
              
              // Address Preview Section
              _buildSectionHeader("Address Preview", Icons.preview),
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.grey[50],
                  borderRadius: BorderRadius.circular(radiusLg),
                  border: Border.all(color: disabledOutlineBorderColor),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      fullName.isEmpty ? "Full Name" : fullName,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: fullName.isEmpty ? disabledColor : Colors.black,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      phoneNumber.isEmpty ? "Phone Number" : phoneNumber,
                      style: TextStyle(
                        color: phoneNumber.isEmpty ? disabledColor : disabledBoldColor,
                      ),
                    ),
                    SizedBox(height: spSm),
                    Text(
                      _buildFullAddress(),
                      style: TextStyle(
                        color: streetAddress.isEmpty ? disabledColor : disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              
              // Settings Section
              _buildSectionHeader("Settings", Icons.settings),
              
              // Default Address Toggle
              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusLg),
                  border: Border.all(color: disabledOutlineBorderColor),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.star,
                      color: warningColor,
                      size: 20,
                    ),
                    SizedBox(width: spMd),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Default Address",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            "Use this address as default for deliveries",
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
              
              // Save to Phone Book Toggle
              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusLg),
                  border: Border.all(color: disabledOutlineBorderColor),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.contacts,
                      color: infoColor,
                      size: 20,
                    ),
                    SizedBox(width: spMd),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Save to Phone Book",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            "Add this contact to your phone's address book",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Switch(
                      value: saveToPhoneBook,
                      onChanged: (value) {
                        saveToPhoneBook = value;
                        setState(() {});
                      },
                      activeColor: infoColor,
                    ),
                  ],
                ),
              ),
              
              // Location Services
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: primaryColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusLg),
                  border: Border.all(color: primaryColor),
                ),
                child: Column(
                  children: [
                    Icon(
                      Icons.my_location,
                      color: primaryColor,
                      size: 24,
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "Use Current Location",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "Automatically fill address using GPS",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 12,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spSm),
                    QButton(
                      label: "Get Location",
                      size: bs.sm,
                      icon: Icons.gps_fixed,
                      onPressed: () {
                        _getCurrentLocation();
                      },
                    ),
                  ],
                ),
              ),
              
              SizedBox(height: spXl),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(spMd),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [shadowLg],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          spacing: spSm,
          children: [
            QButton(
              label: widget.address != null ? "Update Address" : "Save Address",
              size: bs.md,
              icon: Icons.save,
              onPressed: () {
                _saveAddress();
              },
            ),
            if (widget.address != null)
              QButton(
                label: "Cancel",
                size: bs.md,
                color: disabledBoldColor,
                onPressed: () {
                  back();
                },
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title, IconData icon) {
    return Row(
      children: [
        Icon(
          icon,
          size: 20,
          color: primaryColor,
        ),
        SizedBox(width: spSm),
        Text(
          title,
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
      ],
    );
  }

  String _buildFullAddress() {
    List<String> parts = [];
    
    if (streetAddress.isNotEmpty) {
      parts.add(streetAddress);
      if (apartment.isNotEmpty) {
        parts[parts.length - 1] += ", $apartment";
      }
    } else {
      parts.add("Street Address");
    }
    
    if (city.isNotEmpty && state.isNotEmpty && zipCode.isNotEmpty) {
      parts.add("$city, $state $zipCode");
    } else {
      parts.add("City, State ZIP");
    }
    
    if (country.isNotEmpty) {
      parts.add(country);
    }
    
    return parts.join("\n");
  }

  void _getCurrentLocation() async {
    showLoading();
    
    // Simulate getting location
    await Future.delayed(Duration(seconds: 2));
    
    // Mock location data
    streetAddress = "123 Current Street";
    city = "Your City";
    state = "Your State";
    zipCode = "12345";
    
    hideLoading();
    setState(() {});
    ss("Location retrieved successfully");
  }

  void _saveAddress() async {
    if (formKey.currentState!.validate()) {
      showLoading();
      
      // Simulate API call
      await Future.delayed(Duration(seconds: 1));
      
      hideLoading();
      back();
      
      String message = widget.address != null 
          ? "Address updated successfully"
          : "Address added successfully";
      ss(message);
    }
  }
}
