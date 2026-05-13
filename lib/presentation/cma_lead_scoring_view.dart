import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class CmaLeadScoringView extends StatefulWidget {
  const CmaLeadScoringView({super.key});

  @override
  State<CmaLeadScoringView> createState() => _CmaLeadScoringViewState();
}

class _CmaLeadScoringViewState extends State<CmaLeadScoringView> {
  String selectedCategory = "All";
  String searchQuery = "";
  
  List<Map<String, dynamic>> categoryItems = [
    {"label": "All", "value": "All"},
    {"label": "Hot Leads", "value": "Hot"},
    {"label": "Warm Leads", "value": "Warm"},
    {"label": "Cold Leads", "value": "Cold"},
  ];

  List<Map<String, dynamic>> scoringCriteria = [
    {
      "name": "Company Size",
      "weight": 25,
      "maxScore": 100,
      "description": "Number of employees in the company",
      "icon": Icons.business,
    },
    {
      "name": "Budget Range",
      "weight": 30,
      "maxScore": 100,
      "description": "Available budget for the solution",
      "icon": Icons.attach_money,
    },
    {
      "name": "Decision Authority",
      "weight": 20,
      "maxScore": 100,
      "description": "Level of decision-making authority",
      "icon": Icons.admin_panel_settings,
    },
    {
      "name": "Urgency Level",
      "weight": 15,
      "maxScore": 100,
      "description": "Timeline for implementation",
      "icon": Icons.access_time,
    },
    {
      "name": "Engagement",
      "weight": 10,
      "maxScore": 100,
      "description": "Level of interaction and interest",
      "icon": Icons.trending_up,
    },
  ];

  List<Map<String, dynamic>> leads = [
    {
      "id": "1",
      "name": "John Smith",
      "company": "Tech Solutions Inc",
      "email": "john.smith@company.com",
      "totalScore": 85,
      "category": "Hot",
      "scores": {
        "Company Size": 90,
        "Budget Range": 85,
        "Decision Authority": 95,
        "Urgency Level": 70,
        "Engagement": 80,
      },
      "lastUpdated": "2024-01-15",
      "avatar": "https://picsum.photos/50/50?random=1",
      "trend": "up",
    },
    {
      "id": "2",
      "name": "Sarah Johnson",
      "company": "Marketing Pro",
      "email": "sarah.j@marketing.com",
      "totalScore": 72,
      "category": "Warm",
      "scores": {
        "Company Size": 75,
        "Budget Range": 80,
        "Decision Authority": 60,
        "Urgency Level": 85,
        "Engagement": 70,
      },
      "lastUpdated": "2024-01-14",
      "avatar": "https://picsum.photos/50/50?random=2",
      "trend": "up",
    },
    {
      "id": "3",
      "name": "Michael Chen",
      "company": "Innovation Startup",
      "email": "m.chen@startup.io",
      "totalScore": 94,
      "category": "Hot",
      "scores": {
        "Company Size": 70,
        "Budget Range": 95,
        "Decision Authority": 100,
        "Urgency Level": 95,
        "Engagement": 90,
      },
      "lastUpdated": "2024-01-13",
      "avatar": "https://picsum.photos/50/50?random=3",
      "trend": "up",
    },
    {
      "id": "4",
      "name": "Emily Davis",
      "company": "Global Corp",
      "email": "emily.davis@corp.com",
      "totalScore": 45,
      "category": "Cold",
      "scores": {
        "Company Size": 60,
        "Budget Range": 30,
        "Decision Authority": 40,
        "Urgency Level": 50,
        "Engagement": 35,
      },
      "lastUpdated": "2024-01-12",
      "avatar": "https://picsum.photos/50/50?random=4",
      "trend": "down",
    },
    {
      "id": "5",
      "name": "David Wilson",
      "company": "Enterprise Solutions",
      "email": "d.wilson@enterprise.com",
      "totalScore": 68,
      "category": "Warm",
      "scores": {
        "Company Size": 85,
        "Budget Range": 70,
        "Decision Authority": 55,
        "Urgency Level": 60,
        "Engagement": 75,
      },
      "lastUpdated": "2024-01-11",
      "avatar": "https://picsum.photos/50/50?random=5",
      "trend": "stable",
    },
  ];

