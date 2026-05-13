import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class CmaAutomationView extends StatefulWidget {
  const CmaAutomationView({super.key});

  @override
  State<CmaAutomationView> createState() => _CmaAutomationViewState();
}

class _CmaAutomationViewState extends State<CmaAutomationView> {
  String selectedFilter = "all";
  String searchQuery = "";
  int selectedTab = 0;

  List<Map<String, dynamic>> filterOptions = [
    {"label": "All Automations", "value": "all"},
    {"label": "Active", "value": "active"},
    {"label": "Paused", "value": "paused"},
    {"label": "Draft", "value": "draft"},
    {"label": "Completed", "value": "completed"},
  ];

  List<Map<String, dynamic>> automations = [
    {
      "id": "1",
      "name": "Welcome Email Series",
      "description": "Automated welcome sequence for new subscribers",
      "status": "active",
      "trigger": "User Registration",
      "actions": 5,
      "subscribers": 2456,
      "completions": 1847,
      "completionRate": 75.2,
      "createdDate": "2024-11-15",
      "lastRun": "2024-12-15",
      "category": "Onboarding",
      "priority": "high"
    },
    {
      "id": "2",
      "name": "Abandoned Cart Recovery",
      "description": "Recover lost sales with targeted cart abandonment emails",
      "status": "active",
      "trigger": "Cart Abandonment",
      "actions": 3,
      "subscribers": 1234,
      "completions": 456,
      "completionRate": 37.0,
      "createdDate": "2024-10-20",
      "lastRun": "2024-12-15",
      "category": "E-commerce",
      "priority": "high"
    },
    {
      "id": "3",
      "name": "Re-engagement Campaign",
      "description": "Win back inactive subscribers with compelling content",
      "status": "paused",
      "trigger": "Inactivity (30 days)",
      "actions": 4,
      "subscribers": 3456,
      "completions": 987,
      "completionRate": 28.5,
      "createdDate": "2024-09-10",
      "lastRun": "2024-12-01",
      "category": "Retention",
      "priority": "medium"
    },
    {
      "id": "4",
      "name": "Birthday Special Offers",
      "description": "Personalized birthday offers for customers",
      "status": "active",
      "trigger": "Birthday Date",
      "actions": 2,
      "subscribers": 5678,
      "completions": 4321,
      "completionRate": 76.1,
      "createdDate": "2024-01-01",
      "lastRun": "2024-12-14",
      "category": "Loyalty",
      "priority": "low"
    },
    {
      "id": "5",
      "name": "Product Launch Sequence",
      "description": "Multi-step campaign for new product announcements",
      "status": "draft",
      "trigger": "Product Launch",
      "actions": 6,
      "subscribers": 0,
      "completions": 0,
      "completionRate": 0.0,
      "createdDate": "2024-12-10",
      "lastRun": "",
      "category": "Marketing",
      "priority": "high"
    },
  ];

  List<Map<String, dynamic>> templates = [
    {
      "id": "1",
      "name": "Welcome Series",
      "description": "5-step onboarding sequence",
      "category": "Onboarding",
      "actions": 5,
      "popularity": 95,
      "thumbnail": "https://picsum.photos/300/200?random=20&keyword=welcome"
    },
    {
      "id": "2",
      "name": "Cart Recovery",
      "description": "3-email abandoned cart sequence",
      "category": "E-commerce",
      "actions": 3,
      "popularity": 89,
      "thumbnail": "https://picsum.photos/300/200?random=21&keyword=cart"
    },
    {
      "id": "3",
      "name": "Lead Nurturing",
      "description": "Educational content series",
      "category": "Lead Generation",
      "actions": 7,
      "popularity": 87,
      "thumbnail": "https://picsum.photos/300/200?random=22&keyword=nurture"
    },
    {
      "id": "4",
      "name": "Customer Feedback",
      "description": "Review and feedback collection",
      "category": "Feedback",
      "actions": 4,
      "popularity": 82,
      "thumbnail": "https://picsum.photos/300/200?random=23&keyword=feedback"
    },
  ];

