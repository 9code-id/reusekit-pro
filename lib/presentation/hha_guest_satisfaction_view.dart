import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class HhaGuestSatisfactionView extends StatefulWidget {
  const HhaGuestSatisfactionView({super.key});

  @override
  State<HhaGuestSatisfactionView> createState() => _HhaGuestSatisfactionViewState();
}

class _HhaGuestSatisfactionViewState extends State<HhaGuestSatisfactionView> {
  String selectedPeriod = "This Month";
  String selectedRating = "All";
  bool loading = false;
  int currentTab = 0;

  List<Map<String, dynamic>> periodOptions = [
    {"label": "Last 7 Days", "value": "Last 7 Days"},
    {"label": "This Month", "value": "This Month"},
    {"label": "Last Month", "value": "Last Month"},
    {"label": "This Quarter", "value": "This Quarter"},
    {"label": "This Year", "value": "This Year"},
  ];

  List<Map<String, dynamic>> ratingOptions = [
    {"label": "All Ratings", "value": "All"},
    {"label": "5 Stars", "value": "5"},
    {"label": "4 Stars", "value": "4"},
    {"label": "3 Stars", "value": "3"},
    {"label": "2 Stars", "value": "2"},
    {"label": "1 Star", "value": "1"},
  ];

  List<Map<String, dynamic>> satisfactionMetrics = [
    {
      "title": "Overall Satisfaction",
      "value": 4.7,
      "change": 0.3,
      "total": 324,
      "icon": Icons.star,
      "color": 0xFFFFD700,
      "maxValue": 5.0,
    },
    {
      "title": "Service Quality",
      "value": 4.8,
      "change": 0.2,
      "total": 298,
      "icon": Icons.room_service,
      "color": 0xFF4CAF50,
      "maxValue": 5.0,
    },
    {
      "title": "Cleanliness",
      "value": 4.6,
      "change": 0.1,
      "total": 312,
      "icon": Icons.cleaning_services,
      "color": 0xFF2196F3,
      "maxValue": 5.0,
    },
    {
      "title": "Value for Money",
      "value": 4.4,
      "change": -0.1,
      "total": 287,
      "icon": Icons.attach_money,
      "color": 0xFFFF9800,
      "maxValue": 5.0,
    },
  ];

  List<Map<String, dynamic>> ratingDistribution = [
    {"stars": 5, "count": 187, "percentage": 57.7},
    {"stars": 4, "count": 89, "percentage": 27.5},
    {"stars": 3, "count": 32, "percentage": 9.9},
    {"stars": 2, "count": 12, "percentage": 3.7},
    {"stars": 1, "count": 4, "percentage": 1.2},
  ];

  List<Map<String, dynamic>> categoryRatings = [
    {"category": "Room Quality", "rating": 4.6, "reviews": 298},
    {"category": "Staff Service", "rating": 4.8, "reviews": 312},
    {"category": "Food & Beverage", "rating": 4.5, "reviews": 245},
    {"category": "Location", "rating": 4.7, "reviews": 289},
    {"category": "Amenities", "rating": 4.4, "reviews": 267},
    {"category": "Check-in/out", "rating": 4.9, "reviews": 301},
  ];

  List<Map<String, dynamic>> recentReviews = [
    {
      "id": "1",
      "guestName": "John Smith",
      "rating": 5,
      "title": "Exceptional Service!",
      "comment": "The staff went above and beyond to make our stay memorable. The room was spotless and the amenities were top-notch.",
      "date": "2024-03-15T14:30:00Z",
      "roomType": "Deluxe Suite",
      "stayDuration": 3,
      "verified": true,
    },
    {
      "id": "2",
      "guestName": "Sarah Johnson",
      "rating": 4,
      "title": "Great location, minor issues",
      "comment": "Perfect location and friendly staff. The only issue was the slow Wi-Fi in our room, but overall a pleasant stay.",
      "date": "2024-03-14T09:15:00Z",
      "roomType": "Standard Room",
      "stayDuration": 2,
      "verified": true,
    },
    {
      "id": "3",
      "guestName": "Michael Chen",
      "rating": 5,
      "title": "Outstanding experience",
      "comment": "From check-in to check-out, everything was perfect. The breakfast was delicious and the spa services were excellent.",
      "date": "2024-03-13T16:45:00Z",
      "roomType": "Executive Suite",
      "stayDuration": 4,
      "verified": true,
    },
    {
      "id": "4",
      "guestName": "Emma Wilson",
      "rating": 3,
      "title": "Average stay",
      "comment": "The hotel is decent but could use some improvements. The air conditioning in our room wasn't working properly.",
      "date": "2024-03-12T11:20:00Z",
      "roomType": "Standard Room",
      "stayDuration": 1,
      "verified": false,
    },
  ];

