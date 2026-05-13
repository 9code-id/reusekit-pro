import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class CmaCustomerHistoryView extends StatefulWidget {
  const CmaCustomerHistoryView({super.key});

  @override
  State<CmaCustomerHistoryView> createState() => _CmaCustomerHistoryViewState();
}

class _CmaCustomerHistoryViewState extends State<CmaCustomerHistoryView> {
  String selectedCustomer = "customer_001";
  String selectedFilter = "";
  String selectedDateRange = "";
  String searchQuery = "";

  List<Map<String, dynamic>> customers = [
    {"label": "Tech Solutions Inc.", "value": "customer_001"},
    {"label": "Global Manufacturing Ltd.", "value": "customer_002"},
    {"label": "Retail Chain Corp", "value": "customer_003"},
    {"label": "Healthcare Partners", "value": "customer_004"},
    {"label": "Financial Services Group", "value": "customer_005"},
  ];

  List<Map<String, dynamic>> filterOptions = [
    {"label": "All Activities", "value": ""},
    {"label": "Orders", "value": "order"},
    {"label": "Payments", "value": "payment"},
    {"label": "Communications", "value": "communication"},
    {"label": "Support Tickets", "value": "support"},
    {"label": "Account Changes", "value": "account"},
  ];

  List<Map<String, dynamic>> dateRanges = [
    {"label": "All Time", "value": ""},
    {"label": "Last 7 Days", "value": "7d"},
    {"label": "Last 30 Days", "value": "30d"},
    {"label": "Last 90 Days", "value": "90d"},
    {"label": "This Year", "value": "year"},
  ];

  List<Map<String, dynamic>> historyData = [
    {
      "id": "1",
      "customerId": "customer_001",
      "type": "order",
      "title": "Order #ORD-2024-1205",
      "description": "New order placed for Software License Renewal - Enterprise Package",
      "amount": 25000.0,
      "status": "completed",
      "timestamp": "2024-12-15T10:30:00Z",
      "performedBy": "System",
      "details": {
        "orderId": "ORD-2024-1205",
        "items": 15,
        "deliveryDate": "2024-12-20",
        "paymentMethod": "Corporate Credit Card"
      }
    },
    {
      "id": "2",
      "customerId": "customer_001",
      "type": "payment",
      "title": "Payment Received",
      "description": "Payment of \$25,000.00 received for Order #ORD-2024-1205",
      "amount": 25000.0,
      "status": "completed",
      "timestamp": "2024-12-15T10:45:00Z",
      "performedBy": "Payment Gateway",
      "details": {
        "transactionId": "TXN-20241215-001",
        "paymentMethod": "Credit Card",
        "reference": "REF-CC-789456"
      }
    },
    {
      "id": "3",
      "customerId": "customer_001",
      "type": "communication",
      "title": "Email: Order Confirmation",
      "description": "Order confirmation email sent to customer contact",
      "amount": 0.0,
      "status": "sent",
      "timestamp": "2024-12-15T10:32:00Z",
      "performedBy": "Auto System",
      "details": {
        "emailType": "order_confirmation",
        "recipient": "john.doe@techsolutions.com",
        "templateUsed": "standard_confirmation"
      }
    },
    {
      "id": "4",
      "customerId": "customer_001",
      "type": "support",
      "title": "Support Ticket Created",
      "description": "Customer reported login issues with new software deployment",
      "amount": 0.0,
      "status": "in_progress",
      "timestamp": "2024-12-14T14:20:00Z",
      "performedBy": "Sarah Johnson",
      "details": {
        "ticketId": "SUP-2024-0542",
        "priority": "medium",
        "category": "technical_issue",
        "assignedTo": "Tech Support Team"
      }
    },
    {
      "id": "5",
      "customerId": "customer_001",
      "type": "account",
      "title": "Account Information Updated",
      "description": "Customer updated billing address and contact information",
      "amount": 0.0,
      "status": "completed",
      "timestamp": "2024-12-13T09:15:00Z",
      "performedBy": "John Smith",
      "details": {
        "fieldsUpdated": ["billing_address", "phone_number", "contact_person"],
        "previousAddress": "123 Old Street, City",
        "newAddress": "456 New Avenue, City"
      }
    },
    {
      "id": "6",
      "customerId": "customer_001",
      "type": "communication",
      "title": "Phone Call: Quarterly Review",
      "description": "Scheduled quarterly business review call completed",
      "amount": 0.0,
      "status": "completed",
      "timestamp": "2024-12-12T15:00:00Z",
      "performedBy": "Account Manager",
      "details": {
        "duration": "45 minutes",
        "callType": "quarterly_review",
        "outcome": "positive",
        "nextSteps": "Send renewal proposal"
      }
    },
    {
      "id": "7",
      "customerId": "customer_001",
      "type": "order",
      "title": "Order #ORD-2024-1128",
      "description": "Additional user licenses ordered - 10 seats",
      "amount": 5000.0,
      "status": "delivered",
      "timestamp": "2024-11-28T11:20:00Z",
      "performedBy": "System",
      "details": {
        "orderId": "ORD-2024-1128",
        "items": 10,
        "licenseType": "user_seat",
        "activationDate": "2024-11-30"
      }
    },
    {
      "id": "8",
      "customerId": "customer_001",
      "type": "support",
      "title": "Support Ticket Resolved",
      "description": "Integration setup assistance completed successfully",
      "amount": 0.0,
      "status": "resolved",
      "timestamp": "2024-11-25T16:30:00Z",
      "performedBy": "Technical Team",
      "details": {
        "ticketId": "SUP-2024-0498",
        "resolutionTime": "3 hours",
        "satisfactionRating": 5,
        "followupRequired": false
      }
    }
  ];

