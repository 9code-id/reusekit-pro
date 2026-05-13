import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class CrmCustomerHistoryView extends StatefulWidget {
  const CrmCustomerHistoryView({super.key});

  @override
  State<CrmCustomerHistoryView> createState() => _CrmCustomerHistoryViewState();
}

class _CrmCustomerHistoryViewState extends State<CrmCustomerHistoryView> {
  int selectedTab = 0;
  bool loading = false;
  String selectedFilter = "all";
  String selectedPeriod = "all_time";

  Map<String, dynamic> customer = {
    "firstName": "John",
    "lastName": "Smith",
    "email": "john.smith@email.com",
    "profileImage": "https://picsum.photos/200/200?random=1&keyword=person"
  };

  List<Map<String, dynamic>> filterOptions = [
    {"label": "All Activities", "value": "all"},
    {"label": "Orders", "value": "orders"},
    {"label": "Payments", "value": "payments"},
    {"label": "Communications", "value": "communications"},
    {"label": "Support", "value": "support"},
  ];

  List<Map<String, dynamic>> periodOptions = [
    {"label": "All Time", "value": "all_time"},
    {"label": "Last 30 Days", "value": "30_days"},
    {"label": "Last 90 Days", "value": "90_days"},
    {"label": "This Year", "value": "this_year"},
    {"label": "Last Year", "value": "last_year"},
  ];

  List<Map<String, dynamic>> orderHistory = [
    {
      "id": "ORD-2024-156",
      "date": "2024-06-15",
      "amount": 2850.00,
      "status": "Completed",
      "items": [
        {"name": "Premium Service Package", "quantity": 1, "price": 2000.00},
        {"name": "Consultation Hours", "quantity": 5, "price": 850.00}
      ]
    },
    {
      "id": "ORD-2024-143",
      "date": "2024-06-01",
      "amount": 1200.00,
      "status": "Delivered",
      "items": [
        {"name": "Basic Service Package", "quantity": 1, "price": 800.00},
        {"name": "Setup Fee", "quantity": 1, "price": 400.00}
      ]
    },
    {
      "id": "ORD-2024-128",
      "date": "2024-05-20",
      "amount": 3500.00,
      "status": "Completed",
      "items": [
        {"name": "Enterprise Package", "quantity": 1, "price": 3000.00},
        {"name": "Training Sessions", "quantity": 2, "price": 500.00}
      ]
    },
    {
      "id": "ORD-2024-112",
      "date": "2024-05-05",
      "amount": 950.00,
      "status": "Refunded",
      "items": [
        {"name": "Support Package", "quantity": 1, "price": 950.00}
      ]
    }
  ];

  List<Map<String, dynamic>> paymentHistory = [
    {
      "id": "PAY-2024-089",
      "orderId": "ORD-2024-156",
      "date": "2024-06-15",
      "amount": 2850.00,
      "method": "Credit Card",
      "status": "Successful"
    },
    {
      "id": "PAY-2024-076",
      "orderId": "ORD-2024-143",
      "date": "2024-06-01",
      "amount": 1200.00,
      "method": "Bank Transfer",
      "status": "Successful"
    },
    {
      "id": "PAY-2024-064",
      "orderId": "ORD-2024-128",
      "date": "2024-05-20",
      "amount": 3500.00,
      "method": "Credit Card",
      "status": "Successful"
    },
    {
      "id": "REF-2024-015",
      "orderId": "ORD-2024-112",
      "date": "2024-05-12",
      "amount": -950.00,
      "method": "Credit Card Refund",
      "status": "Processed"
    }
  ];

