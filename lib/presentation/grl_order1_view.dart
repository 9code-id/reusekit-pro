import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlOrder1View extends StatefulWidget {
  @override
  State<GrlOrder1View> createState() => _GrlOrder1ViewState();
}

class _GrlOrder1ViewState extends State<GrlOrder1View> {
  String searchQuery = "";
  String selectedStatus = "All";
  String selectedPriority = "All";
  bool showFilters = false;

  List<Map<String, dynamic>> statusOptions = [
    {"label": "All", "value": "All"},
    {"label": "Pending", "value": "Pending"},
    {"label": "Processing", "value": "Processing"},
    {"label": "Shipped", "value": "Shipped"},
    {"label": "Delivered", "value": "Delivered"},
    {"label": "Cancelled", "value": "Cancelled"},
  ];

  List<Map<String, dynamic>> priorityOptions = [
    {"label": "All", "value": "All"},
    {"label": "High", "value": "High"},
    {"label": "Medium", "value": "Medium"},
    {"label": "Low", "value": "Low"},
  ];

  List<Map<String, dynamic>> orders = [
    {
      "id": "ORD-2024-001",
      "customer": "John Smith",
      "email": "john.smith@email.com",
      "phone": "+1-555-0123",
      "status": "Processing",
      "priority": "High",
      "total": 299.99,
      "items": 3,
      "date": "2024-06-20",
      "shipping_address": "123 Main St, New York, NY 10001",
      "payment_method": "Credit Card",
      "notes": "Customer requested expedited shipping"
    },
    {
      "id": "ORD-2024-002", 
      "customer": "Sarah Johnson",
      "email": "sarah.j@email.com",
      "phone": "+1-555-0124",
      "status": "Shipped",
      "priority": "Medium",
      "total": 149.50,
      "items": 2,
      "date": "2024-06-19",
      "shipping_address": "456 Oak Ave, Los Angeles, CA 90210",
      "payment_method": "PayPal",
      "notes": ""
    },
    {
      "id": "ORD-2024-003",
      "customer": "Mike Davis",
      "email": "mike.davis@email.com", 
      "phone": "+1-555-0125",
      "status": "Pending",
      "priority": "Low",
      "total": 89.99,
      "items": 1,
      "date": "2024-06-21",
      "shipping_address": "789 Pine St, Chicago, IL 60601",
      "payment_method": "Bank Transfer",
      "notes": "Payment confirmation pending"
    },
    {
      "id": "ORD-2024-004",
      "customer": "Emily Wilson",
      "email": "emily.wilson@email.com",
      "phone": "+1-555-0126",
      "status": "Delivered",
      "priority": "Medium",
      "total": 459.00,
      "items": 5,
      "date": "2024-06-18",
      "shipping_address": "321 Elm St, Miami, FL 33101",
      "payment_method": "Credit Card",
      "notes": "Customer very satisfied with service"
    },
    {
      "id": "ORD-2024-005",
      "customer": "Robert Brown",
      "email": "robert.brown@email.com",
      "phone": "+1-555-0127", 
      "status": "Cancelled",
      "priority": "High",
      "total": 199.99,
      "items": 2,
      "date": "2024-06-17",
      "shipping_address": "654 Maple Dr, Seattle, WA 98101",
      "payment_method": "Credit Card",
      "notes": "Customer cancelled due to change of mind"
    },
  ];

