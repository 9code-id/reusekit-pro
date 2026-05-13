import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlReview8View extends StatefulWidget {
  @override
  State<GrlReview8View> createState() => _GrlReview8ViewState();
}

class _GrlReview8ViewState extends State<GrlReview8View> {
  String selectedCategory = "all";
  String selectedRating = "all";
  String sortBy = "newest";
  
  List<Map<String, dynamic>> competitorReviews = [
    {
      "id": 1,
      "business": "Digital Marketing Pro",
      "category": "Marketing Agency",
      "rating": 4.7,
      "total_reviews": 234,
      "recent_reviews": [
        {
          "rating": 5,
          "title": "Excellent ROI on our campaigns",
          "content": "Their team delivered exceptional results for our digital marketing campaigns. Highly professional and results-driven.",
          "date": DateTime.now().subtract(Duration(days: 1)),
          "customer": "Tech Startup CEO",
        },
        {
          "rating": 4,
          "title": "Good service, room for improvement",
          "content": "Solid marketing strategies but communication could be better. Overall satisfied with the results.",
          "date": DateTime.now().subtract(Duration(days: 3)),
          "customer": "E-commerce Owner",
        },
      ],
      "strengths": ["ROI Performance", "Campaign Strategy", "Analytics"],
      "weaknesses": ["Communication", "Response Time"],
      "avg_response_rate": 78.5,
    },
    {
      "id": 2,
      "business": "Creative Solutions Hub",
      "category": "Design Agency",
      "rating": 4.2,
      "total_reviews": 189,
      "recent_reviews": [
        {
          "rating": 5,
          "title": "Outstanding creative work",
          "content": "The design team created an amazing brand identity for us. Very creative and professional approach.",
          "date": DateTime.now().subtract(Duration(days: 2)),
          "customer": "Restaurant Owner",
        },
        {
          "rating": 3,
          "title": "Good designs but slow delivery",
          "content": "Quality is good but they missed several deadlines. Need better project management.",
          "date": DateTime.now().subtract(Duration(days: 5)),
          "customer": "Marketing Director",
        },
      ],
      "strengths": ["Creativity", "Design Quality", "Brand Strategy"],
      "weaknesses": ["Project Management", "Deadlines"],
      "avg_response_rate": 45.2,
    },
    {
      "id": 3,
      "business": "TechForward Consulting",
      "category": "IT Consulting",
      "rating": 4.9,
      "total_reviews": 156,
      "recent_reviews": [
        {
          "rating": 5,
          "title": "Transformed our IT infrastructure",
          "content": "Exceptional service and expertise. They modernized our entire IT setup efficiently and professionally.",
          "date": DateTime.now().subtract(Duration(hours: 12)),
          "customer": "Manufacturing CEO",
        },
        {
          "rating": 5,
          "title": "Highly recommend for any IT needs",
          "content": "Professional, knowledgeable, and reliable. Best IT consulting experience we've ever had.",
          "date": DateTime.now().subtract(Duration(days: 1)),
          "customer": "Healthcare Admin",
        },
      ],
      "strengths": ["Technical Expertise", "Project Management", "Customer Service"],
      "weaknesses": ["Pricing", "Availability"],
      "avg_response_rate": 92.3,
    },
  ];
  
  Map<String, dynamic> comparisonData = {
    "our_business": {
      "name": "Your Business",
      "rating": 4.3,
      "total_reviews": 247,
      "response_rate": 89.2,
      "recent_growth": 12.5,
    },
    "industry_average": {
      "rating": 4.1,
      "response_rate": 67.8,
      "monthly_growth": 8.3,
    },
  };

