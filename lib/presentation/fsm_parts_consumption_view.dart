import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class FsmPartsConsumptionView extends StatefulWidget {
  const FsmPartsConsumptionView({super.key});

  @override
  State<FsmPartsConsumptionView> createState() => _FsmPartsConsumptionViewState();
}

class _FsmPartsConsumptionViewState extends State<FsmPartsConsumptionView> {
  String selectedPeriod = "This Month";
  String selectedCategory = "All";
  String selectedJob = "All Jobs";
  String selectedTechnician = "All Technicians";
  bool showCharts = true;

  List<Map<String, dynamic>> periods = [
    {"label": "This Week", "value": "This Week"},
    {"label": "This Month", "value": "This Month"},
    {"label": "Last 3 Months", "value": "Last 3 Months"},
    {"label": "This Year", "value": "This Year"},
    {"label": "Custom Range", "value": "Custom Range"},
  ];

  List<Map<String, dynamic>> categories = [
    {"label": "All", "value": "All"},
    {"label": "Electrical", "value": "Electrical"},
    {"label": "Mechanical", "value": "Mechanical"},
    {"label": "Hydraulic", "value": "Hydraulic"},
    {"label": "Safety", "value": "Safety"},
    {"label": "Tools", "value": "Tools"},
    {"label": "Consumables", "value": "Consumables"},
  ];

  List<Map<String, dynamic>> jobs = [
    {"label": "All Jobs", "value": "All Jobs"},
    {"label": "JOB-2025-001", "value": "JOB-2025-001"},
    {"label": "JOB-2025-002", "value": "JOB-2025-002"},
    {"label": "JOB-2025-003", "value": "JOB-2025-003"},
    {"label": "JOB-2025-004", "value": "JOB-2025-004"},
  ];

  List<Map<String, dynamic>> technicians = [
    {"label": "All Technicians", "value": "All Technicians"},
    {"label": "John Smith", "value": "John Smith"},
    {"label": "Sarah Johnson", "value": "Sarah Johnson"},
    {"label": "Mike Wilson", "value": "Mike Wilson"},
    {"label": "Lisa Chen", "value": "Lisa Chen"},
    {"label": "David Brown", "value": "David Brown"},
  ];

  List<Map<String, dynamic>> consumptionRecords = [
    {
      "id": "CONS-001",
      "date": "2025-06-18",
      "time": "14:30",
      "partName": "Circuit Breaker 20A",
      "partNumber": "CB-20A-001",
      "category": "Electrical",
      "quantityUsed": 3,
      "unitCost": 45.99,
      "totalCost": 137.97,
      "jobNumber": "JOB-2025-001",
      "technician": "John Smith",
      "customer": "ABC Manufacturing",
      "workOrder": "WO-2025-156",
      "reason": "Equipment Repair",
      "location": "Main Factory",
      "approved": true,
      "approvedBy": "Sarah Johnson",
    },
    {
      "id": "CONS-002",
      "date": "2025-06-18",
      "time": "11:15",
      "partName": "Hydraulic Oil Filter",
      "partNumber": "HOF-001",
      "category": "Hydraulic",
      "quantityUsed": 2,
      "unitCost": 35.50,
      "totalCost": 71.00,
      "jobNumber": "JOB-2025-002",
      "technician": "Mike Wilson",
      "customer": "XYZ Industries",
      "workOrder": "WO-2025-157",
      "reason": "Preventive Maintenance",
      "location": "Production Line A",
      "approved": true,
      "approvedBy": "David Brown",
    },
    {
      "id": "CONS-003",
      "date": "2025-06-17",
      "time": "16:45",
      "partName": "Safety Helmet",
      "partNumber": "HELM-STD-001",
      "category": "Safety",
      "quantityUsed": 1,
      "unitCost": 28.75,
      "totalCost": 28.75,
      "jobNumber": "JOB-2025-003",
      "technician": "Lisa Chen",
      "customer": "Construction Corp",
      "workOrder": "WO-2025-158",
      "reason": "Safety Replacement",
      "location": "Building Site 1",
      "approved": true,
      "approvedBy": "John Smith",
    },
    {
      "id": "CONS-004",
      "date": "2025-06-17",
      "time": "09:20",
      "partName": "Ball Bearing SKF-6205",
      "partNumber": "SKF-6205-2RS1",
      "category": "Mechanical",
      "quantityUsed": 4,
      "unitCost": 45.99,
      "totalCost": 183.96,
      "jobNumber": "JOB-2025-001",
      "technician": "John Smith",
      "customer": "ABC Manufacturing",
      "workOrder": "WO-2025-159",
      "reason": "Machine Overhaul",
      "location": "Workshop B",
      "approved": false,
      "approvedBy": "",
    },
    {
      "id": "CONS-005",
      "date": "2025-06-16",
      "time": "13:10",
      "partName": "Industrial Lubricant",
      "partNumber": "LUB-IND-001",
      "category": "Consumables",
      "quantityUsed": 5,
      "unitCost": 15.25,
      "totalCost": 76.25,
      "jobNumber": "JOB-2025-004",
      "technician": "Sarah Johnson",
      "customer": "Heavy Machinery Ltd",
      "workOrder": "WO-2025-160",
      "reason": "Equipment Service",
      "location": "Customer Site",
      "approved": true,
      "approvedBy": "Mike Wilson",
    },
    {
      "id": "CONS-006",
      "date": "2025-06-16",
      "time": "10:30",
      "partName": "Digital Multimeter",
      "partNumber": "FLUKE-87V",
      "category": "Tools",
      "quantityUsed": 1,
      "unitCost": 425.00,
      "totalCost": 425.00,
      "jobNumber": "JOB-2025-002",
      "technician": "David Brown",
      "customer": "XYZ Industries",
      "workOrder": "WO-2025-161",
      "reason": "Tool Replacement",
      "location": "Service Truck #002",
      "approved": true,
      "approvedBy": "Lisa Chen",
    },
  ];

