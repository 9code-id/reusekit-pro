import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class CmaLeadDistributionView extends StatefulWidget {
  const CmaLeadDistributionView({super.key});

  @override
  State<CmaLeadDistributionView> createState() => _CmaLeadDistributionViewState();
}

class _CmaLeadDistributionViewState extends State<CmaLeadDistributionView> {
  String selectedDistributionMethod = "Round Robin";
  String selectedTeam = "All";
  String selectedPeriod = "This Month";
  bool autoDistribution = true;
  
  List<Map<String, dynamic>> distributionMethods = [
    {"label": "Round Robin", "value": "Round Robin"},
    {"label": "Lead Score Based", "value": "Lead Score Based"},
    {"label": "Workload Based", "value": "Workload Based"},
    {"label": "Territory Based", "value": "Territory Based"},
    {"label": "Skill Based", "value": "Skill Based"},
    {"label": "Manual Assignment", "value": "Manual Assignment"},
  ];
  
  List<Map<String, dynamic>> teamItems = [
    {"label": "All", "value": "All"},
    {"label": "Sales Team A", "value": "Sales Team A"},
    {"label": "Sales Team B", "value": "Sales Team B"},
    {"label": "Enterprise Team", "value": "Enterprise Team"},
    {"label": "SMB Team", "value": "SMB Team"},
  ];
  
  List<Map<String, dynamic>> periodItems = [
    {"label": "Today", "value": "Today"},
    {"label": "This Week", "value": "This Week"},
    {"label": "This Month", "value": "This Month"},
    {"label": "This Quarter", "value": "This Quarter"},
  ];

  List<Map<String, dynamic>> salesReps = [
    {
      "id": "1",
      "name": "John Anderson",
      "email": "john.a@company.com",
      "team": "Sales Team A",
      "avatar": "https://picsum.photos/50/50?random=1",
      "totalAssigned": 45,
      "thisWeek": 8,
      "conversionRate": 35.2,
      "avgDealSize": 18500,
      "workloadPercentage": 75.0,
      "skills": ["Enterprise", "Technology", "SaaS"],
      "territory": "North America",
      "status": "Available",
    },
    {
      "id": "2",
      "name": "Sarah Mitchell",
      "email": "sarah.m@company.com",
      "team": "Sales Team A",
      "avatar": "https://picsum.photos/50/50?random=2",
      "totalAssigned": 52,
      "thisWeek": 12,
      "conversionRate": 42.8,
      "avgDealSize": 22000,
      "workloadPercentage": 90.0,
      "skills": ["SMB", "Healthcare", "Finance"],
      "territory": "North America",
      "status": "Busy",
    },
    {
      "id": "3",
      "name": "Michael Chen",
      "email": "michael.c@company.com",
      "team": "Enterprise Team",
      "avatar": "https://picsum.photos/50/50?random=3",
      "totalAssigned": 28,
      "thisWeek": 4,
      "conversionRate": 55.0,
      "avgDealSize": 45000,
      "workloadPercentage": 60.0,
      "skills": ["Enterprise", "Manufacturing", "Enterprise"],
      "territory": "Global",
      "status": "Available",
    },
    {
      "id": "4",
      "name": "Emily Davis",
      "email": "emily.d@company.com",
      "team": "SMB Team",
      "avatar": "https://picsum.photos/50/50?random=4",
      "totalAssigned": 38,
      "thisWeek": 9,
      "conversionRate": 38.5,
      "avgDealSize": 12000,
      "workloadPercentage": 85.0,
      "skills": ["SMB", "Retail", "E-commerce"],
      "territory": "Europe",
      "status": "Available",
    },
    {
      "id": "5",
      "name": "David Wilson",
      "email": "david.w@company.com",
      "team": "Sales Team B",
      "avatar": "https://picsum.photos/50/50?random=5",
      "totalAssigned": 33,
      "thisWeek": 6,
      "conversionRate": 28.9,
      "avgDealSize": 15500,
      "workloadPercentage": 55.0,
      "skills": ["Technology", "Startups", "SaaS"],
      "territory": "Asia Pacific",
      "status": "Available",
    },
  ];

