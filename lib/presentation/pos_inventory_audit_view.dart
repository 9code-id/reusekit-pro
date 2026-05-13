import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class PosInventoryAuditView extends StatefulWidget {
  const PosInventoryAuditView({super.key});

  @override
  State<PosInventoryAuditView> createState() => _PosInventoryAuditViewState();
}

class _PosInventoryAuditViewState extends State<PosInventoryAuditView> {
  String selectedStatus = "All";
  String selectedLocation = "All";
  String searchQuery = "";

  List<Map<String, dynamic>> statusOptions = [
    {"label": "All", "value": "All"},
    {"label": "Scheduled", "value": "Scheduled"},
    {"label": "In Progress", "value": "In Progress"},
    {"label": "Completed", "value": "Completed"},
    {"label": "Review", "value": "Review"},
  ];

  List<Map<String, dynamic>> locationOptions = [
    {"label": "All", "value": "All"},
    {"label": "Main Warehouse", "value": "Main Warehouse"},
    {"label": "Store A", "value": "Store A"},
    {"label": "Store B", "value": "Store B"},
    {"label": "Store C", "value": "Store C"},
  ];

  List<Map<String, dynamic>> inventoryAudits = [
    {
      "id": "AUDIT-2024-001",
      "title": "Quarterly Inventory Audit Q2",
      "location": "Main Warehouse",
      "scheduledDate": "2024-06-20",
      "actualDate": "2024-06-20",
      "status": "Completed",
      "auditedBy": "John Smith",
      "itemsAudited": 1250,
      "discrepancies": 8,
      "adjustmentValue": -450.75,
      "accuracy": 99.4,
      "notes": "Minor discrepancies in electronic components section",
    },
    {
      "id": "AUDIT-2024-002",
      "title": "Monthly Cycle Count - June",
      "location": "Store A",
      "scheduledDate": "2024-06-18",
      "actualDate": "",
      "status": "In Progress",
      "auditedBy": "Sarah Wilson",
      "itemsAudited": 450,
      "discrepancies": 2,
      "adjustmentValue": 125.50,
      "accuracy": 95.5,
      "notes": "Currently auditing clothing section",
    },
    {
      "id": "AUDIT-2024-003",
      "title": "Spot Check - High Value Items",
      "location": "Store B",
      "scheduledDate": "2024-06-15",
      "actualDate": "2024-06-15",
      "status": "Review",
      "auditedBy": "Mike Johnson",
      "itemsAudited": 85,
      "discrepancies": 3,
      "adjustmentValue": -1250.00,
      "accuracy": 96.5,
      "notes": "3 high-value items missing, investigation in progress",
    },
    {
      "id": "AUDIT-2024-004",
      "title": "New Store Opening Audit",
      "location": "Store C",
      "scheduledDate": "2024-06-25",
      "actualDate": "",
      "status": "Scheduled",
      "auditedBy": "Lisa Chen",
      "itemsAudited": 0,
      "discrepancies": 0,
      "adjustmentValue": 0.00,
      "accuracy": 0.0,
      "notes": "Initial inventory count for new store location",
    },
    {
      "id": "AUDIT-2024-005",
      "title": "Perishable Goods Audit",
      "location": "Main Warehouse",
      "scheduledDate": "2024-06-12",
      "actualDate": "2024-06-12",
      "status": "Completed",
      "auditedBy": "Emma Davis",
      "itemsAudited": 320,
      "discrepancies": 15,
      "adjustmentValue": -875.25,
      "accuracy": 95.3,
      "notes": "Higher discrepancy due to expired items disposal",
    },
  ];

