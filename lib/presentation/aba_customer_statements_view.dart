import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class AbaCustomerStatementsView extends StatefulWidget {
  const AbaCustomerStatementsView({super.key});

  @override
  State<AbaCustomerStatementsView> createState() => _AbaCustomerStatementsViewState();
}

class _AbaCustomerStatementsViewState extends State<AbaCustomerStatementsView> {
  String searchQuery = "";
  String selectedCustomer = "all";
  String selectedPeriod = "monthly";
  DateTime? fromDate;
  DateTime? toDate;
  bool loading = false;

  List<Map<String, dynamic>> customerOptions = [
    {"label": "All Customers", "value": "all"},
    {"label": "John Smith", "value": "john_smith"},
    {"label": "Sarah Johnson", "value": "sarah_johnson"},
    {"label": "Michael Brown", "value": "michael_brown"},
    {"label": "Emily Davis", "value": "emily_davis"},
  ];

  List<Map<String, dynamic>> periodOptions = [
    {"label": "Monthly", "value": "monthly"},
    {"label": "Quarterly", "value": "quarterly"},
    {"label": "Yearly", "value": "yearly"},
    {"label": "Custom Range", "value": "custom"},
  ];

  List<Map<String, dynamic>> statements = [
    {
      "id": "STMT-001",
      "customer_name": "John Smith",
      "customer_id": "CUST-001",
      "statement_date": "2024-06-01",
      "period": "May 2024",
      "opening_balance": 2500.00,
      "closing_balance": 1750.00,
      "total_charges": 850.00,
      "total_payments": 1600.00,
      "status": "sent",
      "due_date": "2024-06-30",
      "transaction_count": 12,
    },
    {
      "id": "STMT-002",
      "customer_name": "Sarah Johnson",
      "customer_id": "CUST-002",
      "statement_date": "2024-06-01",
      "period": "May 2024",
      "opening_balance": 1200.00,
      "closing_balance": 890.50,
      "total_charges": 450.50,
      "total_payments": 760.00,
      "status": "draft",
      "due_date": "2024-06-30",
      "transaction_count": 8,
    },
    {
      "id": "STMT-003",
      "customer_name": "Michael Brown",
      "customer_id": "CUST-003",
      "statement_date": "2024-06-01",
      "period": "May 2024",
      "opening_balance": 3400.75,
      "closing_balance": 2100.75,
      "total_charges": 1800.00,
      "total_payments": 3100.00,
      "status": "sent",
      "due_date": "2024-06-30",
      "transaction_count": 15,
    },
    {
      "id": "STMT-004",
      "customer_name": "Emily Davis",
      "customer_id": "CUST-004",
      "statement_date": "2024-06-01",
      "period": "May 2024",
      "opening_balance": 780.00,
      "closing_balance": 450.00,
      "total_charges": 320.00,
      "total_payments": 650.00,
      "status": "viewed",
      "due_date": "2024-06-30",
      "transaction_count": 6,
    },
    {
      "id": "STMT-005",
      "customer_name": "David Wilson",
      "customer_id": "CUST-005",
      "statement_date": "2024-05-01",
      "period": "April 2024",
      "opening_balance": 1800.25,
      "closing_balance": 2280.25,
      "total_charges": 950.00,
      "total_payments": 470.00,
      "status": "overdue",
      "due_date": "2024-05-31",
      "transaction_count": 10,
    },
  ];