  List<Map<String, dynamic>> get filteredHistory {
    List<Map<String, dynamic>> filtered = historyData.where((item) => 
      item["customerId"] == selectedCustomer
    ).toList();
    
    if (selectedFilter.isNotEmpty) {
      filtered = filtered.where((item) => item["type"] == selectedFilter).toList();
    }
    
    if (searchQuery.isNotEmpty) {
      filtered = filtered.where((item) {
        return item["title"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
               item["description"].toString().toLowerCase().contains(searchQuery.toLowerCase());
      }).toList();
    }
    
    if (selectedDateRange.isNotEmpty) {
      DateTime now = DateTime.now();
      DateTime filterDate;
      
      switch (selectedDateRange) {
        case "7d":
          filterDate = now.subtract(Duration(days: 7));
          break;
        case "30d":
          filterDate = now.subtract(Duration(days: 30));
          break;
        case "90d":
          filterDate = now.subtract(Duration(days: 90));
          break;
        case "year":
          filterDate = DateTime(now.year, 1, 1);
          break;
        default:
          filterDate = DateTime(2000);
      }
      
      filtered = filtered.where((item) {
        DateTime itemDate = DateTime.parse(item["timestamp"]);
        return itemDate.isAfter(filterDate);
      }).toList();
    }
    
    return filtered..sort((a, b) => b["timestamp"].compareTo(a["timestamp"]));
  }

  Color _getTypeColor(String type) {
    switch (type) {
      case "order": return successColor;
      case "payment": return primaryColor;
      case "communication": return infoColor;
      case "support": return warningColor;
      case "account": return secondaryColor;
      default: return disabledBoldColor;
    }
  }

  String _getTypeLabel(String type) {
    switch (type) {
      case "order": return "Order";
      case "payment": return "Payment";
      case "communication": return "Communication";
      case "support": return "Support";
      case "account": return "Account";
      default: return "Activity";
    }
  }

  IconData _getTypeIcon(String type) {
    switch (type) {
      case "order": return Icons.shopping_cart;
      case "payment": return Icons.payment;
      case "communication": return Icons.message;
      case "support": return Icons.support_agent;
      case "account": return Icons.account_circle;
      default: return Icons.history;
    }
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "completed": return successColor;
      case "in_progress": return warningColor;
      case "pending": return infoColor;
      case "cancelled": return dangerColor;
      case "delivered": return primaryColor;
      case "sent": return infoColor;
      case "resolved": return successColor;
      default: return disabledBoldColor;
    }
  }

