import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class RmaPurchaseOrdersView extends StatefulWidget {
  const RmaPurchaseOrdersView({super.key});

  @override
  State<RmaPurchaseOrdersView> createState() => _RmaPurchaseOrdersViewState();
}

class _RmaPurchaseOrdersViewState extends State<RmaPurchaseOrdersView> {
  String selectedStatus = "all";
  String selectedSupplier = "all";
  String searchQuery = "";
  
  List<Map<String, dynamic>> purchaseOrders = [
    {
      "id": "PO-001",
      "orderNumber": "PO-2024-001",
      "supplier": "Fresh Produce Co.",
      "orderDate": "2024-03-15",
      "deliveryDate": "2024-03-17",
      "status": "pending",
      "totalAmount": 1250.00,
      "itemCount": 15,
      "priority": "high",
      "items": [
        {"name": "Tomatoes", "quantity": 20, "unit": "kg", "price": 3.50},
        {"name": "Lettuce", "quantity": 15, "unit": "heads", "price": 2.25},
        {"name": "Onions", "quantity": 10, "unit": "kg", "price": 2.80},
      ],
      "notes": "Rush delivery needed for weekend specials",
    },
    {
      "id": "PO-002",
      "orderNumber": "PO-2024-002",
      "supplier": "Ocean Fresh Seafood",
      "orderDate": "2024-03-14",
      "deliveryDate": "2024-03-16",
      "status": "approved",
      "totalAmount": 875.50,
      "itemCount": 8,
      "priority": "medium",
      "items": [
        {"name": "Salmon Fillet", "quantity": 5, "unit": "kg", "price": 45.00},
        {"name": "Shrimp", "quantity": 3, "unit": "kg", "price": 28.50},
        {"name": "Cod", "quantity": 4, "unit": "kg", "price": 32.00},
      ],
      "notes": "Check freshness upon delivery",
    },
    {
      "id": "PO-003",
      "orderNumber": "PO-2024-003",
      "supplier": "Quality Meats Ltd",
      "orderDate": "2024-03-13",
      "deliveryDate": "2024-03-15",
      "status": "delivered",
      "totalAmount": 2100.75,
      "itemCount": 12,
      "priority": "high",
      "items": [
        {"name": "Beef Ribeye", "quantity": 8, "unit": "kg", "price": 65.00},
        {"name": "Chicken Breast", "quantity": 10, "unit": "kg", "price": 18.50},
        {"name": "Pork Tenderloin", "quantity": 6, "unit": "kg", "price": 28.00},
      ],
      "notes": "Premium cuts for special menu",
    },
    {
      "id": "PO-004",
      "orderNumber": "PO-2024-004",
      "supplier": "Dairy Express",
      "orderDate": "2024-03-16",
      "deliveryDate": "2024-03-18",
      "status": "pending",
      "totalAmount": 450.25,
      "itemCount": 6,
      "priority": "low",
      "items": [
        {"name": "Heavy Cream", "quantity": 10, "unit": "liters", "price": 8.50},
        {"name": "Butter", "quantity": 5, "unit": "kg", "price": 12.00},
        {"name": "Cheese", "quantity": 3, "unit": "kg", "price": 25.00},
      ],
      "notes": "Regular weekly order",
    },
    {
      "id": "PO-005",
      "orderNumber": "PO-2024-005",
      "supplier": "Beverage Distributors",
      "orderDate": "2024-03-12",
      "deliveryDate": "2024-03-14",
      "status": "cancelled",
      "totalAmount": 680.00,
      "itemCount": 20,
      "priority": "medium",
      "items": [
        {"name": "Wine Selection", "quantity": 12, "unit": "bottles", "price": 25.00},
        {"name": "Craft Beer", "quantity": 24, "unit": "bottles", "price": 8.50},
        {"name": "Soft Drinks", "quantity": 48, "unit": "cans", "price": 1.75},
      ],
      "notes": "Order cancelled due to supplier issues",
    },
  ];

  List<Map<String, dynamic>> statusOptions = [
    {"label": "All Status", "value": "all"},
    {"label": "Pending", "value": "pending"},
    {"label": "Approved", "value": "approved"},
    {"label": "Delivered", "value": "delivered"},
    {"label": "Cancelled", "value": "cancelled"},
  ];

  List<Map<String, dynamic>> supplierOptions = [
    {"label": "All Suppliers", "value": "all"},
    {"label": "Fresh Produce Co.", "value": "Fresh Produce Co."},
    {"label": "Ocean Fresh Seafood", "value": "Ocean Fresh Seafood"},
    {"label": "Quality Meats Ltd", "value": "Quality Meats Ltd"},
    {"label": "Dairy Express", "value": "Dairy Express"},
    {"label": "Beverage Distributors", "value": "Beverage Distributors"},
  ];

