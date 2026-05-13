import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlFeedback10View extends StatefulWidget {
  @override
  State<GrlFeedback10View> createState() => _GrlFeedback10ViewState();
}

class _GrlFeedback10ViewState extends State<GrlFeedback10View> {
  String selectedTab = "submit";
  
  // Analytics Data
  List<Map<String, dynamic>> feedbackStats = [
    {
      "type": "Bug Reports",
      "count": 142,
      "resolved": 128,
      "pending": 14,
      "color": Colors.red,
      "icon": Icons.bug_report,
    },
    {
      "type": "Feature Requests",
      "count": 89,
      "resolved": 67,
      "pending": 22,
      "color": Colors.blue,
      "icon": Icons.lightbulb,
    },
    {
      "type": "General Feedback",
      "count": 234,
      "resolved": 210,
      "pending": 24,
      "color": Colors.green,
      "icon": Icons.comment,
    },
    {
      "type": "Service Reviews",
      "count": 156,
      "resolved": 145,
      "pending": 11,
      "color": Colors.orange,
      "icon": Icons.star,
    },
  ];
  
  List<Map<String, dynamic>> recentFeedback = [
    {
      "id": "FB2024001",
      "title": "App crashes on startup",
      "type": "Bug Report",
      "priority": "High",
      "status": "In Progress",
      "submitted": DateTime.now().subtract(Duration(hours: 2)),
      "user": "john.doe@email.com",
    },
    {
      "id": "FB2024002",
      "title": "Add dark mode theme",
      "type": "Feature Request",
      "priority": "Medium",
      "status": "Under Review",
      "submitted": DateTime.now().subtract(Duration(hours: 5)),
      "user": "jane.smith@email.com",
    },
    {
      "id": "FB2024003",
      "title": "Excellent customer service",
      "type": "General Feedback",
      "priority": "Low",
      "status": "Acknowledged",
      "submitted": DateTime.now().subtract(Duration(hours: 8)),
      "user": "mike.wilson@email.com",
    },
    {
      "id": "FB2024004",
      "title": "Slow page loading",
      "type": "Performance Issue",
      "priority": "Medium",
      "status": "Investigating",
      "submitted": DateTime.now().subtract(Duration(days: 1)),
      "user": "sarah.johnson@email.com",
    },
  ];
  
