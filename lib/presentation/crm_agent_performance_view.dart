import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class CrmAgentPerformanceView extends StatefulWidget {
  const CrmAgentPerformanceView({super.key});

  @override
  State<CrmAgentPerformanceView> createState() => _CrmAgentPerformanceViewState();
}

class _CrmAgentPerformanceViewState extends State<CrmAgentPerformanceView> {
  String selectedPeriod = "This Month";
  String selectedAgent = "All Agents";
  String selectedMetric = "Revenue";
  
  List<Map<String, dynamic>> periodOptions = [
    {"label": "This Month", "value": "This Month"},
    {"label": "Last Month", "value": "Last Month"},
    {"label": "This Quarter", "value": "This Quarter"},
    {"label": "This Year", "value": "This Year"},
  ];
  
  List<Map<String, dynamic>> agentOptions = [
    {"label": "All Agents", "value": "All Agents"},
    {"label": "Sarah Johnson", "value": "Sarah Johnson"},
    {"label": "Mike Chen", "value": "Mike Chen"},
    {"label": "Emily Davis", "value": "Emily Davis"},
    {"label": "David Wilson", "value": "David Wilson"},
  ];
  
  List<Map<String, dynamic>> metricOptions = [
    {"label": "Revenue", "value": "Revenue"},
    {"label": "Deals Closed", "value": "Deals Closed"},
    {"label": "Conversion Rate", "value": "Conversion Rate"},
    {"label": "Activity Score", "value": "Activity Score"},
  ];
  
  List<Map<String, dynamic>> performanceData = [
    {
      "agentId": "AG001",
      "agentName": "Sarah Johnson",
      "avatar": "https://picsum.photos/60/60?random=1&keyword=woman",
      "department": "Sales",
      "team": "Enterprise Sales",
      "revenue": 48000.0,
      "target": 50000.0,
      "dealsCompleted": 12,
      "dealsTarget": 10,
      "conversionRate": 24.5,
      "activityScore": 94.5,
      "callsMade": 180,
      "emailsSent": 320,
      "meetingsHeld": 45,
      "followUps": 125,
      "leadGenerated": 89,
      "qualifiedLeads": 52,
      "proposalsSent": 18,
      "monthlyGrowth": 8.5,
      "performance": 96.0,
      "ranking": 1,
      "badges": ["Top Performer", "Revenue Leader"],
    },
    {
      "agentId": "AG002",
      "agentName": "Mike Chen",
      "avatar": "https://picsum.photos/60/60?random=2&keyword=man",
      "department": "Sales",
      "team": "SMB Sales",
      "revenue": 32000.0,
      "target": 35000.0,
      "dealsCompleted": 8,
      "dealsTarget": 12,
      "conversionRate": 18.2,
      "activityScore": 87.2,
      "callsMade": 156,
      "emailsSent": 285,
      "meetingsHeld": 32,
      "followUps": 98,
      "leadGenerated": 74,
      "qualifiedLeads": 38,
      "proposalsSent": 12,
      "monthlyGrowth": 5.2,
      "performance": 91.4,
      "ranking": 2,
      "badges": ["Consistent Performer"],
    },
    {
      "agentId": "AG003",
      "agentName": "Emily Davis",
      "avatar": "https://picsum.photos/60/60?random=3&keyword=woman",
      "department": "Customer Support",
      "team": "Customer Success",
      "revenue": 0.0,
      "target": 0.0,
      "dealsCompleted": 0,
      "dealsTarget": 0,
      "conversionRate": 0.0,
      "activityScore": 96.8,
      "callsMade": 245,
      "emailsSent": 420,
      "meetingsHeld": 68,
      "followUps": 189,
      "leadGenerated": 0,
      "qualifiedLeads": 0,
      "proposalsSent": 0,
      "monthlyGrowth": 12.3,
      "performance": 96.8,
      "ranking": 1,
      "badges": ["Customer Champion", "Support Expert"],
    },
    {
      "agentId": "AG004",
      "agentName": "David Wilson",
      "avatar": "https://picsum.photos/60/60?random=4&keyword=man",
      "department": "Marketing",
      "team": "Digital Marketing",
      "revenue": 0.0,
      "target": 0.0,
      "dealsCompleted": 0,
      "dealsTarget": 0,
      "conversionRate": 0.0,
      "activityScore": 82.1,
      "callsMade": 45,
      "emailsSent": 156,
      "meetingsHeld": 28,
      "followUps": 67,
      "leadGenerated": 145,
      "qualifiedLeads": 89,
      "proposalsSent": 0,
      "monthlyGrowth": 15.7,
      "performance": 85.4,
      "ranking": 2,
      "badges": ["Lead Generator"],
    },
    {
      "agentId": "AG005",
      "agentName": "Jessica Miller",
      "avatar": "https://picsum.photos/60/60?random=5&keyword=woman",
      "department": "Sales",
      "team": "SMB Sales",
      "revenue": 15000.0,
      "target": 25000.0,
      "dealsCompleted": 4,
      "dealsTarget": 8,
      "conversionRate": 12.8,
      "activityScore": 74.6,
      "callsMade": 98,
      "emailsSent": 178,
      "meetingsHeld": 18,
      "followUps": 56,
      "leadGenerated": 42,
      "qualifiedLeads": 18,
      "proposalsSent": 6,
      "monthlyGrowth": -2.4,
      "performance": 60.0,
      "ranking": 5,
      "badges": ["Improving"],
    },
  ];
  
