import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class PosCustomerHistoryView extends StatefulWidget {
  const PosCustomerHistoryView({super.key});

  @override
  State<PosCustomerHistoryView> createState() => _PosCustomerHistoryViewState();
}

class _PosCustomerHistoryViewState extends State<PosCustomerHistoryView> {
  int currentTab = 0;
  String selectedStatus = "All";
  String selectedPeriod = "All Time";
  DateTime? startDate;
  DateTime? endDate;

  // Customer Information
  Map<String, dynamic> customer = {
    "id": "CUST-001",
    "name": "Sarah Johnson",
    "email": "sarah.johnson@email.com",
    "tier": "VIP",
    "totalOrders": 47,
    "totalSpent": 3450.75,
    "memberSince": "2022-03-15",
  };

  List<Map<String, dynamic>> statusOptions = [
    {"label": "All", "value": "All"},
    {"label": "Completed", "value": "Completed"},
    {"label": "Processing", "value": "Processing"},
    {"label": "Shipped", "value": "Shipped"},
    {"label": "Delivered", "value": "Delivered"},
    {"label": "Cancelled", "value": "Cancelled"},
    {"label": "Returned", "value": "Returned"},
  ];

  List<Map<String, dynamic>> periodOptions = [
    {"label": "All Time", "value": "All Time"},
    {"label": "Last 30 Days", "value": "30 Days"},
    {"label": "Last 90 Days", "value": "90 Days"},
    {"label": "Last Year", "value": "1 Year"},
    {"label": "Custom Range", "value": "Custom"},
  ];

  // Order History
  List<Map<String, dynamic>> orderHistory = [
    {
      "id": "ORD-2024-0847",
      "date": "2024-06-18",
      "status": "Delivered",
      "items": [
        {"name": "Premium Headphones", "quantity": 1, "price": 89.99},
        {"name": "Wireless Charger", "quantity": 1, "price": 29.99},
        {"name": "Phone Case", "quantity": 1, "price": 14.99},
      ],
      "subtotal": 134.97,
      "tax": 10.80,
      "shipping": 0.00,
      "total": 145.77,
      "paymentMethod": "Credit Card",
      "shippingAddress": "123 Main St, New York, NY 10001",
      "trackingNumber": "TRK789456123",
    },
    {
      "id": "ORD-2024-0823",
      "date": "2024-06-15",
      "status": "Delivered",
      "items": [
        {"name": "Bluetooth Speaker", "quantity": 1, "price": 59.99},
        {"name": "USB Cable", "quantity": 2, "price": 12.50},
      ],
      "subtotal": 85.49,
      "tax": 6.84,
      "shipping": 5.00,
      "total": 97.33,
      "paymentMethod": "Credit Card",
      "shippingAddress": "123 Main St, New York, NY 10001",
      "trackingNumber": "TRK789456124",
    },
    {
      "id": "ORD-2024-0801",
      "date": "2024-06-12",
      "status": "Delivered",
      "items": [
        {"name": "Smart Watch", "quantity": 1, "price": 199.99},
        {"name": "Watch Band", "quantity": 2, "price": 19.99},
        {"name": "Screen Protector", "quantity": 1, "price": 9.99},
      ],
      "subtotal": 249.96,
      "tax": 20.00,
      "shipping": 0.00,
      "total": 269.96,
      "paymentMethod": "Credit Card",
      "shippingAddress": "123 Main St, New York, NY 10001",
      "trackingNumber": "TRK789456125",
    },
    {
      "id": "ORD-2024-0785",
      "date": "2024-06-08",
      "status": "Returned",
      "items": [
        {"name": "Laptop Stand", "quantity": 1, "price": 45.99},
      ],
      "subtotal": 45.99,
      "tax": 3.68,
      "shipping": 5.99,
      "total": 55.66,
      "paymentMethod": "Debit Card",
      "shippingAddress": "123 Main St, New York, NY 10001",
      "trackingNumber": "TRK789456126",
    },
    {
      "id": "ORD-2024-0762",
      "date": "2024-06-05",
      "status": "Delivered",
      "items": [
        {"name": "Gaming Mouse", "quantity": 1, "price": 79.99},
        {"name": "Mouse Pad", "quantity": 1, "price": 24.99},
        {"name": "Keyboard", "quantity": 1, "price": 129.99},
      ],
      "subtotal": 234.97,
      "tax": 18.80,
      "shipping": 0.00,
      "total": 253.77,
      "paymentMethod": "Credit Card",
      "shippingAddress": "123 Main St, New York, NY 10001",
      "trackingNumber": "TRK789456127",
    },
  ];

