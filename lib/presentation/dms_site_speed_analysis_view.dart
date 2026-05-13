import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class DmsSiteSpeedAnalysisView extends StatefulWidget {
  const DmsSiteSpeedAnalysisView({super.key});

  @override
  State<DmsSiteSpeedAnalysisView> createState() => _DmsSiteSpeedAnalysisViewState();
}

class _DmsSiteSpeedAnalysisViewState extends State<DmsSiteSpeedAnalysisView> {
  String selectedDevice = "all_devices";
  String selectedIssueType = "all_issues";
  int selectedFilter = 0;

  List<Map<String, dynamic>> deviceOptions = [
    {"label": "All Devices", "value": "all_devices"},
    {"label": "Desktop", "value": "desktop"},
    {"label": "Mobile", "value": "mobile"},
    {"label": "Tablet", "value": "tablet"},
  ];

  List<Map<String, dynamic>> issueTypeOptions = [
    {"label": "All Issues", "value": "all_issues"},
    {"label": "Slow Loading", "value": "slow_loading"},
    {"label": "Large Images", "value": "large_images"},
    {"label": "Unused CSS", "value": "unused_css"},
    {"label": "Blocking Resources", "value": "blocking_resources"},
    {"label": "Server Issues", "value": "server_issues"},
  ];

