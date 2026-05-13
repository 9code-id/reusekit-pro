import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class ComaProcurementView extends StatefulWidget {
  const ComaProcurementView({super.key});

  @override
  State<ComaProcurementView> createState() => _ComaProcurementViewState();
}

class _ComaProcurementViewState extends State<ComaProcurementView> {
  String searchQuery = "";
  String selectedStatus = "All";
  String selectedPriority = "All";
  String selectedCategory = "All";
  DateTime? fromDate;
  DateTime? toDate;
  
  List<Map<String, dynamic>> procurementRequests = [
    {
      "id": "PR-2024-001",
      "title": "Concrete and Steel Materials",
      "description": "High-strength concrete C35/45 and reinforcement steel for foundation work",
      "category": "Building Materials",
      "requestDate": "2024-03-15",
      "requiredDate": "2024-03-25",
      "status": "Pending Approval",
      "priority": "High",
      "requestedBy": "John Smith",
      "department": "Construction",
      "estimatedValue": 125000.0,
      "actualValue": 0.0,
      "approvedBy": "",
      "items": [
        {"name": "Concrete C35/45", "quantity": 150, "unit": "m³", "unitPrice": 180.0},
        {"name": "Reinforcement Steel", "quantity": 8000, "unit": "kg", "unitPrice": 1.2},
      ],
      "suppliers": 3,
      "quotations": 2,
      "image": "https://picsum.photos/300/200?random=1&keyword=concrete"
    },
    {
      "id": "PR-2024-002", 
      "title": "Electrical Components",
      "description": "Electrical cables, switches, and panel boards for building installation",
      "category": "Electrical",
      "requestDate": "2024-03-18",
      "requiredDate": "2024-04-01",
      "status": "Approved",
      "priority": "Medium",
      "requestedBy": "Mike Johnson",
      "department": "Electrical",
      "estimatedValue": 45000.0,
      "actualValue": 42800.0,
      "approvedBy": "Sarah Wilson",
      "items": [
        {"name": "Electrical Cables", "quantity": 500, "unit": "m", "unitPrice": 15.0},
        {"name": "Switch Panels", "quantity": 25, "unit": "pcs", "unitPrice": 850.0},
      ],
      "suppliers": 5,
      "quotations": 4,
      "image": "https://picsum.photos/300/200?random=2&keyword=electrical"
    },
    {
      "id": "PR-2024-003",
      "title": "Plumbing Fixtures",
      "description": "Bathroom fixtures, pipes, and fittings for residential complex",
      "category": "Plumbing",
      "requestDate": "2024-03-20",
      "requiredDate": "2024-04-05",
      "status": "In Process",
      "priority": "Medium",
      "requestedBy": "Lisa Brown",
      "department": "Plumbing",
      "estimatedValue": 28000.0,
      "actualValue": 26500.0,
      "approvedBy": "Tom Davis",
      "items": [
        {"name": "Toilet Sets", "quantity": 40, "unit": "set", "unitPrice": 320.0},
        {"name": "PVC Pipes", "quantity": 800, "unit": "m", "unitPrice": 12.5},
      ],
      "suppliers": 4,
      "quotations": 3,
      "image": "https://picsum.photos/300/200?random=3&keyword=plumbing"
    },
    {
      "id": "PR-2024-004",
      "title": "Safety Equipment",
      "description": "Personal protective equipment and safety signage for construction site",
      "category": "Safety",
      "requestDate": "2024-03-22",
      "requiredDate": "2024-03-28",
      "status": "Urgent",
      "priority": "High",
      "requestedBy": "David Wilson",
      "department": "Safety",
      "estimatedValue": 15000.0,
      "actualValue": 0.0,
      "approvedBy": "",
      "items": [
        {"name": "Safety Helmets", "quantity": 100, "unit": "pcs", "unitPrice": 25.0},
        {"name": "Safety Vests", "quantity": 100, "unit": "pcs", "unitPrice": 18.0},
      ],
      "suppliers": 6,
      "quotations": 1,
      "image": "https://picsum.photos/300/200?random=4&keyword=safety"
    },
    {
      "id": "PR-2024-005",
      "title": "Finishing Materials",
      "description": "Tiles, paint, and finishing materials for interior work",
      "category": "Finishing",
      "requestDate": "2024-03-25",
      "requiredDate": "2024-04-10",
      "status": "Draft",
      "priority": "Low",
      "requestedBy": "Anna Taylor",
      "department": "Interior",
      "estimatedValue": 35000.0,
      "actualValue": 0.0,
      "approvedBy": "",
      "items": [
        {"name": "Ceramic Tiles", "quantity": 200, "unit": "m²", "unitPrice": 45.0},
        {"name": "Interior Paint", "quantity": 150, "unit": "L", "unitPrice": 35.0},
      ],
      "suppliers": 3,
      "quotations": 0,
      "image": "https://picsum.photos/300/200?random=5&keyword=tiles"
    }
  ];

