import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class AbaPaymentMatchingView extends StatefulWidget {
  const AbaPaymentMatchingView({super.key});

  @override
  State<AbaPaymentMatchingView> createState() => _AbaPaymentMatchingViewState();
}

class _AbaPaymentMatchingViewState extends State<AbaPaymentMatchingView> {
  String searchQuery = "";
  String selectedStatus = "all";
  String selectedType = "all";
  bool loading = false;
  int currentTab = 0;

  List<Map<String, dynamic>> statusOptions = [
    {"label": "All Status", "value": "all"},
    {"label": "Matched", "value": "matched"},
    {"label": "Unmatched", "value": "unmatched"},
    {"label": "Partially Matched", "value": "partially_matched"},
    {"label": "Under Review", "value": "under_review"},
    {"label": "Exception", "value": "exception"},
  ];

  List<Map<String, dynamic>> typeOptions = [
    {"label": "All Types", "value": "all"},
    {"label": "Bank Statement", "value": "bank_statement"},
    {"label": "Payment Record", "value": "payment_record"},
    {"label": "Invoice", "value": "invoice"},
    {"label": "Deposit", "value": "deposit"},
  ];

  List<Map<String, dynamic>> matchingItems = [
    {
      "id": "MATCH-001",
      "type": "bank_statement",
      "reference": "STMT-20240619-001",
      "amount": 1250.00,
      "date": "2024-06-19",
      "description": "Online Payment - John Smith",
      "status": "matched",
      "matched_payment_id": "PAY-001",
      "matched_invoice": "INV-2024-001",
      "customer_name": "John Smith",
      "confidence_score": 98,
      "match_type": "Automatic",
      "processed_by": "system",
    },
    {
      "id": "MATCH-002",
      "type": "payment_record",
      "reference": "PAY-002",
      "amount": 890.50,
      "date": "2024-06-19",
      "description": "Bank Transfer Payment",
      "status": "unmatched",
      "matched_payment_id": "",
      "matched_invoice": "",
      "customer_name": "Sarah Johnson",
      "confidence_score": 0,
      "match_type": "Pending",
      "processed_by": "",
      "suggested_matches": [
        {"invoice": "INV-2024-002", "amount": 890.50, "score": 85},
        {"invoice": "INV-2024-015", "amount": 895.00, "score": 72},
      ],
    },
    {
      "id": "MATCH-003",
      "type": "bank_statement",
      "reference": "STMT-20240618-002",
      "amount": 2100.75,
      "date": "2024-06-18",
      "description": "Wire Transfer - M Brown Corp",
      "status": "partially_matched",
      "matched_payment_id": "PAY-003",
      "matched_invoice": "INV-2024-003",
      "customer_name": "Michael Brown",
      "confidence_score": 75,
      "match_type": "Manual",
      "processed_by": "admin",
      "variance_amount": -50.25,
    },
    {
      "id": "MATCH-004",
      "type": "deposit",
      "reference": "DEP-001",
      "amount": 15750.50,
      "date": "2024-06-17",
      "description": "Batch Deposit - Multiple Payments",
      "status": "matched",
      "matched_payment_id": "BATCH-001",
      "matched_invoice": "Multiple",
      "customer_name": "Multiple Customers",
      "confidence_score": 100,
      "match_type": "Batch Processing",
      "processed_by": "system",
      "payment_count": 12,
    },
    {
      "id": "MATCH-005",
      "type": "bank_statement",
      "reference": "STMT-20240617-003",
      "amount": 450.00,
      "date": "2024-06-17",
      "description": "Card Payment - Unknown",
      "status": "exception",
      "matched_payment_id": "",
      "matched_invoice": "",
      "customer_name": "Unknown",
      "confidence_score": 0,
      "match_type": "Exception",
      "processed_by": "",
      "exception_reason": "Customer not found in system",
    },
  ];

