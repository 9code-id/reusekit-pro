import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class DlaHomeView extends StatefulWidget {
  const DlaHomeView({super.key});

  @override
  State<DlaHomeView> createState() => _DlaHomeViewState();
}

class _DlaHomeViewState extends State<DlaHomeView> {
  bool isOnline = false;
  String currentEarnings = "0.00";
  String todaysDeliveries = "0";
  String currentLocation = "New York, NY";
  
  List<Map<String, dynamic>> nearbyOrders = [
    {
      "id": "DL001",
      "restaurant": "Pizza Palace",
      "customer": "John Smith",
      "pickup": "123 Main St",
      "delivery": "456 Oak Ave",
      "distance": "2.3 km",
      "payment": 12.50,
      "tip": 3.00,
      "time": "15 min",
      "type": "food",
    },
    {
      "id": "DL002",
      "restaurant": "Burger Express",
      "customer": "Sarah Johnson",
      "pickup": "789 Pine St",
      "delivery": "321 Elm Dr",
      "distance": "1.8 km",
      "payment": 8.75,
      "tip": 2.50,
      "time": "12 min",
      "type": "food",
    },
    {
      "id": "DL003",
      "restaurant": "Coffee Corner",
      "customer": "Mike Davis",
      "pickup": "555 Market St",
      "delivery": "999 Broadway",
      "distance": "3.1 km",
      "payment": 6.25,
      "tip": 1.75,
      "time": "20 min",
      "type": "beverage",
    },
  ];
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header with Status
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    primaryColor,
                    primaryColor.withAlpha(200),
                  ],
                ),
              ),
              child: SafeArea(
                child: Column(
                  spacing: spMd,
                  children: [
                    // Top Bar
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Hello, Driver!",
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white.withAlpha(200),
                              ),
                            ),
                            Text(
                              currentLocation,
                              style: TextStyle(
                                fontSize: fsH6,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        
                        Row(
                          children: [
                            IconButton(
                              onPressed: () {
                                // Open notifications
                              },
                              icon: Icon(
                                Icons.notifications,
                                color: Colors.white,
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                // Open profile menu
                              },
                              icon: Icon(
                                Icons.person,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    
                    // Online/Offline Toggle
                    Container(
                      padding: EdgeInsets.all(spMd),
                      decoration: BoxDecoration(
                        color: Colors.white.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusMd),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                isOnline ? "You're Online" : "You're Offline",
                                style: TextStyle(
                                  fontSize: fsH6,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                isOnline 
                                  ? "Ready to receive orders"
                                  : "Turn on to start receiving orders",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.white.withAlpha(200),
                                ),
                              ),
                            ],
                          ),
                          
                          Switch(
                            value: isOnline,
                            onChanged: (value) {
                              isOnline = value;
                              setState(() {});
                              if (value) {
                                ss("You're now online and ready for orders!");
                              } else {
                                ss("You're now offline");
                              }
                            },
                            activeColor: successColor,
                            inactiveThumbColor: Colors.white.withAlpha(150),
                          ),
                        ],
                      ),
                    ),
                    
                    // Today's Stats
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.all(spMd),
                            decoration: BoxDecoration(
                              color: Colors.white.withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusMd),
                            ),
                            child: Column(
                              children: [
                                Text(
                                  "\$$currentEarnings",
                                  style: TextStyle(
                                    fontSize: fsH4,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                Text(
                                  "Today's Earnings",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.white.withAlpha(200),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        
                        SizedBox(width: spSm),
                        
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.all(spMd),
                            decoration: BoxDecoration(
                              color: Colors.white.withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusMd),
                            ),
                            child: Column(
                              children: [
                                Text(
                                  todaysDeliveries,
                                  style: TextStyle(
                                    fontSize: fsH4,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                Text(
                                  "Deliveries",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.white.withAlpha(200),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            
            // Quick Actions
            Container(
              padding: EdgeInsets.all(spMd),
              child: Column(
                spacing: spMd,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Quick Actions",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  
                  Row(
                    children: [
                      Expanded(
                        child: _buildQuickAction(
                          icon: Icons.location_on,
                          title: "My Location",
                          subtitle: "Update location",
                          onTap: () {},
                        ),
                      ),
                      
                      SizedBox(width: spSm),
                      
                      Expanded(
                        child: _buildQuickAction(
                          icon: Icons.history,
                          title: "Order History",
                          subtitle: "View past orders",
                          onTap: () {},
                        ),
                      ),
                    ],
                  ),
                  
                  Row(
                    children: [
                      Expanded(
                        child: _buildQuickAction(
                          icon: Icons.account_balance_wallet,
                          title: "Earnings",
                          subtitle: "View earnings",
                          onTap: () {},
                        ),
                      ),
                      
                      SizedBox(width: spSm),
                      
                      Expanded(
                        child: _buildQuickAction(
                          icon: Icons.support_agent,
                          title: "Support",
                          subtitle: "Get help",
                          onTap: () {},
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            
            // Available Orders
            if (isOnline) ...[
              Container(
                padding: EdgeInsets.all(spMd),
                child: Column(
                  spacing: spMd,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Available Orders",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        
                        GestureDetector(
                          onTap: () {
                            // Refresh orders
                            ss("Orders refreshed");
                          },
                          child: Icon(
                            Icons.refresh,
                            color: primaryColor,
                            size: 20,
                          ),
                        ),
                      ],
                    ),
                    
                    ...nearbyOrders.map((order) => _buildOrderCard(order)),
                  ],
                ),
              ),
            ] else ...[
              Container(
                padding: EdgeInsets.all(spMd),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(sp2xl),
                  decoration: BoxDecoration(
                    color: Colors.grey.withAlpha(10),
                    borderRadius: BorderRadius.circular(radiusMd),
                  ),
                  child: Column(
                    children: [
                      Icon(
                        Icons.power_settings_new,
                        size: 60,
                        color: disabledBoldColor,
                      ),
                      SizedBox(height: spMd),
                      Text(
                        "You're Currently Offline",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: disabledBoldColor,
                        ),
                      ),
                      SizedBox(height: spSm),
                      Text(
                        "Turn on your availability to start receiving delivery orders in your area.",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
  
  Widget _buildQuickAction({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(spMd),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(radiusMd),
          boxShadow: [shadowSm],
        ),
        child: Column(
          children: [
            Icon(
              icon,
              color: primaryColor,
              size: 30,
            ),
            SizedBox(height: spSm),
            Text(
              title,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: primaryColor,
              ),
            ),
            Text(
              subtitle,
              style: TextStyle(
                fontSize: 12,
                color: disabledBoldColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildOrderCard(Map<String, dynamic> order) {
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
        border: Border.all(color: primaryColor.withAlpha(30)),
      ),
      child: Column(
        spacing: spSm,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "#${order["id"]}",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: 4),
                decoration: BoxDecoration(
                  color: successColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Text(
                  "\$${((order["payment"] as double) + (order["tip"] as double)).toStringAsFixed(2)}",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: successColor,
                  ),
                ),
              ),
            ],
          ),
          
          Row(
            children: [
              Icon(
                order["type"] == "food" ? Icons.restaurant : Icons.local_cafe,
                color: primaryColor,
                size: 16,
              ),
              SizedBox(width: spXs),
              Expanded(
                child: Text(
                  "${order["restaurant"]}",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Text(
                "${order["distance"]} • ${order["time"]}",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
          
          Column(
            spacing: spXs,
            children: [
              Row(
                children: [
                  Icon(Icons.store, color: successColor, size: 14),
                  SizedBox(width: spXs),
                  Expanded(
                    child: Text(
                      "Pickup: ${order["pickup"]}",
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
                  Icon(Icons.location_on, color: dangerColor, size: 14),
                  SizedBox(width: spXs),
                  Expanded(
                    child: Text(
                      "Delivery: ${order["delivery"]}",
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
          
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () {
                    // Decline order
                  },
                  style: OutlinedButton.styleFrom(
                    foregroundColor: dangerColor,
                    side: BorderSide(color: dangerColor),
                    padding: EdgeInsets.symmetric(vertical: spSm),
                  ),
                  child: Text("Decline"),
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QButton(
                  label: "Accept",
                  size: bs.sm,
                  onPressed: () {
                    // Accept order
                    ss("Order accepted!");
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
