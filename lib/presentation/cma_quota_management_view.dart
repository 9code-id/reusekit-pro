import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class CmaQuotaManagementView extends StatefulWidget {
  const CmaQuotaManagementView({super.key});

  @override
  State<CmaQuotaManagementView> createState() => _CmaQuotaManagementViewState();
}

class _CmaQuotaManagementViewState extends State<CmaQuotaManagementView> {
  String selectedPeriod = "Q1 2024";
  String selectedTeam = "All Teams";
  
  List<Map<String, dynamic>> periodItems = [
    {"label": "Q4 2023", "value": "Q4 2023"},
    {"label": "Q1 2024", "value": "Q1 2024"},
    {"label": "Q2 2024", "value": "Q2 2024"},
    {"label": "Q3 2024", "value": "Q3 2024"},
    {"label": "Q4 2024", "value": "Q4 2024"},
  ];
  
  List<Map<String, dynamic>> teamItems = [
    {"label": "All Teams", "value": "All Teams"},
    {"label": "Enterprise Sales", "value": "Enterprise Sales"},
    {"label": "SMB Sales", "value": "SMB Sales"},
    {"label": "Channel Partners", "value": "Channel Partners"},
    {"label": "Inside Sales", "value": "Inside Sales"},
  ];
  
  Map<String, dynamic> quotaOverview = {
    "totalQuota": 5200000,
    "achievedRevenue": 4420000,
    "remainingQuota": 780000,
    "achievementRate": 85.0,
    "daysLeft": 45,
    "onTrackReps": 12,
    "totalReps": 16,
    "avgAchievement": 78.5,
  };
  
  List<Map<String, dynamic>> salesReps = [
    {
      "name": "John Smith",
      "role": "Senior Sales Rep",
      "quota": 450000,
      "achieved": 425000,
      "remaining": 25000,
      "achievementRate": 94.4,
      "status": "On Track",
      "deals": 8,
      "pipeline": 125000,
      "lastActivity": "2024-01-20",
      "manager": "Robert Davis",
      "territory": "Enterprise West",
    },
    {
      "name": "Sarah Johnson",
      "role": "Enterprise Sales",
      "quota": 600000,
      "achieved": 520000,
      "remaining": 80000,
      "achievementRate": 86.7,
      "status": "On Track",
      "deals": 6,
      "pipeline": 285000,
      "lastActivity": "2024-01-19",
      "manager": "Robert Davis",
      "territory": "Enterprise East",
    },
    {
      "name": "Mike Wilson",
      "role": "Sales Rep",
      "quota": 350000,
      "achieved": 245000,
      "remaining": 105000,
      "achievementRate": 70.0,
      "status": "At Risk",
      "deals": 12,
      "pipeline": 165000,
      "lastActivity": "2024-01-18",
      "manager": "Jennifer Lee",
      "territory": "SMB Central",
    },
    {
      "name": "Lisa Chen",
      "role": "Inside Sales",
      "quota": 280000,
      "achieved": 265000,
      "remaining": 15000,
      "achievementRate": 94.6,
      "status": "Exceeding",
      "deals": 18,
      "pipeline": 85000,
      "lastActivity": "2024-01-17",
      "manager": "Jennifer Lee",
      "territory": "SMB National",
    },
    {
      "name": "David Brown",
      "role": "Channel Rep",
      "quota": 400000,
      "achieved": 185000,
      "remaining": 215000,
      "achievementRate": 46.3,
      "status": "Behind",
      "deals": 4,
      "pipeline": 95000,
      "lastActivity": "2024-01-16",
      "manager": "Michael Torres",
      "territory": "Channel Partners",
    },
    {
      "name": "Emily Davis",
      "role": "Sales Rep",
      "quota": 320000,
      "achieved": 295000,
      "remaining": 25000,
      "achievementRate": 92.2,
      "status": "On Track",
      "deals": 10,
      "pipeline": 115000,
      "lastActivity": "2024-01-15",
      "manager": "Jennifer Lee",
      "territory": "SMB West",
    },
  ];
  
