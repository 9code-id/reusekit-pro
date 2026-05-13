import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class DmsDuplicateContentView extends StatefulWidget {
  const DmsDuplicateContentView({super.key});

  @override
  State<DmsDuplicateContentView> createState() => _DmsDuplicateContentViewState();
}

class _DmsDuplicateContentViewState extends State<DmsDuplicateContentView> {
  String selectedContentType = "all";
  String selectedSimilarity = "all";
  int selectedFilter = 0;

  List<Map<String, dynamic>> contentTypeOptions = [
    {"label": "All Content", "value": "all"},
    {"label": "Pages", "value": "pages"},
    {"label": "Blog Posts", "value": "blog"},
    {"label": "Products", "value": "products"},
    {"label": "Meta Content", "value": "meta"},
  ];

  List<Map<String, dynamic>> similarityOptions = [
    {"label": "All Similarity", "value": "all"},
    {"label": "Exact Match (100%)", "value": "exact"},
    {"label": "Very High (90-99%)", "value": "very_high"},
    {"label": "High (80-89%)", "value": "high"},
    {"label": "Medium (70-79%)", "value": "medium"},
  ];

  List<Map<String, dynamic>> duplicateData = [
    {
      "id": "D001",
      "primary_url": "/blog/digital-marketing-tips",
      "primary_title": "10 Essential Digital Marketing Tips for 2024",
      "content_type": "blog",
      "similarity_score": 95.8,
      "word_count": 1250,
      "duplicate_count": 3,
      "discovery_date": "2024-06-10",
      "last_updated": "2024-06-16",
      "seo_impact": "high",
      "status": "active",
      "duplicate_urls": [
        {
          "url": "/articles/digital-marketing-tips",
          "title": "10 Essential Digital Marketing Tips for Success",
          "similarity": 95.8,
          "word_count": 1245,
          "differences": "Minor title variation, same content structure"
        },
        {
          "url": "/guides/marketing-tips-2024",
          "title": "Digital Marketing Tips That Work in 2024",
          "similarity": 89.2,
          "word_count": 1180,
          "differences": "Same introduction, slightly different examples"
        },
        {
          "url": "/blog/marketing-strategies",
          "title": "Effective Marketing Strategies for Business Growth",
          "similarity": 76.4,
          "word_count": 980,
          "differences": "Similar concepts, different writing style"
        }
      ],
      "affected_metrics": {
        "total_impressions": 15400,
        "total_clicks": 890,
        "ranking_dilution": "Multiple pages competing for same keywords",
        "keyword_cannibalization": ["digital marketing", "marketing tips", "online marketing"]
      },
      "recommendations": [
        "Consolidate content into single comprehensive guide",
        "Implement 301 redirects from duplicate URLs",
        "Update internal links to point to primary URL",
        "Add unique sections to differentiate remaining pages"
      ]
    },
    {
      "id": "D002",
      "primary_url": "/products/wireless-earbuds-premium",
      "primary_title": "Premium Wireless Earbuds with Noise Cancellation",
      "content_type": "products",
      "similarity_score": 100.0,
      "word_count": 480,
      "duplicate_count": 4,
      "discovery_date": "2024-06-12",
      "last_updated": "2024-06-16",
      "seo_impact": "critical",
      "status": "critical",
      "duplicate_urls": [
        {
          "url": "/shop/earbuds-premium-wireless",
          "title": "Premium Wireless Earbuds with Noise Cancellation",
          "similarity": 100.0,
          "word_count": 480,
          "differences": "Identical content, different URL structure"
        },
        {
          "url": "/products/noise-cancelling-earbuds",
          "title": "Noise Cancelling Wireless Earbuds - Premium Quality",
          "similarity": 98.5,
          "word_count": 475,
          "differences": "Same product, minor description changes"
        },
        {
          "url": "/catalog/premium-earbuds-wireless",
          "title": "Premium Quality Wireless Earbuds",
          "similarity": 94.2,
          "word_count": 420,
          "differences": "Shorter version of same product description"
        },
        {
          "url": "/electronics/wireless-earbuds",
          "title": "Wireless Earbuds - Premium Audio Experience",
          "similarity": 87.6,
          "word_count": 380,
          "differences": "Same product features, different focus"
        }
      ],
      "affected_metrics": {
        "total_impressions": 28900,
        "total_clicks": 1240,
        "ranking_dilution": "4 pages competing for product keywords",
        "keyword_cannibalization": ["wireless earbuds", "noise cancellation", "premium earbuds"]
      },
      "recommendations": [
        "Choose single product URL and redirect others",
        "Combine all product variations into one page",
        "Use canonical tags to indicate preferred version",
        "Update product feed and internal navigation"
      ]
    },
    {
      "id": "D003",
      "primary_url": "/about/company-overview",
      "primary_title": "About Our Company - Leading Digital Solutions Provider",
      "content_type": "pages",
      "similarity_score": 82.4,
      "word_count": 650,
      "duplicate_count": 2,
      "discovery_date": "2024-06-08",
      "last_updated": "2024-06-15",
      "seo_impact": "medium",
      "status": "warning",
      "duplicate_urls": [
        {
          "url": "/company/about-us",
          "title": "About Us - Digital Solutions and Technology Services",
          "similarity": 82.4,
          "word_count": 620,
          "differences": "Similar company description, different structure"
        },
        {
          "url": "/info/company-profile",
          "title": "Company Profile - Technology and Innovation Leader",
          "similarity": 75.8,
          "word_count": 580,
          "differences": "Overlapping content about company history and services"
        }
      ],
      "affected_metrics": {
        "total_impressions": 5200,
        "total_clicks": 180,
        "ranking_dilution": "Brand searches split across multiple pages",
        "keyword_cannibalization": ["about company", "digital solutions", "company profile"]
      },
      "recommendations": [
        "Merge content into comprehensive about page",
        "Differentiate pages with unique value propositions",
        "Update navigation to use single about page",
        "Add structured data for organization information"
      ]
    },
    {
      "id": "D004",
      "primary_url": "/services/web-development",
      "primary_title": "Professional Web Development Services",
      "content_type": "pages",
      "similarity_score": 88.7,
      "word_count": 920,
      "duplicate_count": 3,
      "discovery_date": "2024-06-05",
      "last_updated": "2024-06-14",
      "seo_impact": "high",
      "status": "active",
      "duplicate_urls": [
        {
          "url": "/solutions/website-development",
          "title": "Website Development Solutions for Business Growth",
          "similarity": 88.7,
          "word_count": 890,
          "differences": "Same services, different presentation style"
        },
        {
          "url": "/web-design-development",
          "title": "Web Design & Development Services",
          "similarity": 79.3,
          "word_count": 750,
          "differences": "Combined design and development content"
        },
        {
          "url": "/digital-services/web-development",
          "title": "Custom Web Development for Modern Businesses",
          "similarity": 73.2,
          "word_count": 680,
          "differences": "Focus on custom solutions, overlapping service descriptions"
        }
      ],
      "affected_metrics": {
        "total_impressions": 12600,
        "total_clicks": 420,
        "ranking_dilution": "Service searches fragmented across pages",
        "keyword_cannibalization": ["web development", "website development", "web design"]
      },
      "recommendations": [
        "Create service hierarchy with clear differentiation",
        "Consolidate general web development content",
        "Separate design and development if truly different services",
        "Implement clear internal linking strategy"
      ]
    },
    {
      "id": "D005",
      "primary_url": "/blog/seo-best-practices",
      "primary_title": "SEO Best Practices: Complete Guide for 2024",
      "content_type": "blog",
      "similarity_score": 91.5,
      "word_count": 1850,
      "duplicate_count": 2,
      "discovery_date": "2024-05-30",
      "last_updated": "2024-06-16",
      "seo_impact": "medium",
      "status": "monitoring",
      "duplicate_urls": [
        {
          "url": "/guides/seo-optimization-guide",
          "title": "Complete SEO Optimization Guide for Better Rankings",
          "similarity": 91.5,
          "word_count": 1820,
          "differences": "Same SEO techniques, slightly different organization"
        },
        {
          "url": "/resources/search-engine-optimization",
          "title": "Search Engine Optimization: Strategies That Work",
          "similarity": 78.9,
          "word_count": 1650,
          "differences": "Overlapping strategies, different case studies"
        }
      ],
      "affected_metrics": {
        "total_impressions": 18700,
        "total_clicks": 980,
        "ranking_dilution": "SEO content competing with itself",
        "keyword_cannibalization": ["SEO best practices", "search engine optimization", "SEO guide"]
      },
      "recommendations": [
        "Update older content to reference newer comprehensive guide",
        "Create content clusters with clear topic differentiation",
        "Use canonical tags if content serves different user intents",
        "Monitor keyword rankings for cannibalization effects"
      ]
    },
  ];

