import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class HhaGuestDashboardView extends StatefulWidget {
  const HhaGuestDashboardView({super.key});

  @override
  State<HhaGuestDashboardView> createState() => _HhaGuestDashboardViewState();
}

class _HhaGuestDashboardViewState extends State<HhaGuestDashboardView> {
  int currentTab = 0;

  // Guest Info
  Map<String, dynamic> guestInfo = {
    "name": "Mr. John Smith",
    "room": "205",
    "roomType": "Deluxe Suite",
    "checkIn": "2024-06-15",
    "checkOut": "2024-06-18",
    "nights": 3,
    "guests": 2,
    "loyalty": "Gold Member",
  };

  // Room Services
  List<Map<String, dynamic>> roomServices = [
    {
      "title": "Room Service",
      "description": "Order food and beverages",
      "icon": Icons.room_service,
      "color": Colors.orange,
      "available": true,
    },
    {
      "title": "Housekeeping",
      "description": "Request cleaning service",
      "icon": Icons.cleaning_services,
      "color": Colors.blue,
      "available": true,
    },
    {
      "title": "Maintenance",
      "description": "Report room issues",
      "icon": Icons.build,
      "color": Colors.red,
      "available": true,
    },
    {
      "title": "Concierge",
      "description": "Get local recommendations",
      "icon": Icons.support_agent,
      "color": Colors.green,
      "available": true,
    },
  ];

  // Hotel Amenities
  List<Map<String, dynamic>> amenities = [
    {
      "name": "Fitness Center",
      "hours": "6:00 AM - 10:00 PM",
      "location": "2nd Floor",
      "status": "open",
      "icon": Icons.fitness_center,
    },
    {
      "name": "Swimming Pool",
      "hours": "7:00 AM - 9:00 PM",
      "location": "Rooftop",
      "status": "open",
      "icon": Icons.pool,
    },
    {
      "name": "Restaurant", 
      "hours": "7:00 AM - 11:00 PM",
      "location": "Ground Floor",
      "status": "open",
      "icon": Icons.restaurant,
    },
    {
      "name": "Spa & Wellness",
      "hours": "9:00 AM - 8:00 PM",
      "location": "3rd Floor",
      "status": "closed",
      "icon": Icons.spa,
    },
  ];

  // Recent Orders/Requests
  List<Map<String, dynamic>> recentOrders = [
    {
      "service": "Room Service",
      "item": "Continental Breakfast",
      "time": "8:30 AM",
      "status": "delivered",
      "amount": 45.00,
    },
    {
      "service": "Housekeeping",
      "item": "Extra towels",
      "time": "10:15 AM",
      "status": "completed",
      "amount": 0.00,
    },
    {
      "service": "Concierge",
      "item": "Restaurant reservation",
      "time": "2:30 PM",
      "status": "confirmed",
      "amount": 0.00,
    },
  ];

