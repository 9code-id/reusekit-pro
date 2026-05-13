import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class LtaComplaintsView extends StatefulWidget {
  const LtaComplaintsView({super.key});

  @override
  State<LtaComplaintsView> createState() => _LtaComplaintsViewState();
}

class _LtaComplaintsViewState extends State<LtaComplaintsView> {
  String searchQuery = "";
  String selectedStatus = "All";
  String selectedSeverity = "All";
  
  List<Map<String, dynamic>> statusOptions = [
    {"label": "All", "value": "All"},
    {"label": "Open", "value": "Open"},
    {"label": "Investigating", "value": "Investigating"},
    {"label": "In Progress", "value": "In Progress"},
    {"label": "Resolved", "value": "Resolved"},
    {"label": "Closed", "value": "Closed"}
  ];

  List<Map<String, dynamic>> severityOptions = [
    {"label": "All", "value": "All"},
    {"label": "Low", "value": "Low"},
    {"label": "Medium", "value": "Medium"},
    {"label": "High", "value": "High"},
    {"label": "Critical", "value": "Critical"}
  ];

  List<Map<String, dynamic>> complaints = [
    {
      "complaintId": "CMP001",
      "orderId": "ORD001",
      "customerName": "Ahmad Suryanto",
      "customerEmail": "ahmad.suryanto@email.com",
      "customerPhone": "+62 812-1111-2222",
      "complaintType": "Damage",
      "severity": "High",
      "status": "Investigating",
      "title": "Package Damaged During Transport",
      "description": "Received my electronics package with significant damage. The outer box was crushed and the internal items were broken. This appears to be due to improper handling during transport.",
      "dateSubmitted": "2024-12-15 10:30",
      "lastUpdated": "2024-12-15 14:45",
      "assignedTo": "Customer Service Team A",
      "driverName": "Budi Santoso",
      "vehicleNumber": "B 1234 XYZ",
      "estimatedResolution": "2024-12-17 12:00",
      "compensationOffered": 1500000.0,
      "images": [
        "https://picsum.photos/300/200?random=1&keyword=damage",
        "https://picsum.photos/300/200?random=2&keyword=broken"
      ],
      "updates": [
        {"time": "10:30", "note": "Complaint received from customer"},
        {"time": "11:15", "note": "Assigned to Customer Service Team A"},
        {"time": "14:45", "note": "Driver contacted for incident report"}
      ]
    },
    {
      "complaintId": "CMP002",
      "orderId": "ORD002",
      "customerName": "Siti Nurhaliza",
      "customerEmail": "siti.nurhaliza@company.com",
      "customerPhone": "+62 813-3333-4444",
      "complaintType": "Delay",
      "severity": "Medium",
      "status": "Resolved",
      "title": "Excessive Delivery Delay",
      "description": "My package was supposed to be delivered within 24 hours but took 4 days. No communication was provided about the delay until I called multiple times.",
      "dateSubmitted": "2024-12-14 16:20",
      "lastUpdated": "2024-12-15 11:30",
      "assignedTo": "Operations Manager",
      "driverName": "Eko Prasetyo",
      "vehicleNumber": "B 5678 ABC",
      "estimatedResolution": "2024-12-15 12:00",
      "compensationOffered": 250000.0,
      "images": [],
      "updates": [
        {"time": "16:20", "note": "Complaint received about delivery delay"},
        {"time": "17:00", "note": "Assigned to Operations Manager"},
        {"time": "11:30", "note": "Compensation provided and complaint resolved"}
      ]
    },
    {
      "complaintId": "CMP003",
      "orderId": "ORD003",
      "customerName": "Muhammad Rizki",
      "customerEmail": "m.rizki@business.co.id",
      "customerPhone": "+62 814-5555-6666",
      "complaintType": "Driver Behavior",
      "severity": "Critical",
      "status": "Open",
      "title": "Unprofessional Driver Conduct",
      "description": "The driver was extremely rude and unprofessional. He used inappropriate language and was aggressive when handling the delivery. This is completely unacceptable behavior.",
      "dateSubmitted": "2024-12-15 18:45",
      "lastUpdated": "2024-12-15 18:45",
      "assignedTo": null,
      "driverName": "Agus Wijaya",
      "vehicleNumber": "B 9012 DEF",
      "estimatedResolution": null,
      "compensationOffered": null,
      "images": [],
      "updates": [
        {"time": "18:45", "note": "Critical complaint received about driver behavior"}
      ]
    },
    {
      "complaintId": "CMP004",
      "orderId": "ORD004",
      "customerName": "Diana Putri",
      "customerEmail": "diana.putri@logistics.com",
      "customerPhone": "+62 815-7777-8888",
      "complaintType": "Lost Package",
      "severity": "High",
      "status": "In Progress",
      "title": "Package Lost in Transit",
      "description": "My package has been missing for 3 days. Tracking shows it was out for delivery but never arrived. Customer service has been unable to locate the package.",
      "dateSubmitted": "2024-12-13 14:15",
      "lastUpdated": "2024-12-15 09:20",
      "assignedTo": "Investigation Team",
      "driverName": "Indra Kusuma",
      "vehicleNumber": "B 3456 GHI",
      "estimatedResolution": "2024-12-18 15:00",
      "compensationOffered": 2000000.0,
      "images": [
        "https://picsum.photos/300/200?random=3&keyword=package"
      ],
      "updates": [
        {"time": "14:15", "note": "Lost package complaint received"},
        {"time": "15:30", "note": "Assigned to Investigation Team"},
        {"time": "09:20", "note": "Investigation ongoing - checking route records"}
      ]
    },
    {
      "complaintId": "CMP005",
      "orderId": "ORD005",
      "customerName": "Bambang Sutrisno",
      "customerEmail": "bambang@transport.id",
      "customerPhone": "+62 816-9999-0000",
      "complaintType": "Wrong Delivery",
      "severity": "Low",
      "status": "Closed",
      "title": "Package Delivered to Wrong Address",
      "description": "My package was delivered to the wrong address in the same building. Fortunately, the recipient was honest and returned it to me.",
      "dateSubmitted": "2024-12-12 11:45",
      "lastUpdated": "2024-12-13 08:30",
      "assignedTo": "Customer Service Team B",
      "driverName": "Yoga Pratama",
      "vehicleNumber": "B 7890 JKL",
      "estimatedResolution": "2024-12-13 10:00",
      "compensationOffered": 50000.0,
      "images": [],
      "updates": [
        {"time": "11:45", "note": "Wrong delivery address complaint received"},
        {"time": "12:30", "note": "Assigned to Customer Service Team B"},
        {"time": "08:30", "note": "Issue resolved, driver will receive additional training"}
      ]
    },
    {
      "complaintId": "CMP006",
      "orderId": "ORD006",
      "customerName": "Lestari Indah",
      "customerEmail": "lestari@shop.com",
      "customerPhone": "+62 817-1111-3333",
      "complaintType": "Billing",
      "severity": "Medium",
      "status": "In Progress",
      "title": "Incorrect Billing Amount",
      "description": "I was charged more than the quoted price. The initial quote was Rp 150,000 but I was charged Rp 200,000 without any explanation for the additional charges.",
      "dateSubmitted": "2024-12-14 09:20",
      "lastUpdated": "2024-12-15 16:10",
      "assignedTo": "Billing Department",
      "driverName": "Sari Wulandari",
      "vehicleNumber": "B 2468 MNO",
      "estimatedResolution": "2024-12-16 14:00",
      "compensationOffered": 50000.0,
      "images": [
        "https://picsum.photos/300/200?random=4&keyword=invoice"
      ],
      "updates": [
        {"time": "09:20", "note": "Billing complaint received"},
        {"time": "10:00", "note": "Assigned to Billing Department"},
        {"time": "16:10", "note": "Billing records reviewed, processing refund"}
      ]
    }
  ];