  List<Map<String, dynamic>> get filteredStatements {
    return statements.where((statement) {
      final matchesSearch = statement["customer_name"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
          statement["id"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
          statement["period"].toString().toLowerCase().contains(searchQuery.toLowerCase());
      
      final matchesCustomer = selectedCustomer == "all" || 
          statement["customer_name"].toString().toLowerCase().contains(selectedCustomer.replaceAll("_", " "));
      
      return matchesSearch && matchesCustomer;
    }).toList();
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'sent':
        return successColor;
      case 'viewed':
        return infoColor;
      case 'draft':
        return warningColor;
      case 'overdue':
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  void _generateStatement() async {
    loading = true;
    setState(() {});
    
    await Future.delayed(Duration(seconds: 2));
    
    loading = false;
    setState(() {});
    
    ss("Statement generated successfully");
  }

  void _sendStatement(Map<String, dynamic> statement) async {
    bool isConfirmed = await confirm("Send statement to ${statement["customer_name"]}?");
    if (!isConfirmed) return;

    loading = true;
    setState(() {});
    
    await Future.delayed(Duration(seconds: 2));
    
    loading = false;
    setState(() {});
    
    ss("Statement sent successfully");
  }

  void _downloadStatement(Map<String, dynamic> statement) async {
    loading = true;
    setState(() {});
    
    await Future.delayed(Duration(seconds: 1));
    
    loading = false;
    setState(() {});
    
    ss("Statement downloaded");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Customer Statements"),
        actions: [
          IconButton(
            onPressed: _generateStatement,
            icon: Icon(Icons.add),
          ),
        ],
      ),
      body: loading ? 
        Center(child: CircularProgressIndicator()) :
        SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: Column(
            spacing: spMd,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
                          Text(
                            "Total Outstanding",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "\$${((statements.fold(0.0, (sum, stmt) => sum + (stmt["closing_balance"] as double)))).currency}",
                            style: TextStyle(
                              fontSize: fsH5,
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
                          Text(
                            "Overdue",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "${statements.where((s) => s["status"] == "overdue").length}",
                            style: TextStyle(
                              fontSize: fsH5,
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

              // Search and Filters
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
                            label: "Search statements...",
                            value: searchQuery,
                            hint: "Customer name, statement ID, or period",
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
                            label: "Customer",
                            items: customerOptions,
                            value: selectedCustomer,
                            onChanged: (value, label) {
                              selectedCustomer = value;
                              setState(() {});
                            },
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: QDropdownField(
                            label: "Period",
                            items: periodOptions,
                            value: selectedPeriod,
                            onChanged: (value, label) {
                              selectedPeriod = value;
                              setState(() {});
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Statements List
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
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Statement Records",
                            style: TextStyle(
                              fontSize: fsH6,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          Text(
                            "${filteredStatements.length} statements",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Divider(height: 1),
                    ...List.generate(filteredStatements.length, (index) {
                      final statement = filteredStatements[index];
                      return Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: index < filteredStatements.length - 1 
                                ? disabledOutlineBorderColor 
                                : Colors.transparent,
                              width: 1,
                            ),
                          ),
                        ),
                        child: Column(
                          spacing: spXs,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "${statement["customer_name"]}",
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                          color: primaryColor,
                                        ),
                                      ),
                                      Text(
                                        "${statement["id"]} • ${statement["period"]}",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 4),
                                  decoration: BoxDecoration(
                                    color: _getStatusColor("${statement["status"]}").withAlpha(20),
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                  child: Text(
                                    "${statement["status"]}".toUpperCase(),
                                    style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                      color: _getStatusColor("${statement["status"]}"),
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
                                    children: [
                                      Text(
                                        "Opening Balance",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                      Text(
                                        "\$${(statement["opening_balance"] as double).currency}",
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
                                        "Closing Balance",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                      Text(
                                        "\$${(statement["closing_balance"] as double).currency}",
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
                            Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Total Charges",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                      Text(
                                        "\$${(statement["total_charges"] as double).currency}",
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          color: dangerColor,
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
                                        "Total Payments",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                      Text(
                                        "\$${(statement["total_payments"] as double).currency}",
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          color: successColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "${statement["transaction_count"]} transactions",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                Text(
                                  "Due: ${statement["due_date"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: statement["status"] == "overdue" ? dangerColor : disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                QButton(
                                  label: "Download",
                                  size: bs.sm,
                                  onPressed: () => _downloadStatement(statement),
                                ),
                                SizedBox(width: spXs),
                                if (statement["status"] != "sent")
                                  QButton(
                                    label: "Send",
                                    size: bs.sm,
                                    onPressed: () => _sendStatement(statement),
                                  ),
                              ],
                            ),
                          ],
                        ),
                      );
                    }),
                  ],
                ),
              ),
            ],
          ),
        ),
    );
  }
}
