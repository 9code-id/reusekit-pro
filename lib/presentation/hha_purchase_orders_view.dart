import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class HhaPurchaseOrdersView extends StatefulWidget {
  const HhaPurchaseOrdersView({super.key});

  @override
  State<HhaPurchaseOrdersView> createState() => _HhaPurchaseOrdersViewState();
}

class _HhaPurchaseOrdersViewState extends State<HhaPurchaseOrdersView> {
  String selectedStatus = "All";
  String selectedVendor = "All";
  String selectedDepartment = "All";
  String searchQuery = "";
  bool showFilters = false;
  String sortBy = "Date";

  List<Map<String, dynamic>> purchaseOrders = [
    {
      "id": "PO-2024-001",
      "vendor": "MedSupply Pro",
      "department": "Surgery",
      "requestedBy": "Dr. Sarah Johnson",
      "status": "Pending Approval",
      "priority": "High",
      "orderDate": "2024-01-15",
      "requiredDate": "2024-01-20",
      "expectedDelivery": "2024-01-22",
      "totalAmount": 15750.00,
      "approvedAmount": 0.00,
      "items": [
        {
          "name": "Surgical Scalpels",
          "category": "Surgical Instruments",
          "quantity": 100,
          "unitPrice": 25.50,
          "totalPrice": 2550.00,
          "description": "Disposable surgical scalpels #15"
        },
        {
          "name": "Heart Monitor",
          "category": "Medical Equipment",
          "quantity": 2,
          "unitPrice": 6600.00,
          "totalPrice": 13200.00,
          "description": "Advanced cardiac monitoring system"
        }
      ],
      "notes": "Urgent requirement for upcoming surgeries",
      "approver": "",
      "approvedDate": "",
      "budgetCode": "SURG-2024-Q1",
      "terms": "Net 30 days"
    },
    {
      "id": "PO-2024-002",
      "vendor": "CleanTech Solutions",
      "department": "Housekeeping",
      "requestedBy": "Mike Rodriguez",
      "status": "Approved",
      "priority": "Medium",
      "orderDate": "2024-01-12",
      "requiredDate": "2024-01-18",
      "expectedDelivery": "2024-01-19",
      "totalAmount": 3450.00,
      "approvedAmount": 3450.00,
      "items": [
        {
          "name": "Disinfectant Spray",
          "category": "Cleaning Supplies",
          "quantity": 50,
          "unitPrice": 35.00,
          "totalPrice": 1750.00,
          "description": "Hospital-grade surface disinfectant"
        },
        {
          "name": "Floor Cleaner",
          "category": "Cleaning Supplies",
          "quantity": 25,
          "unitPrice": 68.00,
          "totalPrice": 1700.00,
          "description": "Commercial floor cleaning solution"
        }
      ],
      "notes": "Regular monthly supply order",
      "approver": "Jane Smith",
      "approvedDate": "2024-01-13",
      "budgetCode": "HOUSE-2024-Q1",
      "terms": "Net 15 days"
    },
    {
      "id": "PO-2024-003",
      "vendor": "FoodService Express",
      "department": "Kitchen",
      "requestedBy": "Chef Maria Garcia",
      "status": "Received",
      "priority": "Low",
      "orderDate": "2024-01-10",
      "requiredDate": "2024-01-15",
      "expectedDelivery": "2024-01-14",
      "totalAmount": 2890.00,
      "approvedAmount": 2890.00,
      "items": [
        {
          "name": "Fresh Vegetables",
          "category": "Food Items",
          "quantity": 1,
          "unitPrice": 1200.00,
          "totalPrice": 1200.00,
          "description": "Weekly fresh vegetable supply"
        },
        {
          "name": "Protein Selection",
          "category": "Food Items",
          "quantity": 1,
          "unitPrice": 1690.00,
          "totalPrice": 1690.00,
          "description": "Chicken, fish, and beef selection"
        }
      ],
      "notes": "Weekly food supply delivered on time",
      "approver": "Tom Wilson",
      "approvedDate": "2024-01-11",
      "budgetCode": "FOOD-2024-Q1",
      "terms": "Net 7 days"
    },
    {
      "id": "PO-2024-004",
      "vendor": "Pharma Direct",
      "department": "Pharmacy",
      "requestedBy": "Dr. Emily Chen",
      "status": "Partially Received",
      "priority": "High",
      "orderDate": "2024-01-14",
      "requiredDate": "2024-01-17",
      "expectedDelivery": "2024-01-18",
      "totalAmount": 28500.00,
      "approvedAmount": 28500.00,
      "items": [
        {
          "name": "Antibiotics Package",
          "category": "Pharmaceuticals",
          "quantity": 1,
          "unitPrice": 15000.00,
          "totalPrice": 15000.00,
          "description": "Various antibiotic medications"
        },
        {
          "name": "Pain Management",
          "category": "Pharmaceuticals",
          "quantity": 1,
          "unitPrice": 13500.00,
          "totalPrice": 13500.00,
          "description": "Pain relief medications"
        }
      ],
      "notes": "Critical medications - partial delivery received",
      "approver": "Dr. Robert Brown",
      "approvedDate": "2024-01-14",
      "budgetCode": "PHARM-2024-Q1",
      "terms": "Net 30 days"
    },
    {
      "id": "PO-2024-005",
      "vendor": "TechCare Systems",
      "department": "IT",
      "requestedBy": "John Davis",
      "status": "Cancelled",
      "priority": "Medium",
      "orderDate": "2024-01-08",
      "requiredDate": "2024-01-25",
      "expectedDelivery": "2024-01-30",
      "totalAmount": 12800.00,
      "approvedAmount": 0.00,
      "items": [
        {
          "name": "Desktop Computers",
          "category": "IT Equipment",
          "quantity": 4,
          "unitPrice": 1800.00,
          "totalPrice": 7200.00,
          "description": "Office desktop computers"
        },
        {
          "name": "Network Switch",
          "category": "IT Equipment",
          "quantity": 1,
          "unitPrice": 5600.00,
          "totalPrice": 5600.00,
          "description": "24-port network switch"
        }
      ],
      "notes": "Cancelled due to budget constraints",
      "approver": "",
      "approvedDate": "",
      "budgetCode": "IT-2024-Q1",
      "terms": "Net 45 days"
    },
    {
      "id": "PO-2024-006",
      "vendor": "Linen & More",
      "department": "Laundry",
      "requestedBy": "Linda Thompson",
      "status": "In Transit",
      "priority": "Medium",
      "orderDate": "2024-01-11",
      "requiredDate": "2024-01-20",
      "expectedDelivery": "2024-01-21",
      "totalAmount": 4200.00,
      "approvedAmount": 4200.00,
      "items": [
        {
          "name": "Bed Sheets",
          "category": "Textiles",
          "quantity": 200,
          "unitPrice": 18.00,
          "totalPrice": 3600.00,
          "description": "Hospital bed sheets - white"
        },
        {
          "name": "Towels",
          "category": "Textiles",
          "quantity": 100,
          "unitPrice": 6.00,
          "totalPrice": 600.00,
          "description": "Bath towels for patient rooms"
        }
      ],
      "notes": "Replacement for worn linens",
      "approver": "Susan Clark",
      "approvedDate": "2024-01-12",
      "budgetCode": "LINEN-2024-Q1",
      "terms": "Net 30 days"
    }
  ];

