import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class DmsLinkOpportunitiesView extends StatefulWidget {
  const DmsLinkOpportunitiesView({super.key});

  @override
  State<DmsLinkOpportunitiesView> createState() => _DmsLinkOpportunitiesViewState();
}

class _DmsLinkOpportunitiesViewState extends State<DmsLinkOpportunitiesView> {
  String selectedCategory = "all";
  String selectedDifficulty = "all";
  String selectedPriority = "all";
  String searchQuery = "";
  
  List<Map<String, dynamic>> categoryOptions = [
    {"label": "All Categories", "value": "all"},
    {"label": "Guest Posting", "value": "guest_posting"},
    {"label": "Resource Pages", "value": "resource_pages"},
    {"label": "Broken Links", "value": "broken_links"},
    {"label": "Competitor Analysis", "value": "competitor_analysis"},
    {"label": "HARO", "value": "haro"},
    {"label": "Directory", "value": "directory"},
    {"label": "Partnerships", "value": "partnerships"},
  ];

  List<Map<String, dynamic>> difficultyOptions = [
    {"label": "All Difficulty", "value": "all"},
    {"label": "Easy", "value": "easy"},
    {"label": "Medium", "value": "medium"},
    {"label": "Hard", "value": "hard"},
  ];

  List<Map<String, dynamic>> priorityOptions = [
    {"label": "All Priority", "value": "all"},
    {"label": "High", "value": "high"},
    {"label": "Medium", "value": "medium"},
    {"label": "Low", "value": "low"},
  ];

