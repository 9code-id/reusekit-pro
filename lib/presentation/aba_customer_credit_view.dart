import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class AbaCustomerCreditView extends StatefulWidget {
  const AbaCustomerCreditView({super.key});

  @override
  State<AbaCustomerCreditView> createState() => _AbaCustomerCreditViewState();
}

class _AbaCustomerCreditViewState extends State<AbaCustomerCreditView> {
  String searchQuery = "";
  String selectedStatus = "all";
  String selectedRiskLevel = "all";
  bool loading = false;

  List<Map<String, dynamic>> statusOptions = [
    {"label": "All Status", "value": "all"},
    {"label": "Active", "value": "active"},
    {"label": "Suspended", "value": "suspended"},
    {"label": "Under Review", "value": "under_review"},
    {"label": "Closed", "value": "closed"},
  ];

  List<Map<String, dynamic>> riskLevelOptions = [
    {"label": "All Risk Levels", "value": "all"},
    {"label": "Low Risk", "value": "low"},
    {"label": "Medium Risk", "value": "medium"},
    {"label": "High Risk", "value": "high"},
    {"label": "Critical", "value": "critical"},
  ];

  List<Map<String, dynamic>> creditAccounts = [
    {
      "id": "CREDIT-001",
      "customer_name": "John Smith",
      "customer_id": "CUST-001",
      "credit_limit": 5000.00,
      "available_credit": 3250.00,
      "outstanding_balance": 1750.00,
      "payment_terms": "Net 30",
      "risk_level": "low",
      "status": "active",
      "last_payment_date": "2024-06-15",
      "next_review_date": "2024-09-01",
      "credit_score": 750,
      "utilization_rate": 35.0,
    },
    {
      "id": "CREDIT-002",
      "customer_name": "Sarah Johnson",
      "customer_id": "CUST-002",
      "credit_limit": 3000.00,
      "available_credit": 2100.00,
      "outstanding_balance": 900.00,
      "payment_terms": "Net 15",
      "risk_level": "low",
      "status": "active",
      "last_payment_date": "2024-06-18",
      "next_review_date": "2024-08-15",
      "credit_score": 720,
      "utilization_rate": 30.0,
    },
    {
      "id": "CREDIT-003",
      "customer_name": "Michael Brown",
      "customer_id": "CUST-003",
      "credit_limit": 7500.00,
      "available_credit": 1250.00,
      "outstanding_balance": 6250.00,
      "payment_terms": "Net 45",
      "risk_level": "high",
      "status": "under_review",
      "last_payment_date": "2024-05-20",
      "next_review_date": "2024-07-01",
      "credit_score": 620,
      "utilization_rate": 83.3,
    },
    {
      "id": "CREDIT-004",
      "customer_name": "Emily Davis",
      "customer_id": "CUST-004",
      "credit_limit": 2500.00,
      "available_credit": 2050.00,
      "outstanding_balance": 450.00,
      "payment_terms": "Net 30",
      "risk_level": "low",
      "status": "active",
      "last_payment_date": "2024-06-19",
      "next_review_date": "2024-10-01",
      "credit_score": 780,
      "utilization_rate": 18.0,
    },
    {
      "id": "CREDIT-005",
      "customer_name": "David Wilson",
      "customer_id": "CUST-005",
      "credit_limit": 4000.00,
      "available_credit": 0.00,
      "outstanding_balance": 4000.00,
      "payment_terms": "Net 30",
      "risk_level": "critical",
      "status": "suspended",
      "last_payment_date": "2024-04-15",
      "next_review_date": "2024-06-30",
      "credit_score": 580,
      "utilization_rate": 100.0,
    },
  ];

