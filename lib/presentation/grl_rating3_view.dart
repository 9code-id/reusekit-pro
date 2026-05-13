import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlRating3View extends StatefulWidget {
  @override
  State<GrlRating3View> createState() => _GrlRating3ViewState();
}

class _GrlRating3ViewState extends State<GrlRating3View> {
  String selectedPeriod = "month";
  String selectedCategory = "all";

  Map<String, dynamic> ratingStats = {
    "totalReviews": 1247,
    "averageRating": 4.3,
    "ratingDistribution": {
      "5": 612,
      "4": 389,
      "3": 156,
      "2": 67,
      "1": 23,
    },
    "monthlyGrowth": 12.5,
    "responseRate": 89.4,
  };

  List<Map<String, dynamic>> categoryStats = [
    {
      "category": "Product Quality",
      "rating": 4.5,
      "reviews": 456,
      "trend": 8.2,
      "color": successColor,
      "icon": Icons.inventory,
    },
    {
      "category": "Customer Service",
      "rating": 4.2,
      "reviews": 387,
      "trend": 5.1,
      "color": primaryColor,
      "icon": Icons.support_agent,
    },
    {
      "category": "Delivery Speed",
      "rating": 4.1,
      "reviews": 298,
      "trend": -2.3,
      "color": infoColor,
      "icon": Icons.local_shipping,
    },
    {
      "category": "Value for Money",
      "rating": 3.9,
      "reviews": 312,
      "trend": 3.7,
      "color": warningColor,
      "icon": Icons.attach_money,
    },
  ];

  List<Map<String, dynamic>> recentReviews = [
    {
      "userName": "Alex Thompson",
      "rating": 5.0,
      "comment": "Excellent product and amazing customer service!",
      "date": DateTime.now().subtract(Duration(hours: 2)),
      "category": "Product Quality",
    },
    {
      "userName": "Maria Garcia",
      "rating": 4.0,
      "comment": "Good quality but delivery was a bit slow.",
      "date": DateTime.now().subtract(Duration(hours: 5)),
      "category": "Delivery Speed",
    },
    {
      "userName": "John Kim",
      "rating": 5.0,
      "comment": "Outstanding value! Highly recommend.",
      "date": DateTime.now().subtract(Duration(hours: 8)),
      "category": "Value for Money",
    },
  ];

