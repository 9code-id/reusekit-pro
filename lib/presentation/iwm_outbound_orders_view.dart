import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class IwmOutboundOrdersView extends StatefulWidget {
  const IwmOutboundOrdersView({super.key});

  @override
  State<IwmOutboundOrdersView> createState() => _IwmOutboundOrdersViewState();
}

class _IwmOutboundOrdersViewState extends State<IwmOutboundOrdersView> {
  int selectedTab = 0;
  String selectedFilter = "pending";
  String selectedPriority = "all";
  String searchQuery = "";
  
  List<Map<String, dynamic>> filterOptions = [
    {"label": "Pending Orders", "value": "pending"},
    {"label": "Processing", "value": "processing"},
    {"label": "Ready to Ship", "value": "ready"},
    {"label": "Shipped", "value": "shipped"},
    {"label": "All Orders", "value": "all"},
  ];
  
  List<Map<String, dynamic>> priorityOptions = [
    {"label": "All Priorities", "value": "all"},
    {"label": "High Priority", "value": "high"},
    {"label": "Medium Priority", "value": "medium"},
    {"label": "Low Priority", "value": "low"},
  ];
  
  List<Map<String, dynamic>> outboundOrders = [
    {
      "orderId": "ORD-10001",
      "customer": "TechCorp Solutions",
      "customerType": "Enterprise",
      "status": "Pending",
      "priority": "High",
      "orderDate": "2024-01-15",
      "requestedDate": "2024-01-17",
      "totalValue": 12450.00,
      "totalItems": 15,
      "totalWeight": 8.5,
      "shippingAddress": {
        "street": "123 Tech Avenue",
        "city": "New York",
        "state": "NY",
        "zip": "10001",
        "country": "USA"
      },
      "items": [
        {"sku": "PROD-001", "name": "Wireless Headphones", "quantity": 5, "unitPrice": 299.99, "weight": 0.5},
        {"sku": "PROD-002", "name": "Smartphone Case", "quantity": 10, "unitPrice": 49.99, "weight": 0.2},
        {"sku": "PROD-003", "name": "USB Cable", "quantity": 20, "unitPrice": 19.99, "weight": 0.1},
      ],
      "specialInstructions": "Handle with care - fragile items"
    },
    {
      "orderId": "ORD-10002",
      "customer": "Digital Innovations LLC",
      "customerType": "Business",
      "status": "Processing",
      "priority": "Medium",
      "orderDate": "2024-01-14",
      "requestedDate": "2024-01-18",
      "totalValue": 8750.50,
      "totalItems": 12,
      "totalWeight": 6.2,
      "shippingAddress": {
        "street": "456 Innovation Drive",
        "city": "Los Angeles",
        "state": "CA",
        "zip": "90210",
        "country": "USA"
      },
      "items": [
        {"sku": "PROD-004", "name": "Bluetooth Speaker", "quantity": 3, "unitPrice": 199.99, "weight": 1.2},
        {"sku": "PROD-005", "name": "Gaming Mouse", "quantity": 6, "unitPrice": 89.99, "weight": 0.3},
        {"sku": "PROD-006", "name": "Mechanical Keyboard", "quantity": 3, "unitPrice": 149.99, "weight": 1.1},
      ],
      "specialInstructions": "Express shipping required"
    },
  ];
  
  List<Map<String, dynamic>> orderMetrics = [
    {
      "title": "Pending Orders",
      "value": 45,
      "subtitle": "Awaiting Processing",
      "icon": Icons.pending_actions,
      "color": warningColor
    },
    {
      "title": "Processing",
      "value": 28,
      "subtitle": "Currently Active",
      "icon": Icons.inventory,
      "color": primaryColor
    },
    {
      "title": "Ready to Ship",
      "value": 12,
      "subtitle": "Completed Orders",
      "icon": Icons.local_shipping,
      "color": successColor
    },
    {
      "title": "Total Value",
      "value": 245000,
      "subtitle": "Pending Orders",
      "icon": Icons.attach_money,
      "color": infoColor
    },
  ];
  
  List<Map<String, dynamic>> recentActivity = [
    {"type": "created", "message": "New order ORD-10005 received from Global Tech", "time": "5 min ago"},
    {"type": "processed", "message": "Order ORD-10003 moved to processing", "time": "15 min ago"},
    {"type": "ready", "message": "Order ORD-10001 ready for shipping", "time": "1 hour ago"},
    {"type": "delayed", "message": "Order ORD-10002 delayed due to inventory", "time": "2 hours ago"},
  ];
  
