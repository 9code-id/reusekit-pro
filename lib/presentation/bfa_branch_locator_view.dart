import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class BfaBranchLocatorView extends StatefulWidget {
  const BfaBranchLocatorView({super.key});

  @override
  State<BfaBranchLocatorView> createState() => _BfaBranchLocatorViewState();
}

class _BfaBranchLocatorViewState extends State<BfaBranchLocatorView> {
  String searchQuery = "";
  String selectedFilter = "all";
  bool showOpenOnly = true;
  
  List<Map<String, dynamic>> branchLocations = [
    {
      "id": "branch_001",
      "name": "Downtown Main Branch",
      "address": "123 Financial District, Suite 100",
      "phone": "+1 (555) 123-4567",
      "distance": 0.3,
      "type": "Full Service",
      "isOpen": true,
      "openTime": "09:00",
      "closeTime": "17:00",
      "services": ["Personal Banking", "Business Banking", "Loans", "Investment", "Safe Deposit"],
      "hasParking": true,
      "hasATM": true,
      "wheelchairAccessible": true,
      "manager": "Sarah Johnson",
      "rating": 4.8,
      "waitTime": "5-10 minutes",
      "lat": 37.7749,
      "lng": -122.4194,
    },
    {
      "id": "branch_002",
      "name": "Westside Shopping Center",
      "address": "456 Mall Avenue, Floor 2",
      "phone": "+1 (555) 234-5678",
      "distance": 1.2,
      "type": "Express",
      "isOpen": true,
      "openTime": "10:00",
      "closeTime": "21:00",
      "services": ["Personal Banking", "ATM Services", "Quick Loans"],
      "hasParking": true,
      "hasATM": true,
      "wheelchairAccessible": true,
      "manager": "Michael Chen",
      "rating": 4.5,
      "waitTime": "2-5 minutes",
      "lat": 37.7849,
      "lng": -122.4094,
    },
    {
      "id": "branch_003",
      "name": "Airport Terminal Branch",
      "address": "789 Airport Blvd, International Terminal",
      "phone": "+1 (555) 345-6789",
      "distance": 15.5,
      "type": "Limited Service",
      "isOpen": false,
      "openTime": "06:00",
      "closeTime": "22:00",
      "services": ["Currency Exchange", "Travel Services", "ATM Services"],
      "hasParking": false,
      "hasATM": true,
      "wheelchairAccessible": true,
      "manager": "David Rodriguez",
      "rating": 4.2,
      "waitTime": "10-15 minutes",
      "lat": 37.6213,
      "lng": -122.3790,
    },
    {
      "id": "branch_004",
      "name": "University District",
      "address": "321 College Road, Student Plaza",
      "phone": "+1 (555) 456-7890",
      "distance": 2.8,
      "type": "Student Service",
      "isOpen": true,
      "openTime": "08:00",
      "closeTime": "18:00",
      "services": ["Student Banking", "Education Loans", "Financial Planning"],
      "hasParking": true,
      "hasATM": true,
      "wheelchairAccessible": true,
      "manager": "Emily Davis",
      "rating": 4.9,
      "waitTime": "3-7 minutes",
      "lat": 37.8044,
      "lng": -122.2712,
    },
    {
      "id": "branch_005",
      "name": "Business District South",
      "address": "654 Corporate Way, Tower B",
      "phone": "+1 (555) 567-8901",
      "distance": 3.1,
      "type": "Business Focus",
      "isOpen": true,
      "openTime": "08:30",
      "closeTime": "17:30",
      "services": ["Business Banking", "Commercial Loans", "Treasury Services", "Investment"],
      "hasParking": true,
      "hasATM": true,
      "wheelchairAccessible": true,
      "manager": "Robert Wilson",
      "rating": 4.7,
      "waitTime": "5-12 minutes",
      "lat": 37.7649,
      "lng": -122.4594,
    },
  ];
  
