import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class ComaTeamManagementView extends StatefulWidget {
  const ComaTeamManagementView({super.key});

  @override
  State<ComaTeamManagementView> createState() => _ComaTeamManagementViewState();
}

class _ComaTeamManagementViewState extends State<ComaTeamManagementView> {
  String searchQuery = "";
  String selectedDepartment = "All";
  String selectedStatus = "All";
  String selectedProject = "All";
  int currentTab = 0;

  List<Map<String, dynamic>> teams = [
    {
      "id": "TEAM001",
      "name": "Alpha Construction Team",
      "department": "General Construction",
      "teamLead": "John Smith",
      "leadPhone": "+1-555-0123",
      "leadEmail": "j.smith@company.com",
      "memberCount": 8,
      "specialties": ["Framing", "Concrete", "Foundation"],
      "currentProject": "Riverside Office Complex",
      "status": "Active",
      "efficiency": 92,
      "safetyRating": 4.8,
      "completedTasks": 45,
      "activeTasks": 12,
      "location": "Building A - Floor 3",
      "startDate": "2024-01-08",
      "certifications": ["OSHA 30", "First Aid", "Crane Operation"],
      "equipment": ["Excavator", "Concrete Mixer", "Power Tools"],
      "budget": 85000.0,
      "spent": 62000.0,
      "avatar": "https://picsum.photos/100/100?random=301&keyword=person"
    },
    {
      "id": "TEAM002",
      "name": "Beta Electrical Solutions",
      "department": "Electrical",
      "teamLead": "Sarah Johnson",
      "leadPhone": "+1-555-0124",
      "leadEmail": "s.johnson@company.com",
      "memberCount": 6,
      "specialties": ["Commercial Wiring", "Panel Installation", "Lighting"],
      "currentProject": "Downtown Mall Renovation",
      "status": "Active",
      "efficiency": 88,
      "safetyRating": 4.9,
      "completedTasks": 38,
      "activeTasks": 8,
      "location": "Mall Section B",
      "startDate": "2024-01-10",
      "certifications": ["Licensed Electrician", "Arc Flash Training"],
      "equipment": ["Wire Pullers", "Multimeters", "Conduit Benders"],
      "budget": 72000.0,
      "spent": 45000.0,
      "avatar": "https://picsum.photos/100/100?random=302&keyword=person"
    },
    {
      "id": "TEAM003",
      "name": "Gamma HVAC Specialists",
      "department": "HVAC",
      "teamLead": "Michael Davis",
      "leadPhone": "+1-555-0125",
      "leadEmail": "m.davis@company.com",
      "memberCount": 5,
      "specialties": ["Ductwork", "Climate Control", "Ventilation"],
      "currentProject": "Hospital Wing Extension",
      "status": "Active",
      "efficiency": 95,
      "safetyRating": 4.7,
      "completedTasks": 32,
      "activeTasks": 6,
      "location": "Hospital East Wing",
      "startDate": "2024-01-12",
      "certifications": ["EPA Certification", "Refrigeration License"],
      "equipment": ["Duct Machines", "Gauges", "Vacuum Pumps"],
      "budget": 68000.0,
      "spent": 38000.0,
      "avatar": "https://picsum.photos/100/100?random=303&keyword=person"
    },
    {
      "id": "TEAM004",
      "name": "Delta Plumbing Crew",
      "department": "Plumbing",
      "teamLead": "Lisa Wilson",
      "leadPhone": "+1-555-0126",
      "leadEmail": "l.wilson@company.com",
      "memberCount": 4,
      "specialties": ["Pipe Installation", "Fixture Setup", "Drainage"],
      "currentProject": "Residential Complex Phase 2",
      "status": "On Leave",
      "efficiency": 85,
      "safetyRating": 4.6,
      "completedTasks": 28,
      "activeTasks": 0,
      "location": "Residential Building C",
      "startDate": "2024-01-15",
      "certifications": ["Master Plumber", "Backflow Prevention"],
      "equipment": ["Pipe Cutters", "Soldering Kit", "Snake Machines"],
      "budget": 54000.0,
      "spent": 32000.0,
      "avatar": "https://picsum.photos/100/100?random=304&keyword=person"
    },
    {
      "id": "TEAM005",
      "name": "Epsilon Finishing Group",
      "department": "Interior Finishing",
      "teamLead": "Robert Brown",
      "leadPhone": "+1-555-0127",
      "leadEmail": "r.brown@company.com",
      "memberCount": 7,
      "specialties": ["Drywall", "Painting", "Flooring", "Trim Work"],
      "currentProject": "Corporate Headquarters",
      "status": "Active",
      "efficiency": 90,
      "safetyRating": 4.5,
      "completedTasks": 52,
      "activeTasks": 15,
      "location": "Headquarters Floor 1-3",
      "startDate": "2024-01-05",
      "certifications": ["Lead-Safe Certification", "EPA RRP"],
      "equipment": ["Spray Equipment", "Sanders", "Tile Cutters"],
      "budget": 78000.0,
      "spent": 56000.0,
      "avatar": "https://picsum.photos/100/100?random=305&keyword=person"
    },
    {
      "id": "TEAM006",
      "name": "Zeta Safety & Inspection",
      "department": "Safety & Quality",
      "teamLead": "Jennifer Lee",
      "leadPhone": "+1-555-0128",
      "leadEmail": "j.lee@company.com",
      "memberCount": 3,
      "specialties": ["Safety Inspections", "Quality Control", "Compliance"],
      "currentProject": "Multi-Project Support",
      "status": "Active",
      "efficiency": 97,
      "safetyRating": 5.0,
      "completedTasks": 156,
      "activeTasks": 23,
      "location": "Mobile Unit",
      "startDate": "2024-01-01",
      "certifications": ["CSP", "CIH", "OSHA 500"],
      "equipment": ["Testing Equipment", "Meters", "Inspection Tools"],
      "budget": 45000.0,
      "spent": 28000.0,
      "avatar": "https://picsum.photos/100/100?random=306&keyword=person"
    }
  ];

