import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class DmsEngagementTrackingView extends StatefulWidget {
  const DmsEngagementTrackingView({super.key});

  @override
  State<DmsEngagementTrackingView> createState() => _DmsEngagementTrackingViewState();
}

class _DmsEngagementTrackingViewState extends State<DmsEngagementTrackingView> {
  String selectedPlatform = "All";
  String selectedPeriod = "7d";
  String selectedMetric = "engagement_rate";
  bool isLoading = false;
  int currentTab = 0;

  List<Map<String, dynamic>> platforms = [
    {"label": "All Platforms", "value": "All"},
    {"label": "Instagram", "value": "instagram"},
    {"label": "Facebook", "value": "facebook"},
    {"label": "Twitter", "value": "twitter"},
    {"label": "LinkedIn", "value": "linkedin"},
    {"label": "TikTok", "value": "tiktok"},
  ];

  List<Map<String, dynamic>> periods = [
    {"label": "Last 24 Hours", "value": "24h"},
    {"label": "Last 7 Days", "value": "7d"},
    {"label": "Last 30 Days", "value": "30d"},
    {"label": "Last 90 Days", "value": "90d"},
  ];

  List<Map<String, dynamic>> metrics = [
    {"label": "Engagement Rate", "value": "engagement_rate"},
    {"label": "Reach", "value": "reach"},
    {"label": "Impressions", "value": "impressions"},
    {"label": "Clicks", "value": "clicks"},
  ];

  List<Map<String, dynamic>> posts = [
    {
      "id": "1",
      "platform": "instagram",
      "content": "Our latest product launch is here! Discover the innovation that will transform your workflow. #ProductLaunch #Innovation",
      "image": "https://picsum.photos/400/300?random=1&keyword=product",
      "timestamp": DateTime.now().subtract(Duration(hours: 6)),
      "likes": 1247,
      "comments": 89,
      "shares": 156,
      "impressions": 45820,
      "reach": 32145,
      "engagement_rate": 3.2,
      "clicks": 234,
    },
    {
      "id": "2",
      "platform": "facebook",
      "content": "Tips for boosting your social media presence: 1. Post consistently 2. Engage with your audience 3. Use relevant hashtags 4. Share valuable content",
      "image": "https://picsum.photos/400/300?random=2&keyword=social",
      "timestamp": DateTime.now().subtract(Duration(hours: 12)),
      "likes": 892,
      "comments": 67,
      "shares": 234,
      "impressions": 38765,
      "reach": 28934,
      "engagement_rate": 4.1,
      "clicks": 189,
    },
    {
      "id": "3",
      "platform": "twitter",
      "content": "Excited to announce our partnership with leading industry experts! Together, we're building the future of digital marketing. 🚀",
      "image": "https://picsum.photos/400/300?random=3&keyword=partnership",
      "timestamp": DateTime.now().subtract(Duration(hours: 18)),
      "likes": 634,
      "comments": 45,
      "shares": 123,
      "impressions": 25670,
      "reach": 19345,
      "engagement_rate": 4.8,
      "clicks": 156,
    },
    {
      "id": "4",
      "platform": "linkedin",
      "content": "Industry insights: The future of marketing automation and how AI is transforming customer engagement strategies.",
      "image": "https://picsum.photos/400/300?random=4&keyword=automation",
      "timestamp": DateTime.now().subtract(Duration(days: 1)),
      "likes": 445,
      "comments": 32,
      "shares": 89,
      "impressions": 18234,
      "reach": 14567,
      "engagement_rate": 3.9,
      "clicks": 98,
    },
  ];

  List<Map<String, dynamic>> engagementMetrics = [
    {
      "metric": "Total Engagements",
      "value": 8756,
      "change": 12.5,
      "icon": Icons.favorite,
      "color": Colors.red,
    },
    {
      "metric": "Avg Engagement Rate",
      "value": 4.0,
      "change": 8.3,
      "icon": Icons.show_chart,
      "color": Colors.blue,
    },
    {
      "metric": "Total Reach",
      "value": 94991,
      "change": -2.1,
      "icon": Icons.visibility,
      "color": Colors.green,
    },
    {
      "metric": "Total Clicks",
      "value": 677,
      "change": 15.7,
      "icon": Icons.touch_app,
      "color": Colors.orange,
    },
  ];

