import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlWishlist7View extends StatefulWidget {
  @override
  State<GrlWishlist7View> createState() => _GrlWishlist7ViewState();
}

class _GrlWishlist7ViewState extends State<GrlWishlist7View> {
  bool loading = false;
  String selectedPeriod = "this_month";
  
  Map<String, dynamic> analyticsData = {
    "totalSaved": 1247.89,
    "itemsAdded": 23,
    "itemsPurchased": 8,
    "avgDiscount": 18.5,
    "mostSavedCategory": "Electronics",
    "savingsTrend": [
      {"period": "Jan", "amount": 89.99},
      {"period": "Feb", "amount": 156.50},
      {"period": "Mar", "amount": 203.75},
      {"period": "Apr", "amount": 178.20},
      {"period": "May", "amount": 298.45},
      {"period": "Jun", "amount": 321.00},
    ],
    "categoryBreakdown": [
      {"category": "Electronics", "saved": 567.89, "items": 8, "color": Colors.blue},
      {"category": "Fashion", "saved": 323.45, "items": 6, "color": Colors.pink},
      {"category": "Home", "saved": 189.77, "items": 4, "color": Colors.green},
      {"category": "Books", "saved": 89.33, "items": 3, "color": Colors.orange},
      {"category": "Beauty", "saved": 77.45, "items": 2, "color": Colors.purple},
    ],
    "topDeals": [
      {
        "productName": "Gaming Laptop",
        "originalPrice": 1599.99,
        "salePrice": 1199.99,
        "saved": 400.00,
        "discount": 25,
        "image": "https://picsum.photos/100/100?random=50&keyword=laptop",
      },
      {
        "productName": "Designer Watch",
        "originalPrice": 899.99,
        "salePrice": 649.99,
        "saved": 250.00,
        "discount": 28,
        "image": "https://picsum.photos/100/100?random=51&keyword=watch",
      },
      {
        "productName": "Smart Speaker",
        "originalPrice": 199.99,
        "salePrice": 149.99,
        "saved": 50.00,
        "discount": 25,
        "image": "https://picsum.photos/100/100?random=52&keyword=speaker",
      },
    ],
  };

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Savings Analytics"),
        actions: [
          IconButton(
            icon: Icon(Icons.share),
            onPressed: () {
              ss("Analytics report shared");
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            // Period Selector
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: QDropdownField(
                label: "Analysis Period",
                items: [
                  {"label": "This Week", "value": "this_week"},
                  {"label": "This Month", "value": "this_month"},
                  {"label": "Last 3 Months", "value": "last_3_months"},
                  {"label": "This Year", "value": "this_year"},
                  {"label": "All Time", "value": "all_time"},
                ],
                value: selectedPeriod,
                onChanged: (value, label) {
                  selectedPeriod = value;
                  setState(() {});
                },
              ),
            ),

            // Summary Stats
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [successColor, primaryColor],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(radiusLg),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Total Saved",
                              style: TextStyle(
                                color: Colors.white.withAlpha(200),
                                fontSize: 14,
                              ),
                            ),
                            Text(
                              "\$${(analyticsData["totalSaved"] as double).currency}",
                              style: TextStyle(
                                fontSize: fsH2,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: Colors.white.withAlpha(30),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Icon(
                          Icons.savings,
                          color: Colors.white,
                          size: 48,
                        ),
                      ),
                    ],
                  ),
                  
                  SizedBox(height: spSm),
                  
