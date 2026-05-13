import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class FdaOrderTrackingView extends StatefulWidget {
  const FdaOrderTrackingView({super.key});

  @override
  State<FdaOrderTrackingView> createState() => _FdaOrderTrackingViewState();
}

class _FdaOrderTrackingViewState extends State<FdaOrderTrackingView> {
  Map<String, dynamic> orderData = {
    "id": "ORD-2024-001",
    "status": "out_for_delivery",
    "estimatedDelivery": "15:30",
    "currentTime": "15:15",
    "restaurant": {
      "name": "Burger Palace",
      "image": "https://picsum.photos/80/80?random=1&keyword=restaurant",
      "phone": "+1 (555) 123-4567",
      "address": "456 Food Street, Downtown",
    },
    "driver": {
      "name": "Mike Johnson",
      "image": "https://picsum.photos/80/80?random=2&keyword=driver",
      "phone": "+1 (555) 987-6543",
      "rating": 4.8,
      "vehicle": "Honda Civic - ABC 123",
      "location": {"lat": 37.7749, "lng": -122.4194},
    },
    "delivery": {
      "address": "123 Main St, Apt 4B, Downtown, NY 10001",
      "instructions": "Ring doorbell, leave at door if no answer",
      "type": "Standard Delivery",
    },
    "items": [
      {
        "name": "Classic Burger",
        "quantity": 2,
        "price": 9.99,
        "image": "https://picsum.photos/60/60?random=3&keyword=burger",
      },
      {
        "name": "French Fries",
        "quantity": 1,
        "price": 4.99,
        "image": "https://picsum.photos/60/60?random=4&keyword=fries",
      },
    ],
    "total": 24.99,
  };

  List<Map<String, dynamic>> statusSteps = [
    {
      "status": "order_placed",
      "title": "Order Placed",
      "description": "Your order has been confirmed",
      "time": "14:45",
      "icon": Icons.receipt,
      "completed": true,
    },
    {
      "status": "preparing",
      "title": "Preparing",
      "description": "Restaurant is preparing your order",
      "time": "14:50",
      "icon": Icons.restaurant,
      "completed": true,
    },
    {
      "status": "ready_for_pickup",
      "title": "Ready for Pickup",
      "description": "Order is ready, waiting for driver",
      "time": "15:10",
      "icon": Icons.check_circle,
      "completed": true,
    },
    {
      "status": "out_for_delivery",
      "title": "Out for Delivery",
      "description": "Driver is on the way to you",
      "time": "15:15",
      "icon": Icons.delivery_dining,
      "completed": true,
    },
    {
      "status": "delivered",
      "title": "Delivered",
      "description": "Order delivered successfully",
      "time": "15:30",
      "icon": Icons.home,
      "completed": false,
    },
  ];

