import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlHistory5View extends StatefulWidget {
  @override
  State<GrlHistory5View> createState() => _GrlHistory5ViewState();
}

class _GrlHistory5ViewState extends State<GrlHistory5View> {
  String selectedPeriod = "This Month";
  int currentTab = 0;
  
  List<Map<String, dynamic>> orderHistory = [
    {
      "orderId": "ORD-2024-001",
      "customerName": "John Smith",
      "items": ["MacBook Pro", "iPhone 15"],
      "totalAmount": 2899.99,
      "orderDate": "2024-12-20",
      "status": "Delivered",
      "paymentMethod": "Credit Card",
      "shippingAddress": "123 Main St, New York",
      "trackingNumber": "TRK123456789",
    },
    {
      "orderId": "ORD-2024-002",
      "customerName": "Sarah Johnson",
      "items": ["iPad Air", "Apple Pencil"],
      "totalAmount": 749.99,
      "orderDate": "2024-12-19",
      "status": "Shipped",
      "paymentMethod": "PayPal",
      "shippingAddress": "456 Oak Ave, Los Angeles",
      "trackingNumber": "TRK987654321",
    },
    {
      "orderId": "ORD-2024-003",
      "customerName": "Mike Wilson",
      "items": ["AirPods Pro", "iPhone Case"],
      "totalAmount": 279.99,
      "orderDate": "2024-12-18",
      "status": "Processing",
      "paymentMethod": "Debit Card",
      "shippingAddress": "789 Pine St, Chicago",
      "trackingNumber": "TRK456789123",
    },
    {
      "orderId": "ORD-2024-004",
      "customerName": "Lisa Chen",
      "items": ["Apple Watch", "Sport Band"],
      "totalAmount": 449.99,
      "orderDate": "2024-12-17",
      "status": "Cancelled",
      "paymentMethod": "Apple Pay",
      "shippingAddress": "321 Elm St, Seattle",
      "trackingNumber": "",
    },
    {
      "orderId": "ORD-2024-005",
      "customerName": "David Brown",
      "items": ["MacBook Air", "Magic Mouse"],
      "totalAmount": 1299.99,
      "orderDate": "2024-12-16",
      "status": "Delivered",
      "paymentMethod": "Bank Transfer",
      "shippingAddress": "654 Cedar Ave, Miami",
      "trackingNumber": "TRK789123456",
    },
  ];

  List<Map<String, dynamic>> get filteredOrders {
    switch (currentTab) {
      case 1:
        return orderHistory.where((order) => order["status"] == "Processing").toList();
      case 2:
        return orderHistory.where((order) => order["status"] == "Shipped").toList();
      case 3:
        return orderHistory.where((order) => order["status"] == "Delivered").toList();
      case 4:
        return orderHistory.where((order) => order["status"] == "Cancelled").toList();
      default:
        return orderHistory;
    }
  }

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Order History",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "All", icon: Icon(Icons.list)),
        Tab(text: "Processing", icon: Icon(Icons.hourglass_empty)),
        Tab(text: "Shipped", icon: Icon(Icons.local_shipping)),
        Tab(text: "Delivered", icon: Icon(Icons.check_circle)),
        Tab(text: "Cancelled", icon: Icon(Icons.cancel)),
      ],
      tabChildren: [
        _buildOrderList(),
        _buildOrderList(),
        _buildOrderList(),
        _buildOrderList(),
        _buildOrderList(),
      ],
    );
  }

  Widget _buildOrderList() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          _buildPeriodFilter(),
          _buildOrderStats(),
          _buildOrderItems(),
        ],
      ),
    );
  }

  Widget _buildPeriodFilter() {
    return Row(
      children: [
        Expanded(
          child: QDropdownField(
            label: "Time Period",
            items: [
              {"label": "This Week", "value": "This Week"},
              {"label": "This Month", "value": "This Month"},
              {"label": "Last 3 Months", "value": "Last 3 Months"},
              {"label": "This Year", "value": "This Year"},
            ],
            value: selectedPeriod,
            onChanged: (value, label) {
              selectedPeriod = value;
              setState(() {});
            },
          ),
        ),
        SizedBox(width: spSm),
        QButton(
          icon: Icons.file_download,
          size: bs.sm,
          onPressed: () {},
        ),
      ],
    );
  }

  Widget _buildOrderStats() {
    final totalOrders = filteredOrders.length;
    final totalRevenue = filteredOrders.fold(0.0, (sum, order) => sum + (order["totalAmount"] as double));
    final averageOrder = totalOrders > 0 ? totalRevenue / totalOrders : 0.0;

    return Row(
      children: [
        Expanded(
          child: _buildStatCard(
            "Total Orders",
            totalOrders.toString(),
            Icons.shopping_bag,
            infoColor,
          ),
        ),
        SizedBox(width: spSm),
        Expanded(
          child: _buildStatCard(
            "Total Revenue",
            "\$${totalRevenue.currency}",
            Icons.attach_money,
            successColor,
          ),
        ),
        SizedBox(width: spSm),
        Expanded(
          child: _buildStatCard(
            "Avg Order",
            "\$${averageOrder.currency}",
            Icons.trending_up,
            warningColor,
          ),
        ),
      ],
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        children: [
          Icon(
            icon,
            color: color,
            size: 28,
          ),
          SizedBox(height: spXs),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),
          SizedBox(height: spXs),
          Text(
            value,
            textAlign: TextAlign.center,
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

  Widget _buildOrderItems() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Orders (${filteredOrders.length})",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        SizedBox(height: spSm),
        ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: filteredOrders.length,
          itemBuilder: (context, index) {
            final order = filteredOrders[index];
            return _buildOrderCard(order);
          },
        ),
      ],
    );
  }

  Widget _buildOrderCard(Map<String, dynamic> order) {
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
        border: Border(
          left: BorderSide(
            width: 4,
            color: _getStatusColor(order["status"]),
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
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: _getStatusColor(order["status"]).withAlpha(30),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Text(
                  "${order["status"]}",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: _getStatusColor(order["status"]),
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Icon(
                Icons.shopping_cart,
                size: 16,
                color: disabledBoldColor,
              ),
              SizedBox(width: spXs),
              Expanded(
                child: Text(
                  (order["items"] as List).join(", "),
                  style: TextStyle(
                    fontSize: 13,
                    color: disabledBoldColor,
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Icon(
                Icons.calendar_today,
                size: 16,
                color: disabledBoldColor,
              ),
              SizedBox(width: spXs),
              Text(
                "${DateTime.parse(order["orderDate"]).dMMMy}",
                style: TextStyle(
                  fontSize: 13,
                  color: disabledBoldColor,
                ),
              ),
              Spacer(),
              Icon(
                Icons.payment,
                size: 16,
                color: disabledBoldColor,
              ),
              SizedBox(width: spXs),
              Text(
                "${order["paymentMethod"]}",
                style: TextStyle(
                  fontSize: 13,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
          if (order["trackingNumber"].toString().isNotEmpty)
            Row(
              children: [
                Icon(
                  Icons.local_shipping,
                  size: 16,
                  color: disabledBoldColor,
                ),
                SizedBox(width: spXs),
                Text(
                  "Tracking: ${order["trackingNumber"]}",
                  style: TextStyle(
                    fontSize: 13,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          Row(
            children: [
              Text(
                "\$${(order["totalAmount"] as double).currency}",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: successColor,
                ),
              ),
              Spacer(),
              QButton(
                label: "View Details",
                size: bs.sm,
                onPressed: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "Delivered":
        return successColor;
      case "Shipped":
        return infoColor;
      case "Processing":
        return warningColor;
      case "Cancelled":
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }
}
