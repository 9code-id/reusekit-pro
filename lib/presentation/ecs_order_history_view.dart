import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class EcsOrderHistoryView extends StatefulWidget {
  const EcsOrderHistoryView({super.key});

  @override
  State<EcsOrderHistoryView> createState() => _EcsOrderHistoryViewState();
}

class _EcsOrderHistoryViewState extends State<EcsOrderHistoryView> {
  String selectedFilter = "all";
  String searchQuery = "";
  
  List<Map<String, dynamic>> filterOptions = [
    {"label": "All Orders", "value": "all"},
    {"label": "Delivered", "value": "delivered"},
    {"label": "In Transit", "value": "in_transit"},
    {"label": "Processing", "value": "processing"},
    {"label": "Cancelled", "value": "cancelled"},
  ];

  List<Map<String, dynamic>> orders = [
    {
      "id": "ORD-2024-001234",
      "date": "2024-06-14",
      "status": "delivered",
      "total": 98.06,
      "items": 3,
      "deliveryDate": "2024-06-18",
      "trackingNumber": "TN123456789",
      "image": "https://picsum.photos/80/80?random=1&keyword=headphones",
      "products": [
        {"name": "Wireless Bluetooth Headphones", "quantity": 1},
        {"name": "Phone Case - Clear", "quantity": 1},
        {"name": "USB-C Cable", "quantity": 1}
      ]
    },
    {
      "id": "ORD-2024-001233",
      "date": "2024-06-10",
      "status": "in_transit",
      "total": 156.78,
      "items": 2,
      "deliveryDate": "2024-06-15",
      "trackingNumber": "TN123456788",
      "image": "https://picsum.photos/80/80?random=2&keyword=laptop",
      "products": [
        {"name": "Laptop Stand", "quantity": 1},
        {"name": "Wireless Mouse", "quantity": 1}
      ]
    },
    {
      "id": "ORD-2024-001232",
      "date": "2024-06-08",
      "status": "processing",
      "total": 45.99,
      "items": 1,
      "deliveryDate": "2024-06-12",
      "trackingNumber": "TN123456787",
      "image": "https://picsum.photos/80/80?random=3&keyword=book",
      "products": [
        {"name": "Programming Book", "quantity": 1}
      ]
    },
    {
      "id": "ORD-2024-001231",
      "date": "2024-06-05",
      "status": "delivered",
      "total": 234.50,
      "items": 4,
      "deliveryDate": "2024-06-09",
      "trackingNumber": "TN123456786",
      "image": "https://picsum.photos/80/80?random=4&keyword=watch",
      "products": [
        {"name": "Smart Watch", "quantity": 1},
        {"name": "Watch Band", "quantity": 2},
        {"name": "Screen Protector", "quantity": 1}
      ]
    },
    {
      "id": "ORD-2024-001230",
      "date": "2024-06-01",
      "status": "cancelled",
      "total": 67.89,
      "items": 2,
      "deliveryDate": "",
      "trackingNumber": "",
      "image": "https://picsum.photos/80/80?random=5&keyword=camera",
      "products": [
        {"name": "Camera Lens", "quantity": 1},
        {"name": "Memory Card", "quantity": 1}
      ]
    },
  ];

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> filteredOrders = _getFilteredOrders();
    
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
        ],
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(spMd),
            child: QCategoryPicker(
              items: filterOptions,
              value: selectedFilter,
              onChanged: (index, label, value, item) {
                selectedFilter = value;
                setState(() {});
              },
            ),
          ),
          
          if (filteredOrders.isEmpty)
            Expanded(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.shopping_bag_outlined,
                      size: 64,
                      color: disabledBoldColor,
                    ),
                    SizedBox(height: spMd),
                    Text(
                      "No orders found",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "Try adjusting your filters or search criteria",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(height: spLg),
                    QButton(
                      label: "Start Shopping",
                      size: bs.md,
                      onPressed: () {
                        //navigateTo('home')
                      },
                    ),
                  ],
                ),
              ),
            )
          else
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.all(spMd),
                itemCount: filteredOrders.length,
                itemBuilder: (context, index) {
                  final order = filteredOrders[index];
                  return Container(
                    margin: EdgeInsets.only(bottom: spMd),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusMd),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.all(spMd),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "${order["id"]}",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: primaryColor,
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: spSm,
                                      vertical: spXs,
                                    ),
                                    decoration: BoxDecoration(
                                      color: _getStatusColor(order["status"] as String),
                                      borderRadius: BorderRadius.circular(radiusSm),
                                    ),
                                    child: Text(
                                      _getStatusLabel(order["status"] as String),
                                      style: TextStyle(
                                        fontSize: 10,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: spSm),
                              Row(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(radiusSm),
                                    child: Image.network(
                                      "${order["image"]}",
                                      width: 60,
                                      height: 60,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  SizedBox(width: spMd),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "${(order["products"] as List).first["name"]}",
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
                                          ),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        if ((order["products"] as List).length > 1)
                                          Text(
                                            "+${(order["products"] as List).length - 1} more items",
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: disabledBoldColor,
                                            ),
                                          ),
                                        SizedBox(height: spXs),
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.calendar_today,
                                              size: 14,
                                              color: disabledBoldColor,
                                            ),
                                            SizedBox(width: spXs),
                                            Text(
                                              "${DateTime.parse(order["date"] as String).dMMMy}",
                                              style: TextStyle(
                                                fontSize: 12,
                                                color: disabledBoldColor,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text(
                                        "\$${(order["total"] as double).currency}",
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: primaryColor,
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
                                ],
                              ),
                              
                              if (order["status"] == "delivered") ...[
                                SizedBox(height: spMd),
                                Container(
                                  padding: EdgeInsets.all(spSm),
                                  decoration: BoxDecoration(
                                    color: successColor.withAlpha(20),
                                    borderRadius: BorderRadius.circular(radiusSm),
                                  ),
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.check_circle,
                                        color: successColor,
                                        size: 16,
                                      ),
                                      SizedBox(width: spSm),
                                      Text(
                                        "Delivered on ${DateTime.parse(order["deliveryDate"] as String).dMMMy}",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: successColor,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                              
                              if (order["status"] == "in_transit") ...[
                                SizedBox(height: spMd),
                                Container(
                                  padding: EdgeInsets.all(spSm),
                                  decoration: BoxDecoration(
                                    color: infoColor.withAlpha(20),
                                    borderRadius: BorderRadius.circular(radiusSm),
                                  ),
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.local_shipping,
                                        color: infoColor,
                                        size: 16,
                                      ),
                                      SizedBox(width: spSm),
                                      Text(
                                        "Expected delivery: ${DateTime.parse(order["deliveryDate"] as String).dMMMy}",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: infoColor,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ],
                          ),
                        ),
                        
                        Container(
                          decoration: BoxDecoration(
                            border: Border(
                              top: BorderSide(
                                color: disabledOutlineBorderColor,
                                width: 1,
                              ),
                            ),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: QButton(
                                  label: "View Details",
                                  size: bs.sm,
                                  onPressed: () {
                                    //navigateTo('order_detail')
                                  },
                                ),
                              ),
                              
                              if (order["status"] == "in_transit") ...[
                                SizedBox(width: spSm),
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
                              
                              if (order["status"] == "delivered") ...[
                                SizedBox(width: spSm),
                                Expanded(
                                  child: QButton(
                                    label: "Reorder",
                                    size: bs.sm,
                                    onPressed: () {
                                      _reorderItems(order);
                                    },
                                  ),
                                ),
                              ],
                              
                              if (order["status"] == "processing") ...[
                                SizedBox(width: spSm),
                                Expanded(
                                  child: QButton(
                                    label: "Cancel Order",
                                    size: bs.sm,
                                    onPressed: () {
                                      _cancelOrder(order["id"] as String);
                                    },
                                  ),
                                ),
                              ],
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
        ],
      ),
    );
  }

  List<Map<String, dynamic>> _getFilteredOrders() {
    List<Map<String, dynamic>> filtered = orders;
    
    if (selectedFilter != "all") {
      filtered = filtered.where((order) => order["status"] == selectedFilter).toList();
    }
    
    if (searchQuery.isNotEmpty) {
      filtered = filtered.where((order) {
        return (order["id"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
               (order["products"] as List).any((product) =>
                 (product["name"] as String).toLowerCase().contains(searchQuery.toLowerCase()));
      }).toList();
    }
    
    return filtered;
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'delivered':
        return successColor;
      case 'in_transit':
        return infoColor;
      case 'processing':
        return warningColor;
      case 'cancelled':
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  String _getStatusLabel(String status) {
    switch (status) {
      case 'delivered':
        return 'Delivered';
      case 'in_transit':
        return 'In Transit';
      case 'processing':
        return 'Processing';
      case 'cancelled':
        return 'Cancelled';
      default:
        return 'Unknown';
    }
  }

  void _showSearchDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Search Orders"),
        content: QTextField(
          label: "Enter order ID or product name",
          value: searchQuery,
          onChanged: (value) {
            searchQuery = value;
          },
        ),
        actions: [
          TextButton(
            onPressed: () {
              searchQuery = "";
              Navigator.pop(context);
              setState(() {});
            },
            child: Text("Clear"),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              setState(() {});
            },
            child: Text("Search"),
          ),
        ],
      ),
    );
  }

  void _reorderItems(Map<String, dynamic> order) async {
    bool isConfirmed = await confirm("Add all items from this order to your cart?");
    if (isConfirmed) {
      ss("Items added to cart successfully");
    }
  }

  void _cancelOrder(String orderId) async {
    bool isConfirmed = await confirm("Are you sure you want to cancel this order? This action cannot be undone.");
    if (isConfirmed) {
      setState(() {
        orders.firstWhere((order) => order["id"] == orderId)["status"] = "cancelled";
      });
      ss("Order cancelled successfully");
    }
  }
}
