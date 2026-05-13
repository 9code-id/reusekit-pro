import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class SmaBusinessToolsView extends StatefulWidget {
  const SmaBusinessToolsView({super.key});

  @override
  State<SmaBusinessToolsView> createState() => _SmaBusinessToolsViewState();
}

class _SmaBusinessToolsViewState extends State<SmaBusinessToolsView> {
  int selectedCategory = 0;
  
  final List<Map<String, dynamic>> categories = [
    {"label": "All Tools", "value": "all"},
    {"label": "Analytics", "value": "analytics"},
    {"label": "Marketing", "value": "marketing"},
    {"label": "Sales", "value": "sales"},
    {"label": "Customer", "value": "customer"},
  ];

  final List<Map<String, dynamic>> tools = [
    {
      "id": "1",
      "name": "Social Media Analytics",
      "category": "analytics",
      "description": "Track your social media performance across all platforms",
      "features": ["Real-time analytics", "Competitor analysis", "Custom reports", "ROI tracking"],
      "price": "Free",
      "popular": true,
      "rating": 4.8,
      "users": "50K+",
      "icon": Icons.analytics,
      "color": Colors.blue,
      "image": "https://picsum.photos/300/200?random=1&keyword=analytics",
    },
    {
      "id": "2",
      "name": "Content Scheduler",
      "category": "marketing",
      "description": "Schedule and automate your social media posts",
      "features": ["Multi-platform posting", "Auto-scheduling", "Content calendar", "Team collaboration"],
      "price": "\$19/month",
      "popular": true,
      "rating": 4.6,
      "users": "25K+",
      "icon": Icons.schedule,
      "color": Colors.green,
      "image": "https://picsum.photos/300/200?random=2&keyword=schedule",
    },
    {
      "id": "3",
      "name": "Lead Generation",
      "category": "sales",
      "description": "Generate and manage leads from social media",
      "features": ["Lead capture forms", "CRM integration", "Email automation", "Lead scoring"],
      "price": "\$39/month",
      "popular": false,
      "rating": 4.5,
      "users": "15K+",
      "icon": Icons.people_alt,
      "color": Colors.orange,
      "image": "https://picsum.photos/300/200?random=3&keyword=leads",
    },
    {
      "id": "4",
      "name": "Customer Support Bot",
      "category": "customer",
      "description": "Automated customer support for social media",
      "features": ["24/7 support", "AI responses", "Multi-language", "Human handoff"],
      "price": "\$29/month",
      "popular": false,
      "rating": 4.3,
      "users": "10K+",
      "icon": Icons.support_agent,
      "color": Colors.purple,
      "image": "https://picsum.photos/300/200?random=4&keyword=support",
    },
    {
      "id": "5",
      "name": "Hashtag Optimizer",
      "category": "marketing",
      "description": "Find the best hashtags for maximum reach",
      "features": ["Trending hashtags", "Hashtag analytics", "Competitor hashtags", "Custom suggestions"],
      "price": "\$9/month",
      "popular": true,
      "rating": 4.7,
      "users": "35K+",
      "icon": Icons.tag,
      "color": Colors.teal,
      "image": "https://picsum.photos/300/200?random=5&keyword=hashtag",
    },
    {
      "id": "6",
      "name": "Influencer Finder",
      "category": "marketing",
      "description": "Discover and connect with relevant influencers",
      "features": ["Influencer database", "Contact management", "Campaign tracking", "Performance metrics"],
      "price": "\$49/month",
      "popular": false,
      "rating": 4.4,
      "users": "8K+",
      "icon": Icons.star,
      "color": Colors.pink,
      "image": "https://picsum.photos/300/200?random=6&keyword=influencer",
    },
    {
      "id": "7",
      "name": "Engagement Tracker",
      "category": "analytics",
      "description": "Monitor engagement rates and audience interactions",
      "features": ["Real-time monitoring", "Engagement insights", "Audience demographics", "Trend analysis"],
      "price": "Free",
      "popular": true,
      "rating": 4.6,
      "users": "40K+",
      "icon": Icons.favorite,
      "color": Colors.red,
      "image": "https://picsum.photos/300/200?random=7&keyword=engagement",
    },
    {
      "id": "8",
      "name": "Sales Funnel Builder",
      "category": "sales",
      "description": "Create optimized sales funnels from social traffic",
      "features": ["Drag-drop builder", "A/B testing", "Conversion tracking", "Integration tools"],
      "price": "\$79/month",
      "popular": false,
      "rating": 4.2,
      "users": "5K+",
      "icon": Icons.filter_list,
      "color": Colors.indigo,
      "image": "https://picsum.photos/300/200?random=8&keyword=funnel",
    },
  ];

