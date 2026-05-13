import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class NmaUserContributionsView extends StatefulWidget {
  const NmaUserContributionsView({super.key});

  @override
  State<NmaUserContributionsView> createState() => _NmaUserContributionsViewState();
}

class _NmaUserContributionsViewState extends State<NmaUserContributionsView> {
  int currentTab = 0;
  String selectedFilter = "All";
  String selectedDateRange = "All Time";

  final Map<String, dynamic> userProfile = {
    "name": "Alex Thompson",
    "avatar": "https://picsum.photos/150/150?random=1&face",
    "joinDate": "March 2023",
    "location": "San Francisco, CA",
    "bio": "Passionate citizen journalist focused on local community news and environmental issues. Dedicated to bringing transparency and accountability to our neighborhood.",
    "isVerified": true,
    "totalPosts": 89,
    "totalViews": 45678,
    "totalLikes": 3456,
    "totalShares": 1234,
    "followers": 567,
    "following": 123,
    "badges": ["Verified Reporter", "Community Leader", "Environmental Advocate"]
  };

  final List<Map<String, dynamic>> contributions = [
    {
      "id": "cont_001",
      "type": "Article",
      "title": "Local Park Restoration Project Updates",
      "content": "Major progress made on the community park restoration. New playground equipment installed and landscaping 80% complete. Grand reopening scheduled for next month.",
      "image": "https://picsum.photos/400/300?random=1&park",
      "publishDate": "2024-01-15",
      "status": "Published",
      "views": 1234,
      "likes": 89,
      "comments": 23,
      "shares": 12,
      "category": "Community"
    },
    {
      "id": "cont_002",
      "type": "Breaking News",
      "title": "Traffic Light System Malfunction on Main Street",
      "content": "Multiple traffic lights malfunctioned during rush hour causing significant delays. City maintenance crews dispatched immediately. Alternative routes recommended.",
      "image": "https://picsum.photos/400/300?random=2&traffic",
      "publishDate": "2024-01-14",
      "status": "Published",
      "views": 2456,
      "likes": 145,
      "comments": 56,
      "shares": 34,
      "category": "Traffic"
    },
    {
      "id": "cont_003",
      "type": "Photo Story",
      "title": "Downtown Festival Photo Coverage",
      "content": "Complete photo coverage of the annual downtown festival featuring local artisans, food vendors, and live performances. Community came together for a wonderful celebration.",
      "image": "https://picsum.photos/400/300?random=3&festival",
      "publishDate": "2024-01-12",
      "status": "Published",
      "views": 3567,
      "likes": 234,
      "comments": 45,
      "shares": 67,
      "category": "Events"
    },
    {
      "id": "cont_004",
      "type": "Investigation",
      "title": "Water Quality Concerns at Local School",
      "content": "Investigation into water quality issues at elementary school. Testing results and school board response. Parents and community members demand immediate action.",
      "image": "https://picsum.photos/400/300?random=4&school",
      "publishDate": "2024-01-10",
      "status": "Under Review",
      "views": 4567,
      "likes": 345,
      "comments": 78,
      "shares": 89,
      "category": "Education"
    },
    {
      "id": "cont_005",
      "type": "Weather Report",
      "title": "Severe Storm Damage Assessment",
      "content": "Comprehensive damage assessment following last week's severe thunderstorm. Power outages, fallen trees, and property damage documented across multiple neighborhoods.",
      "image": "https://picsum.photos/400/300?random=5&storm",
      "publishDate": "2024-01-08",
      "status": "Published",
      "views": 5678,
      "likes": 456,
      "comments": 89,
      "shares": 123,
      "category": "Weather"
    },
    {
      "id": "cont_006",
      "type": "Draft",
      "title": "Upcoming City Council Meeting Preview",
      "content": "Preview of key agenda items for this week's city council meeting including budget discussions, zoning changes, and public safety initiatives.",
      "image": "https://picsum.photos/400/300?random=6&government",
      "publishDate": "2024-01-16",
      "status": "Draft",
      "views": 0,
      "likes": 0,
      "comments": 0,
      "shares": 0,
      "category": "Government"
    }
  ];

  final List<Map<String, dynamic>> achievements = [
    {
      "title": "Top Contributor",
      "description": "Most active contributor this month",
      "icon": Icons.star,
      "color": Colors.amber,
      "dateEarned": "2024-01-15"
    },
    {
      "title": "Verified Reporter",
      "description": "Verified as a trusted news source",
      "icon": Icons.verified,
      "color": Colors.blue,
      "dateEarned": "2023-12-01"
    },
    {
      "title": "Community Leader",
      "description": "Leading positive community engagement",
      "icon": Icons.people,
      "color": Colors.green,
      "dateEarned": "2023-11-15"
    },
    {
      "title": "Environmental Advocate",
      "description": "Focused on environmental issues",
      "icon": Icons.eco,
      "color": Colors.teal,
      "dateEarned": "2023-10-20"
    }
  ];

