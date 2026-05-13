import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class DmsSocialListeningView extends StatefulWidget {
  const DmsSocialListeningView({super.key});

  @override
  State<DmsSocialListeningView> createState() => _DmsSocialListeningViewState();
}

class _DmsSocialListeningViewState extends State<DmsSocialListeningView> {
  String selectedPlatform = "All";
  String selectedTimeframe = "7d";
  String searchKeyword = "";
  bool isLoading = false;
  int currentTab = 0;

  List<Map<String, dynamic>> platforms = [
    {"label": "All Platforms", "value": "All"},
    {"label": "Twitter", "value": "twitter"},
    {"label": "Instagram", "value": "instagram"},
    {"label": "Facebook", "value": "facebook"},
    {"label": "LinkedIn", "value": "linkedin"},
    {"label": "TikTok", "value": "tiktok"},
    {"label": "YouTube", "value": "youtube"},
  ];

  List<Map<String, dynamic>> timeframes = [
    {"label": "Last 24 Hours", "value": "24h"},
    {"label": "Last 7 Days", "value": "7d"},
    {"label": "Last 30 Days", "value": "30d"},
    {"label": "Last 90 Days", "value": "90d"},
  ];

  List<Map<String, dynamic>> mentions = [
    {
      "id": "1",
      "platform": "twitter",
      "username": "@marketing_pro",
      "content": "Just discovered this amazing marketing tool! The analytics are incredible and it's helping us track our social media performance like never before. #digitalmarketing #analytics",
      "sentiment": "positive",
      "engagement": 245,
      "followers": 12500,
      "timestamp": DateTime.now().subtract(Duration(hours: 2)),
      "verified": true,
      "location": "New York, USA",
    },
    {
      "id": "2",
      "platform": "instagram",
      "username": "@business_growth",
      "content": "The customer service experience could be better. Took them 3 days to respond to my inquiry. However, the product itself works well once you get it set up properly.",
      "sentiment": "neutral",
      "engagement": 89,
      "followers": 8300,
      "timestamp": DateTime.now().subtract(Duration(hours: 5)),
      "verified": false,
      "location": "London, UK",
    },
    {
      "id": "3",
      "platform": "facebook",
      "username": "Sarah Johnson",
      "content": "Disappointed with the recent update. Some features that I relied on are no longer available and the new interface is confusing. Hope they fix this soon.",
      "sentiment": "negative",
      "engagement": 156,
      "followers": 2100,
      "timestamp": DateTime.now().subtract(Duration(hours: 8)),
      "verified": false,
      "location": "Toronto, Canada",
    },
    {
      "id": "4",
      "platform": "linkedin",
      "username": "Michael Chen",
      "content": "Excellent ROI on our marketing campaigns since implementing this platform. The automation features save us hours every week and the reporting is comprehensive.",
      "sentiment": "positive",
      "engagement": 312,
      "followers": 15600,
      "timestamp": DateTime.now().subtract(Duration(hours: 12)),
      "verified": true,
      "location": "Singapore",
    },
  ];

  List<Map<String, dynamic>> keywords = [
    {
      "keyword": "marketing tool",
      "mentions": 1247,
      "sentiment": "positive",
      "trend": "up",
      "change": 15.3,
    },
    {
      "keyword": "analytics platform",
      "mentions": 892,
      "sentiment": "positive",
      "trend": "up",
      "change": 8.7,
    },
    {
      "keyword": "customer service",
      "mentions": 634,
      "sentiment": "neutral",
      "trend": "stable",
      "change": -1.2,
    },
    {
      "keyword": "pricing",
      "mentions": 445,
      "sentiment": "negative",
      "trend": "down",
      "change": -5.4,
    },
  ];