  List<Map<String, dynamic>> departmentItems = [
    {"label": "All", "value": "All"},
    {"label": "General Construction", "value": "General Construction"},
    {"label": "Electrical", "value": "Electrical"},
    {"label": "HVAC", "value": "HVAC"},
    {"label": "Plumbing", "value": "Plumbing"},
    {"label": "Interior Finishing", "value": "Interior Finishing"},
    {"label": "Safety & Quality", "value": "Safety & Quality"},
  ];

  List<Map<String, dynamic>> statusItems = [
    {"label": "All", "value": "All"},
    {"label": "Active", "value": "Active"},
    {"label": "On Leave", "value": "On Leave"},
    {"label": "Completed", "value": "Completed"},
    {"label": "Standby", "value": "Standby"},
  ];

  List<Map<String, dynamic>> projectItems = [
    {"label": "All", "value": "All"},
    {"label": "Riverside Office Complex", "value": "Riverside Office Complex"},
    {"label": "Downtown Mall Renovation", "value": "Downtown Mall Renovation"},
    {"label": "Hospital Wing Extension", "value": "Hospital Wing Extension"},
    {"label": "Residential Complex Phase 2", "value": "Residential Complex Phase 2"},
    {"label": "Corporate Headquarters", "value": "Corporate Headquarters"},
  ];

