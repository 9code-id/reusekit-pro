import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class CmaLeadAssignmentView extends StatefulWidget {
  const CmaLeadAssignmentView({super.key});

  @override
  State<CmaLeadAssignmentView> createState() => _CmaLeadAssignmentViewState();
}

class _CmaLeadAssignmentViewState extends State<CmaLeadAssignmentView> {
  String selectedTeam = "All";
  String selectedStatus = "All";
  String searchQuery = "";
  
  List<Map<String, dynamic>> teamItems = [
    {"label": "All", "value": "All"},
    {"label": "Sales Team A", "value": "Sales Team A"},
    {"label": "Sales Team B", "value": "Sales Team B"},
    {"label": "Enterprise Team", "value": "Enterprise Team"},
    {"label": "SMB Team", "value": "SMB Team"},
  ];
  
  List<Map<String, dynamic>> statusItems = [
    {"label": "All", "value": "All"},
    {"label": "Assigned", "value": "Assigned"},
    {"label": "In Progress", "value": "In Progress"},
    {"label": "Follow Up", "value": "Follow Up"},
    {"label": "Completed", "value": "Completed"},
  ];

  List<Map<String, dynamic>> salesTeam = [
    {
      "id": "1",
      "name": "John Anderson",
      "email": "john.a@company.com",
      "team": "Sales Team A",
      "avatar": "https://picsum.photos/50/50?random=1",
      "assignedLeads": 15,
      "completedLeads": 8,
      "conversionRate": 35.2,
      "capacity": 20,
      "status": "Available",
      "workload": "Medium",
    },
    {
      "id": "2",
      "name": "Sarah Mitchell",
      "email": "sarah.m@company.com",
      "team": "Sales Team A",
      "avatar": "https://picsum.photos/50/50?random=2",
      "assignedLeads": 18,
      "completedLeads": 12,
      "conversionRate": 42.8,
      "capacity": 20,
      "status": "Busy",
      "workload": "High",
    },
    {
      "id": "3",
      "name": "Michael Chen",
      "email": "michael.c@company.com",
      "team": "Enterprise Team",
      "avatar": "https://picsum.photos/50/50?random=3",
      "assignedLeads": 8,
      "completedLeads": 6,
      "conversionRate": 55.0,
      "capacity": 12,
      "status": "Available",
      "workload": "Medium",
    },
    {
      "id": "4",
      "name": "Emily Davis",
      "email": "emily.d@company.com",
      "team": "SMB Team",
      "avatar": "https://picsum.photos/50/50?random=4",
      "assignedLeads": 22,
      "completedLeads": 15,
      "conversionRate": 38.5,
      "capacity": 25,
      "status": "Available",
      "workload": "High",
    },
    {
      "id": "5",
      "name": "David Wilson",
      "email": "david.w@company.com",
      "team": "Sales Team B",
      "avatar": "https://picsum.photos/50/50?random=5",
      "assignedLeads": 12,
      "completedLeads": 7,
      "conversionRate": 28.9,
      "capacity": 20,
      "status": "Available",
      "workload": "Low",
    },
  ];

  List<Map<String, dynamic>> assignments = [
    {
      "id": "1",
      "leadName": "Tech Solutions Inc",
      "leadContact": "John Smith",
      "leadEmail": "john.smith@techsolutions.com",
      "assignedTo": "Sarah Mitchell",
      "assignedDate": "2024-01-15",
      "dueDate": "2024-01-20",
      "status": "In Progress",
      "priority": "High",
      "estimatedValue": 25000,
      "notes": "Enterprise client interested in full solution",
      "lastActivity": "2024-01-16",
    },
    {
      "id": "2",
      "leadName": "Marketing Pro",
      "leadContact": "Sarah Johnson",
      "leadEmail": "sarah.j@marketingpro.com",
      "assignedTo": "John Anderson",
      "assignedDate": "2024-01-14",
      "dueDate": "2024-01-19",
      "status": "Follow Up",
      "priority": "Medium",
      "estimatedValue": 15000,
      "notes": "Needs pricing information for mid-tier package",
      "lastActivity": "2024-01-15",
    },
    {
      "id": "3",
      "leadName": "Innovation Startup",
      "leadContact": "Michael Chen",
      "leadEmail": "m.chen@innovationstartup.io",
      "assignedTo": "Michael Chen",
      "assignedDate": "2024-01-13",
      "dueDate": "2024-01-18",
      "status": "Assigned",
      "priority": "High",
      "estimatedValue": 50000,
      "notes": "Hot lead ready for enterprise demo",
      "lastActivity": "2024-01-13",
    },
    {
      "id": "4",
      "leadName": "Local Business",
      "leadContact": "Emma Wilson",
      "leadEmail": "emma@localbiz.com",
      "assignedTo": "Emily Davis",
      "assignedDate": "2024-01-12",
      "dueDate": "2024-01-17",
      "status": "Completed",
      "priority": "Low",
      "estimatedValue": 8000,
      "notes": "Converted to customer",
      "lastActivity": "2024-01-16",
    },
  ];

