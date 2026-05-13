import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class IwmPurchaseRequisitionsView extends StatefulWidget {
  const IwmPurchaseRequisitionsView({super.key});

  @override
  State<IwmPurchaseRequisitionsView> createState() => _IwmPurchaseRequisitionsViewState();
}

class _IwmPurchaseRequisitionsViewState extends State<IwmPurchaseRequisitionsView> {
  String searchQuery = "";
  String selectedStatus = "All Status";
  String selectedPriority = "All Priority";
  String selectedDepartment = "All Departments";
  bool loading = false;

  List<Map<String, dynamic>> requisitions = [
    {
      "id": "PR001",
      "title": "Office Supplies Restocking",
      "department": "Administration",
      "requestedBy": "Sarah Johnson",
      "requestDate": "2024-06-15",
      "requiredDate": "2024-06-22",
      "priority": "High",
      "status": "Pending Approval",
      "totalAmount": 2500.00,
      "items": [
        {"name": "A4 Paper", "qty": 100, "unit": "packs", "unitPrice": 15.00},
        {"name": "Printer Ink", "qty": 20, "unit": "cartridges", "unitPrice": 45.00},
        {"name": "Stapler", "qty": 5, "unit": "pieces", "unitPrice": 25.00},
      ],
      "justification": "Monthly office supplies restocking for Q2 operations",
      "approver": "John Smith",
    },
    {
      "id": "PR002",
      "title": "IT Equipment Upgrade",
      "department": "IT",
      "requestedBy": "Mike Wilson",
      "requestDate": "2024-06-12",
      "requiredDate": "2024-07-01",
      "priority": "Critical",
      "status": "Approved",
      "totalAmount": 15000.00,
      "items": [
        {"name": "Laptop Dell XPS", "qty": 5, "unit": "units", "unitPrice": 1200.00},
        {"name": "External Monitor", "qty": 5, "unit": "units", "unitPrice": 300.00},
        {"name": "Wireless Mouse", "qty": 5, "unit": "units", "unitPrice": 50.00},
      ],
      "justification": "Hardware upgrade for development team productivity",
      "approver": "Lisa Brown",
    },
    {
      "id": "PR003",
      "title": "Maintenance Tools",
      "department": "Maintenance",
      "requestedBy": "Alex Chen",
      "requestDate": "2024-06-18",
      "requiredDate": "2024-06-25",
      "priority": "Medium",
      "status": "In Review",
      "totalAmount": 3200.00,
      "items": [
        {"name": "Power Drill", "qty": 2, "unit": "units", "unitPrice": 150.00},
        {"name": "Wrench Set", "qty": 3, "unit": "sets", "unitPrice": 80.00},
        {"name": "Safety Gear", "qty": 10, "unit": "sets", "unitPrice": 120.00},
      ],
      "justification": "Essential tools for facility maintenance operations",
      "approver": "David Wong",
    },
    {
      "id": "PR004",
      "title": "Marketing Materials",
      "department": "Marketing",
      "requestedBy": "Emma Davis",
      "requestDate": "2024-06-10",
      "requiredDate": "2024-06-30",
      "priority": "Low",
      "status": "Rejected",
      "totalAmount": 1800.00,
      "items": [
        {"name": "Brochures", "qty": 1000, "unit": "pieces", "unitPrice": 1.20},
        {"name": "Business Cards", "qty": 500, "unit": "pieces", "unitPrice": 0.80},
        {"name": "Banner", "qty": 3, "unit": "pieces", "unitPrice": 120.00},
      ],
      "justification": "Promotional materials for upcoming trade show",
      "approver": "John Smith",
    },
    {
      "id": "PR005",
      "title": "Laboratory Equipment",
      "department": "R&D",
      "requestedBy": "Dr. Robert Kim",
      "requestDate": "2024-06-19",
      "requiredDate": "2024-07-15",
      "priority": "High",
      "status": "Draft",
      "totalAmount": 8500.00,
      "items": [
        {"name": "Microscope", "qty": 1, "unit": "unit", "unitPrice": 3500.00},
        {"name": "Test Tubes", "qty": 200, "unit": "pieces", "unitPrice": 2.50},
        {"name": "Chemical Reagents", "qty": 1, "unit": "set", "unitPrice": 2000.00},
      ],
      "justification": "Equipment for new research project on material testing",
      "approver": "Lisa Brown",
    },
  ];

