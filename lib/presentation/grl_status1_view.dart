import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlStatus1View extends StatefulWidget {
  @override
  State<GrlStatus1View> createState() => _GrlStatus1ViewState();
}

class _GrlStatus1ViewState extends State<GrlStatus1View> {
  String selectedFilter = "all";
  String searchQuery = "";

  List<Map<String, dynamic>> filterOptions = [
    {"label": "All Orders", "value": "all"},
    {"label": "Pending", "value": "pending"},
    {"label": "Processing", "value": "processing"},
    {"label": "Shipped", "value": "shipped"},
    {"label": "Delivered", "value": "delivered"},
    {"label": "Cancelled", "value": "cancelled"},
  ];

  List<Map<String, dynamic>> orders = [
    {
      "id": "ORD-2024-001",
      "customer": "John Smith",
      "email": "john.smith@email.com",
      "phone": "+1 234 567 8900",
      "status": "delivered",
      "amount": 89.99,
      "items": 3,
      "orderDate": "2024-01-15T10:30:00Z",
      "deliveryDate": "2024-01-18T14:20:00Z",
      "address": "123 Main St, New York, NY 10001",
      "paymentMethod": "Credit Card",
      "trackingNumber": "TRK123456789"
    },
    {
      "id": "ORD-2024-002",
      "customer": "Sarah Johnson",
      "email": "sarah.j@email.com",
      "phone": "+1 234 567 8901",
      "status": "shipped",
      "amount": 156.50,
      "items": 2,
      "orderDate": "2024-01-20T15:45:00Z",
      "deliveryDate": null,
      "address": "456 Oak Ave, Los Angeles, CA 90210",
      "paymentMethod": "PayPal",
      "trackingNumber": "TRK987654321"
    },
    {
      "id": "ORD-2024-003",
      "customer": "Mike Wilson",
      "email": "mike.wilson@email.com",
      "phone": "+1 234 567 8902",
      "status": "processing",
      "amount": 234.75,
      "items": 5,
      "orderDate": "2024-01-22T09:15:00Z",
      "deliveryDate": null,
      "address": "789 Pine St, Chicago, IL 60601",
      "paymentMethod": "Credit Card",
      "trackingNumber": null
    },
    {
      "id": "ORD-2024-004",
      "customer": "Emma Davis",
      "email": "emma.davis@email.com",
      "phone": "+1 234 567 8903",
      "status": "pending",
      "amount": 67.25,
      "items": 1,
      "orderDate": "2024-01-23T11:20:00Z",
      "deliveryDate": null,
      "address": "321 Elm Dr, Miami, FL 33101",
      "paymentMethod": "Bank Transfer",
      "trackingNumber": null
    },
    {
      "id": "ORD-2024-005",
      "customer": "David Brown",
      "email": "david.brown@email.com",
      "phone": "+1 234 567 8904",
      "status": "cancelled",
      "amount": 145.00,
      "items": 2,
      "orderDate": "2024-01-19T16:30:00Z",
      "deliveryDate": null,
      "address": "654 Maple Ln, Seattle, WA 98101",
      "paymentMethod": "Credit Card",
      "trackingNumber": null
    },
  ];

