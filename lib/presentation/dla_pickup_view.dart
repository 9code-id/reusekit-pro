import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class DlaPickupView extends StatefulWidget {
  const DlaPickupView({super.key});

  @override
  State<DlaPickupView> createState() => _DlaPickupViewState();
}

class _DlaPickupViewState extends State<DlaPickupView> {
  String selectedStatusFilter = "All";
  bool isPickupMode = true;
  
  List<Map<String, dynamic>> statusFilters = [
    {"label": "All", "count": 15},
    {"label": "Pending", "count": 8},
    {"label": "Confirmed", "count": 4},
    {"label": "In Progress", "count": 2},
    {"label": "Completed", "count": 1},
  ];

  List<Map<String, dynamic>> pickupRequests = [
    {
      "id": "PU001",
      "customerName": "Alice Johnson",
      "address": "123 Main Street, Downtown",
      "phoneNumber": "+1 234 567 8901",
      "packageType": "Electronics",
      "weight": "2.5 kg",
      "dimensions": "30x20x15 cm",
      "pickupTime": "2:00 PM - 4:00 PM",
      "status": "Confirmed",
      "priority": "High",
      "specialInstructions": "Handle with care - fragile items",
      "estimatedValue": "\$350",
      "createdAt": "2 hours ago"
    },
    {
      "id": "PU002", 
      "customerName": "Bob Wilson",
      "address": "456 Oak Avenue, Uptown",
      "phoneNumber": "+1 234 567 8902",
      "packageType": "Documents",
      "weight": "0.5 kg",
      "dimensions": "35x25x5 cm",
      "pickupTime": "10:00 AM - 12:00 PM",
      "status": "In Progress",
      "priority": "Medium",
      "specialInstructions": "Ring doorbell twice",
      "estimatedValue": "\$25",
      "createdAt": "4 hours ago"
    },
    {
      "id": "PU003",
      "customerName": "Carol Davis",
      "address": "789 Pine Road, Westside",
      "phoneNumber": "+1 234 567 8903",
      "packageType": "Clothing",
      "weight": "1.8 kg",
      "dimensions": "40x30x10 cm",
      "pickupTime": "3:00 PM - 5:00 PM",
      "status": "Pending",
      "priority": "Low",
      "specialInstructions": "Leave with neighbor if not home",
      "estimatedValue": "\$120",
      "createdAt": "1 day ago"
    },
    {
      "id": "PU004",
      "customerName": "David Brown", 
      "address": "321 Elm Street, Eastside",
      "phoneNumber": "+1 234 567 8904",
      "packageType": "Medical Supplies",
      "weight": "3.2 kg",
      "dimensions": "25x25x20 cm",
      "pickupTime": "9:00 AM - 11:00 AM",
      "status": "Completed",
      "priority": "High",
      "specialInstructions": "Temperature controlled - keep cool",
      "estimatedValue": "\$180",
      "createdAt": "2 days ago"
    },
    {
      "id": "PU005",
      "customerName": "Emma White",
      "address": "654 Maple Drive, Southside",
      "phoneNumber": "+1 234 567 8905",
      "packageType": "Books",
      "weight": "4.1 kg",
      "dimensions": "50x30x25 cm",
      "pickupTime": "1:00 PM - 3:00 PM",
      "status": "Pending",
      "priority": "Medium",
      "specialInstructions": "Use side entrance",
      "estimatedValue": "\$85",
      "createdAt": "3 hours ago"
    },
  ];

