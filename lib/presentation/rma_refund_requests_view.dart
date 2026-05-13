import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class RmaRefundRequestsView extends StatefulWidget {
  const RmaRefundRequestsView({super.key});

  @override
  State<RmaRefundRequestsView> createState() => _RmaRefundRequestsViewState();
}

class _RmaRefundRequestsViewState extends State<RmaRefundRequestsView> {
  String selectedFilter = "all";
  String sortBy = "newest";
  bool showDetails = true;
  
  List<Map<String, dynamic>> refundRequests = [
    {
      "id": "REF-001",
      "refundNumber": "#RF12001",
      "orderNumber": "#12001",
      "customerName": "Sarah Johnson",
      "customerPhone": "+1-555-0123",
      "customerEmail": "sarah.johnson@email.com",
      "orderType": "delivery",
      "originalAmount": 45.99,
      "refundAmount": 45.99,
      "refundReason": "food_quality",
      "description": "Pizza arrived cold and soggy, completely inedible",
      "requestDate": "2024-03-15 16:30:00",
      "status": "pending",
      "priority": "high",
      "attachments": ["image1.jpg", "image2.jpg"],
      "staffAssigned": "Mike Wilson",
      "customerRating": 1.0,
      "refundMethod": "card",
      "estimatedProcessTime": 3,
    },
    {
      "id": "REF-002",
      "refundNumber": "#RF12002",
      "orderNumber": "#12002",
      "customerName": "David Chen",
      "customerPhone": "+1-555-0124",
      "customerEmail": "david.chen@email.com",
      "orderType": "dine_in",
      "originalAmount": 67.50,
      "refundAmount": 28.99,
      "refundReason": "wrong_order",
      "description": "Received chicken instead of beef steak, partial refund requested",
      "requestDate": "2024-03-15 15:45:00",
      "status": "approved",
      "priority": "medium",
      "attachments": [],
      "staffAssigned": "Emma Taylor",
      "customerRating": 2.5,
      "refundMethod": "card",
      "estimatedProcessTime": 1,
    },
    {
      "id": "REF-003",
      "refundNumber": "#RF12003",
      "orderNumber": "#12003",
      "customerName": "Lisa Anderson",
      "customerPhone": "+1-555-0125",
      "customerEmail": "lisa.anderson@email.com",
      "orderType": "takeaway",
      "originalAmount": 23.75,
      "refundAmount": 23.75,
      "refundReason": "allergy_concern",
      "description": "Food contained nuts despite specifying no nuts allergy",
      "requestDate": "2024-03-15 14:20:00",
      "status": "processing",
      "priority": "high",
      "attachments": ["medical_note.pdf"],
      "staffAssigned": "James Anderson",
      "customerRating": 1.5,
      "refundMethod": "cash",
      "estimatedProcessTime": 0,
    },
    {
      "id": "REF-004",
      "refundNumber": "#RF12004",
      "orderNumber": "#12004",
      "customerName": "Robert Wilson",
      "customerPhone": "+1-555-0126",
      "customerEmail": "robert.wilson@email.com",
      "orderType": "delivery",
      "originalAmount": 89.95,
      "refundAmount": 0.00,
      "refundReason": "change_of_mind",
      "description": "Customer changed mind after food was prepared",
      "requestDate": "2024-03-15 13:10:00",
      "status": "rejected",
      "priority": "low",
      "attachments": [],
      "staffAssigned": "Sarah Davis",
      "customerRating": 4.0,
      "refundMethod": "none",
      "estimatedProcessTime": 0,
    },
    {
      "id": "REF-005",
      "refundNumber": "#RF12005",
      "orderNumber": "#12005",
      "customerName": "Emily Brown",
      "customerPhone": "+1-555-0127",
      "customerEmail": "emily.brown@email.com",
      "orderType": "dine_in",
      "originalAmount": 156.80,
      "refundAmount": 156.80,
      "refundReason": "service_issue",
      "description": "Extremely poor service, long wait times, rude staff behavior",
      "requestDate": "2024-03-15 12:30:00",
      "status": "completed",
      "priority": "high",
      "attachments": [],
      "staffAssigned": "John Smith",
      "customerRating": 1.0,
      "refundMethod": "card",
      "estimatedProcessTime": 0,
    },
  ];

  List<Map<String, dynamic>> filterOptions = [
    {"label": "All Requests", "value": "all"},
    {"label": "Pending Review", "value": "pending"},
    {"label": "Approved", "value": "approved"},
    {"label": "Processing", "value": "processing"},
    {"label": "Completed", "value": "completed"},
    {"label": "Rejected", "value": "rejected"},
    {"label": "High Priority", "value": "high_priority"},
  ];

  List<Map<String, dynamic>> sortOptions = [
    {"label": "Newest First", "value": "newest"},
    {"label": "Oldest First", "value": "oldest"},
    {"label": "Highest Amount", "value": "amount"},
    {"label": "Priority Level", "value": "priority"},
  ];

