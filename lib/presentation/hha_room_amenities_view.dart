import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class HhaRoomAmenitiesView extends StatefulWidget {
  const HhaRoomAmenitiesView({super.key});

  @override
  State<HhaRoomAmenitiesView> createState() => _HhaRoomAmenitiesViewState();
}

class _HhaRoomAmenitiesViewState extends State<HhaRoomAmenitiesView> {
  int currentTab = 0;
  String selectedRoom = "all";
  String selectedCategory = "all";
  String selectedStatus = "all";
  String searchQuery = "";

  List<Map<String, dynamic>> amenities = [
    {
      "id": "AMN001",
      "roomNumber": "101",
      "floor": 1,
      "type": "Standard",
      "category": "bathroom",
      "item": "Luxury Soap Set",
      "brand": "Molton Brown",
      "quantity": 2,
      "status": "available",
      "condition": "new",
      "lastRestocked": "2024-06-14",
      "expiryDate": "2025-06-01",
      "cost": 25.0,
      "guestRating": 4.8,
      "description": "Premium soap collection with lavender scent"
    },
    {
      "id": "AMN002",
      "roomNumber": "101",
      "floor": 1,
      "type": "Standard",
      "category": "beverages",
      "item": "Coffee Machine",
      "brand": "Nespresso",
      "quantity": 1,
      "status": "available",
      "condition": "good",
      "lastRestocked": "2024-05-20",
      "expiryDate": null,
      "cost": 180.0,
      "guestRating": 4.6,
      "description": "Automatic coffee machine with pod system"
    },
    {
      "id": "AMN003",
      "roomNumber": "205",
      "floor": 2,
      "type": "Deluxe",
      "category": "entertainment",
      "item": "Smart TV",
      "brand": "Samsung",
      "quantity": 1,
      "status": "maintenance",
      "condition": "fair",
      "lastRestocked": "2024-03-15",
      "expiryDate": null,
      "cost": 650.0,
      "guestRating": 4.2,
      "description": "55-inch Smart TV with streaming services"
    },
    {
      "id": "AMN004",
      "roomNumber": "312",
      "floor": 3,
      "type": "Suite",
      "category": "comfort",
      "item": "Mini Fridge",
      "brand": "Liebherr",
      "quantity": 1,
      "status": "available",
      "condition": "excellent",
      "lastRestocked": "2024-06-10",
      "expiryDate": null,
      "cost": 420.0,
      "guestRating": 4.9,
      "description": "Compact mini fridge with freezer compartment"
    },
    {
      "id": "AMN005",
      "roomNumber": "418",
      "floor": 4,
      "type": "Executive",
      "category": "wellness",
      "item": "Essential Oil Diffuser",
      "brand": "Aromatherapy Co",
      "quantity": 1,
      "status": "missing",
      "condition": "unknown",
      "lastRestocked": "2024-06-05",
      "expiryDate": "2025-01-01",
      "cost": 85.0,
      "guestRating": 4.7,
      "description": "Bluetooth enabled diffuser with premium oils"
    },
    {
      "id": "AMN006",
      "roomNumber": "523",
      "floor": 5,
      "type": "Presidential",
      "category": "luxury",
      "item": "Champagne Service Set",
      "brand": "Waterford Crystal",
      "quantity": 4,
      "status": "available",
      "condition": "excellent",
      "lastRestocked": "2024-06-12",
      "expiryDate": null,
      "cost": 320.0,
      "guestRating": 5.0,
      "description": "Crystal champagne flutes with silver tray"
    }
  ];

  List<Map<String, dynamic>> roomOptions = [
    {"label": "All Rooms", "value": "all"},
    {"label": "Room 101", "value": "101"},
    {"label": "Room 205", "value": "205"},
    {"label": "Room 312", "value": "312"},
    {"label": "Room 418", "value": "418"},
    {"label": "Room 523", "value": "523"}
  ];

