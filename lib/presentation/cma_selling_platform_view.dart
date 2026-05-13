import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class CmaSellingPlatformView extends StatefulWidget {
  const CmaSellingPlatformView({super.key});

  @override
  State<CmaSellingPlatformView> createState() => _CmaSellingPlatformViewState();
}

class _CmaSellingPlatformViewState extends State<CmaSellingPlatformView> {
  int currentTab = 0;

  // Listing Details
  String vehicleTitle = "";
  String vehicleDescription = "";
  String askingPrice = "";
  String negotiable = "yes";
  String contactMethod = "";
  String availableViewing = "";
  List<String> selectedPlatforms = [];
  String listingDuration = "";

  // Platform Performance
  String selectedTimeframe = "30_days";
  String selectedMetric = "views";

  List<Map<String, dynamic>> platforms = [
    {
      "id": "autotrader",
      "name": "AutoTrader",
      "logo": "https://picsum.photos/60/60?random=1&keyword=auto",
      "fee_type": "Listing Fee",
      "fee_amount": 49.99,
      "duration": "30 days",
      "features": ["Professional photos", "Market insights", "Buyer protection"],
      "audience": "5M+ monthly visitors",
      "success_rate": 78,
      "avg_days_to_sell": 28,
      "pros": ["Largest audience", "Professional tools", "Trusted brand"],
      "cons": ["Higher fees", "More competition"],
      "rating": 4.8,
      "reviews": 12450,
    },
    {
      "id": "cars_com",
      "name": "Cars.com",
      "logo": "https://picsum.photos/60/60?random=2&keyword=cars",
      "fee_type": "Listing Fee",
      "fee_amount": 39.99,
      "duration": "30 days",
      "features": ["Price alerts", "Market analysis", "Mobile app"],
      "audience": "4.2M+ monthly visitors",
      "success_rate": 72,
      "avg_days_to_sell": 32,
      "pros": ["Good pricing", "Market data", "Easy listing"],
      "cons": ["Less premium feel", "Limited promotion"],
      "rating": 4.6,
      "reviews": 8920,
    },
    {
      "id": "cargurus",
      "name": "CarGurus",
      "logo": "https://picsum.photos/60/60?random=3&keyword=guru",
      "fee_type": "Success Fee",
      "fee_amount": 199.00,
      "duration": "Until sold",
      "features": ["Price scoring", "Deal badges", "Instant alerts"],
      "audience": "3.8M+ monthly visitors",
      "success_rate": 85,
      "avg_days_to_sell": 22,
      "pros": ["No upfront cost", "Smart pricing", "High conversion"],
      "cons": ["High success fee", "Less control"],
      "rating": 4.9,
      "reviews": 15680,
    },
    {
      "id": "facebook",
      "name": "Facebook Marketplace",
      "logo": "https://picsum.photos/60/60?random=4&keyword=facebook",
      "fee_type": "Free",
      "fee_amount": 0.00,
      "duration": "7 days (renewable)",
      "features": ["Local audience", "Messenger integration", "Social proof"],
      "audience": "1.2B+ monthly users",
      "success_rate": 65,
      "avg_days_to_sell": 45,
      "pros": ["Free listing", "Local buyers", "Social verification"],
      "cons": ["Safety concerns", "Time consuming", "Lower prices"],
      "rating": 4.2,
      "reviews": 45120,
    },
    {
      "id": "craigslist",
      "name": "Craigslist",
      "logo": "https://picsum.photos/60/60?random=5&keyword=list",
      "fee_type": "Listing Fee",
      "fee_amount": 5.00,
      "duration": "30 days",
      "features": ["Local focus", "Simple interface", "No middleman"],
      "audience": "Local market",
      "success_rate": 58,
      "avg_days_to_sell": 38,
      "pros": ["Very low cost", "Local buyers", "Direct contact"],
      "cons": ["Outdated interface", "Safety risks", "Scam potential"],
      "rating": 3.8,
      "reviews": 2340,
    },
    {
      "id": "bring_a_trailer",
      "name": "Bring a Trailer",
      "logo": "https://picsum.photos/60/60?random=6&keyword=trailer",
      "fee_type": "Success Fee",
      "fee_amount": 250.00,
      "duration": "7 day auction",
      "features": ["Auction format", "Expert curation", "Enthusiast audience"],
      "audience": "500K+ enthusiasts",
      "success_rate": 92,
      "avg_days_to_sell": 7,
      "pros": ["Premium prices", "Enthusiast buyers", "Professional photos"],
      "cons": ["High standards", "Limited to special cars", "Auction format"],
      "rating": 4.9,
      "reviews": 3420,
    },
  ];

