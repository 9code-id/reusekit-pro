import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class CrmTeamManagementView extends StatefulWidget {
  const CrmTeamManagementView({super.key});

  @override
  State<CrmTeamManagementView> createState() => _CrmTeamManagementViewState();
}

class _CrmTeamManagementViewState extends State<CrmTeamManagementView> {
  String selectedDepartment = "All Departments";
  String searchQuery = "";
  
  List<Map<String, dynamic>> departmentOptions = [
    {"label": "All Departments", "value": "All Departments"},
    {"label": "Sales", "value": "Sales"},
    {"label": "Marketing", "value": "Marketing"},
    {"label": "Customer Support", "value": "Customer Support"},
    {"label": "Technical", "value": "Technical"},
  ];
  
  List<Map<String, dynamic>> teams = [
    {
      "id": "T001",
      "name": "Enterprise Sales Team",
      "department": "Sales",
      "manager": "Sarah Johnson",
      "managerAvatar": "https://picsum.photos/50/50?random=1&keyword=manager",
      "memberCount": 8,
      "activeDeals": 25,
      "monthlyTarget": 500000.0,
      "currentRevenue": 420000.0,
      "performance": 84.0,
      "status": "Active",
      "members": [
        {
          "name": "Mike Chen",
          "role": "Senior Sales Rep",
          "avatar": "https://picsum.photos/40/40?random=10&keyword=person",
          "performance": 92.0,
        },
        {
          "name": "Emily Davis",
          "role": "Sales Rep",
          "avatar": "https://picsum.photos/40/40?random=11&keyword=person",
          "performance": 88.0,
        },
        {
          "name": "David Wilson",
          "role": "Junior Sales Rep",
          "avatar": "https://picsum.photos/40/40?random=12&keyword=person",
          "performance": 76.0,
        },
      ],
    },
    {
      "id": "T002",
      "name": "SMB Sales Team",
      "department": "Sales",
      "manager": "Alex Rodriguez",
      "managerAvatar": "https://picsum.photos/50/50?random=2&keyword=manager",
      "memberCount": 12,
      "activeDeals": 45,
      "monthlyTarget": 300000.0,
      "currentRevenue": 285000.0,
      "performance": 95.0,
      "status": "Active",
      "members": [
        {
          "name": "Jessica Miller",
          "role": "Team Lead",
          "avatar": "https://picsum.photos/40/40?random=13&keyword=person",
          "performance": 98.0,
        },
        {
          "name": "Tom Anderson",
          "role": "Sales Rep",
          "avatar": "https://picsum.photos/40/40?random=14&keyword=person",
          "performance": 85.0,
        },
      ],
    },
    {
      "id": "T003",
      "name": "Customer Success Team",
      "department": "Customer Support",
      "manager": "Lisa Wang",
      "managerAvatar": "https://picsum.photos/50/50?random=3&keyword=manager",
      "memberCount": 6,
      "activeDeals": 0,
      "monthlyTarget": 0.0,
      "currentRevenue": 0.0,
      "performance": 91.0,
      "status": "Active",
      "members": [
        {
          "name": "Chris Brown",
          "role": "CS Manager",
          "avatar": "https://picsum.photos/40/40?random=15&keyword=person",
          "performance": 94.0,
        },
        {
          "name": "Anna Taylor",
          "role": "CS Rep",
          "avatar": "https://picsum.photos/40/40?random=16&keyword=person",
          "performance": 89.0,
        },
      ],
    },
    {
      "id": "T004",
      "name": "Digital Marketing Team",
      "department": "Marketing",
      "manager": "Kevin Park",
      "managerAvatar": "https://picsum.photos/50/50?random=4&keyword=manager",
      "memberCount": 5,
      "activeDeals": 12,
      "monthlyTarget": 150000.0,
      "currentRevenue": 135000.0,
      "performance": 90.0,
      "status": "Active",
      "members": [
        {
          "name": "Sofia Garcia",
          "role": "Marketing Specialist",
          "avatar": "https://picsum.photos/40/40?random=17&keyword=person",
          "performance": 87.0,
        },
      ],
    },
  ];