  List<Map<String, dynamic>> filterOptions = [
    {"label": "All Branches", "value": "all"},
    {"label": "Full Service", "value": "full_service"},
    {"label": "Express Service", "value": "express"},
    {"label": "Business Focus", "value": "business"},
    {"label": "With Parking", "value": "parking"},
  ];

  @override
  Widget build(BuildContext context) {
    final filteredBranches = _getFilteredBranches();
    
    return Scaffold(
      appBar: AppBar(
        title: Text("Branch Locator"),
        actions: [
          IconButton(
            icon: Icon(Icons.map),
            onPressed: () {
              _showMapView();
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Search and Filter Header
          Container(
            padding: EdgeInsets.all(spMd),
            color: Colors.grey.shade50,
            child: Column(
              children: [
                // Search Bar
                Row(
                  children: [
                    Expanded(
                      child: QTextField(
                        label: "Search branches",
                        value: searchQuery,
                        hint: "Enter location or branch name",
                        onChanged: (value) {
                          searchQuery = value;
                          setState(() {});
                        },
                      ),
                    ),
                    SizedBox(width: spSm),
                    Container(
                      decoration: BoxDecoration(
                        color: primaryColor,
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: IconButton(
                        icon: Icon(Icons.search, color: Colors.white),
                        onPressed: () {
                          // Perform search
                        },
                      ),
                    ),
                  ],
                ),
                
                SizedBox(height: spSm),
                
                // Filters
                Row(
                  children: [
                    Expanded(
                      child: QDropdownField(
                        label: "Branch Type",
                        items: filterOptions,
                        value: selectedFilter,
                        onChanged: (value, label) {
                          selectedFilter = value;
                          setState(() {});
                        },
                      ),
                    ),
                    SizedBox(width: spSm),
                    Column(
                      children: [
                        Text(
                          "Open Now",
                          style: TextStyle(fontSize: 12),
                        ),
                        Switch(
                          value: showOpenOnly,
                          onChanged: (value) {
                            showOpenOnly = value;
                            setState(() {});
                          },
                          activeColor: primaryColor,
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          
          // Results Header
          Container(
            padding: EdgeInsets.all(spMd),
            child: Row(
              children: [
                Text(
                  "${filteredBranches.length} branches found",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Spacer(),
                GestureDetector(
                  onTap: () {
                    _sortByDistance();
                  },
                  child: Row(
                    children: [
                      Icon(
                        Icons.sort,
                        size: 16,
                        color: primaryColor,
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "Sort by distance",
                        style: TextStyle(
                          color: primaryColor,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          
          // Branch List
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: spMd),
              itemCount: filteredBranches.length,
              itemBuilder: (context, index) {
                final branch = filteredBranches[index];
                return Container(
                  margin: EdgeInsets.only(bottom: spSm),
                  child: _buildBranchCard(branch),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _getCurrentLocation();
        },
        backgroundColor: primaryColor,
        child: Icon(Icons.my_location, color: Colors.white),
      ),
    );
  }

  Widget _buildBranchCard(Map<String, dynamic> branch) {
    final isOpen = branch["isOpen"] as bool;
    final rating = branch["rating"] as double;
    final hasParking = branch["hasParking"] as bool;
    final hasATM = branch["hasATM"] as bool;
    final wheelchairAccessible = branch["wheelchairAccessible"] as bool;
    
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusSm),
        boxShadow: [shadowSm],
        border: Border.all(
          color: isOpen ? Colors.grey.shade200 : dangerColor.withAlpha(100),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [primaryColor, primaryColor.withAlpha(200)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Icon(
                  Icons.account_balance,
                  color: Colors.white,
                  size: 28,
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            "${branch["name"]}",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: spXs,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: isOpen 
                              ? successColor.withAlpha(30)
                              : dangerColor.withAlpha(30),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            isOpen ? "Open" : "Closed",
                            style: TextStyle(
                              fontSize: 10,
                              color: isOpen ? successColor : dangerColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "${branch["address"]}",
                      style: TextStyle(
                        color: disabledBoldColor,
                        fontSize: 14,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Row(
                      children: [
                        Icon(Icons.star, color: warningColor, size: 14),
                        SizedBox(width: 2),
                        Text(
                          "${rating.toStringAsFixed(1)}",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(width: spSm),
                        Icon(Icons.access_time, color: disabledBoldColor, size: 14),
                        SizedBox(width: 2),
                        Text(
                          "${branch["waitTime"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          
          SizedBox(height: spSm),
          
          // Distance and Type
          Row(
            children: [
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: spXs,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: primaryColor.withAlpha(30),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.location_on,
                      size: 12,
                      color: primaryColor,
                    ),
                    SizedBox(width: 2),
                    Text(
                      "${(branch["distance"] as double).toStringAsFixed(1)} km",
                      style: TextStyle(
                        fontSize: 12,
                        color: primaryColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: spXs),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: spXs,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: infoColor.withAlpha(30),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "${branch["type"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: infoColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              if (isOpen) ...[
                SizedBox(width: spXs),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: spXs,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: successColor.withAlpha(30),
                    borderRadius: BorderRadius.circular(radiusXs),
                  ),
                  child: Text(
                    "${branch["openTime"]} - ${branch["closeTime"]}",
                    style: TextStyle(
                      fontSize: 12,
                      color: successColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ],
          ),
          
          SizedBox(height: spSm),
          
          // Amenities
          Row(
            children: [
              if (hasParking) ...[
                Icon(Icons.local_parking, size: 16, color: successColor),
                SizedBox(width: spXs),
                Text(
                  "Parking",
                  style: TextStyle(
                    fontSize: 12,
                    color: successColor,
                  ),
                ),
                SizedBox(width: spSm),
              ],
              if (hasATM) ...[
                Icon(Icons.atm, size: 16, color: successColor),
                SizedBox(width: spXs),
                Text(
                  "ATM",
                  style: TextStyle(
                    fontSize: 12,
                    color: successColor,
                  ),
                ),
                SizedBox(width: spSm),
              ],
              if (wheelchairAccessible) ...[
                Icon(Icons.accessible, size: 16, color: successColor),
                SizedBox(width: spXs),
                Text(
                  "Accessible",
                  style: TextStyle(
                    fontSize: 12,
                    color: successColor,
                  ),
                ),
              ],
            ],
          ),
          
          SizedBox(height: spSm),
          
          // Services Preview
          Wrap(
            spacing: spXs,
            runSpacing: spXs,
            children: (branch["services"] as List<String>).take(3).map((service) {
              return Container(
                padding: EdgeInsets.symmetric(
                  horizontal: spXs,
                  vertical: 2,
                ),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  service,
                  style: TextStyle(
                    fontSize: 10,
                    color: disabledBoldColor,
                  ),
                ),
              );
            }).toList(),
          ),
          
          SizedBox(height: spSm),
          
          // Actions
          Row(
            children: [
              QButton(
                label: "Call",
                size: bs.sm,
                onPressed: () {
                  _callBranch(branch);
                },
              ),
              SizedBox(width: spSm),
              QButton(
                label: "Directions",
                size: bs.sm,
                onPressed: () {
                  _openDirections(branch);
                },
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QButton(
                  label: "Details",
                  size: bs.sm,
                  onPressed: () {
                    _showBranchDetails(branch);
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  List<Map<String, dynamic>> _getFilteredBranches() {
    List<Map<String, dynamic>> filtered = List.from(branchLocations);
    
    // Apply search filter
    if (searchQuery.isNotEmpty) {
      filtered = filtered.where((branch) {
        return branch["name"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
               branch["address"].toString().toLowerCase().contains(searchQuery.toLowerCase());
      }).toList();
    }
    
    // Apply open only filter
    if (showOpenOnly) {
      filtered = filtered.where((branch) => branch["isOpen"] as bool).toList();
    }
    
    // Apply specific filters
    switch (selectedFilter) {
      case "full_service":
        filtered = filtered.where((branch) => branch["type"] == "Full Service").toList();
        break;
      case "express":
        filtered = filtered.where((branch) => branch["type"] == "Express").toList();
        break;
      case "business":
        filtered = filtered.where((branch) => 
          branch["type"] == "Business Focus").toList();
        break;
      case "parking":
        filtered = filtered.where((branch) => branch["hasParking"] as bool).toList();
        break;
    }
    
    return filtered;
  }

  void _sortByDistance() {
    branchLocations.sort((a, b) => 
      (a["distance"] as double).compareTo(b["distance"] as double));
    setState(() {});
  }

  void _getCurrentLocation() {
    ss("Getting your current location...");
  }

  void _callBranch(Map<String, dynamic> branch) {
    ss("Calling ${branch["name"]} at ${branch["phone"]}");
  }

  void _openDirections(Map<String, dynamic> branch) {
    ss("Opening directions to ${branch["name"]}");
  }

  void _showBranchDetails(Map<String, dynamic> branch) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(radiusLg),
        ),
      ),
      isScrollControlled: true,
      builder: (context) => Container(
        padding: EdgeInsets.all(spMd),
        height: MediaQuery.of(context).size.height * 0.8,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  "${branch["name"]}",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Spacer(),
                IconButton(
                  icon: Icon(Icons.close),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
            
            SizedBox(height: spSm),
            
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildDetailRow("Address", "${branch["address"]}"),
                    _buildDetailRow("Phone", "${branch["phone"]}"),
                    _buildDetailRow("Distance", "${(branch["distance"] as double).toStringAsFixed(1)} km"),
                    _buildDetailRow("Branch Type", "${branch["type"]}"),
                    _buildDetailRow("Hours", "${branch["openTime"]} - ${branch["closeTime"]}"),
                    _buildDetailRow("Manager", "${branch["manager"]}"),
                    _buildDetailRow("Rating", "${(branch["rating"] as double).toStringAsFixed(1)}/5.0"),
                    _buildDetailRow("Wait Time", "${branch["waitTime"]}"),
                    
                    SizedBox(height: spMd),
                    
                    Text(
                      "Available Services:",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Wrap(
                      spacing: spXs,
                      runSpacing: spXs,
                      children: (branch["services"] as List<String>).map((service) {
                        return Chip(
                          label: Text(
                            service,
                            style: TextStyle(fontSize: 12),
                          ),
                          backgroundColor: primaryColor.withAlpha(30),
                        );
                      }).toList(),
                    ),
                    
                    SizedBox(height: spMd),
                    
                    Text(
                      "Amenities:",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Column(
                      children: [
                        _buildAmenityRow(Icons.local_parking, "Parking Available", 
                          branch["hasParking"] as bool),
                        _buildAmenityRow(Icons.atm, "ATM On-Site", 
                          branch["hasATM"] as bool),
                        _buildAmenityRow(Icons.accessible, "Wheelchair Accessible", 
                          branch["wheelchairAccessible"] as bool),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            
            SizedBox(height: spMd),
            
            Row(
              children: [
                Expanded(
                  child: QButton(
                    label: "Call Branch",
                    onPressed: () {
                      Navigator.pop(context);
                      _callBranch(branch);
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QButton(
                    label: "Get Directions",
                    onPressed: () {
                      Navigator.pop(context);
                      _openDirections(branch);
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: spXs),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 100,
            child: Text(
              "$label:",
              style: TextStyle(
                color: disabledBoldColor,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAmenityRow(IconData icon, String label, bool available) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: spXs),
      child: Row(
        children: [
          Icon(
            icon,
            size: 20,
            color: available ? successColor : disabledColor,
          ),
          SizedBox(width: spSm),
          Text(
            label,
            style: TextStyle(
              color: available ? Colors.black : disabledBoldColor,
            ),
          ),
          Spacer(),
          Icon(
            available ? Icons.check_circle : Icons.cancel,
            size: 16,
            color: available ? successColor : disabledColor,
          ),
        ],
      ),
    );
  }

  void _showMapView() {
    ss("Opening map view...");
  }
}
