import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlReview5View extends StatefulWidget {
  @override
  State<GrlReview5View> createState() => _GrlReview5ViewState();
}

class _GrlReview5ViewState extends State<GrlReview5View> {
  String selectedPeriod = "this_month";
  String selectedMetric = "average_rating";
  
  Map<String, dynamic> reviewStats = {
    "total_reviews": 1247,
    "average_rating": 4.3,
    "rating_distribution": {
      "5": 523,
      "4": 398,
      "3": 187,
      "2": 89,
      "1": 50,
    },
    "monthly_growth": 12.5,
    "response_rate": 89.2,
  };
  
  List<Map<String, dynamic>> recentReviews = [
    {
      "id": 1,
      "customer": "Sarah Johnson",
      "rating": 5,
      "title": "Outstanding service!",
      "content": "The team went above and beyond to help me. Highly recommend!",
      "date": DateTime.now().subtract(Duration(hours: 2)),
      "product": "Premium Support Plan",
      "verified": true,
      "responded": false,
      "sentiment": "positive",
    },
    {
      "id": 2,
      "customer": "Mike Chen",
      "rating": 4,
      "title": "Good value for money",
      "content": "Solid product with good features. Delivery was fast.",
      "date": DateTime.now().subtract(Duration(hours: 6)),
      "product": "Wireless Headphones",
      "verified": true,
      "responded": true,
      "sentiment": "positive",
    },
    {
      "id": 3,
      "customer": "Emily Rodriguez",
      "rating": 2,
      "title": "Disappointed with quality",
      "content": "Product didn't meet expectations. Customer service was slow to respond.",
      "date": DateTime.now().subtract(Duration(days: 1)),
      "product": "Smart Watch",
      "verified": true,
      "responded": false,
      "sentiment": "negative",
    },
    {
      "id": 4,
      "customer": "David Kim",
      "rating": 5,
      "title": "Excellent experience",
      "content": "Fast shipping, great quality, and amazing customer support!",
      "date": DateTime.now().subtract(Duration(days: 2)),
      "product": "Laptop Stand",
      "verified": true,
      "responded": true,
      "sentiment": "positive",
    },
  ];
  
