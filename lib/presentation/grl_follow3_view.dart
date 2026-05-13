import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlFollow3View extends StatefulWidget {
  @override
  State<GrlFollow3View> createState() => _GrlFollow3ViewState();
}

class _GrlFollow3ViewState extends State<GrlFollow3View> {
  String searchQuery = "";
  String selectedFilter = "all";
  bool showAnalytics = true;
  
  List<Map<String, dynamic>> filters = [
    {"label": "All", "value": "all"},
    {"label": "New Followers", "value": "new"},
    {"label": "Lost Followers", "value": "lost"},
    {"label": "Active", "value": "active"},
    {"label": "Inactive", "value": "inactive"},
  ];

  List<Map<String, dynamic>> analyticsData = [
    {
      "period": "Today",
      "newFollowers": 12,
      "unfollowers": 3,
      "netGrowth": 9,
      "engagementRate": 8.5,
      "color": primaryColor
    },
    {
      "period": "This Week", 
      "newFollowers": 84,
      "unfollowers": 21,
      "netGrowth": 63,
      "engagementRate": 7.2,
      "color": successColor
    },
    {
      "period": "This Month",
      "newFollowers": 356,
      "unfollowers": 89,
      "netGrowth": 267,
      "engagementRate": 6.8,
      "color": infoColor
    },
  ];

  List<Map<String, dynamic>> followActivities = [
    {
      "id": 1,
      "type": "new_follower",
      "user": {
        "name": "Elena Martinez",
        "username": "@elena_travel",
        "avatar": "https://picsum.photos/40/40?random=21&keyword=woman",
        "verified": true,
        "followers": 2453
      },
      "timestamp": "2024-01-16T10:30:00Z",
      "mutualConnections": 7,
      "isActive": true
    },
    {
      "id": 2,
      "type": "unfollowed",
      "user": {
        "name": "James Wilson",
        "username": "@james_code",
        "avatar": "https://picsum.photos/40/40?random=22&keyword=developer",
        "verified": false,
        "followers": 892
      },
      "timestamp": "2024-01-16T09:15:00Z",
      "reason": "inactive_account",
      "isActive": false
    },
    {
      "id": 3,
      "type": "new_follower",
      "user": {
        "name": "Sophia Chen",
        "username": "@sophia_design",
        "avatar": "https://picsum.photos/40/40?random=23&keyword=designer",
        "verified": true,
        "followers": 5674
      },
      "timestamp": "2024-01-16T08:45:00Z",
      "mutualConnections": 12,
      "isActive": true
    },
    {
      "id": 4,
      "type": "milestone",
      "milestone": "1000_followers",
      "timestamp": "2024-01-15T16:20:00Z",
      "description": "Reached 1,000 followers!"
    },
    {
      "id": 5,
      "type": "engagement_spike",
      "user": {
        "name": "Michael Brown",
        "username": "@mike_fitness",
        "avatar": "https://picsum.photos/40/40?random=24&keyword=fitness",
        "verified": false,
        "followers": 1234
      },
      "timestamp": "2024-01-15T14:10:00Z",
      "engagement": 15.2,
      "isActive": true
    },
  ];

  List<Map<String, dynamic>> topFollowers = [
    {
      "name": "Alex Rodriguez",
      "username": "@alex_business",
      "avatar": "https://picsum.photos/45/45?random=25&keyword=business",
      "influence_score": 95,
      "followers": 25600,
      "engagement": 12.8,
      "verified": true,
      "category": "Business"
    },
    {
      "name": "Maria Garcia", 
      "username": "@maria_lifestyle",
      "avatar": "https://picsum.photos/45/45?random=26&keyword=lifestyle",
      "influence_score": 88,
      "followers": 18900,
      "engagement": 9.4,
      "verified": true,
      "category": "Lifestyle"
    },
    {
      "name": "David Kim",
      "username": "@david_tech",
      "avatar": "https://picsum.photos/45/45?random=27&keyword=technology",
      "influence_score": 82,
      "followers": 12300,
      "engagement": 11.2,
      "verified": false,
      "category": "Technology"
    },
  ];

