import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class DmsInfluencerManagementView extends StatefulWidget {
  const DmsInfluencerManagementView({super.key});

  @override
  State<DmsInfluencerManagementView> createState() => _DmsInfluencerManagementViewState();
}

class _DmsInfluencerManagementViewState extends State<DmsInfluencerManagementView> {
  String searchQuery = "";
  String selectedCategory = "All";
  String selectedFollowerRange = "All";
  String selectedStatus = "All";
  bool isLoading = false;
  int currentTab = 0;

  List<Map<String, dynamic>> categories = [
    {"label": "All Categories", "value": "All"},
    {"label": "Fashion & Beauty", "value": "fashion"},
    {"label": "Technology", "value": "tech"},
    {"label": "Fitness & Health", "value": "fitness"},
    {"label": "Food & Lifestyle", "value": "food"},
    {"label": "Business", "value": "business"},
    {"label": "Travel", "value": "travel"},
  ];

  List<Map<String, dynamic>> followerRanges = [
    {"label": "All Ranges", "value": "All"},
    {"label": "1K - 10K (Nano)", "value": "nano"},
    {"label": "10K - 100K (Micro)", "value": "micro"},
    {"label": "100K - 1M (Macro)", "value": "macro"},
    {"label": "1M+ (Mega)", "value": "mega"},
  ];

  List<Map<String, dynamic>> statusOptions = [
    {"label": "All Status", "value": "All"},
    {"label": "Active Campaign", "value": "active"},
    {"label": "Pending Outreach", "value": "pending"},
    {"label": "Negotiating", "value": "negotiating"},
    {"label": "Completed", "value": "completed"},
  ];

  List<Map<String, dynamic>> influencers = [
    {
      "id": "1",
      "name": "Sarah Johnson",
      "username": "@sarah_lifestyle",
      "email": "sarah@example.com",
      "platform": "instagram",
      "followers": 245000,
      "engagement_rate": 4.8,
      "category": "fashion",
      "verified": true,
      "location": "New York, USA",
      "status": "active",
      "campaign": "Summer Collection 2024",
      "rate": 2500,
      "last_post": DateTime.now().subtract(Duration(hours: 6)),
      "total_campaigns": 12,
      "rating": 4.9,
      "image": "https://picsum.photos/100/100?random=1&keyword=woman",
    },
    {
      "id": "2",
      "name": "Mike Chen",
      "username": "@tech_reviewer_mike",
      "email": "mike@example.com",
      "platform": "youtube",
      "followers": 156000,
      "engagement_rate": 6.2,
      "category": "tech",
      "verified": true,
      "location": "San Francisco, USA",
      "status": "pending",
      "campaign": "Product Launch Review",
      "rate": 3200,
      "last_post": DateTime.now().subtract(Duration(hours: 12)),
      "total_campaigns": 8,
      "rating": 4.7,
      "image": "https://picsum.photos/100/100?random=2&keyword=man",
    },
    {
      "id": "3",
      "name": "Emma Fitness",
      "username": "@emma_fit_life",
      "email": "emma@example.com",
      "platform": "instagram",
      "followers": 89000,
      "engagement_rate": 5.1,
      "category": "fitness",
      "verified": false,
      "location": "Los Angeles, USA",
      "status": "negotiating",
      "campaign": "Wellness Challenge",
      "rate": 1800,
      "last_post": DateTime.now().subtract(Duration(hours: 18)),
      "total_campaigns": 15,
      "rating": 4.6,
      "image": "https://picsum.photos/100/100?random=3&keyword=fitness",
    },
    {
      "id": "4",
      "name": "David Travel",
      "username": "@wanderlust_david",
      "email": "david@example.com",
      "platform": "tiktok",
      "followers": 378000,
      "engagement_rate": 7.3,
      "category": "travel",
      "verified": true,
      "location": "London, UK",
      "status": "completed",
      "campaign": "Destination Campaign",
      "rate": 4500,
      "last_post": DateTime.now().subtract(Duration(days: 1)),
      "total_campaigns": 22,
      "rating": 4.8,
      "image": "https://picsum.photos/100/100?random=4&keyword=travel",
    },
  ];

