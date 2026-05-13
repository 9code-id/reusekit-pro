import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlTutorial7View extends StatefulWidget {
  @override
  State<GrlTutorial7View> createState() => _GrlTutorial7ViewState();
}

class _GrlTutorial7ViewState extends State<GrlTutorial7View> {
  int selectedTopicIndex = 0;
  String searchQuery = "";
  String selectedCategory = "All";

  List<String> categories = ["All", "Getting Started", "Features", "Troubleshooting", "Advanced"];

  List<Map<String, dynamic>> helpTopics = [
    {
      "category": "Getting Started",
      "title": "How to create your first project",
      "description": "Step-by-step guide to setting up your first project",
      "content": "Creating your first project is easy! Follow these simple steps:\n\n1. Click the 'New Project' button in your dashboard\n2. Choose a project template or start from scratch\n3. Enter your project name and description\n4. Set up your team members and permissions\n5. Configure your project settings\n6. Click 'Create Project' to get started\n\nYour project will be ready in seconds and you can start adding tasks, files, and collaborating with your team immediately.",
      "icon": Icons.add_circle,
      "difficulty": "Beginner",
      "estimatedTime": "3 minutes",
      "views": 1245,
      "helpful": 89,
      "lastUpdated": "2 days ago",
    },
    {
      "category": "Getting Started",
      "title": "Understanding the dashboard",
      "description": "Learn about dashboard components and navigation",
      "content": "Your dashboard is the central hub of your workspace. Here's what you'll find:\n\n• Project Overview: Quick stats about your active projects\n• Recent Activity: Latest updates from your team\n• Tasks Summary: Your pending and completed tasks\n• Calendar Integration: Upcoming deadlines and meetings\n• Quick Actions: Fast access to common features\n\nYou can customize your dashboard by dragging and dropping widgets, changing the layout, and selecting which information to display prominently.",
      "icon": Icons.dashboard,
      "difficulty": "Beginner",
      "estimatedTime": "5 minutes",
      "views": 892,
      "helpful": 76,
      "lastUpdated": "1 week ago",
    },
    {
      "category": "Features",
      "title": "Using advanced search filters",
      "description": "Master the search functionality with filters and operators",
      "content": "Our advanced search helps you find exactly what you need:\n\n**Basic Search:**\n• Type keywords in the search bar\n• Results include projects, tasks, files, and messages\n\n**Filters:**\n• Date range: created:2024-01-01..2024-12-31\n• Author: author:john.doe\n• Project: project:\"Project Alpha\"\n• Status: status:completed\n• Type: type:task\n\n**Operators:**\n• AND: keyword1 AND keyword2\n• OR: keyword1 OR keyword2\n• NOT: keyword1 NOT keyword2\n• Exact phrase: \"exact phrase\"\n\nCombine filters for powerful searches like: type:task status:pending author:me created:this-week",
      "icon": Icons.search,
      "difficulty": "Intermediate",
      "estimatedTime": "8 minutes",
      "views": 567,
      "helpful": 94,
      "lastUpdated": "3 days ago",
    },
    {
      "category": "Features",
      "title": "Setting up automation rules",
      "description": "Automate repetitive tasks with smart rules",
      "content": "Automation saves time by handling routine tasks automatically:\n\n**Creating Rules:**\n1. Go to Settings > Automation\n2. Click 'New Rule'\n3. Set trigger conditions (when something happens)\n4. Define actions (what should happen)\n5. Test and activate your rule\n\n**Common Automation Examples:**\n• Auto-assign tasks based on keywords\n• Send notifications when deadlines approach\n• Move completed tasks to archive\n• Create recurring tasks automatically\n• Update project status based on task completion\n\n**Advanced Features:**\n• Multiple conditions with AND/OR logic\n• Time-based triggers\n• Integration with external tools\n• Custom email templates\n• Conditional formatting",
      "icon": Icons.auto_awesome,
      "difficulty": "Advanced",
      "estimatedTime": "15 minutes",
      "views": 334,
      "helpful": 87,
      "lastUpdated": "5 days ago",
    },
    {
      "category": "Troubleshooting",
      "title": "Sync issues and solutions",
      "description": "Resolve common synchronization problems",
      "content": "If your data isn't syncing properly, try these solutions:\n\n**Check Your Connection:**\n• Ensure stable internet connection\n• Try refreshing the page\n• Check if other apps are working\n\n**Clear Cache and Cookies:**\n1. Open browser settings\n2. Find 'Privacy and Security'\n3. Click 'Clear browsing data'\n4. Select 'Cached images and files'\n5. Click 'Clear data'\n\n**App-Specific Solutions:**\n• Force quit and restart the app\n• Log out and log back in\n• Check for app updates\n• Restart your device\n\n**Still Having Issues?**\n• Contact support with error details\n• Include screenshots if possible\n• Mention your device and browser version\n• Describe when the issue started",
      "icon": Icons.sync_problem,
      "difficulty": "Beginner",
      "estimatedTime": "10 minutes",
      "views": 445,
      "helpful": 82,
      "lastUpdated": "1 day ago",
    },
    {
      "category": "Advanced",
      "title": "API integration guide",
      "description": "Connect external applications using our API",
      "content": "Our REST API allows you to integrate with external systems:\n\n**Getting Started:**\n1. Generate API key in Settings > API\n2. Read our API documentation\n3. Test endpoints with Postman\n4. Implement in your application\n\n**Authentication:**\n```\nHeaders:\nAuthorization: Bearer YOUR_API_KEY\nContent-Type: application/json\n```\n\n**Common Endpoints:**\n• GET /api/projects - List all projects\n• POST /api/projects - Create new project\n• GET /api/tasks - List tasks\n• PUT /api/tasks/:id - Update task\n• DELETE /api/tasks/:id - Delete task\n\n**Rate Limits:**\n• 1000 requests per hour\n• 100 requests per minute\n• Monitor usage in dashboard\n\n**Best Practices:**\n• Cache responses when possible\n• Use webhooks for real-time updates\n• Handle errors gracefully\n• Keep API keys secure",
      "icon": Icons.code,
      "difficulty": "Advanced",
      "estimatedTime": "25 minutes",
      "views": 178,
      "helpful": 91,
      "lastUpdated": "1 week ago",
    },
    {
      "category": "Troubleshooting",
      "title": "Performance optimization tips",
      "description": "Speed up your workspace and improve performance",
      "content": "Optimize your workspace for better performance:\n\n**General Tips:**\n• Keep your browser updated\n• Close unnecessary tabs\n• Clear cache regularly\n• Use a fast internet connection\n\n**Project Organization:**\n• Archive completed projects\n• Organize files in folders\n• Delete unnecessary attachments\n• Use tags instead of multiple folders\n\n**Dashboard Optimization:**\n• Limit widgets on dashboard\n• Reduce data refresh frequency\n• Hide inactive projects\n• Use list view for large datasets\n\n**Mobile Performance:**\n• Update the mobile app regularly\n• Enable offline mode for key data\n• Reduce image quality in settings\n• Close other apps while working\n\n**Network Issues:**\n• Switch to mobile data if WiFi is slow\n• Use Ethernet instead of WiFi\n• Contact IT about network speeds\n• Work offline when possible",
      "icon": Icons.speed,
      "difficulty": "Intermediate",
      "estimatedTime": "12 minutes",
      "views": 623,
      "helpful": 85,
      "lastUpdated": "4 days ago",
    },
  ];

