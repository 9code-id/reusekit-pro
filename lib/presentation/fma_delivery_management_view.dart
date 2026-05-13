import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class FmaDeliveryManagementView extends StatefulWidget {
  const FmaDeliveryManagementView({super.key});

  @override
  State<FmaDeliveryManagementView> createState() => _FmaDeliveryManagementViewState();
}

class _FmaDeliveryManagementViewState extends State<FmaDeliveryManagementView> {
  List<Map<String, dynamic>> deliveries = [
    {
      "id": "DEL001",
      "orderNumber": "ORD-2024-156",
      "customer": "John Smith",
      "address": "123 Main St, New York, NY 10001",
      "driver": "Mike Johnson",
      "status": "In Transit",
      "priority": "High",
      "estimatedTime": "2024-06-15T16:30:00",
      "actualTime": null,
      "distance": 8.5,
      "deliveryFee": 12.50,
      "items": 3,
      "totalValue": 156.75,
      "contactNumber": "+1 555-0123",
    },
    {
      "id": "DEL002",
      "orderNumber": "ORD-2024-157",
      "customer": "Sarah Wilson",
      "address": "456 Oak Avenue, Brooklyn, NY 11201",
      "driver": "David Lee",
      "status": "Delivered",
      "priority": "Normal",
      "estimatedTime": "2024-06-15T14:00:00",
      "actualTime": "2024-06-15T13:45:00",
      "distance": 12.3,
      "deliveryFee": 15.00,
      "items": 2,
      "totalValue": 89.99,
      "contactNumber": "+1 555-0456",
    },
    {
      "id": "DEL003",
      "orderNumber": "ORD-2024-158",
      "customer": "Robert Brown",
      "address": "789 Pine Street, Queens, NY 11375",
      "driver": "Carlos Rodriguez",
      "status": "Pending",
      "priority": "Low",
      "estimatedTime": "2024-06-15T18:00:00",
      "actualTime": null,
      "distance": 15.7,
      "deliveryFee": 18.00,
      "items": 5,
      "totalValue": 245.30,
      "contactNumber": "+1 555-0789",
    },
    {
      "id": "DEL004",
      "orderNumber": "ORD-2024-159",
      "customer": "Emily Davis",
      "address": "321 Elm Drive, Manhattan, NY 10016",
      "driver": "Alex Chen",
      "status": "Failed",
      "priority": "High",
      "estimatedTime": "2024-06-15T12:00:00",
      "actualTime": null,
      "distance": 6.2,
      "deliveryFee": 10.00,
      "items": 1,
      "totalValue": 67.50,
      "contactNumber": "+1 555-0321",
    },
    {
      "id": "DEL005",
      "orderNumber": "ORD-2024-160",
      "customer": "Michael Thompson",
      "address": "654 Cedar Lane, Bronx, NY 10451",
      "driver": "Jessica Martinez",
      "status": "Assigned",
      "priority": "Normal",
      "estimatedTime": "2024-06-15T17:15:00",
      "actualTime": null,
      "distance": 11.8,
      "deliveryFee": 14.50,
      "items": 4,
      "totalValue": 198.75,
      "contactNumber": "+1 555-0654",
    },
  ];

  List<Map<String, dynamic>> drivers = [
    {
      "id": "DR001",
      "name": "Mike Johnson",
      "status": "Active",
      "currentDeliveries": 2,
      "completedToday": 8,
      "rating": 4.8,
      "vehicle": "Honda Civic",
      "location": "Manhattan",
    },
    {
      "id": "DR002",
      "name": "David Lee",
      "status": "Active",
      "currentDeliveries": 1,
      "completedToday": 12,
      "rating": 4.9,
      "vehicle": "Toyota Camry",
      "location": "Brooklyn",
    },
    {
      "id": "DR003",
      "name": "Carlos Rodriguez",
      "status": "Break",
      "currentDeliveries": 0,
      "completedToday": 6,
      "rating": 4.7,
      "vehicle": "Ford Focus",
      "location": "Queens",
    },
    {
      "id": "DR004",
      "name": "Alex Chen",
      "status": "Active",
      "currentDeliveries": 3,
      "completedToday": 9,
      "rating": 4.6,
      "vehicle": "Nissan Sentra",
      "location": "Manhattan",
    },
  ];

  String selectedStatus = "All";
  String selectedPriority = "All";
  String selectedDriver = "All";

  List<Map<String, dynamic>> statusOptions = [
    {"label": "All Status", "value": "All"},
    {"label": "Pending", "value": "Pending"},
    {"label": "Assigned", "value": "Assigned"},
    {"label": "In Transit", "value": "In Transit"},
    {"label": "Delivered", "value": "Delivered"},
    {"label": "Failed", "value": "Failed"},
  ];