  List<Map<String, dynamic>> get filteredAccounts {
    return creditAccounts.where((account) {
      final matchesSearch = account["customer_name"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
          account["id"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
          account["customer_id"].toString().toLowerCase().contains(searchQuery.toLowerCase());
      
      final matchesStatus = selectedStatus == "all" || account["status"] == selectedStatus;
      final matchesRisk = selectedRiskLevel == "all" || account["risk_level"] == selectedRiskLevel;
      
      return matchesSearch && matchesStatus && matchesRisk;
    }).toList();
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'active':
        return successColor;
      case 'suspended':
        return dangerColor;
      case 'under_review':
        return warningColor;
      case 'closed':
        return disabledBoldColor;
      default:
        return disabledBoldColor;
    }
  }

  Color _getRiskColor(String riskLevel) {
    switch (riskLevel.toLowerCase()) {
      case 'low':
        return successColor;
      case 'medium':
        return warningColor;
      case 'high':
        return dangerColor;
      case 'critical':
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  void _adjustCreditLimit(Map<String, dynamic> account) async {
    bool isConfirmed = await confirm("Adjust credit limit for ${account["customer_name"]}?");
    if (!isConfirmed) return;

    loading = true;
    setState(() {});
    
    await Future.delayed(Duration(seconds: 2));
    
    loading = false;
    setState(() {});
    
    ss("Credit limit adjusted successfully");
  }

  void _suspendAccount(Map<String, dynamic> account) async {
    bool isConfirmed = await confirm("Suspend credit account for ${account["customer_name"]}?");
    if (!isConfirmed) return;

    loading = true;
    setState(() {});
    
    await Future.delayed(Duration(seconds: 2));
    
    loading = false;
    setState(() {});
    
    sw("Account suspended");
  }

  void _reviewAccount(Map<String, dynamic> account) async {
    loading = true;
    setState(() {});
    
    await Future.delayed(Duration(seconds: 2));
    
    loading = false;
    setState(() {});
    
    si("Account review initiated");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Customer Credit"),
        actions: [
          IconButton(
            onPressed: () {
              si("Credit report generated");
            },
            icon: Icon(Icons.assessment),
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
                            "Total Credit Limit",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "\$${((creditAccounts.fold(0.0, (sum, account) => sum + (account["credit_limit"] as double)))).currency}",
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
                            "Outstanding",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "\$${((creditAccounts.fold(0.0, (sum, account) => sum + (account["outstanding_balance"] as double)))).currency}",
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

              // Risk Distribution
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
                      "Risk Distribution",
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
                                "${creditAccounts.where((a) => a["risk_level"] == "low").length}",
                                style: TextStyle(
                                  fontSize: fsH5,
                                  fontWeight: FontWeight.bold,
                                  color: successColor,
                                ),
                              ),
                              Text(
                                "Low Risk",
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
                                "${creditAccounts.where((a) => a["risk_level"] == "medium").length}",
                                style: TextStyle(
                                  fontSize: fsH5,
                                  fontWeight: FontWeight.bold,
                                  color: warningColor,
                                ),
                              ),
                              Text(
                                "Medium Risk",
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
                                "${creditAccounts.where((a) => a["risk_level"] == "high").length}",
                                style: TextStyle(
                                  fontSize: fsH5,
                                  fontWeight: FontWeight.bold,
                                  color: dangerColor,
                                ),
                              ),
                              Text(
                                "High Risk",
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
                                "${creditAccounts.where((a) => a["risk_level"] == "critical").length}",
                                style: TextStyle(
                                  fontSize: fsH5,
                                  fontWeight: FontWeight.bold,
                                  color: dangerColor,
                                ),
                              ),
                              Text(
                                "Critical",
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
                            label: "Search credit accounts...",
                            value: searchQuery,
                            hint: "Customer name or account ID",
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
                            label: "Risk Level",
                            items: riskLevelOptions,
                            value: selectedRiskLevel,
                            onChanged: (value, label) {
                              selectedRiskLevel = value;
                              setState(() {});
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Credit Accounts List
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
                            "Credit Accounts",
                            style: TextStyle(
                              fontSize: fsH6,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          Text(
                            "${filteredAccounts.length} accounts",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Divider(height: 1),
                    ...List.generate(filteredAccounts.length, (index) {
                      final account = filteredAccounts[index];
                      return Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: index < filteredAccounts.length - 1 
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
                                        "${account["customer_name"]}",
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                          color: primaryColor,
                                        ),
                                      ),
                                      Text(
                                        "${account["id"]} • ${account["customer_id"]}",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Row(
                                  children: [
                                    Container(
                                      padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 4),
                                      decoration: BoxDecoration(
                                        color: _getRiskColor("${account["risk_level"]}").withAlpha(20),
                                        borderRadius: BorderRadius.circular(radiusXs),
                                      ),
                                      child: Text(
                                        "${account["risk_level"]}".toUpperCase(),
                                        style: TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.bold,
                                          color: _getRiskColor("${account["risk_level"]}"),
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: spXs),
                                    Container(
                                      padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 4),
                                      decoration: BoxDecoration(
                                        color: _getStatusColor("${account["status"]}").withAlpha(20),
                                        borderRadius: BorderRadius.circular(radiusXs),
                                      ),
                                      child: Text(
                                        "${account["status"]}".toUpperCase(),
                                        style: TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.bold,
                                          color: _getStatusColor("${account["status"]}"),
                                        ),
                                      ),
                                    ),
                                  ],
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
                                        "Credit Limit",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                      Text(
                                        "\$${(account["credit_limit"] as double).currency}",
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
                                        "Available",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                      Text(
                                        "\$${(account["available_credit"] as double).currency}",
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
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Outstanding",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                      Text(
                                        "\$${(account["outstanding_balance"] as double).currency}",
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
                                        "Utilization",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                      Text(
                                        "${(account["utilization_rate"] as double).toStringAsFixed(1)}%",
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          color: (account["utilization_rate"] as double) > 80 ? dangerColor : primaryColor,
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
                                  "Score: ${account["credit_score"]} • ${account["payment_terms"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                Text(
                                  "Review: ${account["next_review_date"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                QButton(
                                  label: "Review",
                                  size: bs.sm,
                                  onPressed: () => _reviewAccount(account),
                                ),
                                SizedBox(width: spXs),
                                QButton(
                                  label: "Adjust Limit",
                                  size: bs.sm,
                                  onPressed: () => _adjustCreditLimit(account),
                                ),
                                if (account["status"] == "active")
                                  ...[
                                    SizedBox(width: spXs),
                                    QButton(
                                      label: "Suspend",
                                      size: bs.sm,
                                      onPressed: () => _suspendAccount(account),
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
          ),
        ),
    );
  }
}
