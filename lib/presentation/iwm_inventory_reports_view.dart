import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class IwmInventoryReportsView extends StatefulWidget {
  const IwmInventoryReportsView({super.key});

  @override
  State<IwmInventoryReportsView> createState() => _IwmInventoryReportsViewState();
}

class _IwmInventoryReportsViewState extends State<IwmInventoryReportsView> {
  String selectedReportType = "Stock Level Report";
  String selectedPeriod = "This Month";
  String selectedFormat = "PDF";
  String selectedCategory = "All Categories";
  bool loading = false;

  List<Map<String, dynamic>> reportTypes = [
    {"label": "Stock Level Report", "value": "Stock Level Report"},
    {"label": "Inventory Valuation", "value": "Inventory Valuation"},
    {"label": "Movement Report", "value": "Movement Report"},
    {"label": "ABC Analysis", "value": "ABC Analysis"},
    {"label": "Aging Report", "value": "Aging Report"},
    {"label": "Reorder Report", "value": "Reorder Report"},
  ];

  List<Map<String, dynamic>> periodItems = [
    {"label": "Today", "value": "Today"},
    {"label": "This Week", "value": "This Week"},
    {"label": "This Month", "value": "This Month"},
    {"label": "This Quarter", "value": "This Quarter"},
    {"label": "This Year", "value": "This Year"},
    {"label": "Custom Range", "value": "Custom Range"},
  ];

  List<Map<String, dynamic>> formatItems = [
    {"label": "PDF", "value": "PDF"},
    {"label": "Excel", "value": "Excel"},
    {"label": "CSV", "value": "CSV"},
  ];

  List<Map<String, dynamic>> categoryItems = [
    {"label": "All Categories", "value": "All Categories"},
    {"label": "Electronics", "value": "Electronics"},
    {"label": "Raw Materials", "value": "Raw Materials"},
    {"label": "Components", "value": "Components"},
    {"label": "Tools", "value": "Tools"},
    {"label": "Supplies", "value": "Supplies"},
  ];

  List<Map<String, dynamic>> recentReports = [
    {
      "id": "RPT001",
      "name": "Monthly Stock Report - May 2024",
      "type": "Stock Level Report",
      "generatedBy": "Sarah Johnson",
      "generatedDate": "2024-06-01",
      "size": "2.5 MB",
      "format": "PDF",
      "status": "Completed",
      "records": 1234,
    },
    {
      "id": "RPT002",
      "name": "Q2 Inventory Valuation",
      "type": "Inventory Valuation",
      "generatedBy": "Mike Wilson",
      "generatedDate": "2024-05-31",
      "size": "1.8 MB",
      "format": "Excel",
      "status": "Completed",
      "records": 856,
    },
    {
      "id": "RPT003",
      "name": "Weekly Movement Analysis",
      "type": "Movement Report",
      "generatedBy": "Alex Chen",
      "generatedDate": "2024-06-19",
      "size": "3.2 MB",
      "format": "PDF",
      "status": "Processing",
      "records": 2145,
    },
    {
      "id": "RPT004",
      "name": "ABC Classification Report",
      "type": "ABC Analysis",
      "generatedBy": "Emma Davis",
      "generatedDate": "2024-06-18",
      "size": "1.2 MB",
      "format": "CSV",
      "status": "Completed",
      "records": 567,
    },
    {
      "id": "RPT005",
      "name": "Reorder Point Analysis",
      "type": "Reorder Report",
      "generatedBy": "Dr. Robert Kim",
      "generatedDate": "2024-06-17",
      "size": "0.9 MB",
      "format": "Excel",
      "status": "Failed",
      "records": 234,
    },
  ];

  List<Map<String, dynamic>> scheduledReports = [
    {
      "id": "SCH001",
      "name": "Daily Stock Level Report",
      "type": "Stock Level Report",
      "frequency": "Daily",
      "nextRun": "2024-06-20 08:00",
      "recipients": ["manager@company.com", "inventory@company.com"],
      "format": "PDF",
      "isActive": true,
    },
    {
      "id": "SCH002",
      "name": "Weekly Movement Summary",
      "type": "Movement Report",
      "frequency": "Weekly",
      "nextRun": "2024-06-24 09:00",
      "recipients": ["operations@company.com"],
      "format": "Excel",
      "isActive": true,
    },
    {
      "id": "SCH003",
      "name": "Monthly Valuation Report",
      "type": "Inventory Valuation",
      "frequency": "Monthly",
      "nextRun": "2024-07-01 10:00",
      "recipients": ["finance@company.com", "cfo@company.com"],
      "format": "PDF",
      "isActive": false,
    },
  ];