  List<Map<String, dynamic>> get filteredActivities {
    return followActivities.where((activity) {
      bool matchesSearch = searchQuery.isEmpty ||
          (activity["user"]?["name"]?.toLowerCase()?.contains(searchQuery.toLowerCase()) ?? false) ||
          (activity["user"]?["username"]?.toLowerCase()?.contains(searchQuery.toLowerCase()) ?? false);
      
      bool matchesFilter = selectedFilter == "all" ||
          (selectedFilter == "new" && activity["type"] == "new_follower") ||
          (selectedFilter == "lost" && activity["type"] == "unfollowed") ||
          (selectedFilter == "active" && (activity["isActive"] ?? false)) ||
          (selectedFilter == "inactive" && !(activity["isActive"] ?? true));
      
      return matchesSearch && matchesFilter;
    }).toList();
  }

  Widget _buildAnalyticsCard(Map<String, dynamic> data) {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
        border: Border.all(color: (data["color"] as Color).withAlpha(30)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  color: data["color"] as Color,
                  shape: BoxShape.circle,
                ),
              ),
              SizedBox(width: spSm),
              Text(
                "${data["period"]}",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          SizedBox(height: spMd),
          Row(
            children: [
              Expanded(
                child: _buildMetricItem(
                  "New",
                  "${data["newFollowers"]}",
                  successColor,
                  Icons.trending_up,
                ),
              ),
              Expanded(
                child: _buildMetricItem(
                  "Lost",
                  "${data["unfollowers"]}",
                  dangerColor,
                  Icons.trending_down,
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: (data["color"] as Color).withAlpha(20),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Net Growth",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "+${data["netGrowth"]}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: data["color"] as Color,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spXs),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Engagement",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "${data["engagementRate"]}%",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: data["color"] as Color,
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

  Widget _buildMetricItem(String label, String value, Color color, IconData icon) {
    return Column(
      children: [
        Icon(icon, color: color, size: 20),
        SizedBox(height: spXs),
        Text(
          value,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: disabledBoldColor,
          ),
        ),
      ],
    );
  }

  Widget _buildActivityCard(Map<String, dynamic> activity) {
    IconData activityIcon;
    Color activityColor;
    String activityText;

    switch (activity["type"]) {
      case "new_follower":
        activityIcon = Icons.person_add;
        activityColor = successColor;
        activityText = "started following you";
        break;
      case "unfollowed":
        activityIcon = Icons.person_remove;
        activityColor = dangerColor;
        activityText = "unfollowed you";
        break;
      case "milestone":
        activityIcon = Icons.emoji_events;
        activityColor = warningColor;
        activityText = activity["description"];
        break;
      case "engagement_spike":
        activityIcon = Icons.trending_up;
        activityColor = primaryColor;
        activityText = "high engagement activity";
        break;
      default:
        activityIcon = Icons.notifications;
        activityColor = infoColor;
        activityText = "activity update";
    }

    return Container(
      padding: EdgeInsets.all(spMd),
      margin: EdgeInsets.only(bottom: spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
        border: Border.all(color: activityColor.withAlpha(30)),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: activityColor.withAlpha(20),
              shape: BoxShape.circle,
            ),
            child: Icon(
              activityIcon,
              color: activityColor,
              size: 20,
            ),
          ),
          SizedBox(width: spMd),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (activity["user"] != null) ...[
                  Row(
                    children: [
                      Text(
                        "${activity["user"]["name"]}",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      if (activity["user"]["verified"] as bool) ...[
                        SizedBox(width: spXs),
                        Icon(
                          Icons.verified,
                          color: primaryColor,
                          size: 14,
                        ),
                      ],
                    ],
                  ),
                  Text(
                    "${activity["user"]["username"]} $activityText",
                    style: TextStyle(
                      fontSize: 13,
                      color: disabledBoldColor,
                    ),
                  ),
                  if (activity["mutualConnections"] != null)
                    Text(
                      "${activity["mutualConnections"]} mutual connections",
                      style: TextStyle(
                        fontSize: 12,
                        color: infoColor,
                      ),
                    ),
                ] else ...[
                  Text(
                    activityText,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: activityColor,
                    ),
                  ),
                ],
                SizedBox(height: spXs),
                Text(
                  _formatTimestamp(activity["timestamp"]),
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledColor,
                  ),
                ),
              ],
            ),
          ),
          if (activity["user"] != null)
            Container(
              width: 35,
              height: 35,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: NetworkImage("${activity["user"]["avatar"]}"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildTopFollowerCard(Map<String, dynamic> follower) {
    return Container(
      padding: EdgeInsets.all(spMd),
      margin: EdgeInsets.only(bottom: spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Row(
        children: [
          Stack(
            children: [
              Container(
                width: 45,
                height: 45,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: NetworkImage("${follower["avatar"]}"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              if (follower["verified"] as bool)
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    width: 16,
                    height: 16,
                    decoration: BoxDecoration(
                      color: primaryColor,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 2),
                    ),
                    child: Icon(
                      Icons.check,
                      color: Colors.white,
                      size: 10,
                    ),
                  ),
                ),
            ],
          ),
          SizedBox(width: spMd),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${follower["name"]}",
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "${follower["username"]} • ${follower["category"]}",
                  style: TextStyle(
                    fontSize: 13,
                    color: disabledBoldColor,
                  ),
                ),
                SizedBox(height: spXs),
                Row(
                  children: [
                    Icon(Icons.people, size: 12, color: disabledColor),
                    SizedBox(width: spXs),
                    Text(
                      "${((follower["followers"] as int) / 1000).toStringAsFixed(1)}K",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(width: spSm),
                    Icon(Icons.trending_up, size: 12, color: successColor),
                    SizedBox(width: spXs),
                    Text(
                      "${follower["engagement"]}%",
                      style: TextStyle(
                        fontSize: 12,
                        color: successColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
            decoration: BoxDecoration(
              color: _getInfluenceColor(follower["influence_score"] as int).withAlpha(20),
              borderRadius: BorderRadius.circular(radiusSm),
              border: Border.all(
                color: _getInfluenceColor(follower["influence_score"] as int),
              ),
            ),
            child: Text(
              "${follower["influence_score"]}",
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: _getInfluenceColor(follower["influence_score"] as int),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Color _getInfluenceColor(int score) {
    if (score >= 90) return successColor;
    if (score >= 70) return warningColor;
    return infoColor;
  }

  String _formatTimestamp(String timestamp) {
    DateTime date = DateTime.parse(timestamp);
    DateTime now = DateTime.now();
    Duration difference = now.difference(date);

    if (difference.inMinutes < 60) {
      return "${difference.inMinutes}m ago";
    } else if (difference.inHours < 24) {
      return "${difference.inHours}h ago";
    } else {
      return "${difference.inDays}d ago";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Follow Analytics"),
        actions: [
          IconButton(
            icon: Icon(showAnalytics ? Icons.analytics : Icons.analytics_outlined),
            onPressed: () {
              showAnalytics = !showAnalytics;
              setState(() {});
            },
          ),
          IconButton(
            icon: Icon(Icons.more_vert),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (showAnalytics) ...[
              Text(
                "Analytics Overview",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              SizedBox(height: spMd),
              QHorizontalScroll(
                children: analyticsData.map((data) => Container(
                  width: 200,
                  margin: EdgeInsets.only(right: spSm),
                  child: _buildAnalyticsCard(data),
                )).toList(),
              ),
              SizedBox(height: spXl),
              Text(
                "Top Followers",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              SizedBox(height: spMd),
              ...topFollowers.map((follower) => _buildTopFollowerCard(follower)).toList(),
              SizedBox(height: spXl),
            ],
            
            Row(
              children: [
                Expanded(
                  child: QTextField(
                    label: "Search activities",
                    value: searchQuery,
                    hint: "Search by user name or username",
                    onChanged: (value) {
                      searchQuery = value;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: primaryColor,
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Icon(
                    Icons.search,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
              ],
            ),
            
            SizedBox(height: spMd),
            
            QCategoryPicker(
              items: filters,
              value: selectedFilter,
              onChanged: (index, label, value, item) {
                selectedFilter = value;
                setState(() {});
              },
            ),
            
            SizedBox(height: spMd),
            
            Text(
              "Recent Activity (${filteredActivities.length})",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            
            SizedBox(height: spMd),
            
            if (filteredActivities.isEmpty)
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(spXl),
                child: Column(
                  children: [
                    Icon(
                      Icons.timeline,
                      size: 64,
                      color: disabledColor,
                    ),
                    SizedBox(height: spMd),
                    Text(
                      "No activities found",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "Try adjusting your search or filter criteria",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledColor,
                      ),
                    ),
                  ],
                ),
              )
            else
              ...filteredActivities.map((activity) => _buildActivityCard(activity)).toList(),
          ],
        ),
      ),
    );
  }
}
