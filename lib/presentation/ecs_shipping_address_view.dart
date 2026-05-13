import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class EcsShippingAddressView extends StatefulWidget {
  const EcsShippingAddressView({super.key});

  @override
  State<EcsShippingAddressView> createState() => _EcsShippingAddressViewState();
}

class _EcsShippingAddressViewState extends State<EcsShippingAddressView> {
  String selectedAddress = "home";
  bool showAddForm = false;
  
  // New Address Form Fields
  String newAddressLabel = "";
  String newFullName = "";
  String newStreetAddress = "";
  String newApartment = "";
  String newCity = "";
  String newState = "";
  String newZipCode = "";
  String newPhoneNumber = "";
  bool isDefaultAddress = false;
  String addressType = "home"; // home, work, other
  
  List<Map<String, dynamic>> savedAddresses = [
    {
      "id": "home",
      "label": "Home",
      "name": "John Doe",
      "street": "123 Main Street",
      "apartment": "Apt 4B",
      "city": "New York",
      "state": "NY",
      "zipcode": "10001",
      "phone": "+1 (555) 123-4567",
      "is_default": true,
      "type": "home",
      "created_date": "2024-01-15",
    },
    {
      "id": "office",
      "label": "Office",
      "name": "John Doe",
      "street": "456 Business Ave",
      "apartment": "Suite 100",
      "city": "New York",
      "state": "NY",
      "zipcode": "10002",
      "phone": "+1 (555) 987-6543",
      "is_default": false,
      "type": "work",
      "created_date": "2024-02-20",
    },
    {
      "id": "parents",
      "label": "Parents House",
      "name": "John Doe",
      "street": "789 Family Lane",
      "apartment": "",
      "city": "Brooklyn",
      "state": "NY",
      "zipcode": "11201",
      "phone": "+1 (555) 456-7890",
      "is_default": false,
      "type": "home",
      "created_date": "2024-03-10",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Shipping Address"),
        actions: [
          if (!showAddForm && savedAddresses.isNotEmpty)
            GestureDetector(
              onTap: () {
                showAddForm = true;
                setState(() {});
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: spMd),
                child: Center(
                  child: Text(
                    "Add New",
                    style: TextStyle(
                      color: primaryColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
      body: showAddForm ? _buildAddAddressForm() : _buildAddressList(),
      bottomNavigationBar: !showAddForm && savedAddresses.isNotEmpty 
        ? Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [shadowSm],
            ),
            child: QButton(
              label: "Use Selected Address",
              icon: Icons.check,
              size: bs.md,
              onPressed: () => _useSelectedAddress(),
            ),
          )
        : null,
    );
  }

  Widget _buildAddressList() {
    if (savedAddresses.isEmpty) {
      return _buildEmptyState();
    }

    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Info
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: infoColor.withAlpha(26),
              borderRadius: BorderRadius.circular(radiusMd),
              border: Border.all(color: infoColor.withAlpha(51)),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.info,
                  color: infoColor,
                  size: 20,
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: Text(
                    "Select a delivery address for your order. You can add a new address or edit existing ones.",
                    style: TextStyle(
                      fontSize: 12,
                      color: infoColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
          
          SizedBox(height: spMd),
          
          Text(
            "Saved Addresses",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: spSm),

          // Address List
          Column(
            children: savedAddresses.map((address) {
              final isSelected = selectedAddress == address["id"];
              
              return GestureDetector(
                onTap: () {
                  selectedAddress = "${address["id"]}";
                  setState(() {});
                },
                child: Container(
                  margin: EdgeInsets.only(bottom: spMd),
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                    border: Border.all(
                      color: isSelected ? primaryColor : disabledOutlineBorderColor,
                      width: isSelected ? 2 : 1,
                    ),
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          // Selection Radio
                          Container(
                            width: 20,
                            height: 20,
                            decoration: BoxDecoration(
                              color: isSelected ? primaryColor : Colors.white,
                              border: Border.all(
                                color: isSelected ? primaryColor : disabledOutlineBorderColor,
                              ),
                              shape: BoxShape.circle,
                            ),
                            child: isSelected
                                ? Icon(
                                    Icons.check,
                                    color: Colors.white,
                                    size: 14,
                                  )
                                : null,
                          ),
                          
                          SizedBox(width: spMd),
                          
                          // Address Icon
                          Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: primaryColor.withAlpha(26),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Icon(
                              address["type"] == "work" ? Icons.business : Icons.home,
                              color: primaryColor,
                              size: 20,
                            ),
                          ),
                          
                          SizedBox(width: spMd),
                          
                          // Address Info
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      "${address["label"]}",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    if (address["is_default"] as bool) ...[
                                      SizedBox(width: spXs),
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: spXs,
                                          vertical: 2,
                                        ),
                                        decoration: BoxDecoration(
                                          color: successColor,
                                          borderRadius: BorderRadius.circular(radiusXs),
                                        ),
                                        child: Text(
                                          "Default",
                                          style: TextStyle(
                                            fontSize: 10,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ],
                                ),
                                SizedBox(height: spXs),
                                
                                Text(
                                  "${address["name"]}",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                
                                Text(
                                  "${address["street"]}${address["apartment"].toString().isNotEmpty ? ', ${address["apartment"]}' : ''}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                
                                Text(
                                  "${address["city"]}, ${address["state"]} ${address["zipcode"]}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                
                                Text(
                                  "${address["phone"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          
                          // Edit/More Options
                          GestureDetector(
                            onTap: () => _showAddressOptions(address),
                            child: Container(
                              padding: EdgeInsets.all(spXs),
                              decoration: BoxDecoration(
                                color: disabledColor.withAlpha(51),
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                Icons.more_vert,
                                size: 16,
                                color: disabledBoldColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                      
                      // Delivery Estimate
                      if (isSelected) ...[
                        SizedBox(height: spMd),
                        Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: successColor.withAlpha(26),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.local_shipping,
                                color: successColor,
                                size: 16,
                              ),
                              SizedBox(width: spXs),
                              Text(
                                "Estimated delivery: 2-5 business days",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: successColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              );
            }).toList(),
          ),

          // Add New Address Button
          GestureDetector(
            onTap: () {
              showAddForm = true;
              setState(() {});
            },
            child: Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
                border: Border.all(color: primaryColor, style: BorderStyle.solid),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.add,
                    color: primaryColor,
                    size: 20,
                  ),
                  SizedBox(width: spSm),
                  Text(
                    "Add New Address",
                    style: TextStyle(
                      color: primaryColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(spMd),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.location_on,
              size: 80,
              color: disabledColor,
            ),
            SizedBox(height: spMd),
            Text(
              "No Addresses Added",
              style: TextStyle(
                fontSize: fsH4,
                fontWeight: FontWeight.bold,
                color: disabledBoldColor,
              ),
            ),
            SizedBox(height: spSm),
            Text(
              "Add your delivery address to continue with your order.",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: disabledBoldColor,
              ),
            ),
            SizedBox(height: spMd),
            QButton(
              label: "Add Address",
              icon: Icons.add,
              size: bs.md,
              onPressed: () {
                showAddForm = true;
                setState(() {});
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAddAddressForm() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Add New Address",
            style: TextStyle(
              fontSize: fsH5,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: spMd),

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
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    addressType = "home";
                    setState(() {});
                  },
                  child: Container(
                    padding: EdgeInsets.all(spMd),
                    decoration: BoxDecoration(
                      color: addressType == "home" ? primaryColor : Colors.white,
                      borderRadius: BorderRadius.circular(radiusSm),
                      border: Border.all(
                        color: addressType == "home" ? primaryColor : disabledOutlineBorderColor,
                      ),
                    ),
                    child: Column(
                      children: [
                        Icon(
                          Icons.home,
                          color: addressType == "home" ? Colors.white : disabledBoldColor,
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "Home",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: addressType == "home" ? Colors.white : disabledBoldColor,
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
                    addressType = "work";
                    setState(() {});
                  },
                  child: Container(
                    padding: EdgeInsets.all(spMd),
                    decoration: BoxDecoration(
                      color: addressType == "work" ? primaryColor : Colors.white,
                      borderRadius: BorderRadius.circular(radiusSm),
                      border: Border.all(
                        color: addressType == "work" ? primaryColor : disabledOutlineBorderColor,
                      ),
                    ),
                    child: Column(
                      children: [
                        Icon(
                          Icons.business,
                          color: addressType == "work" ? Colors.white : disabledBoldColor,
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "Work",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: addressType == "work" ? Colors.white : disabledBoldColor,
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
                    addressType = "other";
                    setState(() {});
                  },
                  child: Container(
                    padding: EdgeInsets.all(spMd),
                    decoration: BoxDecoration(
                      color: addressType == "other" ? primaryColor : Colors.white,
                      borderRadius: BorderRadius.circular(radiusSm),
                      border: Border.all(
                        color: addressType == "other" ? primaryColor : disabledOutlineBorderColor,
                      ),
                    ),
                    child: Column(
                      children: [
                        Icon(
                          Icons.location_on,
                          color: addressType == "other" ? Colors.white : disabledBoldColor,
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "Other",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: addressType == "other" ? Colors.white : disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),

          SizedBox(height: spMd),

          // Form Fields
          Column(
            spacing: spSm,
            children: [
              QTextField(
                label: "Address Label",
                value: newAddressLabel,
                hint: "e.g., Home, Office, Mom's House",
                onChanged: (value) {
                  newAddressLabel = value;
                  setState(() {});
                },
              ),

              QTextField(
                label: "Full Name",
                value: newFullName,
                hint: "Recipient's full name",
                onChanged: (value) {
                  newFullName = value;
                  setState(() {});
                },
              ),

              QTextField(
                label: "Street Address",
                value: newStreetAddress,
                hint: "House number and street name",
                onChanged: (value) {
                  newStreetAddress = value;
                  setState(() {});
                },
              ),

              QTextField(
                label: "Apartment/Suite (Optional)",
                value: newApartment,
                hint: "Apt, Suite, Unit, Building, Floor, etc.",
                onChanged: (value) {
                  newApartment = value;
                  setState(() {});
                },
              ),

              Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: QTextField(
                      label: "City",
                      value: newCity,
                      hint: "City name",
                      onChanged: (value) {
                        newCity = value;
                        setState(() {});
                      },
                    ),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: QTextField(
                      label: "State",
                      value: newState,
                      hint: "NY",
                      onChanged: (value) {
                        newState = value;
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
                      value: newZipCode,
                      hint: "12345",
                      onChanged: (value) {
                        newZipCode = value;
                        setState(() {});
                      },
                    ),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    flex: 2,
                    child: QTextField(
                      label: "Phone Number",
                      value: newPhoneNumber,
                      hint: "(555) 123-4567",
                      onChanged: (value) {
                        newPhoneNumber = value;
                        setState(() {});
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),

          SizedBox(height: spMd),

          // Default Address Switch
          Row(
            children: [
              Checkbox(
                value: isDefaultAddress,
                activeColor: primaryColor,
                onChanged: (value) {
                  isDefaultAddress = value ?? false;
                  setState(() {});
                },
              ),
              Expanded(
                child: Text(
                  "Set as default delivery address",
                  style: TextStyle(fontSize: 14),
                ),
              ),
            ],
          ),

          SizedBox(height: spMd),

          // Action Buttons
          Row(
            children: [
              Expanded(
                child: QButton(
                  label: "Cancel",
                  size: bs.md,
                  onPressed: () {
                    showAddForm = false;
                    _clearForm();
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                flex: 2,
                child: QButton(
                  label: "Save Address",
                  icon: Icons.save,
                  size: bs.md,
                  onPressed: () => _saveNewAddress(),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _showAddressOptions(Map<String, dynamic> address) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          padding: EdgeInsets.all(spMd),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "${address["label"]}",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: spMd),
              
              Row(
                children: [
                  Expanded(
                    child: QButton(
                      label: "Edit",
                      icon: Icons.edit,
                      size: bs.md,
                      onPressed: () {
                        Navigator.pop(context);
                        _editAddress(address);
                      },
                    ),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: QButton(
                      label: "Delete",
                      icon: Icons.delete,
                      size: bs.md,
                      onPressed: () {
                        Navigator.pop(context);
                        _deleteAddress(address);
                      },
                    ),
                  ),
                ],
              ),
              
              if (!(address["is_default"] as bool)) ...[
                SizedBox(height: spSm),
                QButton(
                  label: "Set as Default",
                  icon: Icons.home,
                  size: bs.md,
                  onPressed: () {
                    Navigator.pop(context);
                    _setAsDefault(address);
                  },
                ),
              ],
            ],
          ),
        );
      },
    );
  }

  void _saveNewAddress() {
    if (_validateForm()) {
      final newAddress = {
        "id": DateTime.now().millisecondsSinceEpoch.toString(),
        "label": newAddressLabel,
        "name": newFullName,
        "street": newStreetAddress,
        "apartment": newApartment,
        "city": newCity,
        "state": newState,
        "zipcode": newZipCode,
        "phone": newPhoneNumber,
        "is_default": isDefaultAddress,
        "type": addressType,
        "created_date": DateTime.now().toString().split(' ')[0],
      };

      if (isDefaultAddress) {
        // Remove default from other addresses
        for (var addr in savedAddresses) {
          addr["is_default"] = false;
        }
      }

      savedAddresses.add(newAddress);
      selectedAddress = newAddress["id"] as String;
      showAddForm = false;
      _clearForm();
      setState(() {});
      ss("Address saved successfully!");
    }
  }

  void _editAddress(Map<String, dynamic> address) {
    // Populate form with existing data
    newAddressLabel = "${address["label"]}";
    newFullName = "${address["name"]}";
    newStreetAddress = "${address["street"]}";
    newApartment = "${address["apartment"]}";
    newCity = "${address["city"]}";
    newState = "${address["state"]}";
    newZipCode = "${address["zipcode"]}";
    newPhoneNumber = "${address["phone"]}";
    isDefaultAddress = address["is_default"] as bool;
    addressType = "${address["type"]}";
    
    showAddForm = true;
    setState(() {});
  }

  void _deleteAddress(Map<String, dynamic> address) {
    savedAddresses.remove(address);
    if (selectedAddress == address["id"]) {
      selectedAddress = savedAddresses.isNotEmpty ? "${savedAddresses.first["id"]}" : "";
    }
    setState(() {});
    ss("Address deleted");
  }

  void _setAsDefault(Map<String, dynamic> address) {
    for (var addr in savedAddresses) {
      addr["is_default"] = addr["id"] == address["id"];
    }
    setState(() {});
    ss("Default address updated");
  }

  void _clearForm() {
    newAddressLabel = "";
    newFullName = "";
    newStreetAddress = "";
    newApartment = "";
    newCity = "";
    newState = "";
    newZipCode = "";
    newPhoneNumber = "";
    isDefaultAddress = false;
    addressType = "home";
  }

  bool _validateForm() {
    if (newAddressLabel.trim().isEmpty ||
        newFullName.trim().isEmpty ||
        newStreetAddress.trim().isEmpty ||
        newCity.trim().isEmpty ||
        newState.trim().isEmpty ||
        newZipCode.trim().isEmpty ||
        newPhoneNumber.trim().isEmpty) {
      se("Please fill in all required fields");
      return false;
    }
    return true;
  }

  void _useSelectedAddress() {
    final address = savedAddresses.firstWhere(
      (addr) => addr["id"] == selectedAddress,
      orElse: () => savedAddresses.first,
    );
    
    back();
    ss("Shipping to ${address["label"]}");
  }
}
