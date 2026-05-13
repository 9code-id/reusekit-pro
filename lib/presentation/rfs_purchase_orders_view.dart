import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class RfsPurchaseOrdersView extends StatefulWidget {
  const RfsPurchaseOrdersView({super.key});

  @override
  State<RfsPurchaseOrdersView> createState() => _RfsPurchaseOrdersViewState();
}

class _RfsPurchaseOrdersViewState extends State<RfsPurchaseOrdersView> {
  int currentTab = 0;
  String searchQuery = "";
  String selectedStatus = "All";
  String selectedPriority = "All";

  List<Map<String, dynamic>> statusOptions = [
    {"label": "All", "value": "All"},
    {"label": "Draft", "value": "Draft"},
    {"label": "Pending", "value": "Pending"},
    {"label": "Approved", "value": "Approved"},
    {"label": "Sent", "value": "Sent"},
    {"label": "Delivered", "value": "Delivered"},
    {"label": "Cancelled", "value": "Cancelled"},
  ];

  List<Map<String, dynamic>> priorityOptions = [
    {"label": "All", "value": "All"},
    {"label": "Low", "value": "Low"},
    {"label": "Medium", "value": "Medium"},
    {"label": "High", "value": "High"},
    {"label": "Urgent", "value": "Urgent"},
  ];

  List<Map<String, dynamic>> purchaseOrders = [
    {
      "id": "PO-2024-001",
      "supplier": "Fresh Valley Produce",
      "supplierContact": "John Smith",
      "orderDate": "2024-12-18",
      "expectedDelivery": "2024-12-20",
      "status": "Sent",
      "priority": "High",
      "totalAmount": 2450.00,
      "items": [
        {"name": "Tomatoes", "quantity": 50, "unit": "lbs", "unitPrice": 3.50, "total": 175.00},
        {"name": "Lettuce", "quantity": 30, "unit": "heads", "unitPrice": 2.25, "total": 67.50},
        {"name": "Onions", "quantity": 25, "unit": "lbs", "unitPrice": 1.80, "total": 45.00},
        {"name": "Carrots", "quantity": 40, "unit": "lbs", "unitPrice": 2.10, "total": 84.00},
      ],
      "approver": "Chef Martinez",
      "notes": "Urgent order for weekend rush",
    },
    {
      "id": "PO-2024-002",
      "supplier": "Premium Dairy Co",
      "supplierContact": "Sarah Johnson",
      "orderDate": "2024-12-17",
      "expectedDelivery": "2024-12-19",
      "status": "Delivered",
      "priority": "Medium",
      "totalAmount": 890.50,
      "items": [
        {"name": "Whole Milk", "quantity": 20, "unit": "gallons", "unitPrice": 4.25, "total": 85.00},
        {"name": "Cheddar Cheese", "quantity": 15, "unit": "lbs", "unitPrice": 8.90, "total": 133.50},
        {"name": "Butter", "quantity": 10, "unit": "lbs", "unitPrice": 6.75, "total": 67.50},
        {"name": "Heavy Cream", "quantity": 12, "unit": "quarts", "unitPrice": 5.20, "total": 62.40},
      ],
      "approver": "Manager Davis",
      "notes": "Regular weekly order",
    },
    {
      "id": "PO-2024-003",
      "supplier": "Ocean Fresh Seafood",
      "supplierContact": "Mike Rodriguez",
      "orderDate": "2024-12-16",
      "expectedDelivery": "2024-12-21",
      "status": "Approved",
      "priority": "Urgent",
      "totalAmount": 1250.00,
      "items": [
        {"name": "Atlantic Salmon", "quantity": 20, "unit": "lbs", "unitPrice": 18.50, "total": 370.00},
        {"name": "Shrimp", "quantity": 15, "unit": "lbs", "unitPrice": 22.00, "total": 330.00},
        {"name": "Tuna", "quantity": 12, "unit": "lbs", "unitPrice": 28.50, "total": 342.00},
      ],
      "approver": "Chef Martinez",
      "notes": "Special order for seafood night menu",
    },
    {
      "id": "PO-2024-004",
      "supplier": "Mountain Beverages",
      "supplierContact": "Lisa Chen",
      "orderDate": "2024-12-15",
      "expectedDelivery": "2024-12-18",
      "status": "Pending",
      "priority": "Low",
      "totalAmount": 456.75,
      "items": [
        {"name": "Soft Drinks", "quantity": 48, "unit": "cans", "unitPrice": 1.25, "total": 60.00},
        {"name": "Orange Juice", "quantity": 24, "unit": "bottles", "unitPrice": 3.50, "total": 84.00},
        {"name": "Coffee Beans", "quantity": 10, "unit": "lbs", "unitPrice": 12.50, "total": 125.00},
      ],
      "approver": "Pending",
      "notes": "Monthly beverage restock",
    },
    {
      "id": "PO-2024-005",
      "supplier": "Golden Grains Supply",
      "supplierContact": "Robert Kim",
      "orderDate": "2024-12-14",
      "expectedDelivery": "2024-12-22",
      "status": "Draft",
      "priority": "Medium",
      "totalAmount": 675.25,
      "items": [
        {"name": "White Rice", "quantity": 50, "unit": "lbs", "unitPrice": 2.45, "total": 122.50},
        {"name": "All-Purpose Flour", "quantity": 40, "unit": "lbs", "unitPrice": 1.85, "total": 74.00},
        {"name": "Pasta", "quantity": 30, "unit": "lbs", "unitPrice": 2.95, "total": 88.50},
        {"name": "Black Beans", "quantity": 25, "unit": "lbs", "unitPrice": 3.25, "total": 81.25},
      ],
      "approver": "Not assigned",
      "notes": "Dry goods inventory replenishment",
    },
  ];