  @override
  Widget build(BuildContext context) {
    final filteredCompetitors = _getFilteredCompetitors();
    
    return Scaffold(
      appBar: AppBar(
        title: Text("Competitor Analysis"),
        actions: [
          IconButton(
            icon: Icon(Icons.analytics),
            onPressed: () {
              _showDetailedAnalytics();
            },
          ),
          IconButton(
            icon: Icon(Icons.download),
            onPressed: () {
              _exportReport();
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Performance Comparison
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [primaryColor, primaryColor.withAlpha(180)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(radiusLg),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Your Performance vs Industry",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: spMd),
                  
                  Row(
                    children: [
                      Expanded(
                        child: _buildComparisonCard(
                          "Average Rating",
                          "${comparisonData["our_business"]["rating"]}",
                          "${comparisonData["industry_average"]["rating"]}",
                          true,
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: _buildComparisonCard(
                          "Response Rate",
                          "${comparisonData["our_business"]["response_rate"]}%",
                          "${comparisonData["industry_average"]["response_rate"]}%",
                          true,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  Row(
                    children: [
                      Expanded(
                        child: _buildComparisonCard(
                          "Total Reviews",
                          "${comparisonData["our_business"]["total_reviews"]}",
                          "Industry Avg: 156",
                          true,
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: _buildComparisonCard(
                          "Monthly Growth",
                          "+${comparisonData["our_business"]["recent_growth"]}%",
                          "+${comparisonData["industry_average"]["monthly_growth"]}%",
                          true,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            
            SizedBox(height: spMd),
            
            // Filters
            Row(
              children: [
                Expanded(
                  child: QDropdownField(
                    label: "Category",
                    items: [
                      {"label": "All Categories", "value": "all"},
                      {"label": "Marketing Agency", "value": "marketing"},
                      {"label": "Design Agency", "value": "design"},
                      {"label": "IT Consulting", "value": "it"},
                    ],
                    value: selectedCategory,
                    onChanged: (value, label) {
                      selectedCategory = value;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QDropdownField(
                    label: "Rating",
                    items: [
                      {"label": "All Ratings", "value": "all"},
                      {"label": "5 Stars", "value": "5"},
                      {"label": "4+ Stars", "value": "4"},
                      {"label": "3+ Stars", "value": "3"},
                    ],
                    value: selectedRating,
                    onChanged: (value, label) {
                      selectedRating = value;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),
            
            SizedBox(height: spMd),
            
            // Competitor List
            Text(
              "Competitor Analysis",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
              ),
            ),
            
            SizedBox(height: spMd),
            
            ...filteredCompetitors.map((competitor) => Container(
              margin: EdgeInsets.only(bottom: spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowMd],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Competitor Header
                  Padding(
                    padding: EdgeInsets.all(spMd),
                    child: Row(
                      children: [
                        Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            color: _getCategoryColor(competitor["category"]).withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusLg),
                          ),
                          child: Icon(
                            _getCategoryIcon(competitor["category"]),
                            color: _getCategoryColor(competitor["category"]),
                            size: 28,
                          ),
                        ),
                        SizedBox(width: spMd),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${competitor["business"]}",
                                style: TextStyle(
                                  fontSize: fsH6,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: spXs),
                              Text(
                                "${competitor["category"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: _getCategoryColor(competitor["category"]),
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(height: spSm),
                              Row(
                                children: [
                                  Row(
                                    children: List.generate(5, (index) => Icon(
                                      index < (competitor["rating"] as double).floor() ? Icons.star : Icons.star_border,
                                      size: 14,
                                      color: warningColor,
                                    )),
                                  ),
                                  SizedBox(width: spSm),
                                  Text(
                                    "${competitor["rating"]}",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(width: spXs),
                                  Text(
                                    "(${competitor["total_reviews"]})",
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
                              padding: EdgeInsets.symmetric(
                                horizontal: spSm,
                                vertical: spXs,
                              ),
                              decoration: BoxDecoration(
                                color: _getPerformanceColor(competitor["avg_response_rate"]).withAlpha(20),
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Text(
                                "${competitor["avg_response_rate"]}% Response",
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                  color: _getPerformanceColor(competitor["avg_response_rate"]),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  
                  // Strengths & Weaknesses
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(spMd),
                    decoration: BoxDecoration(
                      color: Colors.grey[50],
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
                                      Icon(Icons.thumb_up, size: 16, color: successColor),
                                      SizedBox(width: spXs),
                                      Text(
                                        "Strengths",
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: successColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: spSm),
                                  Wrap(
                                    spacing: spXs,
                                    runSpacing: spXs,
                                    children: (competitor["strengths"] as List).map((strength) => Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: spSm,
                                        vertical: spXs,
                                      ),
                                      decoration: BoxDecoration(
                                        color: successColor.withAlpha(20),
                                        borderRadius: BorderRadius.circular(radiusSm),
                                      ),
                                      child: Text(
                                        "$strength",
                                        style: TextStyle(
                                          fontSize: 10,
                                          color: successColor,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    )).toList(),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(width: spMd),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Icon(Icons.thumb_down, size: 16, color: dangerColor),
                                      SizedBox(width: spXs),
                                      Text(
                                        "Weaknesses",
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: dangerColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: spSm),
                                  Wrap(
                                    spacing: spXs,
                                    runSpacing: spXs,
                                    children: (competitor["weaknesses"] as List).map((weakness) => Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: spSm,
                                        vertical: spXs,
                                      ),
                                      decoration: BoxDecoration(
                                        color: dangerColor.withAlpha(20),
                                        borderRadius: BorderRadius.circular(radiusSm),
                                      ),
                                      child: Text(
                                        "$weakness",
                                        style: TextStyle(
                                          fontSize: 10,
                                          color: dangerColor,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    )).toList(),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  
                  // Recent Reviews
                  Padding(
                    padding: EdgeInsets.all(spMd),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Recent Reviews",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: spMd),
                        
                        ...(competitor["recent_reviews"] as List).take(2).map((review) => Container(
                          margin: EdgeInsets.only(bottom: spSm),
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: Colors.grey[100],
                            borderRadius: BorderRadius.circular(radiusLg),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Row(
                                    children: List.generate(5, (index) => Icon(
                                      index < (review["rating"] as int) ? Icons.star : Icons.star_border,
                                      size: 12,
                                      color: warningColor,
                                    )),
                                  ),
                                  SizedBox(width: spSm),
                                  Expanded(
                                    child: Text(
                                      "${review["title"]}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
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
                                "${review["content"]}",
                                style: TextStyle(
                                  fontSize: 11,
                                  color: disabledBoldColor,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              SizedBox(height: spXs),
                              Text(
                                "- ${review["customer"]}",
                                style: TextStyle(
                                  fontSize: 10,
                                  fontStyle: FontStyle.italic,
                                  color: primaryColor,
                                ),
                              ),
                            ],
                          ),
                        )).toList(),
                        
                        SizedBox(height: spMd),
                        
                        Row(
                          children: [
                            Expanded(
                              child: QButton(
                                label: "View All Reviews",
                                size: bs.sm,
                                onPressed: () {},
                              ),
                            ),
                            SizedBox(width: spSm),
                            QButton(
                              icon: Icons.compare,
                              size: bs.sm,
                              onPressed: () {
                                _compareWithBusiness(competitor);
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )).toList(),
            
            SizedBox(height: spMd),
            
            // Insights
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: infoColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusLg),
                border: Border.all(color: infoColor.withAlpha(50)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.insights,
                        size: 20,
                        color: infoColor,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "Key Insights",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: infoColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "• Your response rate (89.2%) is above industry average (67.8%)\n• Focus on improving areas where competitors excel\n• Learn from their customer service strategies\n• Monitor competitor review trends regularly",
                    style: TextStyle(
                      fontSize: 12,
                      color: infoColor,
                      height: 1.5,
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

  Widget _buildComparisonCard(String title, String yourValue, String benchmarkValue, bool isPositive) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white.withAlpha(50),
        borderRadius: BorderRadius.circular(radiusLg),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 10,
              color: Colors.white70,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: spXs),
          Text(
            yourValue,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          SizedBox(height: spXs),
          Text(
            benchmarkValue,
            style: TextStyle(
              fontSize: 10,
              color: Colors.white70,
            ),
          ),
        ],
      ),
    );
  }

  List<Map<String, dynamic>> _getFilteredCompetitors() {
    List<Map<String, dynamic>> filtered = competitorReviews;
    
    if (selectedCategory != "all") {
      String categoryFilter = selectedCategory == "marketing" ? "Marketing Agency" 
                            : selectedCategory == "design" ? "Design Agency"
                            : selectedCategory == "it" ? "IT Consulting" : "";
      if (categoryFilter.isNotEmpty) {
        filtered = filtered.where((c) => c["category"] == categoryFilter).toList();
      }
    }
    
    if (selectedRating != "all") {
      double minRating = double.parse(selectedRating);
      filtered = filtered.where((c) => (c["rating"] as double) >= minRating).toList();
    }
    
    return filtered;
  }

  Color _getCategoryColor(String category) {
    switch (category) {
      case 'Marketing Agency':
        return primaryColor;
      case 'Design Agency':
        return successColor;
      case 'IT Consulting':
        return infoColor;
      default:
        return disabledColor;
    }
  }

  IconData _getCategoryIcon(String category) {
    switch (category) {
      case 'Marketing Agency':
        return Icons.campaign;
      case 'Design Agency':
        return Icons.design_services;
      case 'IT Consulting':
        return Icons.computer;
      default:
        return Icons.business;
    }
  }

  Color _getPerformanceColor(double responseRate) {
    if (responseRate >= 80) return successColor;
    if (responseRate >= 60) return warningColor;
    return dangerColor;
  }

  void _compareWithBusiness(Map<String, dynamic> competitor) {
    ss("Detailed comparison with ${competitor["business"]} opened");
  }

  void _showDetailedAnalytics() {
    ss("Detailed analytics view opened");
  }

  void _exportReport() {
    ss("Competition analysis report exported");
  }
}
