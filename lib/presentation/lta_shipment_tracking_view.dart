import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class LtaShipmentTrackingView extends StatefulWidget {
  const LtaShipmentTrackingView({super.key});

  @override
  State<LtaShipmentTrackingView> createState() => _LtaShipmentTrackingViewState();
}

class _LtaShipmentTrackingViewState extends State<LtaShipmentTrackingView> {
  bool loading = true;
  String searchQuery = "";
  String selectedStatus = "All Statuses";
  String selectedTimeframe = "Last 7 Days";
  String sortBy = "Latest";

  List<Map<String, dynamic>> statusOptions = [
    {"label": "All Statuses", "value": "All Statuses"},
    {"label": "In Transit", "value": "in_transit"},
    {"label": "Delivered", "value": "delivered"},
    {"label": "Pending", "value": "pending"},
    {"label": "Delayed", "value": "delayed"},
    {"label": "Failed", "value": "failed"},
  ];

  List<Map<String, dynamic>> timeframeOptions = [
    {"label": "Last 7 Days", "value": "7_days"},
    {"label": "Last 30 Days", "value": "30_days"},
    {"label": "Last 3 Months", "value": "3_months"},
    {"label": "This Year", "value": "year"},
    {"label": "All Time", "value": "all"},
  ];

  List<Map<String, dynamic>> sortOptions = [
    {"label": "Latest", "value": "Latest"},
    {"label": "Oldest", "value": "Oldest"},
    {"label": "Status", "value": "Status"},
    {"label": "Priority", "value": "Priority"},
  ];

