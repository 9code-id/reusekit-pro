import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class ComaDeliveryTrackingView extends StatefulWidget {
  const ComaDeliveryTrackingView({super.key});

  @override
  State<ComaDeliveryTrackingView> createState() => _ComaDeliveryTrackingViewState();
}

class _ComaDeliveryTrackingViewState extends State<ComaDeliveryTrackingView> {
  String searchQuery = "";
  String selectedStatus = "All";
  String selectedPriority = "All";

  List<Map<String, dynamic>> statusOptions = [
    {"label": "All", "value": "All"},
    {"label": "Pending", "value": "Pending"},
    {"label": "Confirmed", "value": "Confirmed"},
    {"label": "In Transit", "value": "In Transit"},
    {"label": "Delivered", "value": "Delivered"},
    {"label": "Delayed", "value": "Delayed"},
    {"label": "Failed", "value": "Failed"},
  ];

  List<Map<String, dynamic>> priorityOptions = [
    {"label": "All", "value": "All"},
    {"label": "Low", "value": "Low"},
    {"label": "Medium", "value": "Medium"},
    {"label": "High", "value": "High"},
    {"label": "Urgent", "value": "Urgent"},
  ];

  List<Map<String, dynamic>> deliveries = [
    {
      "id": "DEL001",
      "trackingNumber": "TRK-2024-001",
      "orderNumber": "PO-2024-001",
      "supplier": "BuildMart Supply",
      "driver": "Robert Johnson",
      "driverPhone": "+1-555-0123",
      "vehicle": "Truck - ABC-1234",
      "status": "In Transit",
      "priority": "High",
      "scheduledDate": "2024-06-25",
      "estimatedTime": "14:30",
      "actualDeliveryDate": null,
      "deliveryAddress": "Construction Site A, 123 Main St",
      "coordinates": {"lat": 37.7749, "lng": -122.4194},
      "totalValue": 5400.00,
      "items": [
        {"name": "Portland Cement", "quantity": 200, "unit": "bags"},
        {"name": "Pine Timber", "quantity": 15, "unit": "cubic meters"}
      ],
      "progress": 65,
      "lastUpdate": "2024-06-24T10:30:00",
      "notes": "Delivery in progress, expected arrival 2:30 PM",
      "receiptRequired": true,
      "specialInstructions": "Use rear entrance for unloading",
      "image": "https://picsum.photos/120/120?random=31&keyword=truck"
    },
    {
      "id": "DEL002",
      "trackingNumber": "TRK-2024-002",
      "orderNumber": "PO-2024-002",
      "supplier": "Metal Works Ltd",
      "driver": "Michael Brown",
      "driverPhone": "+1-555-0124",
      "vehicle": "Truck - XYZ-5678",
      "status": "Delivered",
      "priority": "Medium",
      "scheduledDate": "2024-06-22",
      "estimatedTime": "09:00",
      "actualDeliveryDate": "2024-06-22T09:15:00",
      "deliveryAddress": "Warehouse B-2, 456 Industrial Ave",
      "coordinates": {"lat": 37.7849, "lng": -122.4094},
      "totalValue": 3250.00,
      "items": [
        {"name": "Steel Reinforcement Bar", "quantity": 5, "unit": "tons"}
      ],
      "progress": 100,
      "lastUpdate": "2024-06-22T09:15:00",
      "notes": "Delivery completed successfully",
      "receiptRequired": true,
      "specialInstructions": "Crane required for unloading",
      "image": "https://picsum.photos/120/120?random=32&keyword=delivery"
    },
    {
      "id": "DEL003",
      "trackingNumber": "TRK-2024-003",
      "orderNumber": "PO-2024-003",
      "supplier": "Sand & Gravel Co",
      "driver": "James Wilson",
      "driverPhone": "+1-555-0125",
      "vehicle": "Dump Truck - DEF-9012",
      "status": "Confirmed",
      "priority": "Low",
      "scheduledDate": "2024-06-26",
      "estimatedTime": "11:00",
      "actualDeliveryDate": null,
      "deliveryAddress": "Yard C-1, 789 Construction Blvd",
      "coordinates": {"lat": 37.7649, "lng": -122.4294},
      "totalValue": 750.00,
      "items": [
        {"name": "River Sand", "quantity": 30, "unit": "cubic meters"}
      ],
      "progress": 25,
      "lastUpdate": "2024-06-24T08:00:00",
      "notes": "Delivery confirmed for tomorrow morning",
      "receiptRequired": false,
      "specialInstructions": "Direct dump in designated area",
      "image": "https://picsum.photos/120/120?random=33&keyword=sand"
    },
    {
      "id": "DEL004",
      "trackingNumber": "TRK-2024-004",
      "orderNumber": "PO-2024-004",
      "supplier": "Brick Manufacturing",
      "driver": "William Davis",
      "driverPhone": "+1-555-0126",
      "vehicle": "Truck - GHI-3456",
      "status": "Delayed",
      "priority": "Urgent",
      "scheduledDate": "2024-06-21",
      "estimatedTime": "13:00",
      "actualDeliveryDate": null,
      "deliveryAddress": "Warehouse D-1, 321 Storage Way",
      "coordinates": {"lat": 37.7549, "lng": -122.4394},
      "totalValue": 1750.00,
      "items": [
        {"name": "Red Clay Bricks", "quantity": 5000, "unit": "pieces"}
      ],
      "progress": 10,
      "lastUpdate": "2024-06-21T13:30:00",
      "notes": "Delayed due to vehicle breakdown - rescheduling",
      "receiptRequired": true,
      "specialInstructions": "Quality inspection required upon delivery",
      "image": "https://picsum.photos/120/120?random=34&keyword=bricks"
    },
    {
      "id": "DEL005",
      "trackingNumber": "TRK-2024-005",
      "orderNumber": "PO-2024-005",
      "supplier": "Paint Store",
      "driver": "Thomas Anderson",
      "driverPhone": "+1-555-0127",
      "vehicle": "Van - JKL-7890",
      "status": "Pending",
      "priority": "Medium",
      "scheduledDate": "2024-06-27",
      "estimatedTime": "10:00",
      "actualDeliveryDate": null,
      "deliveryAddress": "Warehouse F-1, 654 Paint Street",
      "coordinates": {"lat": 37.7449, "lng": -122.4494},
      "totalValue": 2250.00,
      "items": [
        {"name": "Exterior Paint", "quantity": 50, "unit": "liters"}
      ],
      "progress": 0,
      "lastUpdate": "2024-06-24T16:00:00",
      "notes": "Awaiting supplier confirmation",
      "receiptRequired": true,
      "specialInstructions": "Store in temperature-controlled area",
      "image": "https://picsum.photos/120/120?random=35&keyword=paint"
    },
  ];