  List<Map<String, dynamic>> topPosts = [
    {
      "platform": "twitter",
      "content": "Excited to announce our partnership...",
      "engagement_rate": 4.8,
      "engagements": 802,
    },
    {
      "platform": "facebook",
      "content": "Tips for boosting your social media...",
      "engagement_rate": 4.1,
      "engagements": 1193,
    },
    {
      "platform": "linkedin",
      "content": "Industry insights: The future of...",
      "engagement_rate": 3.9,
      "engagements": 566,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Engagement Tracking",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Overview", icon: Icon(Icons.dashboard)),
        Tab(text: "Posts", icon: Icon(Icons.article)),
        Tab(text: "Analytics", icon: Icon(Icons.analytics)),
        Tab(text: "Reports", icon: Icon(Icons.assessment)),
      ],
      tabChildren: [
        _buildOverviewTab(),
        _buildPostsTab(),
        _buildAnalyticsTab(),
        _buildReportsTab(),
      ],
    );
  }

  Widget _buildOverviewTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          _buildFiltersSection(),
          _buildEngagementMetricsGrid(),
          _buildTopPerformingPosts(),
          _buildEngagementTrendChart(),
        ],
      ),
    );
  }

  Widget _buildFiltersSection() {
    return Container(
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
                child: QDropdownField(
                  label: "Platform",
                  items: platforms,
                  value: selectedPlatform,
                  onChanged: (value, label) {
                    selectedPlatform = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QDropdownField(
                  label: "Period",
                  items: periods,
                  value: selectedPeriod,
                  onChanged: (value, label) {
                    selectedPeriod = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
          QDropdownField(
            label: "Primary Metric",
            items: metrics,
            value: selectedMetric,
            onChanged: (value, label) {
              selectedMetric = value;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  Widget _buildEngagementMetricsGrid() {
    return ResponsiveGridView(
      padding: EdgeInsets.zero,
      minItemWidth: 200,
      children: engagementMetrics.map((metric) {
        return _buildMetricCard(metric);
      }).toList(),
    );
  }

  Widget _buildMetricCard(Map<String, dynamic> metric) {
    bool isPositive = (metric["change"] as double) >= 0;
    String formattedValue;
    
    if (metric["metric"] == "Avg Engagement Rate") {
      formattedValue = "${(metric["value"] as double).toStringAsFixed(1)}%";
    } else if (metric["value"] is int && (metric["value"] as int) > 1000) {
      formattedValue = "${((metric["value"] as int) / 1000).toStringAsFixed(1)}K";
    } else {
      formattedValue = "${metric["value"]}";
    }

    return Container(
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
              Container(
                padding: EdgeInsets.all(spXs),
                decoration: BoxDecoration(
                  color: (metric["color"] as Color).withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Icon(
                  metric["icon"],
                  color: metric["color"],
                  size: 20,
                ),
              ),
              Spacer(),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                decoration: BoxDecoration(
                  color: isPositive ? successColor : dangerColor,
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      isPositive ? Icons.trending_up : Icons.trending_down,
                      color: Colors.white,
                      size: 12,
                    ),
                    SizedBox(width: 2),
                    Text(
                      "${isPositive ? '+' : ''}${(metric["change"] as double).toStringAsFixed(1)}%",
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Text(
            formattedValue,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Text(
            "${metric["metric"]}",
            style: TextStyle(
              fontSize: 14,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTopPerformingPosts() {
    return Container(
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
          Row(
            children: [
              Text(
                "Top Performing Posts",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Spacer(),
              QButton(
                label: "View All",
                size: bs.sm,
                onPressed: () {
                  setState(() {
                    currentTab = 1;
                  });
                },
              ),
            ],
          ),
          ...topPosts.map((post) => _buildTopPostItem(post)),
        ],
      ),
    );
  }

  Widget _buildTopPostItem(Map<String, dynamic> post) {
    IconData platformIcon = _getPlatformIcon(post["platform"]);

    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: primaryColor.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(spXs),
            decoration: BoxDecoration(
              color: primaryColor,
              borderRadius: BorderRadius.circular(radiusXs),
            ),
            child: Icon(
              platformIcon,
              color: Colors.white,
              size: 16,
            ),
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${post["content"]}",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spXs),
                Text(
                  "${post["engagements"]} engagements • ${(post["engagement_rate"] as double).toStringAsFixed(1)}% rate",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
          Icon(
            Icons.star,
            color: warningColor,
            size: 16,
          ),
        ],
      ),
    );
  }

  Widget _buildEngagementTrendChart() {
    return Container(
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
            "Engagement Trends",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Container(
            height: 200,
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(10),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.show_chart,
                    color: primaryColor,
                    size: 48,
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "Engagement Trend Chart",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: primaryColor,
                    ),
                  ),
                  Text(
                    "Visual representation of engagement over time",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPostsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          _buildPostsHeader(),
          _buildPostsList(),
        ],
      ),
    );
  }

  Widget _buildPostsHeader() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "All Posts",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "${posts.length} posts tracked",
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
          QButton(
            icon: Icons.filter_list,
            size: bs.sm,
            onPressed: () {
              _showPostFilters();
            },
          ),
        ],
      ),
    );
  }

  Widget _buildPostsList() {
    if (isLoading) {
      return Center(child: CircularProgressIndicator());
    }

    return Column(
      spacing: spSm,
      children: posts.map((post) {
        return _buildPostCard(post);
      }).toList(),
    );
  }

  Widget _buildPostCard(Map<String, dynamic> post) {
    IconData platformIcon = _getPlatformIcon(post["platform"]);
    double engagementRate = post["engagement_rate"];
    int totalEngagements = (post["likes"] as int) + (post["comments"] as int) + (post["shares"] as int);

    return Container(
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
          Row(
            children: [
              Icon(
                platformIcon,
                color: primaryColor,
                size: 20,
              ),
              SizedBox(width: spXs),
              Text(
                "${post["platform"]}".toUpperCase(),
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: primaryColor,
                ),
              ),
              Spacer(),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                decoration: BoxDecoration(
                  color: _getEngagementColor(engagementRate),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "${engagementRate.toStringAsFixed(1)}%",
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          Text(
            "${post["content"]}",
            style: TextStyle(
              fontSize: 14,
              color: primaryColor,
              height: 1.4,
            ),
          ),
          if (post["image"] != null) ...[
            ClipRRect(
              borderRadius: BorderRadius.circular(radiusSm),
              child: Image.network(
                "${post["image"]}",
                height: 150,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
          ],
          Row(
            children: [
              _buildEngagementItem(Icons.favorite, post["likes"], Colors.red),
              SizedBox(width: spSm),
              _buildEngagementItem(Icons.chat_bubble, post["comments"], Colors.blue),
              SizedBox(width: spSm),
              _buildEngagementItem(Icons.share, post["shares"], Colors.green),
              Spacer(),
              Text(
                "${(post["timestamp"] as DateTime).dMMMy}",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledColor,
                ),
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(10),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Row(
              children: [
                Expanded(
                  child: _buildMetricItem("Reach", "${((post["reach"] as int) / 1000).toStringAsFixed(1)}K"),
                ),
                Expanded(
                  child: _buildMetricItem("Impressions", "${((post["impressions"] as int) / 1000).toStringAsFixed(1)}K"),
                ),
                Expanded(
                  child: _buildMetricItem("Clicks", "${post["clicks"]}"),
                ),
                Expanded(
                  child: _buildMetricItem("Total", "$totalEngagements"),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEngagementItem(IconData icon, dynamic count, Color color) {
    return Row(
      children: [
        Icon(
          icon,
          color: color,
          size: 16,
        ),
        SizedBox(width: spXs),
        Text(
          "$count",
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: primaryColor,
          ),
        ),
      ],
    );
  }

  Widget _buildMetricItem(String label, String value) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 10,
            color: disabledBoldColor,
          ),
        ),
      ],
    );
  }

  Widget _buildAnalyticsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          _buildAnalyticsOverview(),
          _buildPlatformComparison(),
          _buildEngagementBreakdown(),
          _buildPerformanceInsights(),
        ],
      ),
    );
  }

  Widget _buildAnalyticsOverview() {
    return Container(
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
            "Analytics Overview",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Row(
            children: [
              Expanded(
                child: _buildAnalyticsCard(
                  "Best Performing Day",
                  "Monday",
                  Icons.calendar_today,
                  primaryColor,
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: _buildAnalyticsCard(
                  "Peak Hour",
                  "3:00 PM",
                  Icons.schedule,
                  infoColor,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: _buildAnalyticsCard(
                  "Top Platform",
                  "Instagram",
                  Icons.camera_alt,
                  warningColor,
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: _buildAnalyticsCard(
                  "Avg Response Time",
                  "2.5 hours",
                  Icons.timer,
                  successColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAnalyticsCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: color.withAlpha(20),
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Column(
        children: [
          Icon(
            icon,
            color: color,
            size: 24,
          ),
          SizedBox(height: spXs),
          Text(
            value,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: color,
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

  Widget _buildPlatformComparison() {
    List<Map<String, dynamic>> platformData = [
      {"platform": "Instagram", "engagement": 3.2, "posts": 15, "reach": 45820},
      {"platform": "Facebook", "engagement": 4.1, "posts": 12, "reach": 38765},
      {"platform": "Twitter", "engagement": 4.8, "posts": 8, "reach": 25670},
      {"platform": "LinkedIn", "engagement": 3.9, "posts": 5, "reach": 18234},
    ];

    return Container(
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
            "Platform Comparison",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          ...platformData.map((platform) => _buildPlatformComparisonItem(platform)),
        ],
      ),
    );
  }

  Widget _buildPlatformComparisonItem(Map<String, dynamic> platform) {
    IconData platformIcon = _getPlatformIcon(platform["platform"].toString().toLowerCase());

    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: primaryColor.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Row(
        children: [
          Icon(
            platformIcon,
            color: primaryColor,
            size: 20,
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Text(
              "${platform["platform"]}",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: primaryColor,
              ),
            ),
          ),
          _buildPlatformMetric("${(platform["engagement"] as double).toStringAsFixed(1)}%", "Engagement"),
          SizedBox(width: spSm),
          _buildPlatformMetric("${platform["posts"]}", "Posts"),
          SizedBox(width: spSm),
          _buildPlatformMetric("${((platform["reach"] as int) / 1000).toStringAsFixed(1)}K", "Reach"),
        ],
      ),
    );
  }

  Widget _buildPlatformMetric(String value, String label) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 10,
            color: disabledBoldColor,
          ),
        ),
      ],
    );
  }

  Widget _buildEngagementBreakdown() {
    return Container(
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
            "Engagement Breakdown",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Row(
            children: [
              Expanded(
                child: _buildEngagementBreakdownItem("Likes", 3218, Colors.red, Icons.favorite),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: _buildEngagementBreakdownItem("Comments", 233, Colors.blue, Icons.chat_bubble),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: _buildEngagementBreakdownItem("Shares", 602, Colors.green, Icons.share),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: _buildEngagementBreakdownItem("Clicks", 677, Colors.orange, Icons.touch_app),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildEngagementBreakdownItem(String label, int value, Color color, IconData icon) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: color.withAlpha(20),
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            color: color,
            size: 20,
          ),
          SizedBox(width: spSm),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "${(value / 1000).toStringAsFixed(1)}K",
                style: TextStyle(
                  fontSize: 16,
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
          ),
        ],
      ),
    );
  }

  Widget _buildPerformanceInsights() {
    List<Map<String, dynamic>> insights = [
      {
        "title": "Best Posting Time",
        "description": "Your audience is most active between 2-4 PM on weekdays",
        "icon": Icons.schedule,
        "color": successColor,
      },
      {
        "title": "Content Performance",
        "description": "Image posts generate 65% more engagement than text-only posts",
        "icon": Icons.image,
        "color": infoColor,
      },
      {
        "title": "Hashtag Impact",
        "description": "Posts with 5-10 hashtags perform best on Instagram",
        "icon": Icons.tag,
        "color": warningColor,
      },
    ];

    return Container(
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
            "Performance Insights",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          ...insights.map((insight) => _buildInsightItem(insight)),
        ],
      ),
    );
  }

  Widget _buildInsightItem(Map<String, dynamic> insight) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: (insight["color"] as Color).withAlpha(20),
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(spXs),
            decoration: BoxDecoration(
              color: insight["color"],
              borderRadius: BorderRadius.circular(radiusXs),
            ),
            child: Icon(
              insight["icon"],
              color: Colors.white,
              size: 16,
            ),
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${insight["title"]}",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spXs),
                Text(
                  "${insight["description"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReportsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          _buildReportsHeader(),
          _buildQuickReports(),
          _buildCustomReports(),
          _buildExportOptions(),
        ],
      ),
    );
  }

  Widget _buildReportsHeader() {
    return Container(
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
            "Reports & Analytics",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spXs),
          Text(
            "Generate detailed reports and export your engagement data",
            style: TextStyle(
              fontSize: 14,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickReports() {
    List<Map<String, dynamic>> quickReports = [
      {
        "title": "Weekly Summary",
        "description": "Engagement overview for the past 7 days",
        "icon": Icons.calendar_view_week,
        "period": "7 days",
      },
      {
        "title": "Monthly Report",
        "description": "Comprehensive monthly engagement analysis",
        "icon": Icons.calendar_view_month,
        "period": "30 days",
      },
      {
        "title": "Platform Comparison",
        "description": "Performance comparison across all platforms",
        "icon": Icons.compare,
        "period": "All time",
      },
    ];

    return Container(
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
            "Quick Reports",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          ...quickReports.map((report) => _buildQuickReportItem(report)),
        ],
      ),
    );
  }

  Widget _buildQuickReportItem(Map<String, dynamic> report) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: primaryColor.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Row(
        children: [
          Icon(
            report["icon"],
            color: primaryColor,
            size: 24,
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${report["title"]}",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spXs),
                Text(
                  "${report["description"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
                Text(
                  "${report["period"]}",
                  style: TextStyle(
                    fontSize: 10,
                    color: disabledColor,
                  ),
                ),
              ],
            ),
          ),
          QButton(
            label: "Generate",
            size: bs.sm,
            onPressed: () {
              _generateQuickReport(report);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildCustomReports() {
    return Container(
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
            "Custom Reports",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Text(
            "Create custom reports with specific metrics and date ranges",
            style: TextStyle(
              fontSize: 14,
              color: disabledBoldColor,
            ),
          ),
          SizedBox(height: spSm),
          Container(
            width: double.infinity,
            child: QButton(
              label: "Create Custom Report",
              size: bs.md,
              icon: Icons.add,
              onPressed: () {
                _createCustomReport();
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildExportOptions() {
    List<Map<String, dynamic>> exportOptions = [
      {
        "title": "Export to CSV",
        "description": "Export engagement data in CSV format",
        "icon": Icons.table_chart,
        "format": "CSV",
      },
      {
        "title": "Export to PDF",
        "description": "Generate PDF report with charts and insights",
        "icon": Icons.picture_as_pdf,
        "format": "PDF",
      },
      {
        "title": "Export to Excel",
        "description": "Export detailed data in Excel format",
        "icon": Icons.grid_on,
        "format": "XLSX",
      },
    ];

    return Container(
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
            "Export Options",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          ...exportOptions.map((option) => _buildExportOptionItem(option)),
        ],
      ),
    );
  }

  Widget _buildExportOptionItem(Map<String, dynamic> option) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: primaryColor.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Row(
        children: [
          Icon(
            option["icon"],
            color: primaryColor,
            size: 20,
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${option["title"]}",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "${option["description"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
          QButton(
            label: "Export",
            size: bs.sm,
            onPressed: () {
              _exportData(option["format"]);
            },
          ),
        ],
      ),
    );
  }

  IconData _getPlatformIcon(String platform) {
    switch (platform.toLowerCase()) {
      case "instagram":
        return Icons.camera_alt;
      case "facebook":
        return Icons.facebook;
      case "twitter":
        return Icons.alternate_email;
      case "linkedin":
        return Icons.business;
      case "tiktok":
        return Icons.music_note;
      case "youtube":
        return Icons.play_circle;
      default:
        return Icons.public;
    }
  }

  Color _getEngagementColor(double rate) {
    if (rate >= 4.0) return successColor;
    if (rate >= 2.0) return warningColor;
    return dangerColor;
  }

  void _showPostFilters() {
    si("Showing post filters");
  }

  void _generateQuickReport(Map<String, dynamic> report) {
    ss("Generating ${report["title"]}...");
  }

  void _createCustomReport() {
    si("Opening custom report builder");
  }

  void _exportData(String format) {
    ss("Exporting data in $format format");
  }
}