  List<Map<String, dynamic>> get filteredItems {
    return matchingItems.where((item) {
      final matchesSearch = item["reference"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
          item["customer_name"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
          item["description"].toString().toLowerCase().contains(searchQuery.toLowerCase());
      
      final matchesStatus = selectedStatus == "all" || item["status"] == selectedStatus;
      final matchesType = selectedType == "all" || item["type"] == selectedType;
      
      return matchesSearch && matchesStatus && matchesType;
    }).toList();
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'matched':
        return successColor;
      case 'unmatched':
        return warningColor;
      case 'partially_matched':
        return infoColor;
      case 'under_review':
        return primaryColor;
      case 'exception':
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  IconData _getTypeIcon(String type) {
    switch (type.toLowerCase()) {
      case 'bank_statement':
        return Icons.account_balance;
      case 'payment_record':
        return Icons.payment;
      case 'invoice':
        return Icons.receipt;
      case 'deposit':
        return Icons.savings;
      default:
        return Icons.description;
    }
  }

  IconData _getStatusIcon(String status) {
    switch (status.toLowerCase()) {
      case 'matched':
        return Icons.check_circle;
      case 'unmatched':
        return Icons.help;
      case 'partially_matched':
        return Icons.incomplete_circle;
      case 'under_review':
        return Icons.visibility;
      case 'exception':
        return Icons.error;
      default:
        return Icons.help;
    }
  }

  void _manualMatch(Map<String, dynamic> item) async {
    bool isConfirmed = await confirm("Manually match ${item["reference"]}?");
    if (!isConfirmed) return;

    loading = true;
    setState(() {});
    
    await Future.delayed(Duration(seconds: 2));
    
    loading = false;
    setState(() {});
    
    ss("Manual match completed");
  }

  void _resolveException(Map<String, dynamic> item) async {
    bool isConfirmed = await confirm("Resolve exception for ${item["reference"]}?");
    if (!isConfirmed) return;

    loading = true;
    setState(() {});
    
    await Future.delayed(Duration(seconds: 2));
    
    loading = false;
    setState(() {});
    
    ss("Exception resolved");
  }

  void _unmatchPayment(Map<String, dynamic> item) async {
    bool isConfirmed = await confirm("Unmatch ${item["reference"]}?");
    if (!isConfirmed) return;

    loading = true;
    setState(() {});
    
    await Future.delayed(Duration(seconds: 2));
    
    loading = false;
    setState(() {});
    
    sw("Payment unmatched");
  }

  void _runAutoMatching() async {
    loading = true;
    setState(() {});
    
    await Future.delayed(Duration(seconds: 3));
    
    loading = false;
    setState(() {});
    
    ss("Auto-matching completed");
  }

  Widget _buildMatchingTab() {
    final matchedCount = matchingItems.where((i) => i["status"] == "matched").length;
    final unmatchedCount = matchingItems.where((i) => i["status"] == "unmatched").length;
    final exceptionCount = matchingItems.where((i) => i["status"] == "exception").length;
    final partialCount = matchingItems.where((i) => i["status"] == "partially_matched").length;

    return Column(
      spacing: spMd,
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
                    Row(
                      children: [
                        Icon(Icons.check_circle, color: successColor, size: 20),
                        SizedBox(width: spXs),
                        Text(
                          "Matched",
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "$matchedCount",
                      style: TextStyle(
                        fontSize: fsH5,
                        fontWeight: FontWeight.bold,
                        color: successColor,
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
                        Icon(Icons.help, color: warningColor, size: 20),
                        SizedBox(width: spXs),
                        Text(
                          "Unmatched",
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "$unmatchedCount",
                      style: TextStyle(
                        fontSize: fsH5,
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
                        Icon(Icons.incomplete_circle, color: infoColor, size: 20),
                        SizedBox(width: spXs),
                        Text(
                          "Partial",
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "$partialCount",
                      style: TextStyle(
                        fontSize: fsH5,
                        fontWeight: FontWeight.bold,
                        color: infoColor,
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
                        Icon(Icons.error, color: dangerColor, size: 20),
                        SizedBox(width: spXs),
                        Text(
                          "Exceptions",
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "$exceptionCount",
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
                      label: "Search matching items...",
                      value: searchQuery,
                      hint: "Reference, customer name, or description",
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
                      label: "Type",
                      items: typeOptions,
                      value: selectedType,
                      onChanged: (value, label) {
                        selectedType = value;
                        setState(() {});
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),

        // Matching Items List
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
                      "Payment Matching",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "${filteredItems.length} items",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              Divider(height: 1),
              ...List.generate(filteredItems.length, (index) {
                final item = filteredItems[index];
                return Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: index < filteredItems.length - 1 
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
                        children: [
                          Icon(
                            _getTypeIcon("${item["type"]}"),
                            color: primaryColor,
                            size: 20,
                          ),
                          SizedBox(width: spXs),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${item["reference"]}",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: primaryColor,
                                  ),
                                ),
                                Text(
                                  "${item["type"]}".replaceAll("_", " ").toUpperCase(),
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: disabledBoldColor,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Row(
                            children: [
                              Icon(
                                _getStatusIcon("${item["status"]}"),
                                color: _getStatusColor("${item["status"]}"),
                                size: 16,
                              ),
                              SizedBox(width: spXs),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 4),
                                decoration: BoxDecoration(
                                  color: _getStatusColor("${item["status"]}").withAlpha(20),
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: Text(
                                  "${item["status"]}".replaceAll("_", " ").toUpperCase(),
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                    color: _getStatusColor("${item["status"]}"),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "\$${(item["amount"] as double).currency}",
                            style: TextStyle(
                              fontSize: fsH6,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          Text(
                            "${item["customer_name"]}",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: primaryColor,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        "${item["description"]}",
                        style: TextStyle(
                          fontSize: 13,
                          color: disabledBoldColor,
                        ),
                      ),
                      if (item["matched_invoice"] != "")
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Matched: ${item["matched_invoice"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: successColor,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            if (item["confidence_score"] > 0)
                              Text(
                                "Confidence: ${item["confidence_score"]}%",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: item["confidence_score"] >= 90 ? successColor : 
                                         item["confidence_score"] >= 70 ? warningColor : dangerColor,
                                ),
                              ),
                          ],
                        ),
                      if (item.containsKey("variance_amount"))
                        Text(
                          "Variance: \$${(item["variance_amount"] as double).abs().currency} ${(item["variance_amount"] as double) < 0 ? 'under' : 'over'}",
                          style: TextStyle(
                            fontSize: 12,
                            color: warningColor,
                          ),
                        ),
                      if (item.containsKey("exception_reason"))
                        Text(
                          "Exception: ${item["exception_reason"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: dangerColor,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Date: ${item["date"]} • ${item["match_type"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          if (item["processed_by"] != "")
                            Text(
                              "By: ${item["processed_by"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                        ],
                      ),
                      if (item.containsKey("suggested_matches"))
                        Container(
                          padding: EdgeInsets.all(spXs),
                          decoration: BoxDecoration(
                            color: warningColor.withAlpha(10),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Suggested Matches:",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: warningColor,
                                ),
                              ),
                              ...List.generate((item["suggested_matches"] as List).length, (i) {
                                final match = (item["suggested_matches"] as List)[i];
                                return Text(
                                  "• ${match["invoice"]} - \$${(match["amount"] as double).currency} (${match["score"]}% match)",
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: disabledBoldColor,
                                  ),
                                );
                              }),
                            ],
                          ),
                        ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          QButton(
                            label: "View Details",
                            size: bs.sm,
                            onPressed: () {
                              si("Matching details viewed");
                            },
                          ),
                          if (item["status"] == "unmatched" || item["status"] == "partially_matched")
                            ...[
                              SizedBox(width: spXs),
                              QButton(
                                label: "Manual Match",
                                size: bs.sm,
                                onPressed: () => _manualMatch(item),
                              ),
                            ],
                          if (item["status"] == "exception")
                            ...[
                              SizedBox(width: spXs),
                              QButton(
                                label: "Resolve",
                                size: bs.sm,
                                onPressed: () => _resolveException(item),
                              ),
                            ],
                          if (item["status"] == "matched" || item["status"] == "partially_matched")
                            ...[
                              SizedBox(width: spXs),
                              QButton(
                                label: "Unmatch",
                                size: bs.sm,
                                onPressed: () => _unmatchPayment(item),
                              ),
                            ],
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
    );
  }

  Widget _buildRulesTab() {
    return Column(
      spacing: spMd,
      children: [
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
                "Matching Rules",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              SizedBox(height: spMd),
              
              QSwitch(
                items: [
                  {
                    "label": "Auto-match by exact amount",
                    "value": true,
                    "checked": true,
                  }
                ],
                value: [
                  {"label": "Auto-match by exact amount", "value": true, "checked": true}
                ],
                onChanged: (values, ids) {
                  si("Exact amount matching updated");
                },
              ),
              
              SizedBox(height: spSm),
              
              QSwitch(
                items: [
                  {
                    "label": "Match by customer reference",
                    "value": true,
                    "checked": true,
                  }
                ],
                value: [
                  {"label": "Match by customer reference", "value": true, "checked": true}
                ],
                onChanged: (values, ids) {
                  si("Reference matching updated");
                },
              ),
              
              SizedBox(height: spSm),
              
              QTextField(
                label: "Amount tolerance (\$)",
                value: "5.00",
                hint: "Maximum amount variance allowed",
                onChanged: (value) {
                  si("Amount tolerance updated");
                },
              ),
              
              SizedBox(height: spSm),
              
              QTextField(
                label: "Date range tolerance (days)",
                value: "3",
                hint: "Maximum date difference allowed",
                onChanged: (value) {
                  si("Date tolerance updated");
                },
              ),
              
              SizedBox(height: spSm),
              
              QTextField(
                label: "Minimum confidence score (%)",
                value: "85",
                hint: "Minimum score for auto-matching",
                onChanged: (value) {
                  si("Confidence score updated");
                },
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
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Matching Statistics",
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
                          "92%",
                          style: TextStyle(
                            fontSize: fsH5,
                            fontWeight: FontWeight.bold,
                            color: successColor,
                          ),
                        ),
                        Text(
                          "Auto Match Rate",
                          textAlign: TextAlign.center,
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
                          "3.2",
                          style: TextStyle(
                            fontSize: fsH5,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "Avg Processing Time (min)",
                          textAlign: TextAlign.center,
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
              
              SizedBox(height: spSm),
              
              Row(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        Text(
                          "5",
                          style: TextStyle(
                            fontSize: fsH5,
                            fontWeight: FontWeight.bold,
                            color: warningColor,
                          ),
                        ),
                        Text(
                          "Manual Reviews Today",
                          textAlign: TextAlign.center,
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
                          "2",
                          style: TextStyle(
                            fontSize: fsH5,
                            fontWeight: FontWeight.bold,
                            color: dangerColor,
                          ),
                        ),
                        Text(
                          "Exceptions Pending",
                          textAlign: TextAlign.center,
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
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Payment Matching",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Matching", icon: Icon(Icons.compare)),
        Tab(text: "Rules", icon: Icon(Icons.rule)),
      ],
      tabChildren: [
        loading ? 
          Center(child: CircularProgressIndicator()) :
          SingleChildScrollView(
            padding: EdgeInsets.all(spMd),
            child: _buildMatchingTab(),
          ),
        loading ? 
          Center(child: CircularProgressIndicator()) :
          SingleChildScrollView(
            padding: EdgeInsets.all(spMd),
            child: _buildRulesTab(),
          ),
      ],
      actions: [
        IconButton(
          onPressed: _runAutoMatching,
          icon: Icon(Icons.auto_fix_high),
        ),
      ],
    );
  }
}
