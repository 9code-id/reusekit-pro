import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class ComaMaterialOrdersView extends StatefulWidget {
  const ComaMaterialOrdersView({super.key});

  @override
  State<ComaMaterialOrdersView> createState() => _ComaMaterialOrdersViewState();
}

class _ComaMaterialOrdersViewState extends State<ComaMaterialOrdersView> {
  String searchQuery = "";
  String selectedStatus = "All";
  String selectedPriority = "All";
  int currentTab = 0;

  List<Map<String, dynamic>> statusOptions = [
    {"label": "All", "value": "All"},
    {"label": "Pending", "value": "Pending"},
    {"label": "Approved", "value": "Approved"},
    {"label": "Ordered", "value": "Ordered"},
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

  List<Map<String, dynamic>> orders = [
    {
      "id": "ORD001",
      "orderNumber": "PO-2024-001",
      "date": "2024-06-18",
      "supplier": "BuildMart Supply",
      "status": "Approved",
      "priority": "High",
      "totalAmount": 5400.00,
      "deliveryDate": "2024-06-25",
      "items": [
        {
          "materialId": "MAT001",
          "name": "Portland Cement",
          "quantity": 200,
          "unit": "bags",
          "unitPrice": 12.50,
          "totalPrice": 2500.00
        },
        {
          "materialId": "MAT005",
          "name": "Pine Timber",
          "quantity": 15,
          "unit": "cubic meters",
          "unitPrice": 180.00,
          "totalPrice": 2700.00
        }
      ],
      "requestedBy": "John Smith",
      "approvedBy": "Mike Johnson",
      "notes": "Urgent order for Foundation Project Phase 2",
      "image": "https://picsum.photos/120/120?random=11&keyword=construction"
    },
    {
      "id": "ORD002",
      "orderNumber": "PO-2024-002",
      "date": "2024-06-17",
      "supplier": "Metal Works Ltd",
      "status": "Ordered",
      "priority": "Medium",
      "totalAmount": 3250.00,
      "deliveryDate": "2024-06-22",
      "items": [
        {
          "materialId": "MAT002",
          "name": "Steel Reinforcement Bar",
          "quantity": 5,
          "unit": "tons",
          "unitPrice": 650.00,
          "totalPrice": 3250.00
        }
      ],
      "requestedBy": "Sarah Wilson",
      "approvedBy": "Mike Johnson",
      "notes": "Standard steel order for structural work",
      "image": "https://picsum.photos/120/120?random=12&keyword=steel"
    },
    {
      "id": "ORD003",
      "orderNumber": "PO-2024-003",
      "date": "2024-06-16",
      "supplier": "Sand & Gravel Co",
      "status": "Delivered",
      "priority": "Low",
      "totalAmount": 750.00,
      "deliveryDate": "2024-06-20",
      "items": [
        {
          "materialId": "MAT003",
          "name": "River Sand",
          "quantity": 30,
          "unit": "cubic meters",
          "unitPrice": 25.00,
          "totalPrice": 750.00
        }
      ],
      "requestedBy": "David Brown",
      "approvedBy": "Mike Johnson",
      "notes": "Sand delivery completed successfully",
      "image": "https://picsum.photos/120/120?random=13&keyword=sand"
    },
    {
      "id": "ORD004",
      "orderNumber": "PO-2024-004",
      "date": "2024-06-15",
      "supplier": "Brick Manufacturing",
      "status": "Pending",
      "priority": "Urgent",
      "totalAmount": 1750.00,
      "deliveryDate": "2024-06-21",
      "items": [
        {
          "materialId": "MAT004",
          "name": "Red Clay Bricks",
          "quantity": 5000,
          "unit": "pieces",
          "unitPrice": 0.35,
          "totalPrice": 1750.00
        }
      ],
      "requestedBy": "Lisa Anderson",
      "approvedBy": null,
      "notes": "Emergency brick order - out of stock situation",
      "image": "https://picsum.photos/120/120?random=14&keyword=bricks"
    },
    {
      "id": "ORD005",
      "orderNumber": "PO-2024-005",
      "date": "2024-06-14",
      "supplier": "Paint Store",
      "status": "Cancelled",
      "priority": "Low",
      "totalAmount": 2250.00,
      "deliveryDate": "2024-06-19",
      "items": [
        {
          "materialId": "MAT006",
          "name": "Exterior Paint",
          "quantity": 50,
          "unit": "liters",
          "unitPrice": 45.00,
          "totalPrice": 2250.00
        }
      ],
      "requestedBy": "Tom Wilson",
      "approvedBy": null,
      "notes": "Order cancelled due to specification changes",
      "image": "https://picsum.photos/120/120?random=15&keyword=paint"
    },
  ];

  List<Map<String, dynamic>> get filteredOrders {
    return orders.where((order) {
      bool matchesSearch = searchQuery.isEmpty ||
          (order["orderNumber"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
          (order["supplier"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
          (order["requestedBy"] as String).toLowerCase().contains(searchQuery.toLowerCase());

      bool matchesStatus = selectedStatus == "All" || order["status"] == selectedStatus;
      bool matchesPriority = selectedPriority == "All" || order["priority"] == selectedPriority;

      return matchesSearch && matchesStatus && matchesPriority;
    }).toList();
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "Delivered":
        return successColor;
      case "Approved":
      case "Ordered":
        return infoColor;
      case "Pending":
        return warningColor;
      case "Cancelled":
        return dangerColor;
      default:
        return disabledColor;
    }
  }

  Color _getPriorityColor(String priority) {
    switch (priority) {
      case "Urgent":
        return dangerColor;
      case "High":
        return warningColor;
      case "Medium":
        return infoColor;
      case "Low":
        return successColor;
      default:
        return disabledColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Material Orders"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              //navigateTo('create_order')
            },
          ),
          IconButton(
            icon: Icon(Icons.filter_list),
            onPressed: () {
              _showFilterDialog();
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            // Search Bar
            QTextField(
              label: "Search orders...",
              value: searchQuery,
              hint: "Enter order number, supplier, or requester",
              onChanged: (value) {
                searchQuery = value;
                setState(() {});
              },
            ),

            // Summary Cards
            Row(
              children: [
                Expanded(
                  child: _buildSummaryCard(
                    "Total Orders",
                    "${orders.length}",
                    Icons.shopping_cart,
                    primaryColor,
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: _buildSummaryCard(
                    "Pending",
                    "${orders.where((o) => o["status"] == "Pending").length}",
                    Icons.pending,
                    warningColor,
                  ),
                ),
              ],
            ),

            Row(
              children: [
                Expanded(
                  child: _buildSummaryCard(
                    "This Month",
                    "\$${(orders.fold(0.0, (sum, item) => sum + (item["totalAmount"] as double))).currency}",
                    Icons.attach_money,
                    successColor,
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: _buildSummaryCard(
                    "Urgent Orders",
                    "${orders.where((o) => o["priority"] == "Urgent").length}",
                    Icons.priority_high,
                    dangerColor,
                  ),
                ),
              ],
            ),

            // Quick Status Filters
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                spacing: spSm,
                children: [
                  _buildQuickFilter("All", selectedStatus == "All"),
                  _buildQuickFilter("Pending", selectedStatus == "Pending"),
                  _buildQuickFilter("Approved", selectedStatus == "Approved"),
                  _buildQuickFilter("Ordered", selectedStatus == "Ordered"),
                  _buildQuickFilter("Delivered", selectedStatus == "Delivered"),
                ],
              ),
            ),

            // Orders List
            Column(
              spacing: spSm,
              children: filteredOrders.map((order) {
                return _buildOrderCard(order);
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryCard(String title, String value, IconData icon, Color color) {
    return Container(
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
              Icon(
                icon,
                color: color,
                size: 20,
              ),
              SizedBox(width: spXs),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: spXs),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              value,
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickFilter(String label, bool isActive) {
    return GestureDetector(
      onTap: () {
        selectedStatus = label == "All" ? "All" : label;
        setState(() {});
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
        decoration: BoxDecoration(
          color: isActive ? primaryColor : Colors.white,
          borderRadius: BorderRadius.circular(radiusSm),
          border: Border.all(
            color: isActive ? primaryColor : disabledOutlineBorderColor,
          ),
          boxShadow: [shadowSm],
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isActive ? Colors.white : disabledBoldColor,
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  Widget _buildOrderCard(Map<String, dynamic> order) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
        border: Border(
          left: BorderSide(
            width: 4,
            color: _getStatusColor(order["status"] as String),
          ),
        ),
      ),
      child: Column(
        spacing: spSm,
        children: [
          // Header
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(radiusSm),
                child: Image.network(
                  "${order["image"]}",
                  width: 50,
                  height: 50,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${order["orderNumber"]}",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "${order["supplier"]}",
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
                    padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                    decoration: BoxDecoration(
                      color: _getStatusColor(order["status"] as String).withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                    child: Text(
                      "${order["status"]}",
                      style: TextStyle(
                        fontSize: 10,
                        color: _getStatusColor(order["status"] as String),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  SizedBox(height: spXs),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                    decoration: BoxDecoration(
                      color: _getPriorityColor(order["priority"] as String).withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                    child: Text(
                      "${order["priority"]}",
                      style: TextStyle(
                        fontSize: 10,
                        color: _getPriorityColor(order["priority"] as String),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),

          // Order Details
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
                    SizedBox(height: spXs),
                    Text(
                      "${DateTime.parse(order["date"] as String).dMMMy}",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
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
                      "Delivery Date",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "${DateTime.parse(order["deliveryDate"] as String).dMMMy}",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
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
                      "Total Amount",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "\$${(order["totalAmount"] as double).currency}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: successColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          // Items Summary
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
                  "Items (${(order["items"] as List).length})",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spXs),
                ...(order["items"] as List).take(2).map((item) {
                  return Padding(
                    padding: EdgeInsets.only(bottom: spXs),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            "${item["name"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                        ),
                        Text(
                          "${item["quantity"]} ${item["unit"]}",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
                if ((order["items"] as List).length > 2)
                  Text(
                    "... and ${(order["items"] as List).length - 2} more items",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
              ],
            ),
          ),

          // Requested By
          Row(
            children: [
              Icon(
                Icons.person,
                size: 16,
                color: disabledBoldColor,
              ),
              SizedBox(width: spXs),
              Text(
                "Requested by ${order["requestedBy"]}",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
              if (order["approvedBy"] != null) ...[
                SizedBox(width: spSm),
                Icon(
                  Icons.check_circle,
                  size: 16,
                  color: successColor,
                ),
                SizedBox(width: spXs),
                Text(
                  "Approved by ${order["approvedBy"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: successColor,
                  ),
                ),
              ],
            ],
          ),

          // Action Buttons
          Row(
            children: [
              Expanded(
                child: QButton(
                  label: "View Details",
                  size: bs.sm,
                  onPressed: () {
                    //navigateTo('order_details')
                  },
                ),
              ),
              SizedBox(width: spSm),
              if (order["status"] == "Pending")
                Expanded(
                  child: QButton(
                    label: "Approve",
                    size: bs.sm,
                    onPressed: () {
                      _approveOrder(order["id"] as String);
                    },
                  ),
                ),
              if (order["status"] == "Approved")
                Expanded(
                  child: QButton(
                    label: "Track Order",
                    size: bs.sm,
                    onPressed: () {
                      //navigateTo('track_order')
                    },
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }

  void _showFilterDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Filter Orders"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            spacing: spSm,
            children: [
              QDropdownField(
                label: "Status",
                items: statusOptions,
                value: selectedStatus,
                onChanged: (value, label) {
                  selectedStatus = value;
                  setState(() {});
                },
              ),
              QDropdownField(
                label: "Priority",
                items: priorityOptions,
                value: selectedPriority,
                onChanged: (value, label) {
                  selectedPriority = value;
                  setState(() {});
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                selectedStatus = "All";
                selectedPriority = "All";
                setState(() {});
                Navigator.pop(context);
              },
              child: Text("Clear"),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("Apply"),
            ),
          ],
        );
      },
    );
  }

  void _approveOrder(String orderId) async {
    bool isConfirmed = await confirm("Are you sure you want to approve this order?");
    if (isConfirmed) {
      // Update order status
      final orderIndex = orders.indexWhere((o) => o["id"] == orderId);
      if (orderIndex != -1) {
        orders[orderIndex]["status"] = "Approved";
        orders[orderIndex]["approvedBy"] = "Current User";
        setState(() {});
        ss("Order approved successfully");
      }
    }
  }
}
