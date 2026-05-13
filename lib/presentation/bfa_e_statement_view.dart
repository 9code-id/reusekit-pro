import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class BfaEStatementView extends StatefulWidget {
  const BfaEStatementView({super.key});

  @override
  State<BfaEStatementView> createState() => _BfaEStatementViewState();
}

class _BfaEStatementViewState extends State<BfaEStatementView> {
  String selectedAccount = "****5678";
  String selectedFormat = "PDF";
  String selectedPeriod = "monthly";
  String fromDate = "2024-01-01";
  String toDate = "2024-12-31";
  String emailAddress = "john.doe@email.com";
  bool emailDelivery = true;
  bool includeSummary = true;
  bool includeImages = false;

  // Sample account options
  List<Map<String, dynamic>> accountItems = [
    {"label": "Savings Account (****5678)", "value": "****5678"},
    {"label": "Current Account (****9012)", "value": "****9012"},
    {"label": "Credit Card (****3456)", "value": "****3456"},
  ];

  // Sample format options
  List<Map<String, dynamic>> formatItems = [
    {"label": "PDF Document", "value": "PDF"},
    {"label": "Excel Spreadsheet", "value": "Excel"},
    {"label": "CSV File", "value": "CSV"},
  ];

  // Sample period options
  List<Map<String, dynamic>> periodItems = [
    {"label": "Last Month", "value": "last_month"},
    {"label": "Last 3 Months", "value": "last_3_months"},
    {"label": "Last 6 Months", "value": "last_6_months"},
    {"label": "Custom Date Range", "value": "custom"},
    {"label": "Monthly Statement", "value": "monthly"},
    {"label": "Quarterly Statement", "value": "quarterly"},
    {"label": "Annual Statement", "value": "annual"},
  ];

