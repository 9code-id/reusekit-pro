import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class AbaExpenseApprovalView extends StatefulWidget {
  const AbaExpenseApprovalView({super.key});

  @override
  State<AbaExpenseApprovalView> createState() => _AbaExpenseApprovalViewState();
}

class _AbaExpenseApprovalViewState extends State<AbaExpenseApprovalView> {
  int selectedTabIndex = 0;
  String selectedFilter = "All";
  String searchQuery = "";

  List<Map<String, dynamic>> filterOptions = [
    {"label": "All", "value": "All"},
    {"label": "Pending", "value": "Pending"},
    {"label": "Overdue", "value": "Overdue"},
    {"label": "High Amount", "value": "High Amount"},
  ];

  List<Map<String, dynamic>> pendingApprovals = [
    {
      "id": 1,
      "employeeName": "John Smith",
      "employeeId": "EMP001",
      "department": "Sales",
      "expenseTitle": "Q1 Client Conference Expenses",
      "totalAmount": 2847.65,
      "submittedDate": "2024-03-15",
      "dueDate": "2024-03-22",
      "itemCount": 12,
      "categories": ["Travel", "Hotel", "Meals"],
      "priority": "High",
      "receiptStatus": "Complete",
      "managerNotes": "Please review hotel expenses carefully",
      "status": "Pending"
    },
    {
      "id": 2,
      "employeeName": "Sarah Johnson",
      "employeeId": "EMP002",
      "department": "Marketing",
      "expenseTitle": "Training Workshop - Digital Marketing",
      "totalAmount": 1456.32,
      "submittedDate": "2024-03-14",
      "dueDate": "2024-03-21",
      "itemCount": 8,
      "categories": ["Training", "Travel", "Materials"],
      "priority": "Medium",
      "receiptStatus": "Incomplete",
      "managerNotes": "Missing receipt for training materials",
      "status": "Pending"
    },
    {
      "id": 3,
      "employeeName": "Mike Chen",
      "employeeId": "EMP003",
      "department": "IT",
      "expenseTitle": "Software Development Tools",
      "totalAmount": 892.48,
      "submittedDate": "2024-03-16",
      "dueDate": "2024-03-20",
      "itemCount": 5,
      "categories": ["Software", "Equipment"],
      "priority": "Low",
      "receiptStatus": "Complete",
      "managerNotes": null,
      "status": "Overdue"
    },
    {
      "id": 4,
      "employeeName": "Lisa Wong",
      "employeeId": "EMP004",
      "department": "HR",
      "expenseTitle": "Recruitment Fair Expenses",
      "totalAmount": 567.89,
      "submittedDate": "2024-03-13",
      "dueDate": "2024-03-25",
      "itemCount": 7,
      "categories": ["Travel", "Materials", "Meals"],
      "priority": "Medium",
      "receiptStatus": "Complete",
      "managerNotes": "Standard recruitment expenses",
      "status": "Pending"
    }
  ];

