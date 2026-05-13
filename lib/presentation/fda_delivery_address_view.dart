import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class FdaDeliveryAddressView extends StatefulWidget {
  const FdaDeliveryAddressView({super.key});

  @override
  State<FdaDeliveryAddressView> createState() => _FdaDeliveryAddressViewState();
}

class _FdaDeliveryAddressViewState extends State<FdaDeliveryAddressView> {
  String selectedAddressId = "addr_001";
  String searchQuery = "";
  
  final List<Map<String, dynamic>> savedAddresses = [
    {
      "id": "addr_001",
      "type": "Home",
      "title": "Home",
      "address": "456 Oak Avenue, Apt 3B",
      "city": "Downtown",
      "state": "NY",
      "zipCode": "10001",
      "fullAddress": "456 Oak Avenue, Apt 3B, Downtown, NY 10001",
      "instructions": "Ring doorbell twice, leave at door",
      "contactPerson": "Sarah Johnson",
      "contactPhone": "+1 234 567 8900",
      "estimatedDeliveryTime": "25-35 min",
      "deliveryFee": 2.99,
      "isDefault": true,
      "distance": "1.2 km",
      "coordinates": {"lat": 40.7589, "lng": -73.9851}
    },
    {
      "id": "addr_002",
      "type": "Work",
      "title": "Office",
      "address": "789 Business Plaza, Floor 12",
      "city": "Midtown",
      "state": "NY",
      "zipCode": "10005",
      "fullAddress": "789 Business Plaza, Floor 12, Midtown, NY 10005",
      "instructions": "Call when arrived, security desk check-in required",
      "contactPerson": "Sarah Johnson",
      "contactPhone": "+1 234 567 8900",
      "estimatedDeliveryTime": "30-40 min",
      "deliveryFee": 3.99,
      "isDefault": false,
      "distance": "2.8 km",
      "coordinates": {"lat": 40.7505, "lng": -73.9934}
    },
    {
      "id": "addr_003",
      "type": "Other",
      "title": "Mom's House",
      "address": "123 Maple Street",
      "city": "Brooklyn",
      "state": "NY",
      "zipCode": "11201",
      "fullAddress": "123 Maple Street, Brooklyn, NY 11201",
      "instructions": "Use side entrance, garden gate",
      "contactPerson": "Mary Johnson",
      "contactPhone": "+1 234 567 8901",
      "estimatedDeliveryTime": "35-45 min",
      "deliveryFee": 4.99,
      "isDefault": false,
      "distance": "5.1 km",
      "coordinates": {"lat": 40.6892, "lng": -73.9442}
    }
  ];

