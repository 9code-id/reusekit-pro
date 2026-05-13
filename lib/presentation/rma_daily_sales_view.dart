import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class RmaDailySalesView extends StatefulWidget {
  const RmaDailySalesView({super.key});

  @override
  State<RmaDailySalesView> createState() => _RmaDailySalesViewState();
}

class _RmaDailySalesViewState extends State<RmaDailySalesView> {
  int currentTab = 0;
  String selectedDate = "2024-03-15";
  String selectedPaymentMethod = "";
  String selectedCategory = "";

  List<Map<String, dynamic>> paymentMethodOptions = [
    {"label": "All Methods", "value": ""},
    {"label": "Credit Card", "value": "credit_card"},
    {"label": "Cash", "value": "cash"},
    {"label": "Debit Card", "value": "debit_card"},
    {"label": "Bank Transfer", "value": "bank_transfer"},
    {"label": "PayPal", "value": "paypal"},
  ];

  List<Map<String, dynamic>> categoryOptions = [
    {"label": "All Categories", "value": ""},
    {"label": "RMA Services", "value": "rma_services"},
    {"label": "Repair Parts", "value": "repair_parts"},
    {"label": "Labor", "value": "labor"},
    {"label": "Shipping", "value": "shipping"},
    {"label": "Accessories", "value": "accessories"},
  ];

  List<Map<String, dynamic>> dailySales = [
    {
      "sale_id": "SALE001",
      "time": "14:30:00",
      "customer_name": "John Smith",
      "customer_email": "john.smith@email.com",
      "rma_number": "RMA-2024-001",
      "items": [
        {"name": "RMA Processing Fee", "category": "rma_services", "quantity": 1, "price": 25.0},
        {"name": "Standard Shipping", "category": "shipping", "quantity": 1, "price": 15.0},
      ],
      "subtotal": 40.0,
      "tax": 3.20,
      "total": 43.20,
      "payment_method": "credit_card",
      "payment_status": "completed",
      "cashier": "Emily Davis",
      "receipt_number": "RCP001",
    },
    {
      "sale_id": "SALE002",
      "time": "13:45:00",
      "customer_name": "Emily Davis",
      "customer_email": "emily.davis@email.com",
      "rma_number": "RMA-2024-002",
      "items": [
        {"name": "Battery Replacement", "category": "repair_parts", "quantity": 1, "price": 45.0},
        {"name": "Technical Diagnostic", "category": "labor", "quantity": 1, "price": 75.0},
      ],
      "subtotal": 120.0,
      "tax": 9.60,
      "total": 129.60,
      "payment_method": "cash",
      "payment_status": "completed",
      "cashier": "John Smith",
      "receipt_number": "RCP002",
    },
    {
      "sale_id": "SALE003",
      "time": "12:15:00",
      "customer_name": "Robert Wilson",
      "customer_email": "robert.wilson@email.com",
      "rma_number": "RMA-2024-003",
      "items": [
        {"name": "Express RMA Processing", "category": "rma_services", "quantity": 1, "price": 50.0},
      ],
      "subtotal": 50.0,
      "tax": 4.00,
      "total": 54.00,
      "payment_method": "debit_card",
      "payment_status": "completed",
      "cashier": "Emily Davis",
      "receipt_number": "RCP003",
    },
    {
      "sale_id": "SALE004",
      "time": "11:30:00",
      "customer_name": "Maria Garcia",
      "customer_email": "maria.garcia@email.com",
      "rma_number": "RMA-2024-004",
      "items": [
        {"name": "Replacement Display Screen", "category": "repair_parts", "quantity": 1, "price": 120.0},
        {"name": "Protective Case", "category": "accessories", "quantity": 1, "price": 30.0},
      ],
      "subtotal": 150.0,
      "tax": 12.00,
      "total": 162.00,
      "payment_method": "paypal",
      "payment_status": "completed",
      "cashier": "John Smith",
      "receipt_number": "RCP004",
    },
    {
      "sale_id": "SALE005",
      "time": "10:45:00",
      "customer_name": "James Anderson",
      "customer_email": "james.anderson@email.com",
      "rma_number": "RMA-2024-005",
      "items": [
        {"name": "Screen Protector", "category": "accessories", "quantity": 2, "price": 12.0},
        {"name": "Express Shipping", "category": "shipping", "quantity": 1, "price": 25.0},
      ],
      "subtotal": 49.0,
      "tax": 3.92,
      "total": 52.92,
      "payment_method": "credit_card",
      "payment_status": "completed",
      "cashier": "Emily Davis",
      "receipt_number": "RCP005",
    },
  ];