  List<Map<String, dynamic>> get filteredLeads {
    List<Map<String, dynamic>> filtered = leads;
    
    if (selectedCategory != "All") {
      filtered = filtered.where((lead) => lead["category"] == selectedCategory).toList();
    }
    
    if (searchQuery.isNotEmpty) {
      filtered = filtered.where((lead) =>
        "${lead["name"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
        "${lead["company"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
        "${lead["email"]}".toLowerCase().contains(searchQuery.toLowerCase())
      ).toList();
    }
    
    filtered.sort((a, b) => (b["totalScore"] as int).compareTo(a["totalScore"] as int));
    
    return filtered;
  }

  Color _getScoreColor(int score) {
    if (score >= 80) return successColor;
    if (score >= 60) return warningColor;
    if (score >= 40) return infoColor;
    return dangerColor;
  }

  Color _getCategoryColor(String category) {
    switch (category) {
      case "Hot":
        return dangerColor;
      case "Warm":
        return warningColor;
      case "Cold":
        return infoColor;
      default:
        return disabledColor;
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

  Color _getTrendColor(String trend) {
    switch (trend) {
      case "up":
        return successColor;
      case "down":
        return dangerColor;
      case "stable":
        return warningColor;
      default:
        return disabledColor;
    }
  }

  void _editScoring(Map<String, dynamic> lead) {
    //navigateTo('CmaEditLeadScoringView')
  }

  void _viewAnalytics() {
    //navigateTo('CmaLeadScoringAnalyticsView')
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Lead Scoring"),
        actions: [
          QButton(
            icon: Icons.analytics,
            size: bs.sm,
            onPressed: _viewAnalytics,
          ),
          SizedBox(width: spSm),
          QButton(
            icon: Icons.settings,
            size: bs.sm,
            onPressed: () {
              //navigateTo('CmaLeadScoringSettingsView')
            },
          ),
          SizedBox(width: spSm),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            _buildHeader(),
            _buildScoringCriteria(),
            _buildFilters(),
            _buildSearchBar(),
            _buildScoreStats(),
            _buildLeadsList(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [primaryColor, primaryColor.withAlpha(200)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(radiusMd),
      ),
      child: Row(
        children: [
          Icon(
            Icons.star,
            color: Colors.white,
            size: 32,
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Lead Scoring System",
                  style: TextStyle(
                    fontSize: fsH5,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Text(
                  "AI-powered lead qualification and ranking",
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white.withAlpha(200),
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
            decoration: BoxDecoration(
              color: Colors.white.withAlpha(50),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Text(
              "${filteredLeads.length} Scored",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildScoringCriteria() {
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
                Icons.rule,
                color: primaryColor,
                size: 20,
              ),
              SizedBox(width: spXs),
              Text(
                "Scoring Criteria",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          Column(
            spacing: spXs,
            children: List.generate(scoringCriteria.length, (index) {
              final criteria = scoringCriteria[index];
              return Row(
                children: [
                  Icon(
                    criteria["icon"],
                    size: 16,
                    color: primaryColor,
                  ),
                  SizedBox(width: spXs),
                  Expanded(
                    child: Text(
                      "${criteria["name"]}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                    decoration: BoxDecoration(
                      color: primaryColor.withAlpha(30),
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                    child: Text(
                      "${criteria["weight"]}%",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                  ),
                ],
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildFilters() {
    return QCategoryPicker(
      label: "Filter by Category",
      items: categoryItems,
      value: selectedCategory,
      onChanged: (index, label, value, item) {
        selectedCategory = value;
        setState(() {});
      },
    );
  }

  Widget _buildSearchBar() {
    return Row(
      children: [
        Expanded(
          child: QTextField(
            label: "Search leads...",
            value: searchQuery,
            hint: "Search by name, company, or email",
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
    );
  }

  Widget _buildScoreStats() {
    double avgScore = leads.fold(0.0, (sum, lead) => sum + (lead["totalScore"] as int)) / leads.length;
    int hotLeads = leads.where((lead) => lead["category"] == "Hot").length;
    int warmLeads = leads.where((lead) => lead["category"] == "Warm").length;
    int coldLeads = leads.where((lead) => lead["category"] == "Cold").length;

    return Row(
      children: [
        Expanded(
          child: _buildStatCard(
            title: "Avg Score",
            value: "${avgScore.toStringAsFixed(0)}",
            icon: Icons.analytics,
            color: primaryColor,
          ),
        ),
        SizedBox(width: spSm),
        Expanded(
          child: _buildStatCard(
            title: "Hot Leads",
            value: "$hotLeads",
            icon: Icons.local_fire_department,
            color: dangerColor,
          ),
        ),
        SizedBox(width: spSm),
        Expanded(
          child: _buildStatCard(
            title: "Warm Leads",
            value: "$warmLeads",
            icon: Icons.thermostat,
            color: warningColor,
          ),
        ),
        SizedBox(width: spSm),
        Expanded(
          child: _buildStatCard(
            title: "Cold Leads",
            value: "$coldLeads",
            icon: Icons.ac_unit,
            color: infoColor,
          ),
        ),
      ],
    );
  }

  Widget _buildStatCard({
    required String title,
    required String value,
    required IconData icon,
    required Color color,
  }) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
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
              fontSize: fsH6,
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

  Widget _buildLeadsList() {
    if (filteredLeads.isEmpty) {
      return Container(
        padding: EdgeInsets.all(spXl),
        child: Column(
          children: [
            Icon(
              Icons.search_off,
              size: 64,
              color: disabledColor,
            ),
            SizedBox(height: spSm),
            Text(
              "No leads found",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: disabledBoldColor,
              ),
            ),
            Text(
              "Try adjusting your filters or search criteria",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: disabledBoldColor,
              ),
            ),
          ],
        ),
      );
    }

    return Column(
      spacing: spSm,
      children: List.generate(filteredLeads.length, (index) {
        final lead = filteredLeads[index];
        return _buildLeadCard(lead, index + 1);
      }),
    );
  }

  Widget _buildLeadCard(Map<String, dynamic> lead, int rank) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
        border: Border(
          left: BorderSide(
            width: 4,
            color: _getCategoryColor(lead["category"]),
          ),
        ),
      ),
      child: Column(
        spacing: spSm,
        children: [
          Row(
            children: [
              Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                  color: _getScoreColor(lead["totalScore"]),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    "#$rank",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              SizedBox(width: spSm),
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(radiusLg),
                  image: DecorationImage(
                    image: NetworkImage("${lead["avatar"]}"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            "${lead["name"]}",
                            style: TextStyle(
                              fontSize: fsH6,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                          decoration: BoxDecoration(
                            color: _getScoreColor(lead["totalScore"]).withAlpha(30),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Text(
                            "${lead["totalScore"]}",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: _getScoreColor(lead["totalScore"]),
                            ),
                          ),
                        ),
                        SizedBox(width: spXs),
                        Icon(
                          _getTrendIcon(lead["trend"]),
                          size: 20,
                          color: _getTrendColor(lead["trend"]),
                        ),
                      ],
                    ),
                    Text(
                      "${lead["company"]}",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Divider(color: disabledOutlineBorderColor),
          _buildScoreBreakdown(lead["scores"]),
          Divider(color: disabledOutlineBorderColor),
          Row(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: _getCategoryColor(lead["category"]).withAlpha(30),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Text(
                  "${lead["category"]} Lead",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: _getCategoryColor(lead["category"]),
                  ),
                ),
              ),
              SizedBox(width: spSm),
              Text(
                "Updated: ${lead["lastUpdated"]}",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
              Spacer(),
              QButton(
                label: "Edit Score",
                size: bs.sm,
                onPressed: () => _editScoring(lead),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildScoreBreakdown(Map<String, dynamic> scores) {
    return Column(
      spacing: spXs,
      children: List.generate(scoringCriteria.length, (index) {
        final criteria = scoringCriteria[index];
        final score = scores[criteria["name"]] as int;
        final percentage = (score / (criteria["maxScore"] as int)) * 100;
        
        return Row(
          children: [
            SizedBox(
              width: 100,
              child: Text(
                "${criteria["name"]}",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
            ),
            SizedBox(width: spXs),
            Expanded(
              child: Container(
                height: 8,
                decoration: BoxDecoration(
                  color: disabledColor.withAlpha(50),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: FractionallySizedBox(
                  alignment: Alignment.centerLeft,
                  widthFactor: percentage / 100,
                  child: Container(
                    decoration: BoxDecoration(
                      color: _getScoreColor(score),
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(width: spXs),
            SizedBox(
              width: 30,
              child: Text(
                "$score",
                textAlign: TextAlign.right,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: _getScoreColor(score),
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}