  List<Map<String, dynamic>> campaigns = [
    {
      "id": "1",
      "name": "Summer Collection 2024",
      "status": "active",
      "start_date": DateTime.now().subtract(Duration(days: 10)),
      "end_date": DateTime.now().add(Duration(days: 20)),
      "budget": 15000,
      "spent": 8500,
      "influencers": 5,
      "posts": 12,
      "impressions": 1234567,
      "engagement": 89432,
    },
    {
      "id": "2",
      "name": "Product Launch Review",
      "status": "pending",
      "start_date": DateTime.now().add(Duration(days: 5)),
      "end_date": DateTime.now().add(Duration(days: 35)),
      "budget": 12000,
      "spent": 0,
      "influencers": 3,
      "posts": 0,
      "impressions": 0,
      "engagement": 0,
    },
    {
      "id": "3",
      "name": "Wellness Challenge",
      "status": "negotiating",
      "start_date": DateTime.now().add(Duration(days: 15)),
      "end_date": DateTime.now().add(Duration(days: 45)),
      "budget": 8000,
      "spent": 1200,
      "influencers": 2,
      "posts": 3,
      "impressions": 234567,
      "engagement": 18765,
    },
  ];

  List<Map<String, dynamic>> get filteredInfluencers {
    return influencers.where((influencer) {
      bool matchesSearch = influencer["name"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
          influencer["username"].toString().toLowerCase().contains(searchQuery.toLowerCase());
      bool matchesCategory = selectedCategory == "All" || influencer["category"] == selectedCategory;
      bool matchesFollowerRange = selectedFollowerRange == "All" || _matchesFollowerRange(influencer["followers"], selectedFollowerRange);
      bool matchesStatus = selectedStatus == "All" || influencer["status"] == selectedStatus;
      return matchesSearch && matchesCategory && matchesFollowerRange && matchesStatus;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Influencer Management",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Influencers", icon: Icon(Icons.people)),
        Tab(text: "Campaigns", icon: Icon(Icons.campaign)),
        Tab(text: "Discovery", icon: Icon(Icons.search)),
        Tab(text: "Analytics", icon: Icon(Icons.analytics)),
      ],
      tabChildren: [
        _buildInfluencersTab(),
        _buildCampaignsTab(),
        _buildDiscoveryTab(),
        _buildAnalyticsTab(),
      ],
    );
  }