  List<Map<String, dynamic>> hourlySales = [
    {"hour": "08:00", "sales_count": 2, "revenue": 85.50},
    {"hour": "09:00", "sales_count": 3, "revenue": 156.75},
    {"hour": "10:00", "sales_count": 1, "revenue": 52.92},
    {"hour": "11:00", "sales_count": 1, "revenue": 162.00},
    {"hour": "12:00", "sales_count": 1, "revenue": 54.00},
    {"hour": "13:00", "sales_count": 1, "revenue": 129.60},
    {"hour": "14:00", "sales_count": 1, "revenue": 43.20},
    {"hour": "15:00", "sales_count": 0, "revenue": 0.0},
    {"hour": "16:00", "sales_count": 2, "revenue": 95.25},
    {"hour": "17:00", "sales_count": 1, "revenue": 78.40},
  ];

  List<Map<String, dynamic>> get filteredSales {
    return dailySales.where((sale) {
      bool matchesPaymentMethod = selectedPaymentMethod.isEmpty ||
          sale["payment_method"] == selectedPaymentMethod;
      
      bool matchesCategory = selectedCategory.isEmpty ||
          (sale["items"] as List).any((item) => item["category"] == selectedCategory);

      return matchesPaymentMethod && matchesCategory;
    }).toList();
  }

  double get totalRevenue {
    return filteredSales.fold(0.0, (sum, sale) => sum + (sale["total"] as double));
  }

  double get totalSubtotal {
    return filteredSales.fold(0.0, (sum, sale) => sum + (sale["subtotal"] as double));
  }

  double get totalTax {
    return filteredSales.fold(0.0, (sum, sale) => sum + (sale["tax"] as double));
  }

  int get totalSalesCount {
    return filteredSales.length;
  }

  String _getPaymentMethodLabel(String method) {
    switch (method) {
      case "credit_card":
        return "Credit Card";
      case "cash":
        return "Cash";
      case "debit_card":
        return "Debit Card";
      case "bank_transfer":
        return "Bank Transfer";
      case "paypal":
        return "PayPal";
      default:
        return "Unknown";
    }
  }

  IconData _getPaymentMethodIcon(String method) {
    switch (method) {
      case "credit_card":
      case "debit_card":
        return Icons.credit_card;
      case "cash":
        return Icons.money;
      case "bank_transfer":
        return Icons.account_balance;
      case "paypal":
        return Icons.payment;
      default:
        return Icons.payment;
    }
  }

  Color _getCategoryColor(String category) {
    switch (category) {
      case "rma_services":
        return primaryColor;
      case "repair_parts":
        return infoColor;
      case "labor":
        return warningColor;
      case "shipping":
        return successColor;
      case "accessories":
        return secondaryColor;
      default:
        return disabledColor;
    }
  }

  void _viewSaleDetails(Map<String, dynamic> sale) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Sale Details"),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildDetailRow("Sale ID", "${sale["sale_id"]}"),
              _buildDetailRow("Time", "${sale["time"]}"),
              _buildDetailRow("Customer", "${sale["customer_name"]}"),
              _buildDetailRow("Email", "${sale["customer_email"]}"),
              _buildDetailRow("RMA Number", "${sale["rma_number"]}"),
              _buildDetailRow("Cashier", "${sale["cashier"]}"),
              _buildDetailRow("Receipt", "${sale["receipt_number"]}"),
              _buildDetailRow("Payment Method", _getPaymentMethodLabel("${sale["payment_method"]}")),
              _buildDetailRow("Payment Status", "${sale["payment_status"]}".toUpperCase()),
              