  List<Map<String, dynamic>> get filteredAssignments {
    List<Map<String, dynamic>> filtered = assignments;
    
    if (selectedStatus != "All") {
      filtered = filtered.where((assignment) => assignment["status"] == selectedStatus).toList();
    }
    
    if (selectedTeam != "All") {
      String? assignedPersonTeam = salesTeam
          .firstWhere(
            (person) => person["name"] == assignments
                .firstWhere((a) => a["assignedTo"] == person["name"], 
                           orElse: () => {"assignedTo": ""})["assignedTo"],
            orElse: () => {"team": ""},
          )["team"];
      
      if (assignedPersonTeam != null && assignedPersonTeam != selectedTeam) {
        filtered = filtered.where((assignment) {
          String assignedTo = assignment["assignedTo"];
          var assignedPerson = salesTeam.firstWhere(
            (person) => person["name"] == assignedTo,
            orElse: () => {"team": ""},
          );
          return assignedPerson["team"] == selectedTeam;
        }).toList();
      }
    }
    
    if (searchQuery.isNotEmpty) {
      filtered = filtered.where((assignment) =>
        "${assignment["leadName"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
        "${assignment["leadContact"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
        "${assignment["assignedTo"]}".toLowerCase().contains(searchQuery.toLowerCase())
      ).toList();
    }
    
    return filtered;
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "Assigned":
        return infoColor;
      case "In Progress":
        return warningColor;
      case "Follow Up":
        return primaryColor;
      case "Completed":
        return successColor;
      default:
        return disabledColor;
    }
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

  Color _getWorkloadColor(String workload) {
    switch (workload) {
      case "Low":
        return successColor;
      case "Medium":
        return warningColor;
      case "High":
        return dangerColor;
      default:
        return disabledColor;
    }
  }

  void _assignLead() {
    //navigateTo('CmaAssignLeadView')
  }

  void _reassignLead(Map<String, dynamic> assignment) {
    //navigateTo('CmaReassignLeadView')
  }

  void _viewAssignmentDetails(Map<String, dynamic> assignment) {
    //navigateTo('CmaAssignmentDetailView')
  }

