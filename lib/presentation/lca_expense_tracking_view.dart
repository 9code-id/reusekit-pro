import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class LcaExpenseTrackingView extends StatefulWidget {
  const LcaExpenseTrackingView({super.key});

  @override
  State<LcaExpenseTrackingView> createState() => _LcaExpenseTrackingViewState();
}

class _LcaExpenseTrackingViewState extends State<LcaExpenseTrackingView> {
  String selectedPeriod = "This Month";
  String selectedCategory = "All Categories";
  String selectedStatus = "All Status";
  
  List<Map<String, dynamic>> expenses = [
    {
      "id": 1,
      "date": "2025-06-19",
      "description": "Court filing fees - Johnson Corp litigation",
      "category": "Court Fees",
      "amount": 450.0,
      "client": "Johnson Corp",
      "matter": "Employment Dispute Litigation",
      "receipt": "https://picsum.photos/300/200?random=1&receipt",
      "status": "Approved",
      "billable": true,
      "reimbursable": true,
      "submittedBy": "Michael Davis",
      "approvedBy": "Senior Partner",
      "notes": "Standard court filing fees for employment dispute case",
    },
    {
      "id": 2,
      "date": "2025-06-18",
      "description": "Business lunch with TechCorp executives",
      "category": "Meals & Entertainment",
      "amount": 185.50,
      "client": "TechCorp Industries",
      "matter": "Software License Negotiation",
      "receipt": "https://picsum.photos/300/200?random=2&receipt",
      "status": "Pending Approval",
      "billable": true,
      "reimbursable": true,
      "submittedBy": "Sarah Wilson",
      "approvedBy": "",
      "notes": "Client development meeting to discuss licensing terms",
    },
    {
      "id": 3,
      "date": "2025-06-17",
      "description": "Travel expenses - property inspection",
      "category": "Travel",
      "amount": 320.75,
      "client": "Metro Construction",
      "matter": "Property Acquisition Due Diligence",
      "receipt": "https://picsum.photos/300/200?random=3&receipt",
      "status": "Rejected",
      "billable": true,
      "reimbursable": false,
      "submittedBy": "David Rodriguez",
      "approvedBy": "Finance Manager",
      "notes": "Travel documentation incomplete - missing hotel receipts",
    },
    {
      "id": 4,
      "date": "2025-06-16",
      "description": "Legal research database subscription",
      "category": "Research & Resources",
      "amount": 299.0,
      "client": "General Office",
      "matter": "Office Overhead",
      "receipt": "https://picsum.photos/300/200?random=4&receipt",
      "status": "Approved",
      "billable": false,
      "reimbursable": true,
      "submittedBy": "Lisa Chen",
      "approvedBy": "Managing Partner",
      "notes": "Monthly subscription for Westlaw research platform",
    },
    {
      "id": 5,
      "date": "2025-06-15",
      "description": "Expert witness consultation fees",
      "category": "Expert Fees",
      "amount": 2500.0,
      "client": "Smith Family Trust",
      "matter": "Estate Valuation Dispute",
      "receipt": "https://picsum.photos/300/200?random=5&receipt",
      "status": "Approved",
      "billable": true,
      "reimbursable": true,
      "submittedBy": "Emily Taylor",
      "approvedBy": "Senior Partner",
      "notes": "Real estate appraisal expert for estate valuation case",
    },
    {
      "id": 6,
      "date": "2025-06-14",
      "description": "Office supplies and printing",
      "category": "Office Supplies",
      "amount": 75.25,
      "client": "General Office",
      "matter": "Office Overhead",
      "receipt": "https://picsum.photos/300/200?random=6&receipt",
      "status": "Pending Approval",
      "billable": false,
      "reimbursable": true,
      "submittedBy": "Sarah Wilson",
      "approvedBy": "",
      "notes": "Printing costs for client presentations and legal documents",
    },
  ];

