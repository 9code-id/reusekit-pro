import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class DmsMetaTagsView extends StatefulWidget {
  const DmsMetaTagsView({super.key});

  @override
  State<DmsMetaTagsView> createState() => _DmsMetaTagsViewState();
}

class _DmsMetaTagsViewState extends State<DmsMetaTagsView> {
  String searchQuery = "";
  String selectedStatus = "All";
  String selectedType = "All";
  String selectedPriority = "All";

  List<Map<String, dynamic>> metaTags = [
    {
      "id": "1",
      "page": "Homepage",
      "url": "https://mywebsite.com/",
      "title": "Best Digital Marketing Services | MyWebsite",
      "titleLength": 42,
      "description": "Get professional digital marketing services to grow your business. SEO, PPC, social media marketing and more.",
      "descriptionLength": 121,
      "keywords": "digital marketing, SEO services, PPC management",
      "keywordsLength": 52,
      "status": "Optimized",
      "priority": "High",
      "issues": [],
      "lastUpdated": "2024-01-15",
      "clickThroughRate": 3.8,
      "impressions": 12500,
      "type": "Service Page"
    },
    {
      "id": "2", 
      "page": "SEO Services",
      "url": "https://mywebsite.com/seo-services",
      "title": "Professional SEO Services",
      "titleLength": 26,
      "description": "Boost your website rankings with our expert SEO services.",
      "descriptionLength": 62,
      "keywords": "SEO, search engine optimization",
      "keywordsLength": 32,
      "status": "Needs Improvement",
      "priority": "High",
      "issues": ["Title too short", "Description too short", "Missing keywords"],
      "lastUpdated": "2024-01-10",
      "clickThroughRate": 2.1,
      "impressions": 8900,
      "type": "Service Page"
    },
    {
      "id": "3",
      "page": "About Us",
      "url": "https://mywebsite.com/about",
      "title": "About Our Digital Marketing Agency - 20 Years Experience",
      "titleLength": 58,
      "description": "Learn about our digital marketing agency with 20 years of experience helping businesses grow online through innovative strategies.",
      "descriptionLength": 145,
      "keywords": "digital marketing agency, about us, experience",
      "keywordsLength": 48,
      "status": "Warning",
      "priority": "Medium",
      "issues": ["Title too long", "Description too long"],
      "lastUpdated": "2024-01-12",
      "clickThroughRate": 1.9,
      "impressions": 4200,
      "type": "Informational"
    },
    {
      "id": "4",
      "page": "Contact",
      "url": "https://mywebsite.com/contact",
      "title": "Contact Us",
      "titleLength": 10,
      "description": "Get in touch with our team.",
      "descriptionLength": 28,
      "keywords": "",
      "keywordsLength": 0,
      "status": "Critical",
      "priority": "High",
      "issues": ["Title too short", "Description too short", "Missing keywords", "Missing location"],
      "lastUpdated": "2024-01-08",
      "clickThroughRate": 1.2,
      "impressions": 2100,
      "type": "Contact Page"
    },
    {
      "id": "5",
      "page": "Blog - SEO Tips",
      "url": "https://mywebsite.com/blog/seo-tips-2024",
      "title": "10 Essential SEO Tips for 2024 | Digital Marketing Blog",
      "titleLength": 52,
      "description": "Discover the top 10 SEO tips for 2024 to improve your website rankings. Learn from our experts about the latest SEO strategies and techniques.",
      "descriptionLength": 147,
      "keywords": "SEO tips 2024, SEO strategies, website rankings",
      "keywordsLength": 49,
      "status": "Warning",
      "priority": "Medium",
      "issues": ["Description too long"],
      "lastUpdated": "2024-01-14",
      "clickThroughRate": 4.2,
      "impressions": 15600,
      "type": "Blog Post"
    },
    {
      "id": "6",
      "page": "PPC Management",
      "url": "https://mywebsite.com/ppc-management",
      "title": "Expert PPC Management Services - Maximize ROI",
      "titleLength": 45,
      "description": "Professional PPC management services to maximize your advertising ROI. Google Ads, Facebook Ads, and more platforms covered.",
      "descriptionLength": 135,
      "keywords": "PPC management, Google Ads, Facebook Ads, ROI",
      "keywordsLength": 48,
      "status": "Optimized",
      "priority": "High",
      "issues": [],
      "lastUpdated": "2024-01-13",
      "clickThroughRate": 3.5,
      "impressions": 9800,
      "type": "Service Page"
    },
    {
      "id": "7",
      "page": "Social Media Marketing",
      "url": "https://mywebsite.com/social-media-marketing",
      "title": "Social Media Marketing Agency",
      "titleLength": 30,
      "description": "Grow your brand with professional social media marketing.",
      "descriptionLength": 58,
      "keywords": "social media marketing, brand growth",
      "keywordsLength": 37,
      "status": "Needs Improvement",
      "priority": "Medium",
      "issues": ["Description too short", "Missing platforms"],
      "lastUpdated": "2024-01-11",
      "clickThroughRate": 2.8,
      "impressions": 6700,
      "type": "Service Page"
    },
    {
      "id": "8",
      "page": "Case Studies",
      "url": "https://mywebsite.com/case-studies",
      "title": "Digital Marketing Case Studies & Success Stories",
      "titleLength": 47,
      "description": "Explore our digital marketing case studies and client success stories. See how we've helped businesses achieve their growth goals.",
      "descriptionLength": 141,
      "keywords": "case studies, success stories, digital marketing results",
      "keywordsLength": 58,
      "status": "Optimized",
      "priority": "Medium",
      "issues": [],
      "lastUpdated": "2024-01-16",
      "clickThroughRate": 2.6,
      "impressions": 5400,
      "type": "Portfolio"
    }
  ];