  List<Map<String, dynamic>> competitorData = [
    {
      "name": "Our Company",
      "rating": 4.3,
      "reviews": 1247,
      "isUs": true,
    },
    {
      "name": "Competitor A",
      "rating": 3.8,
      "reviews": 892,
      "isUs": false,
    },
    {
      "name": "Competitor B",
      "rating": 4.1,
      "reviews": 634,
      "isUs": false,
    },
    {
      "name": "Competitor C",
      "rating": 3.6,
      "reviews": 1156,
      "isUs": false,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Rating Analytics"),
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
            // Period Selector
            QCategoryPicker(
              items: [
                {"label": "Week", "value": "week"},
                {"label": "Month", "value": "month"},
                {"label": "Quarter", "value": "quarter"},
                {"label": "Year", "value": "year"},
              ],
              value: selectedPeriod,
              onChanged: (index, label, value, item) {
                selectedPeriod = value;
                setState(() {});
              },
            ),

            SizedBox(height: spMd),

            // Key Metrics Overview
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(spMd),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [primaryColor, primaryColor.withAlpha(180)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(radiusLg),
                      boxShadow: [shadowMd],
                    ),
                    child: Column(
                      children: [
                        Text(
                          "${ratingStats["averageRating"]}",
                          style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(5, (index) {
                            return Icon(
                              index < 4 ? Icons.star : Icons.star_border,
                              color: Colors.white,
                              size: 16,
                            );
                          }),
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "Average Rating",
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: Column(
                    children: [
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(spMd),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(radiusLg),
                          boxShadow: [shadowSm],
                        ),
                        child: Column(
                          children: [
                            Text(
                              "${ratingStats["totalReviews"]}",
                              style: TextStyle(
                                fontSize: fsH5,
                                fontWeight: FontWeight.bold,
                                color: successColor,
                              ),
                            ),
                            Text(
                              "Total Reviews",
                              style: TextStyle(
                                fontSize: 10,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: spSm),
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(spMd),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(radiusLg),
                          boxShadow: [shadowSm],
                        ),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.trending_up,
                                  color: successColor,
                                  size: 16,
                                ),
                                Text(
                                  "+${ratingStats["monthlyGrowth"]}%",
                                  style: TextStyle(
                                    fontSize: fsH6,
                                    fontWeight: FontWeight.bold,
                                    color: successColor,
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              "Growth",
                              style: TextStyle(
                                fontSize: 10,
                                color: disabledBoldColor,
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

            SizedBox(height: spMd),

            // Rating Distribution Chart
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
                    int count = ratingStats["ratingDistribution"]["$stars"] as int;
                    double percentage = count / (ratingStats["totalReviews"] as int);
                    
                    return Container(
                      margin: EdgeInsets.only(bottom: spSm),
                      child: Row(
                        children: [
                          Text(
                            "$stars",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(width: spXs),
                          Icon(
                            Icons.star,
                            size: 16,
                            color: warningColor,
                          ),
                          SizedBox(width: spMd),
                          Expanded(
                            child: Stack(
                              children: [
                                Container(
                                  height: 20,
                                  decoration: BoxDecoration(
                                    color: disabledColor,
                                    borderRadius: BorderRadius.circular(radiusSm),
                                  ),
                                ),
                                FractionallySizedBox(
                                  widthFactor: percentage,
                                  child: Container(
                                    height: 20,
                                    decoration: BoxDecoration(
                                      color: _getStarColor(stars),
                                      borderRadius: BorderRadius.circular(radiusSm),
                                    ),
                                  ),
                                ),
                                Positioned.fill(
                                  child: Center(
                                    child: Text(
                                      "$count (${(percentage * 100).toStringAsFixed(1)}%)",
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
                          ),
                        ],
                      ),
                    );
                  }),
                ],
              ),
            ),

            SizedBox(height: spMd),

            // Category Performance
            Text(
              "Category Performance",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),

            SizedBox(height: spSm),

            ...categoryStats.map((category) => Container(
              margin: EdgeInsets.only(bottom: spSm),
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: (category["color"] as Color).withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Icon(
                      category["icon"] as IconData,
                      color: category["color"] as Color,
                      size: 20,
                    ),
                  ),
                  SizedBox(width: spMd),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${category["category"]}",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "${category["reviews"]} reviews",
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
                          Row(
                            children: List.generate(5, (index) {
                              return Icon(
                                (category["rating"] as double) > index ? Icons.star : Icons.star_border,
                                size: 12,
                                color: warningColor,
                              );
                            }),
                          ),
                          SizedBox(width: spXs),
                          Text(
                            "${category["rating"]}",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Icon(
                            (category["trend"] as double) > 0 ? Icons.trending_up : Icons.trending_down,
                            size: 12,
                            color: (category["trend"] as double) > 0 ? successColor : dangerColor,
                          ),
                          Text(
                            "${(category["trend"] as double) > 0 ? '+' : ''}${category["trend"]}%",
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color: (category["trend"] as double) > 0 ? successColor : dangerColor,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            )).toList(),

            SizedBox(height: spMd),

            // Competitor Comparison
            Text(
              "Competitor Analysis",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),

            SizedBox(height: spSm),

            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowMd],
              ),
              child: Column(
                children: competitorData.map((competitor) => Container(
                  margin: EdgeInsets.only(bottom: spSm),
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: competitor["isUs"] as bool 
                        ? primaryColor.withAlpha(20) 
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(radiusSm),
                    border: competitor["isUs"] as bool 
                        ? Border.all(color: primaryColor.withAlpha(50))
                        : null,
                  ),
                  child: Row(
                    children: [
                      if (competitor["isUs"] as bool)
                        Container(
                          margin: EdgeInsets.only(right: spSm),
                          padding: EdgeInsets.symmetric(horizontal: spSm, vertical: 2),
                          decoration: BoxDecoration(
                            color: primaryColor,
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            "US",
                            style: TextStyle(
                              fontSize: 8,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      Expanded(
                        child: Text(
                          "${competitor["name"]}",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: competitor["isUs"] as bool ? primaryColor : null,
                          ),
                        ),
                      ),
                      Row(
                        children: List.generate(5, (index) {
                          return Icon(
                            (competitor["rating"] as double) > index ? Icons.star : Icons.star_border,
                            size: 12,
                            color: warningColor,
                          );
                        }),
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "${competitor["rating"]}",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: competitor["isUs"] as bool ? primaryColor : null,
                        ),
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "(${competitor["reviews"]})",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                )).toList(),
              ),
            ),

            SizedBox(height: spMd),

            // Recent Reviews
            Row(
              children: [
                Text(
                  "Recent Reviews",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Spacer(),
                GestureDetector(
                  onTap: () {
                    // navigateTo(AllReviewsView());
                  },
                  child: Text(
                    "View All",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: primaryColor,
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: spSm),

            ...recentReviews.map((review) => Container(
              margin: EdgeInsets.only(bottom: spSm),
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
                      Text(
                        "${review["userName"]}",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Spacer(),
                      Row(
                        children: List.generate(5, (index) {
                          return Icon(
                            (review["rating"] as double) > index ? Icons.star : Icons.star_border,
                            size: 12,
                            color: warningColor,
                          );
                        }),
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "${(review["date"] as DateTime).dMMMy}",
                        style: TextStyle(
                          fontSize: 10,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spXs),
                  Text(
                    "${review["comment"]}",
                    style: TextStyle(
                      fontSize: 14,
                      color: disabledBoldColor,
                    ),
                  ),
                  SizedBox(height: spXs),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: spSm, vertical: 2),
                    decoration: BoxDecoration(
                      color: primaryColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                    child: Text(
                      "${review["category"]}",
                      style: TextStyle(
                        fontSize: 8,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                  ),
                ],
              ),
            )).toList(),

            SizedBox(height: spMd),

            // Response Rate Card
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
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.reply,
                        color: Colors.white,
                        size: 24,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "Response Rate",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "${ratingStats["responseRate"]}%",
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    "of reviews get responses",
                    style: TextStyle(
                      color: Colors.white70,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _getStarColor(int stars) {
    switch (stars) {
      case 5:
        return successColor;
      case 4:
        return primaryColor;
      case 3:
        return warningColor;
      case 2:
        return Colors.orange;
      case 1:
        return dangerColor;
      default:
        return primaryColor;
    }
  }
}