  List<Map<String, dynamic>> statusItems = [
    {"label": "All Status", "value": "All Status"},
    {"label": "Draft", "value": "Draft"},
    {"label": "Pending Approval", "value": "Pending Approval"},
    {"label": "In Review", "value": "In Review"},
    {"label": "Approved", "value": "Approved"},
    {"label": "Rejected", "value": "Rejected"},
  ];

  List<Map<String, dynamic>> priorityItems = [
    {"label": "All Priority", "value": "All Priority"},
    {"label": "Critical", "value": "Critical"},
    {"label": "High", "value": "High"},
    {"label": "Medium", "value": "Medium"},
    {"label": "Low", "value": "Low"},
  ];

  List<Map<String, dynamic>> departmentItems = [
    {"label": "All Departments", "value": "All Departments"},
    {"label": "Administration", "value": "Administration"},
    {"label": "IT", "value": "IT"},
    {"label": "Maintenance", "value": "Maintenance"},
    {"label": "Marketing", "value": "Marketing"},
    {"label": "R&D", "value": "R&D"},
  ];

  List<Map<String, dynamic>> get filteredRequisitions {
    return requisitions.where((req) {
      bool matchesSearch = req["title"].toLowerCase().contains(searchQuery.toLowerCase()) ||
          req["requestedBy"].toLowerCase().contains(searchQuery.toLowerCase()) ||
          req["id"].toLowerCase().contains(searchQuery.toLowerCase());
      bool matchesStatus = selectedStatus == "All Status" || req["status"] == selectedStatus;
      bool matchesPriority = selectedPriority == "All Priority" || req["priority"] == selectedPriority;
      bool matchesDepartment = selectedDepartment == "All Departments" || req["department"] == selectedDepartment;
      return matchesSearch && matchesStatus && matchesPriority && matchesDepartment;
    }).toList();
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "Approved":
        return successColor;
      case "Pending Approval":
      case "In Review":
        return warningColor;
      case "Rejected":
        return dangerColor;
      case "Draft":
        return infoColor;
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

  Widget _buildRequisitionCard(Map<String, dynamic> requisition) {
    Color statusColor = _getStatusColor(requisition["status"]);
    Color priorityColor = _getPriorityColor(requisition["priority"]);

    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
        border: Border(
          left: BorderSide(
            width: 4,
            color: priorityColor,
          ),
        ),
      ),
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
                      "${requisition["title"]}",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "${requisition["id"]} • ${requisition["department"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: statusColor.withAlpha(25),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Text(
                  "${requisition["status"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: statusColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              Icon(Icons.person, size: 16, color: disabledBoldColor),
              SizedBox(width: spXs),
              Text(
                "Requested by ${requisition["requestedBy"]}",
                style: TextStyle(
                  fontSize: 13,
                  color: disabledBoldColor,
                ),
              ),
              Spacer(),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                decoration: BoxDecoration(
                  color: priorityColor.withAlpha(25),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "${requisition["priority"]}",
                  style: TextStyle(
                    fontSize: 11,
                    color: priorityColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              Icon(Icons.calendar_today, size: 16, color: disabledBoldColor),
              SizedBox(width: spXs),
              Text(
                "Requested: ${requisition["requestDate"]}",
                style: TextStyle(
                  fontSize: 13,
                  color: disabledBoldColor,
                ),
              ),
              Spacer(),
              Icon(Icons.event, size: 16, color: disabledBoldColor),
              SizedBox(width: spXs),
              Text(
                "Required: ${requisition["requiredDate"]}",
                style: TextStyle(
                  fontSize: 13,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(12),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Items (${(requisition["items"] as List).length})",
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spXs),
                ...(requisition["items"] as List).take(3).map((item) {
                  return Padding(
                    padding: EdgeInsets.only(bottom: spXs),
                    child: Row(
                      children: [
                        Text(
                          "• ${item["name"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                        Spacer(),
                        Text(
                          "${item["qty"]} ${item["unit"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  );
                }),
                if ((requisition["items"] as List).length > 3)
                  Text(
                    "...and ${(requisition["items"] as List).length - 3} more items",
                    style: TextStyle(
                      fontSize: 11,
                      color: disabledBoldColor,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
              ],
            ),
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              Text(
                "Total Amount: ",
                style: TextStyle(
                  fontSize: 13,
                  color: disabledBoldColor,
                ),
              ),
              Text(
                "\$${(requisition["totalAmount"] as double).currency}",
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: successColor,
                ),
              ),
              Spacer(),
              if (requisition["approver"] != null)
                Text(
                  "Approver: ${requisition["approver"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
            ],
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              Expanded(
                child: QButton(
                  label: "View Details",
                  size: bs.sm,
                  onPressed: () {},
                ),
              ),
              SizedBox(width: spSm),
              if (requisition["status"] == "Draft")
                Expanded(
                  child: QButton(
                    label: "Submit",
                    size: bs.sm,
                    onPressed: () {},
                  ),
                )
              else if (requisition["status"] == "Pending Approval")
                Expanded(
                  child: QButton(
                    label: "Process",
                    size: bs.sm,
                    onPressed: () {},
                  ),
                )
              else
                Expanded(
                  child: QButton(
                    label: "Download",
                    size: bs.sm,
                    onPressed: () {},
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Purchase Requisitions"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {},
          ),
        ],
      ),
      body: loading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: EdgeInsets.all(spMd),
              child: Column(
                spacing: spMd,
                children: [
                  // Search and Filters
                  Row(
                    children: [
                      Expanded(
                        child: QTextField(
                          label: "Search requisitions...",
                          value: searchQuery,
                          onChanged: (value) {
                            searchQuery = value;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
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
                      SizedBox(width: spSm),
                      Expanded(
                        child: QDropdownField(
                          label: "Priority",
                          items: priorityItems,
                          value: selectedPriority,
                          onChanged: (value, label) {
                            selectedPriority = value;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: QDropdownField(
                          label: "Department",
                          items: departmentItems,
                          value: selectedDepartment,
                          onChanged: (value, label) {
                            selectedDepartment = value;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),

                  // Summary Cards
                  ResponsiveGridView(
                    padding: EdgeInsets.all(0),
                    minItemWidth: 200,
                    children: [
                      Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: primaryColor.withAlpha(25),
                          borderRadius: BorderRadius.circular(radiusMd),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(Icons.description, color: primaryColor),
                                SizedBox(width: spSm),
                                Text(
                                  "Total Requests",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: spSm),
                            Text(
                              "${requisitions.length}",
                              style: TextStyle(
                                fontSize: 24,
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
                          color: warningColor.withAlpha(25),
                          borderRadius: BorderRadius.circular(radiusMd),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(Icons.pending, color: warningColor),
                                SizedBox(width: spSm),
                                Text(
                                  "Pending",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: spSm),
                            Text(
                              "${requisitions.where((r) => r["status"] == "Pending Approval" || r["status"] == "In Review").length}",
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: warningColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: successColor.withAlpha(25),
                          borderRadius: BorderRadius.circular(radiusMd),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(Icons.check_circle, color: successColor),
                                SizedBox(width: spSm),
                                Text(
                                  "Approved",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: spSm),
                            Text(
                              "${requisitions.where((r) => r["status"] == "Approved").length}",
                              style: TextStyle(
                                fontSize: 24,
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
                          color: infoColor.withAlpha(25),
                          borderRadius: BorderRadius.circular(radiusMd),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(Icons.attach_money, color: infoColor),
                                SizedBox(width: spSm),
                                Text(
                                  "Total Value",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: spSm),
                            Text(
                              "\$${((requisitions.fold(0.0, (sum, r) => sum + (r["totalAmount"] as double))) / 1000).toStringAsFixed(1)}K",
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: infoColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  // Requisitions List
                  Container(
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              "Requisitions (${filteredRequisitions.length})",
                              style: TextStyle(
                                fontSize: fsH6,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            Spacer(),
                            QButton(
                              label: "Export",
                              icon: Icons.download,
                              size: bs.sm,
                              onPressed: () {},
                            ),
                          ],
                        ),
                        SizedBox(height: spSm),
                        ...filteredRequisitions.map((requisition) => _buildRequisitionCard(requisition)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
