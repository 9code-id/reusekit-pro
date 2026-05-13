import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class PmaTeamPerformanceView extends StatefulWidget {
  const PmaTeamPerformanceView({super.key});

  @override
  State<PmaTeamPerformanceView> createState() => _PmaTeamPerformanceViewState();
}

class _PmaTeamPerformanceViewState extends State<PmaTeamPerformanceView> {
  String selectedPeriod = "This Month";
  String selectedTeam = "All Teams";
  
  List<Map<String, dynamic>> periodOptions = [
    {"label": "This Week", "value": "This Week"},
    {"label": "This Month", "value": "This Month"},
    {"label": "This Quarter", "value": "This Quarter"},
    {"label": "This Year", "value": "This Year"},
  ];
  
  List<Map<String, dynamic>> teamOptions = [
    {"label": "All Teams", "value": "All Teams"},
    {"label": "Development", "value": "Development"},
    {"label": "Design", "value": "Design"},
    {"label": "Marketing", "value": "Marketing"},
    {"label": "Sales", "value": "Sales"},
  ];
  
  List<Map<String, dynamic>> teamMembers = [
    {
      "id": 1,
      "name": "Alex Johnson",
      "role": "Senior Developer",
      "avatar": "https://picsum.photos/50/50?random=1&keyword=person",
      "hoursWorked": 168.5,
      "projectsCompleted": 8,
      "efficiency": 94.2,
      "onTimeDelivery": 96.0,
      "rating": 4.8,
      "status": "active",
      "team": "Development"
    },
    {
      "id": 2,
      "name": "Sarah Chen",
      "role": "UX Designer",
      "avatar": "https://picsum.photos/50/50?random=2&keyword=woman",
      "hoursWorked": 156.0,
      "projectsCompleted": 12,
      "efficiency": 98.5,
      "onTimeDelivery": 100.0,
      "rating": 4.9,
      "status": "active",
      "team": "Design"
    },
    {
      "id": 3,
      "name": "Mike Rodriguez",
      "role": "Project Manager",
      "avatar": "https://picsum.photos/50/50?random=3&keyword=man",
      "hoursWorked": 172.5,
      "projectsCompleted": 15,
      "efficiency": 89.3,
      "onTimeDelivery": 93.5,
      "rating": 4.6,
      "status": "active",
      "team": "Development"
    },
    {
      "id": 4,
      "name": "Emily Davis",
      "role": "Marketing Specialist",
      "avatar": "https://picsum.photos/50/50?random=4&keyword=girl",
      "hoursWorked": 144.0,
      "projectsCompleted": 9,
      "efficiency": 91.7,
      "onTimeDelivery": 88.9,
      "rating": 4.4,
      "status": "active",
      "team": "Marketing"
    },
    {
      "id": 5,
      "name": "James Wilson",
      "role": "Backend Developer",
      "avatar": "https://picsum.photos/50/50?random=5&keyword=person",
      "hoursWorked": 165.5,
      "projectsCompleted": 6,
      "efficiency": 87.1,
      "onTimeDelivery": 91.7,
      "rating": 4.3,
      "status": "away",
      "team": "Development"
    },
    {
      "id": 6,
      "name": "Lisa Thompson",
      "role": "Sales Manager",
      "avatar": "https://picsum.photos/50/50?random=6&keyword=woman",
      "hoursWorked": 158.0,
      "projectsCompleted": 11,
      "efficiency": 95.8,
      "onTimeDelivery": 94.5,
      "rating": 4.7,
      "status": "active",
      "team": "Sales"
    }
  ];

  List<Map<String, dynamic>> get filteredMembers {
    if (selectedTeam == "All Teams") return teamMembers;
    return teamMembers.where((member) => member["team"] == selectedTeam).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Team Performance"),
        actions: [
          IconButton(
            icon: Icon(Icons.filter_list),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.download),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: spMd,
          children: [
            _buildFilters(),
            _buildOverviewCards(),
            _buildPerformanceChart(),
            _buildTeamMembersList(),
          ],
        ),
      ),
    );
  }

  Widget _buildFilters() {
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
                child: QDropdownField(
                  label: "Period",
                  items: periodOptions,
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
                  items: teamOptions,
                  value: selectedTeam,
                  onChanged: (value, label) {
                    selectedTeam = value;
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

  Widget _buildOverviewCards() {
    return Row(
      children: [
        Expanded(
          child: _buildMetricCard(
            "Total Hours",
            "${((filteredMembers.map((m) => m["hoursWorked"] as double).reduce((a, b) => a + b))).toStringAsFixed(0)}h",
            Icons.access_time,
            primaryColor,
          ),
        ),
        SizedBox(width: spSm),
        Expanded(
          child: _buildMetricCard(
            "Avg Efficiency",
            "${((filteredMembers.map((m) => m["efficiency"] as double).reduce((a, b) => a + b)) / filteredMembers.length).toStringAsFixed(1)}%",
            Icons.trending_up,
            successColor,
          ),
        ),
      ],
    );
  }

  Widget _buildMetricCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spXs,
        children: [
          Row(
            children: [
              Icon(
                icon,
                color: color,
                size: 20,
              ),
              SizedBox(width: spXs),
              Text(
                title,
                style: TextStyle(
                  fontSize: 14,
                  color: disabledBoldColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: fsH4,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPerformanceChart() {
    return Container(
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
            "Performance Metrics",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Container(
            height: 200,
            child: Column(
              spacing: spSm,
              children: filteredMembers.map((member) {
                return _buildPerformanceBar(
                  "${member["name"]}",
                  (member["efficiency"] as double),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPerformanceBar(String name, double efficiency) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spXs,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                name,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: primaryColor,
                ),
              ),
              Text(
                "${efficiency.toStringAsFixed(1)}%",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: efficiency >= 90 ? successColor : efficiency >= 80 ? warningColor : dangerColor,
                ),
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
              alignment: Alignment.centerLeft,
              widthFactor: efficiency / 100,
              child: Container(
                decoration: BoxDecoration(
                  color: efficiency >= 90 ? successColor : efficiency >= 80 ? warningColor : dangerColor,
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTeamMembersList() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(spSm),
            child: Text(
              "Team Members",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
          ),
          ...filteredMembers.map((member) => _buildMemberItem(member)).toList(),
        ],
      ),
    );
  }

  Widget _buildMemberItem(Map<String, dynamic> member) {
    return Container(
      padding: EdgeInsets.all(spSm),
      margin: EdgeInsets.only(bottom: spXs),
      child: Row(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(radiusLg),
              image: DecorationImage(
                image: NetworkImage("${member["avatar"]}"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spXs,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        "${member["name"]}",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ),
                    Container(
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color: member["status"] == "active" ? successColor : warningColor,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ],
                ),
                Text(
                  "${member["role"]}",
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        "${(member["hoursWorked"] as double).toStringAsFixed(0)}h worked",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                    ),
                    Row(
                      children: List.generate(5, (index) {
                        return Icon(
                          index < (member["rating"] as double).floor() ? Icons.star : Icons.star_border,
                          size: 14,
                          color: warningColor,
                        );
                      }),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(width: spSm),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            spacing: spXs,
            children: [
              Text(
                "${(member["efficiency"] as double).toStringAsFixed(1)}%",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: (member["efficiency"] as double) >= 90 ? successColor : 
                         (member["efficiency"] as double) >= 80 ? warningColor : dangerColor,
                ),
              ),
              Text(
                "${(member["projectsCompleted"] as int)} projects",
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
}
