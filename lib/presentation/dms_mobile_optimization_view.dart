import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class DmsMobileOptimizationView extends StatefulWidget {
  const DmsMobileOptimizationView({super.key});

  @override
  State<DmsMobileOptimizationView> createState() => _DmsMobileOptimizationViewState();
}

class _DmsMobileOptimizationViewState extends State<DmsMobileOptimizationView> {
  String selectedDevice = "all_devices";
  String selectedIssueType = "all_issues";
  int selectedFilter = 0;

  List<Map<String, dynamic>> deviceOptions = [
    {"label": "All Devices", "value": "all_devices"},
    {"label": "Mobile", "value": "mobile"},
    {"label": "Tablet", "value": "tablet"},
    {"label": "Small Mobile", "value": "small_mobile"},
  ];

  List<Map<String, dynamic>> issueTypeOptions = [
    {"label": "All Issues", "value": "all_issues"},
    {"label": "Viewport Issues", "value": "viewport_issues"},
    {"label": "Touch Elements", "value": "touch_elements"},
    {"label": "Text Size", "value": "text_size"},
    {"label": "Content Sizing", "value": "content_sizing"},
    {"label": "Loading Speed", "value": "loading_speed"},
  ];

  List<Map<String, dynamic>> mobileData = [
    {
      "url": "/",
      "title": "Homepage",
      "mobile_friendly_score": 85,
      "viewport_configured": true,
      "text_readable": false,
      "touch_targets_sized": true,
      "content_fits_viewport": false,
      "mobile_speed_score": 62,
      "mobile_load_time": 4.8,
      "mobile_usability_issues": [
        {
          "type": "text_size",
          "severity": "medium",
          "description": "Text too small to read on mobile",
          "elements": [".footer-links", ".testimonial-author"],
          "affected_percentage": 15,
        },
        {
          "type": "content_sizing",
          "severity": "high",
          "description": "Content wider than screen",
          "elements": [".hero-banner", ".stats-section"],
          "affected_percentage": 25,
        }
      ],
      "mobile_improvements": [
        {
          "title": "Increase font size",
          "description": "Increase font size for footer links and testimonial authors",
          "impact": "Better readability",
          "difficulty": "easy",
        },
        {
          "title": "Fix content overflow",
          "description": "Make hero banner and stats section responsive",
          "impact": "Improved user experience",
          "difficulty": "medium",
        },
        {
          "title": "Optimize touch targets",
          "description": "Ensure all buttons are at least 48px in height",
          "impact": "Better touch interaction",
          "difficulty": "easy",
        }
      ],
      "device_metrics": {
        "mobile": {
          "score": 62,
          "load_time": 4.8,
          "bounce_rate": 68.5,
          "conversion_rate": 2.1,
        },
        "tablet": {
          "score": 74,
          "load_time": 3.2,
          "bounce_rate": 52.3,
          "conversion_rate": 3.8,
        },
        "small_mobile": {
          "score": 58,
          "load_time": 5.2,
          "bounce_rate": 72.8,
          "conversion_rate": 1.8,
        }
      },
      "priority": "high",
      "traffic": 15800,
      "mobile_traffic_percentage": 78.5,
    },
    {
      "url": "/products/marketing-software",
      "title": "Marketing Software Product Page",
      "mobile_friendly_score": 68,
      "viewport_configured": true,
      "text_readable": true,
      "touch_targets_sized": false,
      "content_fits_viewport": false,
      "mobile_speed_score": 45,
      "mobile_load_time": 6.8,
      "mobile_usability_issues": [
        {
          "type": "touch_elements",
          "severity": "critical",
          "description": "Touch targets too close together",
          "elements": [".product-options", ".feature-tabs", ".pricing-buttons"],
          "affected_percentage": 40,
        },
        {
          "type": "content_sizing",
          "severity": "high",
          "description": "Product images overflow viewport",
          "elements": [".product-gallery", ".feature-comparison"],
          "affected_percentage": 35,
        },
        {
          "type": "loading_speed",
          "severity": "critical",
          "description": "Page loads too slowly on mobile",
          "elements": ["Large product images", "Unoptimized videos"],
          "affected_percentage": 100,
        }
      ],
      "mobile_improvements": [
        {
          "title": "Increase touch target spacing",
          "description": "Add more spacing between product options and feature tabs",
          "impact": "Reduced accidental taps",
          "difficulty": "easy",
        },
        {
          "title": "Optimize product images",
          "description": "Implement responsive images and lazy loading",
          "impact": "Faster loading, better layout",
          "difficulty": "medium",
        },
        {
          "title": "Mobile-first design",
          "description": "Redesign product page layout for mobile devices",
          "impact": "Significantly improved UX",
          "difficulty": "hard",
        }
      ],
      "device_metrics": {
        "mobile": {
          "score": 45,
          "load_time": 6.8,
          "bounce_rate": 78.2,
          "conversion_rate": 1.2,
        },
        "tablet": {
          "score": 58,
          "load_time": 4.9,
          "bounce_rate": 65.8,
          "conversion_rate": 2.8,
        },
        "small_mobile": {
          "score": 38,
          "load_time": 7.8,
          "bounce_rate": 85.2,
          "conversion_rate": 0.8,
        }
      },
      "priority": "critical",
      "traffic": 8900,
      "mobile_traffic_percentage": 85.2,
    },
    {
      "url": "/blog/digital-marketing-guide",
      "title": "Digital Marketing Guide Blog Post",
      "mobile_friendly_score": 92,
      "viewport_configured": true,
      "text_readable": true,
      "touch_targets_sized": true,
      "content_fits_viewport": true,
      "mobile_speed_score": 78,
      "mobile_load_time": 3.1,
      "mobile_usability_issues": [
        {
          "type": "text_size",
          "severity": "low",
          "description": "Some code snippets have small font size",
          "elements": [".code-block"],
          "affected_percentage": 5,
        }
      ],
      "mobile_improvements": [
        {
          "title": "Improve code readability",
          "description": "Increase font size for code snippets on mobile",
          "impact": "Better code readability",
          "difficulty": "easy",
        },
        {
          "title": "Add reading progress indicator",
          "description": "Add scroll progress bar for long articles",
          "impact": "Better user engagement",
          "difficulty": "medium",
        }
      ],
      "device_metrics": {
        "mobile": {
          "score": 78,
          "load_time": 3.1,
          "bounce_rate": 45.8,
          "conversion_rate": 4.2,
        },
        "tablet": {
          "score": 85,
          "load_time": 2.4,
          "bounce_rate": 38.5,
          "conversion_rate": 5.8,
        },
        "small_mobile": {
          "score": 72,
          "load_time": 3.8,
          "bounce_rate": 52.1,
          "conversion_rate": 3.5,
        }
      },
      "priority": "low",
      "traffic": 12400,
      "mobile_traffic_percentage": 71.2,
    },
    {
      "url": "/services/seo-optimization",
      "title": "SEO Optimization Services",
      "mobile_friendly_score": 71,
      "viewport_configured": true,
      "text_readable": true,
      "touch_targets_sized": false,
      "content_fits_viewport": true,
      "mobile_speed_score": 52,
      "mobile_load_time": 5.9,
      "mobile_usability_issues": [
        {
          "type": "touch_elements",
          "severity": "medium",
          "description": "Service selection buttons too small",
          "elements": [".service-packages", ".contact-buttons"],
          "affected_percentage": 20,
        },
        {
          "type": "loading_speed",
          "severity": "high",
          "description": "Service showcase images slow to load",
          "elements": [".service-portfolio", ".case-studies"],
          "affected_percentage": 60,
        }
      ],
      "mobile_improvements": [
        {
          "title": "Enlarge touch targets",
          "description": "Make service selection and contact buttons larger",
          "impact": "Better touch interaction",
          "difficulty": "easy",
        },
        {
          "title": "Optimize service images",
          "description": "Compress and implement lazy loading for portfolio images",
          "impact": "Faster loading times",
          "difficulty": "medium",
        },
        {
          "title": "Mobile service navigation",
          "description": "Create mobile-friendly service navigation",
          "impact": "Improved navigation UX",
          "difficulty": "medium",
        }
      ],
      "device_metrics": {
        "mobile": {
          "score": 52,
          "load_time": 5.9,
          "bounce_rate": 72.4,
          "conversion_rate": 2.8,
        },
        "tablet": {
          "score": 61,
          "load_time": 4.6,
          "bounce_rate": 58.9,
          "conversion_rate": 4.1,
        },
        "small_mobile": {
          "score": 48,
          "load_time": 6.8,
          "bounce_rate": 78.5,
          "conversion_rate": 2.1,
        }
      },
      "priority": "high",
      "traffic": 6700,
      "mobile_traffic_percentage": 82.3,
    },
    {
      "url": "/contact",
      "title": "Contact Us Page",
      "mobile_friendly_score": 88,
      "viewport_configured": true,
      "text_readable": true,
      "touch_targets_sized": true,
      "content_fits_viewport": true,
      "mobile_speed_score": 81,
      "mobile_load_time": 2.8,
      "mobile_usability_issues": [
        {
          "type": "viewport_issues",
          "severity": "low",
          "description": "Map container slightly overflows on small screens",
          "elements": [".contact-map"],
          "affected_percentage": 8,
        }
      ],
      "mobile_improvements": [
        {
          "title": "Fix map container",
          "description": "Ensure map fits perfectly in small viewports",
          "impact": "Perfect mobile layout",
          "difficulty": "easy",
        },
        {
          "title": "Add click-to-call buttons",
          "description": "Make phone numbers clickable on mobile",
          "impact": "Better user convenience",
          "difficulty": "easy",
        }
      ],
      "device_metrics": {
        "mobile": {
          "score": 81,
          "load_time": 2.8,
          "bounce_rate": 38.5,
          "conversion_rate": 6.2,
        },
        "tablet": {
          "score": 85,
          "load_time": 2.3,
          "bounce_rate": 32.1,
          "conversion_rate": 7.8,
        },
        "small_mobile": {
          "score": 78,
          "load_time": 3.2,
          "bounce_rate": 42.8,
          "conversion_rate": 5.5,
        }
      },
      "priority": "low",
      "traffic": 3200,
      "mobile_traffic_percentage": 75.8,
    },
  ];