  void _bulkAssign() async {
    showLoading();
    await Future.delayed(Duration(seconds: 2));
    hideLoading();
    ss("Leads assigned automatically based on workload");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Lead Assignment"),
        actions: [
          QButton(
            icon: Icons.auto_awesome,
            size: bs.sm,
            onPressed: _bulkAssign,
          ),
          SizedBox(width: spSm),
          QButton(
            icon: Icons.add,
            size: bs.sm,
            onPressed: _assignLead,
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
            _buildTeamOverview(),
            _buildFilters(),
            _buildSearchBar(),
            _buildAssignmentStats(),
            _buildAssignmentsList(),
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
            Icons.assignment_ind,
            color: Colors.white,
            size: 32,
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Lead Assignment Dashboard",
                  style: TextStyle(
                    fontSize: fsH5,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Text(
                  "Manage and distribute leads across your sales team",
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
              "${filteredAssignments.length} Active",
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

  Widget _buildTeamOverview() {
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
                Icons.groups,
                color: primaryColor,
                size: 20,
              ),
              SizedBox(width: spXs),
              Text(
                "Sales Team Overview",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          QHorizontalScroll(
            children: List.generate(salesTeam.length, (index) {
              final member = salesTeam[index];
              return Container(
                width: 200,
                margin: EdgeInsets.only(right: index < salesTeam.length - 1 ? spSm : 0),
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: _getWorkloadColor(member["workload"]).withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                  border: Border.all(
                    color: _getWorkloadColor(member["workload"]).withAlpha(100),
                  ),
                ),
                child: Column(
                  spacing: spXs,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(radiusLg),
                            image: DecorationImage(
                              image: NetworkImage("${member["avatar"]}"),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        SizedBox(width: spXs),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${member["name"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                              Text(
                                "${member["team"]}",
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
                                "${member["assignedLeads"]}/${member["capacity"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: _getWorkloadColor(member["workload"]),
                                ),
                              ),
                              Text(
                                "Workload",
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
                                "${member["conversionRate"].toStringAsFixed(1)}%",
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
                      ],
                    ),
                  ],
                ),
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildFilters() {
    return Row(
      children: [
        Expanded(
          child: QDropdownField(
            label: "Filter by Team",
            items: teamItems,
            value: selectedTeam,
            onChanged: (value, label) {
              selectedTeam = value;
              setState(() {});
            },
          ),
        ),
        SizedBox(width: spSm),
        Expanded(
          child: QDropdownField(
            label: "Filter by Status",
            items: statusItems,
            value: selectedStatus,
            onChanged: (value, label) {
              selectedStatus = value;
              setState(() {});
            },
          ),
        ),
      ],
    );
  }

  Widget _buildSearchBar() {
    return Row(
      children: [
        Expanded(
          child: QTextField(
            label: "Search assignments...",
            value: searchQuery,
            hint: "Search by lead name, contact, or assigned person",
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

  Widget _buildAssignmentStats() {
    int totalAssignments = assignments.length;
    int inProgressCount = assignments.where((a) => a["status"] == "In Progress").length;
    int completedCount = assignments.where((a) => a["status"] == "Completed").length;
    double completionRate = totalAssignments > 0 ? (completedCount / totalAssignments) * 100 : 0;

    return Row(
      children: [
        Expanded(
          child: _buildStatCard(
            title: "Total Assignments",
            value: "$totalAssignments",
            icon: Icons.assignment,
            color: primaryColor,
          ),
        ),
        SizedBox(width: spSm),
        Expanded(
          child: _buildStatCard(
            title: "In Progress",
            value: "$inProgressCount",
            icon: Icons.pending,
            color: warningColor,
          ),
        ),
        SizedBox(width: spSm),
        Expanded(
          child: _buildStatCard(
            title: "Completed",
            value: "$completedCount",
            icon: Icons.check_circle,
            color: successColor,
          ),
        ),
        SizedBox(width: spSm),
        Expanded(
          child: _buildStatCard(
            title: "Completion Rate",
            value: "${completionRate.toStringAsFixed(0)}%",
            icon: Icons.trending_up,
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

  Widget _buildAssignmentsList() {
    if (filteredAssignments.isEmpty) {
      return Container(
        padding: EdgeInsets.all(spXl),
        child: Column(
          children: [
            Icon(
              Icons.assignment_late,
              size: 64,
              color: disabledColor,
            ),
            SizedBox(height: spSm),
            Text(
              "No assignments found",
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
      children: List.generate(filteredAssignments.length, (index) {
        final assignment = filteredAssignments[index];
        return _buildAssignmentCard(assignment);
      }),
    );
  }

  Widget _buildAssignmentCard(Map<String, dynamic> assignment) {
    var assignedPerson = salesTeam.firstWhere(
      (person) => person["name"] == assignment["assignedTo"],
      orElse: () => {
        "name": "Unknown",
        "avatar": "https://picsum.photos/50/50?random=99",
        "team": "Unknown",
      },
    );

    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
        border: Border(
          left: BorderSide(
            width: 4,
            color: _getStatusColor(assignment["status"]),
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
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            "${assignment["leadName"]}",
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
                            color: _getPriorityColor(assignment["priority"]).withAlpha(30),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Text(
                            "${assignment["priority"]} Priority",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: _getPriorityColor(assignment["priority"]),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Text(
                      "Contact: ${assignment["leadContact"]}",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.email,
                          size: 14,
                          color: disabledBoldColor,
                        ),
                        SizedBox(width: spXs),
                        Text(
                          "${assignment["leadEmail"]}",
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
            ],
          ),
          Divider(color: disabledOutlineBorderColor),
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(radiusLg),
                  image: DecorationImage(
                    image: NetworkImage("${assignedPerson["avatar"]}"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Assigned to: ${assignment["assignedTo"]}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "${assignedPerson["team"]}",
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
                    "Value: \$${((assignment["estimatedValue"] as int).toDouble()).currency}",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: successColor,
                    ),
                  ),
                  Text(
                    "Due: ${assignment["dueDate"]}",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ),
            ],
          ),
          if (assignment["notes"].isNotEmpty) ...[
            Divider(color: disabledOutlineBorderColor),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spXs),
              decoration: BoxDecoration(
                color: infoColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusXs),
              ),
              child: Text(
                "${assignment["notes"]}",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
          ],
          Divider(color: disabledOutlineBorderColor),
          Row(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: _getStatusColor(assignment["status"]).withAlpha(30),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Text(
                  "${assignment["status"]}",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: _getStatusColor(assignment["status"]),
                  ),
                ),
              ),
              SizedBox(width: spSm),
              Text(
                "Last activity: ${assignment["lastActivity"]}",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
              Spacer(),
              QButton(
                label: "Reassign",
                size: bs.sm,
                onPressed: () => _reassignLead(assignment),
              ),
              SizedBox(width: spXs),
              QButton(
                icon: Icons.visibility,
                size: bs.sm,
                onPressed: () => _viewAssignmentDetails(assignment),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
