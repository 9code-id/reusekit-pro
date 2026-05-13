import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class CmaNewsletterView extends StatefulWidget {
  const CmaNewsletterView({super.key});

  @override
  State<CmaNewsletterView> createState() => _CmaNewsletterViewState();
}

class _CmaNewsletterViewState extends State<CmaNewsletterView> {
  String selectedFilter = "all";
  String searchQuery = "";
  int selectedTab = 0;

  List<Map<String, dynamic>> filterOptions = [
    {"label": "All Newsletters", "value": "all"},
    {"label": "Published", "value": "published"},
    {"label": "Draft", "value": "draft"},
    {"label": "Scheduled", "value": "scheduled"},
    {"label": "Archived", "value": "archived"},
  ];

  List<Map<String, dynamic>> newsletters = [
    {
      "id": "1",
      "title": "Weekly Tech Updates - December 2024",
      "description": "Latest technology trends and industry insights",
      "status": "published",
      "subscribers": 15420,
      "opens": 4326,
      "clicks": 567,
      "publishDate": "2024-12-15",
      "author": "John Smith",
      "categories": ["Technology", "News"],
      "thumbnail": "https://picsum.photos/300/200?random=1&keyword=newsletter",
      "openRate": 28.1,
      "clickRate": 3.7
    },
    {
      "id": "2",
      "title": "Holiday Marketing Strategies",
      "description": "Boost your sales with proven holiday marketing tactics",
      "status": "scheduled",
      "subscribers": 12340,
      "opens": 0,
      "clicks": 0,
      "publishDate": "2024-12-20",
      "author": "Sarah Johnson",
      "categories": ["Marketing", "Business"],
      "thumbnail": "https://picsum.photos/300/200?random=2&keyword=marketing",
      "openRate": 0.0,
      "clickRate": 0.0
    },
    {
      "id": "3",
      "title": "Product Launch Announcement",
      "description": "Introducing our latest product features and updates",
      "status": "draft",
      "subscribers": 18750,
      "opens": 0,
      "clicks": 0,
      "publishDate": "",
      "author": "Mike Wilson",
      "categories": ["Product", "Updates"],
      "thumbnail": "https://picsum.photos/300/200?random=3&keyword=product",
      "openRate": 0.0,
      "clickRate": 0.0
    },
    {
      "id": "4",
      "title": "Industry Report Q4 2024",
      "description": "Comprehensive analysis of market trends and predictions",
      "status": "published",
      "subscribers": 22100,
      "opens": 6852,
      "clicks": 1024,
      "publishDate": "2024-12-10",
      "author": "Emma Davis",
      "categories": ["Report", "Analysis"],
      "thumbnail": "https://picsum.photos/300/200?random=4&keyword=report",
      "openRate": 31.0,
      "clickRate": 4.6
    },
    {
      "id": "5",
      "title": "Customer Success Stories",
      "description": "Highlighting amazing achievements from our community",
      "status": "published",
      "subscribers": 9876,
      "opens": 2963,
      "clicks": 445,
      "publishDate": "2024-12-05",
      "author": "Tom Anderson",
      "categories": ["Customer", "Success"],
      "thumbnail": "https://picsum.photos/300/200?random=5&keyword=success",
      "openRate": 30.0,
      "clickRate": 4.5
    },
    {
      "id": "6",
      "title": "Year-End Review 2024",
      "description": "Looking back at our achievements and milestones",
      "status": "archived",
      "subscribers": 25600,
      "opens": 7680,
      "clicks": 1152,
      "publishDate": "2023-12-31",
      "author": "Lisa Brown",
      "categories": ["Review", "Company"],
      "thumbnail": "https://picsum.photos/300/200?random=6&keyword=review",
      "openRate": 30.0,
      "clickRate": 4.5
    },
  ];