  // Payment History
  List<Map<String, dynamic>> paymentHistory = [
    {
      "id": "PAY-2024-0847",
      "orderId": "ORD-2024-0847",
      "date": "2024-06-18",
      "amount": 145.77,
      "method": "Credit Card",
      "status": "Completed",
      "transactionId": "TXN789456123",
      "cardLast4": "1234",
    },
    {
      "id": "PAY-2024-0823",
      "orderId": "ORD-2024-0823",
      "date": "2024-06-15",
      "amount": 97.33,
      "method": "Credit Card",
      "status": "Completed",
      "transactionId": "TXN789456124",
      "cardLast4": "1234",
    },
    {
      "id": "PAY-2024-0801",
      "orderId": "ORD-2024-0801",
      "date": "2024-06-12",
      "amount": 269.96,
      "method": "Credit Card",
      "status": "Completed",
      "transactionId": "TXN789456125",
      "cardLast4": "1234",
    },
    {
      "id": "REF-2024-0785",
      "orderId": "ORD-2024-0785",
      "date": "2024-06-10",
      "amount": -55.66,
      "method": "Credit Card Refund",
      "status": "Completed",
      "transactionId": "REF789456126",
      "cardLast4": "5678",
    },
    {
      "id": "PAY-2024-0762",
      "orderId": "ORD-2024-0762",
      "date": "2024-06-05",
      "amount": 253.77,
      "method": "Credit Card",
      "status": "Completed",
      "transactionId": "TXN789456127",
      "cardLast4": "1234",
    },
  ];

  List<Map<String, dynamic>> get filteredOrders {
    return orderHistory.where((order) {
      bool matchesStatus = selectedStatus == "All" || order["status"] == selectedStatus;
      bool matchesPeriod = true;
      
      if (selectedPeriod != "All Time") {
        DateTime orderDate = DateTime.parse(order["date"]);
        DateTime now = DateTime.now();
        
        switch (selectedPeriod) {
          case "30 Days":
            matchesPeriod = orderDate.isAfter(now.subtract(Duration(days: 30)));
            break;
          case "90 Days":
            matchesPeriod = orderDate.isAfter(now.subtract(Duration(days: 90)));
            break;
          case "1 Year":
            matchesPeriod = orderDate.isAfter(now.subtract(Duration(days: 365)));
            break;
          case "Custom":
            if (startDate != null && endDate != null) {
              matchesPeriod = orderDate.isAfter(startDate!) && orderDate.isBefore(endDate!.add(Duration(days: 1)));
            }
            break;
        }
      }
      
      return matchesStatus && matchesPeriod;
    }).toList();
  }