  List<Map<String, dynamic>> get filteredTeams {
    return teams.where((team) {
      bool matchesSearch = searchQuery.isEmpty ||
          "${team["name"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
          "${team["teamLead"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
          "${team["id"]}".toLowerCase().contains(searchQuery.toLowerCase());
      
      bool matchesDepartment = selectedDepartment == "All" || team["department"] == selectedDepartment;
      bool matchesStatus = selectedStatus == "All" || team["status"] == selectedStatus;
      bool matchesProject = selectedProject == "All" || team["currentProject"] == selectedProject;
      
      return matchesSearch && matchesDepartment && matchesStatus && matchesProject;
    }).toList();
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "Active": return successColor;
      case "On Leave": return warningColor;
      case "Completed": return infoColor;
      case "Standby": return disabledColor;
      default: return disabledColor;
    }
  }

  Color _getEfficiencyColor(int efficiency) {
    if (efficiency >= 95) return successColor;
    if (efficiency >= 85) return primaryColor;
    if (efficiency >= 75) return warningColor;
    return dangerColor;
  }

  Widget _buildOverviewCards() {
    int totalTeams = teams.length;
    int activeTeams = teams.where((team) => team["status"] == "Active").length;
    double avgEfficiency = teams.fold(0.0, (sum, team) => sum + (team["efficiency"] as int)) / totalTeams;
    double avgSafety = teams.fold(0.0, (sum, team) => sum + (team["safetyRating"] as double)) / totalTeams;

    return Column(
      children: [
        Row(
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
                    Row(
                      children: [
                        Icon(Icons.groups, color: primaryColor, size: 20),
                        SizedBox(width: spXs),
                        Text(
                          "Total Teams",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "$totalTeams",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
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
                    Row(
                      children: [
                        Icon(Icons.work, color: successColor, size: 20),
                        SizedBox(width: spXs),
                        Text(
                          "Active Teams",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "$activeTeams",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: successColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: spSm),
        Row(
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
                    Row(
                      children: [
                        Icon(Icons.trending_up, color: infoColor, size: 20),
                        SizedBox(width: spXs),
                        Text(
                          "Avg Efficiency",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "${avgEfficiency.toStringAsFixed(1)}%",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: infoColor,
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
                    Row(
                      children: [
                        Icon(Icons.security, color: warningColor, size: 20),
                        SizedBox(width: spXs),
                        Text(
                          "Safety Rating",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "${avgSafety.toStringAsFixed(1)}/5.0",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: warningColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildTeamCard(Map<String, dynamic> team) {
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spMd),
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
              CircleAvatar(
                radius: 20,
                backgroundImage: NetworkImage("${team["avatar"]}"),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${team["name"]}",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "${team["department"]}",
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
                  color: _getStatusColor("${team["status"]}").withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Text(
                  "${team["status"]}",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: _getStatusColor("${team["status"]}"),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              Icon(Icons.person, size: 16, color: disabledBoldColor),
              SizedBox(width: spXs),
              Text(
                "Lead: ${team["teamLead"]}",
                style: TextStyle(
                  fontSize: 14,
                  color: disabledBoldColor,
                ),
              ),
              Spacer(),
              Icon(Icons.people, size: 16, color: disabledBoldColor),
              SizedBox(width: spXs),
              Text(
                "${team["memberCount"]} members",
                style: TextStyle(
                  fontSize: 14,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
          SizedBox(height: spXs),
          Row(
            children: [
              Icon(Icons.work, size: 16, color: disabledBoldColor),
              SizedBox(width: spXs),
              Expanded(
                child: Text(
                  "${team["currentProject"]}",
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                  ),
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
                      "Efficiency",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Row(
                      children: [
                        Expanded(
                          child: LinearProgressIndicator(
                            value: (team["efficiency"] as int) / 100,
                            backgroundColor: disabledColor,
                            valueColor: AlwaysStoppedAnimation<Color>(
                              _getEfficiencyColor(team["efficiency"] as int),
                            ),
                          ),
                        ),
                        SizedBox(width: spSm),
                        Text(
                          "${team["efficiency"]}%",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: _getEfficiencyColor(team["efficiency"] as int),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(width: spMd),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Safety Rating",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
                  SizedBox(height: spXs),
                  Row(
                    children: List.generate(5, (index) {
                      return Icon(
                        index < (team["safetyRating"] as double).floor()
                          ? Icons.star
                          : (index < (team["safetyRating"] as double) ? Icons.star_half : Icons.star_border),
                        size: 16,
                        color: warningColor,
                      );
                    }),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              Icon(Icons.task, size: 16, color: disabledBoldColor),
              SizedBox(width: spXs),
              Text(
                "Tasks: ${team["completedTasks"]} completed, ${team["activeTasks"]} active",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
          SizedBox(height: spXs),
          Row(
            children: [
              Icon(Icons.attach_money, size: 16, color: disabledBoldColor),
              SizedBox(width: spXs),
              Text(
                "Budget: \$${((team["spent"] as double) / 1000).toStringAsFixed(0)}K / \$${((team["budget"] as double) / 1000).toStringAsFixed(0)}K",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              Expanded(
                child: QButton(
                  label: "View Details",
                  size: bs.sm,
                  onPressed: () {},
                ),
              ),
              SizedBox(width: spSm),
              QButton(
                icon: Icons.edit,
                size: bs.sm,
                onPressed: () {},
              ),
              SizedBox(width: spXs),
              QButton(
                icon: Icons.phone,
                size: bs.sm,
                onPressed: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTeamList() {
    List<Map<String, dynamic>> filtered = filteredTeams;
    
    if (filtered.isEmpty) {
      return Container(
        padding: EdgeInsets.all(spLg),
        child: Column(
          children: [
            Icon(
              Icons.search_off,
              size: 64,
              color: disabledColor,
            ),
            SizedBox(height: spMd),
            Text(
              "No teams found",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.w600,
                color: disabledBoldColor,
              ),
            ),
            SizedBox(height: spSm),
            Text(
              "Try adjusting your search criteria",
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
      children: filtered.map((team) => _buildTeamCard(team)).toList(),
    );
  }

  Widget _buildOverviewTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildOverviewCards(),
          SizedBox(height: spLg),
          Text(
            "Active Teams",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          Column(
            children: teams
                .where((team) => team["status"] == "Active")
                .take(3)
                .map((team) => _buildTeamCard(team))
                .toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildManageTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: QTextField(
                  label: "Search teams...",
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
          SizedBox(height: spSm),
          Row(
            children: [
              Expanded(
                child: QDropdownField(
                  label: "Department",
                  items: departmentItems,
                  value: selectedDepartment,
                  onChanged: (value, label) {
                    selectedDepartment = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QDropdownField(
                  label: "Status",
                  items: statusItems,
                  value: selectedStatus,
                  onChanged: (value, label) {
                    selectedStatus = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          QDropdownField(
            label: "Project",
            items: projectItems,
            value: selectedProject,
            onChanged: (value, label) {
              selectedProject = value;
              setState(() {});
            },
          ),
          SizedBox(height: spLg),
          _buildTeamList(),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Team Management",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Overview", icon: Icon(Icons.dashboard)),
        Tab(text: "Manage", icon: Icon(Icons.groups)),
      ],
      tabChildren: [
        _buildOverviewTab(),
        _buildManageTab(),
      ],
    );
  }
}