  Widget _buildInfluencersTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          _buildInfluencersHeader(),
          _buildInfluencersFilters(),
          _buildInfluencersList(),
        ],
      ),
    );
  }

  Widget _buildInfluencersHeader() {
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
                  "My Influencers",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "${influencers.length} influencers in database",
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
          QButton(
            icon: Icons.person_add,
            size: bs.sm,
            onPressed: () {
              _addNewInfluencer();
            },
          ),
        ],
      ),
    );
  }

  Widget _buildInfluencersFilters() {
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
                child: QTextField(
                  label: "Search influencers",
                  value: searchQuery,
                  hint: "Name, username, or email",
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
                  setState(() {});
                },
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: QDropdownField(
                  label: "Category",
                  items: categories,
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
                  label: "Followers",
                  items: followerRanges,
                  value: selectedFollowerRange,
                  onChanged: (value, label) {
                    selectedFollowerRange = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
          QDropdownField(
            label: "Status",
            items: statusOptions,
            value: selectedStatus,
            onChanged: (value, label) {
              selectedStatus = value;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  Widget _buildInfluencersList() {
    if (isLoading) {
      return Center(child: CircularProgressIndicator());
    }

    return Column(
      spacing: spSm,
      children: filteredInfluencers.map((influencer) {
        return _buildInfluencerCard(influencer);
      }).toList(),
    );
  }

  Widget _buildInfluencerCard(Map<String, dynamic> influencer) {
    IconData platformIcon = _getPlatformIcon(influencer["platform"]);
    Color statusColor = _getStatusColor(influencer["status"]);

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
              ClipRRect(
                borderRadius: BorderRadius.circular(radiusSm),
                child: Image.network(
                  "${influencer["image"]}",
                  width: 60,
                  height: 60,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          "${influencer["name"]}",
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
                            fontSize: 14,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      "${influencer["location"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledColor,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                decoration: BoxDecoration(
                  color: statusColor,
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "${influencer["status"]}".toUpperCase(),
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
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
                  child: _buildInfluencerMetric(
                    "Followers",
                    "${((influencer["followers"] as int) / 1000).toStringAsFixed(0)}K",
                    Icons.people,
                  ),
                ),
                Expanded(
                  child: _buildInfluencerMetric(
                    "Engagement",
                    "${(influencer["engagement_rate"] as double).toStringAsFixed(1)}%",
                    Icons.favorite,
                  ),
                ),
                Expanded(
                  child: _buildInfluencerMetric(
                    "Rate",
                    "\$${influencer["rate"]}",
                    Icons.monetization_on,
                  ),
                ),
                Expanded(
                  child: _buildInfluencerMetric(
                    "Rating",
                    "${(influencer["rating"] as double).toStringAsFixed(1)}",
                    Icons.star,
                  ),
                ),
              ],
            ),
          ),
          if (influencer["status"] == "active") ...[
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: successColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.campaign,
                    color: successColor,
                    size: 16,
                  ),
                  SizedBox(width: spXs),
                  Expanded(
                    child: Text(
                      "Current: ${influencer["campaign"]}",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: successColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Last post: ${(influencer["last_post"] as DateTime).dMMMy}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "${influencer["total_campaigns"]} campaigns completed",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledColor,
                      ),
                    ),
                  ],
                ),
              ),
              QButton(
                icon: Icons.message,
                size: bs.sm,
                onPressed: () {
                  _contactInfluencer(influencer);
                },
              ),
              SizedBox(width: spSm),
              QButton(
                icon: Icons.more_vert,
                size: bs.sm,
                onPressed: () {
                  _showInfluencerOptions(influencer);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInfluencerMetric(String label, String value, IconData icon) {
    return Column(
      children: [
        Icon(
          icon,
          color: primaryColor,
          size: 16,
        ),
        SizedBox(height: spXs),
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

  Widget _buildCampaignsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          _buildCampaignsHeader(),
          _buildCampaignsList(),
        ],
      ),
    );
  }

  Widget _buildCampaignsHeader() {
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
                  "Active Campaigns",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "${campaigns.length} campaigns running",
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
          QButton(
            icon: Icons.add,
            size: bs.sm,
            onPressed: () {
              _createNewCampaign();
            },
          ),
        ],
      ),
    );
  }

  Widget _buildCampaignsList() {
    return Column(
      spacing: spSm,
      children: campaigns.map((campaign) {
        return _buildCampaignCard(campaign);
      }).toList(),
    );
  }

  Widget _buildCampaignCard(Map<String, dynamic> campaign) {
    Color statusColor = _getStatusColor(campaign["status"]);
    double budgetUsed = campaign["spent"] > 0 
        ? ((campaign["spent"] as int) / (campaign["budget"] as int)) * 100 
        : 0;

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
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${campaign["name"]}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "${(campaign["start_date"] as DateTime).dMMMy} - ${(campaign["end_date"] as DateTime).dMMMy}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                decoration: BoxDecoration(
                  color: statusColor,
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "${campaign["status"]}".toUpperCase(),
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
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
            child: Column(
              spacing: spXs,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: _buildCampaignMetric(
                        "Budget",
                        "\$${((campaign["budget"] as int) / 1000).toStringAsFixed(1)}K",
                        Icons.monetization_on,
                      ),
                    ),
                    Expanded(
                      child: _buildCampaignMetric(
                        "Spent",
                        "\$${((campaign["spent"] as int) / 1000).toStringAsFixed(1)}K",
                        Icons.trending_down,
                      ),
                    ),
                    Expanded(
                      child: _buildCampaignMetric(
                        "Influencers",
                        "${campaign["influencers"]}",
                        Icons.people,
                      ),
                    ),
                    Expanded(
                      child: _buildCampaignMetric(
                        "Posts",
                        "${campaign["posts"]}",
                        Icons.article,
                      ),
                    ),
                  ],
                ),
                if (campaign["spent"] > 0) ...[
                  Row(
                    children: [
                      Text(
                        "Budget used: ${budgetUsed.toStringAsFixed(1)}%",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                      Spacer(),
                      Text(
                        "Remaining: \$${((campaign["budget"] as int) - (campaign["spent"] as int))}",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    height: 4,
                    decoration: BoxDecoration(
                      color: disabledColor,
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                    child: FractionallySizedBox(
                      alignment: Alignment.centerLeft,
                      widthFactor: budgetUsed / 100,
                      child: Container(
                        decoration: BoxDecoration(
                          color: budgetUsed > 80 ? dangerColor : primaryColor,
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
          if (campaign["impressions"] > 0) ...[
            Row(
              children: [
                Expanded(
                  child: _buildCampaignMetric(
                    "Impressions",
                    "${((campaign["impressions"] as int) / 1000000).toStringAsFixed(1)}M",
                    Icons.visibility,
                  ),
                ),
                Expanded(
                  child: _buildCampaignMetric(
                    "Engagement",
                    "${((campaign["engagement"] as int) / 1000).toStringAsFixed(1)}K",
                    Icons.favorite,
                  ),
                ),
                Expanded(
                  child: _buildCampaignMetric(
                    "Engagement Rate",
                    "${(((campaign["engagement"] as int) / (campaign["impressions"] as int)) * 100).toStringAsFixed(1)}%",
                    Icons.show_chart,
                  ),
                ),
                QButton(
                  icon: Icons.analytics,
                  size: bs.sm,
                  onPressed: () {
                    _viewCampaignAnalytics(campaign);
                  },
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildCampaignMetric(String label, String value, IconData icon) {
    return Row(
      children: [
        Icon(
          icon,
          color: primaryColor,
          size: 16,
        ),
        SizedBox(width: spXs),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
        ),
      ],
    );
  }

  Widget _buildDiscoveryTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          _buildDiscoveryHeader(),
          _buildDiscoveryFilters(),
          _buildDiscoveryResults(),
        ],
      ),
    );
  }

  Widget _buildDiscoveryHeader() {
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
            "Influencer Discovery",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spXs),
          Text(
            "Find new influencers that match your brand and campaign requirements",
            style: TextStyle(
              fontSize: 14,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDiscoveryFilters() {
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
            "Discovery Filters",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          QTextField(
            label: "Keywords or hashtags",
            value: "",
            hint: "e.g., fashion, beauty, lifestyle",
            onChanged: (value) {},
          ),
          Row(
            children: [
              Expanded(
                child: QDropdownField(
                  label: "Category",
                  items: categories,
                  value: "All",
                  onChanged: (value, label) {},
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QDropdownField(
                  label: "Follower Range",
                  items: followerRanges,
                  value: "All",
                  onChanged: (value, label) {},
                ),
              ),
            ],
          ),
          Container(
            width: double.infinity,
            child: QButton(
              label: "Search Influencers",
              size: bs.md,
              icon: Icons.search,
              onPressed: () {
                _searchInfluencers();
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDiscoveryResults() {
    List<Map<String, dynamic>> discoveredInfluencers = [
      {
        "name": "Jessica Style",
        "username": "@jessica_fashion",
        "platform": "instagram",
        "followers": 89000,
        "engagement_rate": 5.4,
        "category": "fashion",
        "verified": true,
        "location": "Paris, France",
        "match_score": 92,
        "image": "https://picsum.photos/100/100?random=5&keyword=fashion",
      },
      {
        "name": "Alex Tech",
        "username": "@alex_tech_guru",
        "platform": "youtube",
        "followers": 145000,
        "engagement_rate": 6.8,
        "category": "tech",
        "verified": true,
        "location": "Seattle, USA",
        "match_score": 87,
        "image": "https://picsum.photos/100/100?random=6&keyword=tech",
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
            "Discovery Results",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Text(
            "${discoveredInfluencers.length} influencers found",
            style: TextStyle(
              fontSize: 14,
              color: disabledBoldColor,
            ),
          ),
          ...discoveredInfluencers.map((influencer) => _buildDiscoveryInfluencerCard(influencer)),
        ],
      ),
    );
  }

  Widget _buildDiscoveryInfluencerCard(Map<String, dynamic> influencer) {
    IconData platformIcon = _getPlatformIcon(influencer["platform"]);

    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: primaryColor.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Column(
        spacing: spSm,
        children: [
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(radiusSm),
                child: Image.network(
                  "${influencer["image"]}",
                  width: 50,
                  height: 50,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          "${influencer["name"]}",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        if (influencer["verified"] == true) ...[
                          SizedBox(width: spXs),
                          Icon(
                            Icons.verified,
                            color: infoColor,
                            size: 14,
                          ),
                        ],
                      ],
                    ),
                    Row(
                      children: [
                        Icon(
                          platformIcon,
                          color: primaryColor,
                          size: 14,
                        ),
                        SizedBox(width: spXs),
                        Text(
                          "${influencer["username"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                decoration: BoxDecoration(
                  color: successColor,
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "${influencer["match_score"]}% MATCH",
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: _buildDiscoveryMetric(
                  "Followers",
                  "${((influencer["followers"] as int) / 1000).toStringAsFixed(0)}K",
                ),
              ),
              Expanded(
                child: _buildDiscoveryMetric(
                  "Engagement",
                  "${(influencer["engagement_rate"] as double).toStringAsFixed(1)}%",
                ),
              ),
              Expanded(
                child: _buildDiscoveryMetric(
                  "Category",
                  "${influencer["category"]}".toUpperCase(),
                ),
              ),
              QButton(
                label: "Add",
                size: bs.sm,
                onPressed: () {
                  _addDiscoveredInfluencer(influencer);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDiscoveryMetric(String label, String value) {
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

  Widget _buildAnalyticsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          _buildAnalyticsOverview(),
          _buildPerformanceMetrics(),
          _buildROIAnalysis(),
          _buildTopPerformers(),
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
                  "Total Influencers",
                  "${influencers.length}",
                  Icons.people,
                  primaryColor,
                  "+3",
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: _buildAnalyticsCard(
                  "Active Campaigns",
                  "${campaigns.where((c) => c["status"] == "active").length}",
                  Icons.campaign,
                  successColor,
                  "+1",
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: _buildAnalyticsCard(
                  "Total Reach",
                  "2.4M",
                  Icons.visibility,
                  infoColor,
                  "+12%",
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: _buildAnalyticsCard(
                  "Avg Engagement",
                  "5.6%",
                  Icons.favorite,
                  warningColor,
                  "+0.8%",
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

  Widget _buildPerformanceMetrics() {
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
            "Performance Metrics",
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
                    "Performance Chart",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: primaryColor,
                    ),
                  ),
                  Text(
                    "Visual representation of influencer performance over time",
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

  Widget _buildROIAnalysis() {
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
            "ROI Analysis",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Row(
            children: [
              Expanded(
                child: _buildROICard("Total Spend", "\$35,000", Icons.monetization_on, dangerColor),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: _buildROICard("Generated Revenue", "\$125,000", Icons.trending_up, successColor),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: _buildROICard("ROI", "257%", Icons.percent, primaryColor),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: _buildROICard("Cost per Acquisition", "\$28", Icons.person_add, warningColor),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildROICard(String title, String value, IconData icon, Color color) {
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
              fontSize: 18,
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

  Widget _buildTopPerformers() {
    List<Map<String, dynamic>> topPerformers = List.from(influencers)
      ..sort((a, b) => (b["rating"] as double).compareTo(a["rating"] as double));

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
            "Top Performing Influencers",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          ...topPerformers.take(3).map((influencer) => _buildTopPerformerItem(influencer)),
        ],
      ),
    );
  }

  Widget _buildTopPerformerItem(Map<String, dynamic> influencer) {
    IconData platformIcon = _getPlatformIcon(influencer["platform"]);

    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: primaryColor.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(radiusXs),
            child: Image.network(
              "${influencer["image"]}",
              width: 40,
              height: 40,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${influencer["name"]}",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Row(
                  children: [
                    Icon(
                      platformIcon,
                      color: primaryColor,
                      size: 12,
                    ),
                    SizedBox(width: spXs),
                    Text(
                      "${influencer["username"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Row(
            children: [
              Icon(
                Icons.star,
                color: warningColor,
                size: 16,
              ),
              SizedBox(width: spXs),
              Text(
                "${(influencer["rating"] as double).toStringAsFixed(1)}",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: warningColor,
                ),
              ),
            ],
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

  Color _getStatusColor(String status) {
    switch (status) {
      case "active":
        return successColor;
      case "pending":
        return warningColor;
      case "negotiating":
        return infoColor;
      case "completed":
        return primaryColor;
      default:
        return disabledBoldColor;
    }
  }

  bool _matchesFollowerRange(int followers, String range) {
    switch (range) {
      case "nano":
        return followers >= 1000 && followers < 10000;
      case "micro":
        return followers >= 10000 && followers < 100000;
      case "macro":
        return followers >= 100000 && followers < 1000000;
      case "mega":
        return followers >= 1000000;
      default:
        return true;
    }
  }

  void _addNewInfluencer() {
    si("Opening add influencer form");
  }

  void _contactInfluencer(Map<String, dynamic> influencer) {
    ss("Contacting ${influencer["name"]}");
  }

  void _showInfluencerOptions(Map<String, dynamic> influencer) {
    si("Showing options for ${influencer["name"]}");
  }

  void _createNewCampaign() {
    si("Creating new campaign");
  }

  void _viewCampaignAnalytics(Map<String, dynamic> campaign) {
    si("Viewing analytics for ${campaign["name"]}");
  }

  void _searchInfluencers() {
    ss("Searching for new influencers...");
  }

  void _addDiscoveredInfluencer(Map<String, dynamic> influencer) {
    ss("Added ${influencer["name"]} to your influencer list");
  }
}