  List<Map<String, dynamic>> get filteredRecords {
    return consumptionRecords.where((record) {
      bool matchesCategory = selectedCategory == "All" || record["category"] == selectedCategory;
      bool matchesJob = selectedJob == "All Jobs" || record["jobNumber"] == selectedJob;
      bool matchesTechnician = selectedTechnician == "All Technicians" || record["technician"] == selectedTechnician;
      
      return matchesCategory && matchesJob && matchesTechnician;
    }).toList();
  }

  Color _getApprovalColor(bool approved) {
    return approved ? successColor : warningColor;
  }

  Map<String, double> get categoryConsumption {
    Map<String, double> consumption = {};
    for (var record in filteredRecords) {
      String category = record["category"] as String;
      double cost = record["totalCost"] as double;
      consumption[category] = (consumption[category] ?? 0) + cost;
    }
    return consumption;
  }

  Map<String, int> get technicianConsumption {
    Map<String, int> consumption = {};
    for (var record in filteredRecords) {
      String technician = record["technician"] as String;
      consumption[technician] = (consumption[technician] ?? 0) + 1;
    }
    return consumption;
  }

  @override
  Widget build(BuildContext context) {
    double totalConsumptionValue = filteredRecords.fold(0.0, (sum, record) => sum + (record["totalCost"] as double));
    int totalItems = filteredRecords.fold(0, (sum, record) => sum + (record["quantityUsed"] as int));
    int pendingApprovals = filteredRecords.where((record) => !(record["approved"] as bool)).length;

    return Scaffold(
      appBar: AppBar(
        title: Text("Parts Consumption"),
        actions: [
          IconButton(
            icon: Icon(showCharts ? Icons.list : Icons.bar_chart),
            onPressed: () {
              showCharts = !showCharts;
              setState(() {});
            },
          ),
          IconButton(
            icon: Icon(Icons.download),
            onPressed: () {
              // Export report
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Filters
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
                      Expanded(
                        child: QDropdownField(
                          label: "Period",
                          items: periods,
                          value: selectedPeriod,
                          onChanged: (value, label) {
                            selectedPeriod = value;
                            setState(() {});
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QDropdownField(
                          label: "Category",
                          items: categories,
                          value: selectedCategory,
                          onChanged: (value, label) {
                            selectedCategory = value;
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
                        child: QDropdownField(
                          label: "Job",
                          items: jobs,
                          value: selectedJob,
                          onChanged: (value, label) {
                            selectedJob = value;
                            setState(() {});
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QDropdownField(
                          label: "Technician",
                          items: technicians,
                          value: selectedTechnician,
                          onChanged: (value, label) {
                            selectedTechnician = value;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: spMd),

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
                    border: Border(
                      left: BorderSide(
                        width: 4,
                        color: primaryColor,
                      ),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.trending_down,
                            color: primaryColor,
                            size: 24,
                          ),
                          SizedBox(width: spSm),
                          Text(
                            "Total Consumption",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spSm),
                      Text(
                        "\$${totalConsumptionValue.currency}",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "$totalItems parts used",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
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
                    border: Border(
                      left: BorderSide(
                        width: 4,
                        color: warningColor,
                      ),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.pending_actions,
                            color: warningColor,
                            size: 24,
                          ),
                          SizedBox(width: spSm),
                          Text(
                            "Pending Approvals",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spSm),
                      Text(
                        "$pendingApprovals",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: warningColor,
                        ),
                      ),
                      Text(
                        "Records need approval",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
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
                    border: Border(
                      left: BorderSide(
                        width: 4,
                        color: infoColor,
                      ),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.receipt,
                            color: infoColor,
                            size: 24,
                          ),
                          SizedBox(width: spSm),
                          Text(
                            "Records Count",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spSm),
                      Text(
                        "${filteredRecords.length}",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: infoColor,
                        ),
                      ),
                      Text(
                        "Consumption records",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
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
                    border: Border(
                      left: BorderSide(
                        width: 4,
                        color: successColor,
                      ),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.calculate,
                            color: successColor,
                            size: 24,
                          ),
                          SizedBox(width: spSm),
                          Text(
                            "Average per Record",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spSm),
                      Text(
                        "\$${filteredRecords.isNotEmpty ? (totalConsumptionValue / filteredRecords.length).currency : '0.00'}",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: successColor,
                        ),
                      ),
                      Text(
                        "Per consumption record",
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
            SizedBox(height: spMd),

            // Analytics Section
            if (showCharts) ...[
              Text(
                "Consumption Analysis",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              SizedBox(height: spSm),

              ResponsiveGridView(
                padding: EdgeInsets.zero,
                minItemWidth: 200,
                children: [
                  // Category Breakdown
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
                        Text(
                          "By Category",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        SizedBox(height: spSm),
                        ...categoryConsumption.entries.map((entry) {
                          return Container(
                            margin: EdgeInsets.only(bottom: spXs),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    entry.key,
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                ),
                                Text(
                                  "\$${entry.value.currency}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                      ],
                    ),
                  ),
                  
                  // Technician Activity
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
                        Text(
                          "By Technician",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        SizedBox(height: spSm),
                        ...technicianConsumption.entries.map((entry) {
                          return Container(
                            margin: EdgeInsets.only(bottom: spXs),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    entry.key,
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                ),
                                Text(
                                  "${entry.value} records",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: spMd),
            ],

            // Consumption Records
            Text(
              "Consumption Records (${filteredRecords.length})",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spSm),

            ...filteredRecords.map((record) {
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
                      color: _getApprovalColor(record["approved"] as bool),
                    ),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${record["partName"]}",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                              SizedBox(height: spXs),
                              Text(
                                "Part #: ${record["partNumber"]} • ${record["category"]}",
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
                            color: _getApprovalColor(record["approved"] as bool).withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Text(
                            (record["approved"] as bool) ? "Approved" : "Pending",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: _getApprovalColor(record["approved"] as bool),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spSm),

                    // Job Details
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Job Number",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Text(
                                "${record["jobNumber"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
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
                                "Work Order",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Text(
                                "${record["workOrder"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spSm),

                    // Usage Details
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Quantity Used",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Text(
                                "${record["quantityUsed"]} units",
                                style: TextStyle(
                                  fontSize: 14,
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
                                "Total Cost",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Text(
                                "\$${(record["totalCost"] as double).currency}",
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
                    SizedBox(height: spSm),

                    // Technician and Customer
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Technician",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Text(
                                "${record["technician"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
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
                                "Customer",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Text(
                                "${record["customer"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spSm),

                    // Reason and Location
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Reason: ${record["reason"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "Location: ${record["location"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spSm),

                    // Actions and Timestamp
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            "${record["date"]} ${record["time"]}" + 
                            ((record["approved"] as bool) ? " • Approved by ${record["approvedBy"]}" : ""),
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                        ),
                        if (!(record["approved"] as bool)) ...[
                          QButton(
                            icon: Icons.check,
                            size: bs.sm,
                            onPressed: () {
                              // Approve consumption
                            },
                          ),
                          SizedBox(width: spXs),
                        ],
                        QButton(
                          icon: Icons.edit,
                          size: bs.sm,
                          onPressed: () {
                            // Edit record
                          },
                        ),
                        SizedBox(width: spXs),
                        QButton(
                          icon: Icons.receipt,
                          size: bs.sm,
                          onPressed: () {
                            // View details
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              );
            }).toList(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add new consumption record
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
