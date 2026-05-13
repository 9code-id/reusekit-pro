import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class RmaTakeawayOrdersView extends StatefulWidget {
  const RmaTakeawayOrdersView({super.key});

  @override
  State<RmaTakeawayOrdersView> createState() => _RmaTakeawayOrdersViewState();
}

class _RmaTakeawayOrdersViewState extends State<RmaTakeawayOrdersView> {
  String selectedFilter = "all";
  String sortBy = "newest";
  bool showDetails = true;
  
  List<Map<String, dynamic>> takeawayOrders = [
    {
      "id": "TAK-001",
      "orderNumber": "#TA12001",
      "customerName": "Michael Johnson",
      "customerPhone": "+1-555-1001",
      "items": [
        {"name": "Big Mac Burger", "quantity": 2, "price": 14.99, "customizations": ["No pickles", "Extra cheese"]},
        {"name": "Large Fries", "quantity": 2, "price": 5.99, "customizations": []},
        {"name": "Milkshake", "quantity": 1, "price": 4.99, "customizations": ["Vanilla"]},
      ],
      "totalAmount": 46.96,
      "orderTime": "2024-03-15 11:30:00",
      "estimatedPickupTime": "2024-03-15 12:00:00",
      "actualPickupTime": null,
      "status": "preparing",
      "preparationTime": 25,
      "paymentStatus": "paid",
      "paymentMethod": "card",
      "specialInstructions": "Please pack sauces separately",
      "orderSource": "app",
      "loyaltyPoints": 47,
      "promoCode": "TAKE10",
      "discount": 4.70,
    },
    {
      "id": "TAK-002",
      "orderNumber": "#TA12002",
      "customerName": "Sarah Williams",
      "customerPhone": "+1-555-1002",
      "items": [
        {"name": "Chicken Caesar Salad", "quantity": 1, "price": 12.99, "customizations": ["Extra dressing", "No croutons"]},
        {"name": "Garlic Bread", "quantity": 1, "price": 4.99, "customizations": []},
        {"name": "Iced Tea", "quantity": 2, "price": 2.99, "customizations": ["Lemon"]},
      ],
      "totalAmount": 23.96,
      "orderTime": "2024-03-15 12:15:00",
      "estimatedPickupTime": "2024-03-15 12:45:00",
      "actualPickupTime": "2024-03-15 12:42:00",
      "status": "completed",
      "preparationTime": 20,
      "paymentStatus": "paid",
      "paymentMethod": "cash",
      "specialInstructions": "",
      "orderSource": "phone",
      "loyaltyPoints": 24,
      "promoCode": "",
      "discount": 0.00,
    },
    {
      "id": "TAK-003",
      "orderNumber": "#TA12003",
      "customerName": "David Brown",
      "customerPhone": "+1-555-1003",
      "items": [
        {"name": "Fish & Chips", "quantity": 1, "price": 16.99, "customizations": ["Extra tartar sauce"]},
        {"name": "Coleslaw", "quantity": 1, "price": 3.99, "customizations": []},
        {"name": "Lemonade", "quantity": 1, "price": 3.99, "customizations": []},
      ],
      "totalAmount": 24.97,
      "orderTime": "2024-03-15 13:00:00",
      "estimatedPickupTime": "2024-03-15 13:30:00",
      "actualPickupTime": null,
      "status": "ready",
      "preparationTime": 30,
      "paymentStatus": "paid",
      "paymentMethod": "card",
      "specialInstructions": "Customer will arrive at 1:35 PM",
      "orderSource": "website",
      "loyaltyPoints": 25,
      "promoCode": "",
      "discount": 0.00,
    },
    {
      "id": "TAK-004",
      "orderNumber": "#TA12004",
      "customerName": "Lisa Garcia",
      "customerPhone": "+1-555-1004",
      "items": [
        {"name": "Veggie Pizza", "quantity": 1, "price": 18.99, "customizations": ["Thin crust", "Extra vegetables"]},
        {"name": "Garlic Knots", "quantity": 6, "price": 7.99, "customizations": []},
        {"name": "Sparkling Water", "quantity": 2, "price": 1.99, "customizations": []},
      ],
      "totalAmount": 32.96,
      "orderTime": "2024-03-15 14:20:00",
      "estimatedPickupTime": "2024-03-15 15:00:00",
      "actualPickupTime": null,
      "status": "confirmed",
      "preparationTime": 40,
      "paymentStatus": "pending",
      "paymentMethod": "cash",
      "specialInstructions": "Please call when ready",
      "orderSource": "app",
      "loyaltyPoints": 33,
      "promoCode": "VEGGIE15",
      "discount": 4.94,
    },
    {
      "id": "TAK-005",
      "orderNumber": "#TA12005",
      "customerName": "James Wilson",
      "customerPhone": "+1-555-1005",
      "items": [
        {"name": "BBQ Ribs", "quantity": 1, "price": 22.99, "customizations": ["Extra BBQ sauce"]},
        {"name": "Mac & Cheese", "quantity": 1, "price": 6.99, "customizations": []},
        {"name": "Beer", "quantity": 2, "price": 4.99, "customizations": ["Cold"]},
      ],
      "totalAmount": 39.96,
      "orderTime": "2024-03-15 15:45:00",
      "estimatedPickupTime": "2024-03-15 16:30:00",
      "actualPickupTime": null,
      "status": "received",
      "preparationTime": 45,
      "paymentStatus": "paid",
      "paymentMethod": "card",
      "specialInstructions": "Large portion please",
      "orderSource": "phone",
      "loyaltyPoints": 40,
      "promoCode": "",
      "discount": 0.00,
    },
  ];

