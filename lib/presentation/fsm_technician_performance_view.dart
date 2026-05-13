import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class FsmTechnicianPerformanceView extends StatefulWidget {
  const FsmTechnicianPerformanceView({super.key});

  @override
  State<FsmTechnicianPerformanceView> createState() => _FsmTechnicianPerformanceViewState();
}

class _FsmTechnicianPerformanceViewState extends State<FsmTechnicianPerformanceView> {
  int selectedPeriod = 0;
  String selectedMetric = "Overall";
  String selectedTechnician = "All Technicians";
  String selectedTeam = "All Teams";

  final List<String> periods = ["This Week", "This Month", "This Quarter", "This Year"];
  
  final List<Map<String, dynamic>> metricOptions = [
    {"label": "Overall", "value": "Overall"},
    {"label": "Job Completion", "value": "Job Completion"},
    {"label": "Customer Satisfaction", "value": "Customer Satisfaction"},
    {"label": "Response Time", "value": "Response Time"},
    {"label": "Quality Score", "value": "Quality Score"},
  ];

  final List<Map<String, dynamic>> technicianOptions = [
    {"label": "All Technicians", "value": "All Technicians"},
    {"label": "John Smith", "value": "John Smith"},
    {"label": "Sarah Johnson", "value": "Sarah Johnson"},
    {"label": "Mike Rodriguez", "value": "Mike Rodriguez"},
    {"label": "Emily Chen", "value": "Emily Chen"},
    {"label": "David Wilson", "value": "David Wilson"},
    {"label": "Lisa Thompson", "value": "Lisa Thompson"},
  ];

  final List<Map<String, dynamic>> teamOptions = [
    {"label": "All Teams", "value": "All Teams"},
    {"label": "Team Alpha", "value": "Team Alpha"},
    {"label": "Team Beta", "value": "Team Beta"},
    {"label": "Team Gamma", "value": "Team Gamma"},
    {"label": "Emergency Team", "value": "Emergency Team"},
  ];

