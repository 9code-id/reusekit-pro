import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlHome7View extends StatefulWidget {
  @override
  State<GrlHome7View> createState() => _GrlHome7ViewState();
}

class _GrlHome7ViewState extends State<GrlHome7View> {
  String searchQuery = "";
  int selectedServiceType = 0;
  
  final List<Map<String, dynamic>> serviceTypes = [
    {"label": "All Services", "value": "all"},
    {"label": "Home", "value": "home"},
    {"label": "Professional", "value": "professional"},
    {"label": "Emergency", "value": "emergency"},
  ];

  final List<Map<String, dynamic>> featuredServices = [
    {
      "id": 1,
      "name": "Home Cleaning Service",
      "description": "Professional deep cleaning for your home",
      "provider": "CleanPro Services",
      "rating": 4.9,
      "reviews": 1245,
      "price": 89.99,
      "duration": "2-3 hours",
      "image": "https://picsum.photos/300/200?random=1&keyword=cleaning",
      "category": "Home",
      "isAvailable": true,
      "isPopular": true,
    },
    {
      "id": 2,
      "name": "Plumbing Repair",
      "description": "Quick and reliable plumbing solutions",
      "provider": "FixIt Plumbing",
      "rating": 4.8,
      "reviews": 892,
      "price": 125.00,
      "duration": "1-2 hours",
      "image": "https://picsum.photos/300/200?random=2&keyword=plumbing",
      "category": "Home",
      "isAvailable": true,
      "isPopular": false,
    },
    {
      "id": 3,
      "name": "Legal Consultation",
      "description": "Expert legal advice and consultation",
      "provider": "LawFirm Associates",
      "rating": 4.7,
      "reviews": 567,
      "price": 199.99,
      "duration": "45 minutes",
      "image": "https://picsum.photos/300/200?random=3&keyword=legal",
      "category": "Professional",
      "isAvailable": false,
      "isPopular": true,
    },
    {
      "id": 4,
      "name": "Pet Grooming",
      "description": "Complete grooming service for your pets",
      "provider": "PetCare Plus",
      "rating": 4.9,
      "reviews": 423,
      "price": 65.00,
      "duration": "1.5 hours",
      "image": "https://picsum.photos/300/200?random=4&keyword=pet-grooming",
      "category": "Home",
      "isAvailable": true,
      "isPopular": false,
    },
  ];

  final List<Map<String, dynamic>> serviceCategories = [
    {
      "name": "Home Services",
      "icon": Icons.home_repair_service,
      "color": primaryColor,
      "serviceCount": 156,
      "description": "Cleaning, repair, maintenance",
    },
    {
      "name": "Health & Wellness",
      "icon": Icons.health_and_safety,
      "color": successColor,
      "serviceCount": 89,
      "description": "Medical, fitness, therapy",
    },
    {
      "name": "Professional",
      "icon": Icons.business_center,
      "color": infoColor,
      "serviceCount": 67,
      "description": "Legal, financial, consulting",
    },
    {
      "name": "Beauty & Care",
      "icon": Icons.face,
      "color": dangerColor,
      "serviceCount": 134,
      "description": "Salon, spa, grooming",
    },
    {
      "name": "Technology",
      "icon": Icons.computer,
      "color": warningColor,
      "serviceCount": 78,
      "description": "IT support, installation",
    },
    {
      "name": "Transportation",
      "icon": Icons.directions_car,
      "color": infoColor,
      "serviceCount": 45,
      "description": "Delivery, moving, taxi",
    },
  ];

  final List<Map<String, dynamic>> myBookings = [
    {
      "id": "BK001",
      "serviceName": "House Cleaning",
      "provider": "CleanPro Services",
      "date": "2024-02-15",
      "time": "10:00 AM",
      "status": "Confirmed",
      "price": 89.99,
    },
    {
      "id": "BK002",
      "serviceName": "Plumbing Repair",
      "provider": "FixIt Plumbing",
      "date": "2024-02-18",
      "time": "02:00 PM",
      "status": "Pending",
      "price": 125.00,
    },
    {
      "id": "BK003",
      "serviceName": "Pet Grooming",
      "provider": "PetCare Plus",
      "date": "2024-02-12",
      "time": "09:00 AM",
      "status": "Completed",
      "price": 65.00,
    },
  ];