  List<Map<String, dynamic>> approvalHistory = [
    {
      "id": 5,
      "employeeName": "David Lee",
      "expenseTitle": "Regional Sales Meeting",
      "totalAmount": 1234.56,
      "actionDate": "2024-03-12",
      "action": "Approved",
      "approverNotes": "All expenses justified and documented well"
    },
    {
      "id": 6,
      "employeeName": "Emma Wilson",
      "expenseTitle": "Equipment Purchase",
      "totalAmount": 789.12,
      "actionDate": "2024-03-11",
      "action": "Rejected",
      "approverNotes": "Equipment not pre-approved as per policy"
    },
    {
      "id": 7,
      "employeeName": "Robert Taylor",
      "expenseTitle": "Client Dinner Meeting",
      "totalAmount": 345.67,
      "actionDate": "2024-03-10",
      "action": "Approved",
      "approverNotes": "Business meal with valid justification"
    }
  ];

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Expense Approval",
      selectedIndex: selectedTabIndex,
      tabs: [
        Tab(text: "Pending", icon: Icon(Icons.pending_actions)),
        Tab(text: "History", icon: Icon(Icons.history)),
        Tab(text: "Summary", icon: Icon(Icons.dashboard)),
      ],
      tabChildren: [
        _buildPendingTab(),
        _buildHistoryTab(),
        _buildSummaryTab(),
      ],
    );
  }

  Widget _buildPendingTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
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
                Row(
                  children: [
                    Icon(Icons.filter_list, color: primaryColor, size: 20),
                    SizedBox(width: spXs),
                    Text(
                      "Filter & Search",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: QTextField(
                        label: "Search expenses...",
                        value: searchQuery,
                        hint: "Employee name, expense title",
                        onChanged: (value) {
                          searchQuery = value;
                          setState(() {});
                        },
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: QDropdownField(
                        label: "Filter",
                        items: filterOptions,
                        value: selectedFilter,
                        onChanged: (value, label) {
                          selectedFilter = value;
                          setState(() {});
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Pending Approvals",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),
                      Text(
                        "${pendingApprovals.where((item) => item["status"] == "Pending").length}",
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
                  width: 1,
                  height: 40,
                  color: disabledOutlineBorderColor,
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Total Value",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),
                      Text(
                        "\$${pendingApprovals.fold(0.0, (sum, item) => sum + (item["totalAmount"] as num)).toStringAsFixed(2)}",
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
                  width: 1,
                  height: 40,
                  color: disabledOutlineBorderColor,
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Overdue",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),
                      Text(
                        "${pendingApprovals.where((item) => item["status"] == "Overdue").length}",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: dangerColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          ...pendingApprovals.map((approval) => _buildApprovalCard(approval)),
        ],
      ),
    );
  }

  Widget _buildApprovalCard(Map<String, dynamic> approval) {
    Color priorityColor = approval["priority"] == "High" 
        ? dangerColor 
        : approval["priority"] == "Medium" 
            ? warningColor 
            : successColor;

    Color statusColor = approval["status"] == "Overdue" ? dangerColor : warningColor;

    return Container(
      padding: EdgeInsets.all(spMd),
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
        spacing: spSm,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${approval["employeeName"]}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "${approval["department"]} • ${approval["employeeId"]}",
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
                  color: priorityColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Text(
                  "${approval["priority"]} Priority",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: priorityColor,
                  ),
                ),
              ),
            ],
          ),
          Text(
            "${approval["expenseTitle"]}",
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: primaryColor,
            ),
          ),
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: disabledColor.withAlpha(10),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Amount",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                      Text(
                        "\$${(approval["totalAmount"] as num).toStringAsFixed(2)}",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: successColor,
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
                        "Items",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                      Text(
                        "${approval["itemCount"]} items",
                        style: TextStyle(
                          fontSize: 16,
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
                        "Due Date",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                      Text(
                        "${approval["dueDate"]}",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: approval["status"] == "Overdue" ? dangerColor : primaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          if (approval["categories"] != null)
            Wrap(
              spacing: spXs,
              runSpacing: spXs,
              children: (approval["categories"] as List).map((category) {
                return Container(
                  padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                  decoration: BoxDecoration(
                    color: infoColor.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Text(
                    "$category",
                    style: TextStyle(
                      fontSize: 12,
                      color: infoColor,
                    ),
                  ),
                );
              }).toList(),
            ),
          Row(
            children: [
              Icon(
                approval["receiptStatus"] == "Complete" ? Icons.check_circle : Icons.error,
                color: approval["receiptStatus"] == "Complete" ? successColor : dangerColor,
                size: 16,
              ),
              SizedBox(width: spXs),
              Text(
                "Receipts: ${approval["receiptStatus"]}",
                style: TextStyle(
                  fontSize: 13,
                  color: approval["receiptStatus"] == "Complete" ? successColor : dangerColor,
                ),
              ),
              Spacer(),
              Text(
                "Submitted: ${approval["submittedDate"]}",
                style: TextStyle(
                  fontSize: 13,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
          if (approval["managerNotes"] != null)
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: infoColor.withAlpha(10),
                borderRadius: BorderRadius.circular(radiusSm),
                border: Border.all(color: infoColor.withAlpha(30)),
              ),
              child: Row(
                children: [
                  Icon(Icons.note, color: infoColor, size: 16),
                  SizedBox(width: spXs),
                  Expanded(
                    child: Text(
                      "Note: ${approval["managerNotes"]}",
                      style: TextStyle(
                        fontSize: 13,
                        color: infoColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          Row(
            children: [
              Expanded(
                child: QButton(
                  label: "View Details",
                  size: bs.sm,
                  onPressed: () {
                    si("View expense details");
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QButton(
                  label: "Approve",
                  size: bs.sm,
                  onPressed: () async {
                    bool isConfirmed = await confirm("Approve this expense report?");
                    if (isConfirmed) {
                      ss("Expense approved successfully");
                    }
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QButton(
                  label: "Reject",
                  size: bs.sm,
                  onPressed: () async {
                    bool isConfirmed = await confirm("Reject this expense report?");
                    if (isConfirmed) {
                      se("Expense report rejected");
                    }
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildHistoryTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "This Month",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),
                      Text(
                        "25 Approved",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: successColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 1,
                  height: 40,
                  color: disabledOutlineBorderColor,
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Rejected",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),
                      Text(
                        "3 Reports",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: dangerColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 1,
                  height: 40,
                  color: disabledOutlineBorderColor,
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Avg Time",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),
                      Text(
                        "2.4 days",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          ...approvalHistory.map((history) => _buildHistoryCard(history)),
        ],
      ),
    );
  }

  Widget _buildHistoryCard(Map<String, dynamic> history) {
    Color actionColor = history["action"] == "Approved" ? successColor : dangerColor;

    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
        border: Border(
          left: BorderSide(
            width: 4,
            color: actionColor,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${history["employeeName"]}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "${history["expenseTitle"]}",
                      style: TextStyle(
                        fontSize: 14,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: actionColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Text(
                  "${history["action"]}",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: actionColor,
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
                      "Amount",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "\$${(history["totalAmount"] as num).toStringAsFixed(2)}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: successColor,
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
                      "Action Date",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "${history["actionDate"]}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: actionColor.withAlpha(10),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Row(
              children: [
                Icon(
                  history["action"] == "Approved" ? Icons.check_circle : Icons.cancel,
                  color: actionColor,
                  size: 16,
                ),
                SizedBox(width: spXs),
                Expanded(
                  child: Text(
                    "${history["approverNotes"]}",
                    style: TextStyle(
                      fontSize: 13,
                      color: actionColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
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
                  "Approval Performance",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.all(spMd),
                        decoration: BoxDecoration(
                          color: successColor.withAlpha(10),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Column(
                          children: [
                            Icon(Icons.check_circle, color: successColor, size: 32),
                            SizedBox(height: spXs),
                            Text(
                              "Approved",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                            Text(
                              "187",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: successColor,
                              ),
                            ),
                            Text(
                              "94.5%",
                              style: TextStyle(
                                fontSize: 12,
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
                        padding: EdgeInsets.all(spMd),
                        decoration: BoxDecoration(
                          color: dangerColor.withAlpha(10),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Column(
                          children: [
                            Icon(Icons.cancel, color: dangerColor, size: 32),
                            SizedBox(height: spXs),
                            Text(
                              "Rejected",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                            Text(
                              "11",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: dangerColor,
                              ),
                            ),
                            Text(
                              "5.5%",
                              style: TextStyle(
                                fontSize: 12,
                                color: dangerColor,
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
          ),
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
                  "Processing Time Analysis",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                _buildProcessingRow("Same Day", 45, successColor),
                _buildProcessingRow("1-2 Days", 35, primaryColor),
                _buildProcessingRow("3-5 Days", 15, warningColor),
                _buildProcessingRow("Over 5 Days", 5, dangerColor),
              ],
            ),
          ),
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
                  "Department Breakdown",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                _buildDepartmentRow("Sales", 45, 42567.89, primaryColor),
                _buildDepartmentRow("Marketing", 32, 28934.56, successColor),
                _buildDepartmentRow("IT", 28, 15678.90, warningColor),
                _buildDepartmentRow("HR", 15, 8765.43, infoColor),
                _buildDepartmentRow("Operations", 12, 5432.10, secondaryColor),
              ],
            ),
          ),
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
                  "Common Rejection Reasons",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                _buildRejectionRow("Missing Receipts", 40),
                _buildRejectionRow("Exceeds Policy Limits", 25),
                _buildRejectionRow("Unapproved Expenses", 20),
                _buildRejectionRow("Incomplete Documentation", 15),
              ],
            ),
          ),
          QButton(
            label: "Download Full Report",
            onPressed: () {
              ss("Approval summary report downloaded");
            },
          ),
        ],
      ),
    );
  }

  Widget _buildProcessingRow(String timeRange, int percentage, Color color) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: color.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Row(
        children: [
          Container(
            width: 12,
            height: 12,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
            ),
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  timeRange,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
                Container(
                  height: 6,
                  decoration: BoxDecoration(
                    color: disabledColor.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusXs),
                  ),
                  child: FractionallySizedBox(
                    alignment: Alignment.centerLeft,
                    widthFactor: percentage / 100,
                    child: Container(
                      decoration: BoxDecoration(
                        color: color,
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: spSm),
          Text(
            "$percentage%",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDepartmentRow(String department, int count, double amount, Color color) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: color.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Row(
        children: [
          Container(
            width: 4,
            height: 40,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(radiusXs),
            ),
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  department,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "$count reports • \$${amount.toStringAsFixed(2)}",
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
    );
  }

  Widget _buildRejectionRow(String reason, int percentage) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: dangerColor.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Row(
        children: [
          Icon(Icons.error_outline, color: dangerColor, size: 16),
          SizedBox(width: spSm),
          Expanded(
            child: Text(
              reason,
              style: TextStyle(
                fontSize: 14,
                color: primaryColor,
              ),
            ),
          ),
          Text(
            "$percentage%",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: dangerColor,
            ),
          ),
        ],
      ),
    );
  }
}