  List<Map<String, dynamic>> get filteredContributions {
    return contributions.where((contribution) {
      final matchesFilter = selectedFilter == "All" || contribution["type"] == selectedFilter;
      // Note: Date range filtering would be implemented here
      return matchesFilter;
    }).toList();
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "Published":
        return successColor;
      case "Under Review":
        return warningColor;
      case "Draft":
        return infoColor;
      case "Rejected":
        return dangerColor;
      default:
        return disabledColor;
    }
  }

  Widget _buildProfileHeader() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [primaryColor, primaryColor.withAlpha(180)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowMd],
      ),
      child: Column(
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 40,
                backgroundImage: NetworkImage("${userProfile["avatar"]}"),
              ),
              SizedBox(width: spMd),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          "${userProfile["name"]}",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        if (userProfile["isVerified"])
                          Row(
                            children: [
                              SizedBox(width: spSm),
                              Icon(
                                Icons.verified,
                                color: Colors.white,
                                size: 20,
                              ),
                            ],
                          ),
                      ],
                    ),
                    Text(
                      "Joined ${userProfile["joinDate"]} • ${userProfile["location"]}",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: spMd),
          Text(
            "${userProfile["bio"]}",
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              height: 1.4,
            ),
          ),
          SizedBox(height: spMd),
          ResponsiveGridView(
            minItemWidth: 200,
            children: [
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.white.withAlpha(30),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Column(
                  children: [
                    Text(
                      "${userProfile["totalPosts"]}",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "Posts",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.white.withAlpha(30),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Column(
                  children: [
                    Text(
                      "${((userProfile["totalViews"] as int) / 1000).toInt()}K",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "Views",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.white.withAlpha(30),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Column(
                  children: [
                    Text(
                      "${userProfile["followers"]}",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "Followers",
                      style: TextStyle(
                        color: Colors.white,
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
    );
  }

  Widget _buildContributionCard(Map<String, dynamic> contribution) {
    return Container(
      margin: EdgeInsets.only(bottom: spMd),
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowMd],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: primaryColor.withAlpha(30),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Text(
                  "${contribution["type"]}",
                  style: TextStyle(
                    color: primaryColor,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Spacer(),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: _getStatusColor(contribution["status"]).withAlpha(30),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Text(
                  "${contribution["status"]}",
                  style: TextStyle(
                    color: _getStatusColor(contribution["status"]),
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: spMd),
          Text(
            "${contribution["title"]}",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          Text(
            "${contribution["content"]}",
            style: TextStyle(
              color: disabledBoldColor,
              height: 1.4,
            ),
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: spMd),
          ClipRRect(
            borderRadius: BorderRadius.circular(radiusSm),
            child: Image.network(
              "${contribution["image"]}",
              width: double.infinity,
              height: 150,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(height: spMd),
          Row(
            children: [
              Icon(Icons.calendar_today, size: 16, color: disabledBoldColor),
              SizedBox(width: spXs),
              Text(
                "${contribution["publishDate"]}",
                style: TextStyle(color: disabledBoldColor, fontSize: 14),
              ),
              SizedBox(width: spMd),
              Icon(Icons.category, size: 16, color: disabledBoldColor),
              SizedBox(width: spXs),
              Text(
                "${contribution["category"]}",
                style: TextStyle(color: disabledBoldColor, fontSize: 14),
              ),
            ],
          ),
          if (contribution["status"] == "Published") ...[
            SizedBox(height: spMd),
            Row(
              children: [
                Row(
                  children: [
                    Icon(Icons.visibility, size: 16, color: disabledBoldColor),
                    SizedBox(width: spXs),
                    Text("${contribution["views"]}", style: TextStyle(color: disabledBoldColor)),
                  ],
                ),
                SizedBox(width: spMd),
                Row(
                  children: [
                    Icon(Icons.favorite_border, size: 16, color: disabledBoldColor),
                    SizedBox(width: spXs),
                    Text("${contribution["likes"]}", style: TextStyle(color: disabledBoldColor)),
                  ],
                ),
                SizedBox(width: spMd),
                Row(
                  children: [
                    Icon(Icons.comment_outlined, size: 16, color: disabledBoldColor),
                    SizedBox(width: spXs),
                    Text("${contribution["comments"]}", style: TextStyle(color: disabledBoldColor)),
                  ],
                ),
                Spacer(),
                QButton(
                  label: "View",
                  size: bs.sm,
                  onPressed: () {
                    ss("View contribution feature coming soon");
                  },
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildContributionsTab() {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(spMd),
          color: Colors.white,
          child: Row(
            children: [
              Expanded(
                child: QDropdownField(
                  label: "Filter by Type",
                  items: [
                    {"label": "All Types", "value": "All"},
                    {"label": "Article", "value": "Article"},
                    {"label": "Breaking News", "value": "Breaking News"},
                    {"label": "Photo Story", "value": "Photo Story"},
                    {"label": "Investigation", "value": "Investigation"},
                    {"label": "Weather Report", "value": "Weather Report"},
                    {"label": "Draft", "value": "Draft"},
                  ],
                  value: selectedFilter,
                  onChanged: (value, label) {
                    selectedFilter = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QDropdownField(
                  label: "Date Range",
                  items: [
                    {"label": "All Time", "value": "All Time"},
                    {"label": "This Week", "value": "This Week"},
                    {"label": "This Month", "value": "This Month"},
                    {"label": "Last 3 Months", "value": "Last 3 Months"},
                  ],
                  value: selectedDateRange,
                  onChanged: (value, label) {
                    selectedDateRange = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(spMd),
            child: Column(
              children: [
                _buildProfileHeader(),
                SizedBox(height: spMd),
                ...filteredContributions.map((contribution) => _buildContributionCard(contribution)).toList(),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildAchievementsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusLg),
              boxShadow: [shadowMd],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Achievements & Badges",
                  style: TextStyle(
                    fontSize: fsH5,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spSm),
                Text(
                  "Recognition for outstanding contributions to the community",
                  style: TextStyle(
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
          
          ...achievements.map((achievement) {
            return Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowMd],
              ),
              child: Row(
                children: [
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      color: (achievement["color"] as Color).withAlpha(30),
                      borderRadius: BorderRadius.circular(radiusMd),
                    ),
                    child: Icon(
                      achievement["icon"],
                      color: achievement["color"],
                      size: 30,
                    ),
                  ),
                  SizedBox(width: spMd),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${achievement["title"]}",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "${achievement["description"]}",
                          style: TextStyle(
                            color: disabledBoldColor,
                          ),
                        ),
                        SizedBox(height: spSm),
                        Text(
                          "Earned: ${achievement["dateEarned"]}",
                          style: TextStyle(
                            color: disabledBoldColor,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildStatsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          ResponsiveGridView(
            minItemWidth: 200,
            children: [
              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusLg),
                  boxShadow: [shadowMd],
                ),
                child: Column(
                  children: [
                    Icon(Icons.article, color: primaryColor, size: 32),
                    SizedBox(height: spSm),
                    Text(
                      "Total Posts",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "${userProfile["totalPosts"]}",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusLg),
                  boxShadow: [shadowMd],
                ),
                child: Column(
                  children: [
                    Icon(Icons.visibility, color: successColor, size: 32),
                    SizedBox(height: spSm),
                    Text(
                      "Total Views",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "${((userProfile["totalViews"] as int) / 1000).toInt()}K",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusLg),
                  boxShadow: [shadowMd],
                ),
                child: Column(
                  children: [
                    Icon(Icons.favorite, color: dangerColor, size: 32),
                    SizedBox(height: spSm),
                    Text(
                      "Total Likes",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "${((userProfile["totalLikes"] as int) / 1000).toInt()}K",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusLg),
                  boxShadow: [shadowMd],
                ),
                child: Column(
                  children: [
                    Icon(Icons.share, color: warningColor, size: 32),
                    SizedBox(height: spSm),
                    Text(
                      "Total Shares",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "${((userProfile["totalShares"] as int) / 1000).toInt()}K",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusLg),
              boxShadow: [shadowMd],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Engagement Overview",
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
                      child: Column(
                        children: [
                          Text(
                            "Avg. Views per Post",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                          Text(
                            "${((userProfile["totalViews"] as int) / (userProfile["totalPosts"] as int)).toInt()}",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          Text(
                            "Engagement Rate",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                          Text(
                            "7.6%",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
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
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "My Contributions",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Posts", icon: Icon(Icons.article)),
        Tab(text: "Achievements", icon: Icon(Icons.star)),
        Tab(text: "Statistics", icon: Icon(Icons.analytics)),
      ],
      tabChildren: [
        _buildContributionsTab(),
        _buildAchievementsTab(),
        _buildStatsTab(),
      ],
    );
  }
}
