import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class PosLoyaltyProgramView extends StatefulWidget {
  const PosLoyaltyProgramView({super.key});

  @override
  State<PosLoyaltyProgramView> createState() => _PosLoyaltyProgramViewState();
}

class _PosLoyaltyProgramViewState extends State<PosLoyaltyProgramView> {
  int currentTab = 0;
  String searchQuery = "";
  String selectedProgram = "";
  bool loyaltyEnabled = true;
  String pointsPerDollar = "1";
  String redemptionRate = "100";
  String welcomeBonus = "50";

  List<Map<String, dynamic>> loyaltyPrograms = [
    {
      "id": "1",
      "name": "Gold Rewards",
      "type": "Points Based",
      "members": 2450,
      "totalPoints": 125000,
      "status": "Active",
      "pointsPerDollar": 2,
      "redemptionRate": 100,
      "welcomeBonus": 100,
      "color": Colors.amber,
    },
    {
      "id": "2", 
      "name": "VIP Club",
      "type": "Tier Based",
      "members": 890,
      "totalPoints": 87500,
      "status": "Active",
      "pointsPerDollar": 3,
      "redemptionRate": 75,
      "welcomeBonus": 150,
      "color": Colors.purple,
    },
    {
      "id": "3",
      "name": "Student Discount",
      "type": "Discount Based",
      "members": 1250,
      "totalPoints": 0,
      "status": "Inactive",
      "pointsPerDollar": 1,
      "redemptionRate": 0,
      "welcomeBonus": 25,
      "color": Colors.blue,
    },
  ];

