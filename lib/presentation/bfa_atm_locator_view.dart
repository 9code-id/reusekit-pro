import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class BfaAtmLocatorView extends StatefulWidget {
  const BfaAtmLocatorView({super.key});

  @override
  State<BfaAtmLocatorView> createState() => _BfaAtmLocatorViewState();
}

class _BfaAtmLocatorViewState extends State<BfaAtmLocatorView> {
  String searchQuery = "";
  String selectedFilter = "all";
  bool showNearbyOnly = true;
  
  List<Map<String, dynamic>> atmLocations = [
    {
      "id": "atm_001",
      "name": "Downtown Plaza ATM",
      "address": "123 Main Street, Downtown",
      "distance": 0.2,
      "type": "24/7",
      "features": ["Cash Withdrawal", "Deposit", "Balance Inquiry"],
      "isAvailable": true,
      "fees": 0.0,
      "lastMaintenance": "2024-06-10",
      "cashLevel": "High",
      "lat": 37.7749,
      "lng": -122.4194,
    },
    {
      "id": "atm_002", 
      "name": "Shopping Mall ATM",
      "address": "456 Oak Avenue, Mall Level 1",
      "distance": 0.5,
      "type": "Mall Hours",
      "features": ["Cash Withdrawal", "Balance Inquiry"],
      "isAvailable": true,
      "fees": 2.5,
      "lastMaintenance": "2024-06-12",
      "cashLevel": "Medium",
      "lat": 37.7849,
      "lng": -122.4094,
    },
    {
      "id": "atm_003",
      "name": "Airport Terminal ATM",
      "address": "789 Airport Blvd, Terminal 2",
      "distance": 3.2,
      "type": "24/7",
      "features": ["Cash Withdrawal", "Currency Exchange", "Balance Inquiry"],
      "isAvailable": false,
      "fees": 5.0,
      "lastMaintenance": "2024-06-08",
      "cashLevel": "Low",
      "lat": 37.6213,
      "lng": -122.3790,
    },
    {
      "id": "atm_004",
      "name": "University Campus ATM",
      "address": "321 College Road, Student Center",
      "distance": 1.8,
      "type": "Business Hours",
      "features": ["Cash Withdrawal", "Deposit", "Balance Inquiry", "Mini Statement"],
      "isAvailable": true,
      "fees": 0.0,
      "lastMaintenance": "2024-06-14",
      "cashLevel": "High",
      "lat": 37.8044,
      "lng": -122.2712,
    },
    {
      "id": "atm_005",
      "name": "Hospital Emergency ATM",
      "address": "654 Medical Drive, Hospital Lobby",
      "distance": 2.1,
      "type": "24/7",
      "features": ["Cash Withdrawal", "Balance Inquiry"],
      "isAvailable": true,
      "fees": 1.0,
      "lastMaintenance": "2024-06-13",
      "cashLevel": "Medium",
      "lat": 37.7649,
      "lng": -122.4594,
    },
  ];
  
  List<Map<String, dynamic>> filterOptions = [
    {"label": "All ATMs", "value": "all"},
    {"label": "24/7 Available", "value": "24_7"},
    {"label": "No Fees", "value": "no_fees"},
    {"label": "Deposit Enabled", "value": "deposit"},
    {"label": "High Cash Level", "value": "high_cash"},
  ];