  List<Map<String, dynamic>> get filteredTeams {
    List<Map<String, dynamic>> filtered = teams;
    
    if (selectedDepartment != "All Departments") {
      filtered = filtered.where((team) => team["department"] == selectedDepartment).toList();
    }
    
    if (searchQuery.isNotEmpty) {
      filtered = filtered.where((team) =>
        (team["name"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
        (team["manager"] as String).toLowerCase().contains(searchQuery.toLowerCase())).toList();
    }
    
    return filtered;
  }
  
  Color _getPerformanceColor(double performance) {
    if (performance >= 90) return successColor;
    if (performance >= 75) return warningColor;
    return dangerColor;
  }

  @override
  Widget build(BuildContext context) {
    int totalMembers = filteredTeams.fold(0, (sum, item) => sum + (item["memberCount"] as int));
    int totalActiveDeals = filteredTeams.fold(0, (sum, item) => sum + (item["activeDeals"] as int));
    double averagePerformance = filteredTeams.isEmpty ? 0.0 : 
      filteredTeams.fold(0.0, (sum, item) => sum + (item["performance"] as double)) / filteredTeams.length;
    
    return Scaffold(
      appBar: AppBar(
        title: Text("Team Management"),
        actions: [
          QButton(
            icon: Icons.group_add,
            size: bs.sm,
            onPressed: () {
              ss("Create team feature coming soon");
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
                        "Filters",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.w600,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: QDropdownField(
                          label: "Department",
                          items: departmentOptions,
                          value: selectedDepartment,
                          onChanged: (value, label) {
                            selectedDepartment = value;
                            setState(() {});
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QTextField(
                          label: "Search Teams",
                          value: searchQuery,
                          hint: "Search by team or manager",
                          onChanged: (value) {
                            searchQuery = value;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            
            // Summary Cards
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
                            child: Icon(Icons.groups, color: primaryColor, size: 20),
                          ),
                          SizedBox(width: spSm),
                          Text(
                            "Total Teams",
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
                        "${filteredTeams.length}",
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
                            child: Icon(Icons.people, color: successColor, size: 20),
                          ),
                          SizedBox(width: spSm),
                          Text(
                            "Total Members",
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
                        "$totalMembers",
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
                            child: Icon(Icons.trending_up, color: infoColor, size: 20),
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
                        "${averagePerformance.toStringAsFixed(1)}%",
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
            
            // Teams List
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
                          "Teams",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.w600,
                            color: primaryColor,
                          ),
                        ),
                        Spacer(),
                        Text(
                          "${filteredTeams.length} teams",
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
                    itemCount: filteredTeams.length,
                    itemBuilder: (context, index) {
                      final team = filteredTeams[index];
                      final performanceColor = _getPerformanceColor(team["performance"] as double);
                      final isRevenueTeam = (team["monthlyTarget"] as double) > 0;
                      
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
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(radiusLg),
                                  child: Image.network(
                                    "${team["managerAvatar"]}",
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
                                      Text(
                                        "${team["name"]}",
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                          color: primaryColor,
                                        ),
                                      ),
                                      SizedBox(height: spXs),
                                      Text(
                                        "Manager: ${team["manager"]} • ${team["department"]}",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                      SizedBox(height: spXs),
                                      Row(
                                        children: [
                                          Container(
                                            padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                            decoration: BoxDecoration(
                                              color: performanceColor.withAlpha(20),
                                              borderRadius: BorderRadius.circular(radiusXs),
                                            ),
                                            child: Text(
                                              "${(team["performance"] as double).toStringAsFixed(1)}% Performance",
                                              style: TextStyle(
                                                fontSize: 10,
                                                fontWeight: FontWeight.w600,
                                                color: performanceColor,
                                              ),
                                            ),
                                          ),
                                          SizedBox(width: spXs),
                                          Container(
                                            padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                            decoration: BoxDecoration(
                                              color: primaryColor.withAlpha(20),
                                              borderRadius: BorderRadius.circular(radiusXs),
                                            ),
                                            child: Text(
                                              "${team["memberCount"]} Members",
                                              style: TextStyle(
                                                fontSize: 10,
                                                fontWeight: FontWeight.w600,
                                                color: primaryColor,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                QButton(
                                  icon: Icons.more_vert,
                                  size: bs.sm,
                                  onPressed: () {
                                    ss("Team options menu");
                                  },
                                ),
                              ],
                            ),
                            
                            if (isRevenueTeam) ...[
                              SizedBox(height: spSm),
                              Container(
                                padding: EdgeInsets.all(spSm),
                                decoration: BoxDecoration(
                                  color: primaryColor.withAlpha(5),
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
                                                "Monthly Target",
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  color: disabledBoldColor,
                                                ),
                                              ),
                                              Text(
                                                "\$${(team["monthlyTarget"] as double).currency}",
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
                                                "Current Revenue",
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  color: disabledBoldColor,
                                                ),
                                              ),
                                              Text(
                                                "\$${(team["currentRevenue"] as double).currency}",
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
                                                "Active Deals",
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  color: disabledBoldColor,
                                                ),
                                              ),
                                              Text(
                                                "${team["activeDeals"]}",
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
                                    Container(
                                      width: double.infinity,
                                      height: 6,
                                      decoration: BoxDecoration(
                                        color: disabledColor,
                                        borderRadius: BorderRadius.circular(radiusXs),
                                      ),
                                      child: FractionallySizedBox(
                                        widthFactor: ((team["currentRevenue"] as double) / (team["monthlyTarget"] as double)).clamp(0.0, 1.0),
                                        alignment: Alignment.centerLeft,
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: performanceColor,
                                            borderRadius: BorderRadius.circular(radiusXs),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                            
                            // Team Members Preview
                            if ((team["members"] as List).isNotEmpty) ...[
                              SizedBox(height: spSm),
                              Container(
                                padding: EdgeInsets.all(spSm),
                                decoration: BoxDecoration(
                                  color: Colors.grey.withAlpha(20),
                                  borderRadius: BorderRadius.circular(radiusSm),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          "Team Members",
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w600,
                                            color: disabledBoldColor,
                                          ),
                                        ),
                                        Spacer(),
                                        Text(
                                          "Top ${(team["members"] as List).length}",
                                          style: TextStyle(
                                            fontSize: 10,
                                            color: disabledBoldColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: spXs),
                                    Column(
                                      children: List.generate((team["members"] as List).length > 3 ? 3 : (team["members"] as List).length, (memberIndex) {
                                        final member = (team["members"] as List)[memberIndex];
                                        final memberPerformanceColor = _getPerformanceColor(member["performance"] as double);
                                        
                                        return Container(
                                          margin: EdgeInsets.only(bottom: memberIndex < 2 ? spXs : 0),
                                          child: Row(
                                            children: [
                                              ClipRRect(
                                                borderRadius: BorderRadius.circular(radiusSm),
                                                child: Image.network(
                                                  "${member["avatar"]}",
                                                  width: 30,
                                                  height: 30,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                              SizedBox(width: spSm),
                                              Expanded(
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      "${member["name"]}",
                                                      style: TextStyle(
                                                        fontSize: 12,
                                                        fontWeight: FontWeight.w600,
                                                        color: primaryColor,
                                                      ),
                                                    ),
                                                    Text(
                                                      "${member["role"]}",
                                                      style: TextStyle(
                                                        fontSize: 10,
                                                        color: disabledBoldColor,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Container(
                                                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                                decoration: BoxDecoration(
                                                  color: memberPerformanceColor.withAlpha(20),
                                                  borderRadius: BorderRadius.circular(radiusXs),
                                                ),
                                                child: Text(
                                                  "${(member["performance"] as double).toStringAsFixed(0)}%",
                                                  style: TextStyle(
                                                    fontSize: 10,
                                                    fontWeight: FontWeight.w600,
                                                    color: memberPerformanceColor,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                      }),
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
