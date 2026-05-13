import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class DmsWebsiteDetailView extends StatefulWidget {
  const DmsWebsiteDetailView({super.key});

  @override
  State<DmsWebsiteDetailView> createState() => _DmsWebsiteDetailViewState();
}

class _DmsWebsiteDetailViewState extends State<DmsWebsiteDetailView> {
  int currentTab = 0;

  final Map<String, dynamic> websiteData = {
    "id": 1,
    "name": "TechStore Online",
    "domain": "techstore.com",
    "description": "Leading electronics and gadgets e-commerce platform with premium products and exceptional customer service",
    "status": "verified",
    "category": "E-commerce",
    "addedDate": "2024-01-15",
    "verifiedDate": "2024-01-16",
    "ssl": true,
    "sslExpiry": "2024-12-15",
    "loadTime": 1.8,
    "uptime": 99.9,
    "healthScore": 92,
    "totalPages": 2847,
    "indexedPages": 2145,
    "sitemap": true,
    "robotsTxt": true,
    "tags": ["ecommerce", "electronics", "gadgets", "premium"],
  };

  final Map<String, dynamic> analyticsData = {
    "traffic": {
      "monthly": 45820,
      "weekly": 12480,
      "daily": 1540,
      "previousMonth": 42350,
      "change": 8.2,
    },
    "conversions": {
      "total": 342,
      "rate": 0.75,
      "value": 125480.0,
      "previousMonth": 298,
      "change": 14.8,
    },
    "engagement": {
      "avgSessionDuration": "00:03:45",
      "bounceRate": 32.4,
      "pageViews": 124850,
      "pagesPerSession": 2.8,
    },
    "sources": [
      {"name": "Organic Search", "percentage": 45.2, "sessions": 20720},
      {"name": "Direct", "percentage": 28.7, "sessions": 13150},
      {"name": "Social Media", "percentage": 15.3, "sessions": 7010},
      {"name": "Email", "percentage": 7.4, "sessions": 3390},
      {"name": "Referral", "percentage": 3.4, "sessions": 1560},
    ],
  };

  final List<Map<String, dynamic>> performanceMetrics = [
    {
      "metric": "First Contentful Paint",
      "value": "1.2s",
      "score": 95,
      "status": "good",
      "description": "Time when first content appears",
    },
    {
      "metric": "Largest Contentful Paint",
      "value": "2.1s",
      "score": 88,
      "status": "good",
      "description": "Time when largest content appears",
    },
    {
      "metric": "Cumulative Layout Shift",
      "value": "0.05",
      "score": 92,
      "status": "good",
      "description": "Visual stability during loading",
    },
    {
      "metric": "Time to Interactive",
      "value": "2.8s",
      "score": 78,
      "status": "needs-improvement",
      "description": "Time when page becomes interactive",
    },
  ];

  final List<Map<String, dynamic>> seoMetrics = [
    {
      "metric": "Meta Titles",
      "total": 2847,
      "optimized": 2456,
      "percentage": 86.3,
      "status": "good",
    },
    {
      "metric": "Meta Descriptions",
      "total": 2847,
      "optimized": 2234,
      "percentage": 78.5,
      "status": "needs-improvement",
    },
    {
      "metric": "H1 Tags",
      "total": 2847,
      "optimized": 2789,
      "percentage": 97.9,
      "status": "excellent",
    },
    {
      "metric": "Alt Text",
      "total": 8934,
      "optimized": 6421,
      "percentage": 71.9,
      "status": "needs-improvement",
    },
  ];

  final List<Map<String, dynamic>> issues = [
    {
      "type": "critical",
      "title": "Broken Internal Links",
      "count": 5,
      "description": "Several internal links return 404 errors",
      "impact": "High",
      "priority": "Critical",
    },
    {
      "type": "warning",
      "title": "Missing Alt Text",
      "count": 2513,
      "description": "Images without alt text for accessibility",
      "impact": "Medium",
      "priority": "Medium",
    },
  ];

  final List<Map<String, dynamic>> recentActivity = [
    {
      "type": "performance",
      "action": "Page speed improved by 15%",
      "timestamp": "2 hours ago",
      "details": "Optimized images and reduced JavaScript bundle size",
    },
    {
      "type": "seo",
      "action": "Added 45 new meta descriptions",
      "timestamp": "1 day ago",
      "details": "Improved SEO coverage for product pages",
    },
    {
      "type": "security",
      "action": "SSL certificate renewed",
      "timestamp": "3 days ago",
      "details": "Certificate extended until December 2024",
    },
  ];

