import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class LtaOrderHistoryView extends StatefulWidget {
  const LtaOrderHistoryView({super.key});

  @override
  State<LtaOrderHistoryView> createState() => _LtaOrderHistoryViewState();
}

class _LtaOrderHistoryViewState extends State<LtaOrderHistoryView> {
  String searchQuery = "";
  String selectedStatus = "All";
  String selectedPeriod = "All Time";
  
  List<Map<String, dynamic>> statusOptions = [
    {"label": "All", "value": "All"},
    {"label": "Pending", "value": "Pending"},
    {"label": "In Transit", "value": "In Transit"},
    {"label": "Delivered", "value": "Delivered"},
    {"label": "Cancelled", "value": "Cancelled"},
    {"label": "Failed", "value": "Failed"}
  ];

  List<Map<String, dynamic>> periodOptions = [
    {"label": "All Time", "value": "All Time"},
    {"label": "Today", "value": "Today"},
    {"label": "This Week", "value": "This Week"},
    {"label": "This Month", "value": "This Month"},
    {"label": "Last 3 Months", "value": "Last 3 Months"}
  ];

  List<Map<String, dynamic>> orders = [
    {
      "orderId": "ORD001",
      "customerName": "PT Maju Jaya",
      "customerPhone": "+62 812-3456-7890",
      "pickupAddress": "Jl. Sudirman No. 123, Jakarta",
      "deliveryAddress": "Jl. Malioboro No. 45, Yogyakarta",
      "itemDescription": "Electronic Equipment - 15 boxes",
      "weight": 250.5,
      "distance": 420.0,
      "orderDate": "2024-12-15 08:30",
      "deliveryDate": "2024-12-16 14:20",
      "status": "Delivered",
      "totalCost": 2750000.0,
      "driverName": "Ahmad Suryanto",
      "vehicleNumber": "B 1234 XYZ",
      "paymentStatus": "Paid",
      "rating": 5.0
    },
    {
      "orderId": "ORD002",
      "customerName": "CV Berkah Mandiri",
      "customerPhone": "+62 813-9876-5432",
      "pickupAddress": "Jl. Gatot Subroto No. 67, Jakarta",
      "deliveryAddress": "Jl. Pahlawan No. 89, Bandung",
      "itemDescription": "Furniture & Home Decor - 8 packages",
      "weight": 180.0,
      "distance": 150.0,
      "orderDate": "2024-12-15 10:15",
      "deliveryDate": null,
      "status": "In Transit",
      "totalCost": 1850000.0,
      "driverName": "Budi Santoso",
      "vehicleNumber": "B 5678 ABC",
      "paymentStatus": "Paid",
      "rating": null
    },
    {
      "orderId": "ORD003",
      "customerName": "Toko Sejahtera",
      "customerPhone": "+62 814-1111-2222",
      "pickupAddress": "Jl. Raya Bogor No. 34, Depok",
      "deliveryAddress": "Jl. Ahmad Yani No. 12, Semarang",
      "itemDescription": "Food & Beverages - 25 cartons",
      "weight": 320.8,
      "distance": 450.0,
      "orderDate": "2024-12-15 14:45",
      "deliveryDate": null,
      "status": "Pending",
      "totalCost": 3200000.0,
      "driverName": null,
      "vehicleNumber": null,
      "paymentStatus": "Pending",
      "rating": null
    },
    {
      "orderId": "ORD004",
      "customerName": "PT Global Solutions",
      "customerPhone": "+62 815-3333-4444",
      "pickupAddress": "Jl. HR Rasuna Said No. 56, Jakarta",
      "deliveryAddress": "Jl. Diponegoro No. 78, Surabaya",
      "itemDescription": "Industrial Parts - 12 crates",
      "weight": 450.2,
      "distance": 750.0,
      "orderDate": "2024-12-14 16:20",
      "deliveryDate": null,
      "status": "Cancelled",
      "totalCost": 4500000.0,
      "driverName": null,
      "vehicleNumber": null,
      "paymentStatus": "Refunded",
      "rating": null
    },
    {
      "orderId": "ORD005",
      "customerName": "Indah Sari Store",
      "customerPhone": "+62 816-5555-6666",
      "pickupAddress": "Jl. Thamrin No. 90, Jakarta",
      "deliveryAddress": "Jl. Veteran No. 23, Solo",
      "itemDescription": "Fashion & Accessories - 30 packages",
      "weight": 95.5,
      "distance": 550.0,
      "orderDate": "2024-12-14 09:10",
      "deliveryDate": "2024-12-15 11:30",
      "status": "Delivered",
      "totalCost": 2950000.0,
      "driverName": "Sari Wulandari",
      "vehicleNumber": "B 9012 DEF",
      "paymentStatus": "Paid",
      "rating": 4.5
    },
    {
      "orderId": "ORD006",
      "customerName": "Tech Innovative",
      "customerPhone": "+62 817-7777-8888",
      "pickupAddress": "Jl. Kuningan No. 45, Jakarta",
      "deliveryAddress": "Jl. Gajah Mada No. 67, Medan",
      "itemDescription": "Computer Hardware - 20 boxes",
      "weight": 380.0,
      "distance": 1450.0,
      "orderDate": "2024-12-13 13:25",
      "deliveryDate": null,
      "status": "Failed",
      "totalCost": 8500000.0,
      "driverName": "Eko Prasetyo",
      "vehicleNumber": "B 3456 GHI",
      "paymentStatus": "Refund Pending",
      "rating": null
    }
  ];