  List<Map<String, dynamic>> get filteredAutomations {
    List<Map<String, dynamic>> filtered = automations;
    
    if (selectedFilter != "all") {
      filtered = filtered.where((automation) => automation["status"] == selectedFilter).toList();
    }
    
    if (searchQuery.isNotEmpty) {
      filtered = filtered.where((automation) => 
        (automation["name"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
        (automation["description"] as String).toLowerCase().contains(searchQuery.toLowerCase())
      ).toList();
    }
    
    return filtered;
  }

  void _createAutomation() {
    si("Opening automation builder...");
  }

  void _editAutomation(Map<String, dynamic> automation) {
    si("Editing ${automation["name"]}...");
  }

  void _pauseAutomation(Map<String, dynamic> automation) {
    si("Automation paused");
    automation["status"] = "paused";
    setState(() {});
  }

  void _resumeAutomation(Map<String, dynamic> automation) {
    si("Automation resumed");
    automation["status"] = "active";
    setState(() {});
  }

  void _duplicateAutomation(Map<String, dynamic> automation) {
    si("Automation duplicated successfully");
  }

  void _deleteAutomation(Map<String, dynamic> automation) async {
    bool isConfirmed = await confirm("Are you sure you want to delete this automation?");
    if (isConfirmed) {
      ss("Automation deleted successfully");
    }
  }

  void _viewAnalytics(Map<String, dynamic> automation) {
    si("Opening automation analytics...");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Marketing Automation"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: _createAutomation,
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
        onPressed: _createAutomation,
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
                  label: "Search automations...",
                  value: searchQuery,
                  hint: "Search by name or description",
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
    int activeCount = automations.where((a) => a["status"] == "active").length;
    int pausedCount = automations.where((a) => a["status"] == "paused").length;
    int draftCount = automations.where((a) => a["status"] == "draft").length;
    double avgCompletion = automations.isNotEmpty 
        ? automations.map((a) => a["completionRate"] as double).reduce((a, b) => a + b) / automations.length
        : 0.0;

    return ResponsiveGridView(
      minItemWidth: 200,
      children: [
        _buildStatCard("Active Automations", activeCount, Icons.play_circle, Colors.green),
        _buildStatCard("Paused", pausedCount, Icons.pause_circle, Colors.orange),
        _buildStatCard("Drafts", draftCount, Icons.edit, Colors.blue),
        _buildStatCard("Avg. Completion", "${avgCompletion.toStringAsFixed(1)}%", Icons.check_circle, Colors.purple),
      ],
    );
  }

  Widget _buildStatCard(String title, dynamic value, IconData icon, Color color) {
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
                _buildTabButton("Automations", 0),
                _buildTabButton("Templates", 1),
                _buildTabButton("Performance", 2),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(spMd),
            child: selectedTab == 0
                ? _buildAutomationsTab()
                : selectedTab == 1
                    ? _buildTemplatesTab()
                    : _buildPerformanceTab(),
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

  Widget _buildAutomationsTab() {
    return Column(
      spacing: spSm,
      children: filteredAutomations.map((automation) {
        return Container(
          padding: EdgeInsets.all(spSm),
          decoration: BoxDecoration(
            border: Border.all(color: disabledOutlineBorderColor),
            borderRadius: BorderRadius.circular(radiusSm),
          ),
          child: Column(
            spacing: spSm,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                "${automation["name"]}",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: primaryColor,
                                ),
                              ),
                            ),
                            _buildStatusBadge(automation["status"]),
                          ],
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "${automation["description"]}",
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
              Row(
                children: [
                  _buildAutomationInfo("Trigger", "${automation["trigger"]}", Icons.flash_on),
                  SizedBox(width: spSm),
                  _buildAutomationInfo("Actions", "${automation["actions"]}", Icons.list),
                  SizedBox(width: spSm),
                  _buildAutomationInfo("Category", "${automation["category"]}", Icons.category),
                ],
              ),
              if (automation["status"] == "active") ...[
                Row(
                  children: [
                    Expanded(
                      child: _buildProgressMetric("Subscribers", "${automation["subscribers"]}", Icons.people),
                    ),
                    Expanded(
                      child: _buildProgressMetric("Completed", "${automation["completions"]}", Icons.check),
                    ),
                    Expanded(
                      child: _buildProgressMetric("Rate", "${(automation["completionRate"] as num).toStringAsFixed(1)}%", Icons.trending_up),
                    ),
                  ],
                ),
                Container(
                  height: 4,
                  decoration: BoxDecoration(
                    color: disabledColor.withAlpha(51),
                    borderRadius: BorderRadius.circular(radiusXs),
                  ),
                  child: FractionallySizedBox(
                    alignment: Alignment.centerLeft,
                    widthFactor: (automation["completionRate"] as double) / 100,
                    child: Container(
                      decoration: BoxDecoration(
                        color: successColor,
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                    ),
                  ),
                ),
              ],
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      _buildPriorityBadge(automation["priority"]),
                      SizedBox(width: spSm),
                      if (automation["lastRun"].toString().isNotEmpty)
                        Text(
                          "Last run: ${automation["lastRun"]}",
                          style: TextStyle(
                            fontSize: 11,
                            color: disabledBoldColor,
                          ),
                        ),
                    ],
                  ),
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () => _viewAnalytics(automation),
                        child: Icon(Icons.analytics, color: infoColor, size: 18),
                      ),
                      SizedBox(width: spSm),
                      GestureDetector(
                        onTap: () => _editAutomation(automation),
                        child: Icon(Icons.edit, color: warningColor, size: 18),
                      ),
                      SizedBox(width: spSm),
                      GestureDetector(
                        onTap: () => automation["status"] == "active" 
                            ? _pauseAutomation(automation)
                            : _resumeAutomation(automation),
                        child: Icon(
                          automation["status"] == "active" ? Icons.pause : Icons.play_arrow,
                          color: automation["status"] == "active" ? warningColor : successColor,
                          size: 18,
                        ),
                      ),
                      SizedBox(width: spSm),
                      GestureDetector(
                        onTap: () => _duplicateAutomation(automation),
                        child: Icon(Icons.copy, color: primaryColor, size: 18),
                      ),
                      SizedBox(width: spSm),
                      GestureDetector(
                        onTap: () => _deleteAutomation(automation),
                        child: Icon(Icons.delete, color: dangerColor, size: 18),
                      ),
                    ],
                  ),
                ],
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
      case "active":
        color = successColor;
        break;
      case "paused":
        color = warningColor;
        break;
      case "draft":
        color = infoColor;
        break;
      case "completed":
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

