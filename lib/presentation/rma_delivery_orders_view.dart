import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class RmaDeliveryOrdersView extends StatefulWidget {
  const RmaDeliveryOrdersView({super.key});

  @override
  State<RmaDeliveryOrdersView> createState() => _RmaDeliveryOrdersViewState();
}

class _RmaDeliveryOrdersViewState extends State<RmaDeliveryOrdersView> {
  String selectedFilter = "all";
  String sortBy = "newest";
  bool showDetails = true;
  
  List<Map<String, dynamic>> deliveryOrders = [
    {
      "id": "DEL-001",
      "orderNumber": "#DL12001",
      "customerName": "Jennifer Martinez",
      "customerPhone": "+1-555-2001",
      "customerAddress": "123 Oak Street, Apt 4B, Downtown",
      "deliveryInstructions": "Ring doorbell twice, leave at door if no answer",
      "items": [
        {"name": "Large Pepperoni Pizza", "quantity": 2, "price": 18.99, "customizations": ["Extra cheese", "Thin crust"]},
        {"name": "Buffalo Wings", "quantity": 1, "price": 12.99, "customizations": ["Extra spicy"]},
        {"name": "Garlic Bread", "quantity": 1, "price": 5.99, "customizations": []},
        {"name": "Coca Cola", "quantity": 4, "price": 2.99, "customizations": ["Cold"]},
      ],
      "totalAmount": 67.94,
      "deliveryFee": 3.99,
      "tip": 8.50,
      "grandTotal": 80.43,
      "orderTime": "2024-03-15 17:30:00",
      "estimatedDeliveryTime": "2024-03-15 18:15:00",
      "actualDeliveryTime": null,
      "status": "preparing",
      "deliveryStatus": "assigned",
      "driverName": "Mike Johnson",
      "driverPhone": "+1-555-9001",
      "distance": 2.5,
      "paymentStatus": "paid",
      "paymentMethod": "card",
      "orderSource": "app",
      "preparationTime": 25,
    },
    {
      "id": "DEL-002",
      "orderNumber": "#DL12002",
      "customerName": "Robert Chen",
      "customerPhone": "+1-555-2002",
      "customerAddress": "456 Pine Avenue, House #22, Suburbs",
      "deliveryInstructions": "Call on arrival, dog in yard",
      "items": [
        {"name": "Chicken Teriyaki Bowl", "quantity": 2, "price": 14.99, "customizations": ["Extra sauce", "Brown rice"]},
        {"name": "Miso Soup", "quantity": 2, "price": 4.99, "customizations": []},
        {"name": "Green Tea", "quantity": 2, "price": 2.99, "customizations": ["Hot"]},
      ],
      "totalAmount": 37.95,
      "deliveryFee": 2.99,
      "tip": 5.00,
      "grandTotal": 45.94,
      "orderTime": "2024-03-15 18:00:00",
      "estimatedDeliveryTime": "2024-03-15 18:45:00",
      "actualDeliveryTime": "2024-03-15 18:42:00",
      "status": "completed",
      "deliveryStatus": "delivered",
      "driverName": "Sarah Davis",
      "driverPhone": "+1-555-9002",
      "distance": 1.8,
      "paymentStatus": "paid",
      "paymentMethod": "cash",
      "orderSource": "website",
      "preparationTime": 20,
    },
    {
      "id": "DEL-003",
      "orderNumber": "#DL12003",
      "customerName": "Lisa Thompson",
      "customerPhone": "+1-555-2003",
      "customerAddress": "789 Elm Drive, Unit 15C, Riverside",
      "deliveryInstructions": "Apartment building, buzz #15C, elevator to 3rd floor",
      "items": [
        {"name": "Fish & Chips", "quantity": 1, "price": 16.99, "customizations": ["Extra tartar sauce"]},
        {"name": "Onion Rings", "quantity": 1, "price": 6.99, "customizations": []},
        {"name": "Iced Tea", "quantity": 2, "price": 3.99, "customizations": ["Lemon", "No sugar"]},
      ],
      "totalAmount": 31.96,
      "deliveryFee": 4.99,
      "tip": 4.00,
      "grandTotal": 40.95,
      "orderTime": "2024-03-15 19:15:00",
      "estimatedDeliveryTime": "2024-03-15 20:00:00",
      "actualDeliveryTime": null,
      "status": "ready",
      "deliveryStatus": "picked_up",
      "driverName": "David Wilson",
      "driverPhone": "+1-555-9003",
      "distance": 3.2,
      "paymentStatus": "paid",
      "paymentMethod": "online",
      "orderSource": "phone",
      "preparationTime": 30,
    },
    {
      "id": "DEL-004",
      "orderNumber": "#DL12004",
      "customerName": "Mark Anderson",
      "customerPhone": "+1-555-2004",
      "customerAddress": "321 Maple Street, Apartment 2A, City Center",
      "deliveryInstructions": "Contactless delivery, leave by door",
      "items": [
        {"name": "BBQ Ribs Platter", "quantity": 1, "price": 24.99, "customizations": ["Extra BBQ sauce", "Coleslaw on side"]},
        {"name": "Mac & Cheese", "quantity": 1, "price": 8.99, "customizations": ["Extra cheese"]},
        {"name": "Cornbread", "quantity": 2, "price": 3.99, "customizations": []},
        {"name": "Beer", "quantity": 4, "price": 4.99, "customizations": []},
      ],
      "totalAmount": 57.93,
      "deliveryFee": 3.99,
      "tip": 10.00,
      "grandTotal": 71.92,
      "orderTime": "2024-03-15 16:45:00",
      "estimatedDeliveryTime": "2024-03-15 17:45:00",
      "actualDeliveryTime": null,
      "status": "confirmed",
      "deliveryStatus": "pending",
      "driverName": "Not Assigned",
      "driverPhone": "",
      "distance": 4.1,
      "paymentStatus": "paid",
      "paymentMethod": "card",
      "orderSource": "app",
      "preparationTime": 40,
    },
    {
      "id": "DEL-005",
      "orderNumber": "#DL12005",
      "customerName": "Emily Rodriguez",
      "customerPhone": "+1-555-2005",
      "customerAddress": "654 Cedar Lane, House #8, Westside",
      "deliveryInstructions": "Ring bell, wait for customer",
      "items": [
        {"name": "Vegetarian Pasta", "quantity": 1, "price": 15.99, "customizations": ["No cheese", "Extra vegetables"]},
        {"name": "Garden Salad", "quantity": 1, "price": 9.99, "customizations": ["Balsamic dressing"]},
        {"name": "Garlic Knots", "quantity": 6, "price": 7.99, "customizations": []},
        {"name": "Sparkling Water", "quantity": 2, "price": 2.99, "customizations": []},
      ],
      "totalAmount": 42.95,
      "deliveryFee": 2.99,
      "tip": 6.50,
      "grandTotal": 52.44,
      "orderTime": "2024-03-15 20:30:00",
      "estimatedDeliveryTime": "2024-03-15 21:15:00",
      "actualDeliveryTime": null,
      "status": "received",
      "deliveryStatus": "pending",
      "driverName": "Not Assigned",
      "driverPhone": "",
      "distance": 2.8,
      "paymentStatus": "pending",
      "paymentMethod": "cash",
      "orderSource": "app",
      "preparationTime": 35,
    },
  ];

