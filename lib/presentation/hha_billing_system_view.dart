import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class HhaBillingSystemView extends StatefulWidget {
  const HhaBillingSystemView({super.key});

  @override
  State<HhaBillingSystemView> createState() => _HhaBillingSystemViewState();
}

class _HhaBillingSystemViewState extends State<HhaBillingSystemView> {
  int selectedTab = 0;
  String selectedStatus = "All";
  String selectedPaymentMethod = "All";
  DateTime selectedDate = DateTime.now();
  
  List<Map<String, dynamic>> statusOptions = [
    {"label": "All", "value": "All"},
    {"label": "Pending", "value": "Pending"},
    {"label": "Paid", "value": "Paid"},
    {"label": "Overdue", "value": "Overdue"},
    {"label": "Cancelled", "value": "Cancelled"},
  ];

  List<Map<String, dynamic>> paymentOptions = [
    {"label": "All", "value": "All"},
    {"label": "Credit Card", "value": "Credit Card"},
    {"label": "Cash", "value": "Cash"},
    {"label": "Bank Transfer", "value": "Bank Transfer"},
    {"label": "Digital Wallet", "value": "Digital Wallet"},
  ];

  List<Map<String, dynamic>> billingStats = [
    {
      "title": "Today's Revenue",
      "value": 15750,
      "icon": Icons.attach_money,
      "color": successColor,
      "currency": true,
    },
    {
      "title": "Pending Bills",
      "value": 23,
      "icon": Icons.pending,
      "color": warningColor,
    },
    {
      "title": "Overdue",
      "value": 5,
      "icon": Icons.warning,
      "color": dangerColor,
    },
    {
      "title": "Completion Rate",
      "value": 94,
      "icon": Icons.trending_up,
      "color": primaryColor,
      "percentage": true,
    },
  ];

  List<Map<String, dynamic>> bills = [
    {
      "id": "INV-2024-001",
      "roomNumber": "301",
      "guestName": "John Smith",
      "checkIn": "2024-01-15",
      "checkOut": "2024-01-18",
      "status": "Pending",
      "total": 850.00,
      "paid": 0.00,
      "paymentMethod": null,
      "dueDate": "2024-01-18",
      "services": [
        {"name": "Room Charges", "amount": 600.00, "nights": 3},
        {"name": "Minibar", "amount": 45.00, "items": 3},
        {"name": "Laundry Service", "amount": 25.00, "items": 2},
        {"name": "Wi-Fi Premium", "amount": 30.00, "days": 3},
        {"name": "Room Service", "amount": 80.00, "orders": 2},
        {"name": "Parking", "amount": 60.00, "days": 3},
        {"name": "Tax", "amount": 10.00, "rate": "12%"},
      ],
    },
    {
      "id": "INV-2024-002",
      "roomNumber": "156",
      "guestName": "Sarah Johnson",
      "checkIn": "2024-01-14",
      "checkOut": "2024-01-16",
      "status": "Paid",
      "total": 420.00,
      "paid": 420.00,
      "paymentMethod": "Credit Card",
      "dueDate": "2024-01-16",
      "services": [
        {"name": "Room Charges", "amount": 400.00, "nights": 2},
        {"name": "Tax", "amount": 20.00, "rate": "5%"},
      ],
    },
    {
      "id": "INV-2024-003",
      "roomNumber": "204",
      "guestName": "Mike Davis",
      "checkIn": "2024-01-10",
      "checkOut": "2024-01-15",
      "status": "Overdue",
      "total": 1250.00,
      "paid": 0.00,
      "paymentMethod": null,
      "dueDate": "2024-01-15",
      "services": [
        {"name": "Room Charges", "amount": 1000.00, "nights": 5},
        {"name": "Spa Services", "amount": 150.00, "sessions": 2},
        {"name": "Restaurant", "amount": 80.00, "meals": 3},
        {"name": "Tax", "amount": 20.00, "rate": "1.6%"},
      ],
    },
    {
      "id": "INV-2024-004",
      "roomNumber": "089",
      "guestName": "Emma Wilson",
      "checkIn": "2024-01-16",
      "checkOut": "2024-01-20",
      "status": "Pending",
      "total": 720.00,
      "paid": 360.00,
      "paymentMethod": "Bank Transfer",
      "dueDate": "2024-01-20",
      "services": [
        {"name": "Room Charges", "amount": 640.00, "nights": 4},
        {"name": "Minibar", "amount": 35.00, "items": 2},
        {"name": "Laundry Service", "amount": 25.00, "items": 1},
        {"name": "Tax", "amount": 20.00, "rate": "2.8%"},
      ],
    },
  ];

