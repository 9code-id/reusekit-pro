import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class FdaDriverProfileView extends StatefulWidget {
  const FdaDriverProfileView({super.key});

  @override
  State<FdaDriverProfileView> createState() => _FdaDriverProfileViewState();
}

class _FdaDriverProfileViewState extends State<FdaDriverProfileView> {
  Map<String, dynamic> driverInfo = {
    "id": "DRV001",
    "name": "Mike Rodriguez",
    "photo": "https://picsum.photos/200/200?random=1&keyword=person",
    "rating": 4.9,
    "totalRatings": 2847,
    "totalDeliveries": 3240,
    "yearsOfService": 3,
    "phone": "+1 (555) 123-7890",
    "email": "mike.rodriguez@deliveryapp.com",
    "joinDate": "March 2021",
    "status": "Online",
    "vehicleType": "Motorcycle",
    "vehicleModel": "Honda CB250",
    "vehicleColor": "Blue",
    "licensePlate": "ABC-123",
    "currentLocation": "Downtown Area",
    "isVerified": true,
    "languages": ["English", "Spanish"],
    "specializations": ["Fast Delivery", "Food Safety Certified"],
  };

  Map<String, dynamic> stats = {
    "deliveriesToday": 12,
    "onTimeDeliveries": 98.5,
    "customerSatisfaction": 4.9,
    "avgDeliveryTime": "18 minutes",
    "totalEarnings": 1850.50,
    "thisMonthDeliveries": 156,
  };

  List<Map<String, dynamic>> recentReviews = [
    {
      "customerName": "Sarah Johnson",
      "rating": 5,
      "comment": "Excellent service! Food arrived hot and on time. Mike was very professional and courteous.",
      "date": "2024-01-15",
      "orderId": "#FDA001",
    },
    {
      "customerName": "David Chen",
      "rating": 5,
      "comment": "Super fast delivery! Driver was friendly and followed all delivery instructions perfectly.",
      "date": "2024-01-14",
      "orderId": "#FDA002",
    },
    {
      "customerName": "Maria Garcia",
      "rating": 4,
      "comment": "Good service overall. Food was delivered in good condition and driver was polite.",
      "date": "2024-01-13",
      "orderId": "#FDA003",
    },
    {
      "customerName": "James Wilson",
      "rating": 5,
      "comment": "Outstanding delivery experience! Mike went above and beyond to ensure perfect delivery.",
      "date": "2024-01-12",
      "orderId": "#FDA004",
    },
  ];