  List<Map<String, dynamic>> teamPerformance = [
    {
      "team": "Enterprise Sales",
      "avgPerformance": 94.5,
      "totalRevenue": 125000.0,
      "targetRevenue": 150000.0,
      "memberCount": 3,
      "topPerformer": "Sarah Johnson",
    },
    {
      "team": "SMB Sales",
      "avgPerformance": 76.0,
      "totalRevenue": 85000.0,
      "targetRevenue": 120000.0,
      "memberCount": 4,
      "topPerformer": "Mike Chen",
    },
    {
      "team": "Customer Success",
      "avgPerformance": 93.2,
      "totalRevenue": 0.0,
      "targetRevenue": 0.0,
      "memberCount": 2,
      "topPerformer": "Emily Davis",
    },
    {
      "team": "Digital Marketing",
      "avgPerformance": 85.4,
      "totalRevenue": 0.0,
      "targetRevenue": 0.0,
      "memberCount": 2,
      "topPerformer": "David Wilson",
    },
  ];

  List<Map<String, dynamic>> get filteredPerformanceData {
    List<Map<String, dynamic>> filtered = performanceData;
    
    if (selectedAgent != "All Agents") {
      filtered = filtered.where((agent) => agent["agentName"] == selectedAgent).toList();
    }
    
    return filtered;
  }
  
  Color _getPerformanceColor(double performance) {
    if (performance >= 90) return successColor;
    if (performance >= 75) return warningColor;
    return dangerColor;
  }
  
  Color _getGrowthColor(double growth) {
    if (growth > 0) return successColor;
    if (growth == 0) return warningColor;
    return dangerColor;
  }

