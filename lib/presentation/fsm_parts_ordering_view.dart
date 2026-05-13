import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class FsmPartsOrderingView extends StatefulWidget {
  const FsmPartsOrderingView({super.key});

  @override
  State<FsmPartsOrderingView> createState() => _FsmPartsOrderingViewState();
}

class _FsmPartsOrderingViewState extends State<FsmPartsOrderingView> {
  int currentTab = 0;
  String selectedSupplier = "All Suppliers";
  String orderStatus = "All";
  String searchQuery = "";

  List<Map<String, dynamic>> suppliers = [
    {"label": "All Suppliers", "value": "All Suppliers"},
    {"label": "Siemens AG", "value": "Siemens AG"},
    {"label": "ABB Ltd", "value": "ABB Ltd"},
    {"label": "Parker Hannifin", "value": "Parker Hannifin"},
    {"label": "SKF Group", "value": "SKF Group"},
    {"label": "Fluke Corporation", "value": "Fluke Corporation"},
    {"label": "SafetyFirst Inc", "value": "SafetyFirst Inc"},
  ];

  List<Map<String, dynamic>> statusOptions = [
    {"label": "All", "value": "All"},
    {"label": "Draft", "value": "Draft"},
    {"label": "Pending", "value": "Pending"},
    {"label": "Approved", "value": "Approved"},
    {"label": "Ordered", "value": "Ordered"},
    {"label": "Delivered", "value": "Delivered"},
    {"label": "Cancelled", "value": "Cancelled"},
  ];

  List<Map<String, dynamic>> cartItems = [
    {
      "id": "PART001",
      "name": "Variable Frequency Drive",
      "partNumber": "SINAMICS-G120C-5HP",
      "supplier": "Siemens AG",
      "unitPrice": 1250.00,
      "quantity": 3,
      "category": "Electrical",
      "urgency": "High",
      "requestedBy": "John Smith",
      "dateAdded": "2025-06-18",
    },
    {
      "id": "PART002",
      "name": "Safety Helmets",
      "partNumber": "HELM-STD-001",
      "supplier": "SafetyFirst Inc",
      "unitPrice": 28.75,
      "quantity": 20,
      "category": "Safety",
      "urgency": "Medium",
      "requestedBy": "Sarah Johnson",
      "dateAdded": "2025-06-18",
    },
    {
      "id": "PART003",
      "name": "Hydraulic Pump",
      "partNumber": "PARKER-PV140R1K1T1NMMC",
      "supplier": "Parker Hannifin",
      "unitPrice": 2850.00,
      "quantity": 1,
      "category": "Hydraulic",
      "urgency": "Critical",
      "requestedBy": "Mike Wilson",
      "dateAdded": "2025-06-17",
    },
  ];

  List<Map<String, dynamic>> orders = [
    {
      "orderNumber": "PO-2025-0156",
      "supplier": "Siemens AG",
      "orderDate": "2025-06-15",
      "expectedDelivery": "2025-06-28",
      "status": "Ordered",
      "totalAmount": 5670.00,
      "items": 4,
      "urgency": "High",
      "approvedBy": "David Brown",
      "trackingNumber": "TRK123456789",
    },
    {
      "orderNumber": "PO-2025-0155",
      "supplier": "ABB Ltd",
      "orderDate": "2025-06-12",
      "expectedDelivery": "2025-06-25",
      "status": "Approved",
      "totalAmount": 1890.50,
      "items": 6,
      "urgency": "Medium",
      "approvedBy": "Lisa Chen",
      "trackingNumber": "",
    },
    {
      "orderNumber": "PO-2025-0154",
      "supplier": "Parker Hannifin",
      "orderDate": "2025-06-10",
      "expectedDelivery": "2025-06-22",
      "status": "Delivered",
      "totalAmount": 3420.75,
      "items": 2,
      "urgency": "Critical",
      "approvedBy": "David Brown",
      "trackingNumber": "TRK987654321",
    },
    {
      "orderNumber": "PO-2025-0153",
      "supplier": "SKF Group",
      "orderDate": "2025-06-08",
      "expectedDelivery": "2025-06-20",
      "status": "Pending",
      "totalAmount": 890.25,
      "items": 8,
      "urgency": "Low",
      "approvedBy": "",
      "trackingNumber": "",
    },
  ];

