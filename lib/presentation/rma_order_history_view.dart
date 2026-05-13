import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class RmaOrderHistoryView extends StatefulWidget {
  const RmaOrderHistoryView({super.key});

  @override
  State<RmaOrderHistoryView> createState() => _RmaOrderHistoryViewState();
}

class _RmaOrderHistoryViewState extends State<RmaOrderHistoryView> {
  String searchQuery = "";
  String selectedStatus = "all";
  String selectedDateRange = "today";
  String selectedPaymentMethod = "all";
  String sortBy = "newest";
  bool showFilters = false;

  List<Map<String, dynamic>> orderHistory = [
    {
      "orderId": "ORD-2024-001287",
      "customerName": "Sarah Johnson",
      "customerEmail": "sarah.johnson@email.com",
      "orderDate": "2024-06-17 14:30:00",
      "completedDate": "2024-06-17 15:15:00",
      "orderType": "Dine In",
      "tableNumber": "Table 12",
      "status": "completed",
      "paymentStatus": "paid",
      "paymentMethod": "Credit Card",
      "items": [
        {"name": "Classic Cheeseburger", "quantity": 1, "price": 16.50},
        {"name": "Truffle Fries", "quantity": 2, "price": 17.00},
        {"name": "Caesar Salad", "quantity": 1, "price": 12.25},
        {"name": "Iced Coffee", "quantity": 1, "price": 3.00}
      ],
      "subtotal": 48.75,
      "tax": 4.38,
      "tip": 9.75,
      "total": 62.88,
      "server": "Mike Thompson",
      "rating": 5,
      "review": "Excellent service and delicious food!"
    },
    {
      "orderId": "ORD-2024-001286",
      "customerName": "Michael Chen",
      "customerEmail": "michael.chen@email.com",
      "orderDate": "2024-06-17 13:45:00",
      "completedDate": "2024-06-17 14:30:00",
      "orderType": "Takeout",
      "tableNumber": null,
      "status": "completed",
      "paymentStatus": "paid",
      "paymentMethod": "Cash",
      "items": [
        {"name": "Margherita Pizza", "quantity": 1, "price": 18.00},
        {"name": "Garlic Bread", "quantity": 1, "price": 6.50},
        {"name": "Soft Drink", "quantity": 2, "price": 6.00}
      ],
      "subtotal": 30.50,
      "tax": 2.74,
      "tip": 5.00,
      "total": 38.24,
      "server": "Lisa Park",
      "rating": 4,
      "review": "Good pizza, quick service"
    },
    {
      "orderId": "ORD-2024-001285",
      "customerName": "Emma Wilson",
      "customerEmail": "emma.wilson@email.com",
      "orderDate": "2024-06-17 12:15:00",
      "completedDate": null,
      "orderType": "Delivery",
      "tableNumber": null,
      "status": "cancelled",
      "paymentStatus": "refunded",
      "paymentMethod": "Credit Card",
      "items": [
        {"name": "Grilled Salmon", "quantity": 1, "price": 24.00},
        {"name": "Steamed Vegetables", "quantity": 1, "price": 8.50}
      ],
      "subtotal": 32.50,
      "tax": 2.93,
      "tip": 0.00,
      "total": 35.43,
      "server": "James Rodriguez",
      "rating": null,
      "review": null,
      "cancellationReason": "Customer requested cancellation - dietary restrictions"
    },
    {
      "orderId": "ORD-2024-001284",
      "customerName": "David Brown",
      "customerEmail": "david.brown@email.com",
      "orderDate": "2024-06-16 19:20:00",
      "completedDate": "2024-06-16 20:05:00",
      "orderType": "Dine In",
      "tableNumber": "Table 8",
      "status": "completed",
      "paymentStatus": "paid",
      "paymentMethod": "Debit Card",
      "items": [
        {"name": "Ribeye Steak", "quantity": 1, "price": 32.00},
        {"name": "Mashed Potatoes", "quantity": 1, "price": 7.50},
        {"name": "House Salad", "quantity": 1, "price": 9.00},
        {"name": "Red Wine", "quantity": 1, "price": 12.00}
      ],
      "subtotal": 60.50,
      "tax": 5.45,
      "tip": 12.00,
      "total": 77.95,
      "server": "Sophie Martinez",
      "rating": 5,
      "review": "Perfect steak, amazing service!"
    },
    {
      "orderId": "ORD-2024-001283",
      "customerName": "Jessica Taylor",
      "customerEmail": "jessica.taylor@email.com",
      "orderDate": "2024-06-16 18:30:00",
      "completedDate": "2024-06-16 19:15:00",
      "orderType": "Takeout",
      "tableNumber": null,
      "status": "completed",
      "paymentStatus": "paid",
      "paymentMethod": "Mobile Payment",
      "items": [
        {"name": "Chicken Wrap", "quantity": 2, "price": 22.00},
        {"name": "Sweet Potato Fries", "quantity": 1, "price": 9.50},
        {"name": "Lemonade", "quantity": 2, "price": 8.00}
      ],
      "subtotal": 39.50,
      "tax": 3.56,
      "tip": 7.90,
      "total": 50.96,
      "server": "Alex Johnson",
      "rating": 4,
      "review": "Great wraps, fresh ingredients"
    },
    {
      "orderId": "ORD-2024-001282",
      "customerName": "Robert Kim",
      "customerEmail": "robert.kim@email.com",
      "orderDate": "2024-06-15 20:45:00",
      "completedDate": "2024-06-15 21:30:00",
      "orderType": "Dine In",
      "tableNumber": "Table 15",
      "status": "completed",
      "paymentStatus": "paid",
      "paymentMethod": "Credit Card",
      "items": [
        {"name": "Seafood Pasta", "quantity": 1, "price": 26.50},
        {"name": "Bruschetta", "quantity": 1, "price": 8.50},
        {"name": "White Wine", "quantity": 1, "price": 10.00}
      ],
      "subtotal": 45.00,
      "tax": 4.05,
      "tip": 9.00,
      "total": 58.05,
      "server": "Nina Chen",
      "rating": 5,
      "review": "Excellent pasta, will come back!"
    },
    {
      "orderId": "ORD-2024-001281",
      "customerName": "Amanda Lee",
      "customerEmail": "amanda.lee@email.com",
      "orderDate": "2024-06-15 13:20:00",
      "completedDate": "2024-06-15 14:00:00",
      "orderType": "Delivery",
      "tableNumber": null,
      "status": "completed",
      "paymentStatus": "paid",
      "paymentMethod": "Credit Card",
      "items": [
        {"name": "Buddha Bowl", "quantity": 1, "price": 15.50},
        {"name": "Green Smoothie", "quantity": 1, "price": 7.50}
      ],
      "subtotal": 23.00,
      "tax": 2.07,
      "tip": 4.60,
      "total": 29.67,
      "server": "Maria Garcia",
      "rating": 4,
      "review": "Healthy and tasty option"
    },
    {
      "orderId": "ORD-2024-001280",
      "customerName": "Kevin Zhang",
      "customerEmail": "kevin.zhang@email.com",
      "orderDate": "2024-06-14 12:00:00",
      "completedDate": null,
      "orderType": "Takeout",
      "tableNumber": null,
      "status": "refunded",
      "paymentStatus": "refunded",
      "paymentMethod": "Cash",
      "items": [
        {"name": "Fish and Chips", "quantity": 1, "price": 19.50},
        {"name": "Coleslaw", "quantity": 1, "price": 5.50}
      ],
      "subtotal": 25.00,
      "tax": 2.25,
      "tip": 0.00,
      "total": 27.25,
      "server": "Tom Wilson",
      "rating": null,
      "review": null,
      "cancellationReason": "Food quality issue - full refund processed"
    }
  ];

