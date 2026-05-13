import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class ReaOpenHouseAlertsView extends StatefulWidget {
  const ReaOpenHouseAlertsView({super.key});

  @override
  State<ReaOpenHouseAlertsView> createState() => _ReaOpenHouseAlertsViewState();
}

class _ReaOpenHouseAlertsViewState extends State<ReaOpenHouseAlertsView> {
  String searchQuery = "";
  String filterStatus = "all";
  String filterDate = "all";
  bool alertsEnabled = true;
  
  List<Map<String, dynamic>> openHouseEvents = [
    {
      "id": "OH001",
      "propertyTitle": "Modern Downtown Condo",
      "propertyPrice": 1200000.0,
      "propertyImage": "https://picsum.photos/400/300?random=1&keyword=condo",
      "address": "123 Main St, Downtown",
      "date": "2024-01-27",
      "startTime": "10:00",
      "endTime": "12:00",
      "agent": "Sarah Martinez",
      "agentPhone": "+1 234-567-8901",
      "agentEmail": "sarah@realestate.com",
      "bedrooms": 2,
      "bathrooms": 2,
      "sqft": 1200,
      "features": ["Balcony", "Parking", "City View", "Modern Kitchen"],
      "description": "Stunning modern condo with panoramic city views",
      "status": "upcoming",
      "registered": false,
      "notes": "",
      "propertyType": "Condo"
    },
    {
      "id": "OH002",
      "propertyTitle": "Family Home with Garden",
      "propertyPrice": 850000.0,
      "propertyImage": "https://picsum.photos/400/300?random=2&keyword=house",
      "address": "456 Oak Ave, Westside",
      "date": "2024-01-27",
      "startTime": "14:00",
      "endTime": "16:00",
      "agent": "Mike Johnson",
      "agentPhone": "+1 234-567-8902",
      "agentEmail": "mike@realestate.com",
      "bedrooms": 3,
      "bathrooms": 2,
      "sqft": 1800,
      "features": ["Garden", "Garage", "Fireplace", "Updated Kitchen"],
      "description": "Perfect family home with beautiful garden and modern updates",
      "status": "upcoming",
      "registered": true,
      "notes": "Interested in the garden space",
      "propertyType": "House"
    },
    {
      "id": "OH003",
      "propertyTitle": "Luxury Penthouse Suite",
      "propertyPrice": 2500000.0,
      "propertyImage": "https://picsum.photos/400/300?random=3&keyword=penthouse",
      "address": "789 Skyline Blvd, Downtown",
      "date": "2024-01-28",
      "startTime": "11:00",
      "endTime": "13:00",
      "agent": "Lisa Chen",
      "agentPhone": "+1 234-567-8903",
      "agentEmail": "lisa@realestate.com",
      "bedrooms": 3,
      "bathrooms": 3,
      "sqft": 2200,
      "features": ["Terrace", "City View", "Luxury Finishes", "Concierge"],
      "description": "Exclusive penthouse with breathtaking views and luxury amenities",
      "status": "upcoming",
      "registered": false,
      "notes": "",
      "propertyType": "Penthouse"
    },
    {
      "id": "OH004",
      "propertyTitle": "Charming Studio Apartment",
      "propertyPrice": 450000.0,
      "propertyImage": "https://picsum.photos/400/300?random=4&keyword=studio",
      "address": "321 Center St, Midtown",
      "date": "2024-01-26",
      "startTime": "15:00",
      "endTime": "17:00",
      "agent": "David Wilson",
      "agentPhone": "+1 234-567-8904",
      "agentEmail": "david@realestate.com",
      "bedrooms": 1,
      "bathrooms": 1,
      "sqft": 600,
      "features": ["Open Layout", "Natural Light", "Modern Fixtures"],
      "description": "Cozy studio perfect for first-time buyers or investors",
      "status": "completed",
      "registered": true,
      "notes": "Good investment potential",
      "propertyType": "Studio"
    },
    {
      "id": "OH005",
      "propertyTitle": "Investment Property Duplex",
      "propertyPrice": 950000.0,
      "propertyImage": "https://picsum.photos/400/300?random=5&keyword=duplex",
      "address": "654 Investment Ave, Eastside",
      "date": "2024-01-25",
      "startTime": "12:00",
      "endTime": "14:00",
      "agent": "Emma Davis",
      "agentPhone": "+1 234-567-8905",
      "agentEmail": "emma@realestate.com",
      "bedrooms": 4,
      "bathrooms": 3,
      "sqft": 1900,
      "features": ["Rental Income", "Corner Lot", "Recently Renovated"],
      "description": "Excellent duplex investment opportunity with current tenants",
      "status": "completed",
      "registered": false,
      "notes": "",
      "propertyType": "Duplex"
    }
  ];