  List<Map<String, dynamic>> shipments = [
    {
      "id": "SH-001234",
      "trackingNumber": "LTA1234567890",
      "customerName": "Acme Corporation",
      "customerPhone": "+1-555-0123",
      "origin": "San Francisco Warehouse",
      "destination": "Los Angeles Office",
      "status": "in_transit",
      "priority": "high",
      "weight": 25.5,
      "dimensions": "50x40x30 cm",
      "value": 1500.00,
      "createdAt": "2024-03-15T09:00:00Z",
      "estimatedDelivery": "2024-03-16T17:00:00Z",
      "lastUpdate": "2024-03-15T14:30:00Z",
      "currentLocation": "Fresno Distribution Center",
      "driver": "John Smith",
      "vehicle": "Truck TR-001",
      "milestones": [
        {
          "status": "picked_up",
          "location": "San Francisco Warehouse",
          "timestamp": "2024-03-15T09:00:00Z",
          "description": "Package picked up from warehouse",
        },
        {
          "status": "in_transit",
          "location": "Fresno Distribution Center",
          "timestamp": "2024-03-15T14:30:00Z",
          "description": "In transit to destination",
        },
      ],
    },
    {
      "id": "SH-001235",
      "trackingNumber": "LTA1234567891",
      "customerName": "Tech Solutions Inc",
      "customerPhone": "+1-555-0124",
      "origin": "Oakland Depot",
      "destination": "Sacramento Office",
      "status": "delivered",
      "priority": "medium",
      "weight": 12.8,
      "dimensions": "30x25x20 cm",
      "value": 800.00,
      "createdAt": "2024-03-14T10:30:00Z",
      "estimatedDelivery": "2024-03-15T16:00:00Z",
      "lastUpdate": "2024-03-15T15:45:00Z",
      "currentLocation": "Sacramento Office",
      "driver": "Maria Garcia",
      "vehicle": "Van VN-002",
      "milestones": [
        {
          "status": "picked_up",
          "location": "Oakland Depot",
          "timestamp": "2024-03-14T10:30:00Z",
          "description": "Package collected from depot",
        },
        {
          "status": "in_transit",
          "location": "Stockton Hub",
          "timestamp": "2024-03-15T09:15:00Z",
          "description": "Arrived at distribution hub",
        },
        {
          "status": "out_for_delivery",
          "location": "Sacramento Zone",
          "timestamp": "2024-03-15T13:00:00Z",
          "description": "Out for delivery",
        },
        {
          "status": "delivered",
          "location": "Sacramento Office",
          "timestamp": "2024-03-15T15:45:00Z",
          "description": "Successfully delivered to recipient",
        },
      ],
    },
    {
      "id": "SH-001236",
      "trackingNumber": "LTA1234567892",
      "customerName": "Global Manufacturing",
      "customerPhone": "+1-555-0125",
      "origin": "San Jose Center",
      "destination": "Modesto Plant",
      "status": "delayed",
      "priority": "urgent",
      "weight": 45.2,
      "dimensions": "80x60x40 cm",
      "value": 3200.00,
      "createdAt": "2024-03-14T08:00:00Z",
      "estimatedDelivery": "2024-03-15T12:00:00Z",
      "lastUpdate": "2024-03-15T16:20:00Z",
      "currentLocation": "Merced Stop",
      "driver": "David Johnson",
      "vehicle": "Cargo CG-004",
      "milestones": [
        {
          "status": "picked_up",
          "location": "San Jose Center",
          "timestamp": "2024-03-14T08:00:00Z",
          "description": "Urgent shipment collected",
        },
        {
          "status": "in_transit",
          "location": "Turlock Junction",
          "timestamp": "2024-03-15T11:30:00Z",
          "description": "En route to destination",
        },
        {
          "status": "delayed",
          "location": "Merced Stop",
          "timestamp": "2024-03-15T16:20:00Z",
          "description": "Delayed due to vehicle maintenance",
        },
      ],
    },
    {
      "id": "SH-001237",
      "trackingNumber": "LTA1234567893",
      "customerName": "Retail Chain Co",
      "customerPhone": "+1-555-0126",
      "origin": "Hayward Distribution",
      "destination": "Bakersfield Store",
      "status": "pending",
      "priority": "low",
      "weight": 8.3,
      "dimensions": "25x20x15 cm",
      "value": 250.00,
      "createdAt": "2024-03-15T16:45:00Z",
      "estimatedDelivery": "2024-03-17T14:00:00Z",
      "lastUpdate": "2024-03-15T16:45:00Z",
      "currentLocation": "Hayward Distribution",
      "driver": null,
      "vehicle": null,
      "milestones": [
        {
          "status": "pending",
          "location": "Hayward Distribution",
          "timestamp": "2024-03-15T16:45:00Z",
          "description": "Awaiting pickup assignment",
        },
      ],
    },
    {
      "id": "SH-001238",
      "trackingNumber": "LTA1234567894",
      "customerName": "Medical Supplies Ltd",
      "customerPhone": "+1-555-0127",
      "origin": "Richmond Facility",
      "destination": "Fresno Hospital",
      "status": "failed",
      "priority": "urgent",
      "weight": 15.7,
      "dimensions": "40x30x25 cm",
      "value": 2100.00,
      "createdAt": "2024-03-13T14:20:00Z",
      "estimatedDelivery": "2024-03-14T10:00:00Z",
      "lastUpdate": "2024-03-14T11:30:00Z",
      "currentLocation": "Fresno Hospital",
      "driver": "Sarah Wilson",
      "vehicle": "Pickup PK-003",
      "milestones": [
        {
          "status": "picked_up",
          "location": "Richmond Facility",
          "timestamp": "2024-03-13T14:20:00Z",
          "description": "Medical supplies collected",
        },
        {
          "status": "in_transit",
          "location": "Modesto Hub",
          "timestamp": "2024-03-14T08:45:00Z",
          "description": "Transferred to delivery vehicle",
        },
        {
          "status": "out_for_delivery",
          "location": "Fresno Zone",
          "timestamp": "2024-03-14T10:30:00Z",
          "description": "Out for delivery",
        },
        {
          "status": "failed",
          "location": "Fresno Hospital",
          "timestamp": "2024-03-14T11:30:00Z",
          "description": "Delivery failed - recipient unavailable",
        },
      ],
    },
  ];

  @override
  void initState() {
    super.initState();
    _loadShipments();
  }

  void _loadShipments() async {
    await Future.delayed(Duration(seconds: 1));
    loading = false;
    setState(() {});
  }