  List<Map<String, dynamic>> get filteredOrders {
    return orders.where((order) {
      bool matchesSearch = searchQuery.isEmpty ||
          "${order["customer"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
          "${order["id"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
          "${order["email"]}".toLowerCase().contains(searchQuery.toLowerCase());
      
      bool matchesStatus = selectedStatus == "All" || order["status"] == selectedStatus;
      bool matchesPriority = selectedPriority == "All" || order["priority"] == selectedPriority;
      
      return matchesSearch && matchesStatus && matchesPriority;
    }).toList();
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "Pending":
        return warningColor;
      case "Processing":
        return infoColor;
      case "Shipped":
        return primaryColor;
      case "Delivered":
        return successColor;
      case "Cancelled":
        return dangerColor;
      default:
        return disabledBoldColor;
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
        return disabledBoldColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Order Management"),
        actions: [
          IconButton(
            icon: Icon(Icons.filter_list),
            onPressed: () {
              showFilters = !showFilters;
              setState(() {});
            },
          ),
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              //navigateTo('NewOrderView')
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: spMd,
          children: [
            // Search Bar
            Row(
              children: [
                Expanded(
                  child: QTextField(
                    label: "Search orders...",
                    value: searchQuery,
                    hint: "Search by order ID, customer name, or email",
                    onChanged: (value) {
                      searchQuery = value;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spSm),
                QButton(
                  icon: Icons.search,
                  size: bs.md,
                  onPressed: () {
                    // Perform search
                  },
                ),
              ],
            ),

            // Filters Section
            if (showFilters) ...[
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.grey.withAlpha(50),
                  borderRadius: BorderRadius.circular(radiusSm),
                  border: Border.all(color: disabledOutlineBorderColor),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spSm,
                  children: [
                    Text(
                      "Filters",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        QButton(
                          label: "Clear Filters",
                          size: bs.sm,
                          onPressed: () {
                            selectedStatus = "All";
                            selectedPriority = "All";
                            searchQuery = "";
                            setState(() {});
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],

            // Statistics Row
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: primaryColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusSm),
                      border: Border.all(color: primaryColor.withAlpha(50)),
                    ),
                    child: Column(
                      children: [
                        Text(
                          "${filteredOrders.length}",
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
                SizedBox(width: spSm),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: successColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusSm),
                      border: Border.all(color: successColor.withAlpha(50)),
                    ),
                    child: Column(
                      children: [
                        Text(
                          "\$${filteredOrders.fold(0.0, (sum, order) => sum + (order["total"] as num).toDouble()).toStringAsFixed(0)}",
                          style: TextStyle(
                            fontSize: fsH4,
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
            Text(
              "Orders (${filteredOrders.length})",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),

            if (filteredOrders.isEmpty)
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(spLg),
                decoration: BoxDecoration(
                  color: Colors.grey.withAlpha(50),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Column(
                  children: [
                    Icon(
                      Icons.shopping_bag_outlined,
                      size: 64,
                      color: disabledBoldColor,
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "No orders found",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "Try adjusting your search or filter criteria",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              )
            else
              ...filteredOrders.map((order) {
                return Container(
                  margin: EdgeInsets.only(bottom: spSm),
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusSm),
                    boxShadow: [shadowSm],
                    border: Border.all(color: disabledOutlineBorderColor),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: spSm,
                    children: [
                      // Order Header
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
                                  "${order["customer"]}",
                                  style: TextStyle(
                                    fontSize: 14,
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
                                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 4),
                                decoration: BoxDecoration(
                                  color: _getStatusColor("${order["status"]}").withAlpha(20),
                                  borderRadius: BorderRadius.circular(radiusXs),
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
                              SizedBox(height: 4),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                decoration: BoxDecoration(
                                  color: _getPriorityColor("${order["priority"]}").withAlpha(20),
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: Text(
                                  "${order["priority"]} Priority",
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w600,
                                    color: _getPriorityColor("${order["priority"]}"),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),

                      // Order Details
                      Container(
                        padding: EdgeInsets.all(spXs),
                        decoration: BoxDecoration(
                          color: Colors.grey.withAlpha(30),
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Column(
                          spacing: spXs,
                          children: [
                            Row(
                              children: [
                                Icon(Icons.email, size: 16, color: disabledBoldColor),
                                SizedBox(width: spXs),
                                Expanded(
                                  child: Text(
                                    "${order["email"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Icon(Icons.phone, size: 16, color: disabledBoldColor),
                                SizedBox(width: spXs),
                                Expanded(
                                  child: Text(
                                    "${order["phone"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Icon(Icons.location_on, size: 16, color: disabledBoldColor),
                                SizedBox(width: spXs),
                                Expanded(
                                  child: Text(
                                    "${order["shipping_address"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),

                      // Order Summary
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
                          Row(
                            children: [
                              Icon(Icons.shopping_cart, size: 16, color: disabledBoldColor),
                              SizedBox(width: spXs),
                              Text(
                                "${order["items"]} items",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),

                      Row(
                        children: [
                          Expanded(
                            child: Row(
                              children: [
                                Icon(Icons.payment, size: 16, color: disabledBoldColor),
                                SizedBox(width: spXs),
                                Text(
                                  "${order["payment_method"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Text(
                            "\$${((order["total"] as num).toDouble()).toStringAsFixed(2)}",
                            style: TextStyle(
                              fontSize: fsH6,
                              fontWeight: FontWeight.bold,
                              color: successColor,
                            ),
                          ),
                        ],
                      ),

                      // Notes
                      if ("${order["notes"]}".isNotEmpty) ...[
                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.all(spXs),
                          decoration: BoxDecoration(
                            color: infoColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusXs),
                            border: Border.all(color: infoColor.withAlpha(50)),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Icon(Icons.note, size: 16, color: infoColor),
                              SizedBox(width: spXs),
                              Expanded(
                                child: Text(
                                  "${order["notes"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: infoColor,
                                    fontStyle: FontStyle.italic,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],

                      // Action Buttons
                      Row(
                        children: [
                          Expanded(
                            child: QButton(
                              label: "View Details",
                              size: bs.sm,
                              onPressed: () {
                                //navigateTo('OrderDetailsView', arguments: order)
                              },
                            ),
                          ),
                          SizedBox(width: spSm),
                          QButton(
                            icon: Icons.edit,
                            size: bs.sm,
                            onPressed: () {
                              //navigateTo('EditOrderView', arguments: order)
                            },
                          ),
                          SizedBox(width: spXs),
                          QButton(
                            icon: Icons.more_vert,
                            size: bs.sm,
                            onPressed: () {
                              _showOrderActions(order);
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
      ),
    );
  }

  void _showOrderActions(Map<String, dynamic> order) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(radiusLg)),
      ),
      builder: (context) {
        return Container(
          padding: EdgeInsets.all(spMd),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            spacing: spSm,
            children: [
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: disabledOutlineBorderColor,
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
              ),
              Text(
                "Order Actions",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              SizedBox(height: spSm),
              Container(
                width: double.infinity,
                child: QButton(
                  label: "Print Order",
                  size: bs.md,
                  onPressed: () {
                    back();
                    ss("Order will be printed");
                  },
                ),
              ),
              Container(
                width: double.infinity,
                child: QButton(
                  label: "Send Email",
                  size: bs.md,
                  onPressed: () {
                    back();
                    ss("Email sent to customer");
                  },
                ),
              ),
              Container(
                width: double.infinity,
                child: QButton(
                  label: "Update Status",
                  size: bs.md,
                  onPressed: () {
                    back();
                    //navigateTo('UpdateOrderStatusView', arguments: order)
                  },
                ),
              ),
              if ("${order["status"]}" != "Cancelled") ...[
                Container(
                  width: double.infinity,
                  child: QButton(
                    label: "Cancel Order",
                    size: bs.md,
                    onPressed: () async {
                      back();
                      bool isConfirmed = await confirm("Are you sure you want to cancel this order?");
                      if (isConfirmed) {
                        sw("Order cancelled successfully");
                      }
                    },
                  ),
                ),
              ],
            ],
          ),
        );
      },
    );
  }
}
