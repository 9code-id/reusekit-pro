import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class AbaTaxFilingView extends StatefulWidget {
  const AbaTaxFilingView({super.key});

  @override
  State<AbaTaxFilingView> createState() => _AbaTaxFilingViewState();
}

class _AbaTaxFilingViewState extends State<AbaTaxFilingView> {
  String selectedForm = "form_941";
  String selectedPeriod = "q1_2024";
  String selectedStatus = "all";
  String searchQuery = "";
  
  List<Map<String, dynamic>> formTypes = [
    {"label": "Form 941 - Quarterly Federal Tax Return", "value": "form_941"},
    {"label": "Form 940 - Annual Federal Unemployment Tax", "value": "form_940"},
    {"label": "Form W-2 - Wage and Tax Statement", "value": "form_w2"},
    {"label": "Form 1099 - Miscellaneous Income", "value": "form_1099"},
    {"label": "State Tax Return", "value": "state_return"},
    {"label": "Local Tax Return", "value": "local_return"},
  ];

  List<Map<String, dynamic>> filingPeriods = [
    {"label": "Q1 2024", "value": "q1_2024"},
    {"label": "Q4 2023", "value": "q4_2023"},
    {"label": "Q3 2023", "value": "q3_2023"},
    {"label": "Q2 2023", "value": "q2_2023"},
    {"label": "Annual 2023", "value": "annual_2023"},
  ];

  List<Map<String, dynamic>> statusOptions = [
    {"label": "All Status", "value": "all"},
    {"label": "Draft", "value": "draft"},
    {"label": "Ready to File", "value": "ready"},
    {"label": "Filed", "value": "filed"},
    {"label": "Accepted", "value": "accepted"},
    {"label": "Rejected", "value": "rejected"},
  ];

  List<Map<String, dynamic>> filingStats = [
    {
      "title": "Total Filings",
      "count": 45,
      "icon": Icons.description,
      "color": primaryColor,
    },
    {
      "title": "Filed This Month",
      "count": 12,
      "icon": Icons.file_upload,
      "color": successColor,
    },
    {
      "title": "Pending Review",
      "count": 8,
      "icon": Icons.pending,
      "color": warningColor,
    },
    {
      "title": "Rejected",
      "count": 2,
      "icon": Icons.error,
      "color": dangerColor,
    },
  ];

  List<Map<String, dynamic>> taxForms = [
    {
      "id": "TF001",
      "formType": "Form 941",
      "description": "Quarterly Federal Tax Return - Q1 2024",
      "period": "Q1 2024",
      "dueDate": "2024-04-30",
      "amount": 15600.00,
      "status": "ready",
      "filedDate": null,
      "preparedBy": "Sarah Johnson",
      "lastModified": "2024-03-20",
      "attachments": 3,
    },
    {
      "id": "TF002",
      "formType": "Form 940",
      "description": "Annual Federal Unemployment Tax - 2023",
      "period": "Annual 2023",
      "dueDate": "2024-01-31",
      "amount": 2850.00,
      "status": "filed",
      "filedDate": "2024-01-28",
      "preparedBy": "Mike Davis",
      "lastModified": "2024-01-28",
      "attachments": 5,
    },
    {
      "id": "TF003",
      "formType": "State Tax Return",
      "description": "Quarterly State Tax Filing - Q1 2024",
      "period": "Q1 2024",
      "dueDate": "2024-05-01",
      "amount": 9800.00,
      "status": "draft",
      "filedDate": null,
      "preparedBy": "Emily Wilson",
      "lastModified": "2024-03-18",
      "attachments": 2,
    },
    {
      "id": "TF004",
      "formType": "Form W-2",
      "description": "Wage and Tax Statement - 2023",
      "period": "Annual 2023",
      "dueDate": "2024-01-31",
      "amount": 0.00,
      "status": "accepted",
      "filedDate": "2024-01-15",
      "preparedBy": "David Brown",
      "lastModified": "2024-01-15",
      "attachments": 125,
    },
    {
      "id": "TF005",
      "formType": "Local Tax Return",
      "description": "Monthly Local Tax Filing - March 2024",
      "period": "March 2024",
      "dueDate": "2024-04-15",
      "amount": 1200.00,
      "status": "rejected",
      "filedDate": "2024-04-10",
      "preparedBy": "Lisa Anderson",
      "lastModified": "2024-04-12",
      "attachments": 1,
    },
    {
      "id": "TF006",
      "formType": "Form 1099",
      "description": "Miscellaneous Income - 2023",
      "period": "Annual 2023",
      "dueDate": "2024-01-31",
      "amount": 0.00,
      "status": "filed",
      "filedDate": "2024-01-20",
      "preparedBy": "John Smith",
      "lastModified": "2024-01-20",
      "attachments": 8,
    },
  ];

