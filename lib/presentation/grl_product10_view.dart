import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlProduct10View extends StatefulWidget {
  @override
  State<GrlProduct10View> createState() => _GrlProduct10ViewState();
}

class _GrlProduct10ViewState extends State<GrlProduct10View> {
  String selectedStatus = 'all';
  String searchQuery = '';

  List<Map<String, dynamic>> statusFilters = [
    {"label": "All Orders", "value": "all"},
    {"label": "Processing", "value": "processing"},
    {"label": "Shipped", "value": "shipped"},
    {"label": "Delivered", "value": "delivered"},
    {"label": "Cancelled", "value": "cancelled"},
  ];

  List<Map<String, dynamic>> orders = [
    {
      "id": "ORD-2024-001",
      "date": DateTime.now().subtract(Duration(days: 2)),
      "status": "delivered",
      "total": 299.97,
      "items": [
        {
          "name": "Wireless Bluetooth Headphones",
          "brand": "TechSound",
          "price": 79.99,
          "quantity": 2,
          "image": "https://picsum.photos/300/300?random=1&keyword=headphones",
        },
        {
          "name": "Phone Stand",
          "brand": "AccessoryPro",
          "price": 19.99,
          "quantity": 1,
          "image": "https://picsum.photos/300/300?random=2&keyword=stand",
        },
      ],
      "tracking": "1Z999AA1234567890",
      "estimatedDelivery": DateTime.now().add(Duration(days: 1)),
      "shippingAddress": "123 Main St, City, State 12345",
      "paymentMethod": "Credit Card ****1234",
    },
    {
      "id": "ORD-2024-002",
      "date": DateTime.now().subtract(Duration(days: 5)),
      "status": "shipped",
      "total": 449.99,
      "items": [
        {
          "name": "Smart Fitness Watch",
          "brand": "FitTech",
          "price": 199.99,
          "quantity": 1,
          "image": "https://picsum.photos/300/300?random=3&keyword=smartwatch",
        },
        {
          "name": "Wireless Charger",
          "brand": "PowerLink",
          "price": 49.99,
          "quantity": 1,
          "image": "https://picsum.photos/300/300?random=4&keyword=charger",
        },
      ],
      "tracking": "1Z999AA1234567891",
      "estimatedDelivery": DateTime.now().add(Duration(days: 3)),
      "shippingAddress": "456 Oak Ave, City, State 67890",
      "paymentMethod": "PayPal",
    },
    {
      "id": "ORD-2024-003",
      "date": DateTime.now().subtract(Duration(days: 8)),
      "status": "processing",
      "total": 899.99,
      "items": [
        {
          "name": "Professional Camera Lens",
          "brand": "CameraMax",
          "price": 349.99,
          "quantity": 1,
          "image": "https://picsum.photos/300/300?random=5&keyword=lens",
        },
        {
          "name": "Camera Bag",
          "brand": "PhotoGear",
          "price": 89.99,
          "quantity": 1,
          "image": "https://picsum.photos/300/300?random=6&keyword=bag",
        },
      ],
      "tracking": null,
      "estimatedDelivery": DateTime.now().add(Duration(days: 7)),
      "shippingAddress": "789 Pine Rd, City, State 13579",
      "paymentMethod": "Apple Pay",
    },
    {
      "id": "ORD-2024-004",
      "date": DateTime.now().subtract(Duration(days: 15)),
      "status": "cancelled",
      "total": 159.98,
      "items": [
        {
          "name": "Bluetooth Speaker",
          "brand": "SoundWave",
          "price": 79.99,
          "quantity": 2,
          "image": "https://picsum.photos/300/300?random=7&keyword=speaker",
        },
      ],
      "tracking": null,
      "estimatedDelivery": null,
      "shippingAddress": "321 Elm St, City, State 24680",
      "paymentMethod": "Credit Card ****5678",
      "cancellationReason": "Customer requested cancellation",
    },
  ];