  List<Map<String, dynamic>> teamQuotas = [
    {
      "team": "Enterprise Sales",
      "manager": "Robert Davis",
      "totalQuota": 1800000,
      "achieved": 1520000,
      "achievementRate": 84.4,
      "reps": 4,
      "avgDeals": 7,
      "topPerformer": "John Smith",
    },
    {
      "team": "SMB Sales",
      "manager": "Jennifer Lee",
      "totalQuota": 2100000,
      "achieved": 1865000,
      "achievementRate": 88.8,
      "reps": 8,
      "avgDeals": 13,
      "topPerformer": "Lisa Chen",
    },
    {
      "team": "Channel Partners",
      "manager": "Michael Torres",
      "totalQuota": 900000,
      "achieved": 485000,
      "achievementRate": 53.9,
      "reps": 3,
      "avgDeals": 5,
      "topPerformer": "Alex Johnson",
    },
    {
      "team": "Inside Sales",
      "manager": "Jennifer Lee",
      "totalQuota": 400000,
      "achieved": 550000,
      "achievementRate": 137.5,
      "reps": 1,
      "avgDeals": 18,
      "topPerformer": "Lisa Chen",
    },
  ];
  
  List<Map<String, dynamic>> quotaAlerts = [
    {
      "type": "behind",
      "title": "David Brown - Significantly Behind",
      "description": "Only 46% of quota achieved with 45 days remaining",
      "priority": "High",
      "action": "Schedule 1-on-1 coaching session",
      "color": dangerColor,
    },
    {
      "type": "risk",
      "title": "Mike Wilson - At Risk",
      "description": "70% achieved but needs acceleration to meet quota",
      "priority": "Medium",
      "action": "Review pipeline and prioritize opportunities",
      "color": warningColor,
    },
    {
      "type": "exceeding",
      "title": "Lisa Chen - Exceeding Quota",
      "description": "Already at 95% with 45 days remaining",
      "priority": "Low",
      "action": "Consider stretch targets or territory expansion",
      "color": successColor,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Quota Management"),
        actions: [
          QButton(
            icon: Icons.edit,
            size: bs.sm,
            onPressed: () => _editQuotas(),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            // Filters Section
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Row(
                children: [
                  Expanded(
                    child: QDropdownField(
                      label: "Period",
                      items: periodItems,
                      value: selectedPeriod,
                      onChanged: (value, label) {
                        selectedPeriod = value;
                        setState(() {});
                      },
                    ),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: QDropdownField(
                      label: "Team",
                      items: teamItems,
                      value: selectedTeam,
                      onChanged: (value, label) {
                        selectedTeam = value;
                        setState(() {});
                      },
                    ),
                  ),
                ],
              ),
            ),
            
            // Quota Overview
            Container(
              padding: EdgeInsets.all(spSm),
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
                    "Quota Overview - $selectedPeriod",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: _buildOverviewCard(
                          "Total Quota",
                          "\$${((quotaOverview["totalQuota"] as int).toDouble()).currency}",
                          Icons.flag,
                          primaryColor,
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: _buildOverviewCard(
                          "Achieved",
                          "\$${((quotaOverview["achievedRevenue"] as int).toDouble()).currency}",
                          Icons.check_circle,
                          successColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  Row(
                    children: [
                      Expanded(
                        child: _buildOverviewCard(
                          "Achievement",
                          "${(quotaOverview["achievementRate"] as num).toStringAsFixed(1)}%",
                          Icons.trending_up,
                          infoColor,
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: _buildOverviewCard(
                          "Days Left",
                          "${quotaOverview["daysLeft"]}",
                          Icons.schedule,
                          warningColor,
                        ),
                      ),
                    ],
                  ),
                  // Achievement Progress
                  Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: Colors.grey[50],
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: spXs,
                      children: [
                        Row(
                          children: [
                            Text(
                              "Overall Achievement Progress",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: primaryColor,
                              ),
                            ),
                            Spacer(),
                            Text(
                              "${(quotaOverview["achievementRate"] as num).toStringAsFixed(1)}%",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: successColor,
                              ),
                            ),
                          ],
                        ),
                        Container(
                          height: 8,
                          decoration: BoxDecoration(
                            color: disabledColor,
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: FractionallySizedBox(
                            widthFactor: (quotaOverview["achievementRate"] as num) / 100,
                            alignment: Alignment.centerLeft,
                            child: Container(
                              decoration: BoxDecoration(
                                color: successColor,
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                            ),
                          ),
                        ),
                        Text(
                          "${quotaOverview["onTrackReps"]} of ${quotaOverview["totalReps"]} reps on track",
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
            ),
            
            // Team Performance
            Container(
              padding: EdgeInsets.all(spSm),
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
                    "Team Quota Performance",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  ...teamQuotas.map((team) => _buildTeamCard(team)),
                ],
              ),
            ),
            
            // Individual Performance
            Container(
              padding: EdgeInsets.all(spSm),
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
                    "Individual Quota Performance",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  ...salesReps.map((rep) => _buildRepCard(rep)),
                ],
              ),
            ),
            
            // Quota Alerts
            Container(
              padding: EdgeInsets.all(spSm),
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
                    "Quota Alerts & Actions",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  ...quotaAlerts.map((alert) => _buildAlertCard(alert)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildOverviewCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: color.withAlpha(20),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: color.withAlpha(100)),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 24),
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
              fontSize: 11,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildTeamCard(Map<String, dynamic> team) {
    Color achievementColor = _getAchievementColor((team["achievementRate"] as num).toDouble());
    
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: disabledOutlineBorderColor),
      ),
      child: Column(
        spacing: spXs,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${team["team"]}",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "Manager: ${team["manager"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    "${(team["achievementRate"] as num).toStringAsFixed(1)}%",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: achievementColor,
                    ),
                  ),
                  Text(
                    "${team["reps"]} reps",
                    style: TextStyle(
                      fontSize: 11,
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Quota: \$${((team["totalQuota"] as int).toDouble()).currency}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "Achieved: \$${((team["achieved"] as int).toDouble()).currency}",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                "Top: ${team["topPerformer"]}",
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
  
  Widget _buildRepCard(Map<String, dynamic> rep) {
    Color achievementColor = _getAchievementColor((rep["achievementRate"] as num).toDouble());
    Color statusColor = _getStatusColor(rep["status"] as String);
    
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: disabledOutlineBorderColor),
        boxShadow: [shadowXs],
      ),
      child: Column(
        spacing: spXs,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${rep["name"]}",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "${rep["role"]} • ${rep["territory"]}",
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
                  color: statusColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "${rep["status"]}",
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    color: statusColor,
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
                    Text(
                      "Quota: \$${((rep["quota"] as int).toDouble()).currency}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "Achieved: \$${((rep["achieved"] as int).toDouble()).currency}",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    "${(rep["achievementRate"] as num).toStringAsFixed(1)}%",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: achievementColor,
                    ),
                  ),
                  Text(
                    "${rep["deals"]} deals",
                    style: TextStyle(
                      fontSize: 11,
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Container(
            height: 6,
            decoration: BoxDecoration(
              color: disabledColor,
              borderRadius: BorderRadius.circular(radiusXs),
            ),
            child: FractionallySizedBox(
              widthFactor: (rep["achievementRate"] as num) / 100,
              alignment: Alignment.centerLeft,
              child: Container(
                decoration: BoxDecoration(
                  color: achievementColor,
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
              ),
            ),
          ),
          Row(
            children: [
              Text(
                "Remaining: \$${((rep["remaining"] as int).toDouble()).currency}",
                style: TextStyle(
                  fontSize: 11,
                  color: disabledBoldColor,
                ),
              ),
              Spacer(),
              Text(
                "Pipeline: \$${((rep["pipeline"] as int).toDouble()).currency}",
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
  
  Widget _buildAlertCard(Map<String, dynamic> alert) {
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: (alert["color"] as Color).withAlpha(20),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: (alert["color"] as Color).withAlpha(100)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spXs,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  "${alert["title"]}",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: alert["color"] as Color,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                decoration: BoxDecoration(
                  color: alert["color"] as Color,
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "${alert["priority"]}",
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
            "${alert["description"]}",
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),
          Row(
            children: [
              Icon(Icons.lightbulb, size: 12, color: alert["color"] as Color),
              SizedBox(width: 4),
              Expanded(
                child: Text(
                  "${alert["action"]}",
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: alert["color"] as Color,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
  
  Color _getAchievementColor(double achievement) {
    if (achievement >= 90) return successColor;
    if (achievement >= 75) return infoColor;
    if (achievement >= 60) return warningColor;
    return dangerColor;
  }
  
  Color _getStatusColor(String status) {
    switch (status) {
      case "Exceeding":
        return successColor;
      case "On Track":
        return infoColor;
      case "At Risk":
        return warningColor;
      case "Behind":
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }
  
  void _editQuotas() {
    ss("Navigate to quota editing");
  }
}