  List<Map<String, dynamic>> alertPreferences = [
    {
      "id": "PREF001",
      "title": "Weekend Open Houses",
      "description": "Saturday and Sunday events",
      "criteria": {
        "days": ["Saturday", "Sunday"],
        "priceMin": 500000,
        "priceMax": 2000000,
        "location": "Any",
        "propertyTypes": ["House", "Condo"]
      },
      "isActive": true,
      "notifications": {
        "email": true,
        "push": true,
        "sms": false,
        "advance": "24 hours"
      }
    },
    {
      "id": "PREF002",
      "title": "Luxury Properties",
      "description": "High-end properties above \$1.5M",
      "criteria": {
        "days": ["Any"],
        "priceMin": 1500000,
        "priceMax": 10000000,
        "location": "Downtown",
        "propertyTypes": ["Penthouse", "Luxury Condo"]
      },
      "isActive": true,
      "notifications": {
        "email": true,
        "push": true,
        "sms": true,
        "advance": "48 hours"
      }
    }
  ];

  List<Map<String, dynamic>> get filteredEvents {
    List<Map<String, dynamic>> filtered = openHouseEvents;
    
    if (searchQuery.isNotEmpty) {
      filtered = filtered.where((event) {
        return (event["propertyTitle"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
               (event["address"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
               (event["agent"] as String).toLowerCase().contains(searchQuery.toLowerCase());
      }).toList();
    }
    
    if (filterStatus != "all") {
      filtered = filtered.where((event) => event["status"] == filterStatus).toList();
    }
    
    if (filterDate != "all") {
      DateTime now = DateTime.now();
      filtered = filtered.where((event) {
        DateTime eventDate = DateTime.parse(event["date"]);
        switch (filterDate) {
          case "today":
            return eventDate.year == now.year && eventDate.month == now.month && eventDate.day == now.day;
          case "tomorrow":
            DateTime tomorrow = now.add(Duration(days: 1));
            return eventDate.year == tomorrow.year && eventDate.month == tomorrow.month && eventDate.day == tomorrow.day;
          case "thisWeek":
            return eventDate.isAfter(now) && eventDate.isBefore(now.add(Duration(days: 7)));
          default:
            return true;
        }
      }).toList();
    }
    
    return filtered;
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "upcoming":
        return primaryColor;
      case "completed":
        return successColor;
      case "cancelled":
        return dangerColor;
      default:
        return disabledColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Open House Alerts"),
        actions: [
          IconButton(
            icon: Icon(alertsEnabled ? Icons.notifications_active : Icons.notifications_off),
            onPressed: () {
              alertsEnabled = !alertsEnabled;
              setState(() {});
              ss(alertsEnabled ? "Open house alerts enabled" : "Open house alerts disabled");
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            // Search Bar
            Row(
              children: [
                Expanded(
                  child: QTextField(
                    label: "Search open houses...",
                    value: searchQuery,
                    hint: "Search by property, location, or agent",
                    onChanged: (value) {
                      searchQuery = value;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spSm),
                QButton(
                  icon: Icons.search,
                  size: bs.sm,
                  onPressed: () {},
                ),
              ],
            ),

            // Summary Cards
            ResponsiveGridView(
              padding: EdgeInsets.zero,
              minItemWidth: 200,
              children: [
                _buildSummaryCard(
                  "Upcoming Events",
                  "${openHouseEvents.where((e) => e["status"] == "upcoming").length}",
                  Icons.event,
                  primaryColor,
                  "This week",
                ),
                _buildSummaryCard(
                  "Registered",
                  "${openHouseEvents.where((e) => e["registered"] == true).length}",
                  Icons.how_to_reg,
                  successColor,
                  "You're attending",
                ),
                _buildSummaryCard(
                  "Today",
                  "${openHouseEvents.where((e) => DateTime.parse(e["date"]).day == DateTime.now().day).length}",
                  Icons.today,
                  warningColor,
                  "Events today",
                ),
                _buildSummaryCard(
                  "Active Alerts",
                  "${alertPreferences.where((a) => a["isActive"] == true).length}",
                  Icons.notifications_active,
                  infoColor,
                  "Monitoring for you",
                ),
              ],
            ),

            // Alert Preferences
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.all(spMd),
                    child: Row(
                      children: [
                        Icon(Icons.tune, color: primaryColor),
                        SizedBox(width: spSm),
                        Text(
                          "Alert Preferences",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Spacer(),
                        QButton(
                          label: "Add Preference",
                          icon: Icons.add,
                          size: bs.sm,
                          onPressed: () {
                            _showAddPreferenceDialog();
                          },
                        ),
                      ],
                    ),
                  ),
                  ListView.separated(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: alertPreferences.length,
                    separatorBuilder: (context, index) => Divider(height: 1),
                    itemBuilder: (context, index) {
                      final preference = alertPreferences[index];
                      return _buildAlertPreferenceItem(preference);
                    },
                  ),
                ],
              ),
            ),

            // Quick Filters
            Row(
              children: [
                Expanded(
                  child: QCategoryPicker(
                    label: "Status",
                    items: const [
                      {"label": "All", "value": "all"},
                      {"label": "Upcoming", "value": "upcoming"},
                      {"label": "Completed", "value": "completed"},
                      {"label": "Cancelled", "value": "cancelled"},
                    ],
                    value: filterStatus,
                    onChanged: (index, label, value, item) {
                      filterStatus = value;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QCategoryPicker(
                    label: "Date",
                    items: const [
                      {"label": "All", "value": "all"},
                      {"label": "Today", "value": "today"},
                      {"label": "Tomorrow", "value": "tomorrow"},
                      {"label": "This Week", "value": "thisWeek"},
                    ],
                    value: filterDate,
                    onChanged: (index, label, value, item) {
                      filterDate = value;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),

            // Open House Events
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.all(spMd),
                    child: Row(
                      children: [
                        Icon(Icons.home_filled, color: primaryColor),
                        SizedBox(width: spSm),
                        Text(
                          "Open House Events",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Spacer(),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: spSm,
                            vertical: spXs,
                          ),
                          decoration: BoxDecoration(
                            color: primaryColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Text(
                            "${filteredEvents.length} events",
                            style: TextStyle(
                              fontSize: 12,
                              color: primaryColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  ListView.separated(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: filteredEvents.length,
                    separatorBuilder: (context, index) => Divider(height: 1),
                    itemBuilder: (context, index) {
                      final event = filteredEvents[index];
                      return _buildOpenHouseEventItem(event);
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showCreateAlertDialog();
        },
        child: Icon(Icons.add_alert),
      ),
    );
  }

  Widget _buildSummaryCard(String title, String value, IconData icon, Color color, String subtitle) {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
        border: Border(
          left: BorderSide(width: 4, color: color),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: color, size: 24),
              Spacer(),
              Container(
                padding: EdgeInsets.all(spXs),
                decoration: BoxDecoration(
                  color: color.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Icon(icon, color: color, size: 16),
              ),
            ],
          ),
          SizedBox(height: spMd),
          Text(
            value,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spXs),
          Text(
            title,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: primaryColor,
            ),
          ),
          Text(
            subtitle,
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAlertPreferenceItem(Map<String, dynamic> preference) {
    return Container(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${preference["title"]}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "${preference["description"]}",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              Switch(
                value: preference["isActive"] as bool,
                onChanged: (value) {
                  preference["isActive"] = value;
                  setState(() {});
                  ss(value ? "Alert preference activated" : "Alert preference deactivated");
                },
              ),
            ],
          ),
          
          SizedBox(height: spSm),
          
          // Criteria Summary
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(10),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    _buildCriteriaChip("💰 \$${((preference["criteria"]["priceMin"] as int) / 1000).toStringAsFixed(0)}K - \$${((preference["criteria"]["priceMax"] as int) / 1000).toStringAsFixed(0)}K", successColor),
                    SizedBox(width: spSm),
                    _buildCriteriaChip("📍 ${preference["criteria"]["location"]}", primaryColor),
                  ],
                ),
                SizedBox(height: spXs),
                Row(
                  children: [
                    _buildCriteriaChip("⏰ ${preference["notifications"]["advance"]} notice", warningColor),
                    SizedBox(width: spSm),
                    if (preference["notifications"]["email"] as bool)
                      _buildCriteriaChip("📧 Email", infoColor),
                    if (preference["notifications"]["push"] as bool) ...[
                      SizedBox(width: spSm),
                      _buildCriteriaChip("📱 Push", infoColor),
                    ],
                  ],
                ),
              ],
            ),
          ),
          
          SizedBox(height: spSm),
          
          QButton(
            label: "Edit Preference",
            size: bs.sm,
            onPressed: () {
              _showEditPreferenceDialog(preference);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildOpenHouseEventItem(Map<String, dynamic> event) {
    return Container(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              // Property Image
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(radiusSm),
                  image: DecorationImage(
                    image: NetworkImage("${event["propertyImage"]}"),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Stack(
                  children: [
                    if (event["registered"] as bool)
                      Positioned(
                        top: spXs,
                        right: spXs,
                        child: Container(
                          padding: EdgeInsets.all(spXs),
                          decoration: BoxDecoration(
                            color: successColor,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.check,
                            color: Colors.white,
                            size: 12,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              SizedBox(width: spMd),
              
              // Event Details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: spSm,
                            vertical: spXs,
                          ),
                          decoration: BoxDecoration(
                            color: _getStatusColor(event["status"]).withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Text(
                            "${event["status"]}".toUpperCase(),
                            style: TextStyle(
                              fontSize: 10,
                              color: _getStatusColor(event["status"]),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Spacer(),
                        Text(
                          "${DateTime.parse(event["date"]).dMMMy}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "${event["propertyTitle"]}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "\$${((event["propertyPrice"] as double) / 1000).toStringAsFixed(0)}K",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: successColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "${event["address"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
          
          SizedBox(height: spSm),
          
          // Event Time and Details
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: infoColor.withAlpha(10),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Row(
              children: [
                Icon(Icons.schedule, size: 16, color: infoColor),
                SizedBox(width: spXs),
                Text(
                  "${event["startTime"]} - ${event["endTime"]}",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: infoColor,
                  ),
                ),
                Spacer(),
                Text(
                  "${event["bedrooms"]}BR • ${event["bathrooms"]}BA • ${event["sqft"]} sqft",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
          
          SizedBox(height: spSm),
          
          // Agent Information
          Row(
            children: [
              Icon(Icons.person, size: 16, color: disabledBoldColor),
              SizedBox(width: spXs),
              Text(
                "${event["agent"]}",
                style: TextStyle(
                  fontSize: 14,
                  color: primaryColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Spacer(),
              GestureDetector(
                onTap: () {
                  ss("Calling ${event["agent"]}");
                },
                child: Icon(
                  Icons.phone,
                  size: 16,
                  color: primaryColor,
                ),
              ),
              SizedBox(width: spMd),
              GestureDetector(
                onTap: () {
                  ss("Emailing ${event["agent"]}");
                },
                child: Icon(
                  Icons.email,
                  size: 16,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          
          SizedBox(height: spSm),
          
          // Features
          Wrap(
            spacing: spXs,
            runSpacing: spXs,
            children: (event["features"] as List).take(3).map((feature) {
              return Container(
                padding: EdgeInsets.symmetric(
                  horizontal: spSm,
                  vertical: spXs,
                ),
                decoration: BoxDecoration(
                  color: successColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Text(
                  "$feature",
                  style: TextStyle(
                    fontSize: 11,
                    color: successColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              );
            }).toList(),
          ),
          
          SizedBox(height: spSm),
          
          // Action Buttons
          Row(
            children: [
              if (event["status"] == "upcoming") ...[
                QButton(
                  label: event["registered"] as bool ? "Unregister" : "Register",
                  icon: event["registered"] as bool ? Icons.cancel : Icons.how_to_reg,
                  size: bs.sm,
                  onPressed: () {
                    _toggleRegistration(event);
                  },
                ),
                SizedBox(width: spSm),
              ],
              QButton(
                label: "View Details",
                size: bs.sm,
                onPressed: () {
                  _showPropertyDetails(event);
                },
              ),
              SizedBox(width: spSm),
              QButton(
                icon: Icons.directions,
                size: bs.sm,
                onPressed: () {
                  ss("Getting directions to ${event["address"]}");
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCriteriaChip(String text, Color color) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: spSm,
        vertical: spXs,
      ),
      decoration: BoxDecoration(
        color: color.withAlpha(20),
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 11,
          color: color,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  void _showAddPreferenceDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Add Alert Preference"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("Set up new open house alert preferences"),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => back(),
            child: Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              back();
              ss("Alert preference added successfully");
            },
            child: Text("Add"),
          ),
        ],
      ),
    );
  }

  void _showEditPreferenceDialog(Map<String, dynamic> preference) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Edit Preference"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("Modify alert preference: ${preference["title"]}"),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => back(),
            child: Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              back();
              ss("Preference updated successfully");
            },
            child: Text("Save"),
          ),
        ],
      ),
    );
  }

  void _showCreateAlertDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Create Open House Alert"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("Set up a new open house alert"),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => back(),
            child: Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              back();
              ss("Open house alert created");
            },
            child: Text("Create"),
          ),
        ],
      ),
    );
  }

  void _toggleRegistration(Map<String, dynamic> event) {
    bool isRegistered = event["registered"] as bool;
    event["registered"] = !isRegistered;
    setState(() {});
    ss(isRegistered ? "Unregistered from open house" : "Registered for open house");
  }

  void _showPropertyDetails(Map<String, dynamic> event) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("${event["propertyTitle"]}"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Price: \$${((event["propertyPrice"] as double) / 1000).toStringAsFixed(0)}K"),
            Text("Address: ${event["address"]}"),
            Text("Date: ${DateTime.parse(event["date"]).dMMMy}"),
            Text("Time: ${event["startTime"]} - ${event["endTime"]}"),
            Text("Agent: ${event["agent"]}"),
            SizedBox(height: spSm),
            Text("${event["description"]}"),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => back(),
            child: Text("Close"),
          ),
        ],
      ),
    );
  }
}
