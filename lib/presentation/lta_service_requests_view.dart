import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class LtaServiceRequestsView extends StatefulWidget {
  const LtaServiceRequestsView({super.key});

  @override
  State<LtaServiceRequestsView> createState() => _LtaServiceRequestsViewState();
}

class _LtaServiceRequestsViewState extends State<LtaServiceRequestsView> {
  String searchQuery = "";
  String selectedStatus = "All";
  String selectedPriority = "All";
  
  List<Map<String, dynamic>> statusOptions = [
    {"label": "All", "value": "All"},
    {"label": "Open", "value": "Open"},
    {"label": "In Progress", "value": "In Progress"},
    {"label": "Pending Review", "value": "Pending Review"},
    {"label": "Resolved", "value": "Resolved"},
    {"label": "Closed", "value": "Closed"}
  ];

  List<Map<String, dynamic>> priorityOptions = [
    {"label": "All", "value": "All"},
    {"label": "Low", "value": "Low"},
    {"label": "Medium", "value": "Medium"},
    {"label": "High", "value": "High"},
    {"label": "Critical", "value": "Critical"}
  ];

  List<Map<String, dynamic>> serviceRequests = [
    {
      "requestId": "SR001",
      "customerName": "PT Maju Sejahtera",
      "contactPerson": "Ahmad Hidayat",
      "phone": "+62 812-1111-2222",
      "email": "ahmad@majusejahtera.com",
      "serviceType": "Vehicle Maintenance",
      "title": "Truck Engine Overheating Issue",
      "description": "Our delivery truck B 1234 ABC is experiencing engine overheating. Need immediate inspection and repair.",
      "priority": "High",
      "status": "In Progress",
      "createdDate": "2024-12-15 09:30",
      "lastUpdated": "2024-12-15 14:20",
      "assignedTo": "Budi Santoso",
      "estimatedCompletion": "2024-12-16 10:00",
      "vehicleNumber": "B 1234 ABC",
      "location": "Workshop Jakarta Selatan",
      "cost": 1250000.0,
      "notes": [
        {"time": "09:30", "note": "Request submitted by customer"},
        {"time": "10:15", "note": "Assigned to technician Budi Santoso"},
        {"time": "14:20", "note": "Initial diagnosis completed - coolant system issue"}
      ]
    },
    {
      "requestId": "SR002",
      "customerName": "CV Berkah Mandiri",
      "contactPerson": "Siti Nurhaliza",
      "phone": "+62 813-3333-4444",
      "email": "siti@berkahmandiri.com",
      "serviceType": "Emergency Repair",
      "title": "Van Brake System Failure",
      "description": "Delivery van experiencing complete brake failure during operation. Vehicle currently stranded.",
      "priority": "Critical",
      "status": "Open",
      "createdDate": "2024-12-15 16:45",
      "lastUpdated": "2024-12-15 16:45",
      "assignedTo": null,
      "estimatedCompletion": null,
      "vehicleNumber": "B 5678 XYZ",
      "location": "Jl. Sudirman Km 15, Jakarta",
      "cost": null,
      "notes": [
        {"time": "16:45", "note": "Emergency request received - brake failure reported"}
      ]
    },
    {
      "requestId": "SR003",
      "customerName": "Toko Elektronik Jaya",
      "contactPerson": "Muhammad Rizki",
      "phone": "+62 814-5555-6666",
      "email": "rizki@elektronikjaya.com",
      "serviceType": "Scheduled Maintenance",
      "title": "Monthly Vehicle Inspection",
      "description": "Regular monthly maintenance and safety inspection for fleet vehicles.",
      "priority": "Medium",
      "status": "Resolved",
      "createdDate": "2024-12-14 08:00",
      "lastUpdated": "2024-12-15 15:30",
      "assignedTo": "Eko Prasetyo",
      "estimatedCompletion": "2024-12-15 12:00",
      "vehicleNumber": "Multiple Vehicles",
      "location": "Customer Site - Bekasi",
      "cost": 850000.0,
      "notes": [
        {"time": "08:00", "note": "Scheduled maintenance request received"},
        {"time": "09:30", "note": "Assigned to senior technician Eko Prasetyo"},
        {"time": "15:30", "note": "All vehicles inspected and certified. Service completed."}
      ]
    },
    {
      "requestId": "SR004",
      "customerName": "PT Global Logistics",
      "contactPerson": "Diana Putri",
      "phone": "+62 815-7777-8888",
      "email": "diana@globallogistics.com",
      "serviceType": "GPS Installation",
      "title": "Fleet GPS Tracker Installation",
      "description": "Installation of GPS tracking devices on 5 new trucks for fleet management.",
      "priority": "Low",
      "status": "Pending Review",
      "createdDate": "2024-12-13 14:20",
      "lastUpdated": "2024-12-15 11:10",
      "assignedTo": "Agus Wijaya",
      "estimatedCompletion": "2024-12-17 09:00",
      "vehicleNumber": "B 9999 AAA, B 8888 BBB, B 7777 CCC",
      "location": "Workshop Jakarta Utara",
      "cost": 3750000.0,
      "notes": [
        {"time": "14:20", "note": "GPS installation request submitted"},
        {"time": "15:00", "note": "Assigned to electronics specialist Agus Wijaya"},
        {"time": "11:10", "note": "Installation completed, pending customer review"}
      ]
    },
    {
      "requestId": "SR005",
      "customerName": "Sinar Harapan Transport",
      "contactPerson": "Bambang Sutrisno",
      "phone": "+62 816-9999-0000",
      "email": "bambang@sinarharapan.com",
      "serviceType": "Tire Replacement",
      "title": "Truck Tire Replacement",
      "description": "Need replacement of 4 truck tires due to excessive wear and tear.",
      "priority": "Medium",
      "status": "Closed",
      "createdDate": "2024-12-12 10:15",
      "lastUpdated": "2024-12-14 16:00",
      "assignedTo": "Indra Kusuma",
      "estimatedCompletion": "2024-12-13 14:00",
      "vehicleNumber": "B 2222 DEF",
      "location": "Tire Service Center - Tangerang",
      "cost": 2800000.0,
      "notes": [
        {"time": "10:15", "note": "Tire replacement request received"},
        {"time": "11:00", "note": "Assigned to tire specialist Indra Kusuma"},
        {"time": "16:00", "note": "All tires replaced successfully. Service closed."}
      ]
    }
  ];