  List<Map<String, dynamic>> achievements = [
    {
      "title": "Top Performer",
      "description": "Top 5% driver this month",
      "icon": Icons.emoji_events,
      "color": warningColor,
      "earned": "January 2024",
    },
    {
      "title": "Safety Expert",
      "description": "Zero incidents in 1000+ deliveries",
      "icon": Icons.security,
      "color": successColor,
      "earned": "December 2023",
    },
    {
      "title": "Customer Favorite",
      "description": "4.9+ rating for 6 months",
      "icon": Icons.favorite,
      "color": dangerColor,
      "earned": "November 2023",
    },
    {
      "title": "Speed Demon",
      "description": "95% on-time delivery rate",
      "icon": Icons.speed,
      "color": infoColor,
      "earned": "October 2023",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Driver Profile"),
        actions: [
          IconButton(
            icon: Icon(Icons.phone),
            onPressed: _callDriver,
          ),
          IconButton(
            icon: Icon(Icons.message),
            onPressed: _messageDriver,
          ),
          IconButton(
            icon: Icon(Icons.share),
            onPressed: _shareProfile,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            _buildDriverHeader(),
            _buildDriverStats(),
            _buildVehicleInfo(),
            _buildAchievements(),
            _buildRecentReviews(),
            _buildContactActions(),
          ],
        ),
      ),
    );
  }

  Widget _buildDriverHeader() {
    return Container(
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
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(radiusMd),
                    child: Image.network(
                      "${driverInfo["photo"]}",
                      width: 80,
                      height: 80,
                      fit: BoxFit.cover,
                    ),
                  ),
                  if (driverInfo["isVerified"] == true)
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        padding: EdgeInsets.all(2),
                        decoration: BoxDecoration(
                          color: successColor,
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 2),
                        ),
                        child: Icon(
                          Icons.verified,
                          color: Colors.white,
                          size: 16,
                        ),
                      ),
                    ),
                ],
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spXs,
                  children: [
                    Row(
                      children: [
                        Text(
                          "${driverInfo["name"]}",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        SizedBox(width: spXs),
                        Container(
                          width: 8,
                          height: 8,
                          decoration: BoxDecoration(
                            color: driverInfo["status"] == "Online" ? successColor : disabledColor,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      "ID: ${driverInfo["id"]} • ${driverInfo["status"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.star,
                          color: warningColor,
                          size: 16,
                        ),
                        SizedBox(width: 4),
                        Text(
                          "${driverInfo["rating"]}",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: warningColor,
                          ),
                        ),
                        Text(
                          " (${driverInfo["totalRatings"]} reviews)",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      "${driverInfo["totalDeliveries"]} deliveries • ${driverInfo["yearsOfService"]} years",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Divider(color: disabledColor),
          Wrap(
            spacing: spXs,
            runSpacing: spXs,
            children: [
              ...((driverInfo["languages"] as List).map((lang) => 
                _buildTag("$lang", infoColor))),
              ...((driverInfo["specializations"] as List).map((spec) => 
                _buildTag("$spec", successColor))),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTag(String text, Color color) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
      decoration: BoxDecoration(
        color: color.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusXs),
        border: Border.all(color: color.withAlpha(50), width: 1),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 10,
          color: color,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildDriverStats() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Row(
            children: [
              Icon(
                Icons.analytics,
                color: primaryColor,
                size: 20,
              ),
              SizedBox(width: spSm),
              Text(
                "Performance Statistics",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          Divider(color: disabledColor),
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: [
              _buildStatCard("Today's Deliveries", "${stats["deliveriesToday"]}", Icons.delivery_dining, primaryColor),
              _buildStatCard("On-Time Rate", "${stats["onTimeDeliveries"]}%", Icons.schedule, successColor),
              _buildStatCard("Avg Delivery Time", "${stats["avgDeliveryTime"]}", Icons.timer, infoColor),
              _buildStatCard("Customer Rating", "${stats["customerSatisfaction"]}", Icons.star, warningColor),
              _buildStatCard("This Month", "${stats["thisMonthDeliveries"]} deliveries", Icons.calendar_month, primaryColor),
              _buildStatCard("Total Earnings", "\$${((stats["totalEarnings"] as double)).toStringAsFixed(2)}", Icons.payments, successColor),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: color.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: color.withAlpha(50), width: 1),
      ),
      child: Column(
        children: [
          Icon(
            icon,
            color: color,
            size: 24,
          ),
          SizedBox(height: spXs),
          Text(
            value,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVehicleInfo() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Row(
            children: [
              Icon(
                Icons.motorcycle,
                color: primaryColor,
                size: 20,
              ),
              SizedBox(width: spSm),
              Text(
                "Vehicle Information",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          Divider(color: disabledColor),
          Row(
            children: [
              Expanded(
                child: _buildInfoRow("Type", "${driverInfo["vehicleType"]}"),
              ),
              Expanded(
                child: _buildInfoRow("Model", "${driverInfo["vehicleModel"]}"),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: _buildInfoRow("Color", "${driverInfo["vehicleColor"]}"),
              ),
              Expanded(
                child: _buildInfoRow("License", "${driverInfo["licensePlate"]}"),
              ),
            ],
          ),
          _buildInfoRow("Current Location", "${driverInfo["currentLocation"]}"),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: disabledBoldColor,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: primaryColor,
          ),
        ),
      ],
    );
  }

  Widget _buildAchievements() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Row(
            children: [
              Icon(
                Icons.emoji_events,
                color: warningColor,
                size: 20,
              ),
              SizedBox(width: spSm),
              Text(
                "Achievements",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          Divider(color: disabledColor),
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: achievements.map((achievement) => _buildAchievementCard(achievement)).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildAchievementCard(Map<String, dynamic> achievement) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: (achievement["color"] as Color).withAlpha(10),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: (achievement["color"] as Color).withAlpha(50), width: 1),
      ),
      child: Column(
        children: [
          Icon(
            achievement["icon"] as IconData,
            color: achievement["color"] as Color,
            size: 32,
          ),
          SizedBox(height: spXs),
          Text(
            "${achievement["title"]}",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Text(
            "${achievement["description"]}",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),
          SizedBox(height: spXs),
          Text(
            "Earned: ${achievement["earned"]}",
            style: TextStyle(
              fontSize: 10,
              color: achievement["color"] as Color,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecentReviews() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Row(
            children: [
              Icon(
                Icons.rate_review,
                color: primaryColor,
                size: 20,
              ),
              SizedBox(width: spSm),
              Text(
                "Recent Reviews",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          Divider(color: disabledColor),
          ...recentReviews.take(3).map((review) => _buildReviewCard(review)),
          if (recentReviews.length > 3)
            Center(
              child: QButton(
                label: "View All Reviews",
                size: bs.sm,
                onPressed: _viewAllReviews,
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildReviewCard(Map<String, dynamic> review) {
    return Container(
      padding: EdgeInsets.all(spSm),
      margin: EdgeInsets.only(bottom: spSm),
      decoration: BoxDecoration(
        color: primaryColor.withAlpha(5),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: disabledColor, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spXs,
        children: [
          Row(
            children: [
              Text(
                "${review["customerName"]}",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: primaryColor,
                ),
              ),
              Spacer(),
              Row(
                children: List.generate(5, (index) => Icon(
                  Icons.star,
                  size: 14,
                  color: index < (review["rating"] as int) ? warningColor : disabledColor,
                )),
              ),
            ],
          ),
          Text(
            "${review["comment"]}",
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),
          Row(
            children: [
              Text(
                "${review["date"]}",
                style: TextStyle(
                  fontSize: 10,
                  color: disabledColor,
                ),
              ),
              Spacer(),
              Text(
                "${review["orderId"]}",
                style: TextStyle(
                  fontSize: 10,
                  color: disabledColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildContactActions() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        children: [
          Text(
            "Contact Actions",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Divider(color: disabledColor),
          Row(
            children: [
              Expanded(
                child: QButton(
                  label: "Call Driver",
                  size: bs.sm,
                  onPressed: _callDriver,
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QButton(
                  label: "Send Message",
                  size: bs.sm,
                  onPressed: _messageDriver,
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              Expanded(
                child: QButton(
                  label: "Rate Driver",
                  size: bs.sm,
                  onPressed: _rateDriver,
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QButton(
                  label: "Report Issue",
                  size: bs.sm,
                  onPressed: _reportIssue,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _callDriver() {
    ss("Calling ${driverInfo["name"]}...");
  }

  void _messageDriver() {
    ss("Opening chat with ${driverInfo["name"]}...");
  }

  void _shareProfile() {
    ss("Driver profile shared successfully!");
  }

  void _viewAllReviews() {
    ss("Opening all reviews for ${driverInfo["name"]}...");
  }

  void _rateDriver() {
    ss("Opening rating form for ${driverInfo["name"]}...");
  }

  void _reportIssue() {
    ss("Opening issue report form...");
  }
}