  List<Map<String, dynamic>> get filteredTopics {
    var topics = helpTopics;
    
    if (selectedCategory != "All") {
      topics = topics.where((topic) => topic["category"] == selectedCategory).toList();
    }
    
    if (searchQuery.isNotEmpty) {
      topics = topics.where((topic) => 
        topic["title"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
        topic["description"].toString().toLowerCase().contains(searchQuery.toLowerCase())
      ).toList();
    }
    
    return topics;
  }

  Color _getDifficultyColor(String difficulty) {
    switch (difficulty) {
      case "Beginner":
        return successColor;
      case "Intermediate":
        return warningColor;
      case "Advanced":
        return dangerColor;
      default:
        return primaryColor;
    }
  }

  void _markAsHelpful(int index) {
    ss("Thank you for your feedback!");
    // Increment helpful counter
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Help Center"),
      ),
      body: Row(
        children: [
          // Topics List (Left Panel)
          Container(
            width: MediaQuery.of(context).size.width * 0.4,
            decoration: BoxDecoration(
              color: Colors.grey.shade50,
              border: Border(
                right: BorderSide(color: disabledColor),
              ),
            ),
            child: Column(
              children: [
                // Search Bar
                Container(
                  padding: EdgeInsets.all(spMd),
                  child: Row(
                    children: [
                      Expanded(
                        child: QTextField(
                          label: "Search help topics",
                          value: searchQuery,
                          hint: "What can we help you with?",
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
                        onPressed: () {
                          // Search action already handled by onChanged
                        },
                      ),
                    ],
                  ),
                ),

                // Category Filter
                Container(
                  height: 50,
                  padding: EdgeInsets.symmetric(horizontal: spMd),
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: categories.length,
                    itemBuilder: (context, index) {
                      final category = categories[index];
                      final isSelected = selectedCategory == category;
                      
                      return GestureDetector(
                        onTap: () {
                          selectedCategory = category;
                          setState(() {});
                        },
                        child: Container(
                          margin: EdgeInsets.only(right: spSm),
                          padding: EdgeInsets.symmetric(horizontal: spMd, vertical: spSm),
                          decoration: BoxDecoration(
                            color: isSelected ? primaryColor : Colors.white,
                            borderRadius: BorderRadius.circular(radiusLg),
                            border: Border.all(
                              color: isSelected ? primaryColor : disabledColor,
                            ),
                          ),
                          child: Center(
                            child: Text(
                              category,
                              style: TextStyle(
                                color: isSelected ? Colors.white : disabledBoldColor,
                                fontWeight: FontWeight.w600,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),

                // Topics List
                Expanded(
                  child: ListView.builder(
                    padding: EdgeInsets.all(spMd),
                    itemCount: filteredTopics.length,
                    itemBuilder: (context, index) {
                      final topic = filteredTopics[index];
                      final isSelected = selectedTopicIndex == index;
                      final difficultyColor = _getDifficultyColor(topic["difficulty"]);
                      
                      return GestureDetector(
                        onTap: () {
                          selectedTopicIndex = index;
                          setState(() {});
                        },
                        child: Container(
                          margin: EdgeInsets.only(bottom: spSm),
                          padding: EdgeInsets.all(spMd),
                          decoration: BoxDecoration(
                            color: isSelected ? primaryColor.withAlpha(20) : Colors.white,
                            borderRadius: BorderRadius.circular(radiusLg),
                            border: Border.all(
                              color: isSelected ? primaryColor : disabledColor,
                            ),
                            boxShadow: isSelected ? [shadowSm] : [],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            spacing: spSm,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    topic["icon"] as IconData,
                                    color: isSelected ? primaryColor : disabledBoldColor,
                                    size: 20,
                                  ),
                                  SizedBox(width: spSm),
                                  Expanded(
                                    child: Text(
                                      "${topic["title"]}",
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: isSelected ? primaryColor : disabledBoldColor,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                "${topic["description"]}",
                                style: TextStyle(
                                  color: disabledBoldColor,
                                  fontSize: 12,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              Row(
                                children: [
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: spSm,
                                      vertical: spXs,
                                    ),
                                    decoration: BoxDecoration(
                                      color: difficultyColor.withAlpha(20),
                                      borderRadius: BorderRadius.circular(radiusXl),
                                    ),
                                    child: Text(
                                      "${topic["difficulty"]}",
                                      style: TextStyle(
                                        color: difficultyColor,
                                        fontSize: 10,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: spSm),
                                  Text(
                                    "${topic["estimatedTime"]}",
                                    style: TextStyle(
                                      color: disabledBoldColor,
                                      fontSize: 10,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),

          // Content Panel (Right Panel)
          Expanded(
            child: filteredTopics.isEmpty
                ? _buildEmptyState()
                : _buildTopicContent(filteredTopics[selectedTopicIndex]),
          ),
        ],
      ),
    );
  }

  Widget _buildTopicContent(Map<String, dynamic> topic) {
    final difficultyColor = _getDifficultyColor(topic["difficulty"]);
    
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          // Topic Header
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(10),
              borderRadius: BorderRadius.circular(radiusLg),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spSm,
              children: [
                Row(
                  children: [
                    Icon(
                      topic["icon"] as IconData,
                      color: primaryColor,
                      size: 32,
                    ),
                    SizedBox(width: spMd),
                    Expanded(
                      child: Text(
                        "${topic["title"]}",
                        style: TextStyle(
                          fontSize: fsH5,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ),
                  ],
                ),
                Text(
                  "${topic["description"]}",
                  style: TextStyle(
                    color: disabledBoldColor,
                    fontSize: 16,
                  ),
                ),
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: spSm,
                        vertical: spXs,
                      ),
                      decoration: BoxDecoration(
                        color: difficultyColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusXl),
                      ),
                      child: Text(
                        "${topic["difficulty"]}",
                        style: TextStyle(
                          color: difficultyColor,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    SizedBox(width: spSm),
                    Icon(
                      Icons.schedule,
                      color: disabledBoldColor,
                      size: 14,
                    ),
                    SizedBox(width: spXs),
                    Text(
                      "${topic["estimatedTime"]}",
                      style: TextStyle(
                        color: disabledBoldColor,
                        fontSize: 12,
                      ),
                    ),
                    Spacer(),
                    Text(
                      "${topic["views"]} views",
                      style: TextStyle(
                        color: disabledBoldColor,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Content
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusLg),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spMd,
              children: [
                Text(
                  "${topic["content"]}",
                  style: TextStyle(
                    color: disabledBoldColor,
                    height: 1.6,
                    fontSize: 15,
                  ),
                ),
              ],
            ),
          ),

          // Feedback Section
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: successColor.withAlpha(10),
              borderRadius: BorderRadius.circular(radiusLg),
              border: Border.all(color: successColor.withAlpha(30)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spSm,
              children: [
                Text(
                  "Was this helpful?",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: successColor,
                  ),
                ),
                Row(
                  children: [
                    QButton(
                      label: "Yes, helpful",
                      size: bs.sm,
                      icon: Icons.thumb_up,
                      onPressed: () => _markAsHelpful(selectedTopicIndex),
                    ),
                    SizedBox(width: spSm),
                    QButton(
                      label: "No, needs improvement",
                      size: bs.sm,
                      icon: Icons.thumb_down,
                      onPressed: () {
                        sw("Thank you for the feedback. We'll improve this article.");
                      },
                    ),
                  ],
                ),
                Text(
                  "${topic["helpful"]}% found this helpful • Updated ${topic["lastUpdated"]}",
                  style: TextStyle(
                    color: successColor,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),

          // Related Topics
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: infoColor.withAlpha(10),
              borderRadius: BorderRadius.circular(radiusLg),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spSm,
              children: [
                Text(
                  "Related Topics",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: infoColor,
                  ),
                ),
                ...helpTopics
                    .where((t) => t["category"] == topic["category"] && t != topic)
                    .take(3)
                    .map((relatedTopic) => GestureDetector(
                          onTap: () {
                            selectedTopicIndex = helpTopics.indexOf(relatedTopic);
                            setState(() {});
                          },
                          child: Container(
                            padding: EdgeInsets.all(spSm),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  relatedTopic["icon"] as IconData,
                                  color: infoColor,
                                  size: 16,
                                ),
                                SizedBox(width: spSm),
                                Expanded(
                                  child: Text(
                                    "${relatedTopic["title"]}",
                                    style: TextStyle(
                                      color: infoColor,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                                Icon(
                                  Icons.arrow_forward,
                                  color: infoColor,
                                  size: 16,
                                ),
                              ],
                            ),
                          ),
                        )),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Container(
      padding: EdgeInsets.all(spMd),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.search_off,
              size: 64,
              color: disabledColor,
            ),
            SizedBox(height: spMd),
            Text(
              "No help topics found",
              style: TextStyle(
                fontSize: fsH5,
                color: disabledBoldColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: spSm),
            Text(
              "Try adjusting your search or browse different categories",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: disabledBoldColor,
              ),
            ),
            SizedBox(height: spMd),
            QButton(
              label: "Clear Search",
              size: bs.md,
              onPressed: () {
                searchQuery = "";
                selectedCategory = "All";
                setState(() {});
              },
            ),
          ],
        ),
      ),
    );
  }
}
