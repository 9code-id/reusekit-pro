import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlShop9View extends StatefulWidget {
  @override
  State<GrlShop9View> createState() => _GrlShop9ViewState();
}

class _GrlShop9ViewState extends State<GrlShop9View> {
  String selectedOrderStatus = "all";
  
  List<Map<String, dynamic>> orders = [
    {
      "id": "ORD-2024-001",
      "date": "2024-06-20",
      "status": "delivered",
      "total": 1249.98,
      "items": 3,
      "trackingNumber": "TRK123456789",
      "estimatedDelivery": "2024-06-22",
      "products": [
        {
          "name": "Wireless Headphones Pro",
          "price": 299.99,
          "quantity": 2,
          "image": "https://picsum.photos/100/100?random=1&keyword=headphones",
        },
        {
          "name": "Smart Watch Elite",
          "price": 649.99,
          "quantity": 1,
          "image": "https://picsum.photos/100/100?random=2&keyword=smartwatch",
        },
      ],
      "shippingAddress": "123 Main St, New York, NY 10001",
      "paymentMethod": "Credit Card ending in 4567",
    },
    {
      "id": "ORD-2024-002",
      "date": "2024-06-18",
      "status": "shipped",
      "total": 599.99,
      "items": 2,
      "trackingNumber": "TRK987654321",
      "estimatedDelivery": "2024-06-24",
      "products": [
        {
          "name": "Gaming Keyboard RGB",
          "price": 149.99,
          "quantity": 1,
          "image": "https://picsum.photos/100/100?random=3&keyword=keyboard",
        },
        {
          "name": "Wireless Mouse Pro",
          "price": 89.99,
          "quantity": 1,
          "image": "https://picsum.photos/100/100?random=4&keyword=mouse",
        },
      ],
      "shippingAddress": "456 Oak Ave, Brooklyn, NY 11201",
      "paymentMethod": "PayPal",
    },
    {
      "id": "ORD-2024-003",
      "date": "2024-06-15",
      "status": "processing",
      "total": 899.97,
      "items": 3,
      "trackingNumber": "",
      "estimatedDelivery": "2024-06-26",
      "products": [
        {
          "name": "Running Shoes Premium",
          "price": 179.99,
          "quantity": 2,
          "image": "https://picsum.photos/100/100?random=5&keyword=shoes",
        },
        {
          "name": "Fitness Tracker",
          "price": 249.99,
          "quantity": 1,
          "image": "https://picsum.photos/100/100?random=6&keyword=fitness",
        },
      ],
      "shippingAddress": "789 Pine St, Queens, NY 11375",
      "paymentMethod": "Apple Pay",
    },
    {
      "id": "ORD-2024-004",
      "date": "2024-06-10",
      "status": "cancelled",
      "total": 299.99,
      "items": 1,
      "trackingNumber": "",
      "estimatedDelivery": "",
      "products": [
        {
          "name": "Bluetooth Speaker",
          "price": 299.99,
          "quantity": 1,
          "image": "https://picsum.photos/100/100?random=7&keyword=speaker",
        },
      ],
      "shippingAddress": "321 Elm St, Manhattan, NY 10002",
      "paymentMethod": "Credit Card ending in 1234",
      "cancelReason": "Out of stock",
    },
    {
      "id": "ORD-2024-005",
      "date": "2024-06-08",
      "status": "pending",
      "total": 1599.98,
      "items": 2,
      "trackingNumber": "",
      "estimatedDelivery": "2024-06-28",
      "products": [
        {
          "name": "Laptop Stand Adjustable",
          "price": 79.99,
          "quantity": 1,
          "image": "https://picsum.photos/100/100?random=8&keyword=laptop",
        },
        {
          "name": "4K Monitor Ultra Wide",
          "price": 1519.99,
          "quantity": 1,
          "image": "https://picsum.photos/100/100?random=9&keyword=monitor",
        },
      ],
      "shippingAddress": "654 Maple Dr, Staten Island, NY 10301",
      "paymentMethod": "Credit Card ending in 9876",
    },
  ];

  List<String> orderStatuses = ["all", "pending", "processing", "shipped", "delivered", "cancelled"];