  Widget _buildPriorityBadge(String priority) {
    Color color;
    switch (priority) {
      case "high":
        color = dangerColor;
        break;
      case "medium":
        color = warningColor;
        break;
      case "low":
        color = successColor;
        break;
      default:
        color = disabledColor;
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
      decoration: BoxDecoration(
        color: color.withAlpha(26),
        borderRadius: BorderRadius.circular(radiusXs),
      ),
      child: Text(
        priority.toUpperCase(),
        style: TextStyle(
          fontSize: 9,
          color: color,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildAutomationInfo(String label, String value, IconData icon) {
    return Expanded(
      child: Column(
        children: [
          Icon(icon, color: primaryColor, size: 14),
          SizedBox(height: spXxs),
          Text(
            value,
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: primaryColor,
            ),
            textAlign: TextAlign.center,
          ),
          Text(
            label,
            style: TextStyle(
              fontSize: 9,
              color: disabledBoldColor,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildProgressMetric(String label, String value, IconData icon) {
    return Column(
      children: [
        Icon(icon, color: successColor, size: 14),
        SizedBox(height: spXxs),
        Text(
          value,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
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
                        Text(
                          "${template["actions"]} actions",
                          style: TextStyle(
                            fontSize: 11,
                            color: disabledBoldColor,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
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

  Widget _buildPerformanceTab() {
    return Column(
      spacing: spMd,
      children: [
        Row(
          children: [
            Expanded(
              child: _buildPerformanceCard("Total Subscribers", "12,345", "+15%", Icons.people, Colors.blue),
            ),
            SizedBox(width: spSm),
            Expanded(
              child: _buildPerformanceCard("Completions", "8,567", "+22%", Icons.check_circle, Colors.green),
            ),
          ],
        ),
        Row(
          children: [
            Expanded(
              child: _buildPerformanceCard("Avg. Completion", "69.4%", "+5.2%", Icons.trending_up, Colors.orange),
            ),
            SizedBox(width: spSm),
            Expanded(
              child: _buildPerformanceCard("Active Flows", "4", "+1", Icons.play_circle, Colors.purple),
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
                "Top Performing Automations",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: primaryColor,
                ),
              ),
              ...automations.where((a) => a["status"] == "active").take(3).map((automation) {
                return Container(
                  padding: EdgeInsets.all(spSm),
                  margin: EdgeInsets.only(bottom: spXs),
                  decoration: BoxDecoration(
                    color: Colors.grey.withAlpha(26),
                    borderRadius: BorderRadius.circular(radiusXs),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          "${automation["name"]}",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: primaryColor,
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                        decoration: BoxDecoration(
                          color: successColor.withAlpha(26),
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Text(
                          "${(automation["completionRate"] as num).toStringAsFixed(1)}%",
                          style: TextStyle(
                            fontSize: 12,
                            color: successColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildPerformanceCard(String title, String value, String change, IconData icon, Color color) {
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