  List<Map<String, dynamic>> monthlyTrends = [
    {"month": "Oct", "rating": 4.3, "reviews": 298},
    {"month": "Nov", "rating": 4.4, "reviews": 312},
    {"month": "Dec", "rating": 4.5, "reviews": 289},
    {"month": "Jan", "rating": 4.4, "reviews": 267},
    {"month": "Feb", "rating": 4.6, "reviews": 301},
    {"month": "Mar", "rating": 4.7, "reviews": 324},
  ];

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Guest Satisfaction",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Overview", icon: Icon(Icons.dashboard)),
        Tab(text: "Reviews", icon: Icon(Icons.rate_review)),
        Tab(text: "Analytics", icon: Icon(Icons.analytics)),
      ],
      tabChildren: [
        _buildOverviewTab(),
        _buildReviewsTab(),
        _buildAnalyticsTab(),
      ],
    );
  }

  Widget _buildOverviewTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Period Filter
          Row(
            children: [
              Expanded(
                child: QDropdownField(
                  label: "Time Period",
                  items: periodOptions,
                  value: selectedPeriod,
                  onChanged: (value, label) {
                    selectedPeriod = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              QButton(
                label: "Export",
                icon: Icons.download,
                size: bs.sm,
                onPressed: () {},
              ),
            ],
          ),
          SizedBox(height: spLg),

          // Satisfaction Metrics
          Text(
            "Satisfaction Metrics",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: satisfactionMetrics.map((metric) {
              final isPositive = (metric["change"] as double) >= 0;
              final rating = (metric["value"] as double);
              final percentage = (rating / (metric["maxValue"] as double)) * 100;
              
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
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: Color(metric["color"] as int).withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Icon(
                            metric["icon"] as IconData,
                            color: Color(metric["color"] as int),
                            size: 20,
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Text(
                            "${metric["title"]}",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spSm),
                    
                    Row(
                      children: [
                        Text(
                          "${rating.toStringAsFixed(1)}",
                          style: TextStyle(
                            fontSize: fsH4,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        SizedBox(width: spXs),
                        ...List.generate(5, (index) {
                          return Icon(
                            Icons.star,
                            size: 16,
                            color: index < rating.floor() 
                              ? Color(metric["color"] as int)
                              : disabledColor,
                          );
                        }),
                      ],
                    ),
                    SizedBox(height: spXs),
                    
                    Row(
                      children: [
                        Icon(
                          isPositive ? Icons.arrow_upward : Icons.arrow_downward,
                          color: isPositive ? successColor : dangerColor,
                          size: 16,
                        ),
                        SizedBox(width: spXs),
                        Text(
                          "${isPositive ? '+' : ''}${(metric["change"] as double).toStringAsFixed(1)}",
                          style: TextStyle(
                            fontSize: 12,
                            color: isPositive ? successColor : dangerColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(width: spSm),
                        Text(
                          "${metric["total"]} reviews",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
          SizedBox(height: spLg),

          // Rating Distribution
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
                  "Rating Distribution",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spMd),
                
                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: ratingDistribution.length,
                  itemBuilder: (context, index) {
                    final rating = ratingDistribution[index];
                    final stars = (rating["stars"] as int);
                    final count = (rating["count"] as int);
                    final percentage = (rating["percentage"] as double);
                    
                    return Container(
                      margin: EdgeInsets.only(bottom: spSm),
                      child: Row(
                        children: [
                          Container(
                            width: 60,
                            child: Row(
                              children: [
                                Text(
                                  "$stars",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                                SizedBox(width: spXs),
                                Icon(Icons.star, color: warningColor, size: 16),
                              ],
                            ),
                          ),
                          
                          Expanded(
                            child: Container(
                              height: 20,
                              decoration: BoxDecoration(
                                color: disabledColor,
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: FractionallySizedBox(
                                alignment: Alignment.centerLeft,
                                widthFactor: percentage / 100,
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: stars >= 4 ? successColor :
                                           stars == 3 ? warningColor : dangerColor,
                                    borderRadius: BorderRadius.circular(radiusSm),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: spSm),
                          
                          Container(
                            width: 80,
                            child: Text(
                              "$count (${percentage.toStringAsFixed(1)}%)",
                              textAlign: TextAlign.end,
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          SizedBox(height: spLg),

          // Category Ratings
          Text(
            "Category Ratings",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: categoryRatings.map((category) {
              final rating = (category["rating"] as double);
              final reviews = (category["reviews"] as int);
              
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
                    Text(
                      "${category["category"]}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spSm),
                    
                    Row(
                      children: [
                        Text(
                          "${rating.toStringAsFixed(1)}",
                          style: TextStyle(
                            fontSize: fsH5,
                            fontWeight: FontWeight.bold,
                            color: rating >= 4.5 ? successColor :
                                   rating >= 4.0 ? warningColor : dangerColor,
                          ),
                        ),
                        SizedBox(width: spXs),
                        ...List.generate(5, (index) {
                          return Icon(
                            Icons.star,
                            size: 16,
                            color: index < rating.floor() 
                              ? warningColor
                              : disabledColor,
                          );
                        }),
                      ],
                    ),
                    SizedBox(height: spXs),
                    
                    Text(
                      "$reviews reviews",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildReviewsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Filter and Search
          Row(
            children: [
              Expanded(
                child: QDropdownField(
                  label: "Filter by Rating",
                  items: ratingOptions,
                  value: selectedRating,
                  onChanged: (value, label) {
                    selectedRating = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              QButton(
                label: "Respond",
                icon: Icons.reply,
                size: bs.sm,
                onPressed: () {
                  // navigateTo(HhaRespondToReviewView());
                },
              ),
            ],
          ),
          SizedBox(height: spLg),

          // Recent Reviews
          Text(
            "Recent Reviews",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: recentReviews.length,
            itemBuilder: (context, index) {
              final review = recentReviews[index];
              final rating = (review["rating"] as int);
              
              return Container(
                margin: EdgeInsets.only(bottom: spMd),
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                  border: Border(
                    left: BorderSide(
                      width: 4,
                      color: rating >= 4 ? successColor :
                             rating == 3 ? warningColor : dangerColor,
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
                                    "${review["guestName"]}",
                                    style: TextStyle(
                                      fontSize: fsH6,
                                      fontWeight: FontWeight.bold,
                                      color: primaryColor,
                                    ),
                                  ),
                                  if (review["verified"] == true) ...[
                                    SizedBox(width: spXs),
                                    Icon(
                                      Icons.verified,
                                      color: successColor,
                                      size: 16,
                                    ),
                                  ],
                                ],
                              ),
                              SizedBox(height: spXs),
                              Row(
                                children: [
                                  ...List.generate(5, (starIndex) {
                                    return Icon(
                                      Icons.star,
                                      size: 16,
                                      color: starIndex < rating 
                                        ? warningColor
                                        : disabledColor,
                                    );
                                  }),
                                  SizedBox(width: spSm),
                                  Text(
                                    "${DateTime.parse(review["date"] as String).dMMMy}",
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
                        
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: spSm,
                            vertical: spXs,
                          ),
                          decoration: BoxDecoration(
                            color: infoColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Text(
                            "${review["roomType"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: infoColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spSm),
                    
                    Text(
                      "${review["title"]}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    
                    Text(
                      "${review["comment"]}",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                        height: 1.4,
                      ),
                    ),
                    SizedBox(height: spSm),
                    
                    Row(
                      children: [
                        Text(
                          "Stay duration: ${review["stayDuration"]} night${(review["stayDuration"] as int) > 1 ? 's' : ''}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                        Spacer(),
                        QButton(
                          label: "Respond",
                          size: bs.sm,
                          onPressed: () {
                            // navigateTo(HhaRespondToReviewView(reviewId: review["id"]));
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildAnalyticsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Monthly Trends
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
                  "Satisfaction Trends",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spMd),
                
                Container(
                  height: 200,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: monthlyTrends.length,
                    itemBuilder: (context, index) {
                      final trend = monthlyTrends[index];
                      final rating = (trend["rating"] as double);
                      final height = (rating / 5.0) * 150;
                      
                      return Container(
                        width: 80,
                        margin: EdgeInsets.only(right: spMd),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              "${rating.toStringAsFixed(1)}",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(height: spXs),
                            Container(
                              width: 30,
                              height: height,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.bottomCenter,
                                  end: Alignment.topCenter,
                                  colors: [
                                    warningColor,
                                    warningColor.withAlpha(150),
                                  ],
                                ),
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                            ),
                            SizedBox(height: spXs),
                            Text(
                              "${trend["month"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                            Text(
                              "${trend["reviews"]}",
                              style: TextStyle(
                                fontSize: 10,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: spLg),

          // Satisfaction Insights
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
                  "Key Insights",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spSm),
                
                _buildInsightItem(
                  "Guest satisfaction increased by 0.3 points this month",
                  "Staff service improvements are showing positive results",
                  Icons.trending_up,
                  successColor,
                ),
                _buildInsightItem(
                  "Room quality ratings could be improved",
                  "Consider renovating older rooms and updating amenities",
                  Icons.room,
                  warningColor,
                ),
                _buildInsightItem(
                  "Check-in/out process receives highest ratings",
                  "Front desk efficiency is a major strength",
                  Icons.check_circle,
                  infoColor,
                ),
                _buildInsightItem(
                  "Value for money perception needs attention",
                  "Review pricing strategy or enhance service offerings",
                  Icons.attach_money,
                  dangerColor,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInsightItem(String title, String description, IconData icon, Color color) {
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: color.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: color.withAlpha(30)),
      ),
      child: Row(
        children: [
          Icon(icon, color: color, size: 20),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spXs),
                Text(
                  description,
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
    );
  }
}
