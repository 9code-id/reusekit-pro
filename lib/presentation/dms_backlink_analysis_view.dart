import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class DmsBacklinkAnalysisView extends StatefulWidget {
  const DmsBacklinkAnalysisView({super.key});

  @override
  State<DmsBacklinkAnalysisView> createState() => _DmsBacklinkAnalysisViewState();
}

class _DmsBacklinkAnalysisViewState extends State<DmsBacklinkAnalysisView> {
  String selectedLinkType = "all";
  String selectedQuality = "all";
  int selectedFilter = 0;

  List<Map<String, dynamic>> linkTypeOptions = [
    {"label": "All Types", "value": "all"},
    {"label": "Follow Links", "value": "follow"},
    {"label": "No-Follow Links", "value": "nofollow"},
    {"label": "Image Links", "value": "image"},
    {"label": "Text Links", "value": "text"},
  ];

  List<Map<String, dynamic>> qualityOptions = [
    {"label": "All Quality", "value": "all"},
    {"label": "High Quality", "value": "high"},
    {"label": "Medium Quality", "value": "medium"},
    {"label": "Low Quality", "value": "low"},
    {"label": "Toxic Links", "value": "toxic"},
  ];

  List<Map<String, dynamic>> backlinkData = [
    {
      "id": "BL001",
      "source_domain": "techcrunch.com",
      "source_url": "https://techcrunch.com/2024/06/digital-marketing-trends",
      "target_url": "https://example.com/blog/marketing-guide",
      "anchor_text": "comprehensive marketing guide",
      "link_type": "follow",
      "quality_score": 95,
      "quality_rating": "high",
      "domain_authority": 92,
      "page_authority": 78,
      "trust_flow": 85,
      "citation_flow": 88,
      "spam_score": 2,
      "first_detected": "2024-06-10",
      "last_seen": "2024-06-16",
      "link_context": "The article mentions several resources, including this comprehensive marketing guide that covers all essential strategies for modern businesses.",
      "link_placement": "editorial_content",
      "traffic_value": 850,
      "referring_ips": 1,
      "status": "active",
      "language": "english",
      "country": "US",
      "industry": "technology",
      "link_velocity": "+15% this month"
    },
    {
      "id": "BL002",
      "source_domain": "marketingland.com",
      "source_url": "https://marketingland.com/seo-tools-comparison-2024",
      "target_url": "https://example.com/tools/seo-analyzer",
      "anchor_text": "free SEO analyzer tool",
      "link_type": "follow",
      "quality_score": 88,
      "quality_rating": "high",
      "domain_authority": 85,
      "page_authority": 72,
      "trust_flow": 82,
      "citation_flow": 85,
      "spam_score": 1,
      "first_detected": "2024-06-08",
      "last_seen": "2024-06-16",
      "link_context": "For businesses looking for free alternatives, this SEO analyzer tool provides comprehensive website analysis without any cost.",
      "link_placement": "resource_list",
      "traffic_value": 640,
      "referring_ips": 1,
      "status": "active",
      "language": "english",
      "country": "US",
      "industry": "marketing",
      "link_velocity": "+8% this month"
    },
    {
      "id": "BL003",
      "source_domain": "businessblog247.com",
      "source_url": "https://businessblog247.com/guest-post-digital-marketing",
      "target_url": "https://example.com/services/digital-marketing",
      "anchor_text": "click here",
      "link_type": "follow",
      "quality_score": 45,
      "quality_rating": "low",
      "domain_authority": 28,
      "page_authority": 22,
      "trust_flow": 15,
      "citation_flow": 35,
      "spam_score": 65,
      "first_detected": "2024-06-12",
      "last_seen": "2024-06-16",
      "link_context": "This service can help your business grow online. For more information, click here to learn about their offerings.",
      "link_placement": "footer",
      "traffic_value": 5,
      "referring_ips": 1,
      "status": "active",
      "language": "english",
      "country": "unknown",
      "industry": "general",
      "link_velocity": "new this month"
    },
    {
      "id": "BL004",
      "source_domain": "spamsite-links.net",
      "source_url": "https://spamsite-links.net/directory/business-services",
      "target_url": "https://example.com/",
      "anchor_text": "best digital marketing company",
      "link_type": "follow",
      "quality_score": 12,
      "quality_rating": "toxic",
      "domain_authority": 8,
      "page_authority": 5,
      "trust_flow": 2,
      "citation_flow": 45,
      "spam_score": 95,
      "first_detected": "2024-06-14",
      "last_seen": "2024-06-16",
      "link_context": "Automated directory listing with multiple outbound links and promotional content.",
      "link_placement": "directory_listing",
      "traffic_value": 0,
      "referring_ips": 1,
      "status": "flagged",
      "language": "english",
      "country": "unknown",
      "industry": "link_farm",
      "link_velocity": "new this week"
    },
    {
      "id": "BL005",
      "source_domain": "socialmediatoday.com",
      "source_url": "https://socialmediatoday.com/social-media-marketing-trends",
      "target_url": "https://example.com/blog/social-media-strategy",
      "anchor_text": "social media strategy guide",
      "link_type": "nofollow",
      "quality_score": 78,
      "quality_rating": "medium",
      "domain_authority": 80,
      "page_authority": 65,
      "trust_flow": 75,
      "citation_flow": 82,
      "spam_score": 8,
      "first_detected": "2024-06-05",
      "last_seen": "2024-06-16",
      "link_context": "The article references several strategy guides, including this detailed social media strategy guide for businesses.",
      "link_placement": "reference_link",
      "traffic_value": 320,
      "referring_ips": 1,
      "status": "active",
      "language": "english",
      "country": "US",
      "industry": "social_media",
      "link_velocity": "stable"
    },
    {
      "id": "BL006",
      "source_domain": "contentmarketinginstitute.com",
      "source_url": "https://contentmarketinginstitute.com/content-creation-tools",
      "target_url": "https://example.com/tools/content-planner",
      "anchor_text": "content planning tool",
      "link_type": "follow",
      "quality_score": 91,
      "quality_rating": "high",
      "domain_authority": 89,
      "page_authority": 76,
      "trust_flow": 88,
      "citation_flow": 90,
      "spam_score": 3,
      "first_detected": "2024-05-28",
      "last_seen": "2024-06-16",
      "link_context": "For content planning and organization, teams often rely on specialized tools like this content planning tool to streamline their workflow.",
      "link_placement": "tool_recommendation",
      "traffic_value": 1200,
      "referring_ips": 1,
      "status": "active",
      "language": "english",
      "country": "US",
      "industry": "content_marketing",
      "link_velocity": "+12% this month"
    },
  ];