  List<Map<String, dynamic>> linkOpportunities = [
    {
      "id": 1,
      "domain": "tech-insights.com",
      "url": "https://tech-insights.com/ai-tools-roundup",
      "title": "Best AI Tools for Business 2024",
      "category": "guest_posting",
      "difficulty": "medium",
      "priority": "high",
      "domain_authority": 72,
      "traffic": 45000,
      "spam_score": 2,
      "contact_email": "editor@tech-insights.com",
      "outreach_status": "not_contacted",
      "estimated_value": 1200,
      "success_probability": 75,
      "last_updated": DateTime.now().subtract(Duration(days: 2)),
      "notes": "Editor mentioned interest in AI content in recent newsletter",
      "follow_up_date": DateTime.now().add(Duration(days: 7)),
      "industry": "Technology",
      "content_type": "Article",
      "link_type": "dofollow",
      "anchor_suggestions": ["AI business tools", "automation software", "enterprise AI"],
      "contact_name": "Sarah Johnson",
      "social_media": {
        "twitter": "@sarahtechie",
        "linkedin": "linkedin.com/in/sarahjohnson-tech"
      },
      "referring_domains": 1250,
      "organic_keywords": 125000,
      "trust_flow": 45,
      "citation_flow": 52,
    },
    {
      "id": 2,
      "domain": "startupnews.io",
      "url": "https://startupnews.io/resources/funding-tools",
      "title": "Startup Resource Directory",
      "category": "resource_pages",
      "difficulty": "easy",
      "priority": "medium",
      "domain_authority": 58,
      "traffic": 28000,
      "spam_score": 1,
      "contact_email": "resources@startupnews.io",
      "outreach_status": "email_sent",
      "estimated_value": 650,
      "success_probability": 85,
      "last_updated": DateTime.now().subtract(Duration(days: 1)),
      "notes": "Resource page actively maintained, accepts quality submissions",
      "follow_up_date": DateTime.now().add(Duration(days: 3)),
      "industry": "Business",
      "content_type": "Directory Listing",
      "link_type": "dofollow",
      "anchor_suggestions": ["business automation", "startup tools", "productivity platform"],
      "contact_name": "Mike Chen",
      "social_media": {
        "twitter": "@mikestartup",
        "linkedin": "linkedin.com/in/mikechen-startup"
      },
      "referring_domains": 680,
      "organic_keywords": 89000,
      "trust_flow": 38,
      "citation_flow": 44,
    },
    {
      "id": 3,
      "domain": "industry-magazine.com",
      "url": "https://industry-magazine.com/broken-link-page",
      "title": "Software Solutions Comparison",
      "category": "broken_links",
      "difficulty": "easy",
      "priority": "high",
      "domain_authority": 68,
      "traffic": 35000,
      "spam_score": 0,
      "contact_email": "webmaster@industry-magazine.com",
      "outreach_status": "response_received",
      "estimated_value": 980,
      "success_probability": 90,
      "last_updated": DateTime.now().subtract(Duration(hours: 6)),
      "notes": "Confirmed broken link, editor willing to replace with our content",
      "follow_up_date": DateTime.now().add(Duration(days: 1)),
      "industry": "Technology",
      "content_type": "Comparison",
      "link_type": "dofollow",
      "anchor_suggestions": ["comprehensive solution", "leading platform", "innovative software"],
      "contact_name": "Lisa Rodriguez",
      "social_media": {
        "twitter": "@lisaindustry",
        "linkedin": "linkedin.com/in/lisarodriguez-tech"
      },
      "referring_domains": 890,
      "organic_keywords": 98000,
      "trust_flow": 42,
      "citation_flow": 48,
    },
    {
      "id": 4,
      "domain": "competitor-blog.com",
      "url": "https://competitor-blog.com/guest-authors",
      "title": "Expert Contributor Program",
      "category": "competitor_analysis",
      "difficulty": "hard",
      "priority": "medium",
      "domain_authority": 85,
      "traffic": 120000,
      "spam_score": 1,
      "contact_email": "contributors@competitor-blog.com",
      "outreach_status": "not_contacted",
      "estimated_value": 2100,
      "success_probability": 45,
      "last_updated": DateTime.now().subtract(Duration(days: 4)),
      "notes": "Competitor got featured here last month, high-value target",
      "follow_up_date": DateTime.now().add(Duration(days: 14)),
      "industry": "Technology",
      "content_type": "Guest Post",
      "link_type": "dofollow",
      "anchor_suggestions": ["industry expert", "thought leader", "innovation specialist"],
      "contact_name": "David Thompson",
      "social_media": {
        "twitter": "@davidtech",
        "linkedin": "linkedin.com/in/davidthompson-tech"
      },
      "referring_domains": 2340,
      "organic_keywords": 234000,
      "trust_flow": 65,
      "citation_flow": 72,
    },
    {
      "id": 5,
      "domain": "help-a-reporter.com",
      "url": "https://help-a-reporter.com/source-request-1234",
      "title": "AI Expert Needed for Business Article",
      "category": "haro",
      "difficulty": "medium",
      "priority": "high",
      "domain_authority": 78,
      "traffic": 85000,
      "spam_score": 0,
      "contact_email": "journalist@help-a-reporter.com",
      "outreach_status": "pitch_submitted",
      "estimated_value": 1550,
      "success_probability": 60,
      "last_updated": DateTime.now().subtract(Duration(hours: 3)),
      "notes": "Perfect match for our expertise, deadline in 2 days",
      "follow_up_date": DateTime.now().add(Duration(days: 2)),
      "industry": "Media",
      "content_type": "Quote/Interview",
      "link_type": "dofollow",
      "anchor_suggestions": ["AI expert", "technology consultant", "business advisor"],
      "contact_name": "Jennifer Walsh",
      "social_media": {
        "twitter": "@jenniferwrites",
        "linkedin": "linkedin.com/in/jenniferwalsh-journalist"
      },
      "referring_domains": 1560,
      "organic_keywords": 167000,
      "trust_flow": 58,
      "citation_flow": 63,
    },
  ];