  Widget _buildRefundOverview() {
    final totalRequests = refundRequests.length;
    final pendingRequests = refundRequests.where((req) => req["status"] == "pending").length;
    final totalRefundAmount = refundRequests.where((req) => req["status"] != "rejected")
        .map((req) => req["refundAmount"] as double).fold(0.0, (a, b) => a + b);
    final approvalRate = ((refundRequests.where((req) => req["status"] == "approved" || req["status"] == "completed").length / totalRequests) * 100);
    
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Refund Requests Overview",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),
          ResponsiveGridView(
            minItemWidth: 200,
            children: [
              _buildOverviewCard(
                "Total Requests",
                "$totalRequests",
                Icons.request_page,
                primaryColor,
              ),
              _buildOverviewCard(
                "Pending Review",
                "$pendingRequests",
                Icons.pending,
                warningColor,
              ),
              _buildOverviewCard(
                "Total Refunds",
                "\$${totalRefundAmount.currency}",
                Icons.money_off,
                dangerColor,
              ),
              _buildOverviewCard(
                "Approval Rate",
                "${approvalRate.toStringAsFixed(1)}%",
                Icons.check_circle,
                successColor,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildOverviewCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: color.withAlpha(20),
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Column(
        children: [
          Icon(
            icon,
            color: color,
            size: 32,
          ),
          SizedBox(height: spSm),
          Text(
            value,
            style: TextStyle(
              fontSize: fsH5,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          SizedBox(height: spXs),
          Text(
            title,
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilters() {
    return Container(
      padding: EdgeInsets.all(spMd),
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
                child: QDropdownField(
                  label: "Filter Status",
                  items: filterOptions,
                  value: selectedFilter,
                  onChanged: (value, label) {
                    selectedFilter = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QDropdownField(
                  label: "Sort By",
                  items: sortOptions,
                  value: sortBy,
                  onChanged: (value, label) {
                    sortBy = value;
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
                      "label": "Show Request Details",
                      "value": true,
                      "checked": showDetails,
                    }
                  ],
                  value: [
                    if (showDetails)
                      {
                        "label": "Show Request Details",
                        "value": true,
                        "checked": true
                      }
                  ],
                  onChanged: (values, ids) {
                    showDetails = values.isNotEmpty;
                    setState(() {});
                  },
                ),
              ),
              QButton(
                label: "Bulk Process",
                icon: Icons.batch_prediction,
                size: bs.sm,
                onPressed: () {
                  //navigateTo('BulkProcessRefunds')
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildRefundRequestCard(Map<String, dynamic> request) {
    final statusColor = request["status"] == "completed" ? successColor :
                       request["status"] == "approved" ? infoColor :
                       request["status"] == "processing" ? warningColor :
                       request["status"] == "rejected" ? dangerColor : primaryColor;
    
    final priorityColor = request["priority"] == "high" ? dangerColor :
                         request["priority"] == "medium" ? warningColor : successColor;

    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
        border: Border(
          left: BorderSide(
            width: 4,
            color: priorityColor,
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
                    Row(
                      children: [
                        Text(
                          "${request["refundNumber"]}",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        SizedBox(width: spSm),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                          decoration: BoxDecoration(
                            color: statusColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusLg),
                          ),
                          child: Text(
                            "${request["status"]}".toUpperCase(),
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color: statusColor,
                            ),
                          ),
                        ),
                        SizedBox(width: spSm),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                          decoration: BoxDecoration(
                            color: priorityColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusLg),
                          ),
                          child: Text(
                            "${request["priority"]}".toUpperCase(),
                            style: TextStyle(
                              fontSize: 9,
                              fontWeight: FontWeight.bold,
                              color: priorityColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spXs),
                    Row(
                      children: [
                        Icon(Icons.person, color: infoColor, size: 16),
                        SizedBox(width: spXs),
                        Text(
                          "${request["customerName"]}",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: disabledBoldColor,
                          ),
                        ),
                        SizedBox(width: spSm),
                        Text(
                          "Order: ${request["orderNumber"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    "\$${((request["refundAmount"] as double)).currency}",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: dangerColor,
                    ),
                  ),
                  SizedBox(height: spXs),
                  if ((request["estimatedProcessTime"] as int) > 0)
                    Row(
                      children: [
                        Icon(Icons.schedule, color: warningColor, size: 14),
                        SizedBox(width: spXs),
                        Text(
                          "${request["estimatedProcessTime"]} days",
                          style: TextStyle(
                            fontSize: 11,
                            color: warningColor,
                          ),
                        ),
                      ],
                    ),
                ],
              ),
            ],
          ),
          SizedBox(height: spSm),
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(10),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.report_problem, color: dangerColor, size: 16),
                    SizedBox(width: spSm),
                    Text(
                      "Reason: ${request["refundReason"]}".replaceAll("_", " ").toUpperCase(),
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: dangerColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spXs),
                Text(
                  "${request["description"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ],
            ),
          ),
          if (showDetails) ...[
            SizedBox(height: spSm),
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: infoColor.withAlpha(10),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Request Details:",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: infoColor,
                    ),
                  ),
                  SizedBox(height: spXs),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Original Amount: \$${((request["originalAmount"] as double)).currency}",
                              style: TextStyle(fontSize: 11, color: disabledBoldColor),
                            ),
                            Text(
                              "Request Date: ${request["requestDate"]}",
                              style: TextStyle(fontSize: 11, color: disabledBoldColor),
                            ),
                            Text(
                              "Assigned Staff: ${request["staffAssigned"]}",
                              style: TextStyle(fontSize: 11, color: disabledBoldColor),
                            ),
                          ],
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.star, color: warningColor, size: 14),
                              SizedBox(width: spXs),
                              Text(
                                "${(request["customerRating"] as double).toStringAsFixed(1)}",
                                style: TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.bold,
                                  color: warningColor,
                                ),
                              ),
                            ],
                          ),
                          if ((request["attachments"] as List).isNotEmpty) ...[
                            SizedBox(height: spXs),
                            Row(
                              children: [
                                Icon(Icons.attach_file, color: primaryColor, size: 14),
                                SizedBox(width: spXs),
                                Text(
                                  "${(request["attachments"] as List).length} files",
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: primaryColor,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
          SizedBox(height: spMd),
          Row(
            children: [
              if (request["status"] == "pending") ...[
                Expanded(
                  child: QButton(
                    label: "Approve",
                    icon: Icons.check,
                    size: bs.sm,
                    onPressed: () {
                      //navigateTo('ApproveRefund')
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QButton(
                    label: "Reject",
                    icon: Icons.close,
                    size: bs.sm,
                    onPressed: () {
                      //navigateTo('RejectRefund')
                    },
                  ),
                ),
              ] else if (request["status"] == "approved") ...[
                Expanded(
                  child: QButton(
                    label: "Process Payment",
                    icon: Icons.payment,
                    size: bs.sm,
                    onPressed: () {
                      //navigateTo('ProcessPayment')
                    },
                  ),
                ),
              ] else ...[
                Expanded(
                  child: QButton(
                    label: "Contact Customer",
                    icon: Icons.phone,
                    size: bs.sm,
                    onPressed: () {
                      //navigateTo('ContactCustomer')
                    },
                  ),
                ),
              ],
              SizedBox(width: spSm),
              QButton(
                icon: Icons.visibility,
                size: bs.sm,
                onPressed: () {
                  //navigateTo('ViewRefundDetails')
                },
              ),
              SizedBox(width: spSm),
              QButton(
                icon: Icons.history,
                size: bs.sm,
                onPressed: () {
                  //navigateTo('RefundHistory')
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  List<Map<String, dynamic>> get filteredRequests {
    List<Map<String, dynamic>> filtered = List.from(refundRequests);
    
    // Apply filters
    if (selectedFilter != "all") {
      if (selectedFilter == "high_priority") {
        filtered = filtered.where((req) => req["priority"] == "high").toList();
      } else {
        filtered = filtered.where((req) => req["status"] == selectedFilter).toList();
      }
    }
    
    // Apply sorting
    switch (sortBy) {
      case "oldest":
        filtered.sort((a, b) => a["requestDate"].compareTo(b["requestDate"]));
        break;
      case "amount":
        filtered.sort((a, b) => (b["refundAmount"] as double).compareTo(a["refundAmount"] as double));
        break;
      case "priority":
        filtered.sort((a, b) {
          final priorityOrder = {"high": 3, "medium": 2, "low": 1};
          return (priorityOrder[b["priority"]] ?? 0).compareTo(priorityOrder[a["priority"]] ?? 0);
        });
        break;
      default: // newest
        filtered.sort((a, b) => b["requestDate"].compareTo(a["requestDate"]));
    }
    
    return filtered;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Refund Requests"),
        actions: [
          IconButton(
            icon: Icon(Icons.policy),
            onPressed: () {
              //navigateTo('RefundPolicy')
            },
          ),
          IconButton(
            icon: Icon(Icons.analytics),
            onPressed: () {
              //navigateTo('RefundAnalytics')
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            _buildRefundOverview(),
            _buildFilters(),
            Container(
              padding: EdgeInsets.all(spMd),
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
                      Text(
                        "Refund Requests (${filteredRequests.length})",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Spacer(),
                      QButton(
                        label: "Export Report",
                        icon: Icons.download,
                        size: bs.sm,
                        onPressed: () {
                          //navigateTo('ExportRefundReport')
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: spMd),
                  if (filteredRequests.isEmpty)
                    Container(
                      padding: EdgeInsets.all(spMd),
                      child: Column(
                        children: [
                          Icon(
                            Icons.sentiment_satisfied,
                            size: 64,
                            color: successColor,
                          ),
                          SizedBox(height: spSm),
                          Text(
                            "No refund requests found",
                            style: TextStyle(
                              fontSize: fsH6,
                              fontWeight: FontWeight.bold,
                              color: successColor,
                            ),
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "Excellent! Low refund requests indicate high customer satisfaction",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    )
                  else
                    Column(
                      children: filteredRequests.map((request) => _buildRefundRequestCard(request)).toList(),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