  List<Map<String, dynamic>> get filteredAddresses {
    if (searchQuery.isEmpty) return savedAddresses;
    
    return savedAddresses.where((address) =>
      address["title"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
      address["address"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
      address["city"].toString().toLowerCase().contains(searchQuery.toLowerCase())
    ).toList();
  }

  Map<String, dynamic>? get selectedAddress {
    try {
      return savedAddresses.firstWhere((addr) => addr["id"] == selectedAddressId);
    } catch (e) {
      return null;
    }
  }

  IconData getAddressIcon(String type) {
    switch (type) {
      case "Home":
        return Icons.home;
      case "Work":
        return Icons.business;
      case "Other":
        return Icons.location_on;
      default:
        return Icons.place;
    }
  }

  Color getAddressColor(String type) {
    switch (type) {
      case "Home":
        return Colors.blue;
      case "Work":
        return Colors.orange;
      case "Other":
        return Colors.green;
      default:
        return primaryColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Delivery Address"),
        actions: [
          GestureDetector(
            onTap: () {
              // Add new address
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: spSm),
              child: Icon(
                Icons.add,
                color: primaryColor,
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          // Current Selection Header
          if (selectedAddress != null)
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: primaryColor.withAlpha(20),
                border: Border(
                  bottom: BorderSide(color: disabledOutlineBorderColor),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Delivering to:",
                    style: TextStyle(
                      fontSize: 14,
                      color: disabledBoldColor,
                    ),
                  ),
                  SizedBox(height: spXs),
                  Row(
                    children: [
                      Icon(
                        getAddressIcon(selectedAddress!["type"]),
                        color: primaryColor,
                        size: 20,
                      ),
                      SizedBox(width: spXs),
                      Expanded(
                        child: Text(
                          "${selectedAddress!["title"]} - ${selectedAddress!["fullAddress"]}",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spXs),
                  Row(
                    children: [
                      Icon(
                        Icons.access_time,
                        color: successColor,
                        size: 16,
                      ),
                      SizedBox(width: 4),
                      Text(
                        "Estimated delivery: ${selectedAddress!["estimatedDeliveryTime"]}",
                        style: TextStyle(
                          fontSize: 14,
                          color: successColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(width: spSm),
                      Icon(
                        Icons.delivery_dining,
                        color: primaryColor,
                        size: 16,
                      ),
                      SizedBox(width: 4),
                      Text(
                        "Fee: \$${selectedAddress!["deliveryFee"]}",
                        style: TextStyle(
                          fontSize: 14,
                          color: primaryColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          
          // Search Bar
          Container(
            padding: EdgeInsets.all(spMd),
            color: Colors.grey[50],
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: spSm),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusSm),
                      border: Border.all(color: disabledOutlineBorderColor),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.search,
                          color: disabledBoldColor,
                          size: 20,
                        ),
                        SizedBox(width: spXs),
                        Expanded(
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: "Search addresses...",
                              border: InputBorder.none,
                              hintStyle: TextStyle(
                                color: disabledBoldColor,
                                fontSize: 14,
                              ),
                            ),
                            onChanged: (value) {
                              searchQuery = value;
                              setState(() {});
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: spSm),
                GestureDetector(
                  onTap: () {
                    // Use current location
                    _useCurrentLocation();
                  },
                  child: Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: primaryColor,
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Icon(
                      Icons.my_location,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                ),
              ],
            ),
          ),
          
          // Address List
          Expanded(
            child: filteredAddresses.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.location_off,
                          size: 80,
                          color: disabledColor,
                        ),
                        SizedBox(height: spSm),
                        Text(
                          searchQuery.isNotEmpty 
                              ? "No addresses found"
                              : "No saved addresses",
                          style: TextStyle(
                            fontSize: fsH6,
                            color: disabledBoldColor,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Text(
                          searchQuery.isNotEmpty
                              ? "Try searching with different keywords"
                              : "Add your first delivery address",
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                          ),
                        ),
                        SizedBox(height: spMd),
                        QButton(
                          label: "Add New Address",
                          onPressed: () {
                            // Navigate to add address
                          },
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: EdgeInsets.all(spMd),
                    itemCount: filteredAddresses.length,
                    itemBuilder: (context, index) {
                      final address = filteredAddresses[index];
                      final isSelected = selectedAddressId == address["id"];
                      
                      return GestureDetector(
                        onTap: () {
                          selectedAddressId = address["id"];
                          setState(() {});
                        },
                        child: Container(
                          margin: EdgeInsets.only(bottom: spSm),
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(radiusMd),
                            boxShadow: [shadowSm],
                            border: isSelected
                                ? Border.all(color: primaryColor, width: 2)
                                : Border.all(color: disabledOutlineBorderColor),
                          ),
                          child: Column(
                            children: [
                              // Address Header
                              Row(
                                children: [
                                  Container(
                                    padding: EdgeInsets.all(spXs),
                                    decoration: BoxDecoration(
                                      color: getAddressColor(address["type"]).withAlpha(20),
                                      borderRadius: BorderRadius.circular(radiusSm),
                                    ),
                                    child: Icon(
                                      getAddressIcon(address["type"]),
                                      color: getAddressColor(address["type"]),
                                      size: 20,
                                    ),
                                  ),
                                  SizedBox(width: spSm),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              "${address["title"]}",
                                              style: TextStyle(
                                                fontSize: fsH6,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            SizedBox(width: spXs),
                                            if (address["isDefault"] as bool)
                                              Container(
                                                padding: EdgeInsets.symmetric(
                                                  horizontal: spXs,
                                                  vertical: 2,
                                                ),
                                                decoration: BoxDecoration(
                                                  color: warningColor,
                                                  borderRadius: BorderRadius.circular(radiusXs),
                                                ),
                                                child: Text(
                                                  "DEFAULT",
                                                  style: TextStyle(
                                                    fontSize: 10,
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                          ],
                                        ),
                                        SizedBox(height: 4),
                                        Text(
                                          "${address["fullAddress"]}",
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: disabledBoldColor,
                                          ),
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ],
                                    ),
                                  ),
                                  if (isSelected)
                                    Container(
                                      padding: EdgeInsets.all(4),
                                      decoration: BoxDecoration(
                                        color: primaryColor,
                                        borderRadius: BorderRadius.circular(radiusLg),
                                      ),
                                      child: Icon(
                                        Icons.check,
                                        color: Colors.white,
                                        size: 16,
                                      ),
                                    ),
                                ],
                              ),
                              
                              SizedBox(height: spSm),
                              
                              // Delivery Info
                              Row(
                                children: [
                                  Icon(
                                    Icons.access_time,
                                    color: disabledBoldColor,
                                    size: 16,
                                  ),
                                  SizedBox(width: 4),
                                  Text(
                                    "${address["estimatedDeliveryTime"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                  SizedBox(width: spSm),
                                  Icon(
                                    Icons.delivery_dining,
                                    color: disabledBoldColor,
                                    size: 16,
                                  ),
                                  SizedBox(width: 4),
                                  Text(
                                    "\$${address["deliveryFee"]} fee",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                  SizedBox(width: spSm),
                                  Icon(
                                    Icons.location_on,
                                    color: disabledBoldColor,
                                    size: 16,
                                  ),
                                  SizedBox(width: 4),
                                  Text(
                                    "${address["distance"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                  Spacer(),
                                  GestureDetector(
                                    onTap: () {
                                      _showAddressDetails(address);
                                    },
                                    child: Text(
                                      "Details",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: primaryColor,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              
                              // Instructions
                              if (address["instructions"] != null && address["instructions"].toString().isNotEmpty) ...[
                                SizedBox(height: spXs),
                                Container(
                                  width: double.infinity,
                                  padding: EdgeInsets.all(spXs),
                                  decoration: BoxDecoration(
                                    color: infoColor.withAlpha(20),
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.info_outline,
                                        color: infoColor,
                                        size: 14,
                                      ),
                                      SizedBox(width: spXs),
                                      Expanded(
                                        child: Text(
                                          "${address["instructions"]}",
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: infoColor,
                                          ),
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
                    },
                  ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(spMd),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [shadowSm],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Add New Address Button
            Container(
              width: double.infinity,
              margin: EdgeInsets.only(bottom: spSm),
              child: QButton(
                label: "Add New Address",
                onPressed: () {
                  // Navigate to add address
                },
              ),
            ),
            
            // Confirm Address Button
            Container(
              width: double.infinity,
              child: QButton(
                label: selectedAddress != null 
                    ? "Deliver to ${selectedAddress!["title"]}" 
                    : "Select Address",
                onPressed: selectedAddress != null ? () {
                  // Confirm address selection
                  ss("Delivery address updated!");
                  // Navigate back or to next step
                } : null,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _useCurrentLocation() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          padding: EdgeInsets.all(spMd),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Use Current Location",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: spSm),
              
              Text(
                "We'll detect your current location and set it as your delivery address.",
                style: TextStyle(
                  fontSize: 14,
                  color: disabledBoldColor,
                ),
                textAlign: TextAlign.center,
              ),
              
              SizedBox(height: spMd),
              
              Row(
                children: [
                  Expanded(
                    child: QButton(
                      label: "Cancel",
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: QButton(
                      label: "Detect Location",
                      onPressed: () {
                        Navigator.pop(context);
                        // Simulate location detection
                        ss("Current location detected!");
                        // Add as new address or use temporarily
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  void _showAddressDetails(Map<String, dynamic> address) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          padding: EdgeInsets.all(spMd),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(spXs),
                    decoration: BoxDecoration(
                      color: getAddressColor(address["type"]).withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Icon(
                      getAddressIcon(address["type"]),
                      color: getAddressColor(address["type"]),
                      size: 24,
                    ),
                  ),
                  SizedBox(width: spSm),
                  Text(
                    "${address["title"]}",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              
              SizedBox(height: spSm),
              
              Text(
                "Address:",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                "${address["fullAddress"]}",
                style: TextStyle(
                  fontSize: 14,
                  color: disabledBoldColor,
                ),
              ),
              
              SizedBox(height: spSm),
              
              Text(
                "Contact:",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                "${address["contactPerson"]} - ${address["contactPhone"]}",
                style: TextStyle(
                  fontSize: 14,
                  color: disabledBoldColor,
                ),
              ),
              
              if (address["instructions"] != null && address["instructions"].toString().isNotEmpty) ...[
                SizedBox(height: spSm),
                Text(
                  "Instructions:",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  "${address["instructions"]}",
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                  ),
                ),
              ],
              
              SizedBox(height: spSm),
              
              Row(
                children: [
                  Text(
                    "Delivery Time: ",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    "${address["estimatedDeliveryTime"]}",
                    style: TextStyle(
                      fontSize: 14,
                      color: successColor,
                    ),
                  ),
                  SizedBox(width: spSm),
                  Text(
                    "Fee: ",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    "\$${address["deliveryFee"]}",
                    style: TextStyle(
                      fontSize: 14,
                      color: primaryColor,
                    ),
                  ),
                ],
              ),
              
              SizedBox(height: spMd),
              
              Row(
                children: [
                  Expanded(
                    child: QButton(
                      label: "Edit Address",
                      onPressed: () {
                        Navigator.pop(context);
                        // Navigate to edit address
                      },
                    ),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: QButton(
                      label: "Select This",
                      onPressed: () {
                        Navigator.pop(context);
                        selectedAddressId = address["id"];
                        setState(() {});
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