  void _showHistoryDetails(Map<String, dynamic> historyItem) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("${historyItem["title"]}"),
        content: SingleChildScrollView(
          child: Column(
            spacing: spSm,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "${historyItem["description"]}",
                style: TextStyle(
                  fontSize: 14,
                  color: disabledBoldColor,
                ),
              ),
              Divider(),
              Text(
                "Details:",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              ...((historyItem["details"] as Map<String, dynamic>).entries.map((entry) {
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 120,
                      child: Text(
                        "${entry.key.replaceAll('_', ' ').toUpperCase()}:",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: disabledBoldColor,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        "${entry.value}",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                    ),
                  ],
                );
              }).toList()),
              Divider(),
              Row(
                children: [
                  Text(
                    "Status: ",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: disabledBoldColor,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                    decoration: BoxDecoration(
                      color: _getStatusColor(historyItem["status"]).withAlpha(30),
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                    child: Text(
                      "${historyItem["status"]}".toUpperCase(),
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                        color: _getStatusColor(historyItem["status"]),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        actions: [
          QButton(
            label: "Close",
            size: bs.sm,
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Map<String, int> typeStats = {};
    double totalAmount = 0;
    
    for (var item in filteredHistory) {
      String type = item["type"];
      typeStats[type] = (typeStats[type] ?? 0) + 1;
      totalAmount += (item["amount"] as double);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Customer History"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: primaryColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusSm),
                border: Border.all(color: primaryColor.withAlpha(100)),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.history,
                    color: primaryColor,
                    size: 20,
                  ),
                  SizedBox(width: spXs),
                  Expanded(
                    child: Text(
                      "View complete activity history and interactions for each customer",
                      style: TextStyle(
                        color: primaryColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            QDropdownField(
              label: "Select Customer",
              items: customers,
              value: selectedCustomer,
              onChanged: (value, label) {
                selectedCustomer = value;
                setState(() {});
              },
            ),

            Row(
              children: [
                Expanded(
                  child: QTextField(
                    label: "Search History",
                    value: searchQuery,
                    hint: "Search activities...",
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
                SizedBox(width: spSm),
                Expanded(
                  child: QDropdownField(
                    label: "Date Range",
                    items: dateRanges,
                    value: selectedDateRange,
                    onChanged: (value, label) {
                      selectedDateRange = value;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),

            QHorizontalScroll(
              children: [
                Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: primaryColor.withAlpha(30),
                    borderRadius: BorderRadius.circular(radiusSm),
                    border: Border.all(color: primaryColor.withAlpha(100)),
                  ),
                  child: Column(
                    children: [
                      Text(
                        "${filteredHistory.length}",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "Total Activities",
                        style: TextStyle(
                          fontSize: 12,
                          color: primaryColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                
                Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: successColor.withAlpha(30),
                    borderRadius: BorderRadius.circular(radiusSm),
                    border: Border.all(color: successColor.withAlpha(100)),
                  ),
                  child: Column(
                    children: [
                      Text(
                        "\$${(totalAmount / 1000).toStringAsFixed(1)}K",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: successColor,
                        ),
                      ),
                      Text(
                        "Total Value",
                        style: TextStyle(
                          fontSize: 12,
                          color: successColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),

                if (typeStats["order"] != null)
                  Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: infoColor.withAlpha(30),
                      borderRadius: BorderRadius.circular(radiusSm),
                      border: Border.all(color: infoColor.withAlpha(100)),
                    ),
                    child: Column(
                      children: [
                        Text(
                          "${typeStats["order"]}",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: infoColor,
                          ),
                        ),
                        Text(
                          "Orders",
                          style: TextStyle(
                            fontSize: 12,
                            color: infoColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),

                if (typeStats["support"] != null)
                  Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: warningColor.withAlpha(30),
                      borderRadius: BorderRadius.circular(radiusSm),
                      border: Border.all(color: warningColor.withAlpha(100)),
                    ),
                    child: Column(
                      children: [
                        Text(
                          "${typeStats["support"]}",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: warningColor,
                          ),
                        ),
                        Text(
                          "Support Tickets",
                          style: TextStyle(
                            fontSize: 12,
                            color: warningColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),

            Column(
              spacing: spSm,
              children: filteredHistory.map((historyItem) {
                Color typeColor = _getTypeColor(historyItem["type"]);
                Color statusColor = _getStatusColor(historyItem["status"]);
                
                return GestureDetector(
                  onTap: () => _showHistoryDetails(historyItem),
                  child: Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusSm),
                      boxShadow: [shadowSm],
                      border: Border(
                        left: BorderSide(
                          width: 4,
                          color: typeColor,
                        ),
                      ),
                    ),
                    child: Column(
                      spacing: spSm,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: EdgeInsets.all(spXs),
                              decoration: BoxDecoration(
                                color: typeColor.withAlpha(30),
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Icon(
                                _getTypeIcon(historyItem["type"]),
                                size: 16,
                                color: typeColor,
                              ),
                            ),
                            SizedBox(width: spSm),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                              decoration: BoxDecoration(
                                color: typeColor.withAlpha(30),
                                borderRadius: BorderRadius.circular(radiusXs),
                                border: Border.all(color: typeColor.withAlpha(100)),
                              ),
                              child: Text(
                                _getTypeLabel(historyItem["type"]),
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                  color: typeColor,
                                ),
                              ),
                            ),
                            Spacer(),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                              decoration: BoxDecoration(
                                color: statusColor.withAlpha(30),
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Text(
                                "${historyItem["status"]}".toUpperCase(),
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                  color: statusColor,
                                ),
                              ),
                            ),
                            SizedBox(width: spSm),
                            Icon(
                              Icons.chevron_right,
                              color: disabledBoldColor,
                              size: 20,
                            ),
                          ],
                        ),
                        
                        Text(
                          "${historyItem["title"]}",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        
                        Text(
                          "${historyItem["description"]}",
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                          ),
                        ),

                        Row(
                          children: [
                            if ((historyItem["amount"] as double) > 0)
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                                decoration: BoxDecoration(
                                  color: successColor.withAlpha(30),
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: Text(
                                  "\$${(historyItem["amount"] as double).currency}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: successColor,
                                  ),
                                ),
                              ),
                            Spacer(),
                            Text(
                              "By ${historyItem["performedBy"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                            SizedBox(width: spSm),
                            Text(
                              "${DateTime.parse(historyItem["timestamp"]).dMMMy}",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),

            if (filteredHistory.isEmpty)
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(spLg),
                child: Column(
                  children: [
                    Icon(
                      Icons.history_outlined,
                      size: 48,
                      color: disabledColor,
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "No history found",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "Try adjusting your filters or select a different customer",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
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
}