  List<Map<String, dynamic>> paymentMethods = [
    {
      "name": "Credit Card",
      "icon": Icons.credit_card,
      "color": primaryColor,
      "fees": "2.9% + \$0.30",
      "processingTime": "Instant",
    },
    {
      "name": "Cash",
      "icon": Icons.money,
      "color": successColor,
      "fees": "No fees",
      "processingTime": "Instant",
    },
    {
      "name": "Bank Transfer",
      "icon": Icons.account_balance,
      "color": infoColor,
      "fees": "\$5.00",
      "processingTime": "1-3 days",
    },
    {
      "name": "Digital Wallet",
      "icon": Icons.wallet,
      "color": warningColor,
      "fees": "1.5%",
      "processingTime": "Instant",
    },
  ];

  List<Map<String, dynamic>> get filteredBills {
    return bills.where((bill) {
      bool statusMatch = selectedStatus == "All" || bill["status"] == selectedStatus;
      bool paymentMatch = selectedPaymentMethod == "All" || bill["paymentMethod"] == selectedPaymentMethod;
      return statusMatch && paymentMatch;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Billing System",
      selectedIndex: selectedTab,
      tabs: [
        Tab(text: "Bills", icon: Icon(Icons.receipt)),
        Tab(text: "Payments", icon: Icon(Icons.payment)),
        Tab(text: "Reports", icon: Icon(Icons.analytics)),
      ],
      tabChildren: [
        _buildBillsTab(),
        _buildPaymentsTab(),
        _buildReportsTab(),
      ],
    );
  }

  Widget _buildBillsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          // Stats Cards
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: billingStats.map((stat) {
              return Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusSm),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  children: [
                    Icon(
                      stat["icon"] as IconData,
                      color: stat["color"] as Color,
                      size: 28,
                    ),
                    SizedBox(height: spSm),
                    Text(
                      stat["currency"] == true 
                          ? "\$${((stat["value"] as num).toDouble()).currency}"
                          : stat["percentage"] == true
                              ? "${stat["value"]}%"
                              : "${stat["value"]}",
                      style: TextStyle(
                        fontSize: fsH4,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "${stat["title"]}",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
          
          // Filters
          Row(
            spacing: spSm,
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
              Expanded(
                child: QDropdownField(
                  label: "Payment Method",
                  items: paymentOptions,
                  value: selectedPaymentMethod,
                  onChanged: (value, label) {
                    selectedPaymentMethod = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
          
          // Bills List
          Row(
            children: [
              Text(
                "Bills & Invoices",
                style: TextStyle(
                  fontSize: fsH5,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Spacer(),
              Text(
                "${filteredBills.length} bills",
                style: TextStyle(
                  fontSize: 14,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
          
          Column(
            spacing: spSm,
            children: filteredBills.map((bill) {
              return Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusSm),
                  boxShadow: [shadowSm],
                  border: Border(
                    left: BorderSide(
                      width: 4,
                      color: _getStatusColor(bill["status"] as String),
                    ),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spSm,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: primaryColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Column(
                            children: [
                              Text(
                                "${bill["id"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                              Text(
                                "Room ${bill["roomNumber"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${bill["guestName"]}",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                              Text(
                                "${bill["checkIn"]} - ${bill["checkOut"]}",
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
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: spSm,
                                vertical: spXs,
                              ),
                              decoration: BoxDecoration(
                                color: _getStatusColor(bill["status"] as String).withAlpha(20),
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Text(
                                "${bill["status"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: _getStatusColor(bill["status"] as String),
                                ),
                              ),
                            ),
                            SizedBox(height: spXs),
                            Text(
                              "\$${((bill["total"] as double).toDouble()).currency}",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    
                    // Services Breakdown
                    Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: primaryColor.withAlpha(5),
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: spXs,
                        children: [
                          Text(
                            "Service Breakdown:",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: primaryColor,
                            ),
                          ),
                          ...(bill["services"] as List).map((service) {
                            return Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    "${service["name"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                ),
                                if (service["nights"] != null)
                                  Text(
                                    "× ${service["nights"]} nights",
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                if (service["items"] != null)
                                  Text(
                                    "× ${service["items"]} items",
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                if (service["days"] != null)
                                  Text(
                                    "× ${service["days"]} days",
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                SizedBox(width: spSm),
                                Text(
                                  "\$${((service["amount"] as double).toDouble()).currency}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: primaryColor,
                                  ),
                                ),
                              ],
                            );
                          }).toList(),
                        ],
                      ),
                    ),
                    
                    // Payment Info
                    if ((bill["paid"] as double) > 0)
                      Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: successColor.withAlpha(10),
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.check_circle,
                              color: successColor,
                              size: 16,
                            ),
                            SizedBox(width: spXs),
                            Expanded(
                              child: Text(
                                "Paid: \$${((bill["paid"] as double).toDouble()).currency} via ${bill["paymentMethod"] ?? "N/A"}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ),
                            if ((bill["total"] as double) > (bill["paid"] as double))
                              Text(
                                "Remaining: \$${(((bill["total"] as double) - (bill["paid"] as double)).toDouble()).currency}",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: warningColor,
                                ),
                              ),
                          ],
                        ),
                      ),
                    
                    // Due Date Warning
                    if (bill["status"] == "Overdue")
                      Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: dangerColor.withAlpha(10),
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.warning,
                              color: dangerColor,
                              size: 16,
                            ),
                            SizedBox(width: spXs),
                            Text(
                              "Overdue since ${bill["dueDate"]}",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: dangerColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    
                    Row(
                      spacing: spSm,
                      children: [
                        if (bill["status"] == "Pending" || bill["status"] == "Overdue")
                          Expanded(
                            child: QButton(
                              label: "Process Payment",
                              size: bs.sm,
                              onPressed: () {
                                ss("Processing payment for ${bill["id"]}");
                              },
                            ),
                          ),
                        QButton(
                          icon: Icons.print,
                          size: bs.sm,
                          onPressed: () {
                            ss("Printing invoice ${bill["id"]}");
                          },
                        ),
                        QButton(
                          icon: Icons.email,
                          size: bs.sm,
                          onPressed: () {
                            ss("Sending invoice ${bill["id"]} via email");
                          },
                        ),
                        QButton(
                          icon: Icons.more_vert,
                          size: bs.sm,
                          onPressed: () {
                            ss("More options for ${bill["id"]}");
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          Text(
            "Payment Methods",
            style: TextStyle(
              fontSize: fsH5,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: paymentMethods.map((method) {
              return Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusSm),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spSm,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: (method["color"] as Color).withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Icon(
                            method["icon"] as IconData,
                            color: method["color"] as Color,
                            size: 24,
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Text(
                            "${method["name"]}",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                    
                    Row(
                      children: [
                        Text(
                          "Fees: ",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: disabledBoldColor,
                          ),
                        ),
                        Text(
                          "${method["fees"]}",
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
                          "Processing: ",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: disabledBoldColor,
                          ),
                        ),
                        Text(
                          "${method["processingTime"]}",
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
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildReportsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          Text(
            "Billing Reports",
            style: TextStyle(
              fontSize: fsH5,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusSm),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spMd,
              children: [
                Text(
                  "Financial Metrics",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                
                ResponsiveGridView(
                  padding: EdgeInsets.zero,
                  minItemWidth: 200,
                  children: [
                    _buildMetricCard("Monthly Revenue", "\$45,250", Icons.trending_up, successColor),
                    _buildMetricCard("Average Bill Amount", "\$567", Icons.receipt, infoColor),
                    _buildMetricCard("Collection Rate", "94%", Icons.percent, primaryColor),
                    _buildMetricCard("Outstanding Amount", "\$8,950", Icons.warning, dangerColor),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMetricCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: color.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusXs),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 24),
          SizedBox(height: spSm),
          Text(
            value,
            style: TextStyle(
              fontSize: fsH5,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "Pending":
        return warningColor;
      case "Paid":
        return successColor;
      case "Overdue":
        return dangerColor;
      case "Cancelled":
        return disabledBoldColor;
      default:
        return primaryColor;
    }
  }
}