  List<Map<String, dynamic>> get filteredMetaTags {
    return metaTags.where((tag) {
      bool matchesSearch = tag["page"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
                          tag["url"].toString().toLowerCase().contains(searchQuery.toLowerCase());
      
      bool matchesStatus = selectedStatus == "All" || tag["status"] == selectedStatus;
      bool matchesType = selectedType == "All" || tag["type"] == selectedType;
      bool matchesPriority = selectedPriority == "All" || tag["priority"] == selectedPriority;
      
      return matchesSearch && matchesStatus && matchesType && matchesPriority;
    }).toList();
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "Optimized": return successColor;
      case "Warning": return warningColor;
      case "Needs Improvement": return infoColor;
      case "Critical": return dangerColor;
      default: return disabledColor;
    }
  }

  Color _getPriorityColor(String priority) {
    switch (priority) {
      case "High": return dangerColor;
      case "Medium": return warningColor;
      case "Low": return infoColor;
      default: return disabledColor;
    }
  }

  void _showMetaTagDetails(Map<String, dynamic> tag) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Meta Tag Details"),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildDetailRow("Page", tag["page"]),
              _buildDetailRow("URL", tag["url"]),
              SizedBox(height: spSm),
              
              Text("Title Tag", style: TextStyle(fontWeight: FontWeight.bold, fontSize: fsH6)),
              SizedBox(height: spXs),
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.grey.withAlpha(51),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("${tag["title"]}", style: TextStyle(fontSize: 14)),
                    SizedBox(height: spXs),
                    Row(
                      children: [
                        Text("Length: ${tag["titleLength"]}/60", 
                             style: TextStyle(fontSize: 12, color: disabledBoldColor)),
                        Spacer(),
                        Container(
                          width: 100,
                          height: 4,
                          decoration: BoxDecoration(
                            color: Colors.grey.withAlpha(77),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: FractionallySizedBox(
                            alignment: Alignment.centerLeft,
                            widthFactor: ((tag["titleLength"] as int) / 60).clamp(0.0, 1.0),
                            child: Container(
                              decoration: BoxDecoration(
                                color: (tag["titleLength"] as int) > 60 ? dangerColor :
                                       (tag["titleLength"] as int) < 30 ? warningColor : successColor,
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: spSm),
              
              Text("Meta Description", style: TextStyle(fontWeight: FontWeight.bold, fontSize: fsH6)),
              SizedBox(height: spXs),
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.grey.withAlpha(51),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("${tag["description"]}", style: TextStyle(fontSize: 14)),
                    SizedBox(height: spXs),
                    Row(
                      children: [
                        Text("Length: ${tag["descriptionLength"]}/160", 
                             style: TextStyle(fontSize: 12, color: disabledBoldColor)),
                        Spacer(),
                        Container(
                          width: 100,
                          height: 4,
                          decoration: BoxDecoration(
                            color: Colors.grey.withAlpha(77),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: FractionallySizedBox(
                            alignment: Alignment.centerLeft,
                            widthFactor: ((tag["descriptionLength"] as int) / 160).clamp(0.0, 1.0),
                            child: Container(
                              decoration: BoxDecoration(
                                color: (tag["descriptionLength"] as int) > 160 ? dangerColor :
                                       (tag["descriptionLength"] as int) < 120 ? warningColor : successColor,
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: spSm),
              
              if ((tag["keywords"] as String).isNotEmpty) ...[
                Text("Meta Keywords", style: TextStyle(fontWeight: FontWeight.bold, fontSize: fsH6)),
                SizedBox(height: spXs),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.grey.withAlpha(51),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("${tag["keywords"]}", style: TextStyle(fontSize: 14)),
                      SizedBox(height: spXs),
                      Text("Length: ${tag["keywordsLength"]} characters", 
                           style: TextStyle(fontSize: 12, color: disabledBoldColor)),
                    ],
                  ),
                ),
                SizedBox(height: spSm),
              ],
              
              if ((tag["issues"] as List).isNotEmpty) ...[
                Text("Issues Found", style: TextStyle(fontWeight: FontWeight.bold, fontSize: fsH6, color: dangerColor)),
                SizedBox(height: spXs),
                ...(tag["issues"] as List).map((issue) => Container(
                  margin: EdgeInsets.only(bottom: spXs),
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: dangerColor.withAlpha(26),
                    borderRadius: BorderRadius.circular(radiusSm),
                    border: Border.all(color: dangerColor.withAlpha(77)),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.warning, color: dangerColor, size: 16),
                      SizedBox(width: spXs),
                      Expanded(child: Text("${issue}", style: TextStyle(fontSize: 12, color: dangerColor))),
                    ],
                  ),
                )),
                SizedBox(height: spSm),
              ],
              
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("CTR", style: TextStyle(fontSize: 12, color: disabledBoldColor)),
                        Text("${tag["clickThroughRate"]}%", style: TextStyle(fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Impressions", style: TextStyle(fontSize: 12, color: disabledBoldColor)),
                        Text("${(tag["impressions"] as int).toString()}", style: TextStyle(fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Close"),
          ),
          QButton(
            label: "Edit Meta Tags",
            size: bs.sm,
            onPressed: () {
              Navigator.pop(context);
              _showEditMetaTagDialog(tag);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.only(bottom: spXs),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 60,
            child: Text("${label}:", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 12)),
          ),
          Expanded(child: Text("${value}", style: TextStyle(fontSize: 12))),
        ],
      ),
    );
  }

  void _showEditMetaTagDialog(Map<String, dynamic> tag) {
    String title = tag["title"];
    String description = tag["description"];
    String keywords = tag["keywords"];

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Edit Meta Tags"),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              QTextField(
                label: "Title Tag",
                value: title,
                hint: "Enter page title (30-60 characters)",
                onChanged: (value) => title = value,
              ),
              SizedBox(height: spSm),
              QMemoField(
                label: "Meta Description",
                value: description,
                hint: "Enter meta description (120-160 characters)",
                onChanged: (value) => description = value,
              ),
              SizedBox(height: spSm),
              QTextField(
                label: "Meta Keywords",
                value: keywords,
                hint: "Enter keywords separated by commas",
                onChanged: (value) => keywords = value,
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Cancel"),
          ),
          QButton(
            label: "Save Changes",
            size: bs.sm,
            onPressed: () {
              setState(() {
                tag["title"] = title;
                tag["description"] = description;
                tag["keywords"] = keywords;
                tag["titleLength"] = title.length;
                tag["descriptionLength"] = description.length;
                tag["keywordsLength"] = keywords.length;
                tag["lastUpdated"] = DateTime.now().toString().substring(0, 10);
                
                // Update status based on issues
                List<String> newIssues = [];
                if (title.length < 30) newIssues.add("Title too short");
                if (title.length > 60) newIssues.add("Title too long");
                if (description.length < 120) newIssues.add("Description too short");
                if (description.length > 160) newIssues.add("Description too long");
                if (keywords.isEmpty) newIssues.add("Missing keywords");
                
                tag["issues"] = newIssues;
                tag["status"] = newIssues.isEmpty ? "Optimized" :
                              newIssues.length > 2 ? "Critical" :
                              newIssues.any((issue) => issue.contains("too short") || issue.contains("Missing")) ? "Needs Improvement" : "Warning";
              });
              Navigator.pop(context);
              ss("Meta tags updated successfully");
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Meta Tags Management"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => _showAddMetaTagDialog(),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          children: [
            // Search and Filters
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: QTextField(
                    label: "Search pages or URLs",
                    value: searchQuery,
                    hint: "Search by page name or URL",
                    onChanged: (value) {
                      searchQuery = value;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QDropdownField(
                    label: "Status",
                    items: [
                      {"label": "All Statuses", "value": "All"},
                      {"label": "Optimized", "value": "Optimized"},
                      {"label": "Warning", "value": "Warning"},
                      {"label": "Needs Improvement", "value": "Needs Improvement"},
                      {"label": "Critical", "value": "Critical"},
                    ],
                    value: selectedStatus,
                    onChanged: (value, label) {
                      selectedStatus = value;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: spSm),
            
            Row(
              children: [
                Expanded(
                  child: QDropdownField(
                    label: "Page Type",
                    items: [
                      {"label": "All Types", "value": "All"},
                      {"label": "Service Page", "value": "Service Page"},
                      {"label": "Blog Post", "value": "Blog Post"},
                      {"label": "Informational", "value": "Informational"},
                      {"label": "Contact Page", "value": "Contact Page"},
                      {"label": "Portfolio", "value": "Portfolio"},
                    ],
                    value: selectedType,
                    onChanged: (value, label) {
                      selectedType = value;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QDropdownField(
                    label: "Priority",
                    items: [
                      {"label": "All Priorities", "value": "All"},
                      {"label": "High", "value": "High"},
                      {"label": "Medium", "value": "Medium"},
                      {"label": "Low", "value": "Low"},
                    ],
                    value: selectedPriority,
                    onChanged: (value, label) {
                      selectedPriority = value;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: spLg),

            // Summary Cards
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusSm),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      children: [
                        Text("${metaTags.length}", style: TextStyle(fontSize: fsH3, fontWeight: FontWeight.bold, color: primaryColor)),
                        Text("Total Pages", style: TextStyle(fontSize: 12, color: disabledBoldColor)),
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
                      borderRadius: BorderRadius.circular(radiusSm),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      children: [
                        Text("${metaTags.where((tag) => tag["status"] == "Optimized").length}", 
                             style: TextStyle(fontSize: fsH3, fontWeight: FontWeight.bold, color: successColor)),
                        Text("Optimized", style: TextStyle(fontSize: 12, color: disabledBoldColor)),
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
                      borderRadius: BorderRadius.circular(radiusSm),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      children: [
                        Text("${metaTags.where((tag) => (tag["issues"] as List).isNotEmpty).length}", 
                             style: TextStyle(fontSize: fsH3, fontWeight: FontWeight.bold, color: dangerColor)),
                        Text("With Issues", style: TextStyle(fontSize: 12, color: disabledBoldColor)),
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
                      borderRadius: BorderRadius.circular(radiusSm),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      children: [
                        Text("${((metaTags.map((tag) => tag["clickThroughRate"] as double).reduce((a, b) => a + b)) / metaTags.length).toStringAsFixed(1)}%", 
                             style: TextStyle(fontSize: fsH3, fontWeight: FontWeight.bold, color: infoColor)),
                        Text("Avg CTR", style: TextStyle(fontSize: 12, color: disabledBoldColor)),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: spLg),

            // Meta Tags List
            Text("Meta Tags Overview", style: TextStyle(fontSize: fsH6, fontWeight: FontWeight.bold)),
            SizedBox(height: spSm),
            
            ...filteredMetaTags.map((tag) => Container(
              margin: EdgeInsets.only(bottom: spSm),
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusSm),
                boxShadow: [shadowSm],
                border: Border(
                  left: BorderSide(
                    width: 4,
                    color: _getStatusColor(tag["status"]),
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
                            Text("${tag["page"]}", style: TextStyle(fontWeight: FontWeight.bold, fontSize: fsH6)),
                            SizedBox(height: spXs),
                            Text("${tag["url"]}", style: TextStyle(fontSize: 12, color: disabledBoldColor)),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                        decoration: BoxDecoration(
                          color: _getStatusColor(tag["status"]).withAlpha(26),
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Text("${tag["status"]}", 
                               style: TextStyle(fontSize: 12, color: _getStatusColor(tag["status"]), fontWeight: FontWeight.w600)),
                      ),
                      SizedBox(width: spXs),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                        decoration: BoxDecoration(
                          color: _getPriorityColor(tag["priority"]).withAlpha(26),
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Text("${tag["priority"]}", 
                               style: TextStyle(fontSize: 12, color: _getPriorityColor(tag["priority"]), fontWeight: FontWeight.w600)),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  
                  // Title Preview
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: Colors.grey.withAlpha(26),
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text("Title:", style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: disabledBoldColor)),
                            Spacer(),
                            Text("${tag["titleLength"]}/60", style: TextStyle(fontSize: 11, color: disabledBoldColor)),
                          ],
                        ),
                        SizedBox(height: spXs),
                        Text("${tag["title"]}", 
                             style: TextStyle(fontSize: 13, color: primaryColor),
                             maxLines: 1,
                             overflow: TextOverflow.ellipsis),
                      ],
                    ),
                  ),
                  SizedBox(height: spXs),
                  
                  // Description Preview
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: Colors.grey.withAlpha(26),
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text("Description:", style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: disabledBoldColor)),
                            Spacer(),
                            Text("${tag["descriptionLength"]}/160", style: TextStyle(fontSize: 11, color: disabledBoldColor)),
                          ],
                        ),
                        SizedBox(height: spXs),
                        Text("${tag["description"]}", 
                             style: TextStyle(fontSize: 12, color: disabledBoldColor),
                             maxLines: 2,
                             overflow: TextOverflow.ellipsis),
                      ],
                    ),
                  ),
                  
                  if ((tag["issues"] as List).isNotEmpty) ...[
                    SizedBox(height: spSm),
                    Wrap(
                      spacing: spXs,
                      runSpacing: spXs,
                      children: (tag["issues"] as List).take(3).map((issue) => Container(
                        padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                        decoration: BoxDecoration(
                          color: dangerColor.withAlpha(26),
                          borderRadius: BorderRadius.circular(radiusXs),
                          border: Border.all(color: dangerColor.withAlpha(77)),
                        ),
                        child: Text("${issue}", style: TextStyle(fontSize: 11, color: dangerColor)),
                      )).toList(),
                    ),
                  ],
                  
                  SizedBox(height: spSm),
                  Row(
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            Icon(Icons.visibility, size: 16, color: disabledBoldColor),
                            SizedBox(width: spXs),
                            Text("${(tag["impressions"] as int).toString()}", style: TextStyle(fontSize: 12, color: disabledBoldColor)),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Row(
                          children: [
                            Icon(Icons.touch_app, size: 16, color: disabledBoldColor),
                            SizedBox(width: spXs),
                            Text("${tag["clickThroughRate"]}% CTR", style: TextStyle(fontSize: 12, color: disabledBoldColor)),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Row(
                          children: [
                            Icon(Icons.update, size: 16, color: disabledBoldColor),
                            SizedBox(width: spXs),
                            Text("${tag["lastUpdated"]}", style: TextStyle(fontSize: 12, color: disabledBoldColor)),
                          ],
                        ),
                      ),
                      QButton(
                        label: "View Details",
                        size: bs.sm,
                        onPressed: () => _showMetaTagDetails(tag),
                      ),
                    ],
                  ),
                ],
              ),
            )).toList(),
          ],
        ),
      ),
    );
  }

  void _showAddMetaTagDialog() {
    String page = "";
    String url = "";
    String title = "";
    String description = "";
    String keywords = "";
    String type = "Service Page";
    String priority = "Medium";

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Add New Meta Tags"),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              QTextField(
                label: "Page Name",
                value: page,
                hint: "Enter page name",
                onChanged: (value) => page = value,
              ),
              SizedBox(height: spSm),
              QTextField(
                label: "URL",
                value: url,
                hint: "Enter page URL",
                onChanged: (value) => url = value,
              ),
              SizedBox(height: spSm),
              QTextField(
                label: "Title Tag",
                value: title,
                hint: "Enter page title (30-60 characters)",
                onChanged: (value) => title = value,
              ),
              SizedBox(height: spSm),
              QMemoField(
                label: "Meta Description",
                value: description,
                hint: "Enter meta description (120-160 characters)",
                onChanged: (value) => description = value,
              ),
              SizedBox(height: spSm),
              QTextField(
                label: "Meta Keywords",
                value: keywords,
                hint: "Enter keywords separated by commas",
                onChanged: (value) => keywords = value,
              ),
              SizedBox(height: spSm),
              Row(
                children: [
                  Expanded(
                    child: QDropdownField(
                      label: "Page Type",
                      items: [
                        {"label": "Service Page", "value": "Service Page"},
                        {"label": "Blog Post", "value": "Blog Post"},
                        {"label": "Informational", "value": "Informational"},
                        {"label": "Contact Page", "value": "Contact Page"},
                        {"label": "Portfolio", "value": "Portfolio"},
                      ],
                      value: type,
                      onChanged: (value, label) => type = value,
                    ),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: QDropdownField(
                      label: "Priority",
                      items: [
                        {"label": "High", "value": "High"},
                        {"label": "Medium", "value": "Medium"},
                        {"label": "Low", "value": "Low"},
                      ],
                      value: priority,
                      onChanged: (value, label) => priority = value,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Cancel"),
          ),
          QButton(
            label: "Add Meta Tags",
            size: bs.sm,
            onPressed: () {
              if (page.isNotEmpty && url.isNotEmpty && title.isNotEmpty) {
                setState(() {
                  List<String> issues = [];
                  if (title.length < 30) issues.add("Title too short");
                  if (title.length > 60) issues.add("Title too long");
                  if (description.length < 120) issues.add("Description too short");
                  if (description.length > 160) issues.add("Description too long");
                  if (keywords.isEmpty) issues.add("Missing keywords");
                  
                  metaTags.add({
                    "id": (metaTags.length + 1).toString(),
                    "page": page,
                    "url": url,
                    "title": title,
                    "titleLength": title.length,
                    "description": description,
                    "descriptionLength": description.length,
                    "keywords": keywords,
                    "keywordsLength": keywords.length,
                    "status": issues.isEmpty ? "Optimized" :
                             issues.length > 2 ? "Critical" :
                             issues.any((issue) => issue.contains("too short") || issue.contains("Missing")) ? "Needs Improvement" : "Warning",
                    "priority": priority,
                    "issues": issues,
                    "lastUpdated": DateTime.now().toString().substring(0, 10),
                    "clickThroughRate": 0.0,
                    "impressions": 0,
                    "type": type,
                  });
                });
                Navigator.pop(context);
                ss("Meta tags added successfully");
              }
            },
          ),
        ],
      ),
    );
  }
}