  // Local Weather
  Map<String, dynamic> weather = {
    "location": "New York City",
    "temperature": "24°C",
    "condition": "Sunny",
    "icon": Icons.wb_sunny,
    "humidity": "65%",
    "windSpeed": "12 km/h",
  };

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Welcome, ${guestInfo["name"].toString().split(' ').last}",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Dashboard", icon: Icon(Icons.dashboard)),
        Tab(text: "Services", icon: Icon(Icons.room_service)),
        Tab(text: "Amenities", icon: Icon(Icons.pool)),
        Tab(text: "Account", icon: Icon(Icons.person)),
      ],
      tabChildren: [
        _buildDashboardTab(),
        _buildServicesTab(),
        _buildAmenitiesTab(),
        _buildAccountTab(),
      ],
    );
  }

  Widget _buildDashboardTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Welcome Section with Room Info
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [primaryColor, primaryColor.withAlpha(200)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(radiusMd),
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
                            "Welcome back!",
                            style: TextStyle(
                              fontSize: fsH5,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "${guestInfo["name"]}",
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white.withAlpha(220),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: Colors.white.withAlpha(50),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Icon(
                        Icons.hotel,
                        color: Colors.white,
                        size: 32,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spSm),
                Divider(color: Colors.white.withAlpha(100)),
                SizedBox(height: spSm),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Room ${guestInfo["room"]}",
                            style: TextStyle(
                              fontSize: fsH4,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            "${guestInfo["roomType"]}",
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.white.withAlpha(220),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: spSm,
                        vertical: spXs,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white.withAlpha(50),
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Text(
                        "${guestInfo["loyalty"]}",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Stay Information
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
                Text(
                  "Your Stay",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spSm),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          Icon(
                            Icons.login,
                            color: primaryColor,
                            size: 24,
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "Check-in",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          Text(
                            "${guestInfo["checkIn"]}",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: primaryColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: 1,
                      height: 50,
                      color: disabledOutlineBorderColor,
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          Icon(
                            Icons.logout,
                            color: primaryColor,
                            size: 24,
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "Check-out",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          Text(
                            "${guestInfo["checkOut"]}",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: primaryColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: 1,
                      height: 50,
                      color: disabledOutlineBorderColor,
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          Icon(
                            Icons.nights_stay,
                            color: primaryColor,
                            size: 24,
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "Nights",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          Text(
                            "${guestInfo["nights"]}",
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
              ],
            ),
          ),

          // Weather Information
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.orange.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Icon(
                    weather["icon"],
                    color: Colors.orange,
                    size: 32,
                  ),
                ),
                SizedBox(width: spMd),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            "${weather["temperature"]}",
                            style: TextStyle(
                              fontSize: fsH4,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          SizedBox(width: spSm),
                          Text(
                            "${weather["condition"]}",
                            style: TextStyle(
                              fontSize: 16,
                              color: primaryColor,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        "${weather["location"]}",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      "Humidity: ${weather["humidity"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "Wind: ${weather["windSpeed"]}",
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

          // Recent Activity
          Text(
            "Recent Activity",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              children: recentOrders.asMap().entries.map((entry) {
                int index = entry.key;
                Map<String, dynamic> order = entry.value;
                return Container(
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    border: index < recentOrders.length - 1
                        ? Border(
                            bottom: BorderSide(
                              color: disabledOutlineBorderColor,
                            ),
                          )
                        : null,
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: order["status"] == "delivered" || order["status"] == "completed"
                              ? successColor.withAlpha(20)
                              : order["status"] == "confirmed"
                                  ? primaryColor.withAlpha(20)
                                  : warningColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Icon(
                          order["status"] == "delivered" || order["status"] == "completed"
                              ? Icons.check_circle
                              : order["status"] == "confirmed"
                                  ? Icons.confirmation_number
                                  : Icons.pending,
                          color: order["status"] == "delivered" || order["status"] == "completed"
                              ? successColor
                              : order["status"] == "confirmed"
                                  ? primaryColor
                                  : warningColor,
                          size: 20,
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${order["item"]}",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              "${order["service"]} • ${order["time"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      if ((order["amount"] as double) > 0)
                        Text(
                          "\$${((order["amount"] as double).toDouble()).toStringAsFixed(2)}",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: primaryColor,
                          ),
                        ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildServicesTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Room Services",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: roomServices.map((service) {
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
                    Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: (service["color"] as Color).withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Icon(
                        service["icon"],
                        color: service["color"],
                        size: 32,
                      ),
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "${service["title"]}",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "${service["description"]}",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(height: spMd),
                    Container(
                      width: double.infinity,
                      child: QButton(
                        label: service["available"] ? "Request Service" : "Unavailable",
                        size: bs.sm,
                        onPressed: service["available"] ? () {
                          ss("${service["title"]} request submitted");
                        } : null,
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),

          // Quick Contact
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
                Text(
                  "Need Help?",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spSm),
                Text(
                  "Our team is available 24/7 to assist you",
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                  ),
                ),
                SizedBox(height: spMd),
                Row(
                  children: [
                    Expanded(
                      child: QButton(
                        label: "Call Front Desk",
                        icon: Icons.call,
                        size: bs.sm,
                        onPressed: () {
                          si("Calling front desk...");
                        },
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: QButton(
                        label: "Send Message",
                        icon: Icons.message,
                        size: bs.sm,
                        onPressed: () {
                          si("Opening message center");
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

  Widget _buildAmenitiesTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Hotel Amenities",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          ...amenities.map((amenity) {
            return Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
                border: Border(
                  left: BorderSide(
                    width: 4,
                    color: amenity["status"] == "open"
                        ? successColor
                        : dangerColor,
                  ),
                ),
              ),
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: primaryColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Icon(
                      amenity["icon"],
                      color: primaryColor,
                      size: 32,
                    ),
                  ),
                  SizedBox(width: spMd),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                "${amenity["name"]}",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: spSm,
                                vertical: spXs,
                              ),
                              decoration: BoxDecoration(
                                color: amenity["status"] == "open"
                                    ? successColor.withAlpha(20)
                                    : dangerColor.withAlpha(20),
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Text(
                                "${amenity["status"]}".toUpperCase(),
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: amenity["status"] == "open"
                                      ? successColor
                                      : dangerColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: spXs),
                        Row(
                          children: [
                            Icon(
                              Icons.access_time,
                              size: 16,
                              color: disabledBoldColor,
                            ),
                            SizedBox(width: spXs),
                            Text(
                              "${amenity["hours"]}",
                              style: TextStyle(
                                fontSize: 14,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.location_on,
                              size: 16,
                              color: disabledBoldColor,
                            ),
                            SizedBox(width: spXs),
                            Text(
                              "${amenity["location"]}",
                              style: TextStyle(
                                fontSize: 14,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  if (amenity["status"] == "open")
                    QButton(
                      label: "Book",
                      size: bs.sm,
                      onPressed: () {
                        ss("${amenity["name"]} booking request sent");
                      },
                    ),
                ],
              ),
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildAccountTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Guest Profile
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
                    Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        color: primaryColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusLg),
                      ),
                      child: Icon(
                        Icons.person,
                        color: primaryColor,
                        size: 32,
                      ),
                    ),
                    SizedBox(width: spMd),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${guestInfo["name"]}",
                            style: TextStyle(
                              fontSize: fsH5,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          SizedBox(height: spXs),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: spSm,
                              vertical: spXs,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.orange.withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Text(
                              "${guestInfo["loyalty"]}",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: Colors.orange,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spMd),
                Divider(),
                SizedBox(height: spSm),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Current Stay",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                          Text(
                            "Room ${guestInfo["room"]} • ${guestInfo["nights"]} nights",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: primaryColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Account Actions
          Text(
            "Account Settings",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              children: [
                _buildAccountOption(
                  "Update Profile",
                  "Edit personal information",
                  Icons.edit,
                  () {
                    si("Profile update coming soon");
                  },
                ),
                _buildAccountOption(
                  "Billing & Payments",
                  "View charges and payment methods",
                  Icons.payment,
                  () {
                    si("Billing information coming soon");
                  },
                ),
                _buildAccountOption(
                  "Preferences",
                  "Room and service preferences",
                  Icons.settings,
                  () {
                    si("Preferences coming soon");
                  },
                ),
                _buildAccountOption(
                  "Feedback",
                  "Share your experience",
                  Icons.feedback,
                  () {
                    si("Feedback form coming soon");
                  },
                  isLast: true,
                ),
              ],
            ),
          ),

          // Logout
          Container(
            width: double.infinity,
            child: QButton(
              label: "Sign Out",
              icon: Icons.logout,
              size: bs.md,
              onPressed: () async {
                bool isConfirmed = await confirm("Are you sure you want to sign out?");
                if (isConfirmed) {
                  ss("Signed out successfully");
                  //await offAll(HhaGuestLoginView());
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAccountOption(String title, String subtitle, IconData icon, VoidCallback onTap, {bool isLast = false}) {
    return Container(
      decoration: BoxDecoration(
        border: !isLast
            ? Border(
                bottom: BorderSide(
                  color: disabledOutlineBorderColor,
                ),
              )
            : null,
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(radiusMd),
        child: Container(
          padding: EdgeInsets.all(spMd),
          child: Row(
            children: [
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: primaryColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Icon(
                  icon,
                  color: primaryColor,
                  size: 20,
                ),
              ),
              SizedBox(width: spMd),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 16,
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
              Icon(
                Icons.arrow_forward_ios,
                color: disabledBoldColor,
                size: 16,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