  final List<Map<String, dynamic>> performanceData = [
    {
      "id": "TECH001",
      "name": "John Smith",
      "avatar": "https://picsum.photos/50/50?random=1&keyword=man",
      "team": "Team Alpha",
      "overallScore": 92,
      "jobsCompleted": 147,
      "avgResponseTime": "12 min",
      "customerRating": 4.8,
      "qualityScore": 94,
      "efficiency": 88,
      "punctuality": 95,
      "skillLevel": "Expert",
      "monthlyGrowth": 5.2,
      "weeklyJobs": 28,
      "monthlyJobs": 147,
      "quarterlyJobs": 445,
      "yearlyJobs": 1789,
      "totalEarnings": 12450,
      "certifications": 8,
      "specializations": ["Networking", "Electrical", "Emergency Response"],
      "recentAchievements": [
        "Customer Champion - March 2024",
        "Fastest Response Time - February 2024",
        "Quality Excellence Award - January 2024"
      ],
    },
    {
      "id": "TECH002",
      "name": "Sarah Johnson",
      "avatar": "https://picsum.photos/50/50?random=2&keyword=woman",
      "team": "Team Beta",
      "overallScore": 89,
      "jobsCompleted": 132,
      "avgResponseTime": "15 min",
      "customerRating": 4.7,
      "qualityScore": 91,
      "efficiency": 85,
      "punctuality": 92,
      "skillLevel": "Expert",
      "monthlyGrowth": 3.8,
      "weeklyJobs": 25,
      "monthlyJobs": 132,
      "quarterlyJobs": 398,
      "yearlyJobs": 1592,
      "totalEarnings": 11280,
      "certifications": 6,
      "specializations": ["Server Management", "Cloud Services", "Database"],
      "recentAchievements": [
        "Technical Innovation Award - March 2024",
        "Team Player of the Month - February 2024"
      ],
    },
    {
      "id": "TECH003",
      "name": "Mike Rodriguez",
      "avatar": "https://picsum.photos/50/50?random=3&keyword=man",
      "team": "Emergency Team",
      "overallScore": 95,
      "jobsCompleted": 89,
      "avgResponseTime": "8 min",
      "customerRating": 4.9,
      "qualityScore": 97,
      "efficiency": 92,
      "punctuality": 98,
      "skillLevel": "Master",
      "monthlyGrowth": 7.1,
      "weeklyJobs": 18,
      "monthlyJobs": 89,
      "quarterlyJobs": 267,
      "yearlyJobs": 1068,
      "totalEarnings": 15890,
      "certifications": 12,
      "specializations": ["Emergency Response", "Critical Systems", "Safety"],
      "recentAchievements": [
        "Emergency Hero - March 2024",
        "Perfect Score Achievement - February 2024",
        "Leadership Excellence - January 2024"
      ],
    },
    {
      "id": "TECH004",
      "name": "Emily Chen",
      "avatar": "https://picsum.photos/50/50?random=4&keyword=woman",
      "team": "Team Gamma",
      "overallScore": 87,
      "jobsCompleted": 156,
      "avgResponseTime": "14 min",
      "customerRating": 4.6,
      "qualityScore": 89,
      "efficiency": 90,
      "punctuality": 88,
      "skillLevel": "Senior",
      "monthlyGrowth": 4.5,
      "weeklyJobs": 31,
      "monthlyJobs": 156,
      "quarterlyJobs": 468,
      "yearlyJobs": 1872,
      "totalEarnings": 10950,
      "certifications": 5,
      "specializations": ["Quality Assurance", "Testing", "Documentation"],
      "recentAchievements": [
        "Quality Assurance Expert - March 2024",
        "Process Improvement Award - January 2024"
      ],
    },
    {
      "id": "TECH005",
      "name": "David Wilson",
      "avatar": "https://picsum.photos/50/50?random=5&keyword=man",
      "team": "Team Alpha",
      "overallScore": 83,
      "jobsCompleted": 98,
      "avgResponseTime": "18 min",
      "customerRating": 4.4,
      "qualityScore": 85,
      "efficiency": 82,
      "punctuality": 85,
      "skillLevel": "Senior",
      "monthlyGrowth": 2.1,
      "weeklyJobs": 19,
      "monthlyJobs": 98,
      "quarterlyJobs": 294,
      "yearlyJobs": 1176,
      "totalEarnings": 9680,
      "certifications": 4,
      "specializations": ["System Administration", "Database", "Maintenance"],
      "recentAchievements": [
        "Consistent Performance - February 2024"
      ],
    },
    {
      "id": "TECH006",
      "name": "Lisa Thompson",
      "avatar": "https://picsum.photos/50/50?random=6&keyword=woman",
      "team": "Team Beta",
      "overallScore": 91,
      "jobsCompleted": 178,
      "avgResponseTime": "11 min",
      "customerRating": 4.8,
      "qualityScore": 93,
      "efficiency": 89,
      "punctuality": 94,
      "skillLevel": "Expert",
      "monthlyGrowth": 6.3,
      "weeklyJobs": 34,
      "monthlyJobs": 178,
      "quarterlyJobs": 534,
      "yearlyJobs": 2136,
      "totalEarnings": 13250,
      "certifications": 7,
      "specializations": ["Network Installation", "Training", "Mentoring"],
      "recentAchievements": [
        "Mentor of the Year - March 2024",
        "High Performance Award - February 2024",
        "Customer Excellence - January 2024"
      ],
    },
  ];

  List<Map<String, dynamic>> get filteredPerformanceData {
    return performanceData.where((tech) {
      final matchesTechnician = selectedTechnician == "All Technicians" || tech["name"] == selectedTechnician;
      final matchesTeam = selectedTeam == "All Teams" || tech["team"] == selectedTeam;
      return matchesTechnician && matchesTeam;
    }).toList();
  }

  Color _getPerformanceColor(int score) {
    if (score >= 90) return successColor;
    if (score >= 80) return warningColor;
    if (score >= 70) return infoColor;
    return dangerColor;
  }

  String _getPerformanceLevel(int score) {
    if (score >= 95) return "Exceptional";
    if (score >= 90) return "Excellent";
    if (score >= 80) return "Good";
    if (score >= 70) return "Average";
    return "Needs Improvement";
  }

