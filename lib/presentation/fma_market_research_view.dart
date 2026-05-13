import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class FmaMarketResearchView extends StatefulWidget {
  const FmaMarketResearchView({super.key});

  @override
  State<FmaMarketResearchView> createState() => _FmaMarketResearchViewState();
}

class _FmaMarketResearchViewState extends State<FmaMarketResearchView> {
  int selectedTab = 0;
  String selectedTimeframe = "2024";
  String selectedRegion = "all";
  String selectedCategory = "all";

  List<Map<String, dynamic>> researchProjects = [
    {
      "id": "proj001",
      "title": "Consumer Behavior Analysis",
      "type": "Primary Research",
      "status": "Completed",
      "completion": 100,
      "startDate": "2024-01-15",
      "endDate": "2024-03-15",
      "budget": 25000,
      "spent": 24500,
      "insights": 12,
      "participants": 1500,
      "methodology": "Survey & Focus Groups",
      "keyFindings": [
        "70% prefer mobile ordering",
        "85% value sustainability",
        "60% willing to pay premium for quality"
      ]
    },
    {
      "id": "proj002", 
      "title": "Market Size Assessment",
      "type": "Secondary Research",
      "status": "In Progress",
      "completion": 75,
      "startDate": "2024-02-01",
      "endDate": "2024-04-30",
      "budget": 15000,
      "spent": 11250,
      "insights": 8,
      "participants": 0,
      "methodology": "Data Analysis",
      "keyFindings": [
        "Market growth rate: 12%",
        "Total addressable market: \$2.5B",
        "Competitive density increasing"
      ]
    },
    {
      "id": "proj003",
      "title": "Location Feasibility Study",
      "type": "Market Analysis",
      "status": "Planning",
      "completion": 25,
      "startDate": "2024-03-15",
      "endDate": "2024-06-15",
      "budget": 35000,
      "spent": 8750,
      "insights": 3,
      "participants": 800,
      "methodology": "Site Analysis & Demographics",
      "keyFindings": [
        "Prime locations identified",
        "High foot traffic areas",
        "Demographics align with target"
      ]
    }
  ];

  List<Map<String, dynamic>> marketSegments = [
    {
      "segment": "Young Professionals",
      "size": 35,
      "growth": 8.5,
      "value": "High",
      "characteristics": ["Tech-savvy", "Convenience-focused", "Quality-conscious"],
      "preferences": ["Mobile ordering", "Quick service", "Healthy options"],
      "spending": 450
    },
    {
      "segment": "Families",
      "size": 28,
      "growth": 5.2,
      "value": "Medium",
      "characteristics": ["Value-conscious", "Bulk purchases", "Brand loyal"],
      "preferences": ["Family deals", "Kid-friendly", "Variety"],
      "spending": 380
    },
    {
      "segment": "Seniors",
      "size": 22,
      "growth": 12.1,
      "value": "Medium",
      "characteristics": ["Traditional", "Service-oriented", "Quality-focused"],
      "preferences": ["Personal service", "Familiar brands", "Comfort"],
      "spending": 320
    },
    {
      "segment": "Students",
      "size": 15,
      "growth": -2.3,
      "value": "Low",
      "characteristics": ["Price-sensitive", "Social", "Digital natives"],
      "preferences": ["Discounts", "Social media", "Convenience"],
      "spending": 180
    }
  ];

  List<Map<String, dynamic>> marketTrends = [
    {
      "trend": "Digital Transformation",
      "impact": "High",
      "timeline": "Immediate",
      "description": "Increased adoption of digital ordering and payment systems",
      "opportunity": "Implement comprehensive digital platform",
      "threat": "Competitors gaining digital advantage",
      "probability": 95
    },
    {
      "trend": "Sustainability Focus",
      "impact": "Medium",
      "timeline": "6-12 months",
      "description": "Growing consumer demand for eco-friendly practices",
      "opportunity": "Green packaging and sourcing initiatives",
      "threat": "Regulatory compliance costs",
      "probability": 85
    },
    {
      "trend": "Ghost Kitchens",
      "impact": "High",
      "timeline": "3-6 months",
      "description": "Rise of delivery-only restaurant concepts",
      "opportunity": "Lower overhead delivery operations",
      "threat": "Reduced foot traffic to physical locations",
      "probability": 78
    },
    {
      "trend": "Health Consciousness",
      "impact": "Medium",
      "timeline": "12+ months",
      "description": "Increased demand for healthy and transparent ingredients",
      "opportunity": "Expand healthy menu options",
      "threat": "Menu reformulation costs",
      "probability": 82
    }
  ];