  List<Map<String, dynamic>> get filteredTools {
    if (selectedCategory == 0) return tools;
    String categoryValue = categories[selectedCategory]["value"];
    return tools.where((t) => t["category"] == categoryValue).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Business Tools"),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              // Navigate to search
            },
          ),
          IconButton(
            icon: Icon(Icons.bookmark),
            onPressed: () {
              // Navigate to saved tools
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Section
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [primaryColor, primaryColor.withAlpha(150)],
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
                        Icons.business_center,
                        color: Colors.white,
                        size: 32,
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Business Tools",
                              style: TextStyle(
                                fontSize: fsH4,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              "Grow your business with powerful tools",
                              style: TextStyle(
                                color: Colors.white.withAlpha(200),
                                fontSize: 14,
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
            
            SizedBox(height: spLg),
            
            // Quick Stats
            ResponsiveGridView(
              padding: EdgeInsets.zero,
              minItemWidth: 120,
              children: [
                _buildQuickStat("Total Tools", "${tools.length}", Icons.build, primaryColor),
                _buildQuickStat("Free Tools", "${tools.where((t) => t["price"] == "Free").length}", Icons.free_breakfast, successColor),
                _buildQuickStat("Popular", "${tools.where((t) => t["popular"] == true).length}", Icons.trending_up, warningColor),
                _buildQuickStat("Categories", "${categories.length - 1}", Icons.category, infoColor),
              ],
            ),
            
            SizedBox(height: spLg),
            
            // Category Filter
            QCategoryPicker(
              items: categories,
              value: categories[selectedCategory]["value"],
              onChanged: (index, label, value, item) {
                selectedCategory = index;
                setState(() {});
              },
            ),
            
            SizedBox(height: spLg),
            
            // Popular Tools Section
            if (selectedCategory == 0) ...[
              Row(
                children: [
                  Icon(
                    Icons.local_fire_department,
                    color: warningColor,
                    size: 20,
                  ),
                  SizedBox(width: spSm),
                  Text(
                    "Popular Tools",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                ],
              ),
              SizedBox(height: spMd),
              
              QHorizontalScroll(
                children: tools.where((t) => t["popular"] == true).map((tool) {
                  return Container(
                    width: 280,
                    margin: EdgeInsets.only(right: spMd),
                    child: _buildToolCard(tool, isHorizontal: true),
                  );
                }).toList(),
              ),
              
              SizedBox(height: spXl),
            ],
            
            // All Tools Grid
            Text(
              selectedCategory == 0 ? "All Business Tools" : "${categories[selectedCategory]["label"]} Tools",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spMd),
            
            ResponsiveGridView(
              padding: EdgeInsets.zero,
              minItemWidth: 200,
              children: filteredTools.map((tool) {
                return _buildToolCard(tool);
              }).toList(),
            ),
            
            SizedBox(height: spXl),
            
            // Call to Action
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: infoColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusMd),
                border: Border.all(
                  color: infoColor.withAlpha(100),
                  width: 1,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.lightbulb,
                        color: infoColor,
                        size: 24,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "Need a Custom Tool?",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: infoColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "Can't find what you're looking for? We can help you build custom business tools tailored to your specific needs.",
                    style: TextStyle(
                      color: disabledBoldColor,
                      fontSize: 14,
                      height: 1.4,
                    ),
                  ),
                  SizedBox(height: spMd),
                  QButton(
                    label: "Request Custom Tool",
                    icon: Icons.build_circle,
                    size: bs.sm,
                    onPressed: () {
                      // Navigate to custom tool request
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickStat(String title, String value, IconData icon, Color color) {
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
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: color.withAlpha(30),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Icon(
              icon,
              color: color,
              size: 20,
            ),
          ),
          SizedBox(height: spMd),
          Text(
            value,
            style: TextStyle(
              fontSize: fsH5,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spXs),
          Text(
            title,
            style: TextStyle(
              color: disabledBoldColor,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildToolCard(Map<String, dynamic> tool, {bool isHorizontal = false}) {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
        border: tool["popular"] == true
            ? Border.all(color: warningColor.withAlpha(100), width: 2)
            : null,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header with image and popular badge
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(radiusSm),
                child: Image.network(
                  "${tool["image"]}",
                  width: double.infinity,
                  height: isHorizontal ? 120 : 100,
                  fit: BoxFit.cover,
                ),
              ),
              if (tool["popular"] == true)
                Positioned(
                  top: spSm,
                  right: spSm,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                    decoration: BoxDecoration(
                      color: warningColor,
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.local_fire_department,
                          color: Colors.white,
                          size: 12,
                        ),
                        SizedBox(width: spXs),
                        Text(
                          "POPULAR",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 9,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          ),
          
          SizedBox(height: spMd),
          
          // Tool Info
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: (tool["color"] as Color).withAlpha(30),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Icon(
                  tool["icon"] as IconData,
                  color: tool["color"] as Color,
                  size: 20,
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${tool["name"]}",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Row(
                      children: [
                        Icon(
                          Icons.star,
                          color: warningColor,
                          size: 14,
                        ),
                        SizedBox(width: spXs),
                        Text(
                          "${tool["rating"]}",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: disabledBoldColor,
                          ),
                        ),
                        SizedBox(width: spSm),
                        Text(
                          "• ${tool["users"]} users",
                          style: TextStyle(
                            fontSize: 11,
                            color: disabledColor,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          
          SizedBox(height: spMd),
          
          // Description
          Text(
            "${tool["description"]}",
            style: TextStyle(
              color: disabledBoldColor,
              fontSize: 13,
              height: 1.4,
            ),
            maxLines: isHorizontal ? 2 : 3,
            overflow: TextOverflow.ellipsis,
          ),
          
          SizedBox(height: spMd),
          
          // Features
          if (!isHorizontal) ...[
            Wrap(
              spacing: spXs,
              runSpacing: spXs,
              children: (tool["features"] as List).take(3).map((feature) {
                return Container(
                  padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                  decoration: BoxDecoration(
                    color: (tool["color"] as Color).withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusXs),
                  ),
                  child: Text(
                    feature,
                    style: TextStyle(
                      fontSize: 10,
                      color: tool["color"] as Color,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                );
              }).toList(),
            ),
            
            SizedBox(height: spMd),
          ],
          
          // Price and Action
          Row(
            children: [
              Text(
                "${tool["price"]}",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: tool["price"] == "Free" ? successColor : primaryColor,
                ),
              ),
              if (tool["price"] != "Free")
                Text(
                  "/month",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              Spacer(),
              QButton(
                label: tool["price"] == "Free" ? "Try Free" : "Subscribe",
                size: bs.sm,
                onPressed: () {
                  // Navigate to tool details
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