  List<Map<String, dynamic>> topProducts = [
    {
      "name": "Wireless Headphones",
      "average_rating": 4.6,
      "total_reviews": 234,
      "recent_change": 0.2,
    },
    {
      "name": "Smart Watch",
      "average_rating": 3.8,
      "total_reviews": 189,
      "recent_change": -0.3,
    },
    {
      "name": "Laptop Stand",
      "average_rating": 4.9,
      "total_reviews": 156,
      "recent_change": 0.1,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Review Analytics"),
        actions: [
          IconButton(
            icon: Icon(Icons.download),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Filter Controls
            Row(
              children: [
                Expanded(
                  child: QDropdownField(
                    label: "Time Period",
                    items: [
                      {"label": "This Week", "value": "this_week"},
                      {"label": "This Month", "value": "this_month"},
                      {"label": "Last 3 Months", "value": "3_months"},
                      {"label": "This Year", "value": "this_year"},
                    ],
                    value: selectedPeriod,
                    onChanged: (value, label) {
                      selectedPeriod = value;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QDropdownField(
                    label: "Metric",
                    items: [
                      {"label": "Average Rating", "value": "average_rating"},
                      {"label": "Total Reviews", "value": "total_reviews"},
                      {"label": "Response Rate", "value": "response_rate"},
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
            
            SizedBox(height: spMd),
            
            // Key Metrics
            ResponsiveGridView(
              padding: EdgeInsets.zero,
              minItemWidth: 200,
              children: [
                _buildMetricCard(
                  "Total Reviews",
                  "${reviewStats["total_reviews"]}",
                  "+${reviewStats["monthly_growth"]}%",
                  Icons.rate_review,
                  primaryColor,
                  true,
                ),
                _buildMetricCard(
                  "Average Rating",
                  "${reviewStats["average_rating"]}",
                  "★★★★☆",
                  Icons.star,
                  warningColor,
                  true,
                ),
                _buildMetricCard(
                  "Response Rate",
                  "${reviewStats["response_rate"]}%",
                  "High Performance",
                  Icons.reply,
                  successColor,
                  true,
                ),
              ],
            ),
            
            SizedBox(height: spMd),
            
            // Rating Distribution
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowMd],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Rating Distribution",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: spMd),
                  
                  ...List.generate(5, (index) {
                    int stars = 5 - index;
                    int count = (reviewStats["rating_distribution"]["$stars"] as int);
                    int total = reviewStats["total_reviews"] as int;
                    double percentage = count / total;
                    
                    return Container(
                      margin: EdgeInsets.only(bottom: spSm),
                      child: Row(
                        children: [
                          Container(
                            width: 20,
                            child: Text(
                              "$stars",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Icon(Icons.star, size: 16, color: warningColor),
                          SizedBox(width: spSm),
                          Expanded(
                            child: Container(
                              height: 20,
                              decoration: BoxDecoration(
                                color: disabledColor.withAlpha(50),
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: FractionallySizedBox(
                                alignment: Alignment.centerLeft,
                                widthFactor: percentage,
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: _getRatingColor(stars),
                                    borderRadius: BorderRadius.circular(radiusSm),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: spSm),
                          Container(
                            width: 60,
                            child: Text(
                              "$count (${(percentage * 100).toInt()}%)",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                              textAlign: TextAlign.end,
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
                ],
              ),
            ),
            
            SizedBox(height: spMd),
            
            // Recent Reviews
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowMd],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        "Recent Reviews",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Spacer(),
                      GestureDetector(
                        onTap: () {},
                        child: Text(
                          "View All",
                          style: TextStyle(
                            fontSize: 14,
                            color: primaryColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spMd),
                  
                  ...recentReviews.map((review) => Container(
                    margin: EdgeInsets.only(bottom: spMd),
                    padding: EdgeInsets.all(spMd),
                    decoration: BoxDecoration(
                      color: Colors.grey[50],
                      borderRadius: BorderRadius.circular(radiusLg),
                      border: Border(
                        left: BorderSide(
                          width: 4,
                          color: _getSentimentColor(review["sentiment"]),
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
                                        "${review["customer"]}",
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(width: spSm),
                                      if (review["verified"] as bool)
                                        Container(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: spSm,
                                            vertical: spXs,
                                          ),
                                          decoration: BoxDecoration(
                                            color: successColor,
                                            borderRadius: BorderRadius.circular(radiusSm),
                                          ),
                                          child: Text(
                                            "VERIFIED",
                                            style: TextStyle(
                                              fontSize: 8,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                    ],
                                  ),
                                  SizedBox(height: spXs),
                                  Row(
                                    children: [
                                      Row(
                                        children: List.generate(5, (index) => Icon(
                                          index < (review["rating"] as int) ? Icons.star : Icons.star_border,
                                          size: 14,
                                          color: index < (review["rating"] as int) ? warningColor : disabledColor,
                                        )),
                                      ),
                                      SizedBox(width: spSm),
                                      Text(
                                        "${review["product"]}",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: primaryColor,
                                          fontWeight: FontWeight.w600,
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
                                  "${(review["date"] as DateTime).dMMMy}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                SizedBox(height: spXs),
                                if (review["responded"] as bool)
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: spSm,
                                      vertical: spXs,
                                    ),
                                    decoration: BoxDecoration(
                                      color: successColor.withAlpha(20),
                                      borderRadius: BorderRadius.circular(radiusSm),
                                    ),
                                    child: Text(
                                      "RESPONDED",
                                      style: TextStyle(
                                        fontSize: 8,
                                        fontWeight: FontWeight.bold,
                                        color: successColor,
                                      ),
                                    ),
                                  )
                                else
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: spSm,
                                      vertical: spXs,
                                    ),
                                    decoration: BoxDecoration(
                                      color: warningColor.withAlpha(20),
                                      borderRadius: BorderRadius.circular(radiusSm),
                                    ),
                                    child: Text(
                                      "PENDING",
                                      style: TextStyle(
                                        fontSize: 8,
                                        fontWeight: FontWeight.bold,
                                        color: warningColor,
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: spSm),
                        Text(
                          "${review["title"]}",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "${review["content"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                        if (!(review["responded"] as bool)) ...[
                          SizedBox(height: spMd),
                          Row(
                            children: [
                              Expanded(
                                child: QButton(
                                  label: "Reply",
                                  size: bs.sm,
                                  onPressed: () {},
                                ),
                              ),
                              SizedBox(width: spSm),
                              QButton(
                                icon: Icons.more_horiz,
                                size: bs.sm,
                                onPressed: () {},
                              ),
                            ],
                          ),
                        ],
                      ],
                    ),
                  )).toList(),
                ],
              ),
            ),
            
            SizedBox(height: spMd),
            
            // Top Products
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowMd],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Product Performance",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: spMd),
                  
                  ...topProducts.map((product) => Container(
                    margin: EdgeInsets.only(bottom: spMd),
                    padding: EdgeInsets.all(spMd),
                    decoration: BoxDecoration(
                      color: Colors.grey[50],
                      borderRadius: BorderRadius.circular(radiusLg),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${product["name"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: spXs),
                              Text(
                                "${product["total_reviews"]} reviews",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Row(
                              children: [
                                Icon(Icons.star, size: 16, color: warningColor),
                                SizedBox(width: spXs),
                                Text(
                                  "${product["average_rating"]}",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: spXs),
                            Row(
                              children: [
                                Icon(
                                  (product["recent_change"] as double) >= 0 
                                      ? Icons.trending_up 
                                      : Icons.trending_down,
                                  size: 14,
                                  color: (product["recent_change"] as double) >= 0 
                                      ? successColor 
                                      : dangerColor,
                                ),
                                SizedBox(width: spXs),
                                Text(
                                  "${(product["recent_change"] as double) >= 0 ? '+' : ''}${product["recent_change"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: (product["recent_change"] as double) >= 0 
                                        ? successColor 
                                        : dangerColor,
                                  ),
                                ),
                              ],
                            ),
                          ],
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
    );
  }

  Widget _buildMetricCard(String title, String value, String subtitle, IconData icon, Color color, bool isPositive) {
    return Container(
      padding: EdgeInsets.all(spMd),
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
              Container(
                padding: EdgeInsets.all(spSm),
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
              if (title == "Total Reviews")
                Icon(
                  Icons.trending_up,
                  size: 16,
                  color: successColor,
                ),
            ],
          ),
          SizedBox(height: spMd),
          Text(
            value,
            style: TextStyle(
              fontSize: 24,
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
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: spXs),
          Text(
            subtitle,
            style: TextStyle(
              fontSize: 10,
              color: isPositive ? successColor : disabledBoldColor,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Color _getRatingColor(int rating) {
    switch (rating) {
      case 5:
        return successColor;
      case 4:
        return successColor.withAlpha(180);
      case 3:
        return warningColor;
      case 2:
        return warningColor.withAlpha(180);
      case 1:
        return dangerColor;
      default:
        return disabledColor;
    }
  }

  Color _getSentimentColor(String sentiment) {
    switch (sentiment) {
      case 'positive':
        return successColor;
      case 'negative':
        return dangerColor;
      default:
        return warningColor;
    }
  }
}