  List<Map<String, dynamic>> get filteredDeliveries {
    return deliveries.where((delivery) {
      bool matchesSearch = searchQuery.isEmpty ||
          (delivery["trackingNumber"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
          (delivery["orderNumber"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
          (delivery["supplier"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
          (delivery["driver"] as String).toLowerCase().contains(searchQuery.toLowerCase());

      bool matchesStatus = selectedStatus == "All" || delivery["status"] == selectedStatus;
      bool matchesPriority = selectedPriority == "All" || delivery["priority"] == selectedPriority;

      return matchesSearch && matchesStatus && matchesPriority;
    }).toList();
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "Delivered":
        return successColor;
      case "In Transit":
        return infoColor;
      case "Confirmed":
        return primaryColor;
      case "Pending":
        return warningColor;
      case "Delayed":
      case "Failed":
        return dangerColor;
      default:
        return disabledColor;
    }
  }

  Color _getPriorityColor(String priority) {
    switch (priority) {
      case "Urgent":
        return dangerColor;
      case "High":
        return warningColor;
      case "Medium":
        return infoColor;
      case "Low":
        return successColor;
      default:
        return disabledColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Delivery Tracking"),
        actions: [
          IconButton(
            icon: Icon(Icons.map),
            onPressed: () {
              //navigateTo('delivery_map')
            },
          ),
          IconButton(
            icon: Icon(Icons.filter_list),
            onPressed: () {
              _showFilterDialog();
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
            QTextField(
              label: "Search deliveries...",
              value: searchQuery,
              hint: "Enter tracking number, order, supplier, or driver",
              onChanged: (value) {
                searchQuery = value;
                setState(() {});
              },
            ),

            // Summary Cards
            Row(
              children: [
                Expanded(
                  child: _buildSummaryCard(
                    "Total Deliveries",
                    "${deliveries.length}",
                    Icons.local_shipping,
                    primaryColor,
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: _buildSummaryCard(
                    "In Transit",
                    "${deliveries.where((d) => d["status"] == "In Transit").length}",
                    Icons.directions_car,
                    infoColor,
                  ),
                ),
              ],
            ),

            Row(
              children: [
                Expanded(
                  child: _buildSummaryCard(
                    "Delivered Today",
                    "${deliveries.where((d) => d["status"] == "Delivered" && d["actualDeliveryDate"] != null && DateTime.parse(d["actualDeliveryDate"] as String).day == DateTime.now().day).length}",
                    Icons.check_circle,
                    successColor,
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: _buildSummaryCard(
                    "Delayed",
                    "${deliveries.where((d) => d["status"] == "Delayed").length}",
                    Icons.warning,
                    dangerColor,
                  ),
                ),
              ],
            ),

            // Quick Status Filters
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                spacing: spSm,
                children: [
                  _buildQuickFilter("All", selectedStatus == "All"),
                  _buildQuickFilter("In Transit", selectedStatus == "In Transit"),
                  _buildQuickFilter("Confirmed", selectedStatus == "Confirmed"),
                  _buildQuickFilter("Delivered", selectedStatus == "Delivered"),
                  _buildQuickFilter("Delayed", selectedStatus == "Delayed"),
                ],
              ),
            ),

            // Deliveries List
            Column(
              spacing: spSm,
              children: filteredDeliveries.map((delivery) {
                return _buildDeliveryCard(delivery);
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryCard(String title, String value, IconData icon, Color color) {
    return Container(
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
              Icon(
                icon,
                color: color,
                size: 20,
              ),
              SizedBox(width: spXs),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: spXs),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              value,
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickFilter(String label, bool isActive) {
    return GestureDetector(
      onTap: () {
        selectedStatus = label == "All" ? "All" : label;
        setState(() {});
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
        decoration: BoxDecoration(
          color: isActive ? primaryColor : Colors.white,
          borderRadius: BorderRadius.circular(radiusSm),
          border: Border.all(
            color: isActive ? primaryColor : disabledOutlineBorderColor,
          ),
          boxShadow: [shadowSm],
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isActive ? Colors.white : disabledBoldColor,
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  Widget _buildDeliveryCard(Map<String, dynamic> delivery) {
    Color statusColor = _getStatusColor(delivery["status"] as String);
    Color priorityColor = _getPriorityColor(delivery["priority"] as String);
    int progress = delivery["progress"] as int;

    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
        border: Border(
          left: BorderSide(
            width: 4,
            color: statusColor,
          ),
        ),
      ),
      child: Column(
        spacing: spSm,
        children: [
          // Header
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(radiusSm),
                child: Image.network(
                  "${delivery["image"]}",
                  width: 50,
                  height: 50,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${delivery["trackingNumber"]}",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "${delivery["orderNumber"]} • ${delivery["supplier"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                    decoration: BoxDecoration(
                      color: statusColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                    child: Text(
                      "${delivery["status"]}",
                      style: TextStyle(
                        fontSize: 10,
                        color: statusColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  SizedBox(height: spXs),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                    decoration: BoxDecoration(
                      color: priorityColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                    child: Text(
                      "${delivery["priority"]}",
                      style: TextStyle(
                        fontSize: 10,
                        color: priorityColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),

          // Progress Bar
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    "Progress",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
                  Spacer(),
                  Text(
                    "$progress%",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: primaryColor,
                    ),
                  ),
                ],
              ),
              SizedBox(height: spXs),
              Container(
                height: 6,
                decoration: BoxDecoration(
                  color: disabledColor.withAlpha(30),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: FractionallySizedBox(
                  alignment: Alignment.centerLeft,
                  widthFactor: progress / 100,
                  child: Container(
                    decoration: BoxDecoration(
                      color: statusColor,
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                  ),
                ),
              ),
            ],
          ),

          // Delivery Details
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Scheduled",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "${DateTime.parse(delivery["scheduledDate"] as String).dMMMy}",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "${delivery["estimatedTime"]}",
                      style: TextStyle(
                        fontSize: 10,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      "Total Value",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "\$${(delivery["totalValue"] as double).currency}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: successColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          // Driver & Vehicle Info
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(5),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Column(
              spacing: spXs,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.person,
                      size: 16,
                      color: disabledBoldColor,
                    ),
                    SizedBox(width: spXs),
                    Expanded(
                      child: Text(
                        "${delivery["driver"]}",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: primaryColor,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        //callPhone(delivery["driverPhone"])
                      },
                      child: Icon(
                        Icons.phone,
                        size: 16,
                        color: successColor,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Icon(
                      Icons.local_shipping,
                      size: 16,
                      color: disabledBoldColor,
                    ),
                    SizedBox(width: spXs),
                    Text(
                      "${delivery["vehicle"]}",
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

          // Delivery Address
          Row(
            children: [
              Icon(
                Icons.location_on,
                size: 16,
                color: disabledBoldColor,
              ),
              SizedBox(width: spXs),
              Expanded(
                child: Text(
                  "${delivery["deliveryAddress"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ),
            ],
          ),

          // Items Summary
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: infoColor.withAlpha(10),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Items (${(delivery["items"] as List).length})",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spXs),
                ...(delivery["items"] as List).take(2).map((item) {
                  return Padding(
                    padding: EdgeInsets.only(bottom: spXs),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            "${item["name"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                        ),
                        Text(
                          "${item["quantity"]} ${item["unit"]}",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
                if ((delivery["items"] as List).length > 2)
                  Text(
                    "... and ${(delivery["items"] as List).length - 2} more items",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
              ],
            ),
          ),

          // Notes
          if (delivery["notes"] != null && (delivery["notes"] as String).isNotEmpty)
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: warningColor.withAlpha(10),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Text(
                "${delivery["notes"]}",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),

          // Special Instructions
          if (delivery["specialInstructions"] != null && (delivery["specialInstructions"] as String).isNotEmpty)
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: dangerColor.withAlpha(10),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.info,
                    size: 16,
                    color: dangerColor,
                  ),
                  SizedBox(width: spXs),
                  Expanded(
                    child: Text(
                      "${delivery["specialInstructions"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: dangerColor,
                        fontWeight: FontWeight.w600,
                      ),
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
                  label: "Track on Map",
                  size: bs.sm,
                  onPressed: () {
                    //navigateTo('track_on_map')
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QButton(
                  label: "Contact Driver",
                  size: bs.sm,
                  onPressed: () {
                    //callPhone(delivery["driverPhone"])
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _showFilterDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Filter Deliveries"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            spacing: spSm,
            children: [
              QDropdownField(
                label: "Status",
                items: statusOptions,
                value: selectedStatus,
                onChanged: (value, label) {
                  selectedStatus = value;
                  setState(() {});
                },
              ),
              QDropdownField(
                label: "Priority",
                items: priorityOptions,
                value: selectedPriority,
                onChanged: (value, label) {
                  selectedPriority = value;
                  setState(() {});
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                selectedStatus = "All";
                selectedPriority = "All";
                setState(() {});
                Navigator.pop(context);
              },
              child: Text("Clear"),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("Apply"),
            ),
          ],
        );
      },
    );
  }
}