  void _showTechnicianDetails(Map<String, dynamic> technician) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Row(
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage("${technician["avatar"]}"),
              radius: 20,
            ),
            SizedBox(width: spSm),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${technician["name"]}",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        "${technician["id"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                      SizedBox(width: spSm),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: spSm, vertical: 2),
                        decoration: BoxDecoration(
                          color: _getPerformanceColor((technician["overallScore"] as int)).withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Text(
                          "${technician["skillLevel"]}",
                          style: TextStyle(
                            fontSize: 10,
                            color: _getPerformanceColor((technician["overallScore"] as int)),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: _getPerformanceColor((technician["overallScore"] as int)).withAlpha(10),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Overall Score",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                        Text(
                          "${technician["overallScore"]}/100",
                          style: TextStyle(
                            fontSize: fsH4,
                            fontWeight: FontWeight.bold,
                            color: _getPerformanceColor((technician["overallScore"] as int)),
                          ),
                        ),
                      ],
                    ),
                    Spacer(),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          "Performance Level",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                        Text(
                          _getPerformanceLevel((technician["overallScore"] as int)),
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: _getPerformanceColor((technician["overallScore"] as int)),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: spSm),
              
              Text(
                "Key Metrics:",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ),
              SizedBox(height: spXs),
              
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.grey.withAlpha(10),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Jobs Completed",
                                style: TextStyle(fontSize: 12, color: disabledBoldColor),
                              ),
                              Text(
                                "${technician["jobsCompleted"]}",
                                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Avg Response",
                                style: TextStyle(fontSize: 12, color: disabledBoldColor),
                              ),
                              Text(
                                "${technician["avgResponseTime"]}",
                                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spSm),
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Customer Rating",
                                style: TextStyle(fontSize: 12, color: disabledBoldColor),
                              ),
                              Row(
                                children: [
                                  Icon(Icons.star, color: warningColor, size: 16),
                                  SizedBox(width: spXs),
                                  Text(
                                    "${technician["customerRating"]}",
                                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Quality Score",
                                style: TextStyle(fontSize: 12, color: disabledBoldColor),
                              ),
                              Text(
                                "${technician["qualityScore"]}%",
                                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: spSm),
              
              Text(
                "Performance Breakdown:",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ),
              SizedBox(height: spXs),
              
              _buildPerformanceBar("Efficiency", (technician["efficiency"] as int)),
              SizedBox(height: spXs),
              _buildPerformanceBar("Punctuality", (technician["punctuality"] as int)),
              SizedBox(height: spXs),
              _buildPerformanceBar("Quality", (technician["qualityScore"] as int)),
              SizedBox(height: spSm),
              
              Text(
                "Specializations:",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ),
              SizedBox(height: spXs),
              Wrap(
                spacing: spXs,
                runSpacing: spXs,
                children: (technician["specializations"] as List).map<Widget>((spec) {
                  return Container(
                    padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                    decoration: BoxDecoration(
                      color: primaryColor.withAlpha(10),
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                    child: Text(
                      "$spec",
                      style: TextStyle(
                        fontSize: 11,
                        color: primaryColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  );
                }).toList(),
              ),
              SizedBox(height: spSm),
              
              if ((technician["recentAchievements"] as List).isNotEmpty) ...[
                Text(
                  "Recent Achievements:",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
                SizedBox(height: spXs),
                ...(technician["recentAchievements"] as List).map<Widget>((achievement) {
                  return Container(
                    margin: EdgeInsets.only(bottom: spXs),
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: successColor.withAlpha(10),
                      borderRadius: BorderRadius.circular(radiusSm),
                      border: Border.all(color: successColor.withAlpha(30), width: 1),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.emoji_events, color: successColor, size: 16),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Text(
                            "$achievement",
                            style: TextStyle(
                              fontSize: 12,
                              color: successColor,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ],
            ],
          ),
        ),
        actions: [
          QButton(
            label: "Send Feedback",
            size: bs.sm,
            onPressed: () {
              back();
              ss("Feedback form opened for ${technician["name"]}");
            },
          ),
          QButton(
            label: "View Report",
            size: bs.sm,
            onPressed: () {
              back();
              ss("Detailed performance report for ${technician["name"]}");
            },
          ),
        ],
      ),
    );
  }

  Widget _buildPerformanceBar(String label, int value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: TextStyle(fontSize: 12, color: disabledBoldColor),
            ),
            Text(
              "$value%",
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
            ),
          ],
        ),
        SizedBox(height: spXs),
        Container(
          height: 6,
          decoration: BoxDecoration(
            color: disabledColor.withAlpha(30),
            borderRadius: BorderRadius.circular(radiusXs),
          ),
          child: FractionallySizedBox(
            alignment: Alignment.centerLeft,
            widthFactor: value / 100,
            child: Container(
              decoration: BoxDecoration(
                color: _getPerformanceColor(value),
                borderRadius: BorderRadius.circular(radiusXs),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildOverallMetrics() {
    final avgScore = (filteredPerformanceData.map((t) => t["overallScore"] as int).reduce((a, b) => a + b) / filteredPerformanceData.length).round();
    final totalJobs = filteredPerformanceData.map((t) => t["jobsCompleted"] as int).reduce((a, b) => a + b);
    final avgRating = (filteredPerformanceData.map((t) => t["customerRating"] as double).reduce((a, b) => a + b) / filteredPerformanceData.length);
    final totalEarnings = filteredPerformanceData.map((t) => t["totalEarnings"] as int).reduce((a, b) => a + b);

    return ResponsiveGridView(
      padding: EdgeInsets.all(spSm),
      minItemWidth: 160,
      children: [
        _buildMetricCard("Avg Performance", "$avgScore%", _getPerformanceColor(avgScore), Icons.trending_up),
        _buildMetricCard("Total Jobs", "$totalJobs", primaryColor, Icons.work),
        _buildMetricCard("Avg Rating", "${avgRating.toStringAsFixed(1)}", warningColor, Icons.star),
        _buildMetricCard("Total Earnings", "\$${((totalEarnings / 1000).toDouble()).currency}K", successColor, Icons.attach_money),
      ],
    );
  }

  Widget _buildMetricCard(String title, String value, Color color, IconData icon) {
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
                  color: color.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Icon(
                  icon,
                  color: color,
                  size: 20,
                ),
              ),
              Spacer(),
              Text(
                value,
                style: TextStyle(
                  fontSize: fsH4,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Text(
            title,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPerformanceList() {
    return ListView.builder(
      padding: EdgeInsets.all(spSm),
      itemCount: filteredPerformanceData.length,
      itemBuilder: (context, index) {
        final technician = filteredPerformanceData[index];
        return Container(
          margin: EdgeInsets.only(bottom: spSm),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(radiusMd),
            boxShadow: [shadowSm],
          ),
          child: ListTile(
            contentPadding: EdgeInsets.all(spSm),
            leading: Stack(
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage("${technician["avatar"]}"),
                  radius: 24,
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    padding: EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusLg),
                    ),
                    child: Container(
                      width: 16,
                      height: 16,
                      decoration: BoxDecoration(
                        color: _getPerformanceColor((technician["overallScore"] as int)),
                        borderRadius: BorderRadius.circular(radiusLg),
                      ),
                      child: Center(
                        child: Text(
                          "${technician["overallScore"]}",
                          style: TextStyle(
                            fontSize: 8,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            title: Text(
              "${technician["name"]}",
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: spXs),
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: spSm, vertical: 2),
                      decoration: BoxDecoration(
                        color: primaryColor.withAlpha(10),
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Text(
                        "${technician["team"]}",
                        style: TextStyle(
                          fontSize: 10,
                          color: primaryColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    SizedBox(width: spSm),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: spSm, vertical: 2),
                      decoration: BoxDecoration(
                        color: _getPerformanceColor((technician["overallScore"] as int)).withAlpha(10),
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Text(
                        "${technician["skillLevel"]}",
                        style: TextStyle(
                          fontSize: 10,
                          color: _getPerformanceColor((technician["overallScore"] as int)),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spXs),
                Row(
                  children: [
                    Icon(Icons.work, size: 12, color: disabledBoldColor),
                    SizedBox(width: spXs),
                    Text(
                      "${technician["jobsCompleted"]} jobs",
                      style: TextStyle(fontSize: 12, color: disabledBoldColor),
                    ),
                    SizedBox(width: spSm),
                    Icon(Icons.star, size: 12, color: warningColor),
                    SizedBox(width: spXs),
                    Text(
                      "${technician["customerRating"]}",
                      style: TextStyle(fontSize: 12, color: disabledBoldColor),
                    ),
                  ],
                ),
                SizedBox(height: spXs),
                Row(
                  children: [
                    Icon(Icons.speed, size: 12, color: disabledBoldColor),
                    SizedBox(width: spXs),
                    Text(
                      "Avg response: ${technician["avgResponseTime"]}",
                      style: TextStyle(fontSize: 12, color: disabledBoldColor),
                    ),
                  ],
                ),
              ],
            ),
            trailing: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 60,
                  height: 60,
                  child: Stack(
                    children: [
                      Center(
                        child: SizedBox(
                          width: 50,
                          height: 50,
                          child: CircularProgressIndicator(
                            value: (technician["overallScore"] as int) / 100,
                            backgroundColor: disabledColor.withAlpha(30),
                            valueColor: AlwaysStoppedAnimation(_getPerformanceColor((technician["overallScore"] as int))),
                            strokeWidth: 4,
                          ),
                        ),
                      ),
                      Center(
                        child: Text(
                          "${technician["overallScore"]}",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: _getPerformanceColor((technician["overallScore"] as int)),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                if ((technician["monthlyGrowth"] as double) > 0) ...[
                  SizedBox(height: spXs),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.trending_up, size: 12, color: successColor),
                      Text(
                        "+${technician["monthlyGrowth"]}%",
                        style: TextStyle(
                          fontSize: 10,
                          color: successColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ],
              ],
            ),
            onTap: () => _showTechnicianDetails(technician),
          ),
        );
      },
    );
  }

  Widget _buildTopPerformers() {
    final sortedData = List<Map<String, dynamic>>.from(filteredPerformanceData)
      ..sort((a, b) => (b["overallScore"] as int).compareTo(a["overallScore"] as int));
    
    final topPerformers = sortedData.take(3).toList();

    return Container(
      margin: EdgeInsets.all(spSm),
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
              Icon(Icons.emoji_events, color: warningColor, size: 20),
              SizedBox(width: spSm),
              Text(
                "Top Performers",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          ...topPerformers.asMap().entries.map((entry) {
            final index = entry.key;
            final performer = entry.value;
            final icons = [Icons.emoji_events, Icons.workspace_premium, Icons.star];
            final colors = [warningColor, disabledBoldColor, disabledColor];
            
            return Container(
              margin: EdgeInsets.only(bottom: index < topPerformers.length - 1 ? spSm : 0),
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: colors[index].withAlpha(10),
                borderRadius: BorderRadius.circular(radiusSm),
                border: Border.all(color: colors[index].withAlpha(30), width: 1),
              ),
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(spXs),
                    decoration: BoxDecoration(
                      color: colors[index].withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                    child: Icon(
                      icons[index],
                      color: colors[index],
                      size: 16,
                    ),
                  ),
                  SizedBox(width: spSm),
                  CircleAvatar(
                    backgroundImage: NetworkImage("${performer["avatar"]}"),
                    radius: 16,
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${performer["name"]}",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          "${performer["team"]} • ${performer["overallScore"]}% Score",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    "#${index + 1}",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: colors[index],
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Performance Analytics"),
        actions: [
          IconButton(
            icon: Icon(Icons.analytics),
            onPressed: () {
              ss("Advanced analytics opened");
            },
          ),
          IconButton(
            icon: Icon(Icons.file_download),
            onPressed: () {
              ss("Performance report exported");
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(spSm),
              child: QCategoryPicker(
                items: periods.asMap().entries.map((entry) => {
                  "label": entry.value,
                  "value": entry.key,
                }).toList(),
                value: selectedPeriod,
                onChanged: (index, label, value, item) {
                  selectedPeriod = value;
                  setState(() {});
                },
              ),
            ),
            
            _buildOverallMetrics(),
            
            _buildTopPerformers(),
            
            Container(
              padding: EdgeInsets.all(spSm),
              child: Row(
                children: [
                  Expanded(
                    child: QDropdownField(
                      label: "Metric",
                      items: metricOptions,
                      value: selectedMetric,
                      onChanged: (value, label) {
                        selectedMetric = value;
                        setState(() {});
                      },
                    ),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: QDropdownField(
                      label: "Technician",
                      items: technicianOptions,
                      value: selectedTechnician,
                      onChanged: (value, label) {
                        selectedTechnician = value;
                        setState(() {});
                      },
                    ),
                  ),
                ],
              ),
            ),
            
            Container(
              padding: EdgeInsets.symmetric(horizontal: spSm),
              child: QDropdownField(
                label: "Team",
                items: teamOptions,
                value: selectedTeam,
                onChanged: (value, label) {
                  selectedTeam = value;
                  setState(() {});
                },
              ),
            ),
            SizedBox(height: spSm),
            
            Container(
              height: 400,
              child: _buildPerformanceList(),
            ),
          ],
        ),
      ),
    );
  }
}