  int currentStepIndex = 3; // Current step is "out_for_delivery"
  bool showMap = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Track Order"),
        actions: [
          QButton(
            icon: Icons.refresh,
            size: bs.sm,
            onPressed: () {
              ss("Refreshing order status...");
            },
          ),
          QButton(
            icon: Icons.share,
            size: bs.sm,
            onPressed: () {
              ss("Sharing tracking link...");
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Order Status Header
            _buildOrderStatusHeader(),

            // Map/Driver Section Toggle
            _buildMapDriverSection(),

            // Order Progress
            _buildOrderProgress(),

            // Order Details
            _buildOrderDetails(),

            // Action Buttons
            _buildActionButtons(),
          ],
        ),
      ),
    );
  }

  Widget _buildOrderStatusHeader() {
    String currentStatus = statusSteps[currentStepIndex]["title"];
    String currentDescription = statusSteps[currentStepIndex]["description"];
    
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [primaryColor, primaryColor.withAlpha(180)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        spacing: spSm,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(spXs),
                decoration: BoxDecoration(
                  color: Colors.white.withAlpha(50),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Icon(
                  statusSteps[currentStepIndex]["icon"],
                  color: Colors.white,
                  size: 24,
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      currentStatus,
                      style: TextStyle(
                        fontSize: fsH5,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      currentDescription,
                      style: TextStyle(
                        color: Colors.white.withAlpha(200),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white.withAlpha(30),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Row(
              children: [
                Icon(Icons.access_time, color: Colors.white, size: 20),
                SizedBox(width: spXs),
                Text(
                  "Estimated delivery: ${orderData["estimatedDelivery"]}",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Spacer(),
                Text(
                  "Order ${orderData["id"]}",
                  style: TextStyle(
                    color: Colors.white.withAlpha(200),
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMapDriverSection() {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          // Toggle Buttons
          Container(
            padding: EdgeInsets.all(spSm),
            child: Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      showMap = true;
                      setState(() {});
                    },
                    child: Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: showMap ? primaryColor : Colors.transparent,
                        borderRadius: BorderRadius.circular(radiusSm),
                        border: Border.all(
                          color: primaryColor,
                          width: 1,
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.map,
                            color: showMap ? Colors.white : primaryColor,
                            size: 20,
                          ),
                          SizedBox(width: spXs),
                          Text(
                            "Map View",
                            style: TextStyle(
                              color: showMap ? Colors.white : primaryColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      showMap = false;
                      setState(() {});
                    },
                    child: Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: !showMap ? primaryColor : Colors.transparent,
                        borderRadius: BorderRadius.circular(radiusSm),
                        border: Border.all(
                          color: primaryColor,
                          width: 1,
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.person,
                            color: !showMap ? Colors.white : primaryColor,
                            size: 20,
                          ),
                          SizedBox(width: spXs),
                          Text(
                            "Driver Info",
                            style: TextStyle(
                              color: !showMap ? Colors.white : primaryColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Content
          showMap ? _buildMapView() : _buildDriverInfo(),
        ],
      ),
    );
  }

  Widget _buildMapView() {
    return Container(
      height: 250,
      margin: EdgeInsets.symmetric(horizontal: spMd),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Stack(
        children: [
          // Map placeholder
          ClipRRect(
            borderRadius: BorderRadius.circular(radiusMd),
            child: Container(
              width: double.infinity,
              height: double.infinity,
              color: Colors.grey[300],
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.map, size: 60, color: primaryColor),
                    SizedBox(height: spXs),
                    Text(
                      "Live Tracking Map",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "Driver is 5 minutes away",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Driver location indicator
          Positioned(
            top: 20,
            right: 20,
            child: Container(
              padding: EdgeInsets.all(spXs),
              decoration: BoxDecoration(
                color: successColor,
                borderRadius: BorderRadius.circular(radiusXs),
                boxShadow: [shadowSm],
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.delivery_dining, color: Colors.white, size: 16),
                  SizedBox(width: 4),
                  Text(
                    "5 min away",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Live indicator
          Positioned(
            top: 20,
            left: 20,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 4),
              decoration: BoxDecoration(
                color: dangerColor,
                borderRadius: BorderRadius.circular(radiusXs),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                  ),
                  SizedBox(width: 4),
                  Text(
                    "LIVE",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDriverInfo() {
    Map<String, dynamic> driver = orderData["driver"];
    
    return Container(
      margin: EdgeInsets.symmetric(horizontal: spMd),
      padding: EdgeInsets.all(spSm),
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
              ClipRRect(
                borderRadius: BorderRadius.circular(radiusXs),
                child: Image.network(
                  "${driver["image"]}",
                  width: 60,
                  height: 60,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${driver["name"]}",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Row(
                      children: [
                        Icon(Icons.star, size: 14, color: warningColor),
                        SizedBox(width: 4),
                        Text(
                          "${driver["rating"]} rating",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledColor,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      "${driver["vehicle"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                children: [
                  QButton(
                    icon: Icons.phone,
                    size: bs.sm,
                    onPressed: () {
                      ss("Calling driver...");
                    },
                  ),
                  SizedBox(height: spXs),
                  QButton(
                    icon: Icons.message,
                    size: bs.sm,
                    onPressed: () {
                      ss("Opening chat...");
                    },
                  ),
                ],
              ),
            ],
          ),

          // Driver status
          Container(
            padding: EdgeInsets.all(spXs),
            decoration: BoxDecoration(
              color: successColor.withAlpha(10),
              borderRadius: BorderRadius.circular(radiusXs),
            ),
            child: Row(
              children: [
                Icon(Icons.navigation, color: successColor, size: 16),
                SizedBox(width: spXs),
                Text(
                  "Driver is 5 minutes away from your location",
                  style: TextStyle(
                    fontSize: 12,
                    color: successColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),

          // Delivery instructions
          Container(
            padding: EdgeInsets.all(spXs),
            decoration: BoxDecoration(
              color: Colors.blue[50],
              borderRadius: BorderRadius.circular(radiusXs),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.info_outline, color: infoColor, size: 16),
                SizedBox(width: spXs),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Delivery Instructions",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: infoColor,
                        ),
                      ),
                      Text(
                        "${orderData["delivery"]["instructions"]}",
                        style: TextStyle(
                          fontSize: 11,
                          color: infoColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOrderProgress() {
    return Container(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Text(
            "Order Progress",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
            ),
          ),
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              children: statusSteps.asMap().entries.map((entry) {
                int index = entry.key;
                Map<String, dynamic> step = entry.value;
                bool isCompleted = step["completed"];
                bool isCurrent = index == currentStepIndex;
                
                return Column(
                  children: [
                    Row(
                      children: [
                        // Step indicator
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: isCompleted
                                ? (isCurrent ? primaryColor : successColor)
                                : Colors.grey[200],
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            step["icon"],
                            color: isCompleted ? Colors.white : disabledColor,
                            size: 20,
                          ),
                        ),
                        SizedBox(width: spSm),
                        
                        // Step content
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${step["title"]}",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: isCompleted ? primaryColor : disabledBoldColor,
                                ),
                              ),
                              Text(
                                "${step["description"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        
                        // Time
                        Text(
                          "${step["time"]}",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: isCompleted ? primaryColor : disabledColor,
                          ),
                        ),
                      ],
                    ),
                    
                    // Connector line
                    if (index < statusSteps.length - 1)
                      Container(
                        margin: EdgeInsets.only(left: 20, top: spXs, bottom: spXs),
                        height: 30,
                        width: 2,
                        color: isCompleted ? successColor : Colors.grey[300],
                      ),
                  ],
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOrderDetails() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Text(
            "Order Details",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
            ),
          ),

          // Restaurant Info
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(radiusXs),
                  child: Image.network(
                    "${orderData["restaurant"]["image"]}",
                    width: 50,
                    height: 50,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${orderData["restaurant"]["name"]}",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "${orderData["restaurant"]["address"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledColor,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                QButton(
                  icon: Icons.phone,
                  size: bs.sm,
                  onPressed: () {
                    ss("Calling restaurant...");
                  },
                ),
              ],
            ),
          ),

          // Order Items
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spXs,
              children: [
                Text(
                  "Items (${(orderData["items"] as List).length})",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                ...(orderData["items"] as List).map((item) => 
                  Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(radiusXs),
                        child: Image.network(
                          "${item["image"]}",
                          width: 40,
                          height: 40,
                          fit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Text(
                          "${item["quantity"]}x ${item["name"]}",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Text(
                        "\$${((item["price"] as double).toStringAsFixed(2))}",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  )
                ).toList(),
                Divider(),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        "Total",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Text(
                      "\$${((orderData["total"] as double).toStringAsFixed(2))}",
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

          // Delivery Address
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.location_on, color: primaryColor, size: 20),
                SizedBox(width: spXs),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Delivery Address",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                      Text(
                        "${orderData["delivery"]["address"]}",
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons() {
    return Container(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spSm,
        children: [
          Row(
            children: [
              Expanded(
                child: QButton(
                  label: "Call Driver",
                  size: bs.md,
                  onPressed: () {
                    ss("Calling driver...");
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QButton(
                  label: "Message Driver",
                  size: bs.md,
                  onPressed: () {
                    ss("Opening chat...");
                  },
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: QButton(
                  label: "Report Issue",
                  size: bs.md,
                  onPressed: () {
                    // navigateTo('ReportIssueView')
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QButton(
                  label: "Get Help",
                  size: bs.md,
                  onPressed: () {
                    // navigateTo('HelpCenterView')
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