  final List<Map<String, dynamic>> quickActions = [
    {
      "title": "Emergency Service",
      "subtitle": "24/7 urgent support",
      "icon": Icons.emergency,
      "color": dangerColor,
    },
    {
      "title": "Schedule Service",
      "subtitle": "Book for later",
      "icon": Icons.schedule,
      "color": infoColor,
    },
    {
      "title": "Track Booking",
      "subtitle": "Monitor progress",
      "icon": Icons.track_changes,
      "color": primaryColor,
    },
    {
      "title": "Support Center",
      "subtitle": "Get help anytime",
      "icon": Icons.support_agent,
      "color": successColor,
    },
  ];

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'confirmed':
        return successColor;
      case 'pending':
        return warningColor;
      case 'completed':
        return infoColor;
      case 'cancelled':
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Service Hub"),
        actions: [
          IconButton(
            icon: Icon(Icons.history),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Welcome Header
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [successColor, successColor.withAlpha(180)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowMd],
              ),
              child: Column(
                spacing: spSm,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          spacing: spXs,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Need a Service?",
                              style: TextStyle(
                                fontSize: fsH4,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              "Find trusted professionals for any task",
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.white.withAlpha(220),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          color: Colors.white.withAlpha(50),
                          borderRadius: BorderRadius.circular(radiusLg),
                        ),
                        child: Icon(
                          Icons.handyman,
                          size: 32,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      QButton(
                        label: "Book Now",
                        color: Colors.white,
                        size: bs.sm,
                        onPressed: () {},
                      ),
                      SizedBox(width: spSm),
                      QButton(
                        label: "Emergency",
                        color: dangerColor,
                        size: bs.sm,
                        onPressed: () {},
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Search Bar
            Row(
              children: [
                Expanded(
                  child: QTextField(
                    label: "Search services...",
                    value: searchQuery,
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

            // Quick Actions
            Text(
              "Quick Actions",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            ResponsiveGridView(
              padding: EdgeInsets.zero,
              minItemWidth: 140,
              children: quickActions.map((action) {
                return Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusLg),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    spacing: spXs,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          color: (action["color"] as Color).withAlpha(30),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Icon(
                          action["icon"] as IconData,
                          size: 24,
                          color: action["color"] as Color,
                        ),
                      ),
                      Text(
                        "${action["title"]}",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "${action["subtitle"]}",
                        style: TextStyle(
                          fontSize: 10,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),

            // Service Categories
            Text(
              "Browse Categories",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            QCategoryPicker(
              items: serviceTypes,
              value: serviceTypes[selectedServiceType]["value"],
              onChanged: (index, label, value, item) {
                selectedServiceType = index;
                setState(() {});
              },
            ),

            // Service Categories Grid
            ResponsiveGridView(
              padding: EdgeInsets.zero,
              minItemWidth: 160,
              children: serviceCategories.map((category) {
                return Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusLg),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    spacing: spXs,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 45,
                            height: 45,
                            decoration: BoxDecoration(
                              color: (category["color"] as Color).withAlpha(30),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Icon(
                              category["icon"] as IconData,
                              size: 22,
                              color: category["color"] as Color,
                            ),
                          ),
                          Spacer(),
                        ],
                      ),
                      Text(
                        "${category["name"]}",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "${category["description"]}",
                        style: TextStyle(
                          fontSize: 10,
                          color: disabledBoldColor,
                        ),
                      ),
                      Text(
                        "${category["serviceCount"]} services",
                        style: TextStyle(
                          fontSize: 10,
                          color: disabledColor,
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),

            // Featured Services
            Row(
              children: [
                Text(
                  "Featured Services",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Spacer(),
                Text(
                  "View All",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            Column(
              spacing: spSm,
              children: featuredServices.map((service) {
                return Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusLg),
                    boxShadow: [shadowMd],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.vertical(top: Radius.circular(radiusLg)),
                            child: Image.network(
                              "${service["image"]}",
                              width: double.infinity,
                              height: 150,
                              fit: BoxFit.cover,
                            ),
                          ),
                          if (service["isPopular"] as bool)
                            Positioned(
                              top: spSm,
                              left: spSm,
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 4),
                                decoration: BoxDecoration(
                                  color: warningColor,
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: Text(
                                  "POPULAR",
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          Positioned(
                            top: spSm,
                            right: spSm,
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 4),
                              decoration: BoxDecoration(
                                color: (service["isAvailable"] as bool) ? successColor : dangerColor,
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Text(
                                (service["isAvailable"] as bool) ? "AVAILABLE" : "BUSY",
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.all(spSm),
                        child: Column(
                          spacing: spXs,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: primaryColor.withAlpha(30),
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                  child: Text(
                                    "${service["category"]}",
                                    style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                      color: primaryColor,
                                    ),
                                  ),
                                ),
                                Spacer(),
                                Row(
                                  spacing: 2,
                                  children: [
                                    Icon(
                                      Icons.star,
                                      size: 12,
                                      color: warningColor,
                                    ),
                                    Text(
                                      "${(service["rating"] as num).toStringAsFixed(1)}",
                                      style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.w600,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                    Text(
                                      "(${service["reviews"]})",
                                      style: TextStyle(
                                        fontSize: 10,
                                        color: disabledColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Text(
                              "${service["name"]}",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              "${service["description"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                            Row(
                              children: [
                                Text(
                                  "${service["provider"]}",
                                  style: TextStyle(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w600,
                                    color: infoColor,
                                  ),
                                ),
                                SizedBox(width: spSm),
                                Icon(
                                  Icons.access_time,
                                  size: 12,
                                  color: disabledColor,
                                ),
                                SizedBox(width: 2),
                                Text(
                                  "${service["duration"]}",
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: disabledColor,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    "\$${((service["price"] as num).toDouble()).currency}",
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: primaryColor,
                                    ),
                                  ),
                                ),
                                QButton(
                                  label: (service["isAvailable"] as bool) ? "Book Now" : "Join Waitlist",
                                  color: (service["isAvailable"] as bool) ? primaryColor : warningColor,
                                  size: bs.sm,
                                  onPressed: () {},
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),

            // My Recent Bookings
            Row(
              children: [
                Text(
                  "My Recent Bookings",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Spacer(),
                Text(
                  "View All",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            Column(
              spacing: spSm,
              children: myBookings.map((booking) {
                return Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusLg),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    spacing: spXs,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            "${booking["id"]}",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          Spacer(),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                            decoration: BoxDecoration(
                              color: _getStatusColor("${booking["status"]}").withAlpha(30),
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Text(
                              "${booking["status"]}",
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                                color: _getStatusColor("${booking["status"]}"),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Text(
                        "${booking["serviceName"]}",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "${booking["provider"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                      Row(
                        children: [
                          Row(
                            spacing: 4,
                            children: [
                              Icon(
                                Icons.calendar_today,
                                size: 12,
                                color: disabledColor,
                              ),
                              Text(
                                "${booking["date"]} • ${booking["time"]}",
                                style: TextStyle(
                                  fontSize: 10,
                                  color: disabledColor,
                                ),
                              ),
                            ],
                          ),
                          Spacer(),
                          Text(
                            "\$${((booking["price"] as num).toDouble()).currency}",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