  List<Map<String, dynamic>> categoryOptions = [
    {"label": "All Categories", "value": "all"},
    {"label": "Bathroom", "value": "bathroom"},
    {"label": "Beverages", "value": "beverages"},
    {"label": "Entertainment", "value": "entertainment"},
    {"label": "Comfort", "value": "comfort"},
    {"label": "Wellness", "value": "wellness"},
    {"label": "Luxury", "value": "luxury"}
  ];

  List<Map<String, dynamic>> statusOptions = [
    {"label": "All Status", "value": "all"},
    {"label": "Available", "value": "available"},
    {"label": "Maintenance", "value": "maintenance"},
    {"label": "Missing", "value": "missing"},
    {"label": "Replacement", "value": "replacement"}
  ];

  List<Map<String, dynamic>> get filteredAmenities {
    return amenities.where((amenity) {
      bool matchesRoom = selectedRoom == "all" || amenity["roomNumber"] == selectedRoom;
      bool matchesCategory = selectedCategory == "all" || amenity["category"] == selectedCategory;
      bool matchesStatus = selectedStatus == "all" || amenity["status"] == selectedStatus;
      bool matchesSearch = searchQuery.isEmpty || 
          (amenity["item"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
          (amenity["brand"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
          amenity["roomNumber"].toString().toLowerCase().contains(searchQuery.toLowerCase());
      
      return matchesRoom && matchesCategory && matchesStatus && matchesSearch;
    }).toList();
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'available':
        return successColor;
      case 'maintenance':
        return warningColor;
      case 'missing':
        return dangerColor;
      case 'replacement':
        return infoColor;
      default:
        return disabledColor;
    }
  }

  Color _getConditionColor(String condition) {
    switch (condition) {
      case 'excellent':
        return successColor;
      case 'good':
        return infoColor;
      case 'fair':
        return warningColor;
      case 'poor':
        return dangerColor;
      case 'new':
        return primaryColor;
      default:
        return disabledColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Room Amenities",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "All Amenities", icon: Icon(Icons.hotel_outlined)),
        Tab(text: "Available", icon: Icon(Icons.check_circle)),
        Tab(text: "Maintenance", icon: Icon(Icons.build)),
        Tab(text: "Missing", icon: Icon(Icons.error)),
      ],
      tabChildren: [
        _buildAllAmenitiesTab(),
        _buildAvailableTab(),
        _buildMaintenanceTab(),
        _buildMissingTab(),
      ],
    );
  }

  Widget _buildAllAmenitiesTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Search and Filter Section
          Row(
            children: [
              Expanded(
                child: QTextField(
                  label: "Search amenities, brands, or rooms...",
                  value: searchQuery,
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
          
          // Filter Options
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: [
              QDropdownField(
                label: "Room",
                items: roomOptions,
                value: selectedRoom,
                onChanged: (value, label) {
                  selectedRoom = value;
                  setState(() {});
                },
              ),
              QDropdownField(
                label: "Category",
                items: categoryOptions,
                value: selectedCategory,
                onChanged: (value, label) {
                  selectedCategory = value;
                  setState(() {});
                },
              ),
              QDropdownField(
                label: "Status",
                items: statusOptions,
                value: selectedStatus,
                onChanged: (value, label) {
                  selectedStatus = value;
                  setState(() {});
                },
              ),
            ],
          ),

          // Summary Cards
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: [
              _buildSummaryCard(
                "Total Amenities",
                "${amenities.length}",
                Icons.hotel_outlined,
                primaryColor,
              ),
              _buildSummaryCard(
                "Available",
                "${amenities.where((a) => a["status"] == "available").length}",
                Icons.check_circle,
                successColor,
              ),
              _buildSummaryCard(
                "Maintenance",
                "${amenities.where((a) => a["status"] == "maintenance").length}",
                Icons.build,
                warningColor,
              ),
              _buildSummaryCard(
                "Total Value",
                "\$${amenities.fold(0.0, (sum, item) => sum + ((item["quantity"] as int) * (item["cost"] as double))).toStringAsFixed(0)}",
                Icons.attach_money,
                infoColor,
              ),
            ],
          ),

          // Amenities List
          ...filteredAmenities.map((amenity) => _buildAmenityCard(amenity)),
        ],
      ),
    );
  }

