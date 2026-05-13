import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class FdaAddressBookView extends StatefulWidget {
  const FdaAddressBookView({super.key});

  @override
  State<FdaAddressBookView> createState() => _FdaAddressBookViewState();
}

class _FdaAddressBookViewState extends State<FdaAddressBookView> {
  String searchQuery = "";
  
  final List<Map<String, dynamic>> addresses = [
    {
      "id": "addr_001",
      "type": "Home",
      "title": "Home",
      "address": "456 Oak Avenue, Apt 3B",
      "city": "Downtown",
      "state": "NY",
      "zipCode": "10001",
      "country": "United States",
      "fullAddress": "456 Oak Avenue, Apt 3B, Downtown, NY 10001",
      "instructions": "Ring doorbell twice, leave at door",
      "isDefault": true,
      "coordinates": {"lat": 40.7589, "lng": -73.9851},
      "contactPerson": "Sarah Johnson",
      "contactPhone": "+1 234 567 8900",
      "addedDate": "2024-01-15"
    },
    {
      "id": "addr_002",
      "type": "Work",
      "title": "Office",
      "address": "789 Business Plaza, Floor 12",
      "city": "Midtown",
      "state": "NY",
      "zipCode": "10005",
      "country": "United States",
      "fullAddress": "789 Business Plaza, Floor 12, Midtown, NY 10005",
      "instructions": "Call when arrived, security desk check-in required",
      "isDefault": false,
      "coordinates": {"lat": 40.7505, "lng": -73.9934},
      "contactPerson": "Sarah Johnson",
      "contactPhone": "+1 234 567 8900",
      "addedDate": "2024-01-20"
    },
    {
      "id": "addr_003",
      "type": "Other",
      "title": "Mom's House",
      "address": "123 Maple Street",
      "city": "Brooklyn",
      "state": "NY",
      "zipCode": "11201",
      "country": "United States",
      "fullAddress": "123 Maple Street, Brooklyn, NY 11201",
      "instructions": "Use side entrance, garden gate",
      "isDefault": false,
      "coordinates": {"lat": 40.6892, "lng": -73.9442},
      "contactPerson": "Mary Johnson",
      "contactPhone": "+1 234 567 8901",
      "addedDate": "2024-02-05"
    }
  ];

  List<Map<String, dynamic>> get filteredAddresses {
    if (searchQuery.isEmpty) return addresses;
    
    return addresses.where((address) =>
      address["title"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
      address["address"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
      address["city"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
      address["type"].toString().toLowerCase().contains(searchQuery.toLowerCase())
    ).toList();
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
        title: Text("Address Book"),
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
              ],
            ),
          ),
          
          // Addresses List
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
                              : "No addresses added yet",
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
                          label: "Add Address",
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
                      
                      return Container(
                        margin: EdgeInsets.only(bottom: spSm),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(radiusMd),
                          boxShadow: [shadowSm],
                          border: address["isDefault"] as bool
                              ? Border.all(color: primaryColor, width: 2)
                              : null,
                        ),
                        child: Column(
                          children: [
                            // Address Header
                            Container(
                              padding: EdgeInsets.all(spSm),
                              child: Row(
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
                                                  color: primaryColor,
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
                                  GestureDetector(
                                    onTap: () {
                                      _showAddressOptions(address);
                                    },
                                    child: Icon(
                                      Icons.more_vert,
                                      color: disabledBoldColor,
                                      size: 20,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            
                            // Address Details
                            if (address["instructions"] != null) ...[
                              Container(
                                width: double.infinity,
                                padding: EdgeInsets.symmetric(horizontal: spSm),
                                child: Container(
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
                                        size: 16,
                                      ),
                                      SizedBox(width: spXs),
                                      Expanded(
                                        child: Text(
                                          "Instructions: ${address["instructions"]}",
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: infoColor,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                            
                            // Contact Info
                            Container(
                              padding: EdgeInsets.all(spSm),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.person,
                                    color: disabledBoldColor,
                                    size: 16,
                                  ),
                                  SizedBox(width: spXs),
                                  Text(
                                    "${address["contactPerson"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                  SizedBox(width: spSm),
                                  Icon(
                                    Icons.phone,
                                    color: disabledBoldColor,
                                    size: 16,
                                  ),
                                  SizedBox(width: spXs),
                                  Text(
                                    "${address["contactPhone"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                  Spacer(),
                                  Text(
                                    "Added ${address["addedDate"]}",
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            
                            // Action Buttons
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: QButton(
                                      label: "Edit",
                                      size: bs.sm,
                                      onPressed: () {
                                        // Edit address
                                      },
                                    ),
                                  ),
                                  SizedBox(width: spSm),
                                  if (!(address["isDefault"] as bool))
                                    Expanded(
                                      child: QButton(
                                        label: "Set Default",
                                        size: bs.sm,
                                        onPressed: () {
                                          _setDefaultAddress(address["id"]);
                                        },
                                      ),
                                    )
                                  else
                                    Expanded(
                                      child: QButton(
                                        label: "View Map",
                                        size: bs.sm,
                                        onPressed: () {
                                          // View on map
                                        },
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigate to add address
        },
        backgroundColor: primaryColor,
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "${address["title"]}",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: spXs),
              Text(
                "${address["fullAddress"]}",
                style: TextStyle(
                  fontSize: 14,
                  color: disabledBoldColor,
                ),
              ),
              SizedBox(height: spMd),
              
              // Options
              Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                      // Edit address
                    },
                    child: Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(vertical: spSm),
                      child: Row(
                        children: [
                          Icon(
                            Icons.edit,
                            color: primaryColor,
                            size: 24,
                          ),
                          SizedBox(width: spSm),
                          Text(
                            "Edit Address",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  
                  if (!(address["isDefault"] as bool))
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                        _setDefaultAddress(address["id"]);
                      },
                      child: Container(
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(vertical: spSm),
                        child: Row(
                          children: [
                            Icon(
                              Icons.star,
                              color: warningColor,
                              size: 24,
                            ),
                            SizedBox(width: spSm),
                            Text(
                              "Set as Default",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                      // View on map
                    },
                    child: Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(vertical: spSm),
                      child: Row(
                        children: [
                          Icon(
                            Icons.map,
                            color: infoColor,
                            size: 24,
                          ),
                          SizedBox(width: spSm),
                          Text(
                            "View on Map",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                      // Share address
                    },
                    child: Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(vertical: spSm),
                      child: Row(
                        children: [
                          Icon(
                            Icons.share,
                            color: primaryColor,
                            size: 24,
                          ),
                          SizedBox(width: spSm),
                          Text(
                            "Share Address",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  
                  Divider(),
                  
                  GestureDetector(
                    onTap: () async {
                      Navigator.pop(context);
                      bool isConfirmed = await confirm("Are you sure you want to delete this address?");
                      if (isConfirmed) {
                        _deleteAddress(address["id"]);
                      }
                    },
                    child: Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(vertical: spSm),
                      child: Row(
                        children: [
                          Icon(
                            Icons.delete,
                            color: dangerColor,
                            size: 24,
                          ),
                          SizedBox(width: spSm),
                          Text(
                            "Delete Address",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: dangerColor,
                            ),
                          ),
                        ],
                      ),
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

  void _setDefaultAddress(String addressId) {
    // Update default address
    for (var address in addresses) {
      address["isDefault"] = address["id"] == addressId;
    }
    setState(() {});
    ss("Default address updated successfully!");
  }

  void _deleteAddress(String addressId) {
    addresses.removeWhere((address) => address["id"] == addressId);
    setState(() {});
    ss("Address deleted successfully!");
  }
}