  List<Map<String, dynamic>> distributionQueue = [
    {
      "id": "1",
      "leadName": "Tech Innovations Inc",
      "leadContact": "Alex Thompson",
      "leadScore": 85,
      "estimatedValue": 35000,
      "territory": "North America",
      "industry": "Technology",
      "priority": "High",
      "source": "Website",
      "receivedAt": "2024-01-16 10:30",
      "status": "Pending",
      "requiredSkills": ["Enterprise", "Technology"],
    },
    {
      "id": "2",
      "leadName": "Healthcare Solutions",
      "leadContact": "Maria Rodriguez",
      "leadScore": 72,
      "estimatedValue": 28000,
      "territory": "North America",
      "industry": "Healthcare",
      "priority": "Medium",
      "source": "Referral",
      "receivedAt": "2024-01-16 11:15",
      "status": "Pending",
      "requiredSkills": ["Healthcare", "SMB"],
    },
    {
      "id": "3",
      "leadName": "Global Manufacturing Corp",
      "leadContact": "James Wilson",
      "leadScore": 94,
      "estimatedValue": 75000,
      "territory": "Global",
      "industry": "Manufacturing",
      "priority": "High",
      "source": "Trade Show",
      "receivedAt": "2024-01-16 09:45",
      "status": "Assigned",
      "requiredSkills": ["Enterprise", "Manufacturing"],
      "assignedTo": "Michael Chen",
    },
    {
      "id": "4",
      "leadName": "E-commerce Startup",
      "leadContact": "Lisa Chang",
      "leadScore": 58,
      "estimatedValue": 12000,
      "territory": "Asia Pacific",
      "industry": "E-commerce",
      "priority": "Low",
      "source": "Social Media",
      "receivedAt": "2024-01-16 12:00",
      "status": "Pending",
      "requiredSkills": ["SMB", "E-commerce"],
    },
  ];

  List<Map<String, dynamic>> get filteredReps {
    if (selectedTeam == "All") return salesReps;
    return salesReps.where((rep) => rep["team"] == selectedTeam).toList();
  }

  Color _getWorkloadColor(double percentage) {
    if (percentage >= 90) return dangerColor;
    if (percentage >= 75) return warningColor;
    if (percentage >= 50) return successColor;
    return infoColor;
  }

