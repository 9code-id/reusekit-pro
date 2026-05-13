import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class DlaDriverView extends StatefulWidget {
  const DlaDriverView({super.key});

  @override
  State<DlaDriverView> createState() => _DlaDriverViewState();
}

class _DlaDriverViewState extends State<DlaDriverView> {
  int currentTab = 0;
  bool isOnline = true;
  bool loading = false;

  Map<String, dynamic> driverProfile = {
    "name": "Mike Johnson",
    "photo": "https://picsum.photos/150/150?random=1&keyword=person",
    "rating": 4.8,
    "total_deliveries": 1250,
    "status": "active",
    "vehicle": "Motorcycle",
    "license_plate": "ABC 1234",
    "phone": "+1 234 567 8890",
    "join_date": "2023-01-15"
  };

  Map<String, dynamic> todayStats = {
    "deliveries_completed": 12,
    "total_earnings": 145.50,
    "average_rating": 4.9,
    "online_hours": 8.5,
    "distance_covered": 85.2
  };

  List<Map<String, dynamic>> pendingDeliveries = [
    {
      "id": "DL001",
      "customer": "John Smith",
      "address": "123 Main Street, Downtown",
      "package_type": "Electronics",
      "priority": "High",
      "estimated_time": "15 mins",
      "distance": "2.5 km",
      "payment": 25.0,
      "status": "assigned"
    },
    {
      "id": "DL002",
      "customer": "Sarah Wilson",
      "address": "456 Oak Avenue, Uptown",
      "package_type": "Documents",
      "priority": "Normal",
      "estimated_time": "25 mins",
      "distance": "4.1 km",
      "payment": 18.0,
      "status": "pickup_ready"
    },
  ];

  List<Map<String, dynamic>> recentDeliveries = [
    {
      "id": "DL098",
      "customer": "Emma Davis",
      "address": "789 Pine Street",
      "completed_at": "2024-01-15 16:30",
      "payment": 22.0,
      "rating": 5.0,
      "tip": 5.0
    },
    {
      "id": "DL097",
      "customer": "Robert Brown",
      "address": "321 Elm Road",
      "completed_at": "2024-01-15 15:45",
      "payment": 35.0,
      "rating": 4.5,
      "tip": 0.0
    },
  ];