  List<Map<String, dynamic>> recentActivities = [
    {
      "customer": "Sarah Johnson",
      "action": "Points Earned",
      "points": 50,
      "program": "Gold Rewards",
      "timestamp": "2 hours ago",
      "type": "earned",
    },
    {
      "customer": "Mike Chen",
      "action": "Points Redeemed",
      "points": 200,
      "program": "VIP Club",
      "timestamp": "4 hours ago",
      "type": "redeemed",
    },
    {
      "customer": "Emma Davis",
      "action": "Welcome Bonus",
      "points": 100,
      "program": "Gold Rewards",
      "timestamp": "1 day ago",
      "type": "bonus",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Loyalty Programs",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Programs", icon: Icon(Icons.card_membership)),
        Tab(text: "Settings", icon: Icon(Icons.settings)),
        Tab(text: "Activity", icon: Icon(Icons.timeline)),
      ],
      tabChildren: [
        _buildProgramsTab(),
        _buildSettingsTab(),
        _buildActivityTab(),
      ],
    );
  }

  Widget _buildProgramsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          _buildSearchAndFilters(),
          _buildProgramStats(),
          _buildProgramsList(),
        ],
      ),
    );
  }

  Widget _buildSearchAndFilters() {
    return Column(
      spacing: spSm,
      children: [
        Row(
          children: [
            Expanded(
              child: QTextField(
                label: "Search programs...",
                value: searchQuery,
                onChanged: (value) {
                  searchQuery = value;
                  setState(() {});
                },
              ),
            ),
            SizedBox(width: spSm),
            QButton(
              icon: Icons.add,
              size: bs.sm,
              onPressed: () {},
            ),
          ],
        ),
        QDropdownField(
          label: "Filter by Status",
          items: [
            {"label": "All Programs", "value": ""},
            {"label": "Active", "value": "Active"},
            {"label": "Inactive", "value": "Inactive"},
          ],
          value: selectedProgram,
          onChanged: (value, label) {
            selectedProgram = value;
            setState(() {});
          },
        ),
      ],
    );
  }

  Widget _buildProgramStats() {
    return Row(
      children: [
        Expanded(
          child: Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.groups,
                  color: primaryColor,
                  size: 24,
                ),
                SizedBox(height: spSm),
                Text(
                  "4,590",
                  style: TextStyle(
                    fontSize: fsH4,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "Total Members",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(width: spSm),
        Expanded(
          child: Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.stars,
                  color: warningColor,
                  size: 24,
                ),
                SizedBox(height: spSm),
                Text(
                  "212.5K",
                  style: TextStyle(
                    fontSize: fsH4,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "Total Points",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildProgramsList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: spSm,
      children: [
        Text(
          "Active Programs",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        ...loyaltyPrograms.map((program) => _buildProgramCard(program)),
      ],
    );
  }

  Widget _buildProgramCard(Map<String, dynamic> program) {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
        border: Border(
          left: BorderSide(
            width: 4,
            color: program["color"] as Color,
          ),
        ),
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
                      "${program["name"]}",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "${program["type"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: program["status"] == "Active" ? successColor.withAlpha(20) : dangerColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Text(
                  "${program["status"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: program["status"] == "Active" ? successColor : dangerColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.group, size: 16, color: disabledBoldColor),
                        SizedBox(width: spXs),
                        Text(
                          "${(program["members"] as int).toString()} members",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                    if (program["totalPoints"] > 0) ...[
                      SizedBox(height: spXs),
                      Row(
                        children: [
                          Icon(Icons.stars, size: 16, color: warningColor),
                          SizedBox(width: spXs),
                          Text(
                            "${((program["totalPoints"] as int) / 1000).toStringAsFixed(1)}K points",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ],
                ),
              ),
              QButton(
                icon: Icons.more_vert,
                size: bs.sm,
                onPressed: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          _buildGeneralSettings(),
          _buildPointsConfiguration(),
          _buildRedemptionSettings(),
        ],
      ),
    );
  }

  Widget _buildGeneralSettings() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Text(
            "General Settings",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          QSwitch(
            items: [
              {
                "label": "Enable Loyalty Program",
                "value": true,
                "checked": loyaltyEnabled,
              }
            ],
            value: [
              if (loyaltyEnabled)
                {
                  "label": "Enable Loyalty Program",
                  "value": true,
                  "checked": true
                }
            ],
            onChanged: (values, ids) {
              loyaltyEnabled = values.isNotEmpty;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  Widget _buildPointsConfiguration() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Text(
            "Points Configuration",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          QNumberField(
            label: "Points per Dollar Spent",
            value: pointsPerDollar,
            onChanged: (value) {
              pointsPerDollar = value;
              setState(() {});
            },
          ),
          QNumberField(
            label: "Welcome Bonus Points",
            value: welcomeBonus,
            onChanged: (value) {
              welcomeBonus = value;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  Widget _buildRedemptionSettings() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Text(
            "Redemption Settings",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          QNumberField(
            label: "Points Required for \$1 Discount",
            value: redemptionRate,
            onChanged: (value) {
              redemptionRate = value;
              setState(() {});
            },
          ),
          Container(
            width: double.infinity,
            child: QButton(
              label: "Save Settings",
              size: bs.md,
              onPressed: () {
                ss("Loyalty program settings saved successfully");
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActivityTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          _buildActivityStats(),
          _buildRecentActivities(),
        ],
      ),
    );
  }

  Widget _buildActivityStats() {
    return ResponsiveGridView(
      padding: EdgeInsets.zero,
      minItemWidth: 200,
      children: [
        Container(
          padding: EdgeInsets.all(spMd),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(radiusMd),
            boxShadow: [shadowSm],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                Icons.trending_up,
                color: successColor,
                size: 24,
              ),
              SizedBox(height: spSm),
              Text(
                "1,250",
                style: TextStyle(
                  fontSize: fsH4,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Text(
                "Points Earned Today",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.all(spMd),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(radiusMd),
            boxShadow: [shadowSm],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                Icons.trending_down,
                color: dangerColor,
                size: 24,
              ),
              SizedBox(height: spSm),
              Text(
                "890",
                style: TextStyle(
                  fontSize: fsH4,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Text(
                "Points Redeemed Today",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildRecentActivities() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: spSm,
      children: [
        Text(
          "Recent Activity",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        ...recentActivities.map((activity) => _buildActivityItem(activity)),
      ],
    );
  }

  Widget _buildActivityItem(Map<String, dynamic> activity) {
    Color iconColor = activity["type"] == "earned" ? successColor : 
                     activity["type"] == "redeemed" ? dangerColor : infoColor;
    IconData icon = activity["type"] == "earned" ? Icons.add_circle : 
                   activity["type"] == "redeemed" ? Icons.remove_circle : Icons.card_giftcard;

    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: iconColor.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Icon(
              icon,
              color: iconColor,
              size: 20,
            ),
          ),
          SizedBox(width: spMd),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${activity["customer"]}",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "${activity["action"]} - ${activity["program"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
                Text(
                  "${activity["timestamp"]}",
                  style: TextStyle(
                    fontSize: 11,
                    color: disabledColor,
                  ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                "${activity["type"] == "redeemed" ? "-" : "+"}${activity["points"]}",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: iconColor,
                ),
              ),
              Text(
                "points",
                style: TextStyle(
                  fontSize: 11,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