  Map<String, dynamic> pickupStats = {
    "totalRequests": 15,
    "pendingPickups": 8,
    "completedToday": 3,
    "averageTime": "25 min"
  };

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> filteredRequests = selectedStatusFilter == "All" 
        ? pickupRequests 
        : pickupRequests.where((request) => 
            request["status"] == selectedStatusFilter).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text("Pickup Requests"),
        actions: [
          IconButton(
            icon: Icon(Icons.qr_code_scanner),
            onPressed: () {
              ss("QR code scanner opened");
            },
          ),
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              ss("Create new pickup request");
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildPickupMode(),
            SizedBox(height: spMd),
            _buildPickupStats(),
            SizedBox(height: spMd),
            _buildStatusFilters(),
            SizedBox(height: spMd),
            _buildPickupRequests(filteredRequests),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: primaryColor,
        onPressed: () {
          ss("Quick pickup scan");
        },
        child: Icon(Icons.qr_code_scanner, color: Colors.white),
      ),
    );
  }

  Widget _buildPickupMode() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: isPickupMode ? infoColor.withAlpha(20) : warningColor.withAlpha(20),
        borderRadius: BorderRadius.circular(radiusMd),
        border: Border.all(
          color: isPickupMode ? infoColor.withAlpha(50) : warningColor.withAlpha(50),
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: isPickupMode ? infoColor : warningColor,
              shape: BoxShape.circle,
            ),
            child: Icon(
              isPickupMode ? Icons.inventory : Icons.local_shipping,
              color: Colors.white,
              size: 24,
            ),
          ),
          SizedBox(width: spMd),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  isPickupMode ? "Pickup Mode Active" : "Delivery Mode Active",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: isPickupMode ? infoColor : warningColor,
                  ),
                ),
                Text(
                  isPickupMode 
                      ? "Collecting packages from customers"
                      : "Delivering packages to customers",
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
          Switch(
            value: isPickupMode,
            onChanged: (value) {
              isPickupMode = value;
              setState(() {});
              ss(value ? "Switched to pickup mode" : "Switched to delivery mode");
            },
          ),
        ],
      ),
    );
  }

  Widget _buildPickupStats() {
    return Row(
      children: [
        Expanded(
          child: Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              children: [
                Icon(Icons.inventory, color: primaryColor, size: 32),
                SizedBox(height: spSm),
                Text(
                  "${pickupStats["totalRequests"]}",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "Total Requests",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(width: spSm),
        Expanded(
          child: Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              children: [
                Icon(Icons.pending, color: warningColor, size: 32),
                SizedBox(height: spSm),
                Text(
                  "${pickupStats["pendingPickups"]}",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "Pending",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(width: spSm),
        Expanded(
          child: Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              children: [
                Icon(Icons.check_circle, color: successColor, size: 32),
                SizedBox(height: spSm),
                Text(
                  "${pickupStats["completedToday"]}",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "Completed",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildStatusFilters() {
    return QCategoryPicker(
      items: statusFilters.map((filter) => {
        "label": "${filter["label"]} (${filter["count"]})",
        "value": filter["label"],
      }).toList(),
      value: selectedStatusFilter,
      onChanged: (index, label, value, item) {
        selectedStatusFilter = value;
        setState(() {});
      },
    );
  }

  Widget _buildPickupRequests(List<Map<String, dynamic>> requests) {
    return Column(
      children: List.generate(requests.length, (index) {
        final request = requests[index];
        return Container(
          margin: EdgeInsets.only(bottom: spMd),
          child: _buildPickupCard(request),
        );
      }),
    );
  }

  Widget _buildPickupCard(Map<String, dynamic> request) {
    Color statusColor = request["status"] == "Completed" ? successColor :
                       request["status"] == "In Progress" ? infoColor :
                       request["status"] == "Confirmed" ? warningColor :
                       request["status"] == "Pending" ? Colors.grey : dangerColor;

    Color priorityColor = request["priority"] == "High" ? dangerColor :
                         request["priority"] == "Medium" ? warningColor :
                         successColor;

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
            children: [
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: statusColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Icon(
                  request["status"] == "Completed" ? Icons.check_circle :
                  request["status"] == "In Progress" ? Icons.local_shipping :
                  request["status"] == "Confirmed" ? Icons.schedule :
                  Icons.inventory,
                  color: statusColor,
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
                          "${request["id"]}",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: primaryColor,
                          ),
                        ),
                        SizedBox(width: spSm),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                          decoration: BoxDecoration(
                            color: priorityColor,
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            "${request["priority"]}",
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Spacer(),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                          decoration: BoxDecoration(
                            color: statusColor,
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            "${request["status"]}",
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "${request["customerName"]}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: spMd),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(Icons.location_on, color: dangerColor, size: 20),
              SizedBox(width: spSm),
              Expanded(
                child: Text(
                  "${request["address"]}",
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  ss("Navigation to ${request["address"]}");
                },
                child: Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: infoColor.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Icon(Icons.directions, color: infoColor, size: 16),
                ),
              ),
            ],
          ),
          SizedBox(height: spMd),
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.grey.withAlpha(30),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Package Type",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          Text(
                            "${request["packageType"]}",
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
                            "Weight",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          Text(
                            "${request["weight"]}",
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
                            "Value",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          Text(
                            "${request["estimatedValue"]}",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: primaryColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spSm),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Pickup Time",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          Text(
                            "${request["pickupTime"]}",
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
                            "Dimensions",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          Text(
                            "${request["dimensions"]}",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: primaryColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          if (request["specialInstructions"].isNotEmpty) ...[
            SizedBox(height: spMd),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: warningColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusSm),
                border: Border.all(color: warningColor.withAlpha(50)),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.info, color: warningColor, size: 16),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Special Instructions",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: warningColor,
                          ),
                        ),
                        Text(
                          "${request["specialInstructions"]}",
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
          ],
          SizedBox(height: spMd),
          Row(
            children: [
              Text(
                "Created ${request["createdAt"]}",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
              Spacer(),
              GestureDetector(
                onTap: () {
                  ss("Calling ${request["customerName"]}");
                },
                child: Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: successColor.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Icon(Icons.phone, color: successColor, size: 16),
                ),
              ),
              SizedBox(width: spSm),
              if (request["status"] == "Pending")
                QButton(
                  label: "Confirm",
                  size: bs.sm,
                  onPressed: () {
                    request["status"] = "Confirmed";
                    setState(() {});
                    ss("Pickup confirmed for ${request["id"]}");
                  },
                )
              else if (request["status"] == "Confirmed")
                QButton(
                  label: "Start Pickup",
                  size: bs.sm,
                  onPressed: () {
                    request["status"] = "In Progress";
                    setState(() {});
                    ss("Pickup started for ${request["id"]}");
                  },
                )
              else if (request["status"] == "In Progress")
                QButton(
                  label: "Complete",
                  size: bs.sm,
                  onPressed: () {
                    request["status"] = "Completed";
                    setState(() {});
                    ss("Pickup completed for ${request["id"]}");
                  },
                ),
            ],
          ),
        ],
      ),
    );
  }
}