  Widget _buildStatsCard(String title, String value, String subtitle, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusSm),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(spXs),
                decoration: BoxDecoration(
                  color: color.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Icon(
                  icon,
                  color: color,
                  size: 20,
                ),
              ),
              Spacer(),
              Text(
                value,
                style: TextStyle(
                  fontSize: fsH5,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Text(
            title,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: spXs),
          Text(
            subtitle,
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDeliveryCard(Map<String, dynamic> delivery, {bool isPending = true}) {
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusSm),
        boxShadow: [shadowSm],
        border: isPending ? Border.all(color: primaryColor.withAlpha(30)) : null,
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
                    Text(
                      isPending ? "Order #${delivery["id"]}" : "Completed #${delivery["id"]}",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "${delivery["customer"]}",
                      style: TextStyle(
                        color: primaryColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              if (isPending) ...[
                Container(
                  padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                  decoration: BoxDecoration(
                    color: delivery["priority"] == "High" ? dangerColor.withAlpha(20) : infoColor.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Text(
                    "${delivery["priority"]} Priority",
                    style: TextStyle(
                      fontSize: 10,
                      color: delivery["priority"] == "High" ? dangerColor : infoColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ] else ...[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: List.generate(5, (index) {
                        return Icon(
                          index < (delivery["rating"] as double) ? Icons.star : Icons.star_border,
                          color: index < (delivery["rating"] as double) ? warningColor : disabledColor,
                          size: 12,
                        );
                      }),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "${delivery["completed_at"]}".split(" ")[1],
                      style: TextStyle(
                        fontSize: 10,
                        color: disabledColor,
                      ),
                    ),
                  ],
                ),
              ],
            ],
          ),
          
          SizedBox(height: spSm),
          
          Row(
            children: [
              Icon(
                Icons.location_on,
                size: 14,
                color: primaryColor,
              ),
              SizedBox(width: spXs),
              Expanded(
                child: Text(
                  "${delivery["address"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ),
            ],
          ),
          
          SizedBox(height: spSm),
          
          Row(
            children: [
              if (isPending) ...[
                Row(
                  children: [
                    Icon(
                      Icons.schedule,
                      size: 14,
                      color: successColor,
                    ),
                    SizedBox(width: spXs),
                    Text(
                      "${delivery["estimated_time"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: successColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                SizedBox(width: spSm),
                Row(
                  children: [
                    Icon(
                      Icons.route,
                      size: 14,
                      color: infoColor,
                    ),
                    SizedBox(width: spXs),
                    Text(
                      "${delivery["distance"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: infoColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ],
              
              Spacer(),
              
              Text(
                "\$${(delivery["payment"] as double).toStringAsFixed(2)}",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: successColor,
                ),
              ),
              
              if (!isPending && (delivery["tip"] as double) > 0) ...[
                SizedBox(width: spXs),
                Text(
                  "+ \$${(delivery["tip"] as double).toStringAsFixed(2)}",
                  style: TextStyle(
                    fontSize: 12,
                    color: warningColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ],
          ),
          
          if (isPending) ...[
            SizedBox(height: spSm),
            Row(
              children: [
                Expanded(
                  child: QButton(
                    label: delivery["status"] == "assigned" ? "Start Pickup" : "Navigate",
                    size: bs.sm,
                    onPressed: () {},
                  ),
                ),
                SizedBox(width: spSm),
                QButton(
                  icon: Icons.phone,
                  size: bs.sm,
                  color: primaryColor,
                  onPressed: () {},
                ),
                SizedBox(width: spXs),
                QButton(
                  icon: Icons.message,
                  size: bs.sm,
                  color: infoColor,
                  onPressed: () {},
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildDashboardTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: isOnline ? successColor : dangerColor,
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Row(
              children: [
                Icon(
                  isOnline ? Icons.online_prediction : Icons.offline_bolt,
                  color: Colors.white,
                  size: 24,
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: Column(
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
                        isOnline ? "Ready to receive delivery requests" : "You won't receive new orders",
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.white70,
                        ),
                      ),
                    ],
                  ),
                ),
                QButton(
                  label: isOnline ? "Go Offline" : "Go Online",
                  color: Colors.white,
                  size: bs.sm,
                  onPressed: () {
                    isOnline = !isOnline;
                    setState(() {});
                  },
                ),
              ],
            ),
          ),
          
          SizedBox(height: spLg),
          
          Text(
            "Today's Performance",
            style: TextStyle(
              fontSize: fsH5,
              fontWeight: FontWeight.bold,
            ),
          ),
          
          SizedBox(height: spSm),
          
          ResponsiveGridView(
            minItemWidth: 150,
            children: [
              _buildStatsCard(
                "Deliveries",
                "${todayStats["deliveries_completed"]}",
                "Completed today",
                Icons.local_shipping,
                primaryColor
              ),
              _buildStatsCard(
                "Earnings",
                "\$${(todayStats["total_earnings"] as double).toStringAsFixed(0)}",
                "Today's total",
                Icons.attach_money,
                successColor
              ),
              _buildStatsCard(
                "Rating",
                "${(todayStats["average_rating"] as double).toStringAsFixed(1)}",
                "Average today",
                Icons.star,
                warningColor
              ),
              _buildStatsCard(
                "Hours",
                "${(todayStats["online_hours"] as double).toStringAsFixed(1)}h",
                "Online time",
                Icons.schedule,
                infoColor
              ),
            ],
          ),
          
          SizedBox(height: spLg),
          
          Row(
            children: [
              Text(
                "Pending Deliveries",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Spacer(),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: dangerColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusLg),
                ),
                child: Text(
                  "${pendingDeliveries.length} pending",
                  style: TextStyle(
                    fontSize: 12,
                    color: dangerColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          
          SizedBox(height: spSm),
          
          ...pendingDeliveries.map((delivery) => _buildDeliveryCard(delivery, isPending: true)).toList(),
          
          if (pendingDeliveries.isEmpty) ...[
            Container(
              padding: EdgeInsets.all(spLg),
              decoration: BoxDecoration(
                color: Colors.grey.shade50,
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Center(
                child: Column(
                  children: [
                    Icon(
                      Icons.inbox,
                      size: 48,
                      color: disabledColor,
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "No pending deliveries",
                      style: TextStyle(
                        fontSize: fsH6,
                        color: disabledBoldColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "New orders will appear here",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildHistoryTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Recent Deliveries",
            style: TextStyle(
              fontSize: fsH5,
              fontWeight: FontWeight.bold,
            ),
          ),
          
          SizedBox(height: spSm),
          
          ...recentDeliveries.map((delivery) => _buildDeliveryCard(delivery, isPending: false)).toList(),
        ],
      ),
    );
  }

  Widget _buildProfileTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Column(
              children: [
                CircleAvatar(
                  radius: 60,
                  backgroundImage: NetworkImage("${driverProfile["photo"]}"),
                ),
                SizedBox(height: spSm),
                Text(
                  "${driverProfile["name"]}",
                  style: TextStyle(
                    fontSize: fsH4,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: spXs),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: List.generate(5, (index) {
                        return Icon(
                          index < (driverProfile["rating"] as double) ? Icons.star : Icons.star_border,
                          color: index < (driverProfile["rating"] as double) ? warningColor : disabledColor,
                          size: 16,
                        );
                      }),
                    ),
                    SizedBox(width: spXs),
                    Text(
                      "${(driverProfile["rating"] as double).toStringAsFixed(1)} • ${driverProfile["total_deliveries"]} deliveries",
                      style: TextStyle(
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          
          SizedBox(height: spLg),
          
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusSm),
              boxShadow: [shadowSm],
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.directions_car,
                      color: primaryColor,
                      size: 20,
                    ),
                    SizedBox(width: spSm),
                    Text(
                      "Vehicle Information",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spSm),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        "Type: ${driverProfile["vehicle"]}",
                        style: TextStyle(
                          color: disabledBoldColor,
                        ),
                      ),
                    ),
                    Text(
                      "Plate: ${driverProfile["license_plate"]}",
                      style: TextStyle(
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          
          SizedBox(height: spSm),
          
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusSm),
              boxShadow: [shadowSm],
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.phone,
                      color: primaryColor,
                      size: 20,
                    ),
                    SizedBox(width: spSm),
                    Text(
                      "Contact Information",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spSm),
                Row(
                  children: [
                    Text(
                      "${driverProfile["phone"]}",
                      style: TextStyle(
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          
          SizedBox(height: spLg),
          
          Container(
            width: double.infinity,
            child: QButton(
              label: "Edit Profile",
              onPressed: () {},
            ),
          ),
          
          SizedBox(height: spSm),
          
          Container(
            width: double.infinity,
            child: QButton(
              label: "Settings",
              color: disabledBoldColor,
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Driver Dashboard",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Dashboard", icon: Icon(Icons.dashboard)),
        Tab(text: "History", icon: Icon(Icons.history)),
        Tab(text: "Profile", icon: Icon(Icons.person)),
      ],
      tabChildren: [
        _buildDashboardTab(),
        _buildHistoryTab(),
        _buildProfileTab(),
      ],
      onInit: (tabController) {},
    );
  }
}