  List<Map<String, dynamic>> performanceData = [
    {
      "platform": "AutoTrader",
      "views": 1250,
      "inquiries": 45,
      "phone_calls": 12,
      "test_drives": 8,
      "offers": 3,
      "conversion_rate": 3.6,
      "avg_offer": 18500,
      "time_active": 18,
    },
    {
      "platform": "Cars.com",
      "views": 890,
      "inquiries": 32,
      "phone_calls": 8,
      "test_drives": 5,
      "offers": 2,
      "conversion_rate": 3.6,
      "avg_offer": 17800,
      "time_active": 18,
    },
    {
      "platform": "Facebook Marketplace",
      "views": 2100,
      "inquiries": 78,
      "phone_calls": 25,
      "test_drives": 12,
      "offers": 6,
      "conversion_rate": 3.7,
      "avg_offer": 17200,
      "time_active": 18,
    },
  ];

  List<Map<String, dynamic>> sellingTips = [
    {
      "category": "Photography",
      "icon": Icons.camera_alt,
      "tips": [
        "Take photos in natural daylight",
        "Include interior, exterior, engine bay",
        "Show any damage honestly",
        "Clean the car thoroughly first",
        "Use multiple angles for each area",
      ],
    },
    {
      "category": "Pricing",
      "icon": Icons.attach_money,
      "tips": [
        "Research market value thoroughly",
        "Price slightly above target to allow negotiation",
        "Consider seasonal demand factors",
        "Update pricing based on market response",
        "Be transparent about negotiability",
      ],
    },
    {
      "category": "Description",
      "icon": Icons.description,
      "tips": [
        "List all features and options",
        "Mention recent maintenance",
        "Be honest about known issues",
        "Include reason for selling",
        "Use specific details and measurements",
      ],
    },
    {
      "category": "Safety",
      "icon": Icons.security,
      "tips": [
        "Meet buyers in public places",
        "Bring a friend to meetings",
        "Verify funds before test drives",
        "Keep personal information private",
        "Trust your instincts about buyers",
      ],
    },
  ];

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Selling Platform Comparison",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Platforms", icon: Icon(Icons.compare)),
        Tab(text: "Performance", icon: Icon(Icons.analytics)),
        Tab(text: "Tips & Guide", icon: Icon(Icons.lightbulb)),
      ],
      tabChildren: [
        _buildPlatformsTab(),
        _buildPerformanceTab(),
        _buildTipsTab(),
      ],
    );
  }

  Widget _buildPlatformsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Quick Comparison
          Container(
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
                Text(
                  "Quick Platform Comparison",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      Container(
                        width: 120,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Platform", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                            SizedBox(height: spSm),
                            Text("Cost", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                            SizedBox(height: spSm),
                            Text("Success Rate", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                            SizedBox(height: spSm),
                            Text("Avg. Days", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                            SizedBox(height: spSm),
                            Text("Audience", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                          ],
                        ),
                      ),
                      ...platforms.take(4).map((platform) => Container(
                        width: 100,
                        margin: EdgeInsets.only(left: spSm),
                        child: Column(
                          children: [
                            Text(
                              "${platform["name"]}",
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 12,
                                color: primaryColor,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: spSm),
                            Text(
                              platform["fee_type"] == "Free" ? "Free" : "\$${(platform["fee_amount"] as double).toStringAsFixed(0)}",
                              style: TextStyle(fontSize: 11, color: disabledBoldColor),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: spSm),
                            Text(
                              "${platform["success_rate"]}%",
                              style: TextStyle(fontSize: 11, color: disabledBoldColor),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: spSm),
                            Text(
                              "${platform["avg_days_to_sell"]} days",
                              style: TextStyle(fontSize: 11, color: disabledBoldColor),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: spSm),
                            Text(
                              "${platform["audience"]}".split(" ")[0],
                              style: TextStyle(fontSize: 11, color: disabledBoldColor),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      )).toList(),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Platform Details
          ...platforms.map((platform) => Container(
            padding: EdgeInsets.all(spSm),
            margin: EdgeInsets.only(bottom: spSm),
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
                    ClipRRect(
                      borderRadius: BorderRadius.circular(radiusSm),
                      child: Image.network(
                        "${platform["logo"]}",
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
                            "${platform["name"]}",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          SizedBox(height: spXxs),
                          Row(
                            children: [
                              Icon(Icons.star, color: warningColor, size: 16),
                              SizedBox(width: spXxs),
                              Text(
                                "${platform["rating"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: disabledBoldColor,
                                ),
                              ),
                              SizedBox(width: spXs),
                              Text(
                                "(${platform["reviews"]} reviews)",
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
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 4),
                          decoration: BoxDecoration(
                            color: platform["fee_type"] == "Free" ? successColor : 
                                   platform["fee_type"] == "Success Fee" ? warningColor : 
                                   primaryColor,
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            "${platform["fee_type"]}",
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        SizedBox(height: spXxs),
                        Text(
                          platform["fee_type"] == "Free" ? "Free" : "\$${(platform["fee_amount"] as double).toStringAsFixed(2)}",
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
                
                // Key Stats
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.all(spXs),
                        decoration: BoxDecoration(
                          color: successColor.withAlpha(10),
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Column(
                          children: [
                            Text(
                              "${platform["success_rate"]}%",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: successColor,
                              ),
                            ),
                            Text(
                              "Success Rate",
                              style: TextStyle(
                                fontSize: 11,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(width: spXs),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.all(spXs),
                        decoration: BoxDecoration(
                          color: primaryColor.withAlpha(10),
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Column(
                          children: [
                            Text(
                              "${platform["avg_days_to_sell"]}",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              "Avg Days",
                              style: TextStyle(
                                fontSize: 11,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(width: spXs),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.all(spXs),
                        decoration: BoxDecoration(
                          color: infoColor.withAlpha(10),
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Column(
                          children: [
                            Text(
                              "${platform["duration"]}",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: infoColor,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            Text(
                              "Duration",
                              style: TextStyle(
                                fontSize: 11,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),

                // Features
                Text(
                  "Key Features:",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
                Wrap(
                  spacing: spXs,
                  runSpacing: spXs,
                  children: (platform["features"] as List).map((feature) => Container(
                    padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                    decoration: BoxDecoration(
                      color: primaryColor.withAlpha(10),
                      borderRadius: BorderRadius.circular(radiusXs),
                      border: Border.all(color: primaryColor.withAlpha(50)),
                    ),
                    child: Text(
                      "$feature",
                      style: TextStyle(
                        fontSize: 11,
                        color: primaryColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  )).toList(),
                ),

                // Pros and Cons
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.check_circle, color: successColor, size: 16),
                              SizedBox(width: spXs),
                              Text(
                                "Pros",
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                  color: successColor,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: spXs),
                          ...(platform["pros"] as List).map((pro) => Padding(
                            padding: EdgeInsets.only(bottom: 2),
                            child: Text(
                              "• $pro",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                          )).toList(),
                        ],
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.cancel, color: dangerColor, size: 16),
                              SizedBox(width: spXs),
                              Text(
                                "Cons",
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                  color: dangerColor,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: spXs),
                          ...(platform["cons"] as List).map((con) => Padding(
                            padding: EdgeInsets.only(bottom: 2),
                            child: Text(
                              "• $con",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                          )).toList(),
                        ],
                      ),
                    ),
                  ],
                ),

                // Action Buttons
                Row(
                  spacing: spSm,
                  children: [
                    Expanded(
                      child: QButton(
                        label: "View Details",
                        size: bs.sm,
                        onPressed: () {
                          si("Viewing details for ${platform["name"]}");
                        },
                      ),
                    ),
                    Expanded(
                      child: QButton(
                        label: "Start Listing",
                        size: bs.sm,
                        onPressed: () {
                          ss("Starting listing on ${platform["name"]}");
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )).toList(),
        ],
      ),
    );
  }

  Widget _buildPerformanceTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Filter Options
          Container(
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
                Text(
                  "Performance Analytics",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: QDropdownField(
                        label: "Timeframe",
                        items: [
                          {"label": "Last 7 days", "value": "7_days"},
                          {"label": "Last 30 days", "value": "30_days"},
                          {"label": "Last 3 months", "value": "3_months"},
                        ],
                        value: selectedTimeframe,
                        onChanged: (value, label) {
                          selectedTimeframe = value;
                          setState(() {});
                        },
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: QDropdownField(
                        label: "Metric",
                        items: [
                          {"label": "Views", "value": "views"},
                          {"label": "Inquiries", "value": "inquiries"},
                          {"label": "Conversion Rate", "value": "conversion"},
                        ],
                        value: selectedMetric,
                        onChanged: (value, label) {
                          selectedMetric = value;
                          setState(() {});
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Performance Summary
          Container(
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
                Text(
                  "Overall Performance (18 days active)",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: primaryColor.withAlpha(10),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Column(
                          children: [
                            Text(
                              "4,240",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              "Total Views",
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
                          color: infoColor.withAlpha(10),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Column(
                          children: [
                            Text(
                              "155",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: infoColor,
                              ),
                            ),
                            Text(
                              "Total Inquiries",
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
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: successColor.withAlpha(10),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Column(
                          children: [
                            Text(
                              "11",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: successColor,
                              ),
                            ),
                            Text(
                              "Offers Received",
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
                          color: warningColor.withAlpha(10),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Column(
                          children: [
                            Text(
                              "3.7%",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: warningColor,
                              ),
                            ),
                            Text(
                              "Conversion Rate",
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
              ],
            ),
          ),

          // Platform Breakdown
          ...performanceData.map((data) => Container(
            padding: EdgeInsets.all(spSm),
            margin: EdgeInsets.only(bottom: spSm),
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
                    Expanded(
                      child: Text(
                        "${data["platform"]}",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                      decoration: BoxDecoration(
                        color: (data["conversion_rate"] as double) > 3.5 ? 
                               successColor : infoColor,
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Text(
                        "${(data["conversion_rate"] as double).toStringAsFixed(1)}% conversion",
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
                
                // Metrics Grid
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          Text(
                            "${data["views"]}",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          Text(
                            "Views",
                            style: TextStyle(
                              fontSize: 11,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          Text(
                            "${data["inquiries"]}",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: infoColor,
                            ),
                          ),
                          Text(
                            "Inquiries",
                            style: TextStyle(
                              fontSize: 11,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          Text(
                            "${data["offers"]}",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: successColor,
                            ),
                          ),
                          Text(
                            "Offers",
                            style: TextStyle(
                              fontSize: 11,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          Text(
                            "\$${((data["avg_offer"] as int).toDouble()).currency}",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: warningColor,
                            ),
                          ),
                          Text(
                            "Avg Offer",
                            style: TextStyle(
                              fontSize: 11,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                // Progress bars for visual representation
                Container(
                  height: 4,
                  decoration: BoxDecoration(
                    color: disabledColor,
                    borderRadius: BorderRadius.circular(radiusXs),
                  ),
                  child: FractionallySizedBox(
                    alignment: Alignment.centerLeft,
                    widthFactor: ((data["views"] as int) / 2100).clamp(0.0, 1.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: primaryColor,
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )).toList(),
        ],
      ),
    );
  }

  Widget _buildTipsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Selling Tips by Category
          ...sellingTips.map((category) => Container(
            padding: EdgeInsets.all(spSm),
            margin: EdgeInsets.only(bottom: spSm),
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
                    Container(
                      padding: EdgeInsets.all(spXs),
                      decoration: BoxDecoration(
                        color: primaryColor.withAlpha(10),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Icon(
                        category["icon"],
                        color: primaryColor,
                        size: 24,
                      ),
                    ),
                    SizedBox(width: spSm),
                    Text(
                      "${category["category"]}",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
                ...(category["tips"] as List).map((tip) => Container(
                  padding: EdgeInsets.all(spSm),
                  margin: EdgeInsets.only(bottom: spXs),
                  decoration: BoxDecoration(
                    color: primaryColor.withAlpha(5),
                    borderRadius: BorderRadius.circular(radiusSm),
                    border: Border.all(color: disabledOutlineBorderColor),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.check_circle_outline,
                        color: successColor,
                        size: 16,
                      ),
                      SizedBox(width: spXs),
                      Expanded(
                        child: Text(
                          "$tip",
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                )).toList(),
              ],
            ),
          )).toList(),

          // Selling Checklist
          Container(
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
                    Icon(Icons.checklist, color: primaryColor, size: 24),
                    SizedBox(width: spSm),
                    Text(
                      "Pre-Listing Checklist",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
                ...List.generate(8, (index) {
                  List<String> checklistItems = [
                    "Clean and detail your vehicle thoroughly",
                    "Gather all maintenance records",
                    "Complete minor repairs and maintenance",
                    "Research market value and set competitive price",
                    "Take high-quality photos in good lighting",
                    "Write detailed and honest description",
                    "Prepare all necessary paperwork",
                    "Plan safe meeting locations for viewings",
                  ];
                  
                  return Container(
                    padding: EdgeInsets.symmetric(vertical: spXs, horizontal: spSm),
                    margin: EdgeInsets.only(bottom: spXs),
                    decoration: BoxDecoration(
                      color: index % 2 == 0 ? Colors.transparent : primaryColor.withAlpha(5),
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 20,
                          height: 20,
                          decoration: BoxDecoration(
                            border: Border.all(color: primaryColor, width: 2),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Icon(
                            Icons.check,
                            color: primaryColor,
                            size: 14,
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Text(
                            checklistItems[index],
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }),
              ],
            ),
          ),

          // Quick Start Guide
          Container(
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
                    Icon(Icons.rocket_launch, color: primaryColor, size: 24),
                    SizedBox(width: spSm),
                    Text(
                      "Quick Start Guide",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
                Text(
                  "Ready to sell your car? Follow these steps to get started:",
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                  ),
                ),
                Container(
                  width: double.infinity,
                  child: QButton(
                    label: "Start Creating Your Listing",
                    size: bs.md,
                    onPressed: () {
                      ss("Starting guided listing creation");
                    },
                  ),
                ),
                Row(
                  spacing: spSm,
                  children: [
                    Expanded(
                      child: QButton(
                        label: "Price Calculator",
                        size: bs.sm,
                        onPressed: () {
                          si("Opening price calculator");
                        },
                      ),
                    ),
                    Expanded(
                      child: QButton(
                        label: "Photo Tips",
                        size: bs.sm,
                        onPressed: () {
                          si("Viewing photo tips guide");
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
}