  List<Map<String, dynamic>> get filteredOrders {
    List<Map<String, dynamic>> filtered = orders;

    if (selectedStatus != 'all') {
      filtered = filtered.where((order) => order["status"] == selectedStatus).toList();
    }

    if (searchQuery.isNotEmpty) {
      filtered = filtered.where((order) =>
          (order["id"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
          (order["items"] as List).any((item) =>
              (item["name"] as String).toLowerCase().contains(searchQuery.toLowerCase()))
      ).toList();
    }

    return filtered;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Order History"),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              _showSearchDialog();
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
      body: Column(
        children: [
          // Statistics Header
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [primaryColor, secondaryColor],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Column(
              children: [
                Text(
                  "Order Statistics",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: spMd),
                Row(
                  children: [
                    Expanded(
                      child: _buildStatCard(
                        "${orders.length}",
                        "Total Orders",
                        Icons.shopping_bag,
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: _buildStatCard(
                        "${orders.where((o) => o["status"] == "delivered").length}",
                        "Delivered",
                        Icons.check_circle,
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: _buildStatCard(
                        "\$${orders.fold(0.0, (sum, order) => sum + (order["total"] as double)).toStringAsFixed(0)}",
                        "Total Spent",
                        Icons.attach_money,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Status Filter
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [shadowSm],
            ),
            child: QHorizontalScroll(
              children: statusFilters.map((filter) => GestureDetector(
                onTap: () {
                  setState(() {
                    selectedStatus = filter["value"];
                  });
                },
                child: Container(
                  margin: EdgeInsets.only(right: spMd),
                  padding: EdgeInsets.symmetric(
                    horizontal: spMd,
                    vertical: spSm,
                  ),
                  decoration: BoxDecoration(
                    color: selectedStatus == filter["value"]
                        ? primaryColor
                        : Colors.grey[100],
                    borderRadius: BorderRadius.circular(radiusLg),
                    border: Border.all(
                      color: selectedStatus == filter["value"]
                          ? primaryColor
                          : Colors.grey[300]!,
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        _getStatusIcon(filter["value"]),
                        size: 16,
                        color: selectedStatus == filter["value"]
                            ? Colors.white
                            : disabledBoldColor,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "${filter["label"]}",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: selectedStatus == filter["value"]
                              ? Colors.white
                              : disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ),
              )).toList(),
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
    );
  }

  Widget _buildStatCard(String value, String label, IconData icon) {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white.withAlpha(200),
        borderRadius: BorderRadius.circular(radiusLg),
      ),
      child: Column(
        children: [
          Icon(icon, color: primaryColor, size: 24),
          SizedBox(height: spSm),
          Text(
            value,
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Text(
            label,
            style: TextStyle(
              fontSize: 10,
              color: disabledBoldColor,
            ),
            textAlign: TextAlign.center,
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
            child: Row(
              children: [
                Icon(
                  _getStatusIcon(order["status"]),
                  color: _getStatusColor(order["status"]),
                  size: 20,
                ),
                SizedBox(width: spSm),
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
                        "${(order["date"] as DateTime).day}/${(order["date"] as DateTime).month}/${(order["date"] as DateTime).year}",
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
                      padding: EdgeInsets.symmetric(
                        horizontal: spSm,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: _getStatusColor(order["status"]),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Text(
                        "${order["status"]}".toUpperCase(),
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "\$${(order["total"] as double).toStringAsFixed(2)}",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
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
                  "Items (${(order["items"] as List).length})",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: spSm),
                ...(order["items"] as List).take(2).map((item) => Container(
                  margin: EdgeInsets.only(bottom: spSm),
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(radiusSm),
                        child: Image.network(
                          "${item["image"]}",
                          width: 50,
                          height: 50,
                          fit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(width: spMd),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${item["name"]}",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              "${item["brand"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: primaryColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            "Qty: ${item["quantity"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          Text(
                            "\$${(item["price"] as double).toStringAsFixed(2)}",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                )),
                if ((order["items"] as List).length > 2)
                  Text(
                    "... and ${(order["items"] as List).length - 2} more items",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                      fontStyle: FontStyle.italic,
                    ),
                  ),

                SizedBox(height: spMd),

                // Order Details
                if (order["tracking"] != null) ...[
                  _buildOrderDetail("Tracking Number", "${order["tracking"]}"),
                  SizedBox(height: spSm),
                ],
                if (order["estimatedDelivery"] != null) ...[
                  _buildOrderDetail(
                    "Estimated Delivery",
                    "${(order["estimatedDelivery"] as DateTime).day}/${(order["estimatedDelivery"] as DateTime).month}/${(order["estimatedDelivery"] as DateTime).year}",
                  ),
                  SizedBox(height: spSm),
                ],
                _buildOrderDetail("Shipping Address", "${order["shippingAddress"]}"),
                SizedBox(height: spSm),
                _buildOrderDetail("Payment Method", "${order["paymentMethod"]}"),

                if (order["status"] == "cancelled" && order["cancellationReason"] != null) ...[
                  SizedBox(height: spSm),
                  _buildOrderDetail("Cancellation Reason", "${order["cancellationReason"]}"),
                ],

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
                    SizedBox(width: spMd),
                    if (order["status"] == "delivered")
                      Expanded(
                        child: QButton(
                          label: "Reorder",
                          size: bs.sm,
                          onPressed: () {
                            ss("Items added to cart for reorder");
                          },
                        ),
                      ),
                    if (order["status"] == "processing")
                      Expanded(
                        child: QButton(
                          label: "Cancel Order",
                          size: bs.sm,
                          onPressed: () {
                            _cancelOrder(order);
                          },
                        ),
                      ),
                    if (order["status"] == "shipped")
                      Expanded(
                        child: QButton(
                          label: "Track Order",
                          size: bs.sm,
                          onPressed: () {
                            _trackOrder(order);
                          },
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

  Widget _buildOrderDetail(String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 100,
          child: Text(
            "$label:",
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(spMd),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.shopping_bag_outlined,
              size: 80,
              color: disabledBoldColor,
            ),
            SizedBox(height: spMd),
            Text(
              "No orders found",
              style: TextStyle(
                fontSize: fsH5,
                fontWeight: FontWeight.bold,
                color: disabledBoldColor,
              ),
            ),
            SizedBox(height: spSm),
            Text(
              selectedStatus != 'all'
                  ? "No orders with ${selectedStatus} status"
                  : "You haven't placed any orders yet",
              style: TextStyle(
                fontSize: 14,
                color: disabledBoldColor,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: spMd),
            QButton(
              label: "Start Shopping",
              size: bs.md,
              onPressed: () {
                // navigateTo(ProductCatalogView());
              },
            ),
          ],
        ),
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'processing':
        return warningColor;
      case 'shipped':
        return infoColor;
      case 'delivered':
        return successColor;
      case 'cancelled':
        return dangerColor;
      default:
        return primaryColor;
    }
  }

  IconData _getStatusIcon(String status) {
    switch (status) {
      case 'processing':
        return Icons.hourglass_empty;
      case 'shipped':
        return Icons.local_shipping;
      case 'delivered':
        return Icons.check_circle;
      case 'cancelled':
        return Icons.cancel;
      case 'all':
        return Icons.list;
      default:
        return Icons.shopping_bag;
    }
  }

  void _showSearchDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Search Orders"),
        content: TextField(
          decoration: InputDecoration(
            hintText: "Enter order ID or product name...",
          ),
          onChanged: (value) {
            setState(() {
              searchQuery = value;
            });
          },
        ),
        actions: [
          QButton(
            label: "Search",
            size: bs.sm,
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }

  void _showFilterDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Filter Orders"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: statusFilters.map((filter) => 
            RadioListTile<String>(
              title: Text("${filter["label"]}"),
              value: filter["value"],
              groupValue: selectedStatus,
              onChanged: (value) {
                setState(() {
                  selectedStatus = value!;
                });
                Navigator.pop(context);
              },
            )
          ).toList(),
        ),
      ),
    );
  }

  void _showOrderDetails(Map<String, dynamic> order) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Order ${order["id"]}"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Status: ${order["status"]}"),
            Text("Total: \$${(order["total"] as double).toStringAsFixed(2)}"),
            Text("Items: ${(order["items"] as List).length}"),
            if (order["tracking"] != null)
              Text("Tracking: ${order["tracking"]}"),
          ],
        ),
        actions: [
          QButton(
            label: "Close",
            size: bs.sm,
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }

  void _cancelOrder(Map<String, dynamic> order) async {
    bool isConfirmed = await confirm("Are you sure you want to cancel this order?");
    if (isConfirmed) {
      setState(() {
        order["status"] = "cancelled";
        order["cancellationReason"] = "Customer requested cancellation";
      });
      ss("Order ${order["id"]} has been cancelled");
    }
  }

  void _trackOrder(Map<String, dynamic> order) {
    if (order["tracking"] != null) {
      ss("Tracking information: ${order["tracking"]}");
    } else {
      si("Tracking information not available yet");
    }
  }
}