  List<Map<String, dynamic>> get filteredData {
    List<Map<String, dynamic>> filtered = mobileData;

    if (selectedIssueType != "all_issues") {
      filtered = filtered.where((item) {
        List issues = item["mobile_usability_issues"] as List;
        return issues.any((issue) => (issue as Map)["type"] == selectedIssueType);
      }).toList();
    }

    switch (selectedFilter) {
      case 1: // Critical Issues
        filtered = filtered.where((item) => item["priority"] == "critical").toList();
        break;
      case 2: // Poor Mobile Score
        filtered = filtered.where((item) => (item["mobile_friendly_score"] as int) < 70).toList();
        break;
      case 3: // Good Mobile UX
        filtered = filtered.where((item) => (item["mobile_friendly_score"] as int) >= 80).toList();
        break;
    }

    return filtered;
  }

  Color _getScoreColor(int score) {
    if (score >= 80) return successColor;
    if (score >= 60) return infoColor;
    if (score >= 40) return warningColor;
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
        title: Text("Mobile Optimization"),
        actions: [
          IconButton(
            icon: Icon(Icons.smartphone),
            onPressed: () {
              // Mobile preview
            },
          ),
          IconButton(
            icon: Icon(Icons.analytics),
            onPressed: () {
              // Mobile analytics
            },
          ),
          IconButton(
            icon: Icon(Icons.download),
            onPressed: () {
              // Export mobile report
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
                {"label": "Poor Mobile", "value": 2},
                {"label": "Good Mobile", "value": 3},
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
                          "Avg Mobile Score",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "${(mobileData.map((m) => m["mobile_friendly_score"] as int).reduce((a, b) => a + b) / mobileData.length).toStringAsFixed(0)}",
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
                          "Mobile Traffic",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "${(mobileData.map((m) => m["mobile_traffic_percentage"] as double).reduce((a, b) => a + b) / mobileData.length).toStringAsFixed(1)}%",
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
                          "Critical Issues",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "${mobileData.where((m) => m["priority"] == "critical").length}",
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

            // Mobile Optimization Analysis
            Text(
              "Mobile Optimization Analysis",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spSm),

            ...filteredData.map((mobileItem) {
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
                      color: _getScoreColor(mobileItem["mobile_friendly_score"] as int),
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
                                "${mobileItem["title"]}",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                              SizedBox(height: spXs),
                              Text(
                                "${mobileItem["url"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: _getScoreColor(mobileItem["mobile_friendly_score"] as int).withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Column(
                            children: [
                              Icon(
                                Icons.smartphone,
                                size: 20,
                                color: _getScoreColor(mobileItem["mobile_friendly_score"] as int),
                              ),
                              Text(
                                "${mobileItem["mobile_friendly_score"]}",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: _getScoreColor(mobileItem["mobile_friendly_score"] as int),
                                ),
                              ),
                              Text(
                                "Score",
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
                    SizedBox(height: spSm),

                    // Mobile Friendly Indicators
                    Row(
                      children: [
                        Expanded(
                          child: Row(
                            children: [
                              Icon(
                                mobileItem["viewport_configured"] ? Icons.check_circle : Icons.cancel,
                                size: 16,
                                color: mobileItem["viewport_configured"] ? successColor : dangerColor,
                              ),
                              SizedBox(width: spXs),
                              Text(
                                "Viewport",
                                style: TextStyle(
                                  fontSize: 11,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Row(
                            children: [
                              Icon(
                                mobileItem["text_readable"] ? Icons.check_circle : Icons.cancel,
                                size: 16,
                                color: mobileItem["text_readable"] ? successColor : dangerColor,
                              ),
                              SizedBox(width: spXs),
                              Text(
                                "Text Size",
                                style: TextStyle(
                                  fontSize: 11,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Row(
                            children: [
                              Icon(
                                mobileItem["touch_targets_sized"] ? Icons.check_circle : Icons.cancel,
                                size: 16,
                                color: mobileItem["touch_targets_sized"] ? successColor : dangerColor,
                              ),
                              SizedBox(width: spXs),
                              Text(
                                "Touch Targets",
                                style: TextStyle(
                                  fontSize: 11,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Row(
                            children: [
                              Icon(
                                mobileItem["content_fits_viewport"] ? Icons.check_circle : Icons.cancel,
                                size: 16,
                                color: mobileItem["content_fits_viewport"] ? successColor : dangerColor,
                              ),
                              SizedBox(width: spXs),
                              Text(
                                "Content Fit",
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
                    SizedBox(height: spSm),

                    // Device Performance Metrics
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
                            "Device Performance:",
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
                                  children: [
                                    Text(
                                      "Mobile",
                                      style: TextStyle(
                                        fontSize: 11,
                                        color: disabledBoldColor,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    Text(
                                      "${(mobileItem["device_metrics"] as Map)["mobile"]["score"]}",
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: _getScoreColor((mobileItem["device_metrics"] as Map)["mobile"]["score"] as int),
                                      ),
                                    ),
                                    Text(
                                      "${(mobileItem["device_metrics"] as Map)["mobile"]["load_time"]}s",
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
                                      "Tablet",
                                      style: TextStyle(
                                        fontSize: 11,
                                        color: disabledBoldColor,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    Text(
                                      "${(mobileItem["device_metrics"] as Map)["tablet"]["score"]}",
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: _getScoreColor((mobileItem["device_metrics"] as Map)["tablet"]["score"] as int),
                                      ),
                                    ),
                                    Text(
                                      "${(mobileItem["device_metrics"] as Map)["tablet"]["load_time"]}s",
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
                                      "Small Mobile",
                                      style: TextStyle(
                                        fontSize: 11,
                                        color: disabledBoldColor,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    Text(
                                      "${(mobileItem["device_metrics"] as Map)["small_mobile"]["score"]}",
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: _getScoreColor((mobileItem["device_metrics"] as Map)["small_mobile"]["score"] as int),
                                      ),
                                    ),
                                    Text(
                                      "${(mobileItem["device_metrics"] as Map)["small_mobile"]["load_time"]}s",
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
                        ],
                      ),
                    ),
                    SizedBox(height: spSm),

                    // Mobile Usability Issues
                    if ((mobileItem["mobile_usability_issues"] as List).isNotEmpty) ...[
                      Text(
                        "Mobile Usability Issues:",
                        style: TextStyle(
                          fontSize: 12,
                          color: dangerColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: spXs),
                      ...(mobileItem["mobile_usability_issues"] as List).map((issue) {
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
                                "Affected: ${issue["affected_percentage"]}% of page",
                                style: TextStyle(
                                  fontSize: 11,
                                  color: warningColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                "Elements: ${(issue["elements"] as List).join(", ")}",
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

                    // Mobile Improvements
                    if ((mobileItem["mobile_improvements"] as List).isNotEmpty) ...[
                      Text(
                        "Mobile Improvements:",
                        style: TextStyle(
                          fontSize: 12,
                          color: successColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: spXs),
                      ...(mobileItem["mobile_improvements"] as List).map((improvement) {
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
                                      "${improvement["title"]}",
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
                                      color: _getDifficultyColor(improvement["difficulty"] as String).withAlpha(20),
                                      borderRadius: BorderRadius.circular(radiusXs),
                                    ),
                                    child: Text(
                                      "${improvement["difficulty"]}".toUpperCase(),
                                      style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold,
                                        color: _getDifficultyColor(improvement["difficulty"] as String),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: spXs),
                              Text(
                                "${improvement["description"]}",
                                style: TextStyle(
                                  fontSize: 11,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Text(
                                "Impact: ${improvement["impact"]}",
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

                    // Traffic & Conversion Metrics
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Total Traffic",
                                style: TextStyle(
                                  fontSize: 11,
                                  color: disabledBoldColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                "${((mobileItem["traffic"] as int) / 1000).toStringAsFixed(1)}K",
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
                                "Mobile Traffic",
                                style: TextStyle(
                                  fontSize: 11,
                                  color: disabledBoldColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                "${mobileItem["mobile_traffic_percentage"]}%",
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
                                "Mobile CVR",
                                style: TextStyle(
                                  fontSize: 11,
                                  color: disabledBoldColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                "${(mobileItem["device_metrics"] as Map)["mobile"]["conversion_rate"]}%",
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
                                "Mobile Bounce",
                                style: TextStyle(
                                  fontSize: 11,
                                  color: disabledBoldColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                "${(mobileItem["device_metrics"] as Map)["mobile"]["bounce_rate"]}%",
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

                    // Action Buttons
                    Row(
                      children: [
                        Expanded(
                          child: QButton(
                            label: "Mobile Preview",
                            size: bs.sm,
                            onPressed: () {
                              // Preview in mobile view
                            },
                          ),
                        ),
                        SizedBox(width: spSm),
                        QButton(
                          icon: Icons.build,
                          size: bs.sm,
                          onPressed: () {
                            // Mobile optimization tools
                          },
                        ),
                        SizedBox(width: spXs),
                        QButton(
                          icon: Icons.analytics,
                          size: bs.sm,
                          onPressed: () {
                            // Mobile analytics
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