  Color _getStatusColor(String status) {
    switch (status) {
      case "draft":
        return disabledBoldColor;
      case "ready":
        return primaryColor;
      case "filed":
        return infoColor;
      case "accepted":
        return successColor;
      case "rejected":
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  String _getStatusLabel(String status) {
    switch (status) {
      case "draft":
        return "Draft";
      case "ready":
        return "Ready to File";
      case "filed":
        return "Filed";
      case "accepted":
        return "Accepted";
      case "rejected":
        return "Rejected";
      default:
        return "Unknown";
    }
  }

  IconData _getStatusIcon(String status) {
    switch (status) {
      case "draft":
        return Icons.edit;
      case "ready":
        return Icons.check_circle;
      case "filed":
        return Icons.file_upload;
      case "accepted":
        return Icons.verified;
      case "rejected":
        return Icons.error;
      default:
        return Icons.help;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tax Filing"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.upload_file),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: spMd,
          children: [
            // Filters Section
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spSm,
                children: [
                  Text(
                    "Filing Filters",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: QDropdownField(
                          label: "Form Type",
                          items: formTypes,
                          value: selectedForm,
                          onChanged: (value, label) {
                            selectedForm = value;
                            setState(() {});
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QDropdownField(
                          label: "Period",
                          items: filingPeriods,
                          value: selectedPeriod,
                          onChanged: (value, label) {
                            selectedPeriod = value;
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
                        child: QTextField(
                          label: "Search Forms",
                          value: searchQuery,
                          hint: "Form ID or description",
                          onChanged: (value) {
                            searchQuery = value;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Filing Statistics
            Text(
              "Filing Statistics",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            ResponsiveGridView(
              padding: EdgeInsets.zero,
              minItemWidth: 200,
              children: filingStats.map((stat) {
                return Container(
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
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
                              color: (stat["color"] as Color).withAlpha(26),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Icon(
                              stat["icon"] as IconData,
                              color: stat["color"] as Color,
                              size: 24,
                            ),
                          ),
                          Spacer(),
                          Text(
                            "${stat["count"]}",
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: stat["color"] as Color,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        "${stat["title"]}",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),

            // Tax Forms List
            Text(
              "Tax Forms",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                children: taxForms.map((form) {
                  return Container(
                    padding: EdgeInsets.all(spMd),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: disabledOutlineBorderColor,
                          width: 1,
                        ),
                      ),
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
                                color: _getStatusColor(form["status"]).withAlpha(26),
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Icon(
                                _getStatusIcon(form["status"]),
                                color: _getStatusColor(form["status"]),
                                size: 20,
                              ),
                            ),
                            SizedBox(width: spSm),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                spacing: 4,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        "${form["formType"]}",
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: primaryColor,
                                        ),
                                      ),
                                      SizedBox(width: spXs),
                                      Text(
                                        "(${form["id"]})",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    "${form["description"]}",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: spSm,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: _getStatusColor(form["status"]).withAlpha(26),
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Text(
                                _getStatusLabel(form["status"]),
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: _getStatusColor(form["status"]),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                spacing: 4,
                                children: [
                                  Text(
                                    "Period",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                  Text(
                                    "${form["period"]}",
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
                                spacing: 4,
                                children: [
                                  Text(
                                    "Due Date",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                  Text(
                                    "${form["dueDate"]}",
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
                                spacing: 4,
                                children: [
                                  Text(
                                    "Amount",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                  Text(
                                    (form["amount"] as double) > 0 
                                        ? "\$${((form["amount"] as double)).currency}"
                                        : "N/A",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: (form["amount"] as double) > 0 ? successColor : disabledBoldColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.person,
                              size: 16,
                              color: disabledBoldColor,
                            ),
                            SizedBox(width: spXs),
                            Text(
                              "Prepared by ${form["preparedBy"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                            Spacer(),
                            if (form["attachments"] > 0) ...[
                              Icon(
                                Icons.attach_file,
                                size: 16,
                                color: disabledBoldColor,
                              ),
                              SizedBox(width: spXs),
                              Text(
                                "${form["attachments"]} attachments",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ],
                        ),
                        if (form["filedDate"] != null) ...[
                          Text(
                            "Filed on ${form["filedDate"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: successColor,
                            ),
                          ),
                        ],
                        Text(
                          "Last modified: ${form["lastModified"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledColor,
                          ),
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
                            if (form["status"] == "ready") ...[
                              Expanded(
                                child: QButton(
                                  label: "File Now",
                                  size: bs.sm,
                                  onPressed: () {},
                                ),
                              ),
                            ] else if (form["status"] == "draft") ...[
                              Expanded(
                                child: QButton(
                                  label: "Continue Editing",
                                  size: bs.sm,
                                  onPressed: () {},
                                ),
                              ),
                            ] else if (form["status"] == "rejected") ...[
                              Expanded(
                                child: QButton(
                                  label: "Fix & Refile",
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
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