  List<Map<String, dynamic>> speedData = [
    {
      "url": "/",
      "title": "Homepage",
      "desktop_score": 85,
      "mobile_score": 62,
      "tablet_score": 74,
      "desktop_load_time": 2.1,
      "mobile_load_time": 4.8,
      "tablet_load_time": 3.2,
      "core_web_vitals": {
        "lcp": {"desktop": 1.8, "mobile": 3.2, "tablet": 2.4},
        "fid": {"desktop": 45, "mobile": 120, "mobile": 85},
        "cls": {"desktop": 0.05, "mobile": 0.18, "tablet": 0.12},
      },
      "issues": [
        {
          "type": "large_images",
          "severity": "high",
          "description": "Serve images in next-gen formats",
          "impact": "Save 1.2s",
          "resources": ["/images/hero-banner.jpg", "/images/testimonials.png"],
        },
        {
          "type": "unused_css",
          "severity": "medium",
          "description": "Remove unused CSS",
          "impact": "Save 0.8s",
          "resources": ["/css/bootstrap.css", "/css/animations.css"],
        },
        {
          "type": "blocking_resources",
          "severity": "medium",
          "description": "Eliminate render-blocking resources",
          "impact": "Save 0.6s",
          "resources": ["/js/jquery.min.js", "/css/font-awesome.css"],
        }
      ],
      "opportunities": [
        {
          "title": "Optimize images",
          "description": "Convert to WebP format and implement lazy loading",
          "potential_savings": "1.8s",
          "difficulty": "easy",
        },
        {
          "title": "Minify CSS and JavaScript",
          "description": "Remove unnecessary characters from code",
          "potential_savings": "0.9s",
          "difficulty": "easy",
        },
        {
          "title": "Enable compression",
          "description": "Use gzip or brotli compression",
          "potential_savings": "1.2s",
          "difficulty": "medium",
        }
      ],
      "priority": "high",
      "traffic": 15800,
      "bounce_rate": 68.5,
    },
    {
      "url": "/products/marketing-software",
      "title": "Marketing Software Product Page",
      "desktop_score": 72,
      "mobile_score": 45,
      "tablet_score": 58,
      "desktop_load_time": 3.2,
      "mobile_load_time": 6.8,
      "tablet_load_time": 4.9,
      "core_web_vitals": {
        "lcp": {"desktop": 2.8, "mobile": 5.2, "tablet": 3.8},
        "fid": {"desktop": 85, "mobile": 180, "tablet": 135},
        "cls": {"desktop": 0.12, "mobile": 0.35, "tablet": 0.24},
      },
      "issues": [
        {
          "type": "large_images",
          "severity": "critical",
          "description": "Product images are not optimized",
          "impact": "Save 2.8s",
          "resources": ["/images/product-gallery-1.jpg", "/images/product-demo.mp4"],
        },
        {
          "type": "server_issues",
          "severity": "high",
          "description": "Server response time is slow",
          "impact": "Save 1.5s",
          "resources": ["API response delays"],
        },
        {
          "type": "blocking_resources",
          "severity": "high",
          "description": "Third-party scripts blocking render",
          "impact": "Save 1.2s",
          "resources": ["/js/analytics.js", "/js/chat-widget.js"],
        }
      ],
      "opportunities": [
        {
          "title": "Optimize product images",
          "description": "Implement responsive images and WebP format",
          "potential_savings": "2.8s",
          "difficulty": "medium",
        },
        {
          "title": "Improve server response",
          "description": "Implement caching and optimize database queries",
          "potential_savings": "1.5s",
          "difficulty": "hard",
        },
        {
          "title": "Defer third-party scripts",
          "description": "Load analytics and widgets asynchronously",
          "potential_savings": "1.2s",
          "difficulty": "medium",
        }
      ],
      "priority": "critical",
      "traffic": 8900,
      "bounce_rate": 78.2,
    },
    {
      "url": "/blog/digital-marketing-guide",
      "title": "Digital Marketing Guide Blog Post",
      "desktop_score": 91,
      "mobile_score": 78,
      "tablet_score": 85,
      "desktop_load_time": 1.8,
      "mobile_load_time": 3.1,
      "tablet_load_time": 2.4,
      "core_web_vitals": {
        "lcp": {"desktop": 1.2, "mobile": 2.1, "tablet": 1.6},
        "fid": {"desktop": 25, "mobile": 65, "tablet": 45},
        "cls": {"desktop": 0.02, "mobile": 0.08, "tablet": 0.05},
      },
      "issues": [
        {
          "type": "unused_css",
          "severity": "low",
          "description": "Small amount of unused CSS",
          "impact": "Save 0.3s",
          "resources": ["/css/sidebar.css"],
        }
      ],
      "opportunities": [
        {
          "title": "Remove unused CSS",
          "description": "Clean up unused sidebar styles",
          "potential_savings": "0.3s",
          "difficulty": "easy",
        },
        {
          "title": "Preload key resources",
          "description": "Preload critical fonts and images",
          "potential_savings": "0.2s",
          "difficulty": "easy",
        }
      ],
      "priority": "low",
      "traffic": 12400,
      "bounce_rate": 45.8,
    },
    {
      "url": "/services/seo-optimization",
      "title": "SEO Optimization Services",
      "desktop_score": 68,
      "mobile_score": 52,
      "tablet_score": 61,
      "desktop_load_time": 3.8,
      "mobile_load_time": 5.9,
      "tablet_load_time": 4.6,
      "core_web_vitals": {
        "lcp": {"desktop": 3.1, "mobile": 4.8, "tablet": 3.9},
        "fid": {"desktop": 95, "mobile": 165, "tablet": 125},
        "cls": {"desktop": 0.15, "mobile": 0.28, "tablet": 0.21},
      },
      "issues": [
        {
          "type": "large_images",
          "severity": "high",
          "description": "Service showcase images are oversized",
          "impact": "Save 1.8s",
          "resources": ["/images/seo-process.png", "/images/results-chart.jpg"],
        },
        {
          "type": "blocking_resources",
          "severity": "medium",
          "description": "CSS and JS files blocking render",
          "impact": "Save 1.1s",
          "resources": ["/css/services.css", "/js/testimonials.js"],
        },
        {
          "type": "unused_css",
          "severity": "medium",
          "description": "Unused framework CSS",
          "impact": "Save 0.7s",
          "resources": ["/css/framework-unused.css"],
        }
      ],
      "opportunities": [
        {
          "title": "Optimize service images",
          "description": "Compress and convert images to modern formats",
          "potential_savings": "1.8s",
          "difficulty": "easy",
        },
        {
          "title": "Defer non-critical CSS/JS",
          "description": "Load testimonials and animations later",
          "potential_savings": "1.1s",
          "difficulty": "medium",
        },
        {
          "title": "Remove framework bloat",
          "description": "Include only used CSS framework components",
          "potential_savings": "0.7s",
          "difficulty": "medium",
        }
      ],
      "priority": "high",
      "traffic": 6700,
      "bounce_rate": 72.4,
    },
    {
      "url": "/contact",
      "title": "Contact Us Page",
      "desktop_score": 88,
      "mobile_score": 81,
      "tablet_score": 85,
      "desktop_load_time": 2.0,
      "mobile_load_time": 2.8,
      "tablet_load_time": 2.3,
      "core_web_vitals": {
        "lcp": {"desktop": 1.5, "mobile": 2.2, "tablet": 1.8},
        "fid": {"desktop": 35, "mobile": 75, "tablet": 55},
        "cls": {"desktop": 0.03, "mobile": 0.09, "tablet": 0.06},
      },
      "issues": [],
      "opportunities": [
        {
          "title": "Preconnect to external domains",
          "description": "Preconnect to map and form services",
          "potential_savings": "0.2s",
          "difficulty": "easy",
        }
      ],
      "priority": "low",
      "traffic": 3200,
      "bounce_rate": 38.5,
    },
  ];

