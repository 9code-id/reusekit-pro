import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class AbaExpenseReimbursementView extends StatefulWidget {
  const AbaExpenseReimbursementView({super.key});

  @override
  State<AbaExpenseReimbursementView> createState() => _AbaExpenseReimbursementViewState();
}

class _AbaExpenseReimbursementViewState extends State<AbaExpenseReimbursementView> {
  int selectedTabIndex = 0;
  String selectedStatus = "All";
  String selectedPeriod = "This Month";

  List<Map<String, dynamic>> statusOptions = [
    {"label": "All", "value": "All"},
    {"label": "Pending", "value": "Pending"},
    {"label": "Approved", "value": "Approved"},
    {"label": "Paid", "value": "Paid"},
    {"label": "Rejected", "value": "Rejected"},
  ];

  List<Map<String, dynamic>> periodOptions = [
    {"label": "This Week", "value": "This Week"},
    {"label": "This Month", "value": "This Month"},
    {"label": "This Quarter", "value": "This Quarter"},
    {"label": "This Year", "value": "This Year"},
  ];

  List<Map<String, dynamic>> reimbursementRequests = [
    {
      "id": 1,
      "employeeName": "John Smith",
      "employeeId": "EMP001",
      "department": "Sales",
      "submittedDate": "2024-03-15",
      "totalAmount": 847.65,
      "status": "Approved",
      "approvedDate": "2024-03-16",
      "paymentDate": null,
      "description": "Client meeting expenses - Q1 conference",
      "category": "Travel",
      "receiptCount": 5,
      "items": [
        {"type": "Hotel", "amount": 345.00, "date": "2024-03-10"},
        {"type": "Meals", "amount": 125.50, "date": "2024-03-10"},
        {"type": "Transportation", "amount": 89.15, "date": "2024-03-10"},
        {"type": "Conference Fee", "amount": 250.00, "date": "2024-03-11"},
        {"type": "Parking", "amount": 38.00, "date": "2024-03-11"}
      ]
    },
    {
      "id": 2,
      "employeeName": "Sarah Johnson",
      "employeeId": "EMP002",
      "department": "Marketing",
      "submittedDate": "2024-03-14",
      "totalAmount": 456.32,
      "status": "Pending",
      "approvedDate": null,
      "paymentDate": null,
      "description": "Training workshop expenses",
      "category": "Training",
      "receiptCount": 3,
      "items": [
        {"type": "Training Fee", "amount": 350.00, "date": "2024-03-12"},
        {"type": "Materials", "amount": 75.50, "date": "2024-03-12"},
        {"type": "Lunch", "amount": 30.82, "date": "2024-03-12"}
      ]
    },
    {
      "id": 3,
      "employeeName": "Mike Chen",
      "employeeId": "EMP003",
      "department": "IT",
      "submittedDate": "2024-03-12",
      "totalAmount": 1234.56,
      "status": "Paid",
      "approvedDate": "2024-03-13",
      "paymentDate": "2024-03-18",
      "description": "Emergency software license purchase",
      "category": "Equipment",
      "receiptCount": 2,
      "items": [
        {"type": "Software License", "amount": 1199.99, "date": "2024-03-11"},
        {"type": "Support Package", "amount": 34.57, "date": "2024-03-11"}
      ]
    },
    {
      "id": 4,
      "employeeName": "Lisa Wong",
      "employeeId": "EMP004",
      "department": "HR",
      "submittedDate": "2024-03-10",
      "totalAmount": 267.89,
      "status": "Rejected",
      "approvedDate": "2024-03-11",
      "paymentDate": null,
      "description": "Office supplies purchase",
      "category": "Office Supplies",
      "receiptCount": 4,
      "rejectionReason": "Personal items included in expense claim",
      "items": [
        {"type": "Printer Paper", "amount": 45.99, "date": "2024-03-08"},
        {"type": "Ink Cartridges", "amount": 89.90, "date": "2024-03-08"},
        {"type": "Office Chair", "amount": 125.00, "date": "2024-03-09"},
        {"type": "Personal Items", "amount": 7.00, "date": "2024-03-09"}
      ]
    },
    {
      "id": 5,
      "employeeName": "David Lee",
      "employeeId": "EMP005",
      "department": "Finance",
      "submittedDate": "2024-03-18",
      "totalAmount": 678.90,
      "status": "Pending",
      "approvedDate": null,
      "paymentDate": null,
      "description": "Business lunch with clients",
      "category": "Meals",
      "receiptCount": 1,
      "items": [
        {"type": "Business Lunch", "amount": 678.90, "date": "2024-03-17"}
      ]
    }
  ];

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Expense Reimbursement",
      selectedIndex: selectedTabIndex,
      tabs: [
        Tab(text: "Requests", icon: Icon(Icons.request_quote)),
        Tab(text: "Processing", icon: Icon(Icons.hourglass_empty)),
        Tab(text: "Analytics", icon: Icon(Icons.analytics)),
      ],
      tabChildren: [
        _buildRequestsTab(),
        _buildProcessingTab(),
        _buildAnalyticsTab(),
      ],
    );
  }

  Widget _buildRequestsTab() {
    List<Map<String, dynamic>> filteredRequests = reimbursementRequests;
    if (selectedStatus != "All") {
      filteredRequests = reimbursementRequests.where((req) => req["status"] == selectedStatus).toList();
    }

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
                      "Filter Requests",
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
                        "Total Requests",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),
                      Text(
                        "${filteredRequests.length}",
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
                        "Total Amount",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),
                      Text(
                        "\$${filteredRequests.fold(0.0, (sum, req) => sum + (req["totalAmount"] as num)).toStringAsFixed(2)}",
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
                        "Pending",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),
                      Text(
                        "${reimbursementRequests.where((req) => req["status"] == "Pending").length}",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: warningColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          ...filteredRequests.map((request) => _buildReimbursementCard(request)),
        ],
      ),
    );
  }

  Widget _buildReimbursementCard(Map<String, dynamic> request) {
    Color statusColor = _getStatusColor(request["status"]);

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
                      "${request["employeeName"]}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "${request["department"]} • ${request["employeeId"]}",
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
                  color: statusColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Text(
                  "${request["status"]}",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: statusColor,
                  ),
                ),
              ),
            ],
          ),
          Text(
            "${request["description"]}",
            style: TextStyle(
              fontSize: 14,
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
                        "\$${(request["totalAmount"] as num).toStringAsFixed(2)}",
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
                        "Receipts",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                      Text(
                        "${request["receiptCount"]} items",
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
                        "Submitted",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                      Text(
                        "${request["submittedDate"]}",
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
          ),
          Row(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: infoColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Text(
                  "${request["category"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: infoColor,
                  ),
                ),
              ),
              Spacer(),
              if (request["paymentDate"] != null)
                Text(
                  "Paid: ${request["paymentDate"]}",
                  style: TextStyle(
                    fontSize: 13,
                    color: successColor,
                  ),
                )
              else if (request["approvedDate"] != null)
                Text(
                  "Approved: ${request["approvedDate"]}",
                  style: TextStyle(
                    fontSize: 13,
                    color: successColor,
                  ),
                ),
            ],
          ),
          if (request["rejectionReason"] != null)
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: dangerColor.withAlpha(10),
                borderRadius: BorderRadius.circular(radiusSm),
                border: Border.all(color: dangerColor.withAlpha(30)),
              ),
              child: Row(
                children: [
                  Icon(Icons.error_outline, color: dangerColor, size: 16),
                  SizedBox(width: spXs),
                  Expanded(
                    child: Text(
                      "Rejected: ${request["rejectionReason"]}",
                      style: TextStyle(
                        fontSize: 13,
                        color: dangerColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ExpansionTile(
            title: Text(
              "View Expense Items (${(request["items"] as List).length})",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: primaryColor,
              ),
            ),
            children: [
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: disabledColor.withAlpha(10),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Column(
                  children: (request["items"] as List).map((item) {
                    return Padding(
                      padding: EdgeInsets.symmetric(vertical: spXs),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: Text(
                              "${item["type"]}",
                              style: TextStyle(
                                fontSize: 13,
                                color: primaryColor,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              "${item["date"]}",
                              style: TextStyle(
                                fontSize: 13,
                                color: disabledBoldColor,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              "\$${(item["amount"] as num).toStringAsFixed(2)}",
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                                color: successColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: QButton(
                  label: "View Details",
                  size: bs.sm,
                  onPressed: () {
                    si("View reimbursement details");
                  },
                ),
              ),
              SizedBox(width: spSm),
              if (request["status"] == "Pending")
                Expanded(
                  child: QButton(
                    label: "Approve",
                    size: bs.sm,
                    onPressed: () async {
                      bool isConfirmed = await confirm("Approve this reimbursement request?");
                      if (isConfirmed) {
                        ss("Reimbursement approved");
                      }
                    },
                  ),
                ),
              if (request["status"] == "Approved")
                Expanded(
                  child: QButton(
                    label: "Process Payment",
                    size: bs.sm,
                    onPressed: () async {
                      bool isConfirmed = await confirm("Process payment for this reimbursement?");
                      if (isConfirmed) {
                        ss("Payment processed successfully");
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

  Widget _buildProcessingTab() {
    List<Map<String, dynamic>> processingSteps = [
      {
        "title": "Employee Submission",
        "description": "Employee submits expense report with receipts",
        "status": "completed",
        "count": reimbursementRequests.length
      },
      {
        "title": "Manager Review",
        "description": "Direct manager reviews and validates expenses",
        "status": "pending",
        "count": reimbursementRequests.where((r) => r["status"] == "Pending").length
      },
      {
        "title": "Finance Approval",
        "description": "Finance team approves for payment processing",
        "status": "approved",
        "count": reimbursementRequests.where((r) => r["status"] == "Approved").length
      },
      {
        "title": "Payment Processing",
        "description": "Payment issued to employee account",
        "status": "paid",
        "count": reimbursementRequests.where((r) => r["status"] == "Paid").length
      }
    ];

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
                  "Processing Pipeline",
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
                          color: warningColor.withAlpha(10),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Column(
                          children: [
                            Icon(Icons.hourglass_empty, color: warningColor, size: 32),
                            SizedBox(height: spXs),
                            Text(
                              "Avg Processing",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                            Text(
                              "2.8 days",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: warningColor,
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
                          color: successColor.withAlpha(10),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Column(
                          children: [
                            Icon(Icons.check_circle, color: successColor, size: 32),
                            SizedBox(height: spXs),
                            Text(
                              "Approval Rate",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                            Text(
                              "92.5%",
                              style: TextStyle(
                                fontSize: 18,
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
              ],
            ),
          ),
          ...processingSteps.map((step) => _buildProcessingStepCard(step)),
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
                  "Recent Activity",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                _buildActivityItem("Payment processed for Mike Chen", "2 hours ago", successColor),
                _buildActivityItem("John Smith's request approved", "4 hours ago", successColor),
                _buildActivityItem("New request from David Lee", "6 hours ago", infoColor),
                _buildActivityItem("Lisa Wong's request rejected", "1 day ago", dangerColor),
                _buildActivityItem("Sarah Johnson submitted expense report", "1 day ago", warningColor),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProcessingStepCard(Map<String, dynamic> step) {
    Color stepColor = step["status"] == "completed" ? successColor :
                     step["status"] == "pending" ? warningColor :
                     step["status"] == "approved" ? infoColor : primaryColor;

    IconData stepIcon = step["status"] == "completed" ? Icons.check_circle :
                       step["status"] == "pending" ? Icons.hourglass_empty :
                       step["status"] == "approved" ? Icons.approval : Icons.payment;

    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
        border: Border(
          left: BorderSide(
            width: 4,
            color: stepColor,
          ),
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: stepColor.withAlpha(20),
              shape: BoxShape.circle,
            ),
            child: Icon(stepIcon, color: stepColor, size: 24),
          ),
          SizedBox(width: spMd),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${step["title"]}",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "${step["description"]}",
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
            decoration: BoxDecoration(
              color: stepColor.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Text(
              "${step["count"]}",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: stepColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActivityItem(String activity, String time, Color color) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: color.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Row(
        children: [
          Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
            ),
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Text(
              activity,
              style: TextStyle(
                fontSize: 14,
                color: primaryColor,
              ),
            ),
          ),
          Text(
            time,
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAnalyticsTab() {
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
                  "Reimbursement Summary",
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
                          color: primaryColor.withAlpha(10),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Column(
                          children: [
                            Icon(Icons.receipt_long, color: primaryColor, size: 32),
                            SizedBox(height: spXs),
                            Text(
                              "Total Requests",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                            Text(
                              "${reimbursementRequests.length}",
                              style: TextStyle(
                                fontSize: 20,
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
                        padding: EdgeInsets.all(spMd),
                        decoration: BoxDecoration(
                          color: successColor.withAlpha(10),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Column(
                          children: [
                            Icon(Icons.attach_money, color: successColor, size: 32),
                            SizedBox(height: spXs),
                            Text(
                              "Total Amount",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                            Text(
                              "\$${reimbursementRequests.fold(0.0, (sum, req) => sum + (req["totalAmount"] as num)).toStringAsFixed(2)}",
                              style: TextStyle(
                                fontSize: 20,
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
                  "Status Distribution",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                _buildStatusDistribution("Paid", 1, 20, successColor),
                _buildStatusDistribution("Approved", 1, 20, infoColor),
                _buildStatusDistribution("Pending", 2, 40, warningColor),
                _buildStatusDistribution("Rejected", 1, 20, dangerColor),
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
                  "Category Breakdown",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                _buildCategoryBreakdown("Travel", 847.65, 30, primaryColor),
                _buildCategoryBreakdown("Equipment", 1234.56, 35, successColor),
                _buildCategoryBreakdown("Meals", 678.90, 20, warningColor),
                _buildCategoryBreakdown("Training", 456.32, 15, infoColor),
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
                  "Department Analysis",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                _buildDepartmentAnalysis("IT", 1234.56, 1),
                _buildDepartmentAnalysis("Sales", 847.65, 1),
                _buildDepartmentAnalysis("Marketing", 456.32, 1),
                _buildDepartmentAnalysis("Finance", 678.90, 1),
                _buildDepartmentAnalysis("HR", 267.89, 1),
              ],
            ),
          ),
          QButton(
            label: "Export Analytics Report",
            onPressed: () {
              ss("Analytics report exported successfully");
            },
          ),
        ],
      ),
    );
  }

  Widget _buildStatusDistribution(String status, int count, int percentage, Color color) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: color.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Row(
        children: [
          Icon(
            status == "Paid" ? Icons.check_circle :
            status == "Approved" ? Icons.approval :
            status == "Pending" ? Icons.hourglass_empty : Icons.cancel,
            color: color,
            size: 20,
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  status,
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
            "$count ($percentage%)",
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

  Widget _buildCategoryBreakdown(String category, double amount, int percentage, Color color) {
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
                  category,
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
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                "\$${amount.toStringAsFixed(2)}",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
              Text(
                "$percentage%",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDepartmentAnalysis(String department, double amount, int requests) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: primaryColor.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Row(
        children: [
          Container(
            width: 4,
            height: 40,
            decoration: BoxDecoration(
              color: primaryColor,
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
                  "$requests request${requests > 1 ? 's' : ''} • \$${amount.toStringAsFixed(2)}",
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

  Color _getStatusColor(String status) {
    switch (status) {
      case "Approved":
        return infoColor;
      case "Paid":
        return successColor;
      case "Pending":
        return warningColor;
      case "Rejected":
        return dangerColor;
      default:
        return primaryColor;
    }
  }
}