  List<Map<String, dynamic>> get filteredOrders {
    var filtered = orderHistory.where((order) {
      // Search filter
      if (searchQuery.isNotEmpty) {
        final query = searchQuery.toLowerCase();
        if (!order["orderId"].toString().toLowerCase().contains(query) &&
            !order["customerName"].toString().toLowerCase().contains(query) &&
            !order["customerEmail"].toString().toLowerCase().contains(query)) {
          return false;
        }
      }

      // Status filter
      if (selectedStatus != "all" && order["status"] != selectedStatus) {
        return false;
      }

      // Payment method filter
      if (selectedPaymentMethod != "all" && order["paymentMethod"] != selectedPaymentMethod) {
        return false;
      }

      // Date range filter
      final orderDate = DateTime.parse(order["orderDate"]);
      final now = DateTime.now();
      final today = DateTime(now.year, now.month, now.day);
      final yesterday = today.subtract(Duration(days: 1));
      final weekAgo = today.subtract(Duration(days: 7));
      final monthAgo = DateTime(now.year, now.month - 1, now.day);

      switch (selectedDateRange) {
        case "today":
          if (orderDate.isBefore(today)) return false;
          break;
        case "yesterday":
          if (orderDate.isBefore(yesterday) || orderDate.isAfter(today)) return false;
          break;
        case "week":
          if (orderDate.isBefore(weekAgo)) return false;
          break;
        case "month":
          if (orderDate.isBefore(monthAgo)) return false;
          break;
      }

      return true;
    }).toList();

    // Sort orders
    filtered.sort((a, b) {
      switch (sortBy) {
        case "oldest":
          return DateTime.parse(a["orderDate"]).compareTo(DateTime.parse(b["orderDate"]));
        case "amount_high":
          return (b["total"] as num).compareTo(a["total"] as num);
        case "amount_low":
          return (a["total"] as num).compareTo(b["total"] as num);
        case "customer":
          return a["customerName"].toString().compareTo(b["customerName"].toString());
        default: // newest
          return DateTime.parse(b["orderDate"]).compareTo(DateTime.parse(a["orderDate"]));
      }
    });

    return filtered;
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'completed':
        return successColor;
      case 'cancelled':
      case 'refunded':
        return dangerColor;
      case 'pending':
      case 'preparing':
        return warningColor;
      case 'paid':
        return successColor;
      default:
        return disabledBoldColor;
    }
  }

  Widget _buildSearchAndFilters() {
    return Container(
      padding: EdgeInsets.all(spMd),
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
                child: QTextField(
                  label: "Search orders...",
                  value: searchQuery,
                  hint: "Order ID, customer name, or email",
                  onChanged: (value) {
                    searchQuery = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              QButton(
                icon: showFilters ? Icons.filter_list_off : Icons.filter_list,
                size: bs.sm,
                color: showFilters ? dangerColor : primaryColor,
                onPressed: () {
                  showFilters = !showFilters;
                  setState(() {});
                },
              ),
            ],
          ),
          if (showFilters) ...[
            SizedBox(height: spMd),
            Row(
              children: [
                Expanded(
                  child: QDropdownField(
                    label: "Status",
                    items: [
                      {"label": "All Statuses", "value": "all"},
                      {"label": "Completed", "value": "completed"},
                      {"label": "Cancelled", "value": "cancelled"},
                      {"label": "Refunded", "value": "refunded"},
                    ],
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
                    label: "Date Range",
                    items: [
                      {"label": "Today", "value": "today"},
                      {"label": "Yesterday", "value": "yesterday"},
                      {"label": "This Week", "value": "week"},
                      {"label": "This Month", "value": "month"},
                      {"label": "All Time", "value": "all"},
                    ],
                    value: selectedDateRange,
                    onChanged: (value, label) {
                      selectedDateRange = value;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: spSm),
            Row(
              children: [
                Expanded(
                  child: QDropdownField(
                    label: "Payment Method",
                    items: [
                      {"label": "All Methods", "value": "all"},
                      {"label": "Credit Card", "value": "Credit Card"},
                      {"label": "Debit Card", "value": "Debit Card"},
                      {"label": "Cash", "value": "Cash"},
                      {"label": "Mobile Payment", "value": "Mobile Payment"},
                    ],
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
                    label: "Sort By",
                    items: [
                      {"label": "Newest First", "value": "newest"},
                      {"label": "Oldest First", "value": "oldest"},
                      {"label": "Amount (High)", "value": "amount_high"},
                      {"label": "Amount (Low)", "value": "amount_low"},
                      {"label": "Customer Name", "value": "customer"},
                    ],
                    value: sortBy,
                    onChanged: (value, label) {
                      sortBy = value;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildStatsOverview() {
    final orders = filteredOrders;
    final completedOrders = orders.where((o) => o["status"] == "completed").toList();
    final totalRevenue = completedOrders.fold(0.0, (sum, order) => sum + (order["total"] as num).toDouble());
    final averageOrderValue = completedOrders.isNotEmpty ? totalRevenue / completedOrders.length : 0.0;
    final cancelledOrders = orders.where((o) => o["status"] == "cancelled").length;
    final cancelRate = orders.isNotEmpty ? (cancelledOrders / orders.length * 100) : 0.0;

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
            "Overview",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),
          Row(
            children: [
              _buildStatCard("Total Orders", "${orders.length}", Icons.receipt_long, primaryColor),
              SizedBox(width: spSm),
              _buildStatCard("Completed", "${completedOrders.length}", Icons.check_circle, successColor),
              SizedBox(width: spSm),
              _buildStatCard("Cancelled", "$cancelledOrders", Icons.cancel, dangerColor),
            ],
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              _buildStatCard("Revenue", "\$${totalRevenue.currency}", Icons.attach_money, successColor),
              SizedBox(width: spSm),
              _buildStatCard("Avg Order", "\$${averageOrderValue.currency}", Icons.trending_up, infoColor),
              SizedBox(width: spSm),
              _buildStatCard("Cancel Rate", "${cancelRate.toStringAsFixed(1)}%", Icons.trending_down, 
                  cancelRate > 10 ? dangerColor : warningColor),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color color) {
    return Expanded(
      child: Container(
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
              size: 20,
            ),
            SizedBox(height: spXs),
            Text(
              value,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 10,
                color: disabledBoldColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOrderCard(Map<String, dynamic> order) {
    final items = order["items"] as List;
    final itemCount = items.fold(0, (sum, item) => sum + (item["quantity"] as int));
    
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
        border: Border.all(
          color: _getStatusColor(order["status"] as String).withAlpha(50),
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
                      "${order["orderId"]}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "${order["customerName"]}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "${order["customerEmail"]}",
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
                    padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                    decoration: BoxDecoration(
                      color: _getStatusColor(order["status"] as String).withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusLg),
                    ),
                    child: Text(
                      (order["status"] as String).toUpperCase(),
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: _getStatusColor(order["status"] as String),
                      ),
                    ),
                  ),
                  SizedBox(height: spXs),
                  Text(
                    "\$${((order["total"] as num).toDouble()).currency}",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: spMd),
          Row(
            children: [
              _buildOrderInfo("Date", "${DateTime.parse(order["orderDate"]).dMMMy}", Icons.calendar_today),
              SizedBox(width: spMd),
              _buildOrderInfo("Time", "${DateTime.parse(order["orderDate"]).kkmm}", Icons.schedule),
              SizedBox(width: spMd),
              _buildOrderInfo("Type", "${order["orderType"]}", Icons.restaurant),
            ],
          ),
          if (order["tableNumber"] != null) ...[
            SizedBox(height: spSm),
            Row(
              children: [
                _buildOrderInfo("Table", "${order["tableNumber"]}", Icons.table_restaurant),
                SizedBox(width: spMd),
                _buildOrderInfo("Server", "${order["server"]}", Icons.person),
                SizedBox(width: spMd),
                _buildOrderInfo("Payment", "${order["paymentMethod"]}", Icons.payment),
              ],
            ),
          ] else ...[
            SizedBox(height: spSm),
            Row(
              children: [
                _buildOrderInfo("Server", "${order["server"]}", Icons.person),
                SizedBox(width: spMd),
                _buildOrderInfo("Payment", "${order["paymentMethod"]}", Icons.payment),
                SizedBox(width: spMd),
                _buildOrderInfo("Items", "$itemCount items", Icons.shopping_bag),
              ],
            ),
          ],
          SizedBox(height: spMd),
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.grey[50],
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Order Items",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spXs),
                ...items.take(3).map((item) => Container(
                  margin: EdgeInsets.only(bottom: spXs),
                  child: Row(
                    children: [
                      Container(
                        width: 4,
                        height: 4,
                        decoration: BoxDecoration(
                          color: primaryColor,
                          shape: BoxShape.circle,
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Text(
                          "${item["quantity"]}x ${item["name"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: primaryColor,
                          ),
                        ),
                      ),
                      Text(
                        "\$${((item["price"] as num).toDouble()).currency}",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                )),
                if (items.length > 3) ...[
                  Text(
                    "... and ${items.length - 3} more items",
                    style: TextStyle(
                      fontSize: 11,
                      fontStyle: FontStyle.italic,
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ],
            ),
          ),
          if (order["rating"] != null) ...[
            SizedBox(height: spSm),
            Row(
              children: [
                ...List.generate(5, (index) => Icon(
                  index < (order["rating"] as int) ? Icons.star : Icons.star_border,
                  color: warningColor,
                  size: 16,
                )),
                SizedBox(width: spSm),
                Expanded(
                  child: Text(
                    "${order["review"] ?? "No review"}",
                    style: TextStyle(
                      fontSize: 12,
                      fontStyle: FontStyle.italic,
                      color: disabledBoldColor,
                    ),
                  ),
                ),
              ],
            ),
          ],
          if (order["cancellationReason"] != null) ...[
            SizedBox(height: spSm),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: dangerColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusSm),
                border: Border.all(color: dangerColor.withAlpha(50)),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.info,
                    color: dangerColor,
                    size: 16,
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Text(
                      "${order["cancellationReason"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: dangerColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
          SizedBox(height: spMd),
          Row(
            children: [
              Expanded(
                child: QButton(
                  label: "View Details",
                  size: bs.sm,
                  onPressed: () {
                    //navigateTo('RmaOrderDetailView')
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QButton(
                  label: "Reorder",
                  color: infoColor,
                  size: bs.sm,
                  onPressed: () {
                    //navigateTo('CreateOrderView')
                  },
                ),
              ),
              if (order["status"] == "completed") ...[
                SizedBox(width: spSm),
                Expanded(
                  child: QButton(
                    label: "Print Receipt",
                    color: warningColor,
                    size: bs.sm,
                    onPressed: () {
                      ss("Receipt sent to printer");
                    },
                  ),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildOrderInfo(String label, String value, IconData icon) {
    return Expanded(
      child: Row(
        children: [
          Icon(
            icon,
            color: disabledBoldColor,
            size: 14,
          ),
          SizedBox(width: spXs),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 10,
                    color: disabledBoldColor,
                  ),
                ),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildExportSection() {
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
            "Export & Reports",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),
          Row(
            children: [
              Expanded(
                child: QButton(
                  label: "Export CSV",
                  icon: Icons.file_download,
                  size: bs.sm,
                  onPressed: () {
                    ss("Order history exported to CSV");
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QButton(
                  label: "Generate Report",
                  icon: Icons.assessment,
                  color: infoColor,
                  size: bs.sm,
                  onPressed: () {
                    //navigateTo('OrderReportView')
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QButton(
                  label: "Email Summary",
                  icon: Icons.email,
                  color: warningColor,
                  size: bs.sm,
                  onPressed: () {
                    ss("Order summary sent via email");
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final orders = filteredOrders;
    
    return Scaffold(
      appBar: AppBar(
        title: Text("Order History"),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              setState(() {});
              ss("Order history refreshed");
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            _buildSearchAndFilters(),
            _buildStatsOverview(),
            _buildExportSection(),
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
                        "Order History",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Spacer(),
                      Text(
                        "${orders.length} orders found",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spMd),
                  if (orders.isEmpty) ...[
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(spLg),
                      decoration: BoxDecoration(
                        color: Colors.grey[50],
                        borderRadius: BorderRadius.circular(radiusMd),
                      ),
                      child: Column(
                        children: [
                          Icon(
                            Icons.receipt_long,
                            color: disabledBoldColor,
                            size: 48,
                          ),
                          SizedBox(height: spMd),
                          Text(
                            "No orders found",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: disabledBoldColor,
                            ),
                          ),
                          Text(
                            "Try adjusting your search criteria",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ] else ...[
                    ...orders.map((order) => _buildOrderCard(order)),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