  Widget _buildAvailableTab() {
    List<Map<String, dynamic>> availableAmenities = amenities.where((amenity) => 
        amenity["status"] == "available"
    ).toList();

    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Available Summary
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: successColor.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusMd),
              border: Border.all(color: successColor.withAlpha(60)),
            ),
            child: Row(
              children: [
                Icon(Icons.check_circle, color: successColor, size: 24),
                SizedBox(width: spSm),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Available Amenities",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: successColor,
                        ),
                      ),
                      Text(
                        "${availableAmenities.length} amenities ready for guests",
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
          ),

          // Guest Satisfaction Overview
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Guest Satisfaction",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: spSm),
                Row(
                  children: [
                    Icon(Icons.star, color: warningColor, size: 20),
                    SizedBox(width: spXs),
                    Text(
                      "${(availableAmenities.fold(0.0, (sum, item) => sum + (item["guestRating"] as double)) / availableAmenities.length).toStringAsFixed(1)}",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: warningColor,
                      ),
                    ),
                    SizedBox(width: spSm),
                    Text(
                      "Average Rating",
                      style: TextStyle(
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Available Amenities
          ...availableAmenities.map((amenity) => _buildAvailableAmenityCard(amenity)),
        ],
      ),
    );
  }

  Widget _buildMaintenanceTab() {
    List<Map<String, dynamic>> maintenanceAmenities = amenities.where((amenity) => 
        amenity["status"] == "maintenance"
    ).toList();

    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Maintenance Summary
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: warningColor.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusMd),
              border: Border.all(color: warningColor.withAlpha(60)),
            ),
            child: Row(
              children: [
                Icon(Icons.build, color: warningColor, size: 24),
                SizedBox(width: spSm),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Maintenance Required",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: warningColor,
                        ),
                      ),
                      Text(
                        "${maintenanceAmenities.length} amenities need attention",
                        style: TextStyle(
                          color: disabledBoldColor,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
                QButton(
                  label: "Schedule All",
                  size: bs.sm,
                  onPressed: () {
                    // Schedule maintenance for all items
                  },
                ),
              ],
            ),
          ),

          // Maintenance Amenities
          ...maintenanceAmenities.map((amenity) => _buildMaintenanceAmenityCard(amenity)),
        ],
      ),
    );
  }

  Widget _buildMissingTab() {
    List<Map<String, dynamic>> missingAmenities = amenities.where((amenity) => 
        amenity["status"] == "missing"
    ).toList();

    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Missing Summary
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: dangerColor.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusMd),
              border: Border.all(color: dangerColor.withAlpha(60)),
            ),
            child: Row(
              children: [
                Icon(Icons.error, color: dangerColor, size: 24),
                SizedBox(width: spSm),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Missing Amenities",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: dangerColor,
                        ),
                      ),
                      Text(
                        "${missingAmenities.length} amenities need replacement",
                        style: TextStyle(
                          color: disabledBoldColor,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
                QButton(
                  label: "Order All",
                  size: bs.sm,
                  onPressed: () {
                    // Order replacements for all missing items
                  },
                ),
              ],
            ),
          ),

          // Missing Amenities
          ...missingAmenities.map((amenity) => _buildMissingAmenityCard(amenity)),
        ],
      ),
    );
  }

  Widget _buildSummaryCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(icon, color: color, size: 24),
              Text(
                value,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Text(
            title,
            style: TextStyle(
              fontSize: 14,
              color: disabledBoldColor,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAmenityCard(Map<String, dynamic> amenity) {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          // Header
          Row(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: _getStatusColor(amenity["status"]).withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "${amenity["item"]}",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: _getStatusColor(amenity["status"]),
                  ),
                ),
              ),
              Spacer(),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: _getStatusColor(amenity["status"]).withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "${amenity["status"]}".toUpperCase(),
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    color: _getStatusColor(amenity["status"]),
                  ),
                ),
              ),
            ],
          ),

          // Room and Category Info
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Room ${amenity["roomNumber"]} • ${amenity["category"]}".toUpperCase(),
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      "${amenity["brand"]} • ${amenity["type"]}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    "\$${((amenity["cost"] as double) * (amenity["quantity"] as int)).toStringAsFixed(2)}",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Text(
                    "Qty: ${amenity["quantity"]}",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ),
            ],
          ),

          // Description
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: infoColor.withAlpha(10),
              borderRadius: BorderRadius.circular(radiusXs),
            ),
            child: Text(
              "${amenity["description"]}",
              style: TextStyle(
                fontSize: 12,
                color: disabledBoldColor,
              ),
            ),
          ),

          // Additional Information
          Row(
            children: [
              Expanded(
                child: Row(
                  children: [
                    Icon(Icons.star, color: warningColor, size: 16),
                    SizedBox(width: spXs),
                    Text(
                      "${amenity["guestRating"]}",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: warningColor,
                      ),
                    ),
                    SizedBox(width: spSm),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                      decoration: BoxDecoration(
                        color: _getConditionColor(amenity["condition"]).withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Text(
                        "${amenity["condition"]}".toUpperCase(),
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                          color: _getConditionColor(amenity["condition"]),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                "Restocked: ${amenity["lastRestocked"]}",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),

          // Expiry Date (if applicable)
          if (amenity["expiryDate"] != null)
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: warningColor.withAlpha(10),
                borderRadius: BorderRadius.circular(radiusXs),
              ),
              child: Row(
                children: [
                  Icon(Icons.calendar_today, color: warningColor, size: 16),
                  SizedBox(width: spXs),
                  Text(
                    "Expires: ${amenity["expiryDate"]}",
                    style: TextStyle(
                      fontSize: 12,
                      color: warningColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),

          // Action Buttons
          Row(
            children: [
              Expanded(
                child: QButton(
                  label: "View Details",
                  size: bs.sm,
                  onPressed: () {
                    _showAmenityDetails(amenity);
                  },
                ),
              ),
              SizedBox(width: spSm),
              QButton(
                icon: Icons.edit,
                size: bs.sm,
                onPressed: () {
                  // Edit amenity
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAvailableAmenityCard(Map<String, dynamic> amenity) {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
        border: Border.all(color: successColor.withAlpha(60)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Row(
            children: [
              Icon(Icons.check_circle, color: successColor, size: 20),
              SizedBox(width: spXs),
              Text(
                "${amenity["item"]}",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: successColor,
                ),
              ),
              Spacer(),
              Row(
                children: [
                  Icon(Icons.star, color: warningColor, size: 16),
                  SizedBox(width: spXs),
                  Text(
                    "${amenity["guestRating"]}",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: warningColor,
                    ),
                  ),
                ],
              ),
            ],
          ),

          Text(
            "Room ${amenity["roomNumber"]} • ${amenity["brand"]}",
            style: TextStyle(
              fontSize: 14,
              color: disabledBoldColor,
            ),
          ),

          Text(
            "${amenity["description"]}",
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),

          Row(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                decoration: BoxDecoration(
                  color: _getConditionColor(amenity["condition"]).withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "${amenity["condition"]}".toUpperCase(),
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    color: _getConditionColor(amenity["condition"]),
                  ),
                ),
              ),
              Spacer(),
              Text(
                "Qty: ${amenity["quantity"]}",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: primaryColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMaintenanceAmenityCard(Map<String, dynamic> amenity) {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
        border: Border.all(color: warningColor.withAlpha(60)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Row(
            children: [
              Icon(Icons.build, color: warningColor, size: 20),
              SizedBox(width: spXs),
              Text(
                "${amenity["item"]}",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: warningColor,
                ),
              ),
              Spacer(),
              Text(
                "MAINTENANCE",
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                  color: warningColor,
                ),
              ),
            ],
          ),

          Text(
            "Room ${amenity["roomNumber"]} • ${amenity["brand"]}",
            style: TextStyle(
              fontSize: 14,
              color: disabledBoldColor,
            ),
          ),

          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: warningColor.withAlpha(10),
              borderRadius: BorderRadius.circular(radiusXs),
            ),
            child: Row(
              children: [
                Icon(Icons.warning, color: warningColor, size: 16),
                SizedBox(width: spXs),
                Expanded(
                  child: Text(
                    "This amenity requires maintenance attention",
                    style: TextStyle(
                      fontSize: 12,
                      color: warningColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),

          Row(
            children: [
              Expanded(
                child: QButton(
                  label: "Schedule Maintenance",
                  size: bs.sm,
                  onPressed: () {
                    // Schedule maintenance
                  },
                ),
              ),
              SizedBox(width: spSm),
              QButton(
                icon: Icons.info,
                size: bs.sm,
                onPressed: () {
                  _showAmenityDetails(amenity);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMissingAmenityCard(Map<String, dynamic> amenity) {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
        border: Border.all(color: dangerColor.withAlpha(60)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Row(
            children: [
              Icon(Icons.error, color: dangerColor, size: 20),
              SizedBox(width: spXs),
              Text(
                "${amenity["item"]}",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: dangerColor,
                ),
              ),
              Spacer(),
              Text(
                "MISSING",
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                  color: dangerColor,
                ),
              ),
            ],
          ),

          Text(
            "Room ${amenity["roomNumber"]} • ${amenity["brand"]}",
            style: TextStyle(
              fontSize: 14,
              color: disabledBoldColor,
            ),
          ),

          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: dangerColor.withAlpha(10),
              borderRadius: BorderRadius.circular(radiusXs),
            ),
            child: Row(
              children: [
                Icon(Icons.shopping_cart, color: dangerColor, size: 16),
                SizedBox(width: spXs),
                Expanded(
                  child: Text(
                    "Replacement needed: \$${((amenity["cost"] as double) * (amenity["quantity"] as int)).toStringAsFixed(2)}",
                    style: TextStyle(
                      fontSize: 12,
                      color: dangerColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),

          Row(
            children: [
              Expanded(
                child: QButton(
                  label: "Order Replacement",
                  size: bs.sm,
                  onPressed: () {
                    // Order replacement
                  },
                ),
              ),
              SizedBox(width: spSm),
              QButton(
                icon: Icons.search,
                size: bs.sm,
                onPressed: () {
                  // Search for alternatives
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _showAmenityDetails(Map<String, dynamic> amenity) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.8,
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  "${amenity["item"]} Details",
                  style: TextStyle(
                    fontSize: fsH5,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Spacer(),
                QButton(
                  icon: Icons.close,
                  size: bs.sm,
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
            SizedBox(height: spMd),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  spacing: spSm,
                  children: [
                    _buildDetailRow("Room", "${amenity["roomNumber"]}"),
                    _buildDetailRow("Brand", "${amenity["brand"]}"),
                    _buildDetailRow("Category", "${amenity["category"]}"),
                    _buildDetailRow("Quantity", "${amenity["quantity"]}"),
                    _buildDetailRow("Status", "${amenity["status"]}"),
                    _buildDetailRow("Condition", "${amenity["condition"]}"),
                    _buildDetailRow("Cost", "\$${(amenity["cost"] as double).toStringAsFixed(2)}"),
                    _buildDetailRow("Guest Rating", "${amenity["guestRating"]}/5.0"),
                    _buildDetailRow("Last Restocked", "${amenity["lastRestocked"]}"),
                    if (amenity["expiryDate"] != null)
                      _buildDetailRow("Expires", "${amenity["expiryDate"]}"),
                    Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: infoColor.withAlpha(10),
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Description",
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "${amenity["description"]}",
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
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: disabledOutlineBorderColor),
      ),
      child: Row(
        children: [
          Text(
            label,
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),
          Spacer(),
          Text(
            value,
            style: TextStyle(
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