  List<Map<String, dynamic>> get filteredOrders {
    return purchaseOrders.where((order) {
      final matchesStatus = selectedStatus == "all" || order["status"] == selectedStatus;
      final matchesSupplier = selectedSupplier == "all" || order["supplier"] == selectedSupplier;
      final matchesSearch = searchQuery.isEmpty ||
          order["orderNumber"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
          order["supplier"].toString().toLowerCase().contains(searchQuery.toLowerCase());
      
      return matchesStatus && matchesSupplier && matchesSearch;
    }).toList();
  }

  Widget _buildHeader() {
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
              Icon(
                Icons.shopping_cart,
                color: primaryColor,
                size: 24,
              ),
              SizedBox(width: spSm),
              Text(
                "Purchase Orders",
                style: TextStyle(
                  fontSize: fsH5,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Spacer(),
              QButton(
                label: "New Order",
                icon: Icons.add,
                size: bs.sm,
                onPressed: () {
                  //navigateTo('CreatePurchaseOrder')
                },
              ),
            ],
          ),
          SizedBox(height: spMd),
          Row(
            children: [
              Expanded(
                child: QTextField(
                  label: "Search orders...",
                  value: searchQuery,
                  hint: "Order number, supplier",
                  onChanged: (value) {
                    searchQuery = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
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
                  label: "Supplier",
                  items: supplierOptions,
                  value: selectedSupplier,
                  onChanged: (value, label) {
                    selectedSupplier = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildOrderSummary() {
    final totalOrders = filteredOrders.length;
    final totalAmount = filteredOrders.fold(0.0, (sum, order) => sum + (order["totalAmount"] as double));
    final pendingOrders = filteredOrders.where((o) => o["status"] == "pending").length;
    final deliveredOrders = filteredOrders.where((o) => o["status"] == "delivered").length;

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
            "Order Summary",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),
          ResponsiveGridView(
            minItemWidth: 200,
            children: [
              _buildSummaryCard(
                "Total Orders",
                "$totalOrders",
                Icons.receipt_long,
                primaryColor,
              ),
              _buildSummaryCard(
                "Total Value",
                "\$${totalAmount.currency}",
                Icons.attach_money,
                successColor,
              ),
              _buildSummaryCard(
                "Pending",
                "$pendingOrders",
                Icons.pending,
                warningColor,
              ),
              _buildSummaryCard(
                "Delivered",
                "$deliveredOrders",
                Icons.check_circle,
                infoColor,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryCard(String title, String value, IconData icon, Color color) {
    return Container(
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
            size: 32,
          ),
          SizedBox(height: spSm),
          Text(
            value,
            style: TextStyle(
              fontSize: fsH5,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          SizedBox(height: spXs),
          Text(
            title,
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
            "Purchase Orders (${filteredOrders.length})",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),
          if (filteredOrders.isEmpty)
            Container(
              padding: EdgeInsets.all(spLg),
              child: Column(
                children: [
                  Icon(
                    Icons.shopping_cart_outlined,
                    size: 64,
                    color: disabledColor,
                  ),
                  SizedBox(height: spMd),
                  Text(
                    "No purchase orders found",
                    style: TextStyle(
                      fontSize: 16,
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ),
            )
          else
            ...filteredOrders.map((order) => _buildOrderCard(order)).toList(),
        ],
      ),
    );
  }

  Widget _buildOrderCard(Map<String, dynamic> order) {
    final statusColor = _getStatusColor(order["status"]);
    final priorityColor = _getPriorityColor(order["priority"]);

    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: statusColor.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border(
          left: BorderSide(
            width: 4,
            color: statusColor,
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
                    Row(
                      children: [
                        Text(
                          "${order["orderNumber"]}",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        SizedBox(width: spSm),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                          decoration: BoxDecoration(
                            color: statusColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusLg),
                          ),
                          child: Text(
                            "${order["status"]}".toUpperCase(),
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color: statusColor,
                            ),
                          ),
                        ),
                        SizedBox(width: spXs),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                          decoration: BoxDecoration(
                            color: priorityColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusLg),
                          ),
                          child: Text(
                            "${order["priority"]}".toUpperCase(),
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color: priorityColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "${order["supplier"]}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
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
                    "\$${(order["totalAmount"] as double).currency}",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: successColor,
                    ),
                  ),
                  Text(
                    "${order["itemCount"]} items",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              Icon(
                Icons.calendar_today,
                size: 16,
                color: disabledBoldColor,
              ),
              SizedBox(width: spXs),
              Text(
                "Order: ${order["orderDate"]}",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
              SizedBox(width: spMd),
              Icon(
                Icons.local_shipping,
                size: 16,
                color: disabledBoldColor,
              ),
              SizedBox(width: spXs),
              Text(
                "Delivery: ${order["deliveryDate"]}",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
          if (order["notes"] != null && order["notes"].toString().isNotEmpty) ...[
            SizedBox(height: spSm),
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.grey.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.note,
                    size: 16,
                    color: disabledBoldColor,
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Text(
                      "${order["notes"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
          SizedBox(height: spSm),
          Row(
            children: [
              Expanded(
                child: QButton(
                  label: "View Details",
                  size: bs.sm,
                  onPressed: () {
                    //navigateTo('PurchaseOrderDetails')
                  },
                ),
              ),
              SizedBox(width: spSm),
              if (order["status"] == "pending") ...[
                QButton(
                  label: "Approve",
                  size: bs.sm,
                  onPressed: () {
                    //approveOrder()
                  },
                ),
                SizedBox(width: spSm),
                QButton(
                  label: "Cancel",
                  size: bs.sm,
                  onPressed: () {
                    //cancelOrder()
                  },
                ),
              ],
              if (order["status"] == "approved")
                QButton(
                  label: "Mark Delivered",
                  size: bs.sm,
                  onPressed: () {
                    //markDelivered()
                  },
                ),
            ],
          ),
        ],
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "pending":
        return warningColor;
      case "approved":
        return infoColor;
      case "delivered":
        return successColor;
      case "cancelled":
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  Color _getPriorityColor(String priority) {
    switch (priority) {
      case "high":
        return dangerColor;
      case "medium":
        return warningColor;
      case "low":
        return infoColor;
      default:
        return disabledBoldColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Purchase Orders"),
        actions: [
          IconButton(
            icon: Icon(Icons.filter_list),
            onPressed: () {
              //navigateTo('OrderFilters')
            },
          ),
          IconButton(
            icon: Icon(Icons.file_download),
            onPressed: () {
              //exportOrders()
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            _buildHeader(),
            _buildOrderSummary(),
            _buildOrdersList(),
          ],
        ),
      ),
    );
  }
}