  List<Map<String, dynamic>> templates = [
    {
      "id": "1",
      "name": "Modern Newsletter",
      "description": "Clean and professional design",
      "thumbnail": "https://picsum.photos/250/300?random=10&keyword=template",
      "category": "Business",
      "popularity": 95
    },
    {
      "id": "2",
      "name": "Creative Layout",
      "description": "Colorful and engaging template",
      "thumbnail": "https://picsum.photos/250/300?random=11&keyword=creative",
      "category": "Creative",
      "popularity": 87
    },
    {
      "id": "3",
      "name": "Minimalist Design",
      "description": "Simple and elegant approach",
      "thumbnail": "https://picsum.photos/250/300?random=12&keyword=minimal",
      "category": "Design",
      "popularity": 92
    },
    {
      "id": "4",
      "name": "Tech Newsletter",
      "description": "Perfect for technology content",
      "thumbnail": "https://picsum.photos/250/300?random=13&keyword=tech",
      "category": "Technology",
      "popularity": 89
    },
  ];

  List<Map<String, dynamic>> get filteredNewsletters {
    List<Map<String, dynamic>> filtered = newsletters;
    
    if (selectedFilter != "all") {
      filtered = filtered.where((newsletter) => newsletter["status"] == selectedFilter).toList();
    }
    
    if (searchQuery.isNotEmpty) {
      filtered = filtered.where((newsletter) => 
        (newsletter["title"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
        (newsletter["description"] as String).toLowerCase().contains(searchQuery.toLowerCase())
      ).toList();
    }
    
    return filtered;
  }

  void _createNewsletter() {
    si("Opening newsletter editor...");
  }

  void _editNewsletter(Map<String, dynamic> newsletter) {
    si("Editing ${newsletter["title"]}...");
  }

  void _duplicateNewsletter(Map<String, dynamic> newsletter) {
    si("Newsletter duplicated successfully");
  }

  void _deleteNewsletter(Map<String, dynamic> newsletter) async {
    bool isConfirmed = await confirm("Are you sure you want to delete this newsletter?");
    if (isConfirmed) {
      ss("Newsletter deleted successfully");
    }
  }

  void _previewNewsletter(Map<String, dynamic> newsletter) {
    si("Opening newsletter preview...");
  }

  void _publishNewsletter(Map<String, dynamic> newsletter) {
    si("Publishing newsletter...");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Newsletter Management"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: _createNewsletter,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            _buildSearchAndFilters(),
            _buildStatsSection(),
            _buildTabSection(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _createNewsletter,
        backgroundColor: primaryColor,
        child: Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  Widget _buildSearchAndFilters() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        children: [
          Row(
            children: [
              Expanded(
                child: QTextField(
                  label: "Search newsletters...",
                  value: searchQuery,
                  hint: "Search by title or description",
                  onChanged: (value) {
                    searchQuery = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              QButton(
                icon: Icons.search,
                size: bs.sm,
                onPressed: () {},
              ),
            ],
          ),
          QDropdownField(
            label: "Filter by Status",
            items: filterOptions,
            value: selectedFilter,
            onChanged: (value, label) {
              selectedFilter = value;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  Widget _buildStatsSection() {
    int totalNewsletters = newsletters.length;
    int publishedCount = newsletters.where((n) => n["status"] == "published").length;
    int draftCount = newsletters.where((n) => n["status"] == "draft").length;
    int scheduledCount = newsletters.where((n) => n["status"] == "scheduled").length;

    return ResponsiveGridView(
      minItemWidth: 200,
      children: [
        _buildStatCard("Total Newsletters", totalNewsletters, Icons.library_books, Colors.blue),
        _buildStatCard("Published", publishedCount, Icons.publish, Colors.green),
        _buildStatCard("Drafts", draftCount, Icons.edit, Colors.orange),
        _buildStatCard("Scheduled", scheduledCount, Icons.schedule, Colors.purple),
      ],
    );
  }

  Widget _buildStatCard(String title, int value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: color.withAlpha(26),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Icon(icon, color: color, size: 24),
          ),
          SizedBox(height: spSm),
          Text(
            "$value",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabSection() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: spMd, vertical: spSm),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: disabledOutlineBorderColor,
                  width: 1,
                ),
              ),
            ),
            child: Row(
              children: [
                _buildTabButton("Newsletters", 0),
                _buildTabButton("Templates", 1),
                _buildTabButton("Analytics", 2),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(spMd),
            child: selectedTab == 0
                ? _buildNewslettersTab()
                : selectedTab == 1
                    ? _buildTemplatesTab()
                    : _buildAnalyticsTab(),
          ),
        ],
      ),
    );
  }

  Widget _buildTabButton(String title, int index) {
    bool isSelected = selectedTab == index;
    return Expanded(
      child: GestureDetector(
        onTap: () {
          selectedTab = index;
          setState(() {});
        },
        child: Container(
          padding: EdgeInsets.symmetric(vertical: spSm),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: isSelected ? primaryColor : Colors.transparent,
                width: 2,
              ),
            ),
          ),
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              color: isSelected ? primaryColor : disabledBoldColor,
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNewslettersTab() {
    return Column(
      spacing: spSm,
      children: filteredNewsletters.map((newsletter) {
        return Container(
          padding: EdgeInsets.all(spSm),
          decoration: BoxDecoration(
            border: Border.all(color: disabledOutlineBorderColor),
            borderRadius: BorderRadius.circular(radiusSm),
          ),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(radiusSm),
                child: Image.network(
                  "${newsletter["thumbnail"]}",
                  width: 80,
                  height: 60,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spXs,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            "${newsletter["title"]}",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: primaryColor,
                            ),
                          ),
                        ),
                        _buildStatusBadge(newsletter["status"]),
                      ],
                    ),
                    Text(
                      "${newsletter["description"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Row(
                      children: [
                        Icon(Icons.person, size: 12, color: disabledBoldColor),
                        SizedBox(width: spXxs),
                        Text(
                          "${newsletter["author"]}",
                          style: TextStyle(
                            fontSize: 11,
                            color: disabledBoldColor,
                          ),
                        ),
                        SizedBox(width: spSm),
                        if (newsletter["publishDate"].toString().isNotEmpty) ...[
                          Icon(Icons.calendar_today, size: 12, color: disabledBoldColor),
                          SizedBox(width: spXxs),
                          Text(
                            "${newsletter["publishDate"]}",
                            style: TextStyle(
                              fontSize: 11,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ],
                    ),
                    if (newsletter["status"] == "published") ...[
                      Row(
                        children: [
                          _buildMetric("${newsletter["subscribers"]}", "Subscribers", Icons.people),
                          SizedBox(width: spSm),
                          _buildMetric("${(newsletter["openRate"] as num).toStringAsFixed(1)}%", "Opens", Icons.visibility),
                          SizedBox(width: spSm),
                          _buildMetric("${(newsletter["clickRate"] as num).toStringAsFixed(1)}%", "Clicks", Icons.mouse),
                        ],
                      ),
                    ],
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GestureDetector(
                          onTap: () => _previewNewsletter(newsletter),
                          child: Icon(Icons.visibility, color: infoColor, size: 18),
                        ),
                        SizedBox(width: spSm),
                        GestureDetector(
                          onTap: () => _editNewsletter(newsletter),
                          child: Icon(Icons.edit, color: warningColor, size: 18),
                        ),
                        SizedBox(width: spSm),
                        GestureDetector(
                          onTap: () => _duplicateNewsletter(newsletter),
                          child: Icon(Icons.copy, color: primaryColor, size: 18),
                        ),
                        SizedBox(width: spSm),
                        GestureDetector(
                          onTap: () => _deleteNewsletter(newsletter),
                          child: Icon(Icons.delete, color: dangerColor, size: 18),
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
    );
  }

  Widget _buildStatusBadge(String status) {
    Color color;
    switch (status) {
      case "published":
        color = successColor;
        break;
      case "draft":
        color = warningColor;
        break;
      case "scheduled":
        color = infoColor;
        break;
      case "archived":
        color = disabledBoldColor;
        break;
      default:
        color = disabledColor;
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
      decoration: BoxDecoration(
        color: color.withAlpha(26),
        borderRadius: BorderRadius.circular(radiusXs),
      ),
      child: Text(
        status.toUpperCase(),
        style: TextStyle(
          fontSize: 10,
          color: color,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildMetric(String value, String label, IconData icon) {
    return Row(
      children: [
        Icon(icon, size: 12, color: primaryColor),
        SizedBox(width: spXxs),
        Text(
          "$value $label",
          style: TextStyle(
            fontSize: 10,
            color: primaryColor,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildTemplatesTab() {
    return ResponsiveGridView(
      minItemWidth: 200,
      children: templates.map((template) {
        return Container(
          decoration: BoxDecoration(
            border: Border.all(color: disabledOutlineBorderColor),
            borderRadius: BorderRadius.circular(radiusSm),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(radiusSm)),
                child: Image.network(
                  "${template["thumbnail"]}",
                  width: double.infinity,
                  height: 120,
                  fit: BoxFit.cover,
                ),
              ),
              Padding(
                padding: EdgeInsets.all(spSm),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spXs,
                  children: [
                    Text(
                      "${template["name"]}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "${template["description"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                          decoration: BoxDecoration(
                            color: infoColor.withAlpha(26),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            "${template["category"]}",
                            style: TextStyle(
                              fontSize: 10,
                              color: infoColor,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        Row(
                          children: [
                            Icon(Icons.favorite, size: 12, color: dangerColor),
                            SizedBox(width: spXxs),
                            Text(
                              "${template["popularity"]}%",
                              style: TextStyle(
                                fontSize: 11,
                                color: disabledBoldColor,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Container(
                      width: double.infinity,
                      child: QButton(
                        label: "Use Template",
                        size: bs.sm,
                        onPressed: () {
                          si("Using ${template["name"]} template...");
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildAnalyticsTab() {
    return Column(
      spacing: spMd,
      children: [
        Row(
          children: [
            Expanded(
              child: _buildAnalyticsCard("Total Subscribers", "45,678", "+12%", Icons.people, Colors.blue),
            ),
            SizedBox(width: spSm),
            Expanded(
              child: _buildAnalyticsCard("Avg. Open Rate", "28.5%", "+2.3%", Icons.visibility, Colors.green),
            ),
          ],
        ),
        Row(
          children: [
            Expanded(
              child: _buildAnalyticsCard("Avg. Click Rate", "4.2%", "+0.8%", Icons.mouse, Colors.orange),
            ),
            SizedBox(width: spSm),
            Expanded(
              child: _buildAnalyticsCard("Unsubscribe Rate", "0.8%", "-0.2%", Icons.unsubscribe, Colors.red),
            ),
          ],
        ),
        Container(
          padding: EdgeInsets.all(spMd),
          decoration: BoxDecoration(
            border: Border.all(color: disabledOutlineBorderColor),
            borderRadius: BorderRadius.circular(radiusSm),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: spSm,
            children: [
              Text(
                "Performance Trends",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: primaryColor,
                ),
              ),
              Container(
                height: 200,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.trending_up, size: 48, color: disabledColor),
                      SizedBox(height: spSm),
                      Text(
                        "Newsletter Performance Chart",
                        style: TextStyle(
                          fontSize: 16,
                          color: disabledBoldColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        "Track engagement metrics over time",
                        style: TextStyle(
                          fontSize: 12,
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
      ],
    );
  }

  Widget _buildAnalyticsCard(String title, String value, String change, IconData icon, Color color) {
    bool isPositive = change.startsWith("+");
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        border: Border.all(color: disabledOutlineBorderColor),
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(icon, color: color, size: 20),
              Row(
                children: [
                  Icon(
                    isPositive ? Icons.trending_up : Icons.trending_down,
                    color: isPositive ? successColor : dangerColor,
                    size: 12,
                  ),
                  SizedBox(width: spXxs),
                  Text(
                    change,
                    style: TextStyle(
                      fontSize: 10,
                      color: isPositive ? successColor : dangerColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: spSm),
          Text(
            value,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }
}