  List<Map<String, dynamic>> quickOrderItems = [
    {
      "id": "PART001",
      "name": "Emergency Stop Switch",
      "partNumber": "EMG-STOP-001",
      "supplier": "SafetyFirst Inc",
      "unitPrice": 89.99,
      "category": "Critical Parts",
      "inStock": 5,
      "minLevel": 15,
    },
    {
      "id": "PART002",
      "name": "Circuit Breaker 20A",
      "partNumber": "CB-20A-001",
      "supplier": "Siemens AG",
      "unitPrice": 45.99,
      "category": "Electrical",
      "inStock": 8,
      "minLevel": 20,
    },
    {
      "id": "PART003",
      "name": "Ball Bearing SKF-6205",
      "partNumber": "SKF-6205-2RS1",
      "supplier": "SKF Group",
      "unitPrice": 45.99,
      "category": "Mechanical",
      "inStock": 12,
      "minLevel": 25,
    },
  ];

  List<Map<String, dynamic>> get filteredOrders {
    return orders.where((order) {
      bool matchesSupplier = selectedSupplier == "All Suppliers" || order["supplier"] == selectedSupplier;
      bool matchesStatus = orderStatus == "All" || order["status"] == orderStatus;
      bool matchesSearch = searchQuery.isEmpty || 
                          "${order["orderNumber"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
                          "${order["supplier"]}".toLowerCase().contains(searchQuery.toLowerCase());
      
      return matchesSupplier && matchesStatus && matchesSearch;
    }).toList();
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "Draft":
        return disabledBoldColor;
      case "Pending":
        return warningColor;
      case "Approved":
        return infoColor;
      case "Ordered":
        return primaryColor;
      case "Delivered":
        return successColor;
      case "Cancelled":
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  Color _getUrgencyColor(String urgency) {
    switch (urgency) {
      case "Critical":
        return dangerColor;
      case "High":
        return warningColor;
      case "Medium":
        return infoColor;
      case "Low":
        return successColor;
      default:
        return disabledBoldColor;
    }
  }

  double get cartTotal {
    return cartItems.fold(0.0, (sum, item) => sum + ((item["unitPrice"] as double) * (item["quantity"] as int)));
  }

  Widget _buildCartTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Cart Summary
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Cart Summary",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "${cartItems.length} items",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spSm),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Total Amount:",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "\$${cartTotal.currency}",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: successColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spSm),
                Container(
                  width: double.infinity,
                  child: QButton(
                    label: "Create Purchase Order",
                    size: bs.md,
                    onPressed: () {
                      // Create purchase order
                    },
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: spMd),

          // Cart Items
          Text(
            "Items in Cart",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),

          ...cartItems.map((item) {
            return Container(
              margin: EdgeInsets.only(bottom: spSm),
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
                border: Border(
                  left: BorderSide(
                    width: 4,
                    color: _getUrgencyColor("${item["urgency"]}"),
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
                            Text(
                              "${item["name"]}",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            SizedBox(height: spXs),
                            Text(
                              "Part #: ${item["partNumber"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                        decoration: BoxDecoration(
                          color: _getUrgencyColor("${item["urgency"]}").withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Text(
                          "${item["urgency"]}",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: _getUrgencyColor("${item["urgency"]}"),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),

                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Supplier",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                            Text(
                              "${item["supplier"]}",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
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
                              "Requested by",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                            Text(
                              "${item["requestedBy"]}",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
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
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Unit Price",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                            Text(
                              "\$${(item["unitPrice"] as double).currency}",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
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
                              "Quantity",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                            Text(
                              "${item["quantity"]} units",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
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
                              "Total",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                            Text(
                              "\$${((item["unitPrice"] as double) * (item["quantity"] as int)).currency}",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: successColor,
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
                      Expanded(
                        child: Text(
                          "Added: ${item["dateAdded"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ),
                      QButton(
                        icon: Icons.edit,
                        size: bs.sm,
                        onPressed: () {
                          // Edit quantity
                        },
                      ),
                      SizedBox(width: spXs),
                      QButton(
                        icon: Icons.delete,
                        size: bs.sm,
                        onPressed: () {
                          // Remove from cart
                        },
                      ),
                    ],
                  ),
                ],
              ),
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildOrdersTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
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
              children: [
                Row(
                  children: [
                    Expanded(
                      child: QTextField(
                        label: "Search orders",
                        value: searchQuery,
                        hint: "Order number or supplier",
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
                      onPressed: () {
                        // Perform search
                      },
                    ),
                  ],
                ),
                SizedBox(height: spSm),
                Row(
                  children: [
                    Expanded(
                      child: QDropdownField(
                        label: "Supplier",
                        items: suppliers,
                        value: selectedSupplier,
                        onChanged: (value, label) {
                          selectedSupplier = value;
                          setState(() {});
                        },
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: QDropdownField(
                        label: "Status",
                        items: statusOptions,
                        value: orderStatus,
                        onChanged: (value, label) {
                          orderStatus = value;
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

          // Orders List
          Text(
            "Purchase Orders (${filteredOrders.length})",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),

          ...filteredOrders.map((order) {
            return Container(
              margin: EdgeInsets.only(bottom: spSm),
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
                border: Border(
                  left: BorderSide(
                    width: 4,
                    color: _getStatusColor("${order["status"]}"),
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
                            Text(
                              "${order["orderNumber"]}",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            SizedBox(height: spXs),
                            Text(
                              "${order["supplier"]}",
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
                          color: _getStatusColor("${order["status"]}").withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Text(
                          "${order["status"]}",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: _getStatusColor("${order["status"]}"),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),

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
                              "${order["orderDate"]}",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
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
                              "Expected Delivery",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                            Text(
                              "${order["expectedDelivery"]}",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
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
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: successColor,
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
                              "${order["items"]} parts",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
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
                      Expanded(
                        child: Text(
                          "Approved by: ${order["approvedBy"].toString().isEmpty ? 'Pending' : order["approvedBy"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ),
                      QButton(
                        icon: Icons.visibility,
                        size: bs.sm,
                        onPressed: () {
                          // View order details
                        },
                      ),
                      SizedBox(width: spXs),
                      QButton(
                        icon: Icons.local_shipping,
                        size: bs.sm,
                        onPressed: () {
                          // Track order
                        },
                      ),
                    ],
                  ),
                ],
              ),
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildQuickOrderTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Quick Order - Low Stock Items",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),

          ...quickOrderItems.map((item) {
            return Container(
              margin: EdgeInsets.only(bottom: spSm),
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
                border: Border(
                  left: BorderSide(
                    width: 4,
                    color: (item["inStock"] as int) < (item["minLevel"] as int) ? dangerColor : warningColor,
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
                            Text(
                              "${item["name"]}",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            SizedBox(height: spXs),
                            Text(
                              "Part #: ${item["partNumber"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                        decoration: BoxDecoration(
                          color: ((item["inStock"] as int) < (item["minLevel"] as int) ? dangerColor : warningColor).withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Text(
                          (item["inStock"] as int) < (item["minLevel"] as int) ? "Critical" : "Low Stock",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: (item["inStock"] as int) < (item["minLevel"] as int) ? dangerColor : warningColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),

                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Current Stock",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                            Text(
                              "${item["inStock"]} units",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: (item["inStock"] as int) < (item["minLevel"] as int) ? dangerColor : warningColor,
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
                              "Min Level",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                            Text(
                              "${item["minLevel"]} units",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
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
                              "Unit Price",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                            Text(
                              "\$${(item["unitPrice"] as double).currency}",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),

                  Container(
                    width: double.infinity,
                    child: QButton(
                      label: "Add to Cart (Recommended: ${(item["minLevel"] as int) - (item["inStock"] as int) + 5} units)",
                      size: bs.sm,
                      onPressed: () {
                        // Add to cart with recommended quantity
                      },
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Parts Ordering",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Cart", icon: Icon(Icons.shopping_cart)),
        Tab(text: "Orders", icon: Icon(Icons.receipt_long)),
        Tab(text: "Quick Order", icon: Icon(Icons.flash_on)),
      ],
      tabChildren: [
        _buildCartTab(),
        _buildOrdersTab(),
        _buildQuickOrderTab(),
      ],
      onInit: (tabController) {
        // Optional: Access to TabController
      },
    );
  }
}