  List<Map<String, dynamic>> filterOptions = [
    {"label": "All Deliveries", "value": "all"},
    {"label": "Received", "value": "received"},
    {"label": "Confirmed", "value": "confirmed"},
    {"label": "Preparing", "value": "preparing"},
    {"label": "Ready", "value": "ready"},
    {"label": "Out for Delivery", "value": "picked_up"},
    {"label": "Completed", "value": "completed"},
    {"label": "Payment Pending", "value": "payment_pending"},
  ];

  List<Map<String, dynamic>> sortOptions = [
    {"label": "Newest First", "value": "newest"},
    {"label": "Delivery Time", "value": "delivery_time"},
    {"label": "Distance", "value": "distance"},
    {"label": "Order Value", "value": "amount"},
  ];

  Widget _buildDeliveryOverview() {
    final totalOrders = deliveryOrders.length;
    final activeDeliveries = deliveryOrders.where((order) => 
        order["status"] != "completed" && order["deliveryStatus"] != "delivered").length;
    final totalRevenue = deliveryOrders.map((order) => order["grandTotal"] as double).reduce((a, b) => a + b);
    final avgDeliveryTime = deliveryOrders.where((order) => order["actualDeliveryTime"] != null).length > 0 ? 
        35.0 : 0.0; // Simplified calculation
    
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
            "Delivery Orders Overview",
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
                Icons.delivery_dining,
                primaryColor,
              ),
              _buildOverviewCard(
                "Active Deliveries",
                "$activeDeliveries",
                Icons.local_shipping,
                warningColor,
              ),
              _buildOverviewCard(
                "Total Revenue",
                "\$${totalRevenue.currency}",
                Icons.attach_money,
                successColor,
              ),
              _buildOverviewCard(
                "Avg Delivery Time",
                "${avgDeliveryTime.toStringAsFixed(0)} min",
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
                label: "Driver Status",
                icon: Icons.local_shipping,
                size: bs.sm,
                onPressed: () {
                  //navigateTo('DriverStatus')
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDeliveryOrderCard(Map<String, dynamic> order) {
    final statusColor = order["status"] == "completed" ? successColor :
                       order["status"] == "ready" ? warningColor :
                       order["status"] == "preparing" ? infoColor :
                       order["status"] == "confirmed" ? primaryColor : disabledBoldColor;
    
    final deliveryStatusColor = order["deliveryStatus"] == "delivered" ? successColor :
                               order["deliveryStatus"] == "picked_up" ? warningColor :
                               order["deliveryStatus"] == "assigned" ? infoColor : disabledBoldColor;

    final isOverdue = order["actualDeliveryTime"] == null && 
                     DateTime.parse(order["estimatedDeliveryTime"]).isBefore(DateTime.now());

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
                        SizedBox(width: spSm),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                          decoration: BoxDecoration(
                            color: deliveryStatusColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusLg),
                          ),
                          child: Text(
                            "${order["deliveryStatus"]}".replaceAll("_", " ").toUpperCase(),
                            style: TextStyle(
                              fontSize: 9,
                              fontWeight: FontWeight.bold,
                              color: deliveryStatusColor,
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
                    "\$${((order["grandTotal"] as double)).currency}",
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
                        "ETA: ${order["estimatedDeliveryTime"].substring(11, 16)}",
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
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: infoColor.withAlpha(10),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.location_on, color: infoColor, size: 16),
                    SizedBox(width: spSm),
                    Expanded(
                      child: Text(
                        "${order["customerAddress"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: infoColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Text(
                      "${(order["distance"] as double).toStringAsFixed(1)} km",
                      style: TextStyle(
                        fontSize: 11,
                        color: infoColor,
                      ),
                    ),
                  ],
                ),
                if (order["deliveryInstructions"] != "") ...[
                  SizedBox(height: spXs),
                  Text(
                    "📝 ${order["deliveryInstructions"]}",
                    style: TextStyle(
                      fontSize: 11,
                      color: infoColor,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
              ],
            ),
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (order["driverName"] != "Not Assigned") ...[
                      Row(
                        children: [
                          Icon(Icons.delivery_dining, color: primaryColor, size: 14),
                          SizedBox(width: spXs),
                          Text(
                            "Driver: ${order["driverName"]}",
                            style: TextStyle(
                              fontSize: 11,
                              color: primaryColor,
                            ),
                          ),
                          if (order["driverPhone"] != "") ...[
                            SizedBox(width: spSm),
                            Icon(Icons.phone, color: successColor, size: 12),
                            SizedBox(width: spXs),
                            Text(
                              "${order["driverPhone"]}",
                              style: TextStyle(
                                fontSize: 10,
                                color: successColor,
                              ),
                            ),
                          ],
                        ],
                      ),
                    ] else ...[
                      Row(
                        children: [
                          Icon(Icons.warning, color: dangerColor, size: 14),
                          SizedBox(width: spXs),
                          Text(
                            "No driver assigned",
                            style: TextStyle(
                              fontSize: 11,
                              color: dangerColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                    SizedBox(height: spXs),
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
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
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
                  if ((order["tip"] as double) > 0) ...[
                    SizedBox(height: spXs),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                      decoration: BoxDecoration(
                        color: successColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Text(
                        "Tip: \$${((order["tip"] as double)).currency}",
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: successColor,
                        ),
                      ),
                    ),
                  ],
                ],
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
                  Row(
                    children: [
                      Text(
                        "Order Items:",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Spacer(),
                      Text(
                        "Food: \$${((order["totalAmount"] as double)).currency} + Delivery: \$${((order["deliveryFee"] as double)).currency}",
                        style: TextStyle(
                          fontSize: 11,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
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
                ],
              ),
            ),
          ],
          SizedBox(height: spMd),
          Row(
            children: [
              if (order["driverName"] == "Not Assigned") ...[
                Expanded(
                  child: QButton(
                    label: "Assign Driver",
                    icon: Icons.person_add,
                    size: bs.sm,
                    onPressed: () {
                      //navigateTo('AssignDriver')
                    },
                  ),
                ),
              ] else if (order["deliveryStatus"] == "picked_up") ...[
                Expanded(
                  child: QButton(
                    label: "Track Delivery",
                    icon: Icons.gps_fixed,
                    size: bs.sm,
                    onPressed: () {
                      //navigateTo('TrackDelivery')
                    },
                  ),
                ),
              ] else if (order["status"] == "ready") ...[
                Expanded(
                  child: QButton(
                    label: "Ready for Pickup",
                    icon: Icons.check_circle,
                    size: bs.sm,
                    onPressed: () {
                      //navigateTo('ReadyForPickup')
                    },
                  ),
                ),
              ] else if (order["status"] == "completed") ...[
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
              ] else ...[
                Expanded(
                  child: QButton(
                    label: "Update Status",
                    icon: Icons.update,
                    size: bs.sm,
                    onPressed: () {
                      //navigateTo('UpdateStatus')
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
                icon: Icons.directions,
                size: bs.sm,
                onPressed: () {
                  //navigateTo('GetDirections')
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  List<Map<String, dynamic>> get filteredOrders {
    List<Map<String, dynamic>> filtered = List.from(deliveryOrders);
    
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
      case "delivery_time":
        filtered.sort((a, b) => a["estimatedDeliveryTime"].compareTo(b["estimatedDeliveryTime"]));
        break;
      case "distance":
        filtered.sort((a, b) => (a["distance"] as double).compareTo(b["distance"] as double));
        break;
      case "amount":
        filtered.sort((a, b) => (b["grandTotal"] as double).compareTo(a["grandTotal"] as double));
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
        title: Text("Delivery Orders"),
        actions: [
          IconButton(
            icon: Icon(Icons.map),
            onPressed: () {
              //navigateTo('DeliveryMap')
            },
          ),
          IconButton(
            icon: Icon(Icons.local_shipping),
            onPressed: () {
              //navigateTo('DriverManagement')
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            _buildDeliveryOverview(),
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
                        "Delivery Orders (${filteredOrders.length})",
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
                          //navigateTo('NewDeliveryOrder')
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
                            Icons.delivery_dining,
                            size: 64,
                            color: disabledColor,
                          ),
                          SizedBox(height: spSm),
                          Text(
                            "No delivery orders found",
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
                      children: filteredOrders.map((order) => _buildDeliveryOrderCard(order)).toList(),
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