  List<Map<String, dynamic>> get filteredData {
    List<Map<String, dynamic>> filtered = speedData;

    if (selectedIssueType != "all_issues") {
      filtered = filtered.where((item) {
        List issues = item["issues"] as List;
        return issues.any((issue) => (issue as Map)["type"] == selectedIssueType);
      }).toList();
    }

    switch (selectedFilter) {
      case 1: // Critical Performance
        filtered = filtered.where((item) => item["priority"] == "critical").toList();
        break;
      case 2: // Mobile Issues
        filtered = filtered.where((item) => (item["mobile_score"] as int) < 70).toList();
        break;
      case 3: // Good Performance
        filtered = filtered.where((item) => 
            (item["desktop_score"] as int) >= 80 && (item["mobile_score"] as int) >= 70).toList();
        break;
    }

    return filtered;
  }

  Color _getScoreColor(int score) {
    if (score >= 90) return successColor;
    if (score >= 70) return infoColor;
    if (score >= 50) return warningColor;
    return dangerColor;
  }

  Color _getSeverityColor(String severity) {
    switch (severity) {
      case "critical":
        return dangerColor;
      case "high":
        return warningColor;
      case "medium":
        return infoColor;
      case "low":
        return successColor;
      default:
        return disabledBoldColor;
    }
  }