  Color _getScoreColor(int score) {
    if (score >= 90) return successColor;
    if (score >= 70) return warningColor;
    return dangerColor;
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "excellent":
        return successColor;
      case "good":
        return successColor;
      case "needs-improvement":
        return warningColor;
      case "poor":
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  Widget _buildOverviewTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          // Website Info Card
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowMd],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        color: successColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusMd),
                      ),
                      child: Icon(Icons.language, color: successColor, size: 24),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${websiteData["name"]}",
                            style: TextStyle(
                              fontSize: fsH5,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          Text(
                            "${websiteData["domain"]}",
                            style: TextStyle(
                              fontSize: 14,
                              color: infoColor,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                      decoration: BoxDecoration(
                        color: successColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Text(
                        "${websiteData["status"]}".toUpperCase(),
                        style: TextStyle(
                          fontSize: 12,
                          color: successColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spSm),
                Text(
                  "${websiteData["description"]}",
                  style: TextStyle(
                    fontSize: 13,
                    color: disabledBoldColor,
                    height: 1.4,
                  ),
                ),
                SizedBox(height: spSm),
                Row(
                  children: [
                    Icon(Icons.category, color: disabledBoldColor, size: 16),
                    SizedBox(width: spXs),
                    Text(
                      "${websiteData["category"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(width: spSm),
                    Icon(Icons.calendar_today, color: disabledBoldColor, size: 16),
                    SizedBox(width: spXs),
                    Text(
                      "Added ${websiteData["addedDate"]}",
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

          // Quick Stats
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowMd],
                  ),
                  child: Column(
                    children: [
                      Text(
                        "${websiteData["healthScore"]}%",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: _getScoreColor(websiteData["healthScore"]),
                        ),
                      ),
                      Text(
                        "Health Score",
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
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowMd],
                  ),
                  child: Column(
                    children: [
                      Text(
                        "${websiteData["uptime"]}%",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: successColor,
                        ),
                      ),
                      Text(
                        "Uptime",
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
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowMd],
                  ),
                  child: Column(
                    children: [
                      Text(
                        "${websiteData["loadTime"]}s",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: warningColor,
                        ),
                      ),
                      Text(
                        "Load Time",
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

          // Issues Summary
          if (issues.isNotEmpty) ...[
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowMd],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.warning, color: warningColor, size: 20),
                      SizedBox(width: spXs),
                      Text(
                        "Active Issues",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Spacer(),
                      QButton(
                        icon: Icons.arrow_forward,
                        size: bs.sm,
                        onPressed: () {},
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  Column(
                    children: issues.take(2).map((issue) {
                      Color issueColor = issue["type"] == "critical" ? dangerColor : warningColor;
                      return Container(
                        margin: EdgeInsets.only(bottom: spXs),
                        padding: EdgeInsets.all(spXs),
                        decoration: BoxDecoration(
                          color: issueColor.withAlpha(10),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              issue["type"] == "critical" ? Icons.error : Icons.warning,
                              color: issueColor,
                              size: 16,
                            ),
                            SizedBox(width: spXs),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${issue["title"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      color: primaryColor,
                                    ),
                                  ),
                                  Text(
                                    "${issue["description"]}",
                                    style: TextStyle(
                                      fontSize: 11,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Text(
                              "${issue["count"]}",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: issueColor,
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildAnalyticsTab() {
    final traffic = analyticsData["traffic"];
    final conversions = analyticsData["conversions"];
    final engagement = analyticsData["engagement"];
    final sources = analyticsData["sources"] as List;

    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          // Traffic Overview
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowMd],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.trending_up, color: infoColor, size: 20),
                          SizedBox(width: spXs),
                          Text(
                            "Monthly Traffic",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "${(traffic["monthly"] / 1000).toStringAsFixed(1)}K",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: infoColor,
                        ),
                      ),
                      SizedBox(height: spXs),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                        decoration: BoxDecoration(
                          color: successColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Text(
                          "+${(traffic["change"] as double).toStringAsFixed(1)}%",
                          style: TextStyle(
                            fontSize: 10,
                            color: successColor,
                            fontWeight: FontWeight.w600,
                          ),
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
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowMd],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.monetization_on, color: successColor, size: 20),
                          SizedBox(width: spXs),
                          Text(
                            "Conversions",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "${conversions["total"]}",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: successColor,
                        ),
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "Rate: ${(conversions["rate"] as double).toStringAsFixed(2)}%",
                        style: TextStyle(
                          fontSize: 10,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),

          // Engagement Metrics
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowMd],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.people, color: primaryColor, size: 20),
                    SizedBox(width: spXs),
                    Text(
                      "User Engagement",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spSm),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Avg. Session",
                            style: TextStyle(
                              fontSize: 10,
                              color: disabledBoldColor,
                            ),
                          ),
                          Text(
                            "${engagement["avgSessionDuration"]}",
                            style: TextStyle(
                              fontSize: 14,
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
                            "Bounce Rate",
                            style: TextStyle(
                              fontSize: 10,
                              color: disabledBoldColor,
                            ),
                          ),
                          Text(
                            "${(engagement["bounceRate"] as double).toStringAsFixed(1)}%",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: warningColor,
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
                            "Pages/Session",
                            style: TextStyle(
                              fontSize: 10,
                              color: disabledBoldColor,
                            ),
                          ),
                          Text(
                            "${(engagement["pagesPerSession"] as double).toStringAsFixed(1)}",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: infoColor,
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

          // Traffic Sources
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowMd],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.source, color: primaryColor, size: 20),
                    SizedBox(width: spXs),
                    Text(
                      "Traffic Sources",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spSm),
                Column(
                  children: sources.map((source) {
                    Color sourceColor;
                    switch (source["name"]) {
                      case "Organic Search":
                        sourceColor = successColor;
                        break;
                      case "Direct":
                        sourceColor = primaryColor;
                        break;
                      case "Social Media":
                        sourceColor = infoColor;
                        break;
                      case "Email":
                        sourceColor = warningColor;
                        break;
                      default:
                        sourceColor = disabledBoldColor;
                    }

                    return Container(
                      margin: EdgeInsets.only(bottom: spSm),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Container(
                                width: 12,
                                height: 12,
                                decoration: BoxDecoration(
                                  color: sourceColor,
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                              ),
                              SizedBox(width: spXs),
                              Expanded(
                                child: Text(
                                  "${source["name"]}",
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600,
                                    color: primaryColor,
                                  ),
                                ),
                              ),
                              Text(
                                "${(source["percentage"] as double).toStringAsFixed(1)}%",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: sourceColor,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: spXs),
                          Container(
                            height: 6,
                            decoration: BoxDecoration(
                              color: disabledColor,
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: FractionallySizedBox(
                              alignment: Alignment.centerLeft,
                              widthFactor: (source["percentage"] as double) / 100,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: sourceColor,
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPerformanceTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          // Core Web Vitals
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowMd],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.speed, color: primaryColor, size: 20),
                    SizedBox(width: spXs),
                    Text(
                      "Core Web Vitals",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spSm),
                Column(
                  children: performanceMetrics.map((metric) {
                    final score = metric["score"] as int;
                    final scoreColor = _getScoreColor(score);
                    
                    return Container(
                      margin: EdgeInsets.only(bottom: spSm),
                      padding: EdgeInsets.all(spXs),
                      decoration: BoxDecoration(
                        color: scoreColor.withAlpha(10),
                        borderRadius: BorderRadius.circular(radiusSm),
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
                                      "${metric["metric"]}",
                                      style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w600,
                                        color: primaryColor,
                                      ),
                                    ),
                                    Text(
                                      "${metric["description"]}",
                                      style: TextStyle(
                                        fontSize: 11,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    "${metric["value"]}",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: scoreColor,
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                    decoration: BoxDecoration(
                                      color: scoreColor.withAlpha(20),
                                      borderRadius: BorderRadius.circular(radiusXs),
                                    ),
                                    child: Text(
                                      "$score",
                                      style: TextStyle(
                                        fontSize: 10,
                                        color: scoreColor,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(height: spXs),
                          Container(
                            height: 4,
                            decoration: BoxDecoration(
                              color: disabledColor,
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: FractionallySizedBox(
                              alignment: Alignment.centerLeft,
                              widthFactor: score / 100,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: scoreColor,
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),

          // SEO Metrics
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowMd],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.search, color: primaryColor, size: 20),
                    SizedBox(width: spXs),
                    Text(
                      "SEO Optimization",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spSm),
                Column(
                  children: seoMetrics.map((seo) {
                    final percentage = seo["percentage"] as double;
                    final statusColor = _getStatusColor(seo["status"]);
                    
                    return Container(
                      margin: EdgeInsets.only(bottom: spSm),
                      padding: EdgeInsets.all(spXs),
                      decoration: BoxDecoration(
                        color: statusColor.withAlpha(10),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  "${seo["metric"]}",
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600,
                                    color: primaryColor,
                                  ),
                                ),
                              ),
                              Text(
                                "${seo["optimized"]}/${seo["total"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                              SizedBox(width: spXs),
                              Text(
                                "${percentage.toStringAsFixed(1)}%",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: statusColor,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: spXs),
                          Container(
                            height: 6,
                            decoration: BoxDecoration(
                              color: disabledColor,
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: FractionallySizedBox(
                              alignment: Alignment.centerLeft,
                              widthFactor: percentage / 100,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: statusColor,
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "${websiteData["name"]}",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Overview", icon: Icon(Icons.dashboard)),
        Tab(text: "Analytics", icon: Icon(Icons.analytics)),
        Tab(text: "Performance", icon: Icon(Icons.speed)),
      ],
      tabChildren: [
        _buildOverviewTab(),
        _buildAnalyticsTab(),
        _buildPerformanceTab(),
      ],
      actions: [
        QButton(
          icon: Icons.edit,
          size: bs.sm,
          onPressed: () {},
        ),
        SizedBox(width: spSm),
      ],
    );
  }
}