  List<Map<String, dynamic>> get filteredRequests {
    return procurementRequests.where((request) {
      bool matchesSearch = request["title"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
          request["description"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
          request["id"].toString().toLowerCase().contains(searchQuery.toLowerCase());
      
      bool matchesStatus = selectedStatus == "All" || request["status"] == selectedStatus;
      bool matchesPriority = selectedPriority == "All" || request["priority"] == selectedPriority;
      bool matchesCategory = selectedCategory == "All" || request["category"] == selectedCategory;
      
      return matchesSearch && matchesStatus && matchesPriority && matchesCategory;
    }).toList();
  }

  Color getStatusColor(String status) {
    switch (status) {
      case "Approved":
        return successColor;
      case "In Process":
        return infoColor;
      case "Pending Approval":
        return warningColor;
      case "Urgent":
        return dangerColor;
      case "Draft":
        return disabledColor;
      default:
        return disabledColor;
    }
  }

  Color getPriorityColor(String priority) {
    switch (priority) {
      case "High":
        return dangerColor;
      case "Medium":
        return warningColor;
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
        title: Text('Procurement Management'),
        actions: [
          IconButton(
            icon: Icon(Icons.filter_list),
            onPressed: () => _showFilterDialog(),
          ),
          IconButton(
            icon: Icon(Icons.add),
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
            QTextField(
              label: "Search procurement requests...",
              value: searchQuery,
              hint: "Search by ID, title, or description",
              onChanged: (value) {
                searchQuery = value;
                setState(() {});
              },
            ),

            // Summary Cards
            Row(
              spacing: spSm,
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.shopping_cart,
                              color: primaryColor,
                              size: 20,
                            ),
                            SizedBox(width: spXs),
                            Text(
                              "Total Requests",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "${procurementRequests.length}",
                          style: TextStyle(
                            fontSize: fsH4,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
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
                              Icons.pending_actions,
                              color: warningColor,
                              size: 20,
                            ),
                            SizedBox(width: spXs),
                            Text(
                              "Pending",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "${procurementRequests.where((r) => r["status"] == "Pending Approval").length}",
                          style: TextStyle(
                            fontSize: fsH4,
                            fontWeight: FontWeight.bold,
                            color: warningColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            Row(
              spacing: spSm,
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.attach_money,
                              color: successColor,
                              size: 20,
                            ),
                            SizedBox(width: spXs),
                            Text(
                              "Total Value",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "\$${((procurementRequests.fold(0.0, (sum, item) => sum + (item["estimatedValue"] as double)) / 1000)).toStringAsFixed(0)}K",
                          style: TextStyle(
                            fontSize: fsH4,
                            fontWeight: FontWeight.bold,
                            color: successColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
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
                              Icons.priority_high,
                              color: dangerColor,
                              size: 20,
                            ),
                            SizedBox(width: spXs),
                            Text(
                              "Urgent",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "${procurementRequests.where((r) => r["status"] == "Urgent").length}",
                          style: TextStyle(
                            fontSize: fsH4,
                            fontWeight: FontWeight.bold,
                            color: dangerColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            // Procurement Requests List
            ...filteredRequests.map((request) {
              return Container(
                margin: EdgeInsets.only(bottom: spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.vertical(top: Radius.circular(radiusMd)),
                      child: Image.network(
                        "${request["image"]}",
                        height: 150,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(spSm),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: spXs,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  "${request["id"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 4),
                                decoration: BoxDecoration(
                                  color: getStatusColor(request["status"]).withAlpha(20),
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: Text(
                                  "${request["status"]}",
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: getStatusColor(request["status"]),
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Text(
                            "${request["title"]}",
                            style: TextStyle(
                              fontSize: fsH6,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          Text(
                            "${request["description"]}",
                            style: TextStyle(
                              fontSize: 13,
                              color: disabledBoldColor,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.category,
                                size: 14,
                                color: disabledBoldColor,
                              ),
                              SizedBox(width: spXs),
                              Text(
                                "${request["category"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                              SizedBox(width: spSm),
                              Icon(
                                Icons.flag,
                                size: 14,
                                color: getPriorityColor(request["priority"]),
                              ),
                              SizedBox(width: spXs),
                              Text(
                                "${request["priority"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: getPriorityColor(request["priority"]),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.person,
                                size: 14,
                                color: disabledBoldColor,
                              ),
                              SizedBox(width: spXs),
                              Text(
                                "${request["requestedBy"]} • ${request["department"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.calendar_today,
                                size: 14,
                                color: disabledBoldColor,
                              ),
                              SizedBox(width: spXs),
                              Text(
                                "Required: ${request["requiredDate"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  "Est. Value: \$${((request["estimatedValue"] as double) / 1000).toStringAsFixed(0)}K",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: successColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              Text(
                                "${request["suppliers"]} suppliers • ${request["quotations"]} quotes",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: infoColor,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
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
                              QButton(
                                icon: Icons.edit,
                                size: bs.sm,
                                onPressed: () {},
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ],
        ),
      ),
    );
  }

  void _showFilterDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Filter Procurement'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            spacing: spSm,
            children: [
              QDropdownField(
                label: "Status",
                items: [
                  {"label": "All", "value": "All"},
                  {"label": "Draft", "value": "Draft"},
                  {"label": "Pending Approval", "value": "Pending Approval"},
                  {"label": "Approved", "value": "Approved"},
                  {"label": "In Process", "value": "In Process"},
                  {"label": "Urgent", "value": "Urgent"},
                ],
                value: selectedStatus,
                onChanged: (value, label) {
                  selectedStatus = value;
                  setState(() {});
                },
              ),
              QDropdownField(
                label: "Priority",
                items: [
                  {"label": "All", "value": "All"},
                  {"label": "High", "value": "High"},
                  {"label": "Medium", "value": "Medium"},
                  {"label": "Low", "value": "Low"},
                ],
                value: selectedPriority,
                onChanged: (value, label) {
                  selectedPriority = value;
                  setState(() {});
                },
              ),
              QDropdownField(
                label: "Category",
                items: [
                  {"label": "All", "value": "All"},
                  {"label": "Building Materials", "value": "Building Materials"},
                  {"label": "Electrical", "value": "Electrical"},
                  {"label": "Plumbing", "value": "Plumbing"},
                  {"label": "Safety", "value": "Safety"},
                  {"label": "Finishing", "value": "Finishing"},
                ],
                value: selectedCategory,
                onChanged: (value, label) {
                  selectedCategory = value;
                  setState(() {});
                },
              ),
            ],
          ),
          actions: [
            QButton(
              label: 'Clear',
              size: bs.sm,
              onPressed: () {
                selectedStatus = "All";
                selectedPriority = "All";
                selectedCategory = "All";
                setState(() {});
                Navigator.of(context).pop();
              },
            ),
            QButton(
              label: 'Apply',
              size: bs.sm,
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