  List<Map<String, dynamic>> competitiveIntelligence = [
    {
      "competitor": "Fast Burger Co",
      "marketShare": 23.5,
      "recentActions": [
        "Launched mobile app with rewards program",
        "Opened 15 new locations in Q1",
        "Introduced plant-based menu items"
      ],
      "strengths": ["Strong brand recognition", "Extensive locations", "Efficient operations"],
      "weaknesses": ["Limited menu innovation", "Price sensitivity", "Customer service issues"],
      "threat": "High"
    },
    {
      "competitor": "Gourmet Express",
      "marketShare": 18.2,
      "recentActions": [
        "Premium menu repositioning",
        "Partnership with delivery platforms",
        "Sustainability initiative launch"
      ],
      "strengths": ["Premium positioning", "Quality ingredients", "Customer loyalty"],
      "weaknesses": ["Higher price points", "Limited locations", "Slower service"],
      "threat": "Medium"
    },
    {
      "competitor": "Quick Bites",
      "marketShare": 15.8,
      "recentActions": [
        "Aggressive pricing strategy",
        "24/7 operations pilot",
        "Social media marketing push"
      ],
      "strengths": ["Competitive pricing", "Fast service", "Young demographic appeal"],
      "weaknesses": ["Quality perception", "Limited differentiation", "High turnover"],
      "threat": "Medium"
    }
  ];

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Market Research",
      selectedIndex: selectedTab,
      tabs: [
        Tab(text: "Overview", icon: Icon(Icons.dashboard)),
        Tab(text: "Projects", icon: Icon(Icons.assignment)),
        Tab(text: "Segments", icon: Icon(Icons.pie_chart)),
        Tab(text: "Intelligence", icon: Icon(Icons.lightbulb)),
      ],
      tabChildren: [
        _buildOverviewTab(),
        _buildProjectsTab(),
        _buildSegmentsTab(),
        _buildIntelligenceTab(),
      ],
    );
  }

  Widget _buildOverviewTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Key Metrics Cards
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: [
              _buildMetricCard("Active Projects", "3", Icons.assignment, primaryColor),
              _buildMetricCard("Total Budget", "\$75K", Icons.attach_money, successColor),
              _buildMetricCard("Insights Generated", "23", Icons.lightbulb, warningColor),
              _buildMetricCard("Market Size", "\$2.5B", Icons.trending_up, infoColor),
            ],
          ),

          // Recent Research Insights
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spMd),
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
                    Icon(Icons.insights, color: primaryColor, size: 20),
                    SizedBox(width: spXs),
                    Text(
                      "Recent Market Insights",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
                ...marketTrends.take(3).map((trend) => _buildInsightItem(trend)),
              ],
            ),
          ),

          // Market Share Overview
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spMd),
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
                  "Competitive Landscape",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                ...competitiveIntelligence.map((competitor) => _buildCompetitorItem(competitor)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProjectsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Filters
          Row(
            children: [
              Expanded(
                child: QDropdownField(
                  label: "Status Filter",
                  items: [
                    {"label": "All Status", "value": "all"},
                    {"label": "Planning", "value": "planning"},
                    {"label": "In Progress", "value": "progress"},
                    {"label": "Completed", "value": "completed"},
                  ],
                  value: "all",
                  onChanged: (value, label) {},
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QDropdownField(
                  label: "Type Filter",
                  items: [
                    {"label": "All Types", "value": "all"},
                    {"label": "Primary Research", "value": "primary"},
                    {"label": "Secondary Research", "value": "secondary"},
                    {"label": "Market Analysis", "value": "analysis"},
                  ],
                  value: "all",
                  onChanged: (value, label) {},
                ),
              ),
            ],
          ),

          // Projects List
          ...researchProjects.map((project) => _buildProjectCard(project)),
        ],
      ),
    );
  }

  Widget _buildSegmentsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Segment Overview
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spMd),
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
                  "Market Segmentation Analysis",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "Target market divided into 4 key segments based on demographics and behavior",
                  style: TextStyle(
                    color: disabledBoldColor,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),

          // Segments Grid
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: marketSegments.map((segment) => _buildSegmentCard(segment)).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildIntelligenceTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Market Trends
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spMd),
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
                  "Market Trends & Opportunities",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                ...marketTrends.map((trend) => _buildTrendCard(trend)),
              ],
            ),
          ),

          // Competitive Intelligence
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spMd),
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
                  "Competitive Intelligence",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                ...competitiveIntelligence.map((competitor) => _buildIntelligenceCard(competitor)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMetricCard(String title, String value, IconData icon, Color color) {
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
                padding: EdgeInsets.all(spXs),
                decoration: BoxDecoration(
                  color: color.withAlpha(51),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Icon(icon, color: color, size: 20),
              ),
              Spacer(),
            ],
          ),
          SizedBox(height: spSm),
          Text(
            value,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Text(
            title,
            style: TextStyle(
              color: disabledBoldColor,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInsightItem(Map<String, dynamic> trend) {
    return Container(
      padding: EdgeInsets.all(spSm),
      margin: EdgeInsets.only(bottom: spXs),
      decoration: BoxDecoration(
        color: primaryColor.withAlpha(25),
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Row(
        children: [
          Container(
            width: 4,
            height: 40,
            decoration: BoxDecoration(
              color: primaryColor,
              borderRadius: BorderRadius.circular(radiusXs),
            ),
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${trend["trend"]}",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "${trend["description"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
            decoration: BoxDecoration(
              color: trend["impact"] == "High" ? dangerColor : warningColor,
              borderRadius: BorderRadius.circular(radiusXs),
            ),
            child: Text(
              "${trend["impact"]}",
              style: TextStyle(
                color: Colors.white,
                fontSize: 10,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCompetitorItem(Map<String, dynamic> competitor) {
    return Container(
      padding: EdgeInsets.all(spSm),
      margin: EdgeInsets.only(bottom: spXs),
      decoration: BoxDecoration(
        border: Border.all(color: disabledOutlineBorderColor),
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${competitor["competitor"]}",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "Market Share: ${(competitor["marketShare"] as num).toStringAsFixed(1)}%",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
            decoration: BoxDecoration(
              color: competitor["threat"] == "High" ? dangerColor : 
                    competitor["threat"] == "Medium" ? warningColor : successColor,
              borderRadius: BorderRadius.circular(radiusXs),
            ),
            child: Text(
              "${competitor["threat"]} Threat",
              style: TextStyle(
                color: Colors.white,
                fontSize: 10,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProjectCard(Map<String, dynamic> project) {
    Color statusColor = project["status"] == "Completed" ? successColor :
                       project["status"] == "In Progress" ? warningColor : infoColor;

    return Container(
      padding: EdgeInsets.all(spMd),
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
                  "${project["title"]}",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 4),
                decoration: BoxDecoration(
                  color: statusColor,
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "${project["status"]}",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          
          Row(
            children: [
              Text(
                "${project["type"]} • ${project["methodology"]}",
                style: TextStyle(
                  color: disabledBoldColor,
                  fontSize: 14,
                ),
              ),
            ],
          ),

          // Progress Bar
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    "Progress",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
                  Spacer(),
                  Text(
                    "${project["completion"]}%",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: primaryColor,
                    ),
                  ),
                ],
              ),
              SizedBox(height: spXs),
              LinearProgressIndicator(
                value: (project["completion"] as num) / 100,
                backgroundColor: disabledColor,
                valueColor: AlwaysStoppedAnimation<Color>(statusColor),
              ),
            ],
          ),

          // Budget and Timeline
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Budget",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "\$${((project["spent"] as num).toDouble()).currency} / \$${((project["budget"] as num).toDouble()).currency}",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Timeline",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "${project["startDate"]} - ${project["endDate"]}",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          // Key Findings
          if ((project["keyFindings"] as List).isNotEmpty)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Key Findings",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spXs),
                ...(project["keyFindings"] as List).map((finding) => 
                  Padding(
                    padding: EdgeInsets.only(bottom: 2),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 4,
                          height: 4,
                          margin: EdgeInsets.only(top: 6, right: spXs),
                          decoration: BoxDecoration(
                            color: primaryColor,
                            shape: BoxShape.circle,
                          ),
                        ),
                        Expanded(
                          child: Text(
                            "$finding",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

          Container(
            width: double.infinity,
            child: QButton(
              label: "View Details",
              size: bs.sm,
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSegmentCard(Map<String, dynamic> segment) {
    return Container(
      padding: EdgeInsets.all(spMd),
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
                  "${segment["segment"]}",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                decoration: BoxDecoration(
                  color: segment["value"] == "High" ? successColor :
                        segment["value"] == "Medium" ? warningColor : infoColor,
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "${segment["value"]} Value",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),

          // Size and Growth
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Market Size",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "${segment["size"]}%",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Growth Rate",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "${(segment["growth"] as num) >= 0 ? '+' : ''}${(segment["growth"] as num).toStringAsFixed(1)}%",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: (segment["growth"] as num) >= 0 ? successColor : dangerColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          // Average Spending
          Text(
            "Average Spending: \$${((segment["spending"] as num).toDouble()).currency}/month",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: primaryColor,
            ),
          ),

          // Characteristics
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Key Characteristics",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: primaryColor,
                ),
              ),
              SizedBox(height: spXs),
              ...(segment["characteristics"] as List).map((char) =>
                Padding(
                  padding: EdgeInsets.only(bottom: 2),
                  child: Row(
                    children: [
                      Container(
                        width: 4,
                        height: 4,
                        margin: EdgeInsets.only(right: spXs),
                        decoration: BoxDecoration(
                          color: primaryColor,
                          shape: BoxShape.circle,
                        ),
                      ),
                      Text(
                        "$char",
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
    );
  }

  Widget _buildTrendCard(Map<String, dynamic> trend) {
    Color impactColor = trend["impact"] == "High" ? dangerColor : 
                       trend["impact"] == "Medium" ? warningColor : successColor;

    return Container(
      padding: EdgeInsets.all(spMd),
      margin: EdgeInsets.only(bottom: spSm),
      decoration: BoxDecoration(
        border: Border.all(color: disabledOutlineBorderColor),
        borderRadius: BorderRadius.circular(radiusMd),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  "${trend["trend"]}",
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
                  color: impactColor,
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "${trend["impact"]} Impact",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),

          Text(
            "${trend["description"]}",
            style: TextStyle(
              color: disabledBoldColor,
              fontSize: 14,
            ),
          ),

          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Timeline",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "${trend["timeline"]}",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Probability",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "${trend["probability"]}%",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Opportunity",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: successColor,
                ),
              ),
              Text(
                "${trend["opportunity"]}",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Threat",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: dangerColor,
                ),
              ),
              Text(
                "${trend["threat"]}",
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
  }

  Widget _buildIntelligenceCard(Map<String, dynamic> competitor) {
    Color threatColor = competitor["threat"] == "High" ? dangerColor :
                       competitor["threat"] == "Medium" ? warningColor : successColor;

    return Container(
      padding: EdgeInsets.all(spMd),
      margin: EdgeInsets.only(bottom: spSm),
      decoration: BoxDecoration(
        border: Border.all(color: disabledOutlineBorderColor),
        borderRadius: BorderRadius.circular(radiusMd),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  "${competitor["competitor"]}",
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
                  color: threatColor,
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "${competitor["threat"]} Threat",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),

          Text(
            "Market Share: ${(competitor["marketShare"] as num).toStringAsFixed(1)}%",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: primaryColor,
            ),
          ),

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Recent Actions",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: primaryColor,
                ),
              ),
              SizedBox(height: spXs),
              ...(competitor["recentActions"] as List).map((action) =>
                Padding(
                  padding: EdgeInsets.only(bottom: 2),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 4,
                        height: 4,
                        margin: EdgeInsets.only(top: 6, right: spXs),
                        decoration: BoxDecoration(
                          color: primaryColor,
                          shape: BoxShape.circle,
                        ),
                      ),
                      Expanded(
                        child: Text(
                          "$action",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Strengths",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: successColor,
                      ),
                    ),
                    ...(competitor["strengths"] as List).take(2).map((strength) =>
                      Text(
                        "• $strength",
                        style: TextStyle(
                          fontSize: 11,
                          color: disabledBoldColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Weaknesses",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: dangerColor,
                      ),
                    ),
                    ...(competitor["weaknesses"] as List).take(2).map((weakness) =>
                      Text(
                        "• $weakness",
                        style: TextStyle(
                          fontSize: 11,
                          color: disabledBoldColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