  List<Map<String, dynamic>> priorityOptions = [
    {"label": "All Priority", "value": "All"},
    {"label": "High", "value": "High"},
    {"label": "Normal", "value": "Normal"},
    {"label": "Low", "value": "Low"},
  ];

  @override
  Widget build(BuildContext context) {
    int totalDeliveries = deliveries.length;
    int activeDeliveries = deliveries.where((d) => d["status"] == "In Transit" || d["status"] == "Assigned").length;
    int completedToday = deliveries.where((d) => d["status"] == "Delivered").length;
    int failedDeliveries = deliveries.where((d) => d["status"] == "Failed").length;

    return Scaffold(
      appBar: AppBar(
        title: Text("Delivery Management"),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              ss("Delivery data refreshed");
            },
          ),
          IconButton(
            icon: Icon(Icons.map),
            onPressed: () {
              ss("Opening delivery map view");
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            // Filters
            Column(
              spacing: spMd,
              children: [
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
                    SizedBox(width: spMd),
                    Expanded(
                      child: QDropdownField(
                        label: "Priority",
                        items: priorityOptions,
                        value: selectedPriority,
                        onChanged: (value, label) {
                          selectedPriority = value;
                          setState(() {});
                        },
                      ),
                    ),
                  ],
                ),
                QDropdownField(
                  label: "Driver",
                  items: [
                    {"label": "All Drivers", "value": "All"},
                    ...drivers.map((driver) => {"label": driver["name"], "value": driver["name"]}).toList(),
                  ],
                  value: selectedDriver,
                  onChanged: (value, label) {
                    selectedDriver = value;
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
                  "Total Deliveries",
                  "$totalDeliveries",
                  Icons.local_shipping,
                  primaryColor,
                ),
                _buildSummaryCard(
                  "Active",
                  "$activeDeliveries",
                  Icons.directions_run,
                  warningColor,
                ),
                _buildSummaryCard(
                  "Completed Today",
                  "$completedToday",
                  Icons.check_circle,
                  successColor,
                ),
                _buildSummaryCard(
                  "Failed",
                  "$failedDeliveries",
                  Icons.error,
                  failedDeliveries > 0 ? dangerColor : successColor,
                ),
              ],
            ),

            // Active Drivers Status
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spMd,
                children: [
                  Row(
                    children: [
                      Icon(Icons.people, color: primaryColor),
                      SizedBox(width: spSm),
                      Text(
                        "Driver Status",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Spacer(),
                      QButton(
                        label: "Manage Drivers",
                        size: bs.sm,
                        onPressed: () {},
                      ),
                    ],
                  ),
                  QHorizontalScroll(
                    children: drivers.map((driver) {
                      Color statusColor = driver["status"] == "Active"
                          ? successColor
                          : driver["status"] == "Break"
                              ? warningColor
                              : disabledBoldColor;

                      return Container(
                        width: 220,
                        padding: EdgeInsets.all(spMd),
                        decoration: BoxDecoration(
                          border: Border.all(color: disabledOutlineBorderColor),
                          borderRadius: BorderRadius.circular(radiusMd),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: spSm,
                          children: [
                            Row(
                              children: [
                                Container(
                                  padding: EdgeInsets.all(spSm),
                                  decoration: BoxDecoration(
                                    color: statusColor.withAlpha(20),
                                    borderRadius: BorderRadius.circular(radiusMd),
                                  ),
                                  child: Icon(Icons.person, color: statusColor, size: 20),
                                ),
                                SizedBox(width: spSm),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "${driver["name"]}",
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: primaryColor,
                                        ),
                                      ),
                                      Text(
                                        "${driver["vehicle"]}",
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
                            Row(
                              children: [
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                                  decoration: BoxDecoration(
                                    color: statusColor.withAlpha(20),
                                    borderRadius: BorderRadius.circular(radiusSm),
                                  ),
                                  child: Text(
                                    "${driver["status"]}",
                                    style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w600,
                                      color: statusColor,
                                    ),
                                  ),
                                ),
                                Spacer(),
                                Row(
                                  children: [
                                    Icon(Icons.star, color: warningColor, size: 12),
                                    SizedBox(width: spXs),
                                    Text(
                                      "${(driver["rating"] as double).toStringAsFixed(1)}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                        color: primaryColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Divider(color: disabledOutlineBorderColor),
                            Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Current",
                                        style: TextStyle(
                                          fontSize: 10,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                      Text(
                                        "${driver["currentDeliveries"]}",
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: primaryColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Completed",
                                        style: TextStyle(
                                          fontSize: 10,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                      Text(
                                        "${driver["completedToday"]}",
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: successColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),

            // Delivery List
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spMd,
                children: [
                  Row(
                    children: [
                      Icon(Icons.list_alt, color: primaryColor),
                      SizedBox(width: spSm),
                      Text(
                        "Delivery Orders",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Spacer(),
                      QButton(
                        label: "New Delivery",
                        size: bs.sm,
                        onPressed: () {},
                      ),
                    ],
                  ),
                  Column(
                    spacing: spSm,
                    children: deliveries.map((delivery) {
                      Color statusColor = delivery["status"] == "Delivered"
                          ? successColor
                          : delivery["status"] == "In Transit"
                              ? infoColor
                              : delivery["status"] == "Failed"
                                  ? dangerColor
                                  : delivery["status"] == "Assigned"
                                      ? warningColor
                                      : disabledBoldColor;

                      Color priorityColor = delivery["priority"] == "High"
                          ? dangerColor
                          : delivery["priority"] == "Normal"
                              ? warningColor
                              : successColor;

                      return Container(
                        padding: EdgeInsets.all(spMd),
                        decoration: BoxDecoration(
                          border: Border.all(color: disabledOutlineBorderColor),
                          borderRadius: BorderRadius.circular(radiusMd),
                        ),
                        child: Column(
                          spacing: spSm,
                          children: [
                            Row(
                              children: [
                                Container(
                                  padding: EdgeInsets.all(spSm),
                                  decoration: BoxDecoration(
                                    color: statusColor.withAlpha(20),
                                    borderRadius: BorderRadius.circular(radiusMd),
                                  ),
                                  child: Icon(
                                    delivery["status"] == "Delivered"
                                        ? Icons.check_circle
                                        : delivery["status"] == "In Transit"
                                            ? Icons.local_shipping
                                            : delivery["status"] == "Failed"
                                                ? Icons.error
                                                : Icons.schedule,
                                    color: statusColor,
                                    size: 16,
                                  ),
                                ),
                                SizedBox(width: spMd),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            "${delivery["orderNumber"]}",
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              color: primaryColor,
                                            ),
                                          ),
                                          SizedBox(width: spSm),
                                          Container(
                                            padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                                            decoration: BoxDecoration(
                                              color: priorityColor.withAlpha(20),
                                              borderRadius: BorderRadius.circular(radiusSm),
                                            ),
                                            child: Text(
                                              "${delivery["priority"]}",
                                              style: TextStyle(
                                                fontSize: 10,
                                                fontWeight: FontWeight.w600,
                                                color: priorityColor,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: spXs),
                                      Text(
                                        "${delivery["customer"]}",
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          color: primaryColor,
                                        ),
                                      ),
                                      SizedBox(height: spXs),
                                      Text(
                                        "${delivery["address"]}",
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
                                      padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                                      decoration: BoxDecoration(
                                        color: statusColor.withAlpha(20),
                                        borderRadius: BorderRadius.circular(radiusSm),
                                      ),
                                      child: Text(
                                        "${delivery["status"]}",
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600,
                                          color: statusColor,
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: spSm),
                                    Text(
                                      "\$${(delivery["totalValue"] as double).currency}",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: primaryColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Divider(color: disabledOutlineBorderColor),
                            Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Driver",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                      Text(
                                        "${delivery["driver"]}",
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          color: primaryColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Distance",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                      Text(
                                        "${(delivery["distance"] as double).toStringAsFixed(1)} km",
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          color: primaryColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Items",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                      Text(
                                        "${delivery["items"]}",
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          color: primaryColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Fee",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                      Text(
                                        "\$${(delivery["deliveryFee"] as double).toStringAsFixed(2)}",
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          color: successColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    "ETA: ${DateTime.parse(delivery["estimatedTime"]).dMMMy} ${DateTime.parse(delivery["estimatedTime"]).hour}:${DateTime.parse(delivery["estimatedTime"]).minute.toString().padLeft(2, '0')}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                ),
                                Row(
                                  children: [
                                    QButton(
                                      label: "Track",
                                      size: bs.sm,
                                      onPressed: () {},
                                    ),
                                    SizedBox(width: spSm),
                                    QButton(
                                      label: "Contact",
                                      size: bs.sm,
                                      onPressed: () {},
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: color.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusMd),
                ),
                child: Icon(icon, color: color, size: 24),
              ),
              Spacer(),
              Icon(Icons.trending_up, color: successColor, size: 16),
            ],
          ),
          SizedBox(height: spMd),
          Text(
            title,
            style: TextStyle(
              fontSize: 14,
              color: disabledBoldColor,
            ),
          ),
          SizedBox(height: spXs),
          Text(
            value,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
        ],
      ),
    );
  }
}