  List<Map<String, dynamic>> get filteredOrders {
    return orders.where((order) {
      bool matchesSearch = searchQuery.isEmpty || 
          (order["orderId"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
          (order["customerName"] as String).toLowerCase().contains(searchQuery.toLowerCase());
      
      bool matchesStatus = selectedStatus == "All" || order["status"] == selectedStatus;
      
      return matchesSearch && matchesStatus;
    }).toList();
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "Delivered":
        return successColor;
      case "In Transit":
        return infoColor;
      case "Pending":
        return warningColor;
      case "Cancelled":
      case "Failed":
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  IconData _getStatusIcon(String status) {
    switch (status) {
      case "Delivered":
        return Icons.check_circle;
      case "In Transit":
        return Icons.local_shipping;
      case "Pending":
        return Icons.schedule;
      case "Cancelled":
        return Icons.cancel;
      case "Failed":
        return Icons.error;
      default:
        return Icons.help;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Order History"),
        actions: [
          IconButton(
            icon: Icon(Icons.filter_list),
            onPressed: () {
              // Show filter options
            },
          ),
          IconButton(
            icon: Icon(Icons.download),
            onPressed: () {
              ss("Export started");
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
            Row(
              children: [
                Expanded(
                  child: QTextField(
                    label: "Search orders...",
                    value: searchQuery,
                    hint: "Search by Order ID or Customer",
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

            // Filter Options
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
                    label: "Period",
                    items: periodOptions,
                    value: selectedPeriod,
                    onChanged: (value, label) {
                      selectedPeriod = value;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),

            // Order Statistics
            Row(
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
                        Icon(Icons.assignment, color: primaryColor, size: 24),
                        SizedBox(height: spXs),
                        Text(
                          "${orders.length}",
                          style: TextStyle(
                            fontSize: fsH5,
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
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusMd),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      children: [
                        Icon(Icons.check_circle, color: successColor, size: 24),
                        SizedBox(height: spXs),
                        Text(
                          "${orders.where((order) => order["status"] == "Delivered").length}",
                          style: TextStyle(
                            fontSize: fsH5,
                            fontWeight: FontWeight.bold,
                            color: successColor,
                          ),
                        ),
                        Text(
                          "Delivered",
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
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusMd),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      children: [
                        Icon(Icons.local_shipping, color: infoColor, size: 24),
                        SizedBox(height: spXs),
                        Text(
                          "${orders.where((order) => order["status"] == "In Transit").length}",
                          style: TextStyle(
                            fontSize: fsH5,
                            fontWeight: FontWeight.bold,
                            color: infoColor,
                          ),
                        ),
                        Text(
                          "In Transit",
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
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.all(spSm),
                    child: Row(
                      children: [
                        Text(
                          "Order History",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Spacer(),
                        Text(
                          "${filteredOrders.length} orders",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  ListView.separated(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: filteredOrders.length,
                    separatorBuilder: (context, index) => Divider(height: 1),
                    itemBuilder: (context, index) {
                      final order = filteredOrders[index];
                      return Container(
                        padding: EdgeInsets.all(spSm),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Container(
                                  width: 40,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    color: _getStatusColor(order["status"] as String).withAlpha(20),
                                    borderRadius: BorderRadius.circular(radiusSm),
                                  ),
                                  child: Icon(
                                    _getStatusIcon(order["status"] as String),
                                    color: _getStatusColor(order["status"] as String),
                                    size: 20,
                                  ),
                                ),
                                SizedBox(width: spSm),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            "${order["orderId"]}",
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16,
                                            ),
                                          ),
                                          Spacer(),
                                          Container(
                                            padding: EdgeInsets.symmetric(
                                              horizontal: spXs,
                                              vertical: 2,
                                            ),
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
                                        ],
                                      ),
                                      SizedBox(height: spXs),
                                      Text(
                                        "${order["customerName"]}",
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: primaryColor,
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
                              padding: EdgeInsets.all(spSm),
                              decoration: BoxDecoration(
                                color: Colors.grey.withAlpha(10),
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Column(
                                spacing: spXs,
                                children: [
                                  Row(
                                    children: [
                                      Icon(Icons.inventory, size: 14, color: disabledBoldColor),
                                      SizedBox(width: spXs),
                                      Expanded(
                                        child: Text(
                                          "${order["itemDescription"]}",
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
                                      Icon(Icons.scale, size: 14, color: disabledBoldColor),
                                      SizedBox(width: spXs),
                                      Text(
                                        "${order["weight"]} kg",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                      SizedBox(width: spSm),
                                      Icon(Icons.route, size: 14, color: disabledBoldColor),
                                      SizedBox(width: spXs),
                                      Text(
                                        "${order["distance"]} km",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Icon(Icons.access_time, size: 14, color: disabledBoldColor),
                                      SizedBox(width: spXs),
                                      Text(
                                        "${order["orderDate"]}",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                  if (order["driverName"] != null) ...[
                                    Row(
                                      children: [
                                        Icon(Icons.person, size: 14, color: disabledBoldColor),
                                        SizedBox(width: spXs),
                                        Text(
                                          "${order["driverName"]} • ${order["vehicleNumber"]}",
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: disabledBoldColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ],
                              ),
                            ),
                            SizedBox(height: spSm),
                            Row(
                              children: [
                                Text(
                                  "Rp ${(order["totalCost"] as double).currency}",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                                Spacer(),
                                QButton(
                                  label: "View Details",
                                  size: bs.sm,
                                  onPressed: () {
                                    // Navigate to order details
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
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
