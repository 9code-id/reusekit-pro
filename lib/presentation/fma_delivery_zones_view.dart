import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class FmaDeliveryZonesView extends StatefulWidget {
  const FmaDeliveryZonesView({super.key});

  @override
  State<FmaDeliveryZonesView> createState() => _FmaDeliveryZonesViewState();
}

class _FmaDeliveryZonesViewState extends State<FmaDeliveryZonesView> {
  List<Map<String, dynamic>> zones = [
    {
      "id": "ZONE001",
      "name": "Downtown Core",
      "description": "Central business district and downtown area",
      "status": "Active",
      "color": "#FF5722",
      "radius": 5.0,
      "center_lat": 37.7749,
      "center_lng": -122.4194,
      "delivery_fee": 3.99,
      "min_order": 15.00,
      "max_distance": 5.0,
      "estimated_time": "20-30 min",
      "active_drivers": 8,
      "total_orders": 142,
      "avg_rating": 4.8,
      "boundaries": [
        {"lat": 37.7849, "lng": -122.4294},
        {"lat": 37.7649, "lng": -122.4094},
        {"lat": 37.7749, "lng": -122.4094},
        {"lat": 37.7849, "lng": -122.4194},
      ],
    },
    {
      "id": "ZONE002",
      "name": "Mall District",
      "description": "Shopping centers and retail areas",
      "status": "Active",
      "color": "#4CAF50",
      "radius": 7.5,
      "center_lat": 37.7849,
      "center_lng": -122.4094,
      "delivery_fee": 4.99,
      "min_order": 20.00,
      "max_distance": 7.5,
      "estimated_time": "25-35 min",
      "active_drivers": 6,
      "total_orders": 98,
      "avg_rating": 4.6,
      "boundaries": [
        {"lat": 37.7949, "lng": -122.4194},
        {"lat": 37.7749, "lng": -122.3994},
        {"lat": 37.7849, "lng": -122.3994},
        {"lat": 37.7949, "lng": -122.4094},
      ],
    },
    {
      "id": "ZONE003",
      "name": "Business Center",
      "description": "Office buildings and corporate areas",
      "status": "Active",
      "color": "#2196F3",
      "radius": 6.0,
      "center_lat": 37.7949,
      "center_lng": -122.3994,
      "delivery_fee": 5.99,
      "min_order": 25.00,
      "max_distance": 6.0,
      "estimated_time": "30-40 min",
      "active_drivers": 4,
      "total_orders": 76,
      "avg_rating": 4.7,
      "boundaries": [
        {"lat": 37.8049, "lng": -122.4094},
        {"lat": 37.7849, "lng": -122.3894},
        {"lat": 37.7949, "lng": -122.3894},
        {"lat": 37.8049, "lng": -122.3994},
      ],
    },
    {
      "id": "ZONE004",
      "name": "Residential North",
      "description": "Northern residential neighborhoods",
      "status": "Inactive",
      "color": "#9E9E9E",
      "radius": 8.0,
      "center_lat": 37.8049,
      "center_lng": -122.3894,
      "delivery_fee": 6.99,
      "min_order": 30.00,
      "max_distance": 8.0,
      "estimated_time": "35-45 min",
      "active_drivers": 0,
      "total_orders": 23,
      "avg_rating": 4.2,
      "boundaries": [
        {"lat": 37.8149, "lng": -122.3994},
        {"lat": 37.7949, "lng": -122.3794},
        {"lat": 37.8049, "lng": -122.3794},
        {"lat": 37.8149, "lng": -122.3894},
      ],
    },
  ];

  String selectedStatus = "All Status";
  String searchQuery = "";

  List<Map<String, dynamic>> statusItems = [
    {"label": "All Status", "value": "All Status"},
    {"label": "Active", "value": "Active"},
    {"label": "Inactive", "value": "Inactive"},
  ];

  // Form fields for adding/editing zones
  String zoneName = "";
  String zoneDescription = "";
  double deliveryFee = 0.0;
  double minOrder = 0.0;
  double maxDistance = 0.0;
  String estimatedTime = "";
  String selectedColor = "#FF5722";

  List<Map<String, dynamic>> colorOptions = [
    {"label": "Red", "value": "#FF5722"},
    {"label": "Green", "value": "#4CAF50"},
    {"label": "Blue", "value": "#2196F3"},
    {"label": "Orange", "value": "#FF9800"},
    {"label": "Purple", "value": "#9C27B0"},
    {"label": "Teal", "value": "#009688"},
  ];