  List<Map<String, dynamic>> periodOptions = [
    {"label": "Today", "value": "Today"},
    {"label": "This Week", "value": "This Week"},
    {"label": "This Month", "value": "This Month"},
    {"label": "Last Month", "value": "Last Month"},
    {"label": "This Quarter", "value": "This Quarter"},
    {"label": "This Year", "value": "This Year"},
  ];

  List<Map<String, dynamic>> categoryOptions = [
    {"label": "All Categories", "value": "All Categories"},
    {"label": "Court Fees", "value": "Court Fees"},
    {"label": "Travel", "value": "Travel"},
    {"label": "Meals & Entertainment", "value": "Meals & Entertainment"},
    {"label": "Expert Fees", "value": "Expert Fees"},
    {"label": "Research & Resources", "value": "Research & Resources"},
    {"label": "Office Supplies", "value": "Office Supplies"},
    {"label": "Communications", "value": "Communications"},
    {"label": "Other", "value": "Other"},
  ];

  List<Map<String, dynamic>> statusOptions = [
    {"label": "All Status", "value": "All Status"},
    {"label": "Pending Approval", "value": "Pending Approval"},
    {"label": "Approved", "value": "Approved"},
    {"label": "Rejected", "value": "Rejected"},
    {"label": "Reimbursed", "value": "Reimbursed"},
  ];

  Color _getStatusColor(String status) {
    switch (status) {
      case "Approved":
        return successColor;
      case "Pending Approval":
        return warningColor;
      case "Rejected":
        return dangerColor;
      case "Reimbursed":
        return primaryColor;
      default:
        return disabledColor;
    }
  }

  List<Map<String, dynamic>> get filteredExpenses {
    return expenses.where((expense) {
      bool categoryMatch = selectedCategory == "All Categories" || expense["category"] == selectedCategory;
      bool statusMatch = selectedStatus == "All Status" || expense["status"] == selectedStatus;
      return categoryMatch && statusMatch;
    }).toList();
  }

  void _approveExpense(Map<String, dynamic> expense) {
    setState(() {
      expense["status"] = "Approved";
      expense["approvedBy"] = "Current User";
    });
    ss("Expense approved successfully");
  }

  void _rejectExpense(Map<String, dynamic> expense) {
    setState(() {
      expense["status"] = "Rejected";
      expense["approvedBy"] = "Current User";
    });
    se("Expense rejected");
  }

