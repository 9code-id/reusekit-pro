import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class PosPurchaseOrdersView extends StatefulWidget {
  const PosPurchaseOrdersView({super.key});

  @override
  State<PosPurchaseOrdersView> createState() => _PosPurchaseOrdersViewState();
}

class _PosPurchaseOrdersViewState extends State<PosPurchaseOrdersView> {
  String searchQuery = "";
  String selectedStatus = "All";
  String selectedSupplier = "All";
  String sortBy = "date";
  bool isAscending = false;

  List<Map<String, dynamic>> suppliers = [
    {"label": "All Suppliers", "value": "All"},
    {"label": "ABC Wholesale", "value": "ABC Wholesale"},
    {"label": "XYZ Supply Co", "value": "XYZ Supply Co"},
    {"label": "Best Foods Ltd", "value": "Best Foods Ltd"},
    {"label": "Quick Mart Supply", "value": "Quick Mart Supply"},
  ];

  List<Map<String, dynamic>> statusOptions = [
    {"label": "All Status", "value": "All"},
    {"label": "Draft", "value": "Draft"},
    {"label": "Pending", "value": "Pending"},
    {"label": "Approved", "value": "Approved"},
    {"label": "Received", "value": "Received"},
    {"label": "Cancelled", "value": "Cancelled"},
  ];

  List<Map<String, dynamic>> sortOptions = [
    {"label": "Date", "value": "date"},
    {"label": "Order Number", "value": "orderNumber"},
    {"label": "Supplier", "value": "supplier"},
    {"label": "Amount", "value": "amount"},
  ];

  List<Map<String, dynamic>> purchaseOrders = [
    {
      "id": "PO-2024-001",
      "orderNumber": "PO-2024-001",
      "supplier": "ABC Wholesale",
      "date": "2024-01-15",
      "expectedDate": "2024-01-20",
      "status": "Pending",
      "amount": 2500.00,
      "items": 15,
      "description": "Monthly inventory restocking",
      "priority": "Medium",
    },
    {
      "id": "PO-2024-002",
      "orderNumber": "PO-2024-002",
      "supplier": "XYZ Supply Co",
      "date": "2024-01-14",
      "expectedDate": "2024-01-18",
      "status": "Approved",
      "amount": 1800.50,
      "items": 8,
      "description": "Emergency supplies order",
      "priority": "High",
    },
    {
      "id": "PO-2024-003",
      "orderNumber": "PO-2024-003",
      "supplier": "Best Foods Ltd",
      "date": "2024-01-13",
      "expectedDate": "2024-01-17",
      "status": "Received",
      "amount": 3200.75,
      "items": 22,
      "description": "Weekly food supplies",
      "priority": "Low",
    },
    {
      "id": "PO-2024-004",
      "orderNumber": "PO-2024-004",
      "supplier": "Quick Mart Supply",
      "date": "2024-01-12",
      "expectedDate": "2024-01-16",
      "status": "Draft",
      "amount": 950.25,
      "items": 5,
      "description": "Office supplies order",
      "priority": "Low",
    },
    {
      "id": "PO-2024-005",
      "orderNumber": "PO-2024-005",
      "supplier": "ABC Wholesale",
      "date": "2024-01-11",
      "expectedDate": "2024-01-15",
      "status": "Cancelled",
      "amount": 1450.00,
      "items": 12,
      "description": "Cancelled due to supplier issues",
      "priority": "Medium",
    },
  ];