  // Sample previous statements
  List<Map<String, dynamic>> previousStatements = [
    {
      "id": "STMT001",
      "account": "****5678",
      "period": "November 2024",
      "format": "PDF",
      "size": "2.5 MB",
      "date": "2024-12-01T00:00:00Z",
      "status": "Ready"
    },
    {
      "id": "STMT002",
      "account": "****5678",
      "period": "October 2024",
      "format": "PDF",
      "size": "3.1 MB",
      "date": "2024-11-01T00:00:00Z",
      "status": "Ready"
    },
    {
      "id": "STMT003",
      "account": "****9012",
      "period": "September 2024",
      "format": "Excel",
      "size": "1.8 MB",
      "date": "2024-10-01T00:00:00Z",
      "status": "Ready"
    },
  ];

  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("E-Statement"),
        actions: [
          IconButton(
            icon: Icon(Icons.history),
            onPressed: () {
              // Show statement history
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            // Header Info Card
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spLg),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [infoColor, infoColor.withAlpha(150)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(radiusLg),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.description,
                        color: Colors.white,
                        size: 32,
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Electronic Statement",
                              style: TextStyle(
                                fontSize: fsH5,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(height: spXs),
                            Text(
                              "Request and download your account statements in various formats",
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.white.withAlpha(200),
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

            // Statement Request Form
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spLg),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spSm,
                children: [
                  Text(
                    "Request New Statement",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),

                  QDropdownField(
                    label: "Select Account",
                    items: accountItems,
                    value: selectedAccount,
                    onChanged: (value, label) {
                      selectedAccount = value;
                      setState(() {});
                    },
                  ),

                  QDropdownField(
                    label: "Statement Period",
                    items: periodItems,
                    value: selectedPeriod,
                    onChanged: (value, label) {
                      selectedPeriod = value;
                      setState(() {});
                    },
                  ),

                  if (selectedPeriod == "custom") ...[
                    Row(
                      spacing: spSm,
                      children: [
                        Expanded(
                          child: QDatePicker(
                            label: "From Date",
                            value: DateTime.parse(fromDate),
                            onChanged: (value) {
                              fromDate = value.toIso8601String().split('T')[0];
                              setState(() {});
                            },
                          ),
                        ),
                        Expanded(
                          child: QDatePicker(
                            label: "To Date",
                            value: DateTime.parse(toDate),
                            onChanged: (value) {
                              toDate = value.toIso8601String().split('T')[0];
                              setState(() {});
                            },
                          ),
                        ),
                      ],
                    ),
                  ],

                  QDropdownField(
                    label: "File Format",
                    items: formatItems,
                    value: selectedFormat,
                    onChanged: (value, label) {
                      selectedFormat = value;
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),

            // Email Delivery Options
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spLg),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spSm,
                children: [
                  Text(
                    "Delivery Options",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),

                  Row(
                    children: [
                      Expanded(
                        child: QSwitch(
                          items: [
                            {
                              "label": "Email Delivery",
                              "value": true,
                              "checked": emailDelivery,
                            }
                          ],
                          value: [
                            if (emailDelivery)
                              {
                                "label": "Email Delivery",
                                "value": true,
                                "checked": true
                              }
                          ],
                          onChanged: (values, ids) {
                            emailDelivery = values.isNotEmpty;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),

                  if (emailDelivery) ...[
                    QTextField(
                      label: "Email Address",
                      value: emailAddress,
                      hint: "Enter your email address",
                      onChanged: (value) {
                        emailAddress = value;
                        setState(() {});
                      },
                    ),
                  ],
                ],
              ),
            ),

            // Statement Options
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spLg),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spSm,
                children: [
                  Text(
                    "Statement Options",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),

                  Row(
                    children: [
                      Expanded(
                        child: QSwitch(
                          items: [
                            {
                              "label": "Include Summary",
                              "value": true,
                              "checked": includeSummary,
                            }
                          ],
                          value: [
                            if (includeSummary)
                              {
                                "label": "Include Summary",
                                "value": true,
                                "checked": true
                              }
                          ],
                          onChanged: (values, ids) {
                            includeSummary = values.isNotEmpty;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),

                  Row(
                    children: [
                      Expanded(
                        child: QSwitch(
                          items: [
                            {
                              "label": "Include Transaction Images",
                              "value": true,
                              "checked": includeImages,
                            }
                          ],
                          value: [
                            if (includeImages)
                              {
                                "label": "Include Transaction Images",
                                "value": true,
                                "checked": true
                              }
                          ],
                          onChanged: (values, ids) {
                            includeImages = values.isNotEmpty;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Request Button
            Container(
              width: double.infinity,
              child: QButton(
                label: loading ? "Processing..." : "Request Statement",
                icon: Icons.download,
                size: bs.md,
                onPressed: loading ? null : () async {
                  loading = true;
                  setState(() {});
                  
                  // Simulate processing
                  await Future.delayed(Duration(seconds: 2));
                  
                  loading = false;
                  setState(() {});
                  
                  ss("Statement request submitted successfully");
                },
              ),
            ),

            // Previous Statements
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.all(spLg),
                    child: Text(
                      "Previous Statements",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                  ),

                  ...List.generate(previousStatements.length, (index) {
                    final statement = previousStatements[index];
                    return _buildStatementItem(statement, index == previousStatements.length - 1);
                  }),
                ],
              ),
            ),

            // Info Card
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spLg),
              decoration: BoxDecoration(
                color: Colors.blue[50],
                borderRadius: BorderRadius.circular(radiusLg),
                border: Border.all(color: infoColor.withAlpha(50)),
              ),
              child: Column(
                children: [
                  Icon(
                    Icons.info_outline,
                    color: infoColor,
                    size: 32,
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "Statement Information",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spXs),
                  Text(
                    "• Statements are generated within 24 hours\n• Email delivery is secure and encrypted\n• Statements are available for download for 30 days\n• No charges for electronic statements",
                    style: TextStyle(
                      fontSize: 14,
                      color: disabledBoldColor,
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatementItem(Map<String, dynamic> statement, bool isLast) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: spLg, vertical: spSm),
      decoration: BoxDecoration(
        border: isLast ? null : Border(
          bottom: BorderSide(
            color: disabledOutlineBorderColor,
            width: 1,
          ),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: successColor.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Icon(
              Icons.description,
              color: successColor,
              size: 20,
            ),
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${statement["account"]} - ${statement["period"]}",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spXs),
                Row(
                  children: [
                    Text(
                      "${statement["format"]} • ${statement["size"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(width: spSm),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                      decoration: BoxDecoration(
                        color: successColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Text(
                        "${statement["status"]}",
                        style: TextStyle(
                          fontSize: 10,
                          color: successColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Row(
            children: [
              GestureDetector(
                onTap: () {
                  ss("Statement downloaded");
                },
                child: Container(
                  padding: EdgeInsets.all(spXs),
                  decoration: BoxDecoration(
                    color: primaryColor.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusXs),
                  ),
                  child: Icon(
                    Icons.download,
                    color: primaryColor,
                    size: 16,
                  ),
                ),
              ),
              SizedBox(width: spXs),
              GestureDetector(
                onTap: () {
                  ss("Statement shared");
                },
                child: Container(
                  padding: EdgeInsets.all(spXs),
                  decoration: BoxDecoration(
                    color: infoColor.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusXs),
                  ),
                  child: Icon(
                    Icons.share,
                    color: infoColor,
                    size: 16,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