  List<Map<String, dynamic>> influencers = [
    {
      "username": "@marketing_guru",
      "platform": "twitter",
      "followers": 245000,
      "engagement": 4.8,
      "mentions": 12,
      "sentiment": "positive",
      "verified": true,
    },
    {
      "username": "@business_expert",
      "platform": "linkedin",
      "followers": 189000,
      "engagement": 6.2,
      "mentions": 8,
      "sentiment": "positive",
      "verified": true,
    },
    {
      "username": "@digital_nomad",
      "platform": "instagram",
      "followers": 156000,
      "engagement": 3.9,
      "mentions": 5,
      "sentiment": "neutral",
      "verified": false,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Social Listening",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Mentions", icon: Icon(Icons.chat_bubble)),
        Tab(text: "Keywords", icon: Icon(Icons.search)),
        Tab(text: "Influencers", icon: Icon(Icons.stars)),
        Tab(text: "Analytics", icon: Icon(Icons.analytics)),
      ],
      tabChildren: [
        _buildMentionsTab(),
        _buildKeywordsTab(),
        _buildInfluencersTab(),
        _buildAnalyticsTab(),
      ],
    );
  }

  Widget _buildMentionsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          _buildFiltersSection(),
          _buildSentimentOverview(),
          _buildMentionsList(),
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
                child: QTextField(
                  label: "Search keywords",
                  value: searchKeyword,
                  hint: "Enter brand, product, or keyword",
                  onChanged: (value) {
                    searchKeyword = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              QButton(
                icon: Icons.search,
                size: bs.sm,
                onPressed: () {
                  _searchMentions();
                },
              ),
            ],
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
                  label: "Timeframe",
                  items: timeframes,
                  value: selectedTimeframe,
                  onChanged: (value, label) {
                    selectedTimeframe = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSentimentOverview() {
    int totalMentions = mentions.length;
    int positiveMentions = mentions.where((m) => m["sentiment"] == "positive").length;
    int neutralMentions = mentions.where((m) => m["sentiment"] == "neutral").length;
    int negativeMentions = mentions.where((m) => m["sentiment"] == "negative").length;

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
            "Sentiment Overview",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Row(
            children: [
              Expanded(
                child: _buildSentimentCard(
                  "Positive",
                  positiveMentions,
                  totalMentions,
                  successColor,
                  Icons.sentiment_very_satisfied,
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: _buildSentimentCard(
                  "Neutral",
                  neutralMentions,
                  totalMentions,
                  warningColor,
                  Icons.sentiment_neutral,
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: _buildSentimentCard(
                  "Negative",
                  negativeMentions,
                  totalMentions,
                  dangerColor,
                  Icons.sentiment_very_dissatisfied,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSentimentCard(String label, int count, int total, Color color, IconData icon) {
    double percentage = total > 0 ? (count / total) * 100 : 0;
    
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
            "$count",
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
          Text(
            "${percentage.toStringAsFixed(1)}%",
            style: TextStyle(
              fontSize: 10,
              color: disabledColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMentionsList() {
    if (isLoading) {
      return Center(child: CircularProgressIndicator());
    }

    return Column(
      spacing: spSm,
      children: mentions.map((mention) {
        return _buildMentionCard(mention);
      }).toList(),
    );
  }

  Widget _buildMentionCard(Map<String, dynamic> mention) {
    Color sentimentColor = _getSentimentColor(mention["sentiment"]);
    IconData sentimentIcon = _getSentimentIcon(mention["sentiment"]);
    IconData platformIcon = _getPlatformIcon(mention["platform"]);

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
                "${mention["username"]}",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: primaryColor,
                ),
              ),
              if (mention["verified"] == true) ...[
                SizedBox(width: spXs),
                Icon(
                  Icons.verified,
                  color: infoColor,
                  size: 16,
                ),
              ],
              Spacer(),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                decoration: BoxDecoration(
                  color: sentimentColor,
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      sentimentIcon,
                      color: Colors.white,
                      size: 12,
                    ),
                    SizedBox(width: 2),
                    Text(
                      "${mention["sentiment"]}".toUpperCase(),
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
          Text(
            "${mention["content"]}",
            style: TextStyle(
              fontSize: 14,
              color: primaryColor,
              height: 1.4,
            ),
          ),
          Row(
            children: [
              Icon(
                Icons.favorite,
                color: disabledBoldColor,
                size: 16,
              ),
              SizedBox(width: spXs),
              Text(
                "${mention["engagement"]}",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
              SizedBox(width: spSm),
              Icon(
                Icons.people,
                color: disabledBoldColor,
                size: 16,
              ),
              SizedBox(width: spXs),
              Text(
                "${((mention["followers"] as int) / 1000).toStringAsFixed(1)}K",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
              SizedBox(width: spSm),
              Icon(
                Icons.location_on,
                color: disabledBoldColor,
                size: 16,
              ),
              SizedBox(width: spXs),
              Text(
                "${mention["location"]}",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
              Spacer(),
              Text(
                "${(mention["timestamp"] as DateTime).dMMMy}",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildKeywordsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          _buildKeywordOverview(),
          _buildKeywordsList(),
        ],
      ),
    );
  }

  Widget _buildKeywordOverview() {
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
            "Keyword Performance",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Row(
            children: [
              Expanded(
                child: _buildKeywordMetric(
                  "Total Keywords",
                  "${keywords.length}",
                  Icons.search,
                  primaryColor,
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: _buildKeywordMetric(
                  "Total Mentions",
                  "${keywords.map((k) => k["mentions"] as int).reduce((a, b) => a + b)}",
                  Icons.chat_bubble,
                  infoColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildKeywordMetric(String label, String value, IconData icon, Color color) {
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
            size: 24,
          ),
          SizedBox(width: spSm),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
          ),
        ],
      ),
    );
  }

  Widget _buildKeywordsList() {
    return Column(
      spacing: spSm,
      children: keywords.map((keyword) {
        return _buildKeywordCard(keyword);
      }).toList(),
    );
  }

  Widget _buildKeywordCard(Map<String, dynamic> keyword) {
    Color trendColor = _getTrendColor(keyword["trend"]);
    IconData trendIcon = _getTrendIcon(keyword["trend"]);
    Color sentimentColor = _getSentimentColor(keyword["sentiment"]);

    return Container(
      padding: EdgeInsets.all(spSm),
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${keyword["keyword"]}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "${keyword["mentions"]} mentions",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: sentimentColor,
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Text(
                  "${keyword["sentiment"]}".toUpperCase(),
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Icon(
                trendIcon,
                color: trendColor,
                size: 16,
              ),
              SizedBox(width: spXs),
              Text(
                "${(keyword["change"] as double) >= 0 ? '+' : ''}${(keyword["change"] as double).toStringAsFixed(1)}%",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: trendColor,
                ),
              ),
              SizedBox(width: spSm),
              Text(
                "vs last period",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledColor,
                ),
              ),
              Spacer(),
              QButton(
                icon: Icons.analytics,
                size: bs.sm,
                onPressed: () {
                  _viewKeywordDetails(keyword);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInfluencersTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          _buildInfluencerOverview(),
          _buildInfluencersList(),
        ],
      ),
    );
  }

  Widget _buildInfluencerOverview() {
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
            "Top Influencers",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Text(
            "Influencers mentioning your brand or keywords",
            style: TextStyle(
              fontSize: 14,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfluencersList() {
    return Column(
      spacing: spSm,
      children: influencers.map((influencer) {
        return _buildInfluencerCard(influencer);
      }).toList(),
    );
  }

  Widget _buildInfluencerCard(Map<String, dynamic> influencer) {
    IconData platformIcon = _getPlatformIcon(influencer["platform"]);
    Color sentimentColor = _getSentimentColor(influencer["sentiment"]);

    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Row(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: primaryColor,
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Icon(
              Icons.person,
              color: Colors.white,
              size: 24,
            ),
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      platformIcon,
                      color: primaryColor,
                      size: 16,
                    ),
                    SizedBox(width: spXs),
                    Text(
                      "${influencer["username"]}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    if (influencer["verified"] == true) ...[
                      SizedBox(width: spXs),
                      Icon(
                        Icons.verified,
                        color: infoColor,
                        size: 16,
                      ),
                    ],
                  ],
                ),
                SizedBox(height: spXs),
                Row(
                  children: [
                    Text(
                      "${((influencer["followers"] as int) / 1000).toStringAsFixed(0)}K followers",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(width: spSm),
                    Text(
                      "${(influencer["engagement"] as double).toStringAsFixed(1)}% engagement",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spXs),
                Row(
                  children: [
                    Text(
                      "${influencer["mentions"]} mentions",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(width: spSm),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                      decoration: BoxDecoration(
                        color: sentimentColor,
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Text(
                        "${influencer["sentiment"]}".toUpperCase(),
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          QButton(
            icon: Icons.person_add,
            size: bs.sm,
            onPressed: () {
              _followInfluencer(influencer);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildAnalyticsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          _buildAnalyticsOverview(),
          _buildEngagementChart(),
          _buildPlatformBreakdown(),
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
                  "Total Mentions",
                  "3,218",
                  Icons.chat_bubble,
                  primaryColor,
                  "+12.5%",
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: _buildAnalyticsCard(
                  "Reach",
                  "847K",
                  Icons.visibility,
                  infoColor,
                  "+8.3%",
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: _buildAnalyticsCard(
                  "Sentiment Score",
                  "73%",
                  Icons.sentiment_satisfied,
                  successColor,
                  "+5.2%",
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: _buildAnalyticsCard(
                  "Influencers",
                  "${influencers.length}",
                  Icons.stars,
                  warningColor,
                  "+2",
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAnalyticsCard(String title, String value, IconData icon, Color color, String change) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: color.withAlpha(20),
        borderRadius: BorderRadius.circular(radiusSm),
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
                change,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: successColor,
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Text(
            value,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          Text(
            title,
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEngagementChart() {
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
                    "Engagement Chart",
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

  Widget _buildPlatformBreakdown() {
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
            "Platform Breakdown",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          _buildPlatformItem("Twitter", 1247, 38.7, Icons.alternate_email),
          _buildPlatformItem("Instagram", 892, 27.6, Icons.camera_alt),
          _buildPlatformItem("Facebook", 634, 19.7, Icons.facebook),
          _buildPlatformItem("LinkedIn", 445, 13.8, Icons.business),
        ],
      ),
    );
  }

  Widget _buildPlatformItem(String platform, int mentions, double percentage, IconData icon) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: primaryColor.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            color: primaryColor,
            size: 20,
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  platform,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "$mentions mentions",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
          Text(
            "${percentage.toStringAsFixed(1)}%",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
        ],
      ),
    );
  }

  Color _getSentimentColor(String sentiment) {
    switch (sentiment) {
      case "positive":
        return successColor;
      case "negative":
        return dangerColor;
      case "neutral":
        return warningColor;
      default:
        return disabledBoldColor;
    }
  }

  IconData _getSentimentIcon(String sentiment) {
    switch (sentiment) {
      case "positive":
        return Icons.sentiment_very_satisfied;
      case "negative":
        return Icons.sentiment_very_dissatisfied;
      case "neutral":
        return Icons.sentiment_neutral;
      default:
        return Icons.sentiment_neutral;
    }
  }

  IconData _getPlatformIcon(String platform) {
    switch (platform) {
      case "twitter":
        return Icons.alternate_email;
      case "instagram":
        return Icons.camera_alt;
      case "facebook":
        return Icons.facebook;
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

  Color _getTrendColor(String trend) {
    switch (trend) {
      case "up":
        return successColor;
      case "down":
        return dangerColor;
      case "stable":
        return warningColor;
      default:
        return disabledBoldColor;
    }
  }

  IconData _getTrendIcon(String trend) {
    switch (trend) {
      case "up":
        return Icons.trending_up;
      case "down":
        return Icons.trending_down;
      case "stable":
        return Icons.trending_flat;
      default:
        return Icons.trending_flat;
    }
  }

  void _searchMentions() {
    isLoading = true;
    setState(() {});
    
    Future.delayed(Duration(seconds: 2), () {
      isLoading = false;
      setState(() {});
      ss("Search completed");
    });
  }

  void _viewKeywordDetails(Map<String, dynamic> keyword) {
    si("Viewing details for ${keyword["keyword"]}");
  }

  void _followInfluencer(Map<String, dynamic> influencer) {
    ss("Following ${influencer["username"]}");
  }
}
