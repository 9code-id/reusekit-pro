import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class FdaDeliveryMapView extends StatefulWidget {
  const FdaDeliveryMapView({super.key});

  @override
  State<FdaDeliveryMapView> createState() => _FdaDeliveryMapViewState();
}

class _FdaDeliveryMapViewState extends State<FdaDeliveryMapView> {
  bool isTrackingActive = true;
  String deliveryStatus = "On the way";
  int estimatedTime = 15;
  String driverName = "John Smith";
  String driverPhone = "+1 234 567 8900";
  double driverRating = 4.8;
  
  final Map<String, dynamic> orderDetails = {
    "orderId": "#FD2024001",
    "restaurant": "Pizza Palace",
    "items": [
      {"name": "Margherita Pizza", "qty": 1, "price": 24.99},
      {"name": "Garlic Bread", "qty": 2, "price": 8.99},
      {"name": "Coca Cola", "qty": 2, "price": 4.99},
    ],
    "total": 38.97,
    "deliveryFee": 2.99,
    "tax": 3.12,
    "grandTotal": 45.08,
  };

  final List<Map<String, dynamic>> trackingSteps = [
    {
      "title": "Order Confirmed",
      "time": "2:30 PM",
      "status": "completed",
      "icon": Icons.check_circle,
    },
    {
      "title": "Preparing Food",
      "time": "2:35 PM", 
      "status": "completed",
      "icon": Icons.restaurant,
    },
    {
      "title": "Out for Delivery",
      "time": "2:45 PM",
      "status": "active",
      "icon": Icons.delivery_dining,
    },
    {
      "title": "Delivered",
      "time": "Est. 3:00 PM",
      "status": "pending",
      "icon": Icons.home,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Track Delivery"),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              _refreshLocation();
            },
          ),
          IconButton(
            icon: Icon(Icons.more_vert),
            onPressed: () {
              _showMoreOptions();
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          // Map View
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage("https://picsum.photos/800/1200?random=1&keyword=map"),
                fit: BoxFit.cover,
              ),
            ),
            child: Stack(
              children: [
                // Restaurant Marker
                Positioned(
                  top: 150,
                  left: 80,
                  child: _buildMapMarker(
                    icon: Icons.restaurant,
                    color: successColor,
                    label: "Pizza Palace",
                  ),
                ),
                
                // Driver Marker  
                Positioned(
                  top: 300,
                  left: 200,
                  child: _buildMapMarker(
                    icon: Icons.delivery_dining,
                    color: primaryColor,
                    label: driverName,
                    isDriver: true,
                  ),
                ),
                
                // Destination Marker
                Positioned(
                  top: 450,
                  right: 60,
                  child: _buildMapMarker(
                    icon: Icons.home,
                    color: dangerColor,
                    label: "Your Location",
                  ),
                ),
                
                // Route Line
                Positioned(
                  top: 160,
                  left: 90,
                  child: Container(
                    width: 2,
                    height: 300,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [successColor, primaryColor, dangerColor],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          
          // Top Info Card
          Positioned(
            top: 20,
            left: spMd,
            right: spMd,
            child: Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowMd],
              ),
              child: Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: successColor,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(Icons.timer, color: Colors.white, size: 20),
                  ),
                  
                  SizedBox(width: spSm),
                  
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Estimated Delivery",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                        
                        Text(
                          "$estimatedTime minutes",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                    decoration: BoxDecoration(
                      color: successColor.withAlpha(25),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Text(
                      deliveryStatus,
                      style: TextStyle(
                        fontSize: 12,
                        color: successColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          
          // Bottom Sheet
          DraggableScrollableSheet(
            initialChildSize: 0.35,
            minChildSize: 0.35,
            maxChildSize: 0.8,
            builder: (context, scrollController) {
              return Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(radiusXl)),
                  boxShadow: [shadowXl],
                ),
                child: SingleChildScrollView(
                  controller: scrollController,
                  padding: EdgeInsets.all(spMd),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Drag Handle
                      Center(
                        child: Container(
                          width: 40,
                          height: 4,
                          decoration: BoxDecoration(
                            color: disabledColor,
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                        ),
                      ),
                      
                      SizedBox(height: spMd),
                      
                      // Driver Info
                      Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: primaryColor.withAlpha(12),
                          borderRadius: BorderRadius.circular(radiusMd),
                        ),
                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: 25,
                              backgroundImage: NetworkImage(
                                "https://picsum.photos/100/100?random=2&keyword=driver",
                              ),
                            ),
                            
                            SizedBox(width: spSm),
                            
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Your Driver",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                  
                                  Text(
                                    driverName,
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  
                                  Row(
                                    children: [
                                      Icon(Icons.star, color: warningColor, size: 14),
                                      SizedBox(width: spXs),
                                      Text(
                                        "$driverRating",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                      SizedBox(width: spSm),
                                      Text(
                                        "• 2.5 km away",
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
                            
                            Row(
                              children: [
                                Container(
                                  width: 40,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    color: successColor,
                                    shape: BoxShape.circle,
                                  ),
                                  child: IconButton(
                                    icon: Icon(Icons.call, color: Colors.white, size: 20),
                                    onPressed: () {
                                      _callDriver();
                                    },
                                  ),
                                ),
                                
                                SizedBox(width: spSm),
                                
                                Container(
                                  width: 40,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    color: primaryColor,
                                    shape: BoxShape.circle,
                                  ),
                                  child: IconButton(
                                    icon: Icon(Icons.message, color: Colors.white, size: 20),
                                    onPressed: () {
                                      _messageDriver();
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      
                      SizedBox(height: spLg),
                      
                      // Order Tracking
                      Text(
                        "Order Tracking",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      
                      SizedBox(height: spSm),
                      
                      ...List.generate(trackingSteps.length, (index) {
                        final step = trackingSteps[index];
                        final isLast = index == trackingSteps.length - 1;
                        
                        return Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              children: [
                                Container(
                                  width: 40,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    color: _getStepColor(step["status"]),
                                    shape: BoxShape.circle,
                                  ),
                                  child: Icon(
                                    step["icon"],
                                    color: Colors.white,
                                    size: 20,
                                  ),
                                ),
                                
                                if (!isLast)
                                  Container(
                                    width: 2,
                                    height: 40,
                                    color: step["status"] == "completed" 
                                        ? successColor 
                                        : disabledColor,
                                    margin: EdgeInsets.symmetric(vertical: spXs),
                                  ),
                              ],
                            ),
                            
                            SizedBox(width: spSm),
                            
                            Expanded(
                              child: Padding(
                                padding: EdgeInsets.only(top: 8, bottom: spSm),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "${step["title"]}",
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: step["status"] == "pending" 
                                            ? disabledBoldColor 
                                            : primaryColor,
                                      ),
                                    ),
                                    
                                    Text(
                                      "${step["time"]}",
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
                        );
                      }),
                      
                      SizedBox(height: spLg),
                      
                      // Order Summary
                      Text(
                        "Order Summary",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      
                      SizedBox(height: spSm),
                      
                      Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(radiusMd),
                          border: Border.all(color: disabledOutlineBorderColor),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  "${orderDetails["orderId"]}",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                
                                Spacer(),
                                
                                Text(
                                  "From: ${orderDetails["restaurant"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                            
                            SizedBox(height: spSm),
                            
                            ...(orderDetails["items"] as List).map<Widget>((item) {
                              return Padding(
                                padding: EdgeInsets.only(bottom: spXs),
                                child: Row(
                                  children: [
                                    Text(
                                      "${item["qty"]}x ${item["name"]}",
                                      style: TextStyle(fontSize: 13),
                                    ),
                                    
                                    Spacer(),
                                    
                                    Text(
                                      "\$${(item["price"] as double).toStringAsFixed(2)}",
                                      style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }).toList(),
                            
                            Divider(),
                            
                            Row(
                              children: [
                                Text(
                                  "Total",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                
                                Spacer(),
                                
                                Text(
                                  "\$${(orderDetails["grandTotal"] as double).toStringAsFixed(2)}",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      
                      SizedBox(height: spLg),
                      
                      // Action Buttons
                      Row(
                        children: [
                          Expanded(
                            child: QButton(
                              label: "Cancel Order",
                              size: bs.md,
                              onPressed: () {
                                _cancelOrder();
                              },
                            ),
                          ),
                          
                          SizedBox(width: spSm),
                          
                          Expanded(
                            child: QButton(
                              label: "Get Help",
                              size: bs.md,
                              onPressed: () {
                                _getHelp();
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildMapMarker({
    required IconData icon,
    required Color color,
    required String label,
    bool isDriver = false,
  }) {
    return Column(
      children: [
        Stack(
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: color,
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white, width: 3),
                boxShadow: [shadowMd],
              ),
              child: Icon(icon, color: Colors.white, size: 24),
            ),
            
            if (isDriver)
              Positioned(
                right: 0,
                bottom: 0,
                child: Container(
                  width: 16,
                  height: 16,
                  decoration: BoxDecoration(
                    color: successColor,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 2),
                  ),
                ),
              ),
          ],
        ),
        
        SizedBox(height: spXs),
        
        Container(
          padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(radiusSm),
            boxShadow: [shadowSm],
          ),
          child: Text(
            label,
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w600,
              color: primaryColor,
            ),
          ),
        ),
      ],
    );
  }

  Color _getStepColor(String status) {
    switch (status) {
      case "completed":
        return successColor;
      case "active":
        return primaryColor;
      case "pending":
        return disabledColor;
      default:
        return disabledColor;
    }
  }

  void _refreshLocation() {
    ss("Location refreshed");
  }

  void _showMoreOptions() {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: EdgeInsets.all(spLg),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: Icon(Icons.share),
              title: Text("Share Live Location"),
              onTap: () {
                Navigator.pop(context);
                ss("Live location shared");
              },
            ),
            
            ListTile(
              leading: Icon(Icons.report),
              title: Text("Report Issue"),
              onTap: () {
                Navigator.pop(context);
                _reportIssue();
              },
            ),
            
            ListTile(
              leading: Icon(Icons.settings),
              title: Text("Delivery Preferences"),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  void _callDriver() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Call Driver"),
        content: Text("Do you want to call $driverName at $driverPhone?"),
        actions: [
          QButton(
            label: "Cancel",
            size: bs.sm,
            onPressed: () => Navigator.pop(context),
          ),
          QButton(
            label: "Call",
            size: bs.sm,
            onPressed: () {
              Navigator.pop(context);
              ss("Calling $driverName...");
            },
          ),
        ],
      ),
    );
  }

  void _messageDriver() {
    ss("Opening chat with $driverName");
  }

  void _cancelOrder() async {
    bool isConfirmed = await confirm("Are you sure you want to cancel this order?");
    if (isConfirmed) {
      ss("Order cancellation request sent");
    }
  }

  void _getHelp() {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: EdgeInsets.all(spLg),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "How can we help?",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
              ),
            ),
            
            SizedBox(height: spMd),
            
            ListTile(
              leading: Icon(Icons.chat),
              title: Text("Chat with Support"),
              onTap: () {
                Navigator.pop(context);
                ss("Opening support chat");
              },
            ),
            
            ListTile(
              leading: Icon(Icons.call),
              title: Text("Call Support"),
              onTap: () {
                Navigator.pop(context);
                ss("Calling support...");
              },
            ),
            
            ListTile(
              leading: Icon(Icons.help),
              title: Text("View FAQ"),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  void _reportIssue() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Report Issue"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: Text("Driver is late"),
              onTap: () {
                Navigator.pop(context);
                ss("Issue reported: Driver is late");
              },
            ),
            ListTile(
              title: Text("Wrong delivery address"),
              onTap: () {
                Navigator.pop(context);
                ss("Issue reported: Wrong delivery address");
              },
            ),
            ListTile(
              title: Text("Food quality issue"),
              onTap: () {
                Navigator.pop(context);
                ss("Issue reported: Food quality issue");
              },
            ),
            ListTile(
              title: Text("Other issue"),
              onTap: () {
                Navigator.pop(context);
                ss("Issue report form opened");
              },
            ),
          ],
        ),
      ),
    );
  }
}