              SizedBox(height: spMd),
              Text(
                "Items:",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              SizedBox(height: spXs),
              
              ...(sale["items"] as List).map((item) => Container(
                margin: EdgeInsets.only(bottom: spXs),
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: _getCategoryColor("${item["category"]}").withAlpha(10),
                  borderRadius: BorderRadius.circular(radiusSm),
                  border: Border.all(color: _getCategoryColor("${item["category"]}").withAlpha(20)),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${item["name"]}",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: primaryColor,
                            ),
                          ),
                          Text(
                            "${item["category"]}".replaceAll('_', ' ').toUpperCase(),
                            style: TextStyle(
                              fontSize: 12,
                              color: _getCategoryColor("${item["category"]}"),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      "${item["quantity"]} × \$${(item["price"] as double).currency}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
              )),
              
              SizedBox(height: spMd),
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: primaryColor.withAlpha(10),
                  borderRadius: BorderRadius.circular(radiusSm),
                  border: Border.all(color: primaryColor.withAlpha(20)),
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text("Subtotal:", style: TextStyle(color: disabledBoldColor)),
                        Spacer(),
                        Text("\$${(sale["subtotal"] as double).currency}", style: TextStyle(color: primaryColor, fontWeight: FontWeight.w600)),
                      ],
                    ),
                    Row(
                      children: [
                        Text("Tax:", style: TextStyle(color: disabledBoldColor)),
                        Spacer(),
                        Text("\$${(sale["tax"] as double).currency}", style: TextStyle(color: primaryColor, fontWeight: FontWeight.w600)),
                      ],
                    ),
                    Divider(),
                    Row(
                      children: [
                        Text("Total:", style: TextStyle(fontWeight: FontWeight.bold, color: primaryColor)),
                        Spacer(),
                        Text("\$${(sale["total"] as double).currency}", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: primaryColor)),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Close"),
          ),
          QButton(
            label: "Print Receipt",
            size: bs.sm,
            onPressed: () {
              Navigator.pop(context);
              ss("Receipt printed successfully");
            },
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.only(bottom: spSm),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: Text(
              "${label}:",
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: disabledBoldColor,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(color: primaryColor),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSaleCard(Map<String, dynamic> sale) {
    IconData paymentIcon = _getPaymentMethodIcon("${sale["payment_method"]}");
    
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusSm),
        boxShadow: [shadowSm],
        border: Border(
          left: BorderSide(
            width: 4,
            color: successColor,
          ),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(spSm),
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
                        "${sale["customer_name"]}",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      SizedBox(height: spXxs),
                      Text(
                        "${sale["sale_id"]} • ${sale["time"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Text(
                  "\$${(sale["total"] as double).currency}",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
              ],
            ),
            
            SizedBox(height: spSm),
            Text(
              "RMA: ${sale["rma_number"]}",
              style: TextStyle(
                fontSize: 14,
                color: disabledBoldColor,
              ),
            ),
            
            SizedBox(height: spSm),
            Row(
              children: [
                Icon(paymentIcon, size: 16, color: disabledBoldColor),
                SizedBox(width: spXxs),
                Text(
                  _getPaymentMethodLabel("${sale["payment_method"]}"),
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
                SizedBox(width: spSm),
                Icon(Icons.person, size: 16, color: disabledBoldColor),
                SizedBox(width: spXxs),
                Text(
                  "${sale["cashier"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
                SizedBox(width: spSm),
                Icon(Icons.receipt, size: 16, color: disabledBoldColor),
                SizedBox(width: spXxs),
                Text(
                  "${sale["receipt_number"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
            
            SizedBox(height: spSm),
            Text(
              "Items: ${(sale["items"] as List).length}",
              style: TextStyle(
                fontSize: 12,
                color: disabledBoldColor,
              ),
            ),
            
            SizedBox(height: spSm),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Subtotal: \$${(sale["subtotal"] as double).currency}",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                      Text(
                        "Tax: \$${(sale["tax"] as double).currency}",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ),
                QButton(
                  label: "View Details",
                  size: bs.sm,
                  onPressed: () => _viewSaleDetails(sale),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHourlyChart() {
    double maxRevenue = hourlySales.map((h) => h["revenue"] as double).reduce((a, b) => a > b ? a : b);
    
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusSm),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Hourly Sales Performance",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),
          
          ...hourlySales.map((hour) {
            double revenue = hour["revenue"] as double;
            int salesCount = hour["sales_count"] as int;
            double percentage = maxRevenue > 0 ? (revenue / maxRevenue) : 0;
            
            return Container(
              margin: EdgeInsets.only(bottom: spSm),
              child: Column(
                children: [
                  Row(
                    children: [
                      SizedBox(
                        width: 60,
                        child: Text(
                          "${hour["hour"]}",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: primaryColor,
                          ),
                        ),
                      ),
                      
                      Expanded(
                        child: Container(
                          height: 24,
                          decoration: BoxDecoration(
                            color: primaryColor.withAlpha(10),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: FractionallySizedBox(
                            alignment: Alignment.centerLeft,
                            widthFactor: percentage,
                            child: Container(
                              decoration: BoxDecoration(
                                color: primaryColor,
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                            ),
                          ),
                        ),
                      ),
                      
                      SizedBox(width: spSm),
                      
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            "\$${revenue.currency}",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          Text(
                            "$salesCount sales",
                            style: TextStyle(
                              fontSize: 10,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildOverviewTab() {
    return Column(
      children: [
        // Date Selection
        Container(
          padding: EdgeInsets.all(spSm),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(radiusSm),
            boxShadow: [shadowSm],
          ),
          child: QDatePicker(
            label: "Select Date",
            value: DateTime.parse(selectedDate),
            onChanged: (value) {
              selectedDate = value.toString().split(' ')[0];
              setState(() {});
            },
          ),
        ),
        
        SizedBox(height: spMd),
        
        // Daily Summary
        ResponsiveGridView(
          padding: EdgeInsets.zero,
          minItemWidth: 200,
          children: [
            _buildSummaryCard("Total Sales", totalSalesCount.toString(), primaryColor, Icons.receipt_long),
            _buildSummaryCard("Revenue", "\$${totalRevenue.currency}", successColor, Icons.attach_money),
            _buildSummaryCard("Subtotal", "\$${totalSubtotal.currency}", infoColor, Icons.calculate),
            _buildSummaryCard("Tax Collected", "\$${totalTax.currency}", warningColor, Icons.account_balance),
          ],
        ),
        
        SizedBox(height: spMd),
        
        // Hourly Performance Chart
        _buildHourlyChart(),
      ],
    );
  }

  Widget _buildSalesTab() {
    return Column(
      children: [
        // Filters
        Container(
          padding: EdgeInsets.all(spSm),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(radiusSm),
            boxShadow: [shadowSm],
          ),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: QDropdownField(
                      label: "Payment Method",
                      items: paymentMethodOptions,
                      value: selectedPaymentMethod,
                      onChanged: (value, label) {
                        selectedPaymentMethod = value;
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
            ],
          ),
        ),
        
        SizedBox(height: spMd),
        
        // Sales Summary
        Container(
          padding: EdgeInsets.all(spSm),
          decoration: BoxDecoration(
            color: primaryColor.withAlpha(20),
            borderRadius: BorderRadius.circular(radiusSm),
            border: Border.all(color: primaryColor.withAlpha(40)),
          ),
          child: Row(
            children: [
              Icon(Icons.info_outline, color: primaryColor, size: 20),
              SizedBox(width: spSm),
              Text(
                "Showing ${filteredSales.length} of ${dailySales.length} sales • Total: \$${totalRevenue.currency}",
                style: TextStyle(
                  color: primaryColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
        
        SizedBox(height: spMd),
        
        // Sales List
        if (filteredSales.isEmpty)
          Container(
            padding: EdgeInsets.all(spLg),
            child: Column(
              children: [
                Icon(
                  Icons.receipt_long,
                  size: 64,
                  color: disabledColor,
                ),
                SizedBox(height: spMd),
                Text(
                  "No sales found",
                  style: TextStyle(
                    fontSize: fsH5,
                    fontWeight: FontWeight.bold,
                    color: disabledBoldColor,
                  ),
                ),
                SizedBox(height: spSm),
                Text(
                  "Try adjusting your filter criteria",
                  style: TextStyle(
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          )
        else
          ...filteredSales.map((sale) => _buildSaleCard(sale)),
      ],
    );
  }

  Widget _buildSummaryCard(String title, String value, Color color, IconData icon) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: color.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: color.withAlpha(20)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: color, size: 24),
              Spacer(),
              Text(
                value,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Text(
            title,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "RMA Daily Sales",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Overview", icon: Icon(Icons.dashboard)),
        Tab(text: "Sales List", icon: Icon(Icons.receipt_long)),
      ],
      tabChildren: [
        SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: _buildOverviewTab(),
        ),
        SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: _buildSalesTab(),
        ),
      ],
    );
  }
}