  List<Map<String, dynamic>> get filteredRequests {
    return serviceRequests.where((request) {
      bool matchesSearch = searchQuery.isEmpty || 
          (request["requestId"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
          (request["customerName"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
          (request["title"] as String).toLowerCase().contains(searchQuery.toLowerCase());
      
      bool matchesStatus = selectedStatus == "All" || request["status"] == selectedStatus;
      bool matchesPriority = selectedPriority == "All" || request["priority"] == selectedPriority;
      
      return matchesSearch && matchesStatus && matchesPriority;
    }).toList();
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "Open":
        return warningColor;
      case "In Progress":
        return infoColor;
      case "Pending Review":
        return warningColor;
      case "Resolved":
        return successColor;
      case "Closed":
        return disabledBoldColor;
      default:
        return disabledBoldColor;
    }
  }

  Color _getPriorityColor(String priority) {
    switch (priority) {
      case "Critical":
        return dangerColor;
      case "High":
        return warningColor;
      case "Medium":
        return infoColor;
      case "Low":
        return successColor;
      default:
        return disabledBoldColor;
    }
  }

  IconData _getServiceIcon(String serviceType) {
    switch (serviceType) {
      case "Vehicle Maintenance":
        return Icons.build;
      case "Emergency Repair":
        return Icons.emergency;
      case "Scheduled Maintenance":
        return Icons.schedule;
      case "GPS Installation":
        return Icons.gps_fixed;
      case "Tire Replacement":
        return Icons.tire_repair;
      default:
        return Icons.handyman;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Service Requests"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              // Navigate to create service request
            },
          ),
          IconButton(
            icon: Icon(Icons.more_vert),
            onPressed: () {},
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
                    label: "Search requests...",
                    value: searchQuery,
                    hint: "Search by ID, customer, or title",
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

            // Service Request Statistics
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusMd),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      children: [
                        Icon(Icons.assignment, color: primaryColor, size: 24),
                        SizedBox(height: spXs),
                        Text(
                          "${serviceRequests.length}",
                          style: TextStyle(
                            fontSize: fsH5,
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
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusMd),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      children: [
                        Icon(Icons.pending_actions, color: warningColor, size: 24),
                        SizedBox(height: spXs),
                        Text(
                          "${serviceRequests.where((r) => r["status"] == "Open" || r["status"] == "In Progress").length}",
                          style: TextStyle(
                            fontSize: fsH5,
                            fontWeight: FontWeight.bold,
                            color: warningColor,
                          ),
                        ),
                        Text(
                          "Active",
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
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusMd),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      children: [
                        Icon(Icons.emergency, color: dangerColor, size: 24),
                        SizedBox(height: spXs),
                        Text(
                          "${serviceRequests.where((r) => r["priority"] == "Critical" || r["priority"] == "High").length}",
                          style: TextStyle(
                            fontSize: fsH5,
                            fontWeight: FontWeight.bold,
                            color: dangerColor,
                          ),
                        ),
                        Text(
                          "Urgent",
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
            ),

            // Service Requests List
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
                    padding: EdgeInsets.all(spSm),
                    child: Row(
                      children: [
                        Text(
                          "Service Requests",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Spacer(),
                        Text(
                          "${filteredRequests.length} requests",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  ListView.separated(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: filteredRequests.length,
                    separatorBuilder: (context, index) => Divider(height: 1),
                    itemBuilder: (context, index) {
                      final request = filteredRequests[index];
                      return Container(
                        padding: EdgeInsets.all(spSm),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Container(
                                  width: 40,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    color: _getPriorityColor(request["priority"] as String).withAlpha(20),
                                    borderRadius: BorderRadius.circular(radiusSm),
                                  ),
                                  child: Icon(
                                    _getServiceIcon(request["serviceType"] as String),
                                    color: _getPriorityColor(request["priority"] as String),
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
                                            "${request["requestId"]}",
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16,
                                            ),
                                          ),
                                          Spacer(),
                                          Container(
                                            padding: EdgeInsets.symmetric(
                                              horizontal: spXs,
                                              vertical: 2,
                                            ),
                                            decoration: BoxDecoration(
                                              color: _getPriorityColor(request["priority"] as String).withAlpha(20),
                                              borderRadius: BorderRadius.circular(radiusXs),
                                            ),
                                            child: Text(
                                              "${request["priority"]}",
                                              style: TextStyle(
                                                fontSize: 10,
                                                color: _getPriorityColor(request["priority"] as String),
                                                fontWeight: FontWeight.w600,
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
                                              color: _getStatusColor(request["status"] as String).withAlpha(20),
                                              borderRadius: BorderRadius.circular(radiusXs),
                                            ),
                                            child: Text(
                                              "${request["status"]}",
                                              style: TextStyle(
                                                fontSize: 10,
                                                color: _getStatusColor(request["status"] as String),
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: spXs),
                                      Text(
                                        "${request["title"]}",
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
                            Container(
                              padding: EdgeInsets.all(spSm),
                              decoration: BoxDecoration(
                                color: Colors.grey.withAlpha(10),
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Column(
                                spacing: spXs,
                                children: [
                                  Row(
                                    children: [
                                      Icon(Icons.person, size: 14, color: disabledBoldColor),
                                      SizedBox(width: spXs),
                                      Text(
                                        "${request["customerName"]} • ${request["contactPerson"]}",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Icon(Icons.category, size: 14, color: disabledBoldColor),
                                      SizedBox(width: spXs),
                                      Text(
                                        "${request["serviceType"]}",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                  if (request["vehicleNumber"] != null) ...[
                                    Row(
                                      children: [
                                        Icon(Icons.directions_car, size: 14, color: disabledBoldColor),
                                        SizedBox(width: spXs),
                                        Text(
                                          "${request["vehicleNumber"]}",
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: disabledBoldColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                  if (request["assignedTo"] != null) ...[
                                    Row(
                                      children: [
                                        Icon(Icons.engineering, size: 14, color: disabledBoldColor),
                                        SizedBox(width: spXs),
                                        Text(
                                          "Assigned to: ${request["assignedTo"]}",
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: disabledBoldColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                  Row(
                                    children: [
                                      Icon(Icons.access_time, size: 14, color: disabledBoldColor),
                                      SizedBox(width: spXs),
                                      Text(
                                        "Created: ${request["createdDate"]}",
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
                            SizedBox(height: spSm),
                            Row(
                              children: [
                                if (request["cost"] != null) ...[
                                  Text(
                                    "Rp ${(request["cost"] as double).currency}",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: primaryColor,
                                    ),
                                  ),
                                ],
                                Spacer(),
                                QButton(
                                  label: "View Details",
                                  size: bs.sm,
                                  onPressed: () {
                                    // Navigate to service request details
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