  List<Map<String, dynamic>> get filteredDuplicates {
    List<Map<String, dynamic>> filtered = duplicateData;

    if (selectedContentType != "all") {
      filtered = filtered.where((item) => item["content_type"] == selectedContentType).toList();
    }

    if (selectedSimilarity != "all") {
      filtered = filtered.where((item) {
        double similarity = item["similarity_score"] as double;
        switch (selectedSimilarity) {
          case "exact":
            return similarity == 100.0;
          case "very_high":
            return similarity >= 90.0 && similarity < 100.0;
          case "high":
            return similarity >= 80.0 && similarity < 90.0;
          case "medium":
            return similarity >= 70.0 && similarity < 80.0;
          default:
            return true;
        }
      }).toList();
    }

    switch (selectedFilter) {
      case 1: // Critical Issues
        filtered = filtered.where((item) => item["status"] == "critical").toList();
        break;
      case 2: // High Impact
        filtered = filtered.where((item) => item["seo_impact"] == "high" || item["seo_impact"] == "critical").toList();
        break;
      case 3: // Many Duplicates
        filtered = filtered.where((item) => (item["duplicate_count"] as int) > 3).toList();
        break;
    }

    return filtered;
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "critical":
        return dangerColor;
      case "active":
        return warningColor;
      case "warning":
        return warningColor;
      case "monitoring":
        return infoColor;
      case "resolved":
        return successColor;
      default:
        return disabledBoldColor;
    }
  }

  Color _getSimilarityColor(double similarity) {
    if (similarity == 100.0) return dangerColor;
    if (similarity >= 90.0) return dangerColor;
    if (similarity >= 80.0) return warningColor;
    if (similarity >= 70.0) return infoColor;
    return successColor;
  }

  Color _getImpactColor(String impact) {
    switch (impact) {
      case "critical":
        return dangerColor;
      case "high":
        return dangerColor;
      case "medium":
        return warningColor;
      case "low":
        return successColor;
      default:
        return disabledBoldColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Duplicate Content"),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              // Scan for duplicate content
            },
          ),
          IconButton(
            icon: Icon(Icons.auto_fix_high),
            onPressed: () {
              // Auto-resolve duplicates
            },
          ),
          IconButton(
            icon: Icon(Icons.download),
            onPressed: () {
              // Export duplicate report
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
                    label: "Content Type",
                    items: contentTypeOptions,
                    value: selectedContentType,
                    onChanged: (value, label) {
                      selectedContentType = value;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QDropdownField(
                    label: "Similarity Level",
                    items: similarityOptions,
                    value: selectedSimilarity,
                    onChanged: (value, label) {
                      selectedSimilarity = value;
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
                {"label": "All Issues", "value": 0},
                {"label": "Critical", "value": 1},
                {"label": "High Impact", "value": 2},
                {"label": "Many Duplicates", "value": 3},
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
                          "Duplicate Groups",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "${duplicateData.length}",
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
                          "Total Duplicates",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "${duplicateData.map((d) => d["duplicate_count"] as int).reduce((a, b) => a + b)}",
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
                          "Avg Similarity",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "${((duplicateData.map((d) => d["similarity_score"] as double).reduce((a, b) => a + b)) / duplicateData.length).toStringAsFixed(1)}%",
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

            // Duplicate Content Groups
            Text(
              "Duplicate Content Groups",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spSm),

            ...filteredDuplicates.map((duplicate) {
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
                      color: _getStatusColor(duplicate["status"] as String),
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
                                  Container(
                                    padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                                    decoration: BoxDecoration(
                                      color: _getSimilarityColor(duplicate["similarity_score"] as double).withAlpha(20),
                                      borderRadius: BorderRadius.circular(radiusSm),
                                    ),
                                    child: Text(
                                      "${duplicate["similarity_score"]}% SIMILAR",
                                      style: TextStyle(
                                        fontSize: 11,
                                        fontWeight: FontWeight.bold,
                                        color: _getSimilarityColor(duplicate["similarity_score"] as double),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: spSm),
                                  Container(
                                    padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                                    decoration: BoxDecoration(
                                      color: _getImpactColor(duplicate["seo_impact"] as String).withAlpha(20),
                                      borderRadius: BorderRadius.circular(radiusSm),
                                    ),
                                    child: Text(
                                      "${duplicate["seo_impact"]} IMPACT",
                                      style: TextStyle(
                                        fontSize: 11,
                                        fontWeight: FontWeight.bold,
                                        color: _getImpactColor(duplicate["seo_impact"] as String),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: spSm),
                              Text(
                                "${duplicate["primary_title"]}",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                              SizedBox(height: spXs),
                              Text(
                                "Primary: ${duplicate["primary_url"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                  fontFamily: 'monospace',
                                ),
                              ),
                            ],
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              "${duplicate["duplicate_count"]}",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: warningColor,
                              ),
                            ),
                            Text(
                              "Duplicates",
                              style: TextStyle(
                                fontSize: 11,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: spSm),

                    // Affected Metrics
                    Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: warningColor.withAlpha(10),
                        borderRadius: BorderRadius.circular(radiusSm),
                        border: Border.all(
                          color: warningColor.withAlpha(30),
                          width: 1,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.warning,
                                color: warningColor,
                                size: 16,
                              ),
                              SizedBox(width: spSm),
                              Text(
                                "SEO Impact:",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: warningColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: spXs),
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Total Impressions",
                                      style: TextStyle(
                                        fontSize: 11,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                    Text(
                                      "${((duplicate["affected_metrics"]["total_impressions"] as int) / 1000).toStringAsFixed(1)}K",
                                      style: TextStyle(
                                        fontSize: 13,
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
                                      "Total Clicks",
                                      style: TextStyle(
                                        fontSize: 11,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                    Text(
                                      "${duplicate["affected_metrics"]["total_clicks"]}",
                                      style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.bold,
                                        color: primaryColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "${duplicate["affected_metrics"]["ranking_dilution"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: primaryColor,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: spSm),

                    // Duplicate URLs
                    Text(
                      "Duplicate URLs:",
                      style: TextStyle(
                        fontSize: 12,
                        color: primaryColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: spXs),

                    ...(duplicate["duplicate_urls"] as List).map((url) {
                      return Container(
                        margin: EdgeInsets.only(bottom: spXs),
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: Colors.grey.withAlpha(10),
                          borderRadius: BorderRadius.circular(radiusSm),
                          border: Border.all(
                            color: _getSimilarityColor(url["similarity"] as double).withAlpha(30),
                            width: 1,
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
                                        "${url["title"]}",
                                        style: TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.bold,
                                          color: primaryColor,
                                        ),
                                      ),
                                      SizedBox(height: spXs),
                                      Text(
                                        "${url["url"]}",
                                        style: TextStyle(
                                          fontSize: 11,
                                          color: disabledBoldColor,
                                          fontFamily: 'monospace',
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                                  decoration: BoxDecoration(
                                    color: _getSimilarityColor(url["similarity"] as double).withAlpha(20),
                                    borderRadius: BorderRadius.circular(radiusSm),
                                  ),
                                  child: Text(
                                    "${url["similarity"]}%",
                                    style: TextStyle(
                                      fontSize: 11,
                                      fontWeight: FontWeight.bold,
                                      color: _getSimilarityColor(url["similarity"] as double),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: spXs),
                            Row(
                              children: [
                                Text(
                                  "Words: ${url["word_count"]}",
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                SizedBox(width: spSm),
                                Expanded(
                                  child: Text(
                                    "${url["differences"]}",
                                    style: TextStyle(
                                      fontSize: 11,
                                      color: infoColor,
                                      fontStyle: FontStyle.italic,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                    SizedBox(height: spSm),

                    // Keyword Cannibalization
                    if ((duplicate["affected_metrics"]["keyword_cannibalization"] as List).isNotEmpty) ...[
                      Text(
                        "Competing Keywords:",
                        style: TextStyle(
                          fontSize: 12,
                          color: dangerColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: spXs),
                      Wrap(
                        spacing: spXs,
                        runSpacing: spXs,
                        children: (duplicate["affected_metrics"]["keyword_cannibalization"] as List).map((keyword) {
                          return Container(
                            padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                            decoration: BoxDecoration(
                              color: dangerColor.withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Text(
                              "$keyword",
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                                color: dangerColor,
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                      SizedBox(height: spSm),
                    ],

                    // Recommendations
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
                            "Recommendations:",
                            style: TextStyle(
                              fontSize: 12,
                              color: infoColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(height: spXs),
                          ...(duplicate["recommendations"] as List).take(3).map((rec) {
                            return Padding(
                              padding: EdgeInsets.only(bottom: spXs),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "• ",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: infoColor,
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(
                                      "$rec",
                                      style: TextStyle(
                                        fontSize: 13,
                                        color: primaryColor,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }).toList(),
                        ],
                      ),
                    ),
                    SizedBox(height: spSm),

                    // Meta Information
                    Row(
                      children: [
                        Text(
                          "Discovered: ${DateTime.parse(duplicate["discovery_date"]).dMMMy}",
                          style: TextStyle(
                            fontSize: 11,
                            color: disabledBoldColor,
                          ),
                        ),
                        Spacer(),
                        Text(
                          "Content Type: ${duplicate["content_type"]}",
                          style: TextStyle(
                            fontSize: 11,
                            color: disabledBoldColor,
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
                            label: "Resolve Duplicates",
                            size: bs.sm,
                            onPressed: () {
                              // Open resolution dialog
                            },
                          ),
                        ),
                        SizedBox(width: spSm),
                        QButton(
                          icon: Icons.compare,
                          size: bs.sm,
                          onPressed: () {
                            // Compare content side by side
                          },
                        ),
                        SizedBox(width: spXs),
                        QButton(
                          icon: Icons.analytics,
                          size: bs.sm,
                          onPressed: () {
                            // View detailed metrics
                          },
                        ),
                        SizedBox(width: spXs),
                        QButton(
                          icon: Icons.merge,
                          size: bs.sm,
                          onPressed: () {
                            // Merge content
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