  Color _getDifficultyColor(String difficulty) {
    switch (difficulty) {
      case "easy":
        return successColor;
      case "medium":
        return warningColor;
      case "hard":
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Site Speed Analysis"),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              // Refresh speed tests
            },
          ),
          IconButton(
            icon: Icon(Icons.analytics),
            onPressed: () {
              // Speed analytics
            },
          ),
          IconButton(
            icon: Icon(Icons.download),
            onPressed: () {
              // Export speed report
            },
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
                    label: "Device Type",
                    items: deviceOptions,
                    value: selectedDevice,
                    onChanged: (value, label) {
                      selectedDevice = value;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QDropdownField(
                    label: "Issue Type",
                    items: issueTypeOptions,
                    value: selectedIssueType,
                    onChanged: (value, label) {
                      selectedIssueType = value;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: spMd),

            // Filter Tabs
            QCategoryPicker(
              items: [
                {"label": "All Pages", "value": 0},
                {"label": "Critical", "value": 1},
                {"label": "Mobile Issues", "value": 2},
                {"label": "Good Performance", "value": 3},
              ],
              value: selectedFilter,
              onChanged: (index, label, value, item) {
                selectedFilter = value;
                setState(() {});
              },
            ),
            SizedBox(height: spMd),

            // Summary Statistics
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusMd),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Avg Desktop Score",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "${(speedData.map((s) => s["desktop_score"] as int).reduce((a, b) => a + b) / speedData.length).toStringAsFixed(0)}",
                          style: TextStyle(
                            fontSize: fsH4,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
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
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Avg Mobile Score",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "${(speedData.map((s) => s["mobile_score"] as int).reduce((a, b) => a + b) / speedData.length).toStringAsFixed(0)}",
                          style: TextStyle(
                            fontSize: fsH4,
                            fontWeight: FontWeight.bold,
                            color: warningColor,
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
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Critical Issues",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "${speedData.where((s) => s["priority"] == "critical").length}",
                          style: TextStyle(
                            fontSize: fsH4,
                            fontWeight: FontWeight.bold,
                            color: dangerColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: spMd),

            // Speed Analysis
            Text(
              "Site Speed Performance Analysis",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spSm),

            ...filteredData.map((speedItem) {
              return Container(
                margin: EdgeInsets.only(bottom: spSm),
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                  border: Border(
                    left: BorderSide(
                      width: 4,
                      color: _getScoreColor(speedItem["mobile_score"] as int),
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
                              Text(
                                "${speedItem["title"]}",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                              SizedBox(height: spXs),
                              Text(
                                "${speedItem["url"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Row(
                          children: [
                            Container(
                              padding: EdgeInsets.all(spSm),
                              decoration: BoxDecoration(
                                color: _getScoreColor(speedItem["desktop_score"] as int).withAlpha(20),
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Column(
                                children: [
                                  Icon(
                                    Icons.computer,
                                    size: 16,
                                    color: _getScoreColor(speedItem["desktop_score"] as int),
                                  ),
                                  Text(
                                    "${speedItem["desktop_score"]}",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: _getScoreColor(speedItem["desktop_score"] as int),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(width: spXs),
                            Container(
                              padding: EdgeInsets.all(spSm),
                              decoration: BoxDecoration(
                                color: _getScoreColor(speedItem["mobile_score"] as int).withAlpha(20),
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Column(
                                children: [
                                  Icon(
                                    Icons.smartphone,
                                    size: 16,
                                    color: _getScoreColor(speedItem["mobile_score"] as int),
                                  ),
                                  Text(
                                    "${speedItem["mobile_score"]}",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: _getScoreColor(speedItem["mobile_score"] as int),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: spSm),

                    // Load Time Metrics
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Desktop Load Time",
                                style: TextStyle(
                                  fontSize: 11,
                                  color: disabledBoldColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                "${speedItem["desktop_load_time"]}s",
                                style: TextStyle(
                                  fontSize: 14,
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
                                "Mobile Load Time",
                                style: TextStyle(
                                  fontSize: 11,
                                  color: disabledBoldColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                "${speedItem["mobile_load_time"]}s",
                                style: TextStyle(
                                  fontSize: 14,
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
                                "Traffic",
                                style: TextStyle(
                                  fontSize: 11,
                                  color: disabledBoldColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                "${((speedItem["traffic"] as int) / 1000).toStringAsFixed(1)}K",
                                style: TextStyle(
                                  fontSize: 14,
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
                                "Bounce Rate",
                                style: TextStyle(
                                  fontSize: 11,
                                  color: disabledBoldColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                "${speedItem["bounce_rate"]}%",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spSm),

                    // Core Web Vitals
                    Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: infoColor.withAlpha(10),
                        borderRadius: BorderRadius.circular(radiusSm),
                        border: Border.all(
                          color: infoColor.withAlpha(30),
                          width: 1,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Core Web Vitals:",
                            style: TextStyle(
                              fontSize: 12,
                              color: infoColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(height: spXs),
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "LCP",
                                      style: TextStyle(
                                        fontSize: 11,
                                        color: disabledBoldColor,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    Text(
                                      "D: ${(speedItem["core_web_vitals"] as Map)["lcp"]["desktop"]}s",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: primaryColor,
                                      ),
                                    ),
                                    Text(
                                      "M: ${(speedItem["core_web_vitals"] as Map)["lcp"]["mobile"]}s",
                                      style: TextStyle(
                                        fontSize: 12,
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
                                      "FID",
                                      style: TextStyle(
                                        fontSize: 11,
                                        color: disabledBoldColor,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    Text(
                                      "D: ${(speedItem["core_web_vitals"] as Map)["fid"]["desktop"]}ms",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: primaryColor,
                                      ),
                                    ),
                                    Text(
                                      "M: ${(speedItem["core_web_vitals"] as Map)["fid"]["mobile"]}ms",
                                      style: TextStyle(
                                        fontSize: 12,
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
                                      "CLS",
                                      style: TextStyle(
                                        fontSize: 11,
                                        color: disabledBoldColor,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    Text(
                                      "D: ${(speedItem["core_web_vitals"] as Map)["cls"]["desktop"]}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: primaryColor,
                                      ),
                                    ),
                                    Text(
                                      "M: ${(speedItem["core_web_vitals"] as Map)["cls"]["mobile"]}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: primaryColor,
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
                    SizedBox(height: spSm),

                    // Performance Issues
                    if ((speedItem["issues"] as List).isNotEmpty) ...[
                      Text(
                        "Performance Issues:",
                        style: TextStyle(
                          fontSize: 12,
                          color: dangerColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: spXs),
                      ...(speedItem["issues"] as List).map((issue) {
                        return Container(
                          margin: EdgeInsets.only(bottom: spXs),
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: _getSeverityColor(issue["severity"] as String).withAlpha(10),
                            borderRadius: BorderRadius.circular(radiusSm),
                            border: Border.all(
                              color: _getSeverityColor(issue["severity"] as String).withAlpha(30),
                              width: 1,
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      "${issue["description"]}",
                                      style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w600,
                                        color: primaryColor,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                                    decoration: BoxDecoration(
                                      color: _getSeverityColor(issue["severity"] as String).withAlpha(20),
                                      borderRadius: BorderRadius.circular(radiusXs),
                                    ),
                                    child: Text(
                                      "${issue["severity"]}".toUpperCase(),
                                      style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold,
                                        color: _getSeverityColor(issue["severity"] as String),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: spXs),
                              Text(
                                "Potential savings: ${issue["impact"]}",
                                style: TextStyle(
                                  fontSize: 11,
                                  color: successColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              if ((issue["resources"] as List).isNotEmpty)
                                Text(
                                  "Resources: ${(issue["resources"] as List).join(", ")}",
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: disabledBoldColor,
                                  ),
                                ),
                            ],
                          ),
                        );
                      }).toList(),
                      SizedBox(height: spSm),
                    ],

                    // Optimization Opportunities
                    if ((speedItem["opportunities"] as List).isNotEmpty) ...[
                      Text(
                        "Optimization Opportunities:",
                        style: TextStyle(
                          fontSize: 12,
                          color: successColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: spXs),
                      ...(speedItem["opportunities"] as List).map((opportunity) {
                        return Container(
                          margin: EdgeInsets.only(bottom: spXs),
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: successColor.withAlpha(10),
                            borderRadius: BorderRadius.circular(radiusSm),
                            border: Border.all(
                              color: successColor.withAlpha(30),
                              width: 1,
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      "${opportunity["title"]}",
                                      style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w600,
                                        color: primaryColor,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                                    decoration: BoxDecoration(
                                      color: _getDifficultyColor(opportunity["difficulty"] as String).withAlpha(20),
                                      borderRadius: BorderRadius.circular(radiusXs),
                                    ),
                                    child: Text(
                                      "${opportunity["difficulty"]}".toUpperCase(),
                                      style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold,
                                        color: _getDifficultyColor(opportunity["difficulty"] as String),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: spXs),
                              Text(
                                "${opportunity["description"]}",
                                style: TextStyle(
                                  fontSize: 11,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Text(
                                "Potential savings: ${opportunity["potential_savings"]}",
                                style: TextStyle(
                                  fontSize: 11,
                                  color: successColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                      SizedBox(height: spSm),
                    ],

                    // Action Buttons
                    Row(
                      children: [
                        Expanded(
                          child: QButton(
                            label: "Run Speed Test",
                            size: bs.sm,
                            onPressed: () {
                              // Run new speed test
                            },
                          ),
                        ),
                        SizedBox(width: spSm),
                        QButton(
                          icon: Icons.analytics,
                          size: bs.sm,
                          onPressed: () {
                            // View detailed analytics
                          },
                        ),
                        SizedBox(width: spXs),
                        QButton(
                          icon: Icons.build,
                          size: bs.sm,
                          onPressed: () {
                            // Optimization suggestions
                          },
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
    );
  }
}