  @override
  Widget build(BuildContext context) {
    double avgPerformance = filteredPerformanceData.isEmpty ? 0.0 : 
      filteredPerformanceData.fold(0.0, (sum, item) => sum + (item["performance"] as double)) / filteredPerformanceData.length;
    double totalRevenue = filteredPerformanceData.fold(0.0, (sum, item) => sum + (item["revenue"] as double));
    int totalDeals = filteredPerformanceData.fold(0, (sum, item) => sum + (item["dealsCompleted"] as int));
    
    return Scaffold(
      appBar: AppBar(
        title: Text("Agent Performance"),
        actions: [
          QButton(
            icon: Icons.download,
            size: bs.sm,
            onPressed: () {
              ss("Performance report exported successfully");
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
            // Filters Section
            Container(
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
                      Icon(Icons.filter_list, color: primaryColor, size: 20),
                      SizedBox(width: spXs),
                      Text(
                        "Performance Filters",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.w600,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  ResponsiveGridView(
                    padding: EdgeInsets.zero,
                    minItemWidth: 200,
                    children: [
                      QDropdownField(
                        label: "Period",
                        items: periodOptions,
                        value: selectedPeriod,
                        onChanged: (value, label) {
                          selectedPeriod = value;
                          setState(() {});
                        },
                      ),
                      QDropdownField(
                        label: "Agent",
                        items: agentOptions,
                        value: selectedAgent,
                        onChanged: (value, label) {
                          selectedAgent = value;
                          setState(() {});
                        },
                      ),
                      QDropdownField(
                        label: "Primary Metric",
                        items: metricOptions,
                        value: selectedMetric,
                        onChanged: (value, label) {
                          selectedMetric = value;
                          setState(() {});
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
            
            // Performance Summary Cards
            ResponsiveGridView(
              padding: EdgeInsets.zero,
              minItemWidth: 200,
              children: [
                Container(
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
                              color: primaryColor.withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Icon(Icons.trending_up, color: primaryColor, size: 20),
                          ),
                          SizedBox(width: spSm),
                          Text(
                            "Avg Performance",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spSm),
                      Text(
                        "${avgPerformance.toStringAsFixed(1)}%",
                        style: TextStyle(
                          fontSize: fsH4,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
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
                              color: successColor.withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Icon(Icons.attach_money, color: successColor, size: 20),
                          ),
                          SizedBox(width: spSm),
                          Text(
                            "Total Revenue",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spSm),
                      Text(
                        "\$${totalRevenue.currency}",
                        style: TextStyle(
                          fontSize: fsH4,
                          fontWeight: FontWeight.bold,
                          color: successColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
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
                              color: infoColor.withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Icon(Icons.handshake, color: infoColor, size: 20),
                          ),
                          SizedBox(width: spSm),
                          Text(
                            "Total Deals",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spSm),
                      Text(
                        "$totalDeals",
                        style: TextStyle(
                          fontSize: fsH4,
                          fontWeight: FontWeight.bold,
                          color: infoColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            
            // Individual Performance Rankings
            Container(
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
                      border: Border(
                        bottom: BorderSide(
                          color: disabledOutlineBorderColor,
                          width: 1,
                        ),
                      ),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.leaderboard, color: primaryColor, size: 20),
                        SizedBox(width: spXs),
                        Text(
                          "Performance Leaderboard",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.w600,
                            color: primaryColor,
                          ),
                        ),
                        Spacer(),
                        Text(
                          "${filteredPerformanceData.length} agents",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: filteredPerformanceData.length,
                    itemBuilder: (context, index) {
                      final agent = filteredPerformanceData[index];
                      final performanceColor = _getPerformanceColor(agent["performance"] as double);
                      final growthColor = _getGrowthColor(agent["monthlyGrowth"] as double);
                      final isSalesAgent = (agent["revenue"] as double) > 0;
                      
                      return Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: disabledOutlineBorderColor.withAlpha(100),
                              width: 0.5,
                            ),
                          ),
                        ),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                // Ranking Badge
                                Container(
                                  width: 30,
                                  height: 30,
                                  decoration: BoxDecoration(
                                    color: performanceColor.withAlpha(20),
                                    borderRadius: BorderRadius.circular(radiusLg),
                                  ),
                                  child: Center(
                                    child: Text(
                                      "#${agent["ranking"]}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        color: performanceColor,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(width: spSm),
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(radiusLg),
                                  child: Image.network(
                                    "${agent["avatar"]}",
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
                                            "${agent["agentName"]}",
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600,
                                              color: primaryColor,
                                            ),
                                          ),
                                          SizedBox(width: spXs),
                                          Container(
                                            padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                            decoration: BoxDecoration(
                                              color: performanceColor.withAlpha(20),
                                              borderRadius: BorderRadius.circular(radiusXs),
                                            ),
                                            child: Text(
                                              "${(agent["performance"] as double).toStringAsFixed(1)}%",
                                              style: TextStyle(
                                                fontSize: 10,
                                                fontWeight: FontWeight.w600,
                                                color: performanceColor,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: spXs),
                                      Text(
                                        "${agent["team"]} • ${agent["department"]}",
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
                                      "${(agent["monthlyGrowth"] as double) >= 0 ? '+' : ''}${(agent["monthlyGrowth"] as double).toStringAsFixed(1)}%",
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: growthColor,
                                      ),
                                    ),
                                    Text(
                                      "Growth",
                                      style: TextStyle(
                                        fontSize: 10,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            
                            SizedBox(height: spSm),
                            
                            // Performance Metrics
                            Container(
                              padding: EdgeInsets.all(spSm),
                              decoration: BoxDecoration(
                                color: primaryColor.withAlpha(5),
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Column(
                                children: [
                                  if (isSalesAgent) ...[
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "Revenue",
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  color: disabledBoldColor,
                                                ),
                                              ),
                                              Text(
                                                "\$${(agent["revenue"] as double).currency}",
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w600,
                                                  color: successColor,
                                                ),
                                              ),
                                              if ((agent["target"] as double) > 0)
                                                Text(
                                                  "Target: \$${(agent["target"] as double).currency}",
                                                  style: TextStyle(
                                                    fontSize: 10,
                                                    color: disabledBoldColor,
                                                  ),
                                                ),
                                            ],
                                          ),
                                        ),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "Deals Closed",
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  color: disabledBoldColor,
                                                ),
                                              ),
                                              Text(
                                                "${agent["dealsCompleted"]}/${agent["dealsTarget"]}",
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w600,
                                                  color: primaryColor,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "Conversion",
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  color: disabledBoldColor,
                                                ),
                                              ),
                                              Text(
                                                "${(agent["conversionRate"] as double).toStringAsFixed(1)}%",
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w600,
                                                  color: infoColor,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: spSm),
                                  ],
                                  
                                  // Activity Metrics
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Calls Made",
                                              style: TextStyle(
                                                fontSize: 12,
                                                color: disabledBoldColor,
                                              ),
                                            ),
                                            Text(
                                              "${agent["callsMade"]}",
                                              style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600,
                                                color: primaryColor,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Emails Sent",
                                              style: TextStyle(
                                                fontSize: 12,
                                                color: disabledBoldColor,
                                              ),
                                            ),
                                            Text(
                                              "${agent["emailsSent"]}",
                                              style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600,
                                                color: infoColor,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Meetings",
                                              style: TextStyle(
                                                fontSize: 12,
                                                color: disabledBoldColor,
                                              ),
                                            ),
                                            Text(
                                              "${agent["meetingsHeld"]}",
                                              style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600,
                                                color: warningColor,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Follow-ups",
                                              style: TextStyle(
                                                fontSize: 12,
                                                color: disabledBoldColor,
                                              ),
                                            ),
                                            Text(
                                              "${agent["followUps"]}",
                                              style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600,
                                                color: successColor,
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
                            
                            // Badges
                            if ((agent["badges"] as List).isNotEmpty) ...[
                              SizedBox(height: spSm),
                              Wrap(
                                spacing: spXs,
                                runSpacing: spXs,
                                children: (agent["badges"] as List).map((badge) {
                                  return Container(
                                    padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                    decoration: BoxDecoration(
                                      color: successColor.withAlpha(20),
                                      borderRadius: BorderRadius.circular(radiusXs),
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Icon(Icons.star, color: successColor, size: 12),
                                        SizedBox(width: 2),
                                        Text(
                                          "$badge",
                                          style: TextStyle(
                                            fontSize: 10,
                                            color: successColor,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                }).toList(),
                              ),
                            ],
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
            
            // Team Performance Summary
            Container(
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
                      border: Border(
                        bottom: BorderSide(
                          color: disabledOutlineBorderColor,
                          width: 1,
                        ),
                      ),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.groups, color: primaryColor, size: 20),
                        SizedBox(width: spXs),
                        Text(
                          "Team Performance Summary",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.w600,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: teamPerformance.length,
                    itemBuilder: (context, index) {
                      final team = teamPerformance[index];
                      final teamPerformanceColor = _getPerformanceColor(team["avgPerformance"] as double);
                      final hasRevenue = (team["totalRevenue"] as double) > 0;
                      
                      return Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: disabledOutlineBorderColor.withAlpha(100),
                              width: 0.5,
                            ),
                          ),
                        ),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Container(
                                  padding: EdgeInsets.all(spXs),
                                  decoration: BoxDecoration(
                                    color: teamPerformanceColor.withAlpha(20),
                                    borderRadius: BorderRadius.circular(radiusSm),
                                  ),
                                  child: Icon(Icons.groups, color: teamPerformanceColor, size: 20),
                                ),
                                SizedBox(width: spSm),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "${team["team"]}",
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                          color: primaryColor,
                                        ),
                                      ),
                                      SizedBox(height: spXs),
                                      Text(
                                        "${team["memberCount"]} members • Top: ${team["topPerformer"]}",
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
                                    color: teamPerformanceColor.withAlpha(20),
                                    borderRadius: BorderRadius.circular(radiusSm),
                                  ),
                                  child: Text(
                                    "${(team["avgPerformance"] as double).toStringAsFixed(1)}%",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: teamPerformanceColor,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            
                            if (hasRevenue) ...[
                              SizedBox(height: spSm),
                              Container(
                                padding: EdgeInsets.all(spSm),
                                decoration: BoxDecoration(
                                  color: primaryColor.withAlpha(5),
                                  borderRadius: BorderRadius.circular(radiusSm),
                                ),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Total Revenue",
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: disabledBoldColor,
                                            ),
                                          ),
                                          Text(
                                            "\$${(team["totalRevenue"] as double).currency}",
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600,
                                              color: successColor,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Target Revenue",
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: disabledBoldColor,
                                            ),
                                          ),
                                          Text(
                                            "\$${(team["targetRevenue"] as double).currency}",
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600,
                                              color: primaryColor,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Achievement",
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: disabledBoldColor,
                                            ),
                                          ),
                                          Text(
                                            "${(((team["totalRevenue"] as double) / (team["targetRevenue"] as double)) * 100).toStringAsFixed(1)}%",
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600,
                                              color: infoColor,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