  List<Map<String, dynamic>> get filteredOrders {
    return purchaseOrders.where((order) {
      bool matchesSearch = "${order["id"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
          "${order["supplier"]}".toLowerCase().contains(searchQuery.toLowerCase());
      
      bool matchesStatus = selectedStatus == "All" || order["status"] == selectedStatus;
      bool matchesPriority = selectedPriority == "All" || order["priority"] == selectedPriority;
      
      return matchesSearch && matchesStatus && matchesPriority;
    }).toList();
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "Draft":
        return disabledColor;
      case "Pending":
        return warningColor;
      case "Approved":
        return infoColor;
      case "Sent":
        return primaryColor;
      case "Delivered":
        return successColor;
      case "Cancelled":
        return dangerColor;
      default:
        return disabledColor;
    }
  }

  Color _getPriorityColor(String priority) {
    switch (priority) {
      case "Low":
        return successColor;
      case "Medium":
        return warningColor;
      case "High":
        return primaryColor;
      case "Urgent":
        return dangerColor;
      default:
        return disabledColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Purchase Orders",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Orders", icon: Icon(Icons.shopping_cart)),
        Tab(text: "Analytics", icon: Icon(Icons.analytics)),
        Tab(text: "Templates", icon: Icon(Icons.description)),
      ],
      tabChildren: [
        _buildOrdersTab(),
        _buildAnalyticsTab(),
        _buildTemplatesTab(),
      ],
    );
  }

  Widget _buildOrdersTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          Row(
            children: [
              Expanded(
                child: QTextField(
                  label: "Search orders...",
                  value: searchQuery,
                  onChanged: (value) {
                    searchQuery = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              QButton(
                icon: Icons.add,
                size: bs.sm,
                onPressed: () {
                  // Create new purchase order
                },
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
                  label: "Priority",
                  items: priorityOptions,
                  value: selectedPriority,
                  onChanged: (value, label) {
                    selectedPriority = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),

          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: [
              _buildStatusCard("Total Orders", "${purchaseOrders.length}", Icons.shopping_cart, primaryColor),
              _buildStatusCard("Pending", "${purchaseOrders.where((o) => o["status"] == "Pending").length}", Icons.pending, warningColor),
              _buildStatusCard("Delivered", "${purchaseOrders.where((o) => o["status"] == "Delivered").length}", Icons.check_circle, successColor),
              _buildStatusCard("Urgent", "${purchaseOrders.where((o) => o["priority"] == "Urgent").length}", Icons.priority_high, dangerColor),
            ],
          ),

          ListView.separated(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: filteredOrders.length,
            separatorBuilder: (context, index) => SizedBox(height: spSm),
            itemBuilder: (context, index) {
              final order = filteredOrders[index];
              return _buildOrderCard(order);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildAnalyticsTab() {
    double totalValue = purchaseOrders.fold(0.0, (sum, order) => sum + (order["totalAmount"] as double));
    double avgOrderValue = totalValue / purchaseOrders.length;

    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: [
              _buildMetricCard("Total Spend", "\$${totalValue.currency}", Icons.attach_money, primaryColor),
              _buildMetricCard("Avg Order Value", "\$${avgOrderValue.currency}", Icons.trending_up, successColor),
              _buildMetricCard("This Month", "${purchaseOrders.length}", Icons.calendar_month, infoColor),
              _buildMetricCard("On-Time Delivery", "92%", Icons.schedule, warningColor),
            ],
          ),

          Container(
            width: double.infinity,
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
                  "Orders by Status",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                ...statusOptions
                    .where((status) => status["value"] != "All")
                    .map((status) {
                  int count = purchaseOrders.where((o) => o["status"] == status["value"]).length;
                  return _buildStatusAnalyticItem("${status["label"]}", count, _getStatusColor("${status["value"]}"));
                }),
              ],
            ),
          ),

          Container(
            width: double.infinity,
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
                  "Top Suppliers by Order Value",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                ..._getTopSuppliers().map((supplier) => _buildSupplierAnalyticItem(supplier)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTemplatesTab() {
    List<Map<String, dynamic>> templates = [
      {
        "name": "Weekly Produce Order",
        "description": "Standard weekly fresh produce order template",
        "category": "Produce",
        "lastUsed": "2024-12-15",
        "items": 8,
      },
      {
        "name": "Dairy Restock",
        "description": "Monthly dairy products restock template",
        "category": "Dairy",
        "lastUsed": "2024-12-10",
        "items": 6,
      },
      {
        "name": "Seafood Special",
        "description": "Special seafood order for events",
        "category": "Seafood",
        "lastUsed": "2024-12-05",
        "items": 5,
      },
    ];

    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  "Order Templates",
                  style: TextStyle(
                    fontSize: fsH5,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
              ),
              QButton(
                icon: Icons.add,
                size: bs.sm,
                onPressed: () {
                  // Create new template
                },
              ),
            ],
          ),

          ...templates.map((template) => _buildTemplateCard(template)),
        ],
      ),
    );
  }

  Widget _buildOrderCard(Map<String, dynamic> order) {
    return Container(
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
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${order["id"]}",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "${order["supplier"]}",
                      style: TextStyle(
                        color: disabledBoldColor,
                        fontSize: 14,
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
                      color: _getStatusColor("${order["status"]}").withAlpha(51),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Text(
                      "${order["status"]}",
                      style: TextStyle(
                        color: _getStatusColor("${order["status"]}"),
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  SizedBox(height: spXs),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                    decoration: BoxDecoration(
                      color: _getPriorityColor("${order["priority"]}").withAlpha(51),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Text(
                      "${order["priority"]}",
                      style: TextStyle(
                        color: _getPriorityColor("${order["priority"]}"),
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),

          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Order Date",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "${DateTime.parse("${order["orderDate"]}").dMMMy}",
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Expected Delivery",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "${DateTime.parse("${order["expectedDelivery"]}").dMMMy}",
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
            ],
          ),

          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Total Amount",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "\$${(order["totalAmount"] as double).currency}",
                      style: TextStyle(
                        fontSize: 18,
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
                      "Items",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "${(order["items"] as List).length} items",
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
            ],
          ),

          if ("${order["notes"]}".isNotEmpty)
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: primaryColor.withAlpha(25),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Row(
                children: [
                  Icon(Icons.note, size: 16, color: primaryColor),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Text(
                      "${order["notes"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: primaryColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),

          Row(
            children: [
              Expanded(
                child: QButton(
                  label: "View Details",
                  size: bs.sm,
                  onPressed: () {
                    // View order details
                  },
                ),
              ),
              SizedBox(width: spSm),
              QButton(
                icon: Icons.edit,
                size: bs.sm,
                onPressed: () {
                  // Edit order
                },
              ),
              SizedBox(width: spXs),
              QButton(
                icon: Icons.more_vert,
                size: bs.sm,
                onPressed: () {
                  // More options
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatusCard(String title, String value, IconData icon, Color color) {
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
          Row(
            children: [
              Icon(icon, color: color, size: 24),
              Spacer(),
              Text(
                value,
                style: TextStyle(
                  fontSize: 24,
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
              color: disabledBoldColor,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMetricCard(String title, String value, IconData icon, Color color) {
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
          Row(
            children: [
              Icon(icon, color: color, size: 24),
              Spacer(),
              Text(
                value,
                style: TextStyle(
                  fontSize: 20,
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
              color: disabledBoldColor,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusAnalyticItem(String status, int count, Color color) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: spSm),
      child: Row(
        children: [
          Container(
            width: 12,
            height: 12,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(radiusSm),
            ),
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Text(
              status,
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
          ),
          Text(
            "$count",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSupplierAnalyticItem(Map<String, dynamic> supplier) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: spSm),
      child: Row(
        children: [
          Expanded(
            child: Text(
              "${supplier["name"]}",
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
          ),
          Text(
            "\$${(supplier["total"] as double).currency}",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTemplateCard(Map<String, dynamic> template) {
    return Container(
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
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${template["name"]}",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "${template["description"]}",
                      style: TextStyle(
                        color: disabledBoldColor,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: primaryColor.withAlpha(51),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Text(
                  "${template["category"]}",
                  style: TextStyle(
                    color: primaryColor,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),

          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Last Used",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "${DateTime.parse("${template["lastUsed"]}").dMMMy}",
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Items",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "${template["items"]} items",
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
            ],
          ),

          Row(
            children: [
              Expanded(
                child: QButton(
                  label: "Use Template",
                  size: bs.sm,
                  onPressed: () {
                    // Use template to create order
                  },
                ),
              ),
              SizedBox(width: spSm),
              QButton(
                icon: Icons.edit,
                size: bs.sm,
                onPressed: () {
                  // Edit template
                },
              ),
              SizedBox(width: spXs),
              QButton(
                icon: Icons.delete,
                size: bs.sm,
                onPressed: () {
                  // Delete template
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  List<Map<String, dynamic>> _getTopSuppliers() {
    Map<String, double> supplierTotals = {};
    
    for (var order in purchaseOrders) {
      String supplier = "${order["supplier"]}";
      double amount = order["totalAmount"] as double;
      supplierTotals[supplier] = (supplierTotals[supplier] ?? 0) + amount;
    }
    
    return supplierTotals.entries
        .map((entry) => {"name": entry.key, "total": entry.value})
        .toList()
      ..sort((a, b) => (b["total"] as double).compareTo(a["total"] as double));
  }
}