  @override
  Widget build(BuildContext context) {
    final filteredAtms = _getFilteredAtms();
    
    return Scaffold(
      appBar: AppBar(
        title: Text("ATM Locator"),
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
                        label: "Search location",
                        value: searchQuery,
                        hint: "Enter address or landmark",
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
                        label: "Filter",
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
                          "Nearby Only",
                          style: TextStyle(fontSize: 12),
                        ),
                        Switch(
                          value: showNearbyOnly,
                          onChanged: (value) {
                            showNearbyOnly = value;
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
                  "${filteredAtms.length} ATMs found",
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
          
          // ATM List
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: spMd),
              itemCount: filteredAtms.length,
              itemBuilder: (context, index) {
                final atm = filteredAtms[index];
                return Container(
                  margin: EdgeInsets.only(bottom: spSm),
                  child: _buildAtmCard(atm),
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

  Widget _buildAtmCard(Map<String, dynamic> atm) {
    final isAvailable = atm["isAvailable"] as bool;
    final fees = atm["fees"] as double;
    final cashLevel = atm["cashLevel"] as String;
    
    Color statusColor = isAvailable ? successColor : dangerColor;
    Color cashLevelColor = cashLevel == "High" ? successColor :
                          cashLevel == "Medium" ? warningColor : dangerColor;
    
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusSm),
        boxShadow: [shadowSm],
        border: Border.all(
          color: isAvailable ? Colors.grey.shade200 : dangerColor.withAlpha(100),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: statusColor.withAlpha(30),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Icon(
                  Icons.atm,
                  color: statusColor,
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
                        Expanded(
                          child: Text(
                            "${atm["name"]}",
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
                            color: statusColor.withAlpha(30),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            isAvailable ? "Available" : "Offline",
                            style: TextStyle(
                              fontSize: 10,
                              color: statusColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "${atm["address"]}",
                      style: TextStyle(
                        color: disabledBoldColor,
                        fontSize: 14,
                      ),
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
                      "${(atm["distance"] as double).toStringAsFixed(1)} km",
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
                  "${atm["type"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: infoColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              SizedBox(width: spXs),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: spXs,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: cashLevelColor.withAlpha(30),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "Cash: ${cashLevel}",
                  style: TextStyle(
                    fontSize: 12,
                    color: cashLevelColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          
          SizedBox(height: spSm),
          
          // Features
          Wrap(
            spacing: spXs,
            runSpacing: spXs,
            children: (atm["features"] as List<String>).map((feature) {
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
                  feature,
                  style: TextStyle(
                    fontSize: 10,
                    color: disabledBoldColor,
                  ),
                ),
              );
            }).toList(),
          ),
          
          SizedBox(height: spSm),
          
          // Fee and Actions
          Row(
            children: [
              if (fees > 0) ...[
                Icon(
                  Icons.attach_money,
                  size: 16,
                  color: warningColor,
                ),
                Text(
                  "Fee: \$${fees.toStringAsFixed(2)}",
                  style: TextStyle(
                    fontSize: 12,
                    color: warningColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ] else ...[
                Icon(
                  Icons.money_off,
                  size: 16,
                  color: successColor,
                ),
                Text(
                  "No Fee",
                  style: TextStyle(
                    fontSize: 12,
                    color: successColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
              Spacer(),
              QButton(
                label: "Directions",
                size: bs.sm,
                onPressed: isAvailable ? () {
                  _openDirections(atm);
                } : null,
              ),
              SizedBox(width: spSm),
              QButton(
                label: "Details",
                size: bs.sm,
                onPressed: () {
                  _showAtmDetails(atm);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  List<Map<String, dynamic>> _getFilteredAtms() {
    List<Map<String, dynamic>> filtered = List.from(atmLocations);
    
    // Apply search filter
    if (searchQuery.isNotEmpty) {
      filtered = filtered.where((atm) {
        return atm["name"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
               atm["address"].toString().toLowerCase().contains(searchQuery.toLowerCase());
      }).toList();
    }
    
    // Apply nearby filter
    if (showNearbyOnly) {
      filtered = filtered.where((atm) => (atm["distance"] as double) <= 5.0).toList();
    }
    
    // Apply specific filters
    switch (selectedFilter) {
      case "24_7":
        filtered = filtered.where((atm) => atm["type"] == "24/7").toList();
        break;
      case "no_fees":
        filtered = filtered.where((atm) => (atm["fees"] as double) == 0.0).toList();
        break;
      case "deposit":
        filtered = filtered.where((atm) => 
          (atm["features"] as List<String>).contains("Deposit")).toList();
        break;
      case "high_cash":
        filtered = filtered.where((atm) => atm["cashLevel"] == "High").toList();
        break;
    }
    
    return filtered;
  }

  void _sortByDistance() {
    atmLocations.sort((a, b) => 
      (a["distance"] as double).compareTo(b["distance"] as double));
    setState(() {});
  }

  void _getCurrentLocation() {
    ss("Getting your current location...");
    // Simulate getting location and updating nearby ATMs
  }

  void _openDirections(Map<String, dynamic> atm) {
    ss("Opening directions to ${atm["name"]}");
    // Open maps app with directions
  }

  void _showAtmDetails(Map<String, dynamic> atm) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(radiusLg),
        ),
      ),
      builder: (context) => Container(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Text(
                  "${atm["name"]}",
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
            
            _buildDetailRow("Address", "${atm["address"]}"),
            _buildDetailRow("Distance", "${(atm["distance"] as double).toStringAsFixed(1)} km"),
            _buildDetailRow("Operating Hours", "${atm["type"]}"),
            _buildDetailRow("Transaction Fee", 
              (atm["fees"] as double) > 0 ? "\$${(atm["fees"] as double).toStringAsFixed(2)}" : "Free"),
            _buildDetailRow("Cash Level", "${atm["cashLevel"]}"),
            _buildDetailRow("Last Maintenance", "${atm["lastMaintenance"]}"),
            
            SizedBox(height: spSm),
            
            Text(
              "Available Services:",
              style: TextStyle(
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: spXs),
            Wrap(
              spacing: spXs,
              children: (atm["features"] as List<String>).map((feature) {
                return Chip(
                  label: Text(
                    feature,
                    style: TextStyle(fontSize: 12),
                  ),
                  backgroundColor: primaryColor.withAlpha(30),
                );
              }).toList(),
            ),
            
            SizedBox(height: spMd),
            
            Row(
              children: [
                Expanded(
                  child: QButton(
                    label: "Get Directions",
                    onPressed: () {
                      Navigator.pop(context);
                      _openDirections(atm);
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QButton(
                    label: "Report Issue",
                    onPressed: () {
                      Navigator.pop(context);
                      _reportIssue(atm);
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
        children: [
          Text(
            "$label:",
            style: TextStyle(
              color: disabledBoldColor,
            ),
          ),
          SizedBox(width: spSm),
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

  void _showMapView() {
    // Navigate to map view
    ss("Opening map view...");
  }

  void _reportIssue(Map<String, dynamic> atm) {
    String issue = "not_working";
    String description = "";
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Report ATM Issue"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            QDropdownField(
              label: "Issue Type",
              items: [
                {"label": "ATM Not Working", "value": "not_working"},
                {"label": "Out of Cash", "value": "no_cash"},
                {"label": "Card Reader Problem", "value": "card_reader"},
                {"label": "Screen Issue", "value": "screen"},
                {"label": "Other", "value": "other"},
              ],
              value: issue,
              onChanged: (value, label) {
                issue = value;
              },
            ),
            SizedBox(height: spSm),
            QMemoField(
              label: "Description",
              value: description,
              hint: "Provide additional details about the issue",
              onChanged: (value) {
                description = value;
              },
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Cancel"),
          ),
          QButton(
            label: "Report Issue",
            size: bs.sm,
            onPressed: () {
              Navigator.pop(context);
              ss("Issue reported successfully. Thank you for your feedback!");
            },
          ),
        ],
      ),
    );
  }
}