  List<Map<String, dynamic>> get filteredAndSortedShipments {
    List<Map<String, dynamic>> filtered = shipments.where((shipment) {
      bool matchesSearch = searchQuery.isEmpty ||
          "${shipment["trackingNumber"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
          "${shipment["customerName"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
          "${shipment["origin"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
          "${shipment["destination"]}".toLowerCase().contains(searchQuery.toLowerCase());
      
      bool matchesStatus = selectedStatus == "All Statuses" || 
          shipment["status"] == selectedStatus;
      
      return matchesSearch && matchesStatus;
    }).toList();

    // Sort the filtered results
    switch (sortBy) {
      case "Latest":
        filtered.sort((a, b) => 
            DateTime.parse("${b["lastUpdate"]}").compareTo(DateTime.parse("${a["lastUpdate"]}")));
        break;
      case "Oldest":
        filtered.sort((a, b) => 
            DateTime.parse("${a["lastUpdate"]}").compareTo(DateTime.parse("${b["lastUpdate"]}")));
        break;
      case "Status":
        filtered.sort((a, b) => "${a["status"]}".compareTo("${b["status"]}"));
        break;
      case "Priority":
        Map<String, int> priorityOrder = {"urgent": 0, "high": 1, "medium": 2, "low": 3};
        filtered.sort((a, b) => 
            (priorityOrder["${a["priority"]}"] ?? 4).compareTo(priorityOrder["${b["priority"]}"] ?? 4));
        break;
    }

    return filtered;
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "delivered":
        return successColor;
      case "in_transit":
        return infoColor;
      case "pending":
        return warningColor;
      case "delayed":
        return warningColor;
      case "failed":
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  IconData _getStatusIcon(String status) {
    switch (status) {
      case "delivered":
        return Icons.check_circle;
      case "in_transit":
        return Icons.local_shipping;
      case "pending":
        return Icons.schedule;
      case "delayed":
        return Icons.warning;
      case "failed":
        return Icons.error;
      default:
        return Icons.help_outline;
    }
  }

  Color _getPriorityColor(String priority) {
    switch (priority) {
      case "urgent":
        return dangerColor;
      case "high":
        return warningColor;
      case "medium":
        return infoColor;
      case "low":
        return successColor;
      default:
        return disabledBoldColor;
    }
  }

  String _formatDateTime(String dateString) {
    DateTime date = DateTime.parse(dateString);
    return "${date.day}/${date.month}/${date.year} ${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}";
  }

  String _getTimeAgo(String dateString) {
    DateTime date = DateTime.parse(dateString);
    DateTime now = DateTime.now();
    Duration difference = now.difference(date);

    if (difference.inMinutes < 1) {
      return "Just now";
    } else if (difference.inMinutes < 60) {
      return "${difference.inMinutes}m ago";
    } else if (difference.inHours < 24) {
      return "${difference.inHours}h ago";
    } else {
      return "${difference.inDays}d ago";
    }
  }

  void _viewShipmentDetails(Map<String, dynamic> shipment) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        child: Container(
          width: 500,
          padding: EdgeInsets.all(spMd),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      "Shipment Details",
                      style: TextStyle(
                        fontSize: fsH5,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.close),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ],
              ),
              SizedBox(height: spMd),
              