  List<Map<String, dynamic>> popularFeedback = [
    {
      "title": "Dark mode support",
      "votes": 156,
      "category": "Feature Request",
      "status": "In Development",
    },
    {
      "title": "Offline mode functionality",
      "votes": 89,
      "category": "Feature Request",
      "status": "Under Review",
    },
    {
      "title": "Better search functionality",
      "votes": 67,
      "category": "Enhancement",
      "status": "Planned",
    },
    {
      "title": "Mobile app performance",
      "votes": 45,
      "category": "Bug Report",
      "status": "Fixed",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Feedback Hub"),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {
              // navigateTo(FeedbackNotificationsView());
            },
          ),
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              // navigateTo(FeedbackSettingsView());
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Tab Header
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: primaryColor,
              boxShadow: [shadowSm],
            ),
            child: Row(
              children: [
                _buildTabButton("submit", "Submit", Icons.add_comment),
                SizedBox(width: spSm),
                _buildTabButton("analytics", "Analytics", Icons.analytics),
                SizedBox(width: spSm),
                _buildTabButton("trending", "Trending", Icons.trending_up),
              ],
            ),
          ),
          
          // Tab Content
          Expanded(
            child: _buildTabContent(),
          ),
        ],
      ),
      floatingActionButton: selectedTab == "submit" 
          ? FloatingActionButton.extended(
              onPressed: () {
                _showFeedbackOptions();
              },
              backgroundColor: primaryColor,
              icon: Icon(Icons.add, color: Colors.white),
              label: Text(
                "New Feedback",
                style: TextStyle(color: Colors.white),
              ),
            )
          : null,
    );
  }

  Widget _buildTabButton(String tabKey, String label, IconData icon) {
    bool isSelected = selectedTab == tabKey;
    return Expanded(
      child: GestureDetector(
        onTap: () {
          selectedTab = tabKey;
          setState(() {});
        },
        child: Container(
          padding: EdgeInsets.symmetric(vertical: spMd),
          decoration: BoxDecoration(
            color: isSelected ? Colors.white : Colors.transparent,
            borderRadius: BorderRadius.circular(radiusLg),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                color: isSelected ? primaryColor : Colors.white,
                size: 20,
              ),
              SizedBox(width: spSm),
              Text(
                label,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: isSelected ? primaryColor : Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTabContent() {
    switch (selectedTab) {
      case "submit":
        return _buildSubmitTab();
      case "analytics":
        return _buildAnalyticsTab();
      case "trending":
        return _buildTrendingTab();
      default:
        return _buildSubmitTab();
    }
  }

  Widget _buildSubmitTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Quick Actions
          Text(
            "Quick Actions",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),
          
          Row(
            children: [
              _buildQuickActionCard(
                "Bug Report",
                Icons.bug_report,
                Colors.red,
                "Report a technical issue",
                () {
                  // navigateTo(BugReportView());
                },
              ),
              SizedBox(width: spSm),
              _buildQuickActionCard(
                "Feature Request",
                Icons.lightbulb,
                Colors.blue,
                "Suggest a new feature",
                () {
                  // navigateTo(FeatureRequestView());
                },
              ),
            ],
          ),
          
          SizedBox(height: spSm),
          
          Row(
            children: [
              _buildQuickActionCard(
                "General Feedback",
                Icons.comment,
                Colors.green,
                "Share your thoughts",
                () {
                  // navigateTo(GeneralFeedbackView());
                },
              ),
              SizedBox(width: spSm),
              _buildQuickActionCard(
                "Service Review",
                Icons.star,
                Colors.orange,
                "Rate our service",
                () {
                  // navigateTo(ServiceReviewView());
                },
              ),
            ],
          ),
          
          SizedBox(height: spMd),
          
          // Recent Submissions
          Row(
            children: [
              Text(
                "Your Recent Submissions",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Spacer(),
              GestureDetector(
                onTap: () {
                  // navigateTo(FeedbackHistoryView());
                },
                child: Text(
                  "View All",
                  style: TextStyle(
                    fontSize: 14,
                    color: primaryColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          
          SizedBox(height: spMd),
          
          ...recentFeedback.take(3).map((feedback) => Container(
            width: double.infinity,
            margin: EdgeInsets.only(bottom: spMd),
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusLg),
              boxShadow: [shadowSm],
              border: Border(
                left: BorderSide(
                  width: 4,
                  color: _getStatusColor(feedback["status"]),
                ),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: spSm,
                        vertical: spXs,
                      ),
                      decoration: BoxDecoration(
                        color: _getTypeColor(feedback["type"]).withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Text(
                        feedback["id"],
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: _getTypeColor(feedback["type"]),
                        ),
                      ),
                    ),
                    Spacer(),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: spSm,
                        vertical: spXs,
                      ),
                      decoration: BoxDecoration(
                        color: _getStatusColor(feedback["status"]),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Text(
                        feedback["status"],
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spSm),
                Text(
                  "${feedback["title"]}",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: spXs),
                Text(
                  "${feedback["type"]} • ${(feedback["submitted"] as DateTime).dMMMy}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          )).toList(),
          
          SizedBox(height: spMd),
          
          // Help Section
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: infoColor.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusLg),
              border: Border.all(
                color: infoColor.withAlpha(40),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.help,
                      color: infoColor,
                      size: 20,
                    ),
                    SizedBox(width: spSm),
                    Text(
                      "Need Help?",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: infoColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spSm),
                Text(
                  "Before submitting feedback, check our FAQ or search existing feedback to avoid duplicates.",
                  style: TextStyle(
                    fontSize: 12,
                    color: infoColor,
                  ),
                ),
                SizedBox(height: spMd),
                Row(
                  children: [
                    Expanded(
                      child: QButton(
                        label: "View FAQ",
                        size: bs.sm,
                        color: infoColor,
                        onPressed: () {
                          // navigateTo(FAQView());
                        },
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: QButton(
                        label: "Search Feedback",
                        size: bs.sm,
                        color: Colors.grey.shade600,
                        onPressed: () {
                          // navigateTo(SearchFeedbackView());
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAnalyticsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Overview Stats
          Text(
            "Feedback Overview",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),
          
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 150,
            children: feedbackStats.map((stat) => Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        stat["icon"] as IconData,
                        color: stat["color"] as Color,
                        size: 24,
                      ),
                      Spacer(),
                      Text(
                        "${stat["count"]}",
                        style: TextStyle(
                          fontSize: fsH5,
                          fontWeight: FontWeight.bold,
                          color: stat["color"] as Color,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  Text(
                    stat["type"],
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: spXs),
                  Row(
                    children: [
                      Text(
                        "Resolved: ${stat["resolved"]}",
                        style: TextStyle(
                          fontSize: 10,
                          color: successColor,
                        ),
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "Pending: ${stat["pending"]}",
                        style: TextStyle(
                          fontSize: 10,
                          color: warningColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  LinearProgressIndicator(
                    value: (stat["resolved"] as int) / (stat["count"] as int),
                    backgroundColor: Colors.grey.shade200,
                    valueColor: AlwaysStoppedAnimation<Color>(stat["color"] as Color),
                  ),
                ],
              ),
            )).toList(),
          ),
          
          SizedBox(height: spMd),
          
          // Resolution Rate
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusLg),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Resolution Performance",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spMd),
                Row(
                  children: [
                    Expanded(
                      child: _buildMetricCard(
                        "Average Resolution Time",
                        "2.3 days",
                        Icons.schedule,
                        successColor,
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: _buildMetricCard(
                        "Customer Satisfaction",
                        "4.6/5.0",
                        Icons.sentiment_satisfied,
                        warningColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spSm),
                Row(
                  children: [
                    Expanded(
                      child: _buildMetricCard(
                        "Total Feedback",
                        "621",
                        Icons.feedback,
                        primaryColor,
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: _buildMetricCard(
                        "This Month",
                        "+23%",
                        Icons.trending_up,
                        infoColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          
          SizedBox(height: spMd),
          
          // Recent Activity
          Text(
            "Recent Activity",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),
          
          ...recentFeedback.map((feedback) => Container(
            width: double.infinity,
            margin: EdgeInsets.only(bottom: spMd),
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusLg),
              boxShadow: [shadowSm],
            ),
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: _getTypeColor(feedback["type"]).withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Icon(
                    _getTypeIcon(feedback["type"]),
                    color: _getTypeColor(feedback["type"]),
                    size: 20,
                  ),
                ),
                SizedBox(width: spMd),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${feedback["title"]}",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "${feedback["user"]} • ${(feedback["submitted"] as DateTime).dMMMy}",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: spSm,
                    vertical: spXs,
                  ),
                  decoration: BoxDecoration(
                    color: _getStatusColor(feedback["status"]),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Text(
                    feedback["status"],
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          )).toList(),
        ],
      ),
    );
  }

  Widget _buildTrendingTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Popular Requests
          Text(
            "Most Requested Features",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),
          
          ...popularFeedback.map((feedback) => Container(
            width: double.infinity,
            margin: EdgeInsets.only(bottom: spMd),
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusLg),
              boxShadow: [shadowSm],
            ),
            child: Row(
              children: [
                // Vote Count
                Container(
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: primaryColor.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusLg),
                  ),
                  child: Column(
                    children: [
                      Icon(
                        Icons.keyboard_arrow_up,
                        color: primaryColor,
                        size: 20,
                      ),
                      Text(
                        "${feedback["votes"]}",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "votes",
                        style: TextStyle(
                          fontSize: 10,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
                
                SizedBox(width: spMd),
                
                // Content
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${feedback["title"]}",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: spXs),
                      Row(
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: spSm,
                              vertical: spXs,
                            ),
                            decoration: BoxDecoration(
                              color: infoColor.withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Text(
                              feedback["category"],
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                color: infoColor,
                              ),
                            ),
                          ),
                          SizedBox(width: spSm),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: spSm,
                              vertical: spXs,
                            ),
                            decoration: BoxDecoration(
                              color: _getStatusColor(feedback["status"]),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Text(
                              feedback["status"],
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                
                // Action Button
                QButton(
                  icon: Icons.keyboard_arrow_up,
                  size: bs.sm,
                  onPressed: () {
                    _voteForFeature(feedback);
                  },
                ),
              ],
            ),
          )).toList(),
          
          SizedBox(height: spMd),
          
          // Trending Categories
          Text(
            "Trending Categories",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),
          
          Wrap(
            spacing: spSm,
            runSpacing: spSm,
            children: [
              "UI/UX Improvements",
              "Performance Optimization",
              "New Features",
              "Mobile Experience",
              "Accessibility",
              "Integration Requests"
            ].map((category) => Container(
              padding: EdgeInsets.symmetric(
                horizontal: spMd,
                vertical: spSm,
              ),
              decoration: BoxDecoration(
                color: primaryColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusLg),
                border: Border.all(
                  color: primaryColor.withAlpha(40),
                ),
              ),
              child: Text(
                category,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: primaryColor,
                ),
              ),
            )).toList(),
          ),
          
          SizedBox(height: spMd),
          
          // Community Engagement
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: successColor.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusLg),
              border: Border.all(
                color: successColor.withAlpha(40),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.people,
                      color: successColor,
                      size: 20,
                    ),
                    SizedBox(width: spSm),
                    Text(
                      "Community Engagement",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: successColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spSm),
                Text(
                  "Join our community forum to discuss features, vote on requests, and collaborate with other users.",
                  style: TextStyle(
                    fontSize: 12,
                    color: successColor,
                  ),
                ),
                SizedBox(height: spMd),
                QButton(
                  label: "Join Community",
                  size: bs.sm,
                  color: successColor,
                  onPressed: () {
                    // navigateTo(CommunityForumView());
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActionCard(String title, IconData icon, Color color, String description, VoidCallback onTap) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.all(spMd),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(radiusLg),
            boxShadow: [shadowSm],
          ),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: color.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusLg),
                ),
                child: Icon(
                  icon,
                  color: color,
                  size: 32,
                ),
              ),
              SizedBox(height: spMd),
              Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: spXs),
              Text(
                description,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 11,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMetricCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: color.withAlpha(20),
        borderRadius: BorderRadius.circular(radiusLg),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                icon,
                color: color,
                size: 20,
              ),
              Spacer(),
              Text(
                value,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Text(
            title,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "In Progress":
      case "Investigating":
        return warningColor;
      case "Resolved":
      case "Fixed":
      case "In Development":
        return successColor;
      case "Under Review":
      case "Planned":
        return infoColor;
      case "Acknowledged":
        return primaryColor;
      default:
        return Colors.grey;
    }
  }

  Color _getTypeColor(String type) {
    switch (type) {
      case "Bug Report":
      case "Performance Issue":
        return dangerColor;
      case "Feature Request":
        return primaryColor;
      case "General Feedback":
        return successColor;
      case "Service Review":
        return warningColor;
      default:
        return Colors.grey;
    }
  }

  IconData _getTypeIcon(String type) {
    switch (type) {
      case "Bug Report":
      case "Performance Issue":
        return Icons.bug_report;
      case "Feature Request":
        return Icons.lightbulb;
      case "General Feedback":
        return Icons.comment;
      case "Service Review":
        return Icons.star;
      default:
        return Icons.feedback;
    }
  }

  void _showFeedbackOptions() {
    si("Feedback options would open in a bottom sheet");
  }

  void _voteForFeature(Map<String, dynamic> feedback) {
    si("Voted for: ${feedback["title"]}");
  }
}