  Color getStatusColor(String status) {
    switch (status) {
      case "Completed":
      case "Delivered":
        return successColor;
      case "Processing":
        return warningColor;
      case "Shipped":
        return infoColor;
      case "Cancelled":
      case "Returned":
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  Widget _buildOrdersTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Filters
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
                      child: QDropdownField(
                        label: "Filter by Status",
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
                        label: "Time Period",
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
                if (selectedPeriod == "Custom")
                  Row(
                    children: [
                      Expanded(
                        child: QDatePicker(
                          label: "Start Date",
                          value: startDate,
                          onChanged: (value) {
                            startDate = value;
                            setState(() {});
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QDatePicker(
                          label: "End Date",
                          value: endDate,
                          onChanged: (value) {
                            endDate = value;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
              ],
            ),
          ),

          // Order Statistics
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
                  "Order Statistics",
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
                            "${filteredOrders.length}",
                            style: TextStyle(
                              fontSize: fsH5,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          Text(
                            "Total Orders",
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
                            "\$${((filteredOrders.fold(0.0, (sum, order) => sum + (order["total"] as num).toDouble())).currency)}",
                            style: TextStyle(
                              fontSize: fsH5,
                              fontWeight: FontWeight.bold,
                              color: successColor,
                            ),
                          ),
                          Text(
                            "Total Spent",
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
                            "\$${filteredOrders.isNotEmpty ? ((filteredOrders.fold(0.0, (sum, order) => sum + (order["total"] as num).toDouble()) / filteredOrders.length).toStringAsFixed(2)) : "0.00"}",
                            style: TextStyle(
                              fontSize: fsH5,
                              fontWeight: FontWeight.bold,
                              color: warningColor,
                            ),
                          ),
                          Text(
                            "Avg Order",
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

          // Orders List
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
                  child: Text(
                    "Order History (${filteredOrders.length})",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                ),
                ...filteredOrders.map((order) {
                  return Container(
                    margin: EdgeInsets.only(
                      left: spSm,
                      right: spSm,
                      bottom: spSm,
                    ),
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: disabledOutlineBorderColor,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Column(
                      spacing: spXs,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                "${order["id"]}",
                                style: TextStyle(
                                  fontSize: fsH6,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: spXs,
                                vertical: 2,
                              ),
                              decoration: BoxDecoration(
                                color: getStatusColor(order["status"]).withAlpha(20),
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Text(
                                "${order["status"]}",
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                  color: getStatusColor(order["status"]),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.calendar_today,
                              size: 14,
                              color: disabledBoldColor,
                            ),
                            SizedBox(width: spXs),
                            Text(
                              "${DateTime.parse(order["date"]).dMMMy}",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                            SizedBox(width: spSm),
                            Icon(
                              Icons.payment,
                              size: 14,
                              color: disabledBoldColor,
                            ),
                            SizedBox(width: spXs),
                            Text(
                              "${order["paymentMethod"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                        Text(
                          "Items: ${(order["items"] as List).map((item) => "${item["quantity"]}x ${item["name"]}").join(", ")}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                        if (order["trackingNumber"] != null)
                          Row(
                            children: [
                              Icon(
                                Icons.local_shipping,
                                size: 14,
                                color: disabledBoldColor,
                              ),
                              SizedBox(width: spXs),
                              Text(
                                "Tracking: ${order["trackingNumber"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        Row(
                          children: [
                            Text(
                              "${(order["items"] as List).length} items",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                            Spacer(),
                            Text(
                              "\$${((order["total"] as num).toDouble()).currency}",
                              style: TextStyle(
                                fontSize: fsH6,
                                fontWeight: FontWeight.bold,
                                color: successColor,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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
                  child: Text(
                    "Payment History",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                ),
                ...paymentHistory.map((payment) {
                  return Container(
                    margin: EdgeInsets.only(
                      left: spSm,
                      right: spSm,
                      bottom: spSm,
                    ),
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: disabledOutlineBorderColor,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Column(
                      spacing: spXs,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                "${payment["id"]}",
                                style: TextStyle(
                                  fontSize: fsH6,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: spXs,
                                vertical: 2,
                              ),
                              decoration: BoxDecoration(
                                color: successColor.withAlpha(20),
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Text(
                                "${payment["status"]}",
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                  color: successColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Text(
                          "Order: ${payment["orderId"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.calendar_today,
                              size: 14,
                              color: disabledBoldColor,
                            ),
                            SizedBox(width: spXs),
                            Text(
                              "${DateTime.parse(payment["date"]).dMMMy}",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                            SizedBox(width: spSm),
                            Icon(
                              Icons.payment,
                              size: 14,
                              color: disabledBoldColor,
                            ),
                            SizedBox(width: spXs),
                            Text(
                              "${payment["method"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                        if (payment["cardLast4"] != null)
                          Text(
                            "Card ending in ${payment["cardLast4"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                        Row(
                          children: [
                            Text(
                              "Transaction: ${payment["transactionId"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                            Spacer(),
                            Text(
                              "${(payment["amount"] as num) >= 0 ? '\$' : '-\$'}${((payment["amount"] as num).abs().toDouble()).currency}",
                              style: TextStyle(
                                fontSize: fsH6,
                                fontWeight: FontWeight.bold,
                                color: (payment["amount"] as num) >= 0 ? successColor : dangerColor,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                }).toList(),
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Customer Overview
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
                  "Customer Overview",
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
                            "${customer["totalOrders"]}",
                            style: TextStyle(
                              fontSize: fsH4,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          Text(
                            "Total Orders",
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
                            "\$${((customer["totalSpent"] as num).toDouble()).currency}",
                            style: TextStyle(
                              fontSize: fsH4,
                              fontWeight: FontWeight.bold,
                              color: successColor,
                            ),
                          ),
                          Text(
                            "Total Spent",
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
                    Text(
                      "Member Since:",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(width: spSm),
                    Text(
                      "${DateTime.parse(customer["memberSince"]).dMMMy}",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Quick Actions
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
                  "Quick Actions",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spSm),
                Column(
                  spacing: spXs,
                  children: [
                    Container(
                      width: double.infinity,
                      child: QButton(
                        label: "View Customer Profile",
                        icon: Icons.person,
                        onPressed: () {
                          //navigateTo('PosCustomerProfileView')
                        },
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      child: QButton(
                        label: "Create New Order",
                        icon: Icons.add_shopping_cart,
                        onPressed: () {
                          //navigateTo('CreateOrderView')
                        },
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      child: QButton(
                        label: "Send Email",
                        icon: Icons.email,
                        onPressed: () {
                          //navigateTo('SendEmailView')
                        },
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      child: QButton(
                        label: "Export History",
                        icon: Icons.download,
                        onPressed: () {
                          //exportCustomerHistory()
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "${customer["name"]} - History",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Orders", icon: Icon(Icons.shopping_bag)),
        Tab(text: "Payments", icon: Icon(Icons.payment)),
        Tab(text: "Summary", icon: Icon(Icons.analytics)),
      ],
      tabChildren: [
        _buildOrdersTab(),
        _buildPaymentsTab(),
        _buildSummaryTab(),
      ],
      onInit: (tabController) {
        // Optional: Access to TabController if needed
      },
    );
  }
}