  List<Map<String, dynamic>> get filteredOrders {
    return purchaseOrders.where((order) {
      if (selectedStatus != "All" && (order["status"] as String) != selectedStatus) return false;
      if (selectedVendor != "All" && (order["vendor"] as String) != selectedVendor) return false;
      if (selectedDepartment != "All" && (order["department"] as String) != selectedDepartment) return false;
      if (searchQuery.isNotEmpty) {
        String query = searchQuery.toLowerCase();
        String id = (order["id"] as String).toLowerCase();
        String vendor = (order["vendor"] as String).toLowerCase();
        String department = (order["department"] as String).toLowerCase();
        if (!id.contains(query) && !vendor.contains(query) && !department.contains(query)) return false;
      }
      return true;
    }).toList();
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "Approved":
        return successColor;
      case "Pending Approval":
        return warningColor;
      case "Received":
        return infoColor;
      case "Partially Received":
        return primaryColor;
      case "In Transit":
        return secondaryColor;
      case "Cancelled":
        return dangerColor;
      default:
        return disabledColor;
    }
  }

  Color _getPriorityColor(String priority) {
    switch (priority) {
      case "High":
        return dangerColor;
      case "Medium":
        return warningColor;
      case "Low":
        return successColor;
      default:
        return disabledColor;
    }
  }

  Widget _buildOrderCard(Map<String, dynamic> order) {
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusSm),
        boxShadow: [shadowSm],
        border: Border(
          left: BorderSide(
            width: 4,
            color: _getPriorityColor(order["priority"] as String),
          ),
        ),
      ),
      child: Column(
        children: [
          // Header
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.grey[50],
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(radiusSm),
                topRight: Radius.circular(radiusSm),
              ),
            ),
            child: Column(
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
                          SizedBox(height: spXs),
                          Text(
                            "${order["vendor"]} • ${order["department"]}",
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
                        color: _getStatusColor(order["status"] as String).withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Text(
                        "${order["status"]}",
                        style: TextStyle(
                          color: _getStatusColor(order["status"] as String),
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spSm),
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                      decoration: BoxDecoration(
                        color: _getPriorityColor(order["priority"] as String).withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Text(
                        "${order["priority"]} Priority",
                        style: TextStyle(
                          color: _getPriorityColor(order["priority"] as String),
                          fontWeight: FontWeight.w600,
                          fontSize: 11,
                        ),
                      ),
                    ),
                    Spacer(),
                    Text(
                      "Ordered: ${order["orderDate"]}",
                      style: TextStyle(
                        fontSize: 11,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Content
          Padding(
            padding: EdgeInsets.all(spSm),
            child: Column(
              children: [
                // Amount and dates
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
                            "\$${((order["totalAmount"] as double)).currency}",
                            style: TextStyle(
                              fontSize: fsH6,
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
                            "Required Date",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          Text(
                            "${order["requiredDate"]}",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: primaryColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                SizedBox(height: spSm),

                // Items summary
                Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.grey[50],
                    borderRadius: BorderRadius.circular(radiusXs),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Items (${(order["items"] as List).length})",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: primaryColor,
                        ),
                      ),
                      SizedBox(height: spXs),
                      ...(order["items"] as List<Map<String, dynamic>>).take(2).map((item) {
                        return Padding(
                          padding: EdgeInsets.only(bottom: spXs),
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  "${item["name"]} x${item["quantity"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ),
                              Text(
                                "\$${((item["totalPrice"] as double)).currency}",
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
                            fontSize: 11,
                            color: disabledColor,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                    ],
                  ),
                ),

                if ((order["notes"] as String).isNotEmpty) ...[
                  SizedBox(height: spSm),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: infoColor.withAlpha(10),
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Notes:",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: infoColor,
                            fontSize: 12,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "${order["notes"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],

                SizedBox(height: spSm),

                // Approval info
                if ((order["approver"] as String).isNotEmpty)
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: successColor.withAlpha(10),
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.check_circle, color: successColor, size: 16),
                        SizedBox(width: spXs),
                        Expanded(
                          child: Text(
                            "Approved by ${order["approver"]} on ${order["approvedDate"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: successColor,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                SizedBox(height: spSm),

                // Action buttons
                Row(
                  children: [
                    Expanded(
                      child: QButton(
                        label: "View Details",
                        size: bs.sm,
                        onPressed: () {
                          // Navigate to order details
                        },
                      ),
                    ),
                    SizedBox(width: spSm),
                    if ((order["status"] as String) == "Pending Approval")
                      QButton(
                        icon: Icons.check,
                        size: bs.sm,
                        onPressed: () {
                          ss("Order approved");
                        },
                      ),
                    if ((order["status"] as String) == "Approved")
                      QButton(
                        icon: Icons.local_shipping,
                        size: bs.sm,
                        onPressed: () {
                          ss("Tracking shipment");
                        },
                      ),
                    SizedBox(width: spXs),
                    QButton(
                      icon: Icons.more_vert,
                      size: bs.sm,
                      onPressed: () {
                        // Show more options
                      },
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

  Widget _buildStatsCard() {
    int totalOrders = purchaseOrders.length;
    int pendingOrders = purchaseOrders.where((o) => o["status"] == "Pending Approval").length;
    double totalValue = purchaseOrders.fold(0.0, (sum, o) => sum + (o["totalAmount"] as double));
    double approvedValue = purchaseOrders.fold(0.0, (sum, o) => sum + (o["approvedAmount"] as double));

    return Container(
      margin: EdgeInsets.only(bottom: spMd),
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
            "Purchase Orders Overview",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 150,
            children: [
              _buildStatItem("Total Orders", "$totalOrders", Icons.shopping_cart, primaryColor),
              _buildStatItem("Pending", "$pendingOrders", Icons.pending_actions, warningColor),
              _buildStatItem("Total Value", "\$${(totalValue / 1000).toStringAsFixed(0)}K", Icons.attach_money, infoColor),
              _buildStatItem("Approved", "\$${(approvedValue / 1000).toStringAsFixed(0)}K", Icons.check_circle, successColor),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(String title, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: color.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusXs),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 24),
          SizedBox(height: spXs),
          Text(
            value,
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          Text(
            title,
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildFilters() {
    if (!showFilters) return SizedBox.shrink();

    List<String> vendors = ["All"] + purchaseOrders.map((o) => o["vendor"] as String).toSet().toList();
    List<String> departments = ["All"] + purchaseOrders.map((o) => o["department"] as String).toSet().toList();

    return Container(
      margin: EdgeInsets.only(bottom: spMd),
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
            "Filters",
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
                child: QDropdownField(
                  label: "Vendor",
                  items: vendors.map((v) => {"label": v, "value": v}).toList(),
                  value: selectedVendor,
                  onChanged: (value, label) {
                    selectedVendor = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QDropdownField(
                  label: "Department",
                  items: departments.map((d) => {"label": d, "value": d}).toList(),
                  value: selectedDepartment,
                  onChanged: (value, label) {
                    selectedDepartment = value;
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Purchase Orders"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              // Navigate to create purchase order
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          children: [
            // Search bar
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
                  icon: showFilters ? Icons.filter_list_off : Icons.filter_list,
                  size: bs.sm,
                  onPressed: () {
                    showFilters = !showFilters;
                    setState(() {});
                  },
                ),
              ],
            ),

            SizedBox(height: spMd),

            // Filters
            _buildFilters(),

            // Stats overview
            _buildStatsCard(),

            // Status filter chips
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  "All",
                  "Pending Approval",
                  "Approved",
                  "In Transit",
                  "Received",
                  "Partially Received",
                  "Cancelled"
                ].map((status) {
                  bool isSelected = selectedStatus == status;
                  return Container(
                    margin: EdgeInsets.only(right: spSm),
                    child: GestureDetector(
                      onTap: () {
                        selectedStatus = status;
                        setState(() {});
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                        decoration: BoxDecoration(
                          color: isSelected ? primaryColor : Colors.grey[100],
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Text(
                          status,
                          style: TextStyle(
                            color: isSelected ? Colors.white : disabledBoldColor,
                            fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),

            SizedBox(height: spMd),

            // Results count and sort
            Row(
              children: [
                Text(
                  "${filteredOrders.length} orders found",
                  style: TextStyle(
                    color: disabledBoldColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Spacer(),
                QButton(
                  icon: Icons.sort,
                  size: bs.sm,
                  onPressed: () {
                    // Show sort options
                  },
                ),
              ],
            ),

            SizedBox(height: spSm),

            // Orders list
            ...filteredOrders.map((order) => _buildOrderCard(order)).toList(),

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
                    SizedBox(height: spSm),
                    Text(
                      "No purchase orders found",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "Try adjusting your search criteria",
                      style: TextStyle(
                        color: disabledColor,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