  List<Map<String, dynamic>> get filteredOpportunities {
    return linkOpportunities.where((opportunity) {
      bool matchesCategory = selectedCategory == "all" || opportunity["category"] == selectedCategory;
      bool matchesDifficulty = selectedDifficulty == "all" || opportunity["difficulty"] == selectedDifficulty;
      bool matchesPriority = selectedPriority == "all" || opportunity["priority"] == selectedPriority;
      bool matchesSearch = searchQuery.isEmpty || 
          (opportunity["domain"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
          (opportunity["title"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
          (opportunity["industry"] as String).toLowerCase().contains(searchQuery.toLowerCase());
      
      return matchesCategory && matchesDifficulty && matchesPriority && matchesSearch;
    }).toList();
  }

  Color _getPriorityColor(String priority) {
    switch (priority) {
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

  Color _getStatusColor(String status) {
    switch (status) {
      case "not_contacted":
        return disabledBoldColor;
      case "email_sent":
        return infoColor;
      case "response_received":
        return warningColor;
      case "pitch_submitted":
        return primaryColor;
      case "accepted":
        return successColor;
      case "rejected":
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> filtered = filteredOpportunities;
    
    // Summary statistics
    int totalOpportunities = filtered.length;
    int highPriority = filtered.where((item) => item["priority"] == "high").length;
    int notContacted = filtered.where((item) => item["outreach_status"] == "not_contacted").length;
    
    double totalEstimatedValue = filtered.fold(0.0, (sum, item) => sum + (item["estimated_value"] as int).toDouble());
    double avgSuccessProbability = filtered.isEmpty ? 0 : filtered.fold(0.0, (sum, item) => sum + (item["success_probability"] as int).toDouble()) / filtered.length;

    return Scaffold(
      appBar: AppBar(
        title: Text("Link Opportunities"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
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
          spacing: spMd,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Summary Cards
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
                        Row(
                          children: [
                            Icon(Icons.link, color: primaryColor, size: 20),
                            SizedBox(width: spXs),
                            Text(
                              "Total Opportunities",
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
                          "$totalOpportunities",
                          style: TextStyle(
                            fontSize: 24,
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
                        Row(
                          children: [
                            Icon(Icons.priority_high, color: dangerColor, size: 20),
                            SizedBox(width: spXs),
                            Text(
                              "High Priority",
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
                          "$highPriority",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
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
                        Row(
                          children: [
                            Icon(Icons.mail_outline, color: warningColor, size: 20),
                            SizedBox(width: spXs),
                            Text(
                              "Not Contacted",
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
                          "$notContacted",
                          style: TextStyle(
                            fontSize: 24,
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
                        Row(
                          children: [
                            Icon(Icons.attach_money, color: successColor, size: 20),
                            SizedBox(width: spXs),
                            Text(
                              "Est. Value",
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
                          "\$${(totalEstimatedValue / 1000).toStringAsFixed(1)}K",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            // Filters
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                spacing: spSm,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Filters",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: QTextField(
                          label: "Search",
                          value: searchQuery,
                          hint: "Search by domain, title, or industry",
                          onChanged: (value) {
                            searchQuery = value;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: QDropdownField(
                          label: "Category",
                          items: categoryOptions,
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
                          label: "Difficulty",
                          items: difficultyOptions,
                          value: selectedDifficulty,
                          onChanged: (value, label) {
                            selectedDifficulty = value;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: QDropdownField(
                          label: "Priority",
                          items: priorityOptions,
                          value: selectedPriority,
                          onChanged: (value, label) {
                            selectedPriority = value;
                            setState(() {});
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.only(top: 24),
                          child: QButton(
                            label: "Add Opportunity",
                            icon: Icons.add,
                            size: bs.sm,
                            onPressed: () {},
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Results Summary
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Showing ${filtered.length} opportunities",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: primaryColor,
                    ),
                  ),
                  Text(
                    "Avg Success: ${avgSuccessProbability.toStringAsFixed(0)}%",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ),
            ),

            // Link Opportunities List
            ...filtered.map((opportunity) {
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
                      color: _getPriorityColor(opportunity["priority"]),
                    ),
                  ),
                ),
                child: Column(
                  spacing: spSm,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header Row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${opportunity["domain"]}",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                              Text(
                                "${opportunity["title"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: disabledBoldColor,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 4),
                              decoration: BoxDecoration(
                                color: _getPriorityColor(opportunity["priority"]).withAlpha(20),
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Text(
                                "${opportunity["priority"]}".toUpperCase(),
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                  color: _getPriorityColor(opportunity["priority"]),
                                ),
                              ),
                            ),
                            SizedBox(height: 2),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                              decoration: BoxDecoration(
                                color: _getStatusColor(opportunity["outreach_status"]).withAlpha(15),
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Text(
                                "${opportunity["outreach_status"]}".replaceAll("_", " ").toUpperCase(),
                                style: TextStyle(
                                  fontSize: 8,
                                  fontWeight: FontWeight.w600,
                                  color: _getStatusColor(opportunity["outreach_status"]),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),

                    // Category and Contact Info
                    Container(
                      padding: EdgeInsets.all(spXs),
                      decoration: BoxDecoration(
                        color: Colors.grey[50],
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Column(
                        spacing: spXs,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                decoration: BoxDecoration(
                                  color: infoColor.withAlpha(20),
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: Text(
                                  "${opportunity["category"]}".replaceAll("_", " ").toUpperCase(),
                                  style: TextStyle(
                                    fontSize: 9,
                                    fontWeight: FontWeight.bold,
                                    color: infoColor,
                                  ),
                                ),
                              ),
                              SizedBox(width: spXs),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                decoration: BoxDecoration(
                                  color: _getDifficultyColor(opportunity["difficulty"]).withAlpha(20),
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: Text(
                                  "${opportunity["difficulty"]}".toUpperCase(),
                                  style: TextStyle(
                                    fontSize: 9,
                                    fontWeight: FontWeight.bold,
                                    color: _getDifficultyColor(opportunity["difficulty"]),
                                  ),
                                ),
                              ),
                              Spacer(),
                              Text(
                                "${opportunity["industry"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                          if (opportunity["contact_name"].toString().isNotEmpty) ...[
                            Row(
                              children: [
                                Icon(Icons.person, color: disabledBoldColor, size: 14),
                                SizedBox(width: spXs),
                                Text(
                                  "${opportunity["contact_name"]}",
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: primaryColor,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                SizedBox(width: spSm),
                                Text(
                                  "${opportunity["contact_email"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: infoColor,
                                  ),
                                ),
                              ],
                            ),
                          ],
                          if (opportunity["notes"].toString().isNotEmpty) ...[
                            Row(
                              children: [
                                Icon(Icons.note, color: disabledBoldColor, size: 14),
                                SizedBox(width: spXs),
                                Expanded(
                                  child: Text(
                                    "${opportunity["notes"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                      fontStyle: FontStyle.italic,
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ],
                      ),
                    ),

                    // Metrics Grid
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            children: [
                              Text(
                                "${opportunity["domain_authority"]}",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                              Text(
                                "DA",
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
                                "${(opportunity["traffic"] as int) >= 1000 ? '${((opportunity["traffic"] as int) / 1000).toStringAsFixed(0)}K' : '${opportunity["traffic"]}'}",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                              Text(
                                "Traffic",
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
                                "\$${opportunity["estimated_value"]}",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: successColor,
                                ),
                              ),
                              Text(
                                "Value",
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
                                "${opportunity["success_probability"]}%",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: (opportunity["success_probability"] as int) >= 70 ? successColor : 
                                        (opportunity["success_probability"] as int) >= 40 ? warningColor : dangerColor,
                                ),
                              ),
                              Text(
                                "Success",
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

                    // Anchor Text Suggestions
                    if ((opportunity["anchor_suggestions"] as List).isNotEmpty) ...[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Suggested Anchor Text:",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: disabledBoldColor,
                            ),
                          ),
                          SizedBox(height: spXs),
                          Wrap(
                            spacing: spXs,
                            runSpacing: 4,
                            children: (opportunity["anchor_suggestions"] as List).map((anchor) {
                              return Container(
                                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                decoration: BoxDecoration(
                                  color: primaryColor.withAlpha(15),
                                  borderRadius: BorderRadius.circular(radiusXs),
                                  border: Border.all(color: primaryColor.withAlpha(30)),
                                ),
                                child: Text(
                                  anchor,
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: primaryColor,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        ],
                      ),
                    ],

                    // Action Buttons
                    Row(
                      children: [
                        QButton(
                          label: "View Details",
                          size: bs.sm,
                          onPressed: () {},
                        ),
                        SizedBox(width: spSm),
                        if (opportunity["outreach_status"] == "not_contacted")
                          QButton(
                            label: "Start Outreach",
                            size: bs.sm,
                            onPressed: () {},
                          ),
                        if (opportunity["outreach_status"] == "email_sent")
                          QButton(
                            label: "Follow Up",
                            size: bs.sm,
                            onPressed: () {},
                          ),
                        if (opportunity["outreach_status"] == "response_received")
                          QButton(
                            label: "Submit Pitch",
                            size: bs.sm,
                            onPressed: () {},
                          ),
                        Spacer(),
                        Text(
                          "Follow-up: ${(opportunity["follow_up_date"] as DateTime).dMMMy}",
                          style: TextStyle(
                            fontSize: 11,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            }).toList(),

            if (filtered.isEmpty)
              Container(
                padding: EdgeInsets.all(spLg),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Center(
                  child: Column(
                    children: [
                      Icon(
                        Icons.search_off,
                        size: 48,
                        color: disabledColor,
                      ),
                      SizedBox(height: spSm),
                      Text(
                        "No link opportunities found",
                        style: TextStyle(
                          fontSize: 16,
                          color: disabledBoldColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "Try adjusting your filters or search criteria",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