  List<Map<String, dynamic>> get filteredOrders {
    return orders.where((order) {
      final statusMatch = selectedFilter == "all" || order["status"] == selectedFilter;
      final searchMatch = searchQuery.isEmpty || 
          order["id"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
          order["customer"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
          order["email"].toString().toLowerCase().contains(searchQuery.toLowerCase());
      return statusMatch && searchMatch;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Order Status"),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.filter_list),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            // Search and Filter
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
                  icon: Icons.search,
                  size: bs.sm,
                  onPressed: () {},
                ),
              ],
            ),

            // Status Filter
            QCategoryPicker(
              items: filterOptions,
              value: selectedFilter,
              onChanged: (index, label, value, item) {
                selectedFilter = value;
                setState(() {});
              },
            ),

            // Order Statistics
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Column(
                spacing: spMd,
                children: [
                  Text(
                    "Order Overview",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  
                  Row(
                    children: [
                      Expanded(
                        child: _buildStatCard(
                          "Total Orders",
                          "${orders.length}",
                          Icons.shopping_cart,
                          primaryColor,
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: _buildStatCard(
                          "Pending",
                          "${_getOrderCountByStatus('pending')}",
                          Icons.schedule,
                          warningColor,
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: _buildStatCard(
                          "Delivered",
                          "${_getOrderCountByStatus('delivered')}",
                          Icons.check_circle,
                          successColor,
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: _buildStatCard(
                          "Cancelled",
                          "${_getOrderCountByStatus('cancelled')}",
                          Icons.cancel,
                          dangerColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Order List
            Column(
              spacing: spSm,
              children: List.generate(
                filteredOrders.length,
                (index) => _buildOrderCard(filteredOrders[index]),
              ),
            ),

            if (filteredOrders.isEmpty)
              Container(
                padding: EdgeInsets.all(sp2xl),
                child: Column(
                  spacing: spSm,
                  children: [
                    Icon(
                      Icons.inbox,
                      size: 64,
                      color: disabledBoldColor,
                    ),
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
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: color.withAlpha(20),
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Column(
        spacing: spXs,
        children: [
          Icon(
            icon,
            color: color,
            size: 20,
          ),
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
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOrderCard(Map<String, dynamic> order) {
    final statusColor = _getStatusColor(order["status"]);
    final orderDate = DateTime.parse(order["orderDate"]);
    
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
        border: Border.all(color: statusColor.withAlpha(60)),
      ),
      child: Column(
        spacing: spMd,
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
                      ),
                    ),
                    Text(
                      "${order["customer"]}",
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
                  color: statusColor,
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Text(
                  "${order["status"]}".toUpperCase(),
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),

          // Order Details
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.grey[50],
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Column(
              spacing: spSm,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.email,
                      size: 16,
                      color: disabledBoldColor,
                    ),
                    SizedBox(width: spXs),
                    Expanded(
                      child: Text(
                        "${order["email"]}",
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
                      Icons.phone,
                      size: 16,
                      color: disabledBoldColor,
                    ),
                    SizedBox(width: spXs),
                    Expanded(
                      child: Text(
                        "${order["phone"]}",
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
                      Icons.location_on,
                      size: 16,
                      color: disabledBoldColor,
                    ),
                    SizedBox(width: spXs),
                    Expanded(
                      child: Text(
                        "${order["address"]}",
                        style: TextStyle(
                          fontSize: 13,
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
                child: _buildOrderStat(
                  "Amount",
                  "\$${(order["amount"] as double).toStringAsFixed(2)}",
                  Icons.attach_money,
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: _buildOrderStat(
                  "Items",
                  "${order["items"]}",
                  Icons.shopping_bag,
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: _buildOrderStat(
                  "Payment",
                  "${order["paymentMethod"]}",
                  Icons.payment,
                ),
              ),
            ],
          ),

          // Timeline
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: statusColor.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spXs,
              children: [
                Text(
                  "Order Timeline",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
                
                Row(
                  children: [
                    Icon(
                      Icons.schedule,
                      size: 14,
                      color: disabledBoldColor,
                    ),
                    SizedBox(width: spXs),
                    Text(
                      "Ordered: ${orderDate.day}/${orderDate.month}/${orderDate.year} at ${orderDate.hour}:${orderDate.minute.toString().padLeft(2, '0')}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
                
                if (order["trackingNumber"] != null)
                  Row(
                    children: [
                      Icon(
                        Icons.local_shipping,
                        size: 14,
                        color: disabledBoldColor,
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "Tracking: ${order["trackingNumber"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                
                if (order["deliveryDate"] != null)
                  Row(
                    children: [
                      Icon(
                        Icons.check_circle,
                        size: 14,
                        color: successColor,
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "Delivered: ${DateTime.parse(order["deliveryDate"]).day}/${DateTime.parse(order["deliveryDate"]).month}/${DateTime.parse(order["deliveryDate"]).year}",
                        style: TextStyle(
                          fontSize: 12,
                          color: successColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
              ],
            ),
          ),

          // Action Buttons
          Row(
            spacing: spSm,
            children: [
              Expanded(
                child: QButton(
                  label: "View Details",
                  size: bs.sm,
                  onPressed: () {},
                ),
              ),
              if (order["status"] == "pending" || order["status"] == "processing")
                Expanded(
                  child: QButton(
                    label: "Update Status",
                    size: bs.sm,
                    onPressed: () {},
                  ),
                ),
              if (order["trackingNumber"] != null)
                Expanded(
                  child: QButton(
                    label: "Track Order",
                    size: bs.sm,
                    onPressed: () {},
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildOrderStat(String title, String value, IconData icon) {
    return Container(
      padding: EdgeInsets.all(spXs),
      child: Column(
        spacing: spXs,
        children: [
          Icon(
            icon,
            size: 16,
            color: primaryColor,
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Text(
            title,
            style: TextStyle(
              fontSize: 10,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "pending":
        return warningColor;
      case "processing":
        return infoColor;
      case "shipped":
        return primaryColor;
      case "delivered":
        return successColor;
      case "cancelled":
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  int _getOrderCountByStatus(String status) {
    return orders.where((order) => order["status"] == status).length;
  }
}