  Color _getPriorityColor(String priority) {
    switch (priority) {
      case "High":
        return dangerColor;
      case "Medium":
        return warningColor;
      case "Low":
        return successColor;
      default:
        return disabledColor;
    }
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "Pending":
        return warningColor;
      case "Assigned":
        return successColor;
      case "Processing":
        return infoColor;
      default:
        return disabledColor;
    }
  }

  String _getRecommendedAssignee(Map<String, dynamic> lead) {
    List<String> requiredSkills = (lead["requiredSkills"] as List).cast<String>();
    String territory = lead["territory"];
    int leadScore = lead["leadScore"];
    
    // Find best match based on skills, territory, and workload
    var eligibleReps = salesReps.where((rep) {
      bool hasSkills = requiredSkills.any((skill) => 
        (rep["skills"] as List).contains(skill));
      bool matchesTerritory = rep["territory"] == territory || rep["territory"] == "Global";
      bool available = rep["workloadPercentage"] < 95;
      
      return hasSkills && matchesTerritory && available;
    }).toList();
    
    if (eligibleReps.isEmpty) {
      return "No suitable rep available";
    }
    
    // Sort by conversion rate and workload
    eligibleReps.sort((a, b) {
      double scoreA = (a["conversionRate"] as double) - (a["workloadPercentage"] as double);
      double scoreB = (b["conversionRate"] as double) - (b["workloadPercentage"] as double);
      return scoreB.compareTo(scoreA);
    });
    
    return eligibleReps.first["name"];
  }

  void _configureDistribution() {
    //navigateTo('CmaDistributionConfigView')
  }

  void _processQueue() async {
    showLoading();
    await Future.delayed(Duration(seconds: 3));
    hideLoading();
    
    // Update pending leads to assigned
    for (var lead in distributionQueue) {
      if (lead["status"] == "Pending") {
        lead["status"] = "Assigned";
        lead["assignedTo"] = _getRecommendedAssignee(lead);
      }
    }
    
    setState(() {});
    ss("${distributionQueue.where((l) => l["status"] == "Assigned").length} leads distributed successfully");
  }

  void _manualAssign(Map<String, dynamic> lead) {
    //navigateTo('CmaManualAssignView')
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Lead Distribution"),
        actions: [
          QButton(
            icon: Icons.settings,
            size: bs.sm,
            onPressed: _configureDistribution,
          ),
          SizedBox(width: spSm),
          QButton(
            label: "Process Queue",
            size: bs.sm,
            onPressed: _processQueue,
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
            _buildDistributionSettings(),
            _buildTeamWorkload(),
            _buildDistributionQueue(),
            _buildDistributionAnalytics(),
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
          colors: [infoColor, infoColor.withAlpha(200)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(radiusMd),
      ),
      child: Row(
        children: [
          Icon(
            Icons.share,
            color: Colors.white,
            size: 32,
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Intelligent Lead Distribution",
                  style: TextStyle(
                    fontSize: fsH5,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Text(
                  "Automatically distribute leads based on skills and workload",
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
              color: autoDistribution ? successColor : warningColor,
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Text(
              autoDistribution ? "AUTO ON" : "MANUAL",
              style: TextStyle(
                fontSize: 12,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDistributionSettings() {
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
                Icons.tune,
                color: primaryColor,
                size: 20,
              ),
              SizedBox(width: spXs),
              Text(
                "Distribution Settings",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: QDropdownField(
                  label: "Distribution Method",
                  items: distributionMethods,
                  value: selectedDistributionMethod,
                  onChanged: (value, label) {
                    selectedDistributionMethod = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QDropdownField(
                  label: "Filter Team",
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
          Row(
            children: [
              Expanded(
                child: QSwitch(
                  items: [
                    {
                      "label": "Auto Distribution",
                      "value": true,
                      "checked": autoDistribution,
                    }
                  ],
                  value: [
                    if (autoDistribution)
                      {
                        "label": "Auto Distribution",
                        "value": true,
                        "checked": true
                      }
                  ],
                  onChanged: (values, ids) {
                    autoDistribution = values.isNotEmpty;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Text(
                autoDistribution 
                  ? "Leads will be distributed automatically"
                  : "Manual distribution required",
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

  Widget _buildTeamWorkload() {
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
                Icons.people,
                color: primaryColor,
                size: 20,
              ),
              SizedBox(width: spXs),
              Text(
                "Team Workload Distribution",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          Column(
            spacing: spSm,
            children: List.generate(filteredReps.length, (index) {
              final rep = filteredReps[index];
              return _buildWorkloadCard(rep);
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildWorkloadCard(Map<String, dynamic> rep) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: _getWorkloadColor(rep["workloadPercentage"]).withAlpha(20),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(
          color: _getWorkloadColor(rep["workloadPercentage"]).withAlpha(100),
        ),
      ),
      child: Column(
        spacing: spSm,
        children: [
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(radiusLg),
                  image: DecorationImage(
                    image: NetworkImage("${rep["avatar"]}"),
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
                            "${rep["name"]}",
                            style: TextStyle(
                              fontSize: fsH6,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                        ),
                        Text(
                          "${rep["workloadPercentage"].toStringAsFixed(0)}% capacity",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: _getWorkloadColor(rep["workloadPercentage"]),
                          ),
                        ),
                      ],
                    ),
                    Text(
                      "${rep["team"]} • ${rep["territory"]}",
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
          Container(
            height: 8,
            decoration: BoxDecoration(
              color: disabledColor.withAlpha(50),
              borderRadius: BorderRadius.circular(radiusXs),
            ),
            child: FractionallySizedBox(
              alignment: Alignment.centerLeft,
              widthFactor: (rep["workloadPercentage"] as double) / 100,
              child: Container(
                decoration: BoxDecoration(
                  color: _getWorkloadColor(rep["workloadPercentage"]),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
              ),
            ),
          ),
          Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    Text(
                      "${rep["totalAssigned"]}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "Total Assigned",
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
                  children: [
                    Text(
                      "${rep["thisWeek"]}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: warningColor,
                      ),
                    ),
                    Text(
                      "This Week",
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
                  children: [
                    Text(
                      "${rep["conversionRate"].toStringAsFixed(1)}%",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: successColor,
                      ),
                    ),
                    Text(
                      "Conv. Rate",
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
                  children: [
                    Text(
                      "\$${((rep["avgDealSize"] as int) / 1000).toStringAsFixed(0)}K",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: infoColor,
                      ),
                    ),
                    Text(
                      "Avg Deal",
                      style: TextStyle(
                        fontSize: 10,
                        color: disabledBoldColor,
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

  Widget _buildDistributionQueue() {
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
                Icons.queue,
                color: primaryColor,
                size: 20,
              ),
              SizedBox(width: spXs),
              Text(
                "Distribution Queue",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Spacer(),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: warningColor.withAlpha(30),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Text(
                  "${distributionQueue.where((l) => l["status"] == "Pending").length} Pending",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: warningColor,
                  ),
                ),
              ),
            ],
          ),
          Column(
            spacing: spSm,
            children: List.generate(distributionQueue.length, (index) {
              final lead = distributionQueue[index];
              return _buildQueueCard(lead);
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildQueueCard(Map<String, dynamic> lead) {
    String recommendedAssignee = _getRecommendedAssignee(lead);
    
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: _getStatusColor(lead["status"]).withAlpha(10),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(
          color: _getStatusColor(lead["status"]).withAlpha(100),
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
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            "${lead["leadName"]}",
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
                            color: _getPriorityColor(lead["priority"]).withAlpha(30),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Text(
                            "${lead["priority"]}",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: _getPriorityColor(lead["priority"]),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Text(
                      "Contact: ${lead["leadContact"]}",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "Industry: ${lead["industry"]} • Territory: ${lead["territory"]}",
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
          Divider(color: disabledOutlineBorderColor),
          Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    Text(
                      "${lead["leadScore"]}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: successColor,
                      ),
                    ),
                    Text(
                      "Score",
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
                  children: [
                    Text(
                      "\$${((lead["estimatedValue"] as int) / 1000).toStringAsFixed(0)}K",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: warningColor,
                      ),
                    ),
                    Text(
                      "Value",
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
                  children: [
                    Text(
                      "${lead["source"]}",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: infoColor,
                      ),
                    ),
                    Text(
                      "Source",
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
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                      decoration: BoxDecoration(
                        color: _getStatusColor(lead["status"]),
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Text(
                        "${lead["status"]}",
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Text(
                      "Status",
                      style: TextStyle(
                        fontSize: 10,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          if (lead["status"] == "Pending") ...[
            Divider(color: disabledOutlineBorderColor),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spXs),
              decoration: BoxDecoration(
                color: successColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusXs),
              ),
              child: Text(
                "Recommended: $recommendedAssignee",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: successColor,
                ),
              ),
            ),
            Row(
              children: [
                Text(
                  "Received: ${lead["receivedAt"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
                Spacer(),
                QButton(
                  label: "Manual Assign",
                  size: bs.sm,
                  onPressed: () => _manualAssign(lead),
                ),
              ],
            ),
          ],
          if (lead["status"] == "Assigned") ...[
            Divider(color: disabledOutlineBorderColor),
            Row(
              children: [
                Text(
                  "Assigned to: ${lead["assignedTo"]}",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: successColor,
                  ),
                ),
                Spacer(),
                Text(
                  "Received: ${lead["receivedAt"]}",
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
    );
  }

  Widget _buildDistributionAnalytics() {
    int totalDistributed = distributionQueue.where((l) => l["status"] == "Assigned").length;
    int pendingDistribution = distributionQueue.where((l) => l["status"] == "Pending").length;
    double avgResponseTime = 15.5; // minutes
    double distributionEfficiency = totalDistributed > 0 ? (totalDistributed / distributionQueue.length) * 100 : 0;

    return Row(
      children: [
        Expanded(
          child: _buildStatCard(
            title: "Distributed",
            value: "$totalDistributed",
            icon: Icons.check_circle,
            color: successColor,
          ),
        ),
        SizedBox(width: spSm),
        Expanded(
          child: _buildStatCard(
            title: "Pending",
            value: "$pendingDistribution",
            icon: Icons.pending,
            color: warningColor,
          ),
        ),
        SizedBox(width: spSm),
        Expanded(
          child: _buildStatCard(
            title: "Avg Response",
            value: "${avgResponseTime.toStringAsFixed(0)}m",
            icon: Icons.access_time,
            color: infoColor,
          ),
        ),
        SizedBox(width: spSm),
        Expanded(
          child: _buildStatCard(
            title: "Efficiency",
            value: "${distributionEfficiency.toStringAsFixed(0)}%",
            icon: Icons.trending_up,
            color: primaryColor,
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
}