  Widget _buildExpenseSummary() {
    List<Map<String, dynamic>> filtered = filteredExpenses;
    double totalAmount = filtered.fold(0.0, (sum, e) => sum + (e["amount"] as double));
    double billableAmount = filtered
        .where((e) => e["billable"] == true)
        .fold(0.0, (sum, e) => sum + (e["amount"] as double));
    double reimbursableAmount = filtered
        .where((e) => e["reimbursable"] == true)
        .fold(0.0, (sum, e) => sum + (e["amount"] as double));
    int pendingCount = filtered.where((e) => e["status"] == "Pending Approval").length;

    return Container(
      margin: EdgeInsets.all(spMd),
      child: Column(
        children: [
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
                    children: [
                      Text(
                        "\$${totalAmount.currency}",
                        style: TextStyle(
                          fontSize: fsH5,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "Total Expenses",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
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
                    children: [
                      Text(
                        "\$${billableAmount.currency}",
                        style: TextStyle(
                          fontSize: fsH5,
                          fontWeight: FontWeight.bold,
                          color: successColor,
                        ),
                      ),
                      Text(
                        "Billable",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
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
                    children: [
                      Text(
                        "\$${reimbursableAmount.currency}",
                        style: TextStyle(
                          fontSize: fsH5,
                          fontWeight: FontWeight.bold,
                          color: infoColor,
                        ),
                      ),
                      Text(
                        "Reimbursable",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
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
                    children: [
                      Text(
                        "$pendingCount",
                        style: TextStyle(
                          fontSize: fsH5,
                          fontWeight: FontWeight.bold,
                          color: warningColor,
                        ),
                      ),
                      Text(
                        "Pending",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFilters() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: spMd),
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
                  items: periodOptions,
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
                  items: categoryOptions,
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
          QDropdownField(
            label: "Status",
            items: statusOptions,
            value: selectedStatus,
            onChanged: (value, label) {
              selectedStatus = value;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  Widget _buildExpensesList() {
    List<Map<String, dynamic>> filtered = filteredExpenses;

    return Container(
      margin: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                "Expense Records",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Spacer(),
              Text(
                "${filtered.length} records",
                style: TextStyle(
                  fontSize: 14,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          ...filtered.map((expense) {
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
                    color: _getStatusColor(expense["status"]),
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
                              "${expense["description"]}",
                              style: TextStyle(
                                fontSize: fsH6,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: spXs),
                            Text(
                              "${expense["client"]} • ${expense["matter"]}",
                              style: TextStyle(
                                fontSize: 14,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            "\$${(expense["amount"] as double).currency}",
                            style: TextStyle(
                              fontSize: fsH6,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                            decoration: BoxDecoration(
                              color: _getStatusColor(expense["status"]).withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Text(
                              "${expense["status"]}",
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                                color: _getStatusColor(expense["status"]),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  Row(
                    children: [
                      Icon(
                        Icons.calendar_today,
                        size: 16,
                        color: disabledBoldColor,
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "${expense["date"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                      SizedBox(width: spSm),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                        decoration: BoxDecoration(
                          color: infoColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Text(
                          "${expense["category"]}",
                          style: TextStyle(
                            fontSize: 11,
                            color: infoColor,
                          ),
                        ),
                      ),
                      Spacer(),
                      Text(
                        "by ${expense["submittedBy"]}",
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
                      if (expense["billable"])
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                          decoration: BoxDecoration(
                            color: successColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            "Billable",
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                              color: successColor,
                            ),
                          ),
                        ),
                      if (expense["billable"]) SizedBox(width: spXs),
                      if (expense["reimbursable"])
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                          decoration: BoxDecoration(
                            color: primaryColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            "Reimbursable",
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                              color: primaryColor,
                            ),
                          ),
                        ),
                      Spacer(),
                      GestureDetector(
                        onTap: () {
                          ss("View receipt");
                        },
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.receipt,
                              size: 16,
                              color: primaryColor,
                            ),
                            SizedBox(width: spXs),
                            Text(
                              "Receipt",
                              style: TextStyle(
                                fontSize: 12,
                                color: primaryColor,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  if (expense["notes"].isNotEmpty) ...[
                    SizedBox(height: spSm),
                    Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: disabledColor.withAlpha(10),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Notes:",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: disabledBoldColor,
                            ),
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "${expense["notes"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.black87,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                  if (expense["status"] == "Pending Approval") ...[
                    SizedBox(height: spSm),
                    Row(
                      children: [
                        Expanded(
                          child: QButton(
                            label: "Approve",
                            size: bs.sm,
                            onPressed: () => _approveExpense(expense),
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: QButton(
                            label: "Reject",
                            size: bs.sm,
                            onPressed: () => _rejectExpense(expense),
                          ),
                        ),
                      ],
                    ),
                  ],
                ],
              ),
            );
          }).toList(),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Expense Tracking"),
        actions: [
          QButton(
            icon: Icons.add,
            size: bs.sm,
            onPressed: () {
              ss("Add new expense");
            },
          ),
          SizedBox(width: spSm),
          QButton(
            icon: Icons.download,
            size: bs.sm,
            onPressed: () {
              ss("Export expense report");
            },
          ),
          SizedBox(width: spSm),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildExpenseSummary(),
            _buildFilters(),
            SizedBox(height: spMd),
            _buildExpensesList(),
          ],
        ),
      ),
    );
  }
}