  Widget _buildReportCard(Map<String, dynamic> report) {
    Color statusColor = report["status"] == "Completed" 
        ? successColor 
        : report["status"] == "Processing"
            ? warningColor
            : dangerColor;

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
            color: statusColor,
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
                      "${report["name"]}",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "${report["id"]} • ${report["type"]}",
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
                  "${report["status"]}",
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
                "Generated by ${report["generatedBy"]}",
                style: TextStyle(
                  fontSize: 13,
                  color: disabledBoldColor,
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
                "${report["generatedDate"]}",
                style: TextStyle(
                  fontSize: 13,
                  color: disabledBoldColor,
                ),
              ),
              Spacer(),
              Icon(Icons.description, size: 16, color: disabledBoldColor),
              SizedBox(width: spXs),
              Text(
                "${report["format"]}",
                style: TextStyle(
                  fontSize: 13,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              Text(
                "Records: ${report["records"]}",
                style: TextStyle(
                  fontSize: 13,
                  color: disabledBoldColor,
                ),
              ),
              Spacer(),
              Text(
                "Size: ${report["size"]}",
                style: TextStyle(
                  fontSize: 13,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              if (report["status"] == "Completed") ...[
                Expanded(
                  child: QButton(
                    label: "Download",
                    size: bs.sm,
                    onPressed: () {},
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QButton(
                    label: "View",
                    size: bs.sm,
                    onPressed: () {},
                  ),
                ),
              ] else if (report["status"] == "Processing") ...[
                Expanded(
                  child: QButton(
                    label: "Cancel",
                    size: bs.sm,
                    onPressed: () {},
                  ),
                ),
              ] else ...[
                Expanded(
                  child: QButton(
                    label: "Retry",
                    size: bs.sm,
                    onPressed: () {},
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QButton(
                    label: "Delete",
                    size: bs.sm,
                    onPressed: () {},
                  ),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildScheduledReportCard(Map<String, dynamic> report) {
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
            color: report["isActive"] ? successColor : disabledBoldColor,
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
                      "${report["name"]}",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "${report["id"]} • ${report["frequency"]}",
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
                  color: report["isActive"] 
                      ? successColor.withAlpha(25)
                      : disabledBoldColor.withAlpha(25),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Text(
                  report["isActive"] ? "Active" : "Inactive",
                  style: TextStyle(
                    fontSize: 12,
                    color: report["isActive"] ? successColor : disabledBoldColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              Icon(Icons.schedule, size: 16, color: disabledBoldColor),
              SizedBox(width: spXs),
              Text(
                "Next run: ${report["nextRun"]}",
                style: TextStyle(
                  fontSize: 13,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              Icon(Icons.email, size: 16, color: disabledBoldColor),
              SizedBox(width: spXs),
              Expanded(
                child: Text(
                  "${(report["recipients"] as List).length} recipients",
                  style: TextStyle(
                    fontSize: 13,
                    color: disabledBoldColor,
                  ),
                ),
              ),
              Text(
                "${report["format"]}",
                style: TextStyle(
                  fontSize: 13,
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
                  label: "Edit",
                  size: bs.sm,
                  onPressed: () {},
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QButton(
                  label: report["isActive"] ? "Disable" : "Enable",
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
        title: Text("Inventory Reports"),
        actions: [
          IconButton(
            icon: Icon(Icons.schedule),
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
                  // Generate Report Section
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
                          "Generate New Report",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        SizedBox(height: spSm),
                        QDropdownField(
                          label: "Report Type",
                          items: reportTypes,
                          value: selectedReportType,
                          onChanged: (value, label) {
                            selectedReportType = value;
                            setState(() {});
                          },
                        ),
                        SizedBox(height: spSm),
                        Row(
                          children: [
                            Expanded(
                              child: QDropdownField(
                                label: "Period",
                                items: periodItems,
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
                                label: "Format",
                                items: formatItems,
                                value: selectedFormat,
                                onChanged: (value, label) {
                                  selectedFormat = value;
                                  setState(() {});
                                },
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: spSm),
                        QDropdownField(
                          label: "Category Filter",
                          items: categoryItems,
                          value: selectedCategory,
                          onChanged: (value, label) {
                            selectedCategory = value;
                            setState(() {});
                          },
                        ),
                        SizedBox(height: spSm),
                        Container(
                          width: double.infinity,
                          child: QButton(
                            label: "Generate Report",
                            size: bs.md,
                            onPressed: () {
                              ss("Report generation started");
                            },
                          ),
                        ),
                      ],
                    ),
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
                                  "Total Reports",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: spSm),
                            Text(
                              "${recentReports.length}",
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
                                  "Completed",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: spSm),
                            Text(
                              "${recentReports.where((r) => r["status"] == "Completed").length}",
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
                          color: warningColor.withAlpha(25),
                          borderRadius: BorderRadius.circular(radiusMd),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(Icons.schedule, color: warningColor),
                                SizedBox(width: spSm),
                                Text(
                                  "Scheduled",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: spSm),
                            Text(
                              "${scheduledReports.where((r) => r["isActive"]).length}",
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
                          color: infoColor.withAlpha(25),
                          borderRadius: BorderRadius.circular(radiusMd),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(Icons.storage, color: infoColor),
                                SizedBox(width: spSm),
                                Text(
                                  "Total Size",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: spSm),
                            Text(
                              "9.6 MB",
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

                  // Recent Reports
                  Container(
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              "Recent Reports",
                              style: TextStyle(
                                fontSize: fsH6,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            Spacer(),
                            QButton(
                              label: "View All",
                              size: bs.sm,
                              onPressed: () {},
                            ),
                          ],
                        ),
                        SizedBox(height: spSm),
                        ...recentReports.map((report) => _buildReportCard(report)),
                      ],
                    ),
                  ),

                  // Scheduled Reports
                  Container(
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              "Scheduled Reports",
                              style: TextStyle(
                                fontSize: fsH6,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            Spacer(),
                            QButton(
                              label: "Add Schedule",
                              size: bs.sm,
                              onPressed: () {},
                            ),
                          ],
                        ),
                        SizedBox(height: spSm),
                        ...scheduledReports.map((report) => _buildScheduledReportCard(report)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