  List<Map<String, dynamic>> get filteredComplaints {
    return complaints.where((complaint) {
      bool matchesSearch = searchQuery.isEmpty || 
          (complaint["complaintId"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
          (complaint["customerName"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
          (complaint["title"] as String).toLowerCase().contains(searchQuery.toLowerCase());
      
      bool matchesStatus = selectedStatus == "All" || complaint["status"] == selectedStatus;
      bool matchesSeverity = selectedSeverity == "All" || complaint["severity"] == selectedSeverity;
      
      return matchesSearch && matchesStatus && matchesSeverity;
    }).toList();
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "Open":
        return dangerColor;
      case "Investigating":
        return warningColor;
      case "In Progress":
        return infoColor;
      case "Resolved":
        return successColor;
      case "Closed":
        return disabledBoldColor;
      default:
        return disabledBoldColor;
    }
  }

  Color _getSeverityColor(String severity) {
    switch (severity) {
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

  IconData _getComplaintIcon(String complaintType) {
    switch (complaintType) {
      case "Damage":
        return Icons.broken_image;
      case "Delay":
        return Icons.schedule;
      case "Driver Behavior":
        return Icons.person_off;
      case "Lost Package":
        return Icons.search_off;
      case "Wrong Delivery":
        return Icons.location_off;
      case "Billing":
        return Icons.payment;
      default:
        return Icons.report_problem;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Complaints"),
        actions: [
          IconButton(
            icon: Icon(Icons.analytics),
            onPressed: () {
              // Navigate to complaint analytics
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
                    label: "Search complaints...",
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
                    label: "Severity",
                    items: severityOptions,
                    value: selectedSeverity,
                    onChanged: (value, label) {
                      selectedSeverity = value;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),

            // Complaint Statistics
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
                        Icon(Icons.report_problem, color: primaryColor, size: 24),
                        SizedBox(height: spXs),
                        Text(
                          "${complaints.length}",
                          style: TextStyle(
                            fontSize: fsH5,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "Total Complaints",
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
                        Icon(Icons.pending, color: warningColor, size: 24),
                        SizedBox(height: spXs),
                        Text(
                          "${complaints.where((c) => c["status"] == "Open" || c["status"] == "Investigating").length}",
                          style: TextStyle(
                            fontSize: fsH5,
                            fontWeight: FontWeight.bold,
                            color: warningColor,
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
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusMd),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      children: [
                        Icon(Icons.priority_high, color: dangerColor, size: 24),
                        SizedBox(height: spXs),
                        Text(
                          "${complaints.where((c) => c["severity"] == "Critical" || c["severity"] == "High").length}",
                          style: TextStyle(
                            fontSize: fsH5,
                            fontWeight: FontWeight.bold,
                            color: dangerColor,
                          ),
                        ),
                        Text(
                          "High Priority",
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

            // Complaints List
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
                          "Customer Complaints",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Spacer(),
                        Text(
                          "${filteredComplaints.length} complaints",
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
                    itemCount: filteredComplaints.length,
                    separatorBuilder: (context, index) => Divider(height: 1),
                    itemBuilder: (context, index) {
                      final complaint = filteredComplaints[index];
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
                                    color: _getSeverityColor(complaint["severity"] as String).withAlpha(20),
                                    borderRadius: BorderRadius.circular(radiusSm),
                                  ),
                                  child: Icon(
                                    _getComplaintIcon(complaint["complaintType"] as String),
                                    color: _getSeverityColor(complaint["severity"] as String),
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
                                            "${complaint["complaintId"]}",
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
                                              color: _getSeverityColor(complaint["severity"] as String).withAlpha(20),
                                              borderRadius: BorderRadius.circular(radiusXs),
                                            ),
                                            child: Text(
                                              "${complaint["severity"]}",
                                              style: TextStyle(
                                                fontSize: 10,
                                                color: _getSeverityColor(complaint["severity"] as String),
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
                                              color: _getStatusColor(complaint["status"] as String).withAlpha(20),
                                              borderRadius: BorderRadius.circular(radiusXs),
                                            ),
                                            child: Text(
                                              "${complaint["status"]}",
                                              style: TextStyle(
                                                fontSize: 10,
                                                color: _getStatusColor(complaint["status"] as String),
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: spXs),
                                      Text(
                                        "${complaint["title"]}",
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
                                  Text(
                                    "${complaint["description"]}",
                                    style: TextStyle(
                                      fontSize: 13,
                                      color: Colors.black87,
                                      height: 1.4,
                                    ),
                                  ),
                                  if ((complaint["images"] as List).isNotEmpty) ...[
                                    SizedBox(height: spSm),
                                    QHorizontalScroll(
                                      children: (complaint["images"] as List).map((imageUrl) {
                                        return Container(
                                          width: 80,
                                          height: 60,
                                          margin: EdgeInsets.only(right: spXs),
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(radiusSm),
                                            image: DecorationImage(
                                              image: NetworkImage(imageUrl as String),
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        );
                                      }).toList(),
                                    ),
                                  ],
                                  SizedBox(height: spSm),
                                  Row(
                                    children: [
                                      Text(
                                        "${complaint["customerName"]} • ${complaint["complaintType"]}",
                                        style: TextStyle(
                                          fontSize: 11,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "Order: ${complaint["orderId"]} • Driver: ${complaint["driverName"]}",
                                        style: TextStyle(
                                          fontSize: 11,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Icon(Icons.access_time, size: 12, color: disabledBoldColor),
                                      SizedBox(width: 2),
                                      Text(
                                        "Submitted: ${complaint["dateSubmitted"]}",
                                        style: TextStyle(
                                          fontSize: 11,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                  if (complaint["assignedTo"] != null) ...[
                                    Row(
                                      children: [
                                        Icon(Icons.assignment_ind, size: 12, color: disabledBoldColor),
                                        SizedBox(width: 2),
                                        Text(
                                          "Assigned to: ${complaint["assignedTo"]}",
                                          style: TextStyle(
                                            fontSize: 11,
                                            color: disabledBoldColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ],
                              ),
                            ),
                            SizedBox(height: spSm),
                            Row(
                              children: [
                                if (complaint["compensationOffered"] != null) ...[
                                  Text(
                                    "Compensation: Rp ${(complaint["compensationOffered"] as double).currency}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      color: successColor,
                                    ),
                                  ),
                                ],
                                Spacer(),
                                if (complaint["status"] == "Open" || complaint["status"] == "Investigating") ...[
                                  QButton(
                                    label: "Take Action",
                                    size: bs.sm,
                                    onPressed: () {
                                      // Navigate to complaint management
                                    },
                                  ),
                                  SizedBox(width: spXs),
                                ],
                                QButton(
                                  label: "View Details",
                                  size: bs.sm,
                                  onPressed: () {
                                    // Navigate to complaint details
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