  List<Map<String, dynamic>> get filteredOrders {
    if (selectedOrderStatus == "all") {
      return orders;
    }
    return orders.where((order) => order["status"] == selectedOrderStatus).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Orders"),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.filter_list),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          // Status Filter
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Filter by Status",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spMd),
                QHorizontalScroll(
                  children: orderStatuses.map((status) => GestureDetector(
                    onTap: () {
                      selectedOrderStatus = status;
                      setState(() {});
                    },
                    child: Container(
                      margin: EdgeInsets.only(right: spSm),
                      padding: EdgeInsets.symmetric(
                        horizontal: spMd,
                        vertical: spSm,
                      ),
                      decoration: BoxDecoration(
                        color: selectedOrderStatus == status ? primaryColor : Colors.white,
                        borderRadius: BorderRadius.circular(radiusLg),
                        border: Border.all(
                          color: selectedOrderStatus == status ? primaryColor : disabledOutlineBorderColor,
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          if (status != "all") ...[
                            Container(
                              width: 8,
                              height: 8,
                              decoration: BoxDecoration(
                                color: _getStatusColor(status),
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                            ),
                            SizedBox(width: spSm),
                          ],
                          Text(
                            status == "all" 
                                ? "All Orders (${orders.length})"
                                : "${status.toUpperCase()} (${orders.where((o) => o["status"] == status).length})",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: selectedOrderStatus == status ? Colors.white : primaryColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  )).toList(),
                ),
              ],
            ),
          ),
          
          // Orders List
          Expanded(
            child: filteredOrders.isEmpty 
                ? _buildEmptyState()
                : ListView.builder(
                    padding: EdgeInsets.all(spMd),
                    itemCount: filteredOrders.length,
                    itemBuilder: (context, index) {
                      final order = filteredOrders[index];
                      return _buildOrderCard(order);
                    },
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // Navigate to continue shopping
        },
        backgroundColor: primaryColor,
        icon: Icon(Icons.shopping_cart, color: Colors.white),
        label: Text(
          "Continue Shopping",
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    String message = selectedOrderStatus == "all" 
        ? "No orders yet"
        : "No ${selectedOrderStatus} orders";
    
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.shopping_bag_outlined,
            size: 100,
            color: disabledColor,
          ),
          SizedBox(height: spMd),
          Text(
            message,
            style: TextStyle(
              fontSize: fsH4,
              fontWeight: FontWeight.bold,
              color: disabledBoldColor,
            ),
          ),
          SizedBox(height: spSm),
          Text(
            selectedOrderStatus == "all"
                ? "Start shopping to see your orders here"
                : "Orders with this status will appear here",
            style: TextStyle(
              fontSize: 16,
              color: disabledBoldColor,
            ),
          ),
          SizedBox(height: spMd),
          QButton(
            label: "Start Shopping",
            size: bs.md,
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildOrderCard(Map<String, dynamic> order) {
    return Container(
      margin: EdgeInsets.only(bottom: spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowMd],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Order Header
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: _getStatusColor(order["status"]).withAlpha(20),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(radiusLg),
                topRight: Radius.circular(radiusLg),
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
                            "Order ${order["id"]}",
                            style: TextStyle(
                              fontSize: fsH6,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "Placed on ${order["date"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: spMd,
                        vertical: spSm,
                      ),
                      decoration: BoxDecoration(
                        color: _getStatusColor(order["status"]),
                        borderRadius: BorderRadius.circular(radiusLg),
                      ),
                      child: Text(
                        "${order["status"]}".toUpperCase(),
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
                
                if (order["status"] == "shipped" && order["trackingNumber"].isNotEmpty) ...[
                  SizedBox(height: spMd),
                  Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: infoColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusLg),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.local_shipping,
                          color: infoColor,
                          size: 16,
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Text(
                            "Tracking: ${order["trackingNumber"]}",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: infoColor,
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            // Track order
                          },
                          child: Text(
                            "Track",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: infoColor,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
                
                if (order["status"] == "cancelled") ...[
                  SizedBox(height: spMd),
                  Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: dangerColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusLg),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.cancel,
                          color: dangerColor,
                          size: 16,
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Text(
                            "Reason: ${order["cancelReason"] ?? "Order cancelled"}",
                            style: TextStyle(
                              fontSize: 12,
                              color: dangerColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ],
            ),
          ),
          
          // Order Items
          Padding(
            padding: EdgeInsets.all(spMd),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Items (${order["items"]})",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: spMd),
                
                ...(order["products"] as List).map((product) => Container(
                  margin: EdgeInsets.only(bottom: spMd),
                  child: Row(
                    children: [
                      Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(radiusLg),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(radiusLg),
                          child: Image.network(
                            "${product["image"]}",
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SizedBox(width: spMd),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${product["name"]}",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(height: spXs),
                            Text(
                              "Qty: ${product["quantity"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        "\$${(product["price"] as double).toStringAsFixed(2)}",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                )).toList(),
                
                // Order Total
                Container(
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: primaryColor.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusLg),
                  ),
                  child: Row(
                    children: [
                      Text(
                        "Order Total:",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Spacer(),
                      Text(
                        "\$${(order["total"] as double).toStringAsFixed(2)}",
                        style: TextStyle(
                          fontSize: fsH5,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
                
                SizedBox(height: spMd),
                
                // Delivery Info
                if (order["estimatedDelivery"].isNotEmpty) ...[
                  Row(
                    children: [
                      Icon(
                        Icons.local_shipping,
                        color: disabledBoldColor,
                        size: 16,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        order["status"] == "delivered" 
                            ? "Delivered on ${order["estimatedDelivery"]}"
                            : "Estimated delivery: ${order["estimatedDelivery"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                ],
                
                // Shipping Address
                Row(
                  children: [
                    Icon(
                      Icons.location_on,
                      color: disabledBoldColor,
                      size: 16,
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: Text(
                        "${order["shippingAddress"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                    ),
                  ],
                ),
                
                SizedBox(height: spSm),
                
                // Payment Method
                Row(
                  children: [
                    Icon(
                      Icons.payment,
                      color: disabledBoldColor,
                      size: 16,
                    ),
                    SizedBox(width: spSm),
                    Text(
                      "${order["paymentMethod"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
                
                SizedBox(height: spMd),
                
                // Action Buttons
                Row(
                  children: [
                    Expanded(
                      child: QButton(
                        label: "View Details",
                        size: bs.sm,
                        onPressed: () {
                          _showOrderDetails(order);
                        },
                      ),
                    ),
                    
                    SizedBox(width: spSm),
                    
                    if (order["status"] == "delivered")
                      Expanded(
                        child: QButton(
                          label: "Review",
                          size: bs.sm,
                          onPressed: () {},
                        ),
                      ),
                    
                    if (order["status"] == "pending" || order["status"] == "processing")
                      Expanded(
                        child: QButton(
                          label: "Cancel",
                          size: bs.sm,
                          onPressed: () {
                            _cancelOrder(order);
                          },
                        ),
                      ),
                    
                    if (order["status"] == "shipped")
                      Expanded(
                        child: QButton(
                          label: "Track",
                          size: bs.sm,
                          onPressed: () {},
                        ),
                      ),
                    
                    if (order["status"] == "delivered" || order["status"] == "cancelled")
                      Expanded(
                        child: QButton(
                          label: "Reorder",
                          size: bs.sm,
                          onPressed: () {},
                        ),
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

  void _showOrderDetails(Map<String, dynamic> order) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.8,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(radiusLg),
            topRight: Radius.circular(radiusLg),
          ),
        ),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: disabledOutlineBorderColor),
                ),
              ),
              child: Row(
                children: [
                  Text(
                    "Order Details",
                    style: TextStyle(
                      fontSize: fsH5,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Spacer(),
                  IconButton(
                    icon: Icon(Icons.close),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(spMd),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Order ${order["id"]}",
                      style: TextStyle(
                        fontSize: fsH4,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "Placed on ${order["date"]}",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                    
                    SizedBox(height: spMd),
                    
                    Container(
                      padding: EdgeInsets.all(spMd),
                      decoration: BoxDecoration(
                        color: _getStatusColor(order["status"]).withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusLg),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            _getStatusIcon(order["status"]),
                            color: _getStatusColor(order["status"]),
                          ),
                          SizedBox(width: spMd),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Status: ${order["status"]}".toUpperCase(),
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: _getStatusColor(order["status"]),
                                  ),
                                ),
                                if (order["estimatedDelivery"].isNotEmpty)
                                  Text(
                                    order["status"] == "delivered"
                                        ? "Delivered on ${order["estimatedDelivery"]}"
                                        : "Expected delivery: ${order["estimatedDelivery"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    
                    SizedBox(height: spMd),
                    
                    Text(
                      "Order Items",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    
                    SizedBox(height: spMd),
                    
                    ...(order["products"] as List).map((product) => Container(
                      margin: EdgeInsets.only(bottom: spMd),
                      padding: EdgeInsets.all(spMd),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(radiusLg),
                        border: Border.all(color: disabledOutlineBorderColor),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 80,
                            height: 80,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(radiusLg),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(radiusLg),
                              child: Image.network(
                                "${product["image"]}",
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          SizedBox(width: spMd),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${product["name"]}",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: spSm),
                                Text(
                                  "Quantity: ${product["quantity"]}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                SizedBox(height: spSm),
                                Text(
                                  "\$${(product["price"] as double).toStringAsFixed(2)} each",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: primaryColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )).toList(),
                    
                    Container(
                      padding: EdgeInsets.all(spMd),
                      decoration: BoxDecoration(
                        color: primaryColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusLg),
                      ),
                      child: Row(
                        children: [
                          Text(
                            "Total Amount:",
                            style: TextStyle(
                              fontSize: fsH5,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Spacer(),
                          Text(
                            "\$${(order["total"] as double).toStringAsFixed(2)}",
                            style: TextStyle(
                              fontSize: fsH4,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  IconData _getStatusIcon(String status) {
    switch (status) {
      case "pending":
        return Icons.hourglass_empty;
      case "processing":
        return Icons.settings;
      case "shipped":
        return Icons.local_shipping;
      case "delivered":
        return Icons.check_circle;
      case "cancelled":
        return Icons.cancel;
      default:
        return Icons.shopping_bag;
    }
  }

  void _cancelOrder(Map<String, dynamic> order) async {
    bool isConfirmed = await confirm("Are you sure you want to cancel this order?");
    if (isConfirmed) {
      order["status"] = "cancelled";
      order["cancelReason"] = "Cancelled by customer";
      setState(() {});
      ss("Order cancelled successfully");
    }
  }
}