  List<Map<String, dynamic>> get filteredOrders {
    return purchaseOrders.where((order) {
      bool matchesSearch = order["orderNumber"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
          order["supplier"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
          order["description"].toString().toLowerCase().contains(searchQuery.toLowerCase());
      
      bool matchesStatus = selectedStatus == "All" || order["status"] == selectedStatus;
      bool matchesSupplier = selectedSupplier == "All" || order["supplier"] == selectedSupplier;

      return matchesSearch && matchesStatus && matchesSupplier;
    }).toList()
      ..sort((a, b) {
        dynamic aValue = a[sortBy];
        dynamic bValue = b[sortBy];
        
        if (sortBy == "amount") {
          aValue = a[sortBy] as double;
          bValue = b[sortBy] as double;
        }
        
        int comparison = aValue.toString().compareTo(bValue.toString());
        return isAscending ? comparison : -comparison;
      });
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "Draft":
        return disabledBoldColor;
      case "Pending":
        return warningColor;
      case "Approved":
        return infoColor;
      case "Received":
        return successColor;
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Purchase Orders"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              // Navigate to add purchase order
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            // Search and Filters
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                spacing: spSm,
                children: [
                  // Search
                  QTextField(
                    label: "Search Orders",
                    value: searchQuery,
                    hint: "Search by order number, supplier, or description",
                    onChanged: (value) {
                      searchQuery = value;
                      setState(() {});
                    },
                  ),
                  
                  // Filters Row
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
                          label: "Supplier",
                          items: suppliers,
                          value: selectedSupplier,
                          onChanged: (value, label) {
                            selectedSupplier = value;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),

                  // Sort Options
                  Row(
                    spacing: spSm,
                    children: [
                      Expanded(
                        child: QDropdownField(
                          label: "Sort By",
                          items: sortOptions,
                          value: sortBy,
                          onChanged: (value, label) {
                            sortBy = value;
                            setState(() {});
                          },
                        ),
                      ),
                      QButton(
                        icon: isAscending ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                        size: bs.sm,
                        onPressed: () {
                          isAscending = !isAscending;
                          setState(() {});
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Statistics Cards
            Row(
              spacing: spSm,
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusMd),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      children: [
                        Text(
                          "${purchaseOrders.length}",
                          style: TextStyle(
                            fontSize: fsH4,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "Total Orders",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusMd),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      children: [
                        Text(
                          "${purchaseOrders.where((o) => o["status"] == "Pending").length}",
                          style: TextStyle(
                            fontSize: fsH4,
                            fontWeight: FontWeight.bold,
                            color: warningColor,
                          ),
                        ),
                        Text(
                          "Pending",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusMd),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      children: [
                        Text(
                          "\$${((purchaseOrders.fold(0.0, (sum, order) => sum + (order["amount"] as double)))).currency}",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: successColor,
                          ),
                        ),
                        Text(
                          "Total Value",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            // Orders List
            ...filteredOrders.map((order) {
              return Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                  border: Border(
                    left: BorderSide(
                      width: 4,
                      color: _getStatusColor(order["status"]),
                    ),
                  ),
                ),
                child: Column(
                  spacing: spXs,
                  children: [
                    // Header Row
                    Row(
                      children: [
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
                          padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 4),
                          decoration: BoxDecoration(
                            color: _getStatusColor(order["status"]).withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusXs),
                            border: Border.all(
                              color: _getStatusColor(order["status"]),
                              width: 1,
                            ),
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

                    // Details
                    Text(
                      "${order["description"]}",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),

                    // Info Row
                    Row(
                      children: [
                        Expanded(
                          child: Row(
                            children: [
                              Icon(Icons.calendar_today, size: 16, color: disabledBoldColor),
                              SizedBox(width: spXs),
                              Text(
                                "${order["date"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: 8,
                          height: 8,
                          decoration: BoxDecoration(
                            color: _getPriorityColor(order["priority"]),
                            shape: BoxShape.circle,
                          ),
                        ),
                        SizedBox(width: spXs),
                        Text(
                          "${order["priority"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),

                    // Amount and Items
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            "\$${(order["amount"] as double).currency}",
                            style: TextStyle(
                              fontSize: fsH6,
                              fontWeight: FontWeight.bold,
                              color: successColor,
                            ),
                          ),
                        ),
                        Text(
                          "${order["items"]} items",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),

                    // Action Buttons
                    Row(
                      spacing: spSm,
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
                        if (order["status"] == "Draft") ...[
                          QButton(
                            icon: Icons.edit,
                            size: bs.sm,
                            onPressed: () {
                              // Edit order
                            },
                          ),
                          QButton(
                            icon: Icons.delete,
                            size: bs.sm,
                            onPressed: () async {
                              bool isConfirmed = await confirm("Are you sure you want to delete this purchase order?");
                              if (isConfirmed) {
                                purchaseOrders.removeWhere((o) => o["id"] == order["id"]);
                                setState(() {});
                                ss("Purchase order deleted successfully");
                              }
                            },
                          ),
                        ],
                      ],
                    ),
                  ],
                ),
              );
            }).toList(),

            if (filteredOrders.isEmpty)
              Container(
                padding: EdgeInsets.all(spLg),
                child: Column(
                  children: [
                    Icon(
                      Icons.receipt_long,
                      size: 64,
                      color: disabledColor,
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "No purchase orders found",
                      style: TextStyle(
                        fontSize: fsH6,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "Try adjusting your search criteria",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledColor,
                      ),
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