              // Tracking Information
              Text(
                "Tracking Information",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              SizedBox(height: spSm),
              
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.grey.withValues(alpha: 0.05),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Tracking Number: ${shipment["trackingNumber"]}", style: TextStyle(fontWeight: FontWeight.w600)),
                    Text("Customer: ${shipment["customerName"]}"),
                    Text("Phone: ${shipment["customerPhone"]}"),
                    Text("From: ${shipment["origin"]}"),
                    Text("To: ${shipment["destination"]}"),
                    Text("Weight: ${shipment["weight"]} kg"),
                    Text("Dimensions: ${shipment["dimensions"]}"),
                    Text("Value: \$${(shipment["value"] as double).currency}"),
                  ],
                ),
              ),
              SizedBox(height: spMd),
              
              // Timeline
              Text(
                "Delivery Timeline",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              SizedBox(height: spSm),
              
              Container(
                height: 200,
                child: SingleChildScrollView(
                  child: Column(
                    children: (shipment["milestones"] as List).map<Widget>((milestone) {
                      return Container(
                        margin: EdgeInsets.only(bottom: spSm),
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(radiusSm),
                          border: Border.all(
                            color: Colors.grey.withValues(alpha: 0.3),
                            width: 1,
                          ),
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 8,
                              height: 8,
                              decoration: BoxDecoration(
                                color: _getStatusColor("${milestone["status"]}"),
                                borderRadius: BorderRadius.circular(radiusLg),
                              ),
                            ),
                            SizedBox(width: spSm),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${milestone["description"]}",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: primaryColor,
                                    ),
                                  ),
                                  Text(
                                    "${milestone["location"]} • ${_formatDateTime("${milestone["timestamp"]}")}",
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
                      );
                    }).toList(),
                  ),
                ),
              ),
              SizedBox(height: spMd),
              
              // Action Buttons
              Row(
                children: [
                  Expanded(
                    child: QButton(
                      label: "Contact Customer",
                      size: bs.sm,
                      onPressed: () {
                        Navigator.of(context).pop();
                        // Contact customer
                      },
                    ),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: QButton(
                      label: "Update Status",
                      size: bs.sm,
                      onPressed: () {
                        Navigator.of(context).pop();
                        // Update shipment status
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return Scaffold(
        appBar: AppBar(
          title: Text("Shipment Tracking"),
        ),
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    List<Map<String, dynamic>> displayShipments = filteredAndSortedShipments;

    return Scaffold(
      appBar: AppBar(
        title: Text("Shipment Tracking"),
        actions: [
          IconButton(
            icon: Icon(Icons.qr_code_scanner),
            onPressed: () {
              // Open barcode scanner
            },
          ),
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              // Add new shipment
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            // Status Summary
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                children: [
                  Text(
                    "Shipment Overview",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spSm),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: infoColor.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Column(
                            children: [
                              Text(
                                "${shipments.where((s) => s["status"] == "in_transit").length}",
                                style: TextStyle(
                                  fontSize: fsH4,
                                  fontWeight: FontWeight.bold,
                                  color: infoColor,
                                ),
                              ),
                              Text(
                                "In Transit",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: infoColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(width: spXs),
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: successColor.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Column(
                            children: [
                              Text(
                                "${shipments.where((s) => s["status"] == "delivered").length}",
                                style: TextStyle(
                                  fontSize: fsH4,
                                  fontWeight: FontWeight.bold,
                                  color: successColor,
                                ),
                              ),
                              Text(
                                "Delivered",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: successColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(width: spXs),
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: warningColor.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Column(
                            children: [
                              Text(
                                "${shipments.where((s) => s["status"] == "pending" || s["status"] == "delayed").length}",
                                style: TextStyle(
                                  fontSize: fsH4,
                                  fontWeight: FontWeight.bold,
                                  color: warningColor,
                                ),
                              ),
                              Text(
                                "Pending",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: warningColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(width: spXs),
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: dangerColor.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Column(
                            children: [
                              Text(
                                "${shipments.where((s) => s["status"] == "failed").length}",
                                style: TextStyle(
                                  fontSize: fsH4,
                                  fontWeight: FontWeight.bold,
                                  color: dangerColor,
                                ),
                              ),
                              Text(
                                "Failed",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: dangerColor,
                                  fontWeight: FontWeight.w600,
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
            ),

            // Search and Filters
            QTextField(
              label: "Search shipments...",
              value: searchQuery,
              hint: "Search by tracking number, customer, or location",
              onChanged: (value) {
                searchQuery = value;
                setState(() {});
              },
            ),

            Row(
              children: [
                Expanded(
                  child: QDropdownField(
                    label: "Status",
                    items: statusOptions,
                    value: selectedStatus,
                    onChanged: (value, label) {
                      selectedStatus = value;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QDropdownField(
                    label: "Timeframe",
                    items: timeframeOptions,
                    value: selectedTimeframe,
                    onChanged: (value, label) {
                      selectedTimeframe = value;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QDropdownField(
                    label: "Sort by",
                    items: sortOptions,
                    value: sortBy,
                    onChanged: (value, label) {
                      sortBy = value;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),

            // Results Summary
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.grey.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Text(
                "${displayShipments.length} shipments found",
                style: TextStyle(
                  fontSize: 14,
                  color: disabledBoldColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),

            // Shipments List
            if (displayShipments.isEmpty)
              Container(
                padding: EdgeInsets.all(spLg),
                child: Column(
                  children: [
                    Icon(
                      Icons.local_shipping,
                      size: 64,
                      color: disabledColor,
                    ),
                    SizedBox(height: spMd),
                    Text(
                      "No shipments found",
                      style: TextStyle(
                        fontSize: fsH5,
                        fontWeight: FontWeight.bold,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "Try adjusting your filters or create a new shipment",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              )
            else
              Column(
                children: displayShipments.map((shipment) {
                  String status = "${shipment["status"]}";
                  String priority = "${shipment["priority"]}";
                  
                  return Container(
                    margin: EdgeInsets.only(bottom: spSm),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusMd),
                      boxShadow: [shadowSm],
                      border: Border(
                        left: BorderSide(
                          color: _getPriorityColor(priority),
                          width: 4,
                        ),
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(spSm),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Header
                          Row(
                            children: [
                              Container(
                                padding: EdgeInsets.all(spXs),
                                decoration: BoxDecoration(
                                  color: _getStatusColor(status).withValues(alpha: 0.1),
                                  borderRadius: BorderRadius.circular(radiusSm),
                                ),
                                child: Icon(
                                  _getStatusIcon(status),
                                  size: 16,
                                  color: _getStatusColor(status),
                                ),
                              ),
                              SizedBox(width: spSm),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "${shipment["trackingNumber"]}",
                                      style: TextStyle(
                                        fontSize: fsH6,
                                        fontWeight: FontWeight.bold,
                                        color: primaryColor,
                                      ),
                                    ),
                                    Text(
                                      "${shipment["customerName"]}",
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: spXs,
                                  vertical: 2,
                                ),
                                decoration: BoxDecoration(
                                  color: _getStatusColor(status).withValues(alpha: 0.1),
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: Text(
                                  status.toUpperCase().replaceAll("_", " "),
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: _getStatusColor(status),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              SizedBox(width: spXs),
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: spXs,
                                  vertical: 2,
                                ),
                                decoration: BoxDecoration(
                                  color: _getPriorityColor(priority).withValues(alpha: 0.1),
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: Text(
                                  priority.toUpperCase(),
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: _getPriorityColor(priority),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: spSm),

                          // Route Information
                          Row(
                            children: [
                              Icon(
                                Icons.location_on,
                                size: 14,
                                color: successColor,
                              ),
                              SizedBox(width: 4),
                              Expanded(
                                child: Text(
                                  "${shipment["origin"]}",
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: successColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              Icon(
                                Icons.arrow_forward,
                                size: 14,
                                color: disabledBoldColor,
                              ),
                              SizedBox(width: 4),
                              Icon(
                                Icons.flag,
                                size: 14,
                                color: dangerColor,
                              ),
                              SizedBox(width: 4),
                              Expanded(
                                child: Text(
                                  "${shipment["destination"]}",
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: dangerColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: spXs),

                          // Current Location
                          Row(
                            children: [
                              Icon(
                                Icons.my_location,
                                size: 14,
                                color: primaryColor,
                              ),
                              SizedBox(width: 4),
                              Expanded(
                                child: Text(
                                  "Current: ${shipment["currentLocation"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: primaryColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              Text(
                                _getTimeAgo("${shipment["lastUpdate"]}"),
                                style: TextStyle(
                                  fontSize: 11,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),

                          // Shipment Details
                          SizedBox(height: spSm),
                          Row(
                            children: [
                              Expanded(
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.scale,
                                      size: 12,
                                      color: disabledBoldColor,
                                    ),
                                    SizedBox(width: 2),
                                    Text(
                                      "${shipment["weight"]} kg",
                                      style: TextStyle(
                                        fontSize: 11,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.attach_money,
                                      size: 12,
                                      color: disabledBoldColor,
                                    ),
                                    SizedBox(width: 2),
                                    Text(
                                      "\$${(shipment["value"] as double).currency}",
                                      style: TextStyle(
                                        fontSize: 11,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              if (shipment["driver"] != null)
                                Expanded(
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.person,
                                        size: 12,
                                        color: disabledBoldColor,
                                      ),
                                      SizedBox(width: 2),
                                      Text(
                                        "${shipment["driver"]}",
                                        style: TextStyle(
                                          fontSize: 11,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                            ],
                          ),

                          SizedBox(height: spSm),
                          // Action Buttons
                          Row(
                            children: [
                              Expanded(
                                child: QButton(
                                  label: "View Details",
                                  size: bs.sm,
                                  onPressed: () => _viewShipmentDetails(shipment),
                                ),
                              ),
                              SizedBox(width: spXs),
                              QButton(
                                icon: Icons.phone,
                                size: bs.sm,
                                onPressed: () {
                                  // Call customer
                                },
                              ),
                              SizedBox(width: spXs),
                              QButton(
                                icon: Icons.edit,
                                size: bs.sm,
                                onPressed: () {
                                  // Edit shipment
                                },
                              ),
                              SizedBox(width: spXs),
                              QButton(
                                icon: Icons.share,
                                size: bs.sm,
                                onPressed: () {
                                  // Share tracking info
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
          ],
        ),
      ),
    );
  }
}