  Color _getStatusColor(String status) {
    switch (status) {
      case "Active":
        return successColor;
      case "Inactive":
        return disabledBoldColor;
      default:
        return disabledBoldColor;
    }
  }

  Color _parseColor(String colorHex) {
    return Color(int.parse(colorHex.substring(1), radix: 16) + 0xFF000000);
  }

  List<Map<String, dynamic>> get filteredZones {
    return zones.where((zone) {
      bool matchesStatus = selectedStatus == "All Status" || zone["status"] == selectedStatus;
      bool matchesSearch = searchQuery.isEmpty || 
          (zone["name"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
          (zone["id"] as String).toLowerCase().contains(searchQuery.toLowerCase());
      
      return matchesStatus && matchesSearch;
    }).toList();
  }

  void _showAddZoneDialog() {
    // Reset form
    zoneName = "";
    zoneDescription = "";
    deliveryFee = 0.0;
    minOrder = 0.0;
    maxDistance = 0.0;
    estimatedTime = "";
    selectedColor = "#FF5722";

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Add New Zone"),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              QTextField(
                label: "Zone Name",
                value: zoneName,
                hint: "Enter zone name",
                onChanged: (value) {
                  zoneName = value;
                  setState(() {});
                },
              ),
              SizedBox(height: spSm),
              QTextField(
                label: "Description",
                value: zoneDescription,
                hint: "Enter zone description",
                onChanged: (value) {
                  zoneDescription = value;
                  setState(() {});
                },
              ),
              SizedBox(height: spSm),
              Row(
                children: [
                  Expanded(
                    child: QNumberField(
                      label: "Delivery Fee (\$)",
                      value: deliveryFee.toString(),
                      onChanged: (value) {
                        deliveryFee = double.tryParse(value) ?? 0.0;
                        setState(() {});
                      },
                    ),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: QNumberField(
                      label: "Min Order (\$)",
                      value: minOrder.toString(),
                      onChanged: (value) {
                        minOrder = double.tryParse(value) ?? 0.0;
                        setState(() {});
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: spSm),
              Row(
                children: [
                  Expanded(
                    child: QNumberField(
                      label: "Max Distance (km)",
                      value: maxDistance.toString(),
                      onChanged: (value) {
                        maxDistance = double.tryParse(value) ?? 0.0;
                        setState(() {});
                      },
                    ),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: QTextField(
                      label: "Estimated Time",
                      value: estimatedTime,
                      hint: "e.g., 20-30 min",
                      onChanged: (value) {
                        estimatedTime = value;
                        setState(() {});
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: spSm),
              QDropdownField(
                label: "Zone Color",
                items: colorOptions,
                value: selectedColor,
                onChanged: (value, label) {
                  selectedColor = value;
                  setState(() {});
                },
              ),
            ],
          ),
        ),
        actions: [
          QButton(
            label: "Cancel",
            size: bs.sm,
            onPressed: () => Navigator.pop(context),
          ),
          QButton(
            label: "Add Zone",
            size: bs.sm,
            onPressed: () {
              Navigator.pop(context);
              _addZone();
            },
          ),
        ],
      ),
    );
  }

  void _addZone() {
    ss("New delivery zone added successfully");
  }

  void _editZone(Map<String, dynamic> zone) {
    zoneName = zone["name"];
    zoneDescription = zone["description"];
    deliveryFee = zone["delivery_fee"];
    minOrder = zone["min_order"];
    maxDistance = zone["max_distance"];
    estimatedTime = zone["estimated_time"];
    selectedColor = zone["color"];

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Edit Zone"),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              QTextField(
                label: "Zone Name",
                value: zoneName,
                onChanged: (value) {
                  zoneName = value;
                  setState(() {});
                },
              ),
              SizedBox(height: spSm),
              QTextField(
                label: "Description",
                value: zoneDescription,
                onChanged: (value) {
                  zoneDescription = value;
                  setState(() {});
                },
              ),
              SizedBox(height: spSm),
              Row(
                children: [
                  Expanded(
                    child: QNumberField(
                      label: "Delivery Fee (\$)",
                      value: deliveryFee.toString(),
                      onChanged: (value) {
                        deliveryFee = double.tryParse(value) ?? 0.0;
                        setState(() {});
                      },
                    ),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: QNumberField(
                      label: "Min Order (\$)",
                      value: minOrder.toString(),
                      onChanged: (value) {
                        minOrder = double.tryParse(value) ?? 0.0;
                        setState(() {});
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: spSm),
              Row(
                children: [
                  Expanded(
                    child: QNumberField(
                      label: "Max Distance (km)",
                      value: maxDistance.toString(),
                      onChanged: (value) {
                        maxDistance = double.tryParse(value) ?? 0.0;
                        setState(() {});
                      },
                    ),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: QTextField(
                      label: "Estimated Time",
                      value: estimatedTime,
                      onChanged: (value) {
                        estimatedTime = value;
                        setState(() {});
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        actions: [
          QButton(
            label: "Cancel",
            size: bs.sm,
            onPressed: () => Navigator.pop(context),
          ),
          QButton(
            label: "Update",
            size: bs.sm,
            onPressed: () {
              Navigator.pop(context);
              ss("Zone updated successfully");
            },
          ),
        ],
      ),
    );
  }

  void _toggleZoneStatus(Map<String, dynamic> zone) {
    String newStatus = zone["status"] == "Active" ? "Inactive" : "Active";
    ss("Zone ${zone["name"]} is now ${newStatus}");
  }

  void _deleteZone(Map<String, dynamic> zone) async {
    bool isConfirmed = await confirm("Are you sure you want to delete ${zone["name"]}?");
    if (isConfirmed) {
      ss("Zone ${zone["name"]} deleted successfully");
    }
  }

  void _viewZoneDetails(Map<String, dynamic> zone) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.7,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(radiusLg)),
        ),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: disabledOutlineBorderColor),
                ),
              ),
              child: Row(
                children: [
                  Container(
                    width: 24,
                    height: 24,
                    decoration: BoxDecoration(
                      color: _parseColor("${zone["color"]}"),
                      shape: BoxShape.circle,
                    ),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Text(
                      "${zone["name"]}",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.close),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(spMd),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Zone Info
                    Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: _parseColor("${zone["color"]}").withAlpha(10),
                        borderRadius: BorderRadius.circular(radiusMd),
                        border: Border.all(
                          color: _parseColor("${zone["color"]}").withAlpha(30),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  "${zone["description"]}",
                                  style: TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                decoration: BoxDecoration(
                                  color: _getStatusColor("${zone["status"]}"),
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: Text(
                                  "${zone["status"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: spSm),
                          Text(
                            "Zone ID: ${zone["id"]}",
                            style: TextStyle(
                              color: disabledBoldColor,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: spMd),

                    // Zone Statistics
                    Text(
                      "Zone Statistics",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: spSm),
                    ResponsiveGridView(
                      padding: EdgeInsets.zero,
                      minItemWidth: 200,
                      children: [
                        Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(radiusMd),
                            boxShadow: [shadowSm],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Icon(Icons.person, color: primaryColor, size: 20),
                                  SizedBox(width: spXs),
                                  Text(
                                    "Active Drivers",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: spXs),
                              Text(
                                "${zone["active_drivers"]}",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(radiusMd),
                            boxShadow: [shadowSm],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Icon(Icons.shopping_bag, color: successColor, size: 20),
                                  SizedBox(width: spXs),
                                  Text(
                                    "Total Orders",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: spXs),
                              Text(
                                "${zone["total_orders"]}",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: successColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(radiusMd),
                            boxShadow: [shadowSm],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Icon(Icons.star, color: warningColor, size: 20),
                                  SizedBox(width: spXs),
                                  Text(
                                    "Avg Rating",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: spXs),
                              Text(
                                "${zone["avg_rating"]}",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: warningColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: spMd),

                    // Zone Configuration
                    Text(
                      "Zone Configuration",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: spSm),
                    Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(radiusMd),
                        boxShadow: [shadowSm],
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Text("Delivery Fee:"),
                              Spacer(),
                              Text(
                                "\$${(zone["delivery_fee"] as double).currency}",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: spXs),
                          Row(
                            children: [
                              Text("Minimum Order:"),
                              Spacer(),
                              Text(
                                "\$${(zone["min_order"] as double).currency}",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: spXs),
                          Row(
                            children: [
                              Text("Max Distance:"),
                              Spacer(),
                              Text(
                                "${zone["max_distance"]} km",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: spXs),
                          Row(
                            children: [
                              Text("Estimated Time:"),
                              Spacer(),
                              Text(
                                "${zone["estimated_time"]}",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: spMd),

                    // Action Buttons
                    Row(
                      children: [
                        Expanded(
                          child: QButton(
                            label: "Edit Zone",
                            icon: Icons.edit,
                            size: bs.md,
                            onPressed: () {
                              Navigator.pop(context);
                              _editZone(zone);
                            },
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: QButton(
                            label: zone["status"] == "Active" ? "Deactivate" : "Activate",
                            icon: zone["status"] == "Active" ? Icons.pause : Icons.play_arrow,
                            size: bs.md,
                            onPressed: () {
                              Navigator.pop(context);
                              _toggleZoneStatus(zone);
                            },
                          ),
                        ),
                      ],
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Delivery Zones"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: _showAddZoneDialog,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Summary Cards
            ResponsiveGridView(
              padding: EdgeInsets.zero,
              minItemWidth: 200,
              children: [
                Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.location_on,
                            color: primaryColor,
                            size: 24,
                          ),
                          SizedBox(width: spXs),
                          Text(
                            "Total Zones",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "${zones.length}",
                        style: TextStyle(
                          fontSize: fsH4,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.check_circle,
                            color: successColor,
                            size: 24,
                          ),
                          SizedBox(width: spXs),
                          Text(
                            "Active Zones",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "${zones.where((z) => z["status"] == "Active").length}",
                        style: TextStyle(
                          fontSize: fsH4,
                          fontWeight: FontWeight.bold,
                          color: successColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.local_shipping,
                            color: infoColor,
                            size: 24,
                          ),
                          SizedBox(width: spXs),
                          Text(
                            "Total Drivers",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "${zones.fold(0, (sum, zone) => sum + (zone["active_drivers"] as int))}",
                        style: TextStyle(
                          fontSize: fsH4,
                          fontWeight: FontWeight.bold,
                          color: infoColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.shopping_bag,
                            color: warningColor,
                            size: 24,
                          ),
                          SizedBox(width: spXs),
                          Text(
                            "Total Orders",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "${zones.fold(0, (sum, zone) => sum + (zone["total_orders"] as int))}",
                        style: TextStyle(
                          fontSize: fsH4,
                          fontWeight: FontWeight.bold,
                          color: warningColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            SizedBox(height: spLg),

            // Filters
            Row(
              children: [
                Expanded(
                  child: QTextField(
                    label: "Search Zones",
                    value: searchQuery,
                    hint: "Search by name or ID",
                    onChanged: (value) {
                      searchQuery = value;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QDropdownField(
                    label: "Status",
                    items: statusItems,
                    value: selectedStatus,
                    onChanged: (value, label) {
                      selectedStatus = value;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),

            SizedBox(height: spLg),

            // Zones List
            Text(
              "Delivery Zones (${filteredZones.length})",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: spSm),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                children: List.generate(filteredZones.length, (index) {
                  final zone = filteredZones[index];
                  return Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      border: Border(
                        left: BorderSide(
                          width: 4,
                          color: _parseColor("${zone["color"]}"),
                        ),
                        bottom: BorderSide(
                          color: index < filteredZones.length - 1 ? disabledOutlineBorderColor : Colors.transparent,
                          width: 1,
                        ),
                      ),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: _parseColor("${zone["color"]}").withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Icon(
                            Icons.location_on,
                            color: _parseColor("${zone["color"]}"),
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
                                    "${zone["name"]}",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                  SizedBox(width: spXs),
                                  Container(
                                    padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                    decoration: BoxDecoration(
                                      color: _getStatusColor("${zone["status"]}").withAlpha(20),
                                      borderRadius: BorderRadius.circular(radiusXs),
                                    ),
                                    child: Text(
                                      "${zone["status"]}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: _getStatusColor("${zone["status"]}"),
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: spXs),
                              Text(
                                "${zone["description"]}",
                                style: TextStyle(
                                  color: disabledBoldColor,
                                  fontSize: 12,
                                ),
                              ),
                              SizedBox(height: spXs),
                              Row(
                                children: [
                                  Text(
                                    "\$${(zone["delivery_fee"] as double).currency}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      color: primaryColor,
                                    ),
                                  ),
                                  SizedBox(width: spSm),
                                  Text(
                                    "${zone["max_distance"]} km",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                  SizedBox(width: spSm),
                                  Text(
                                    "${zone["active_drivers"]} drivers",
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
                        SizedBox(width: spSm),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            QButton(
                              icon: Icons.info,
                              size: bs.sm,
                              onPressed: () => _viewZoneDetails(zone),
                            ),
                            SizedBox(width: spXs),
                            QButton(
                              icon: Icons.edit,
                              size: bs.sm,
                              onPressed: () => _editZone(zone),
                            ),
                            SizedBox(width: spXs),
                            QButton(
                              icon: Icons.delete,
                              size: bs.sm,
                              onPressed: () => _deleteZone(zone),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