                  ResponsiveGridView(
                    padding: EdgeInsets.zero,
                    minItemWidth: 200,
                    children: [
                      _buildStatCard(
                        "Items Added",
                        "${analyticsData["itemsAdded"]}",
                        Icons.add_circle,
                        Colors.white.withAlpha(150),
                      ),
                      _buildStatCard(
                        "Items Purchased",
                        "${analyticsData["itemsPurchased"]}",
                        Icons.shopping_bag,
                        Colors.white.withAlpha(150),
                      ),
                      _buildStatCard(
                        "Avg. Discount",
                        "${analyticsData["avgDiscount"]}%",
                        Icons.percent,
                        Colors.white.withAlpha(150),
                      ),
                      _buildStatCard(
                        "Top Category",
                        "${analyticsData["mostSavedCategory"]}",
                        Icons.category,
                        Colors.white.withAlpha(150),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Savings Trend Chart
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
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
                              "Savings Trend",
                              style: TextStyle(
                                fontSize: fsH6,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "Monthly savings over time",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Icon(
                        Icons.trending_up,
                        color: successColor,
                      ),
                    ],
                  ),
                  
                  SizedBox(height: spMd),
                  
                  Container(
                    height: 200,
                    child: Column(
                      children: [
                        Expanded(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: (analyticsData["savingsTrend"] as List).map((data) {
                              double maxAmount = (analyticsData["savingsTrend"] as List)
                                  .map((item) => item["amount"] as double)
                                  .reduce((a, b) => a > b ? a : b);
                              double height = ((data["amount"] as double) / maxAmount) * 150;
                              
                              return Expanded(
                                child: Container(
                                  margin: EdgeInsets.symmetric(horizontal: 4),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Container(
                                        height: height,
                                        decoration: BoxDecoration(
                                          color: primaryColor,
                                          borderRadius: BorderRadius.circular(radiusXs),
                                          gradient: LinearGradient(
                                            colors: [primaryColor, successColor],
                                            begin: Alignment.bottomCenter,
                                            end: Alignment.topCenter,
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: spXs),
                                      Text(
                                        "${data["period"]}",
                                        style: TextStyle(
                                          fontSize: 10,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Category Breakdown
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Savings by Category",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  
                  SizedBox(height: spSm),
                  
                  ...(analyticsData["categoryBreakdown"] as List).map((category) {
                    double totalSaved = analyticsData["totalSaved"] as double;
                    double categorySaved = category["saved"] as double;
                    double percentage = (categorySaved / totalSaved) * 100;
                    
                    return Container(
                      margin: EdgeInsets.only(bottom: spSm),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Container(
                                width: 16,
                                height: 16,
                                decoration: BoxDecoration(
                                  color: category["color"] as Color,
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                              ),
                              SizedBox(width: spSm),
                              Expanded(
                                child: Text(
                                  "${category["category"]}",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              Text(
                                "${category["items"]} items",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                              SizedBox(width: spSm),
                              Text(
                                "\$${(categorySaved).currency}",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: spXs),
                          Row(
                            children: [
                              Expanded(
                                child: LinearProgressIndicator(
                                  value: percentage / 100,
                                  backgroundColor: disabledOutlineBorderColor,
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                    category["color"] as Color,
                                  ),
                                ),
                              ),
                              SizedBox(width: spSm),
                              Text(
                                "${percentage.toStringAsFixed(1)}%",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: category["color"] as Color,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ],
              ),
            ),

            // Top Deals
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
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
                              "Best Deals Found",
                              style: TextStyle(
                                fontSize: fsH6,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "Your biggest savings this period",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Icon(
                        Icons.local_fire_department,
                        color: dangerColor,
                      ),
                    ],
                  ),
                  
                  SizedBox(height: spSm),
                  
                  ...(analyticsData["topDeals"] as List).asMap().entries.map((entry) {
                    int index = entry.key;
                    Map<String, dynamic> deal = entry.value;
                    
                    return Container(
                      margin: EdgeInsets.only(bottom: index < 2 ? spSm : 0),
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: index == 0 ? successColor.withAlpha(20) : Colors.grey.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusSm),
                        border: Border.all(
                          color: index == 0 ? successColor.withAlpha(50) : disabledOutlineBorderColor,
                          width: 1,
                        ),
                      ),
                      child: Row(
                        children: [
                          // Rank Badge
                          Container(
                            width: 32,
                            height: 32,
                            decoration: BoxDecoration(
                              color: index == 0 ? successColor : 
                                     index == 1 ? warningColor : infoColor,
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Center(
                              child: Text(
                                "${index + 1}",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          
                          SizedBox(width: spSm),
                          
                          // Product Image
                          ClipRRect(
                            borderRadius: BorderRadius.circular(radiusXs),
                            child: Image.network(
                              "${deal["image"]}",
                              width: 50,
                              height: 50,
                              fit: BoxFit.cover,
                            ),
                          ),
                          
                          SizedBox(width: spSm),
                          
                          // Product Info
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${deal["productName"]}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Row(
                                  children: [
                                    Text(
                                      "\$${(deal["originalPrice"] as double).currency}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: disabledBoldColor,
                                        decoration: TextDecoration.lineThrough,
                                      ),
                                    ),
                                    SizedBox(width: spXs),
                                    Text(
                                      "\$${(deal["salePrice"] as double).currency}",
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
                          ),
                          
                          // Savings Info
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: spXs,
                                  vertical: 2,
                                ),
                                decoration: BoxDecoration(
                                  color: successColor,
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: Text(
                                  "${deal["discount"]}% OFF",
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              SizedBox(height: 2),
                              Text(
                                "Saved \$${(deal["saved"] as double).currency}",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: successColor,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ],
              ),
            ),

            // Action Buttons
            ResponsiveGridView(
              padding: EdgeInsets.zero,
              minItemWidth: 200,
              children: [
                Container(
                  child: QButton(
                    label: "Export Report",
                    icon: Icons.download,
                    size: bs.md,
                    onPressed: () {
                      ss("Analytics report exported");
                    },
                  ),
                ),
                Container(
                  child: QButton(
                    label: "Share Achievement",
                    icon: Icons.share,
                    size: bs.md,
                    onPressed: () {
                      ss("Achievement shared on social media");
                    },
                  ),
                ),
              ],
            ),

            // Achievement Badges
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Achievement Badges",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  
                  SizedBox(height: spSm),
                  
                  ResponsiveGridView(
                    padding: EdgeInsets.zero,
                    minItemWidth: 200,
                    children: [
                      _buildAchievementBadge(
                        "Smart Saver",
                        "Saved over \$1000",
                        Icons.star,
                        successColor,
                        true,
                      ),
                      _buildAchievementBadge(
                        "Deal Hunter",
                        "Found 10+ deals",
                        Icons.search,
                        warningColor,
                        true,
                      ),
                      _buildAchievementBadge(
                        "Patient Shopper",
                        "Waited for 50% off",
                        Icons.timer,
                        infoColor,
                        false,
                      ),
                      _buildAchievementBadge(
                        "Bargain Master",
                        "Saved 25% on average",
                        Icons.emoji_events,
                        primaryColor,
                        true,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spSm),
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
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAchievementBadge(String title, String description, IconData icon, Color color, bool isEarned) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: isEarned ? color.withAlpha(20) : Colors.grey.withAlpha(20),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(
          color: isEarned ? color.withAlpha(50) : disabledOutlineBorderColor,
          width: 1,
        ),
      ),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: isEarned ? color : disabledColor,
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Icon(
              icon,
              color: Colors.white,
              size: 32,
            ),
          ),
          SizedBox(height: spSm),
          Text(
            title,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: isEarned ? color : disabledBoldColor,
            ),
            textAlign: TextAlign.center,
          ),
          Text(
            description,
            style: TextStyle(
              fontSize: 12,
              color: isEarned ? disabledBoldColor : disabledColor,
            ),
            textAlign: TextAlign.center,
          ),
          if (!isEarned)
            Container(
              margin: EdgeInsets.only(top: spXs),
              padding: EdgeInsets.symmetric(
                horizontal: spXs,
                vertical: 2,
              ),
              decoration: BoxDecoration(
                color: disabledColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusXs),
              ),
              child: Text(
                "LOCKED",
                style: TextStyle(
                  fontSize: 10,
                  color: disabledColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