  List<Map<String, dynamic>> get filteredAudits {
    return inventoryAudits.where((audit) {
      bool matchesStatus = selectedStatus == "All" || audit["status"] == selectedStatus;
      bool matchesLocation = selectedLocation == "All" || audit["location"] == selectedLocation;
      bool matchesSearch = searchQuery.isEmpty ||
          audit["id"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
          audit["title"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
          audit["auditedBy"].toString().toLowerCase().contains(searchQuery.toLowerCase());
      return matchesStatus && matchesLocation && matchesSearch;
    }).toList();
  }

  Color getStatusColor(String status) {
    switch (status) {
      case "Scheduled":
        return infoColor;
      case "In Progress":
        return warningColor;
      case "Completed":
        return successColor;
      case "Review":
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  Color getAccuracyColor(double accuracy) {
    if (accuracy >= 98.0) return successColor;
    if (accuracy >= 95.0) return warningColor;
    return dangerColor;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Inventory Audit"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              //navigateTo('CreateInventoryAuditView')
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Filters Section
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                spacing: spSm,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: QTextField(
                          label: "Search Audits",
                          value: searchQuery,
                          hint: "Search by ID, title, or auditor",
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
                          label: "Filter by Status",
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
                          label: "Filter by Location",
                          items: locationOptions,
                          value: selectedLocation,
                          onChanged: (value, label) {
                            selectedLocation = value;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Summary Cards
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.assignment,
                              color: primaryColor,
                              size: 20,
                            ),
                            SizedBox(width: spXs),
                            Text(
                              "Total Audits",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "${inventoryAudits.length}",
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.trending_up,
                              color: successColor,
                              size: 20,
                            ),
                            SizedBox(width: spXs),
                            Text(
                              "Avg Accuracy",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "${(inventoryAudits.where((a) => (a["accuracy"] as num) > 0).fold(0.0, (sum, audit) => sum + (audit["accuracy"] as num).toDouble()) / inventoryAudits.where((a) => (a["accuracy"] as num) > 0).length).toStringAsFixed(1)}%",
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
              ],
            ),

            // Audit Statistics
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
                    "Audit Statistics",
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
                        child: Column(
                          children: [
                            Text(
                              "${inventoryAudits.where((a) => a["status"] == "Completed").length}",
                              style: TextStyle(
                                fontSize: fsH5,
                                fontWeight: FontWeight.bold,
                                color: successColor,
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
                      Expanded(
                        child: Column(
                          children: [
                            Text(
                              "${inventoryAudits.where((a) => a["status"] == "In Progress").length}",
                              style: TextStyle(
                                fontSize: fsH5,
                                fontWeight: FontWeight.bold,
                                color: warningColor,
                              ),
                            ),
                            Text(
                              "In Progress",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            Text(
                              "${inventoryAudits.where((a) => a["status"] == "Review").length}",
                              style: TextStyle(
                                fontSize: fsH5,
                                fontWeight: FontWeight.bold,
                                color: dangerColor,
                              ),
                            ),
                            Text(
                              "Review",
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
                ],
              ),
            ),

            // Audits List
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
                        Icon(
                          Icons.list_alt,
                          color: primaryColor,
                          size: 20,
                        ),
                        SizedBox(width: spXs),
                        Text(
                          "Inventory Audits (${filteredAudits.length})",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  ...filteredAudits.map((audit) {
                    return Container(
                      margin: EdgeInsets.only(
                        left: spSm,
                        right: spSm,
                        bottom: spSm,
                      ),
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: disabledOutlineBorderColor,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Column(
                        spacing: spXs,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  "${audit["id"]}",
                                  style: TextStyle(
                                    fontSize: fsH6,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: spXs,
                                  vertical: 2,
                                ),
                                decoration: BoxDecoration(
                                  color: getStatusColor(audit["status"]).withAlpha(20),
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: Text(
                                  "${audit["status"]}",
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w600,
                                    color: getStatusColor(audit["status"]),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Text(
                            "${audit["title"]}",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: primaryColor,
                            ),
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.location_on,
                                size: 14,
                                color: disabledBoldColor,
                              ),
                              SizedBox(width: spXs),
                              Text(
                                "${audit["location"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                              SizedBox(width: spSm),
                              Icon(
                                Icons.person,
                                size: 14,
                                color: disabledBoldColor,
                              ),
                              SizedBox(width: spXs),
                              Text(
                                "${audit["auditedBy"]}",
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
                                "Scheduled: ${DateTime.parse(audit["scheduledDate"]).dMMMy}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                              if (audit["actualDate"].toString().isNotEmpty) ...[
                                SizedBox(width: spSm),
                                Text(
                                  "Actual: ${DateTime.parse(audit["actualDate"]).dMMMy}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ],
                          ),
                          if ((audit["itemsAudited"] as num) > 0)
                            Row(
                              children: [
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: spXs,
                                    vertical: 2,
                                  ),
                                  decoration: BoxDecoration(
                                    color: infoColor.withAlpha(20),
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                  child: Text(
                                    "${audit["itemsAudited"]} items audited",
                                    style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w600,
                                      color: infoColor,
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
                                    color: warningColor.withAlpha(20),
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                  child: Text(
                                    "${audit["discrepancies"]} discrepancies",
                                    style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w600,
                                      color: warningColor,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          if ((audit["accuracy"] as num) > 0)
                            Row(
                              children: [
                                Text(
                                  "Accuracy: ${(audit["accuracy"] as num).toStringAsFixed(1)}%",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: getAccuracyColor((audit["accuracy"] as num).toDouble()),
                                  ),
                                ),
                                SizedBox(width: spSm),
                                Text(
                                  "Adjustment: ${(audit["adjustmentValue"] as num) >= 0 ? '+' : ''}\$${((audit["adjustmentValue"] as num).toDouble()).currency}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: (audit["adjustmentValue"] as num) >= 0 ? successColor : dangerColor,
                                  ),
                                ),
                              ],
                            ),
                          if (audit["notes"].toString().isNotEmpty)
                            Container(
                              width: double.infinity,
                              padding: EdgeInsets.all(spXs),
                              decoration: BoxDecoration(
                                color: disabledColor.withAlpha(30),
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Text(
                                "${audit["notes"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                            ),
                          Row(
                            children: [
                              Spacer(),
                              Row(
                                children: [
                                  QButton(
                                    icon: Icons.visibility,
                                    size: bs.sm,
                                    onPressed: () {
                                      //navigateTo('InventoryAuditDetailView')
                                    },
                                  ),
                                  SizedBox(width: spXs),
                                  QButton(
                                    icon: Icons.edit,
                                    size: bs.sm,
                                    onPressed: () {
                                      //navigateTo('EditInventoryAuditView')
                                    },
                                  ),
                                  SizedBox(width: spXs),
                                  QButton(
                                    icon: Icons.print,
                                    size: bs.sm,
                                    onPressed: () {
                                      //navigateTo('PrintAuditReportView')
                                    },
                                  ),
                                ],
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
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          //navigateTo('CreateInventoryAuditView')
        },
        backgroundColor: primaryColor,
        child: Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