  List<Map<String, dynamic>> get filteredBacklinks {
    List<Map<String, dynamic>> filtered = backlinkData;

    if (selectedLinkType != "all") {
      filtered = filtered.where((item) => item["link_type"] == selectedLinkType).toList();
    }

    if (selectedQuality != "all") {
      filtered = filtered.where((item) => item["quality_rating"] == selectedQuality).toList();
    }

    switch (selectedFilter) {
      case 1: // High Quality
        filtered = filtered.where((item) => (item["quality_score"] as int) >= 80).toList();
        break;
      case 2: // Toxic Links
        filtered = filtered.where((item) => item["quality_rating"] == "toxic" || (item["spam_score"] as int) > 80).toList();
        break;
      case 3: // Recent Links
        filtered = filtered.where((item) => DateTime.parse(item["first_detected"]).isAfter(DateTime.now().subtract(Duration(days: 7)))).toList();
        break;
    }

    return filtered;
  }

  Color _getQualityColor(String quality) {
    switch (quality) {
      case "high":
        return successColor;
      case "medium":
        return infoColor;
      case "low":
        return warningColor;
      case "toxic":
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  Color _getLinkTypeColor(String type) {
    switch (type) {
      case "follow":
        return successColor;
      case "nofollow":
        return warningColor;
      case "image":
        return infoColor;
      case "text":
        return primaryColor;
      default:
        return disabledBoldColor;
    }
  }

  Color _getSpamScoreColor(int score) {
    if (score >= 80) return dangerColor;
    if (score >= 50) return warningColor;
    if (score >= 20) return infoColor;
    return successColor;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Backlink Analysis"),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              // Refresh backlink data
            },
          ),
          IconButton(
            icon: Icon(Icons.block),
            onPressed: () {
              // Disavow toxic links
            },
          ),
          IconButton(
            icon: Icon(Icons.download),
            onPressed: () {
              // Export backlink report
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
                    label: "Link Type",
                    items: linkTypeOptions,
                    value: selectedLinkType,
                    onChanged: (value, label) {
                      selectedLinkType = value;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QDropdownField(
                    label: "Quality",
                    items: qualityOptions,
                    value: selectedQuality,
                    onChanged: (value, label) {
                      selectedQuality = value;
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
                {"label": "All Links", "value": 0},
                {"label": "High Quality", "value": 1},
                {"label": "Toxic Links", "value": 2},
                {"label": "Recent", "value": 3},
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
                          "Total Backlinks",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "${backlinkData.length}",
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
                          "High Quality",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "${backlinkData.where((b) => b["quality_rating"] == "high").length}",
                          style: TextStyle(
                            fontSize: fsH4,
                            fontWeight: FontWeight.bold,
                            color: successColor,
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
                          "Toxic Links",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "${backlinkData.where((b) => b["quality_rating"] == "toxic").length}",
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

            // Backlinks List
            Text(
              "Backlink Profile",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spSm),

            ...filteredBacklinks.map((backlink) {
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
                      color: _getQualityColor(backlink["quality_rating"] as String),
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
                                      color: _getQualityColor(backlink["quality_rating"] as String).withAlpha(20),
                                      borderRadius: BorderRadius.circular(radiusSm),
                                    ),
                                    child: Text(
                                      "${backlink["quality_rating"]}".toUpperCase(),
                                      style: TextStyle(
                                        fontSize: 11,
                                        fontWeight: FontWeight.bold,
                                        color: _getQualityColor(backlink["quality_rating"] as String),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: spSm),
                                  Container(
                                    padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                                    decoration: BoxDecoration(
                                      color: _getLinkTypeColor(backlink["link_type"] as String).withAlpha(20),
                                      borderRadius: BorderRadius.circular(radiusSm),
                                    ),
                                    child: Text(
                                      "${backlink["link_type"]}".toUpperCase(),
                                      style: TextStyle(
                                        fontSize: 11,
                                        fontWeight: FontWeight.bold,
                                        color: _getLinkTypeColor(backlink["link_type"] as String),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: spSm),
                              Text(
                                "${backlink["source_domain"]}",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                              SizedBox(height: spXs),
                              Text(
                                "DA: ${backlink["domain_authority"]} • PA: ${backlink["page_authority"]}",
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
                            Text(
                              "${backlink["quality_score"]}",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: _getQualityColor(backlink["quality_rating"] as String),
                              ),
                            ),
                            Text(
                              "Quality Score",
                              style: TextStyle(
                                fontSize: 10,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: spSm),

                    // Link Information
                    Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: Colors.grey.withAlpha(10),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.link,
                                color: primaryColor,
                                size: 16,
                              ),
                              SizedBox(width: spSm),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Source URL:",
                                      style: TextStyle(
                                        fontSize: 11,
                                        color: disabledBoldColor,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    Text(
                                      "${backlink["source_url"]}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: primaryColor,
                                        fontFamily: 'monospace',
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: spSm),
                          Row(
                            children: [
                              Icon(
                                Icons.arrow_downward,
                                color: successColor,
                                size: 16,
                              ),
                              SizedBox(width: spSm),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Target URL:",
                                      style: TextStyle(
                                        fontSize: 11,
                                        color: disabledBoldColor,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    Text(
                                      "${backlink["target_url"]}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: successColor,
                                        fontFamily: 'monospace',
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

                    // Anchor Text
                    Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: infoColor.withAlpha(10),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.text_fields,
                            color: infoColor,
                            size: 16,
                          ),
                          SizedBox(width: spSm),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Anchor Text:",
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: infoColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Text(
                                  "\"${backlink["anchor_text"]}\"",
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: primaryColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: spSm),

                    // Metrics
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Trust Flow",
                                style: TextStyle(
                                  fontSize: 11,
                                  color: disabledBoldColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                "${backlink["trust_flow"]}",
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
                                "Citation Flow",
                                style: TextStyle(
                                  fontSize: 11,
                                  color: disabledBoldColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                "${backlink["citation_flow"]}",
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
                                "Spam Score",
                                style: TextStyle(
                                  fontSize: 11,
                                  color: disabledBoldColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                "${backlink["spam_score"]}%",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: _getSpamScoreColor(backlink["spam_score"] as int),
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
                                "Traffic Value",
                                style: TextStyle(
                                  fontSize: 11,
                                  color: disabledBoldColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                "\$${backlink["traffic_value"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: successColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spSm),

                    // Link Context
                    if (backlink["link_context"] != null && (backlink["link_context"] as String).isNotEmpty) ...[
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
                                  Icons.article,
                                  color: warningColor,
                                  size: 16,
                                ),
                                SizedBox(width: spSm),
                                Text(
                                  "Link Context:",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: warningColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: spXs),
                            Text(
                              "\"${backlink["link_context"]}\"",
                              style: TextStyle(
                                fontSize: 13,
                                color: primaryColor,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: spSm),
                    ],

                    // Additional Information
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "First Detected",
                                style: TextStyle(
                                  fontSize: 11,
                                  color: disabledBoldColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                "${DateTime.parse(backlink["first_detected"]).dMMMy}",
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
                                "Link Placement",
                                style: TextStyle(
                                  fontSize: 11,
                                  color: disabledBoldColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                "${backlink["link_placement"]}".replaceAll("_", " "),
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
                                "Industry",
                                style: TextStyle(
                                  fontSize: 11,
                                  color: disabledBoldColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                "${backlink["industry"]}".replaceAll("_", " "),
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
                                "Link Velocity",
                                style: TextStyle(
                                  fontSize: 11,
                                  color: disabledBoldColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                "${backlink["link_velocity"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: backlink["link_velocity"].toString().contains("+") ? successColor : primaryColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spSm),

                    // Status and Actions
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                          decoration: BoxDecoration(
                            color: backlink["status"] == "active" ? successColor.withAlpha(20) : dangerColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Text(
                            "${backlink["status"]}".toUpperCase(),
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                              color: backlink["status"] == "active" ? successColor : dangerColor,
                            ),
                          ),
                        ),
                        Spacer(),
                        QButton(
                          icon: Icons.visibility,
                          size: bs.sm,
                          onPressed: () {
                            // View source page
                          },
                        ),
                        SizedBox(width: spXs),
                        QButton(
                          icon: Icons.analytics,
                          size: bs.sm,
                          onPressed: () {
                            // View detailed analysis
                          },
                        ),
                        if (backlink["quality_rating"] == "toxic") ...[
                          SizedBox(width: spXs),
                          QButton(
                            icon: Icons.block,
                            size: bs.sm,
                            onPressed: () {
                              // Disavow link
                            },
                          ),
                        ],
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
