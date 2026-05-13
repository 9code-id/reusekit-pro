import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlCategory10View extends StatefulWidget {
  @override
  State<GrlCategory10View> createState() => _GrlCategory10ViewState();
}

class _GrlCategory10ViewState extends State<GrlCategory10View> {
  String selectedView = 'categories';
  String selectedSort = 'popularity';
  
  List<Map<String, dynamic>> categoryComparison = [
    {
      "name": "Social Media",
      "icon": Icons.share,
      "color": 0xFF1976D2,
      "apps": 567,
      "marketShare": 28.5,
      "revenue": 45.2,
      "growth": 12.3,
      "userRetention": 78,
      "avgRating": 4.2,
      "satisfaction": 82,
      "competitionLevel": "Very High",
      "entryBarrier": "High",
      "innovationRate": 85,
      "strengths": ["Network Effects", "User Engagement", "Ad Revenue"],
      "challenges": ["Privacy Concerns", "Content Moderation", "Market Saturation"],
      "opportunities": ["Video Content", "AR Filters", "Creator Economy"],
      "threats": ["Regulation", "Platform Fatigue", "Competition"],
    },
    {
      "name": "E-commerce",
      "icon": Icons.shopping_cart,
      "color": 0xFF388E3C,
      "apps": 342,
      "marketShare": 22.1,
      "revenue": 52.8,
      "growth": 18.7,
      "userRetention": 85,
      "avgRating": 4.4,
      "satisfaction": 89,
      "competitionLevel": "High",
      "entryBarrier": "Medium",
      "innovationRate": 79,
      "strengths": ["Mobile Commerce", "Quick Delivery", "Payment Integration"],
      "challenges": ["Logistics", "Customer Service", "Return Management"],
      "opportunities": ["Live Shopping", "Social Commerce", "Sustainability"],
      "threats": ["Economic Downturn", "Supply Chain", "Platform Dominance"],
    },
    {
      "name": "Fintech",
      "icon": Icons.account_balance,
      "color": 0xFFE91E63,
      "apps": 234,
      "marketShare": 15.3,
      "revenue": 38.9,
      "growth": 24.2,
      "userRetention": 72,
      "avgRating": 4.6,
      "satisfaction": 87,
      "competitionLevel": "Medium",
      "entryBarrier": "Very High",
      "innovationRate": 92,
      "strengths": ["Digital Payments", "Investment Tools", "Security"],
      "challenges": ["Regulation", "Trust Building", "Compliance"],
      "opportunities": ["Crypto Integration", "SME Services", "Insurance"],
      "threats": ["Banking Competition", "Regulation Changes", "Economic Volatility"],
    },
    {
      "name": "Health & Fitness",
      "icon": Icons.fitness_center,
      "color": 0xFFFF9800,
      "apps": 445,
      "marketShare": 18.7,
      "revenue": 28.4,
      "growth": 16.8,
      "userRetention": 69,
      "avgRating": 4.5,
      "satisfaction": 84,
      "competitionLevel": "Medium",
      "entryBarrier": "Low",
      "innovationRate": 76,
      "strengths": ["Health Awareness", "Wearable Integration", "Personalization"],
      "challenges": ["User Motivation", "Data Privacy", "Medical Accuracy"],
      "opportunities": ["Mental Health", "Telemedicine", "Corporate Wellness"],
      "threats": ["Medical Regulation", "Insurance Issues", "Liability"],
    },
    {
      "name": "Entertainment",
      "icon": Icons.movie,
      "color": 0xFF9C27B0,
      "apps": 789,
      "marketShare": 31.2,
      "revenue": 62.7,
      "growth": 8.9,
      "userRetention": 91,
      "avgRating": 4.1,
      "satisfaction": 86,
      "competitionLevel": "Very High",
      "entryBarrier": "High",
      "innovationRate": 73,
      "strengths": ["Content Library", "Streaming Quality", "Original Content"],
      "challenges": ["Content Costs", "Piracy", "Competition"],
      "opportunities": ["Interactive Content", "Global Expansion", "Gaming"],
      "threats": ["Content Wars", "Economic Impact", "Cord Cutting"],
    },
    {
      "name": "Productivity",
      "icon": Icons.work,
      "color": 0xFF795548,
      "apps": 298,
      "marketShare": 12.8,
      "revenue": 34.6,
      "growth": 14.5,
      "userRetention": 74,
      "avgRating": 4.7,
      "satisfaction": 91,
      "competitionLevel": "High",
      "entryBarrier": "Medium",
      "innovationRate": 88,
      "strengths": ["Remote Work", "Collaboration", "Automation"],
      "challenges": ["User Adoption", "Feature Complexity", "Integration"],
      "opportunities": ["AI Integration", "No-Code Tools", "Mobile-First"],
      "threats": ["Big Tech Competition", "Economic Downturn", "Feature Creep"],
    },
  ];

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Category Analysis",
      selectedIndex: selectedView == 'categories' ? 0 : selectedView == 'comparison' ? 1 : 2,
      tabs: [
        Tab(text: "Overview", icon: Icon(Icons.dashboard)),
        Tab(text: "Comparison", icon: Icon(Icons.compare)),
        Tab(text: "SWOT Analysis", icon: Icon(Icons.analytics)),
      ],
      tabChildren: [
        _buildOverviewTab(),
        _buildComparisonTab(),
        _buildSWOTAnalysisTab(),
      ],
    );
  }

  Widget _buildOverviewTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Market Overview Card
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
                Row(
                  children: [
                    Icon(
                      Icons.pie_chart,
                      color: Colors.white,
                      size: 28,
                    ),
                    SizedBox(width: spMd),
                    Text(
                      "App Market Analysis",
                      style: TextStyle(
                        fontSize: fsH5,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spMd),
                Text(
                  "Comprehensive analysis of major app categories based on market share, revenue potential, and growth trends",
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white70,
                  ),
                ),
                SizedBox(height: spMd),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          Text(
                            "${categoryComparison.length}",
                            style: TextStyle(
                              fontSize: fsH3,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            "Categories",
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.white70,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          Text(
                            "${categoryComparison.fold(0, (sum, cat) => sum + (cat["apps"] as int))}",
                            style: TextStyle(
                              fontSize: fsH3,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            "Total Apps",
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.white70,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          Text(
                            "\$${categoryComparison.fold(0.0, (sum, cat) => sum + (cat["revenue"] as double)).toStringAsFixed(1)}B",
                            style: TextStyle(
                              fontSize: fsH3,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            "Revenue",
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.white70,
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
          
          SizedBox(height: spMd),
          
          // Sort Options
          Row(
            children: [
              Text(
                "Sort by:",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: primaryColor,
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QHorizontalScroll(
                  children: ['popularity', 'revenue', 'growth', 'rating'].map((sort) => Container(
                    margin: EdgeInsets.only(right: spSm),
                    child: GestureDetector(
                      onTap: () {
                        selectedSort = sort;
                        setState(() {});
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: spMd,
                          vertical: spSm,
                        ),
                        decoration: BoxDecoration(
                          color: selectedSort == sort ? successColor : Colors.grey[100],
                          borderRadius: BorderRadius.circular(radiusLg),
                        ),
                        child: Text(
                          sort.toUpperCase(),
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: selectedSort == sort ? Colors.white : disabledBoldColor,
                          ),
                        ),
                      ),
                    ),
                  )).toList(),
                ),
              ),
            ],
          ),
          
          SizedBox(height: spMd),
          
          // Category Cards
          ...categoryComparison.map((category) {
            Color categoryColor = Color(category["color"] as int);
            
            return Container(
              margin: EdgeInsets.only(bottom: spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowMd],
              ),
              child: Column(
                children: [
                  // Header
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(spMd),
                    decoration: BoxDecoration(
                      color: categoryColor.withAlpha(20),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(radiusLg),
                        topRight: Radius.circular(radiusLg),
                      ),
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: categoryColor,
                            borderRadius: BorderRadius.circular(radiusLg),
                          ),
                          child: Icon(
                            category["icon"] as IconData,
                            color: Colors.white,
                            size: 24,
                          ),
                        ),
                        SizedBox(width: spMd),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${category["name"]}",
                                style: TextStyle(
                                  fontSize: fsH6,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                              Text(
                                "${category["apps"]} apps • ${category["marketShare"]}% market share",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: spSm,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: _getCompetitionLevelColor(category["competitionLevel"]).withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Text(
                            "${category["competitionLevel"]}",
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color: _getCompetitionLevelColor(category["competitionLevel"]),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  
                  // Content
                  Padding(
                    padding: EdgeInsets.all(spMd),
                    child: Column(
                      children: [
                        // Key Metrics Row
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                children: [
                                  Text(
                                    "\$${category["revenue"]}B",
                                    style: TextStyle(
                                      fontSize: fsH6,
                                      fontWeight: FontWeight.bold,
                                      color: categoryColor,
                                    ),
                                  ),
                                  Text(
                                    "Revenue",
                                    style: TextStyle(
                                      fontSize: 10,
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
                                    "+${category["growth"]}%",
                                    style: TextStyle(
                                      fontSize: fsH6,
                                      fontWeight: FontWeight.bold,
                                      color: successColor,
                                    ),
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
                            Expanded(
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.star,
                                        size: 14,
                                        color: warningColor,
                                      ),
                                      SizedBox(width: 2),
                                      Text(
                                        "${category["avgRating"]}",
                                        style: TextStyle(
                                          fontSize: fsH6,
                                          fontWeight: FontWeight.bold,
                                          color: categoryColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    "Rating",
                                    style: TextStyle(
                                      fontSize: 10,
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
                                    "${category["userRetention"]}%",
                                    style: TextStyle(
                                      fontSize: fsH6,
                                      fontWeight: FontWeight.bold,
                                      color: categoryColor,
                                    ),
                                  ),
                                  Text(
                                    "Retention",
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
                        
                        SizedBox(height: spMd),
                        
                        // Barrier & Innovation
                        Row(
                          children: [
                            Expanded(
                              child: Container(
                                padding: EdgeInsets.all(spSm),
                                decoration: BoxDecoration(
                                  color: categoryColor.withAlpha(20),
                                  borderRadius: BorderRadius.circular(radiusSm),
                                ),
                                child: Column(
                                  children: [
                                    Text(
                                      "${category["entryBarrier"]}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        color: categoryColor,
                                      ),
                                    ),
                                    Text(
                                      "Entry Barrier",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 9,
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
                                  color: infoColor.withAlpha(20),
                                  borderRadius: BorderRadius.circular(radiusSm),
                                ),
                                child: Column(
                                  children: [
                                    Text(
                                      "${category["innovationRate"]}%",
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        color: infoColor,
                                      ),
                                    ),
                                    Text(
                                      "Innovation Rate",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 9,
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
                                  color: successColor.withAlpha(20),
                                  borderRadius: BorderRadius.circular(radiusSm),
                                ),
                                child: Column(
                                  children: [
                                    Text(
                                      "${category["satisfaction"]}%",
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        color: successColor,
                                      ),
                                    ),
                                    Text(
                                      "User Satisfaction",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 9,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        
                        SizedBox(height: spMd),
                        
                        // View Details Button
                        Container(
                          width: double.infinity,
                          child: QButton(
                            label: "View Detailed Analysis",
                            size: bs.sm,
                            onPressed: () {},
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildComparisonTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Comparison Header
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [infoColor, infoColor.withAlpha(180)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(radiusLg),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.compare_arrows,
                      color: Colors.white,
                      size: 24,
                    ),
                    SizedBox(width: spSm),
                    Text(
                      "Category Comparison",
                      style: TextStyle(
                        fontSize: fsH5,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spSm),
                Text(
                  "Side-by-side comparison of key metrics across different app categories",
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white70,
                  ),
                ),
              ],
            ),
          ),
          
          SizedBox(height: spMd),
          
          // Market Share Comparison
          _buildComparisonSection(
            "Market Share Comparison",
            Icons.pie_chart,
            categoryComparison.map((cat) => {
              "name": cat["name"],
              "value": cat["marketShare"],
              "color": Color(cat["color"] as int),
              "unit": "%"
            }).toList(),
          ),
          
          SizedBox(height: spMd),
          
          // Revenue Comparison
          _buildComparisonSection(
            "Revenue Comparison",
            Icons.attach_money,
            categoryComparison.map((cat) => {
              "name": cat["name"],
              "value": cat["revenue"],
              "color": Color(cat["color"] as int),
              "unit": "B"
            }).toList(),
          ),
          
          SizedBox(height: spMd),
          
          // Growth Rate Comparison
          _buildComparisonSection(
            "Growth Rate Comparison",
            Icons.trending_up,
            categoryComparison.map((cat) => {
              "name": cat["name"],
              "value": cat["growth"],
              "color": Color(cat["color"] as int),
              "unit": "%"
            }).toList(),
          ),
          
          SizedBox(height: spMd),
          
          // User Satisfaction Comparison
          _buildComparisonSection(
            "User Satisfaction",
            Icons.sentiment_very_satisfied,
            categoryComparison.map((cat) => {
              "name": cat["name"],
              "value": cat["satisfaction"],
              "color": Color(cat["color"] as int),
              "unit": "%"
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildComparisonSection(String title, IconData icon, List<Map<String, dynamic>> data) {
    // Sort data by value for better visualization
    data.sort((a, b) => (b["value"] as num).compareTo(a["value"] as num));
    double maxValue = (data.first["value"] as num).toDouble();
    
    return Container(
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
              Icon(
                icon,
                color: primaryColor,
                size: 20,
              ),
              SizedBox(width: spSm),
              Text(
                title,
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          SizedBox(height: spMd),
          ...data.map((item) {
            double percentage = ((item["value"] as num) / maxValue * 100);
            return Container(
              margin: EdgeInsets.only(bottom: spSm),
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        width: 80,
                        child: Text(
                          "${item["name"]}",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: primaryColor,
                          ),
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Container(
                          height: 24,
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: FractionallySizedBox(
                            alignment: Alignment.centerLeft,
                            widthFactor: percentage / 100,
                            child: Container(
                              decoration: BoxDecoration(
                                color: item["color"] as Color,
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: spSm),
                      Container(
                        width: 50,
                        child: Text(
                          "${item["value"]}${item["unit"]}",
                          textAlign: TextAlign.right,
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: item["color"] as Color,
                          ),
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
    );
  }

  Widget _buildSWOTAnalysisTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // SWOT Header
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [warningColor, warningColor.withAlpha(180)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(radiusLg),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.analytics,
                      color: Colors.white,
                      size: 24,
                    ),
                    SizedBox(width: spSm),
                    Text(
                      "SWOT Analysis",
                      style: TextStyle(
                        fontSize: fsH5,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spSm),
                Text(
                  "Strengths, Weaknesses, Opportunities, and Threats analysis for each category",
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white70,
                  ),
                ),
              ],
            ),
          ),
          
          SizedBox(height: spMd),
          
          // SWOT Analysis Cards
          ...categoryComparison.map((category) {
            Color categoryColor = Color(category["color"] as int);
            
            return Container(
              margin: EdgeInsets.only(bottom: spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowMd],
              ),
              child: Column(
                children: [
                  // Header
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(spMd),
                    decoration: BoxDecoration(
                      color: categoryColor.withAlpha(20),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(radiusLg),
                        topRight: Radius.circular(radiusLg),
                      ),
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: categoryColor,
                            borderRadius: BorderRadius.circular(radiusLg),
                          ),
                          child: Icon(
                            category["icon"] as IconData,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                        SizedBox(width: spMd),
                        Text(
                          "${category["name"]} SWOT",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  
                  // SWOT Grid
                  Padding(
                    padding: EdgeInsets.all(spMd),
                    child: Column(
                      children: [
                        // Strengths & Weaknesses
                        Row(
                          children: [
                            Expanded(
                              child: _buildSWOTSection(
                                "Strengths",
                                Icons.trending_up,
                                successColor,
                                category["strengths"] as List<String>,
                              ),
                            ),
                            SizedBox(width: spSm),
                            Expanded(
                              child: _buildSWOTSection(
                                "Challenges",
                                Icons.warning,
                                dangerColor,
                                category["challenges"] as List<String>,
                              ),
                            ),
                          ],
                        ),
                        
                        SizedBox(height: spSm),
                        
                        // Opportunities & Threats
                        Row(
                          children: [
                            Expanded(
                              child: _buildSWOTSection(
                                "Opportunities",
                                Icons.lightbulb,
                                infoColor,
                                category["opportunities"] as List<String>,
                              ),
                            ),
                            SizedBox(width: spSm),
                            Expanded(
                              child: _buildSWOTSection(
                                "Threats",
                                Icons.shield,
                                warningColor,
                                category["threats"] as List<String>,
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
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildSWOTSection(String title, IconData icon, Color color, List<String> items) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: color.withAlpha(20),
        borderRadius: BorderRadius.circular(radiusLg),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                icon,
                size: 16,
                color: color,
              ),
              SizedBox(width: spXs),
              Text(
                title,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
            ],
          ),
          SizedBox(height: spXs),
          ...items.map((item) => Padding(
            padding: EdgeInsets.only(bottom: 4),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "• ",
                  style: TextStyle(
                    fontSize: 10,
                    color: color,
                  ),
                ),
                Expanded(
                  child: Text(
                    item,
                    style: TextStyle(
                      fontSize: 10,
                      color: primaryColor,
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

  Color _getCompetitionLevelColor(String level) {
    switch (level) {
      case 'Very High':
        return dangerColor;
      case 'High':
        return warningColor;
      case 'Medium':
        return infoColor;
      default:
        return successColor;
    }
  }
}