  List<Map<String, dynamic>> filterOptions = [
    {"label": "All Orders", "value": "all"},
    {"label": "Received", "value": "received"},
    {"label": "Confirmed", "value": "confirmed"},
    {"label": "Preparing", "value": "preparing"},
    {"label": "Ready", "value": "ready"},
    {"label": "Completed", "value": "completed"},
    {"label": "Payment Pending", "value": "payment_pending"},
  ];

  List<Map<String, dynamic>> sortOptions = [
    {"label": "Newest First", "value": "newest"},
    {"label": "Pickup Time", "value": "pickup_time"},
    {"label": "Order Value", "value": "amount"},
    {"label": "Status", "value": "status"},
  ];

  Widget _buildTakeawayOverview() {
    final totalOrders = takeawayOrders.length;
    final readyOrders = takeawayOrders.where((order) => order["status"] == "ready").length;
    final totalRevenue = takeawayOrders.map((order) => order["totalAmount"] as double).reduce((a, b) => a + b);
    final avgPreparationTime = takeawayOrders.map((order) => order["preparationTime"] as int).reduce((a, b) => a + b) / totalOrders;
    
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
            "Takeaway Orders Overview",
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
              _buildOverviewCard(
                "Total Orders",
                "$totalOrders",
                Icons.takeout_dining,
                primaryColor,
              ),
              _buildOverviewCard(
                "Ready for Pickup",
                "$readyOrders",
                Icons.check_circle,
                successColor,
              ),
              _buildOverviewCard(
                "Total Revenue",
                "\$${totalRevenue.currency}",
                Icons.attach_money,
                successColor,
              ),
              _buildOverviewCard(
                "Avg Prep Time",
                "${avgPreparationTime.toStringAsFixed(0)} min",
                Icons.timer,
                infoColor,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildOverviewCard(String title, String value, IconData icon, Color color) {
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

  Widget _buildFilters() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        children: [
          Row(
            children: [
              Expanded(
                child: QDropdownField(
                  label: "Filter Status",
                  items: filterOptions,
                  value: selectedFilter,
                  onChanged: (value, label) {
                    selectedFilter = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
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
            ],
          ),
          Row(
            children: [
              Expanded(
                child: QSwitch(
                  items: [
                    {
                      "label": "Show Order Details",
                      "value": true,
                      "checked": showDetails,
                    }
                  ],
                  value: [
                    if (showDetails)
                      {
                        "label": "Show Order Details",
                        "value": true,
                        "checked": true
                      }
                  ],
                  onChanged: (values, ids) {
                    showDetails = values.isNotEmpty;
                    setState(() {});
                  },
                ),
              ),
              QButton(
                label: "Call Customer",
                icon: Icons.phone,
                size: bs.sm,
                onPressed: () {
                  //navigateTo('CallCustomer')
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTakeawayOrderCard(Map<String, dynamic> order) {
    final statusColor = order["status"] == "completed" ? successColor :
                       order["status"] == "ready" ? warningColor :
                       order["status"] == "preparing" ? infoColor :
                       order["status"] == "confirmed" ? primaryColor : disabledBoldColor;
    
    final isOverdue = order["actualPickupTime"] == null && 
                     DateTime.parse(order["estimatedPickupTime"]).isBefore(DateTime.now());

    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
        border: Border(
          left: BorderSide(
            width: 4,
            color: isOverdue ? dangerColor : statusColor,
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
                            fontSize: fsH6,
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
                        if (isOverdue) ...[
                          SizedBox(width: spSm),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                            decoration: BoxDecoration(
                              color: dangerColor.withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusLg),
                            ),
                            child: Text(
                              "OVERDUE",
                              style: TextStyle(
                                fontSize: 9,
                                fontWeight: FontWeight.bold,
                                color: dangerColor,
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                    SizedBox(height: spXs),
                    Row(
                      children: [
                        Icon(Icons.person, color: infoColor, size: 16),
                        SizedBox(width: spXs),
                        Text(
                          "${order["customerName"]}",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: disabledBoldColor,
                          ),
                        ),
                        SizedBox(width: spSm),
                        Icon(Icons.phone, color: successColor, size: 14),
                        SizedBox(width: spXs),
                        Text(
                          "${order["customerPhone"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: successColor,
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
                    "\$${((order["totalAmount"] as double)).currency}",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: successColor,
                    ),
                  ),
                  SizedBox(height: spXs),
                  Row(
                    children: [
                      Icon(Icons.schedule, color: warningColor, size: 16),
                      SizedBox(width: spXs),
                      Text(
                        "Pickup: ${order["estimatedPickupTime"].substring(11, 16)}",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: warningColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.access_time, color: disabledBoldColor, size: 14),
                        SizedBox(width: spXs),
                        Text(
                          "Ordered: ${order["orderTime"].substring(11, 16)}",
                          style: TextStyle(
                            fontSize: 11,
                            color: disabledBoldColor,
                          ),
                        ),
                        SizedBox(width: spSm),
                        Icon(Icons.timer, color: primaryColor, size: 14),
                        SizedBox(width: spXs),
                        Text(
                          "Prep: ${order["preparationTime"]} min",
                          style: TextStyle(
                            fontSize: 11,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spXs),
                    Row(
                      children: [
                        Icon(Icons.phone_android, color: infoColor, size: 14),
                        SizedBox(width: spXs),
                        Text(
                          "Source: ${order["orderSource"]}".toUpperCase(),
                          style: TextStyle(
                            fontSize: 11,
                            color: infoColor,
                          ),
                        ),
                        if ((order["loyaltyPoints"] as int) > 0) ...[
                          SizedBox(width: spSm),
                          Icon(Icons.stars, color: warningColor, size: 14),
                          SizedBox(width: spXs),
                          Text(
                            "${order["loyaltyPoints"]} pts",
                            style: TextStyle(
                              fontSize: 11,
                              color: warningColor,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ],
                ),
              ),
              if (order["paymentStatus"] == "pending")
                Container(
                  padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                  decoration: BoxDecoration(
                    color: dangerColor.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Text(
                    "PAYMENT PENDING",
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: dangerColor,
                    ),
                  ),
                ),
            ],
          ),
          if (showDetails) ...[
            SizedBox(height: spMd),
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: primaryColor.withAlpha(10),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Order Items:",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spXs),
                  ...((order["items"] as List).map((item) => Padding(
                    padding: EdgeInsets.only(bottom: spXs),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              "${item["quantity"]}x",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            SizedBox(width: spSm),
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
                              "\$${((item["price"] as double)).currency}",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: successColor,
                              ),
                            ),
                          ],
                        ),
                        if ((item["customizations"] as List).isNotEmpty) ...[
                          SizedBox(height: spXs),
                          Padding(
                            padding: EdgeInsets.only(left: spMd),
                            child: Text(
                              "• ${(item["customizations"] as List).join(", ")}",
                              style: TextStyle(
                                fontSize: 11,
                                color: infoColor,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                  ))).toList(),
                  if (order["specialInstructions"] != null && order["specialInstructions"] != "") ...[
                    SizedBox(height: spSm),
                    Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: warningColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.note, color: warningColor, size: 16),
                          SizedBox(width: spSm),
                          Expanded(
                            child: Text(
                              "${order["specialInstructions"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: warningColor,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                  if ((order["discount"] as double) > 0) ...[
                    SizedBox(height: spSm),
                    Row(
                      children: [
                        Icon(Icons.local_offer, color: successColor, size: 14),
                        SizedBox(width: spSm),
                        Text(
                          "Promo: ${order["promoCode"]} (-\$${((order["discount"] as double)).currency})",
                          style: TextStyle(
                            fontSize: 11,
                            color: successColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ],
              ),
            ),
          ],
          SizedBox(height: spMd),
          Row(
            children: [
              if (order["status"] == "ready") ...[
                Expanded(
                  child: QButton(
                    label: "Mark Picked Up",
                    icon: Icons.check,
                    size: bs.sm,
                    onPressed: () {
                      //navigateTo('MarkPickedUp')
                    },
                  ),
                ),
              ] else if (order["status"] == "preparing") ...[
                Expanded(
                  child: QButton(
                    label: "Mark Ready",
                    icon: Icons.restaurant,
                    size: bs.sm,
                    onPressed: () {
                      //navigateTo('MarkReady')
                    },
                  ),
                ),
              ] else if (order["status"] == "confirmed") ...[
                Expanded(
                  child: QButton(
                    label: "Start Preparing",
                    icon: Icons.play_arrow,
                    size: bs.sm,
                    onPressed: () {
                      //navigateTo('StartPreparing')
                    },
                  ),
                ),
              ] else ...[
                Expanded(
                  child: QButton(
                    label: "View Receipt",
                    icon: Icons.receipt,
                    size: bs.sm,
                    onPressed: () {
                      //navigateTo('ViewReceipt')
                    },
                  ),
                ),
              ],
              SizedBox(width: spSm),
              QButton(
                icon: Icons.phone,
                size: bs.sm,
                onPressed: () {
                  //navigateTo('CallCustomer')
                },
              ),
              SizedBox(width: spSm),
              QButton(
                icon: Icons.edit,
                size: bs.sm,
                onPressed: () {
                  //navigateTo('EditOrder')
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  List<Map<String, dynamic>> get filteredOrders {
    List<Map<String, dynamic>> filtered = List.from(takeawayOrders);
    
    // Apply filters
    if (selectedFilter != "all") {
      if (selectedFilter == "payment_pending") {
        filtered = filtered.where((order) => order["paymentStatus"] == "pending").toList();
      } else {
        filtered = filtered.where((order) => order["status"] == selectedFilter).toList();
      }
    }
    
    // Apply sorting
    switch (sortBy) {
      case "pickup_time":
        filtered.sort((a, b) => a["estimatedPickupTime"].compareTo(b["estimatedPickupTime"]));
        break;
      case "amount":
        filtered.sort((a, b) => (b["totalAmount"] as double).compareTo(a["totalAmount"] as double));
        break;
      case "status":
        filtered.sort((a, b) => a["status"].compareTo(b["status"]));
        break;
      default: // newest
        filtered.sort((a, b) => b["orderTime"].compareTo(a["orderTime"]));
    }
    
    return filtered;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Takeaway Orders"),
        actions: [
          IconButton(
            icon: Icon(Icons.print),
            onPressed: () {
              //navigateTo('PrintOrders')
            },
          ),
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {
              //navigateTo('OrderNotifications')
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            _buildTakeawayOverview(),
            _buildFilters(),
            Container(
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
                      Text(
                        "Takeaway Orders (${filteredOrders.length})",
                        style: TextStyle(
                          fontSize: fsH6,
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
                          //navigateTo('NewTakeawayOrder')
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: spMd),
                  if (filteredOrders.isEmpty)
                    Container(
                      padding: EdgeInsets.all(spMd),
                      child: Column(
                        children: [
                          Icon(
                            Icons.takeout_dining,
                            size: 64,
                            color: disabledColor,
                          ),
                          SizedBox(height: spSm),
                          Text(
                            "No takeaway orders found",
                            style: TextStyle(
                              fontSize: fsH6,
                              fontWeight: FontWeight.bold,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    )
                  else
                    Column(
                      children: filteredOrders.map((order) => _buildTakeawayOrderCard(order)).toList(),
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