  List<Map<String, dynamic>> communications = [
    {
      "type": "Email",
      "subject": "Order confirmation #ORD-2024-156",
      "date": "2024-06-15",
      "direction": "Outbound",
      "status": "Delivered"
    },
    {
      "type": "Phone Call",
      "subject": "Product consultation discussion",
      "date": "2024-06-10",
      "direction": "Inbound",
      "status": "Completed",
      "duration": "25 minutes"
    },
    {
      "type": "Email",
      "subject": "Technical support request",
      "date": "2024-06-08",
      "direction": "Inbound",
      "status": "Resolved"
    },
    {
      "type": "Meeting",
      "subject": "Quarterly business review",
      "date": "2024-05-25",
      "direction": "Scheduled",
      "status": "Completed",
      "duration": "1 hour"
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Customer History"),
        actions: [
          QButton(
            icon: Icons.download,
            size: bs.sm,
            onPressed: () => _exportHistory(),
          ),
          SizedBox(width: spSm),
        ],
      ),
      body: loading
          ? Center(child: CircularProgressIndicator())
          : Column(
              children: [
                // Customer Header
                _buildCustomerHeader(),
                
                // Filters
                _buildFilters(),
                
                // Tab Navigation
                _buildTabNavigation(),
                
                // Content
                Expanded(
                  child: _buildTabContent(),
                ),
              ],
            ),
    );
  }

  Widget _buildCustomerHeader() {
    return Container(
      padding: EdgeInsets.all(spMd),
      color: Colors.white,
      child: Row(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(radiusMd),
              child: Image.network(
                "${customer["profileImage"]}",
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(width: spMd),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${customer["firstName"]} ${customer["lastName"]}",
                  style: TextStyle(
                    fontSize: fsH5,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spXs),
                Text(
                  "${customer["email"]}",
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
              color: successColor.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Text(
              "VIP Customer",
              style: TextStyle(
                fontSize: 12,
                color: successColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilters() {
    return Container(
      padding: EdgeInsets.all(spMd),
      color: Colors.white,
      child: Column(
        spacing: spSm,
        children: [
          Row(
            children: [
              Expanded(
                child: QDropdownField(
                  label: "Filter by Type",
                  items: filterOptions,
                  value: selectedFilter,
                  onChanged: (value, label) {
                    selectedFilter = value;
                    _applyFilters();
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QDropdownField(
                  label: "Time Period",
                  items: periodOptions,
                  value: selectedPeriod,
                  onChanged: (value, label) {
                    selectedPeriod = value;
                    _applyFilters();
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTabNavigation() {
    return Container(
      color: Colors.white,
      child: Row(
        children: [
          _buildTabButton("Orders", 0),
          _buildTabButton("Payments", 1),
          _buildTabButton("Communications", 2),
        ],
      ),
    );
  }

  Widget _buildTabButton(String title, int index) {
    bool isSelected = selectedTab == index;
    return Expanded(
      child: GestureDetector(
        onTap: () {
          selectedTab = index;
          setState(() {});
        },
        child: Container(
          padding: EdgeInsets.symmetric(vertical: spSm, horizontal: spMd),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: isSelected ? primaryColor : Colors.transparent,
                width: 2,
              ),
            ),
          ),
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              color: isSelected ? primaryColor : disabledBoldColor,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTabContent() {
    switch (selectedTab) {
      case 0:
        return _buildOrderHistoryTab();
      case 1:
        return _buildPaymentHistoryTab();
      case 2:
        return _buildCommunicationsTab();
      default:
        return _buildOrderHistoryTab();
    }
  }

  Widget _buildOrderHistoryTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                "Order History",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Spacer(),
              Text(
                "${orderHistory.length} orders",
                style: TextStyle(
                  fontSize: 14,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
          SizedBox(height: spMd),
          ...orderHistory.map((order) => _buildOrderHistoryItem(order)),
        ],
      ),
    );
  }

  Widget _buildOrderHistoryItem(Map<String, dynamic> order) {
    return Container(
      margin: EdgeInsets.only(bottom: spMd),
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Order Header
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: primaryColor.withAlpha(10),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Icon(
                  Icons.shopping_bag,
                  color: primaryColor,
                  size: 20,
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${order["id"]}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "${DateTime.parse(order["date"]).dMMMy}",
                      style: TextStyle(
                        fontSize: 12,
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
                    "\$${(order["amount"] as double).currency}",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: successColor,
                    ),
                  ),
                  SizedBox(height: spXs),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                    decoration: BoxDecoration(
                      color: _getOrderStatusColor(order["status"]).withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                    child: Text(
                      "${order["status"]}",
                      style: TextStyle(
                        fontSize: 10,
                        color: _getOrderStatusColor(order["status"]),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          
          SizedBox(height: spSm),
          
          // Order Items
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(5),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Items",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: disabledBoldColor,
                  ),
                ),
                SizedBox(height: spXs),
                ...(order["items"] as List).map((item) => Container(
                  margin: EdgeInsets.only(bottom: spXs),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          "${item["name"]} (${item["quantity"]}x)",
                          style: TextStyle(
                            fontSize: 12,
                            color: primaryColor,
                          ),
                        ),
                      ),
                      Text(
                        "\$${(item["price"] as double).currency}",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                )),
              ],
            ),
          ),
          
          SizedBox(height: spSm),
          
          // Actions
          Row(
            children: [
              Expanded(
                child: QButton(
                  label: "View Details",
                  size: bs.sm,
                  onPressed: () => _viewOrderDetails(order["id"]),
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QButton(
                  label: "Reorder",
                  size: bs.sm,
                  onPressed: () => _reorderItems(order["id"]),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentHistoryTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                "Payment History",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Spacer(),
              Text(
                "${paymentHistory.length} transactions",
                style: TextStyle(
                  fontSize: 14,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
          SizedBox(height: spMd),
          ...paymentHistory.map((payment) => _buildPaymentItem(payment)),
        ],
      ),
    );
  }

  Widget _buildPaymentItem(Map<String, dynamic> payment) {
    bool isRefund = (payment["amount"] as double) < 0;
    Color amountColor = isRefund ? dangerColor : successColor;
    IconData icon = isRefund ? Icons.money_off : Icons.payment;
    
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: disabledOutlineBorderColor),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: amountColor.withAlpha(10),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Icon(
              icon,
              color: amountColor,
              size: 20,
            ),
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${payment["id"]}",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spXs),
                Text(
                  "${payment["method"]} • ${DateTime.parse(payment["date"]).dMMMy}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
                if (payment["orderId"] != null) ...[
                  SizedBox(height: spXs),
                  Text(
                    "Order: ${payment["orderId"]}",
                    style: TextStyle(
                      fontSize: 11,
                      color: infoColor,
                    ),
                  ),
                ],
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                "${isRefund ? '' : '+'}\$${((payment["amount"] as double).abs()).currency}",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: amountColor,
                ),
              ),
              SizedBox(height: spXs),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                decoration: BoxDecoration(
                  color: _getPaymentStatusColor(payment["status"]).withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "${payment["status"]}",
                  style: TextStyle(
                    fontSize: 10,
                    color: _getPaymentStatusColor(payment["status"]),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCommunicationsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                "Communication History",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Spacer(),
              QButton(
                label: "Add Note",
                size: bs.sm,
                onPressed: () => _addCommunication(),
              ),
            ],
          ),
          SizedBox(height: spMd),
          ...communications.map((comm) => _buildCommunicationItem(comm)),
        ],
      ),
    );
  }

  Widget _buildCommunicationItem(Map<String, dynamic> comm) {
    IconData icon;
    Color iconColor;
    
    switch (comm["type"]) {
      case "Email":
        icon = Icons.email;
        iconColor = infoColor;
        break;
      case "Phone Call":
        icon = Icons.call;
        iconColor = successColor;
        break;
      case "Meeting":
        icon = Icons.people;
        iconColor = primaryColor;
        break;
      default:
        icon = Icons.chat;
        iconColor = disabledBoldColor;
    }

    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: disabledOutlineBorderColor),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: iconColor.withAlpha(10),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Icon(
              icon,
              color: iconColor,
              size: 20,
            ),
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${comm["subject"]}",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spXs),
                Row(
                  children: [
                    Text(
                      "${comm["type"]} • ${comm["direction"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    if (comm["duration"] != null) ...[
                      Text(
                        " • ${comm["duration"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ],
                ),
                SizedBox(height: spXs),
                Text(
                  "${DateTime.parse(comm["date"]).dMMMy}",
                  style: TextStyle(
                    fontSize: 11,
                    color: disabledColor,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
            decoration: BoxDecoration(
              color: _getCommunicationStatusColor(comm["status"]).withAlpha(20),
              borderRadius: BorderRadius.circular(radiusXs),
            ),
            child: Text(
              "${comm["status"]}",
              style: TextStyle(
                fontSize: 10,
                color: _getCommunicationStatusColor(comm["status"]),
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Color _getOrderStatusColor(String status) {
    switch (status.toLowerCase()) {
      case "completed":
        return successColor;
      case "delivered":
        return infoColor;
      case "pending":
        return warningColor;
      case "cancelled":
        return dangerColor;
      case "refunded":
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  Color _getPaymentStatusColor(String status) {
    switch (status.toLowerCase()) {
      case "successful":
        return successColor;
      case "processed":
        return infoColor;
      case "pending":
        return warningColor;
      case "failed":
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  Color _getCommunicationStatusColor(String status) {
    switch (status.toLowerCase()) {
      case "completed":
      case "delivered":
      case "resolved":
        return successColor;
      case "pending":
        return warningColor;
      case "failed":
        return dangerColor;
      default:
        return infoColor;
    }
  }

  void _applyFilters() {
    loading = true;
    setState(() {});
    
    // Simulate filter processing
    Future.delayed(Duration(milliseconds: 500), () {
      loading = false;
      setState(() {});
    });
  }

  void _exportHistory() {
    ss("History exported successfully");
  }

  void _viewOrderDetails(String orderId) {
    si("View order details: $orderId");
  }

  void _reorderItems(String orderId) {
    si("Reorder items from: $orderId");
  }

  void _addCommunication() {
    si("Add new communication");
  }
}