  List<Map<String, dynamic>> topCustomers = [
    {"customer": "TechCorp Solutions", "orders": 25, "value": 125000, "avgOrder": 5000},
    {"customer": "Digital Innovations", "orders": 18, "value": 89000, "avgOrder": 4944},
    {"customer": "Future Systems Inc", "orders": 15, "value": 78000, "avgOrder": 5200},
    {"customer": "Smart Solutions Ltd", "orders": 12, "value": 65000, "avgOrder": 5417},
  ];

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Outbound Orders",
      selectedIndex: selectedTab,
      tabs: [
        Tab(text: "Orders", icon: Icon(Icons.shopping_cart)),
        Tab(text: "Processing", icon: Icon(Icons.inventory)),
        Tab(text: "Analytics", icon: Icon(Icons.analytics)),
      ],
      tabChildren: [
        _buildOrdersTab(),
        _buildProcessingTab(),
        _buildAnalyticsTab(),
      ],
    );
  }

  Widget _buildOrdersTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildFiltersAndSearch(),
          _buildOrderMetrics(),
          _buildOrdersList(),
        ],
      ),
    );
  }

  Widget _buildProcessingTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildProcessingQueue(),
          _buildProcessingStats(),
          _buildActiveOrders(),
        ],
      ),
    );
  }

  Widget _buildAnalyticsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildPerformanceMetrics(),
          _buildTopCustomers(),
          _buildOrderTrends(),
        ],
      ),
    );
  }

  Widget _buildFiltersAndSearch() {
    return Container(
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
                child: QTextField(
                  label: "Search Orders",
                  value: searchQuery,
                  hint: "Search by order ID, customer, or product",
                  onChanged: (value) {
                    searchQuery = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              QButton(
                icon: Icons.search,
                size: bs.sm,
                onPressed: () {},
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: QDropdownField(
                  label: "Status Filter",
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
                  label: "Priority",
                  items: priorityOptions,
                  value: selectedPriority,
                  onChanged: (value, label) {
                    selectedPriority = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              QButton(
                icon: Icons.add,
                size: bs.sm,
                onPressed: () => _showCreateOrderDialog(),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildOrderMetrics() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: spSm,
      children: [
        Text(
          "Order Overview",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        ResponsiveGridView(
          padding: EdgeInsets.zero,
          minItemWidth: 200,
          children: orderMetrics.map((metric) => _buildMetricCard(metric)).toList(),
        ),
      ],
    );
  }

  Widget _buildMetricCard(Map<String, dynamic> metric) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spXs,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(spXs),
                decoration: BoxDecoration(
                  color: (metric["color"] as Color).withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Icon(
                  metric["icon"],
                  color: metric["color"],
                  size: 20,
                ),
              ),
            ],
          ),
          Text(
            metric["title"] == "Total Value"
                ? "\$${((metric["value"] as num) / 1000).toStringAsFixed(0)}K"
                : "${metric["value"]}",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Text(
            "${metric["title"]}",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: primaryColor,
            ),
          ),
          Text(
            "${metric["subtitle"]}",
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOrdersList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: spSm,
      children: [
        Text(
          "Active Orders",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        ...outboundOrders.map((order) => _buildOrderCard(order)),
      ],
    );
  }

  Widget _buildOrderCard(Map<String, dynamic> order) {
    Color statusColor = _getStatusColor(order["status"]);
    Color priorityColor = _getPriorityColor(order["priority"]);
    
    return Container(
      padding: EdgeInsets.all(spSm),
      margin: EdgeInsets.only(bottom: spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 4,
                height: 60,
                decoration: BoxDecoration(
                  color: statusColor,
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          "${order["orderId"]}",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Spacer(),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                          decoration: BoxDecoration(
                            color: priorityColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            "${order["priority"]}",
                            style: TextStyle(
                              color: priorityColor,
                              fontSize: 12,
                            ),
                          ),
                        ),
                        SizedBox(width: spXs),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                          decoration: BoxDecoration(
                            color: statusColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            "${order["status"]}",
                            style: TextStyle(
                              color: statusColor,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Text(
                      "${order["customer"]} • ${order["customerType"]}",
                      style: TextStyle(
                        color: disabledBoldColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Row(
                      children: [
                        Icon(Icons.location_on, size: 16, color: disabledBoldColor),
                        SizedBox(width: 4),
                        Text(
                          "${(order["shippingAddress"] as Map<String, dynamic>)["city"]}, ${(order["shippingAddress"] as Map<String, dynamic>)["state"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                        SizedBox(width: spSm),
                        Icon(Icons.schedule, size: 16, color: disabledBoldColor),
                        SizedBox(width: 4),
                        Text(
                          "Due: ${order["requestedDate"]}",
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
            ],
          ),
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(5),
              borderRadius: BorderRadius.circular(radiusSm),
              border: Border.all(color: disabledOutlineBorderColor),
            ),
            child: Column(
              spacing: spXs,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Order Value",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          Text(
                            "\$${(order["totalValue"] as double).toStringAsFixed(2)}",
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
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "Items",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          Text(
                            "${order["totalItems"]}",
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
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            "Weight",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          Text(
                            "${order["totalWeight"]} kg",
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
                if (order["specialInstructions"] != null)
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(spXs),
                    decoration: BoxDecoration(
                      color: warningColor.withAlpha(10),
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.info_outline, size: 16, color: warningColor),
                        SizedBox(width: spXs),
                        Expanded(
                          child: Text(
                            "${order["specialInstructions"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: warningColor,
                              fontWeight: FontWeight.w500,
                            ),
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
              Expanded(
                child: QButton(
                  label: "Process",
                  size: bs.sm,
                  onPressed: () => _processOrder(order),
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QButton(
                  label: "Details",
                  size: bs.sm,
                  onPressed: () => _showOrderDetails(order),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildProcessingQueue() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Processing Queue",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Row(
            children: [
              Expanded(
                child: _buildQueueMetric("High Priority", 8, dangerColor),
              ),
              Expanded(
                child: _buildQueueMetric("Medium Priority", 15, warningColor),
              ),
              Expanded(
                child: _buildQueueMetric("Low Priority", 22, successColor),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildQueueMetric(String title, int count, Color color) {
    return Container(
      padding: EdgeInsets.all(spSm),
      margin: EdgeInsets.symmetric(horizontal: 4),
      decoration: BoxDecoration(
        color: color.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: color.withAlpha(50)),
      ),
      child: Column(
        children: [
          Text(
            "$count",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12,
              color: color,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProcessingStats() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Processing Statistics",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Row(
            children: [
              Expanded(
                child: _buildStatItem("Avg Processing Time", "2.5 hours", Icons.schedule),
              ),
              Expanded(
                child: _buildStatItem("Success Rate", "98.2%", Icons.check_circle),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: _buildStatItem("Orders Today", "47", Icons.today),
              ),
              Expanded(
                child: _buildStatItem("Completed", "35", Icons.done_all),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(String title, String value, IconData icon) {
    return Container(
      padding: EdgeInsets.all(spSm),
      margin: EdgeInsets.all(2),
      decoration: BoxDecoration(
        color: primaryColor.withAlpha(5),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: disabledOutlineBorderColor),
      ),
      child: Column(
        children: [
          Icon(icon, color: primaryColor, size: 24),
          SizedBox(height: spXs),
          Text(
            value,
            style: TextStyle(
              fontSize: 18,
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

  Widget _buildActiveOrders() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Currently Processing",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          ...outboundOrders.where((order) => order["status"] == "Processing").map((order) => _buildProcessingOrderItem(order)),
        ],
      ),
    );
  }

  Widget _buildProcessingOrderItem(Map<String, dynamic> order) {
    return Container(
      padding: EdgeInsets.all(spSm),
      margin: EdgeInsets.only(bottom: spXs),
      decoration: BoxDecoration(
        color: primaryColor.withAlpha(5),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: disabledOutlineBorderColor),
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
                Row(
                  children: [
                    Text(
                      "${order["orderId"]}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                    Spacer(),
                    Text(
                      "Started 2h ago",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
                Text(
                  "${order["customer"]} • ${order["totalItems"]} items",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
          QButton(
            label: "View",
            size: bs.sm,
            onPressed: () => _showOrderDetails(order),
          ),
        ],
      ),
    );
  }

  Widget _buildPerformanceMetrics() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: spSm,
      children: [
        Text(
          "Performance Overview",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        ResponsiveGridView(
          padding: EdgeInsets.zero,
          minItemWidth: 200,
          children: orderMetrics.map((metric) => _buildMetricCard(metric)).toList(),
        ),
      ],
    );
  }

  Widget _buildTopCustomers() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Top Customers",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          ...topCustomers.map((customer) => _buildCustomerItem(customer)),
        ],
      ),
    );
  }

  Widget _buildCustomerItem(Map<String, dynamic> customer) {
    return Container(
      padding: EdgeInsets.all(spSm),
      margin: EdgeInsets.only(bottom: spSm),
      decoration: BoxDecoration(
        color: primaryColor.withAlpha(3),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: disabledOutlineBorderColor),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${customer["customer"]}",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "${customer["orders"]} orders",
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
                  "\$${((customer["value"] as num) / 1000).toStringAsFixed(0)}K",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: successColor,
                  ),
                ),
                Text(
                  "Total Value",
                  style: TextStyle(
                    fontSize: 10,
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
                  "\$${((customer["avgOrder"] as num) / 1000).toStringAsFixed(1)}K",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "Avg Order",
                  style: TextStyle(
                    fontSize: 10,
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

  Widget _buildOrderTrends() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Order Trends",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Container(
            height: 200,
            width: double.infinity,
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(5),
              borderRadius: BorderRadius.circular(radiusSm),
              border: Border.all(color: disabledOutlineBorderColor),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.trending_up,
                    size: 48,
                    color: primaryColor.withAlpha(100),
                  ),
                  SizedBox(height: spXs),
                  Text(
                    "Order Analytics Chart",
                    style: TextStyle(
                      color: disabledBoldColor,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showCreateOrderDialog() {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        child: Container(
          padding: EdgeInsets.all(spMd),
          width: 500,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            spacing: spSm,
            children: [
              Text(
                "Create New Order",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              QTextField(
                label: "Customer Name",
                value: "",
                onChanged: (value) => setState(() {}),
              ),
              Row(
                children: [
                  Expanded(
                    child: QDropdownField(
                      label: "Priority",
                      items: priorityOptions.where((p) => p["value"] != "all").toList(),
                      value: "medium",
                      onChanged: (value, label) => setState(() {}),
                    ),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: QDatePicker(
                      label: "Requested Date",
                      value: DateTime.now().add(Duration(days: 3)),
                      onChanged: (value) => setState(() {}),
                    ),
                  ),
                ],
              ),
              QMemoField(
                label: "Special Instructions",
                value: "",
                onChanged: (value) => setState(() {}),
              ),
              Row(
                children: [
                  Expanded(
                    child: QButton(
                      label: "Cancel",
                      size: bs.sm,
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: QButton(
                      label: "Create Order",
                      size: bs.sm,
                      onPressed: () {
                        Navigator.pop(context);
                        ss("Order created successfully");
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _processOrder(Map<String, dynamic> order) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        child: Container(
          padding: EdgeInsets.all(spMd),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            spacing: spSm,
            children: [
              Text(
                "Process Order",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Text(
                "Are you sure you want to process order ${order["orderId"]}?",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: disabledBoldColor,
                ),
              ),
              Text(
                "This will move the order to processing queue and allocate inventory.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: QButton(
                      label: "Cancel",
                      size: bs.sm,
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: QButton(
                      label: "Process",
                      size: bs.sm,
                      onPressed: () {
                        Navigator.pop(context);
                        ss("Order moved to processing");
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showOrderDetails(Map<String, dynamic> order) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        child: Container(
          padding: EdgeInsets.all(spMd),
          width: 600,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            spacing: spSm,
            children: [
              Text(
                "Order Details",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Container(
                height: 300,
                child: SingleChildScrollView(
                  child: Column(
                    spacing: spSm,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildDetailRow("Order ID", "${order["orderId"]}"),
                      _buildDetailRow("Customer", "${order["customer"]}"),
                      _buildDetailRow("Status", "${order["status"]}"),
                      _buildDetailRow("Priority", "${order["priority"]}"),
                      _buildDetailRow("Order Date", "${order["orderDate"]}"),
                      _buildDetailRow("Total Value", "\$${(order["totalValue"] as double).toStringAsFixed(2)}"),
                      _buildDetailRow("Total Items", "${order["totalItems"]}"),
                      _buildDetailRow("Weight", "${order["totalWeight"]} kg"),
                      Text(
                        "Shipping Address:",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text("${(order["shippingAddress"] as Map<String, dynamic>)["street"]}"),
                      Text("${(order["shippingAddress"] as Map<String, dynamic>)["city"]}, ${(order["shippingAddress"] as Map<String, dynamic>)["state"]} ${(order["shippingAddress"] as Map<String, dynamic>)["zip"]}"),
                      if (order["specialInstructions"] != null) ...[
                        Text(
                          "Special Instructions:",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text("${order["specialInstructions"]}"),
                      ],
                    ],
                  ),
                ),
              ),
              QButton(
                label: "Close",
                size: bs.sm,
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: Text(
            "$label:",
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
        ),
        Expanded(
          flex: 3,
          child: Text(value),
        ),
      ],
    );
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'pending':
        return warningColor;
      case 'processing':
        return primaryColor;
      case 'ready':
        return infoColor;
      case 'shipped':
        return successColor;
      default:
        return disabledBoldColor;
    }
  }

  Color _getPriorityColor(String priority) {
    switch (priority.toLowerCase()) {
      case 'high':
        return dangerColor;
      case 'medium':
        return warningColor;
      case 'low':
        return successColor;
      default:
        return disabledBoldColor;
    }
  }
}
