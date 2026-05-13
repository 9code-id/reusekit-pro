import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class ComaCrewManagementView extends StatefulWidget {
  const ComaCrewManagementView({super.key});

  @override
  State<ComaCrewManagementView> createState() => _ComaCrewManagementViewState();
}

class _ComaCrewManagementViewState extends State<ComaCrewManagementView> {
  String searchQuery = "";
  String selectedSkill = "All";
  String selectedStatus = "All";
  String selectedShift = "All";
  int currentTab = 0;

  List<Map<String, dynamic>> crews = [
    {
      "id": "CREW001",
      "name": "Foundation Specialists",
      "foreman": "Carlos Rodriguez",
      "foremanPhone": "+1-555-0201",
      "memberCount": 6,
      "primarySkill": "Foundation Work",
      "skills": ["Excavation", "Concrete Pouring", "Rebar Installation"],
      "currentLocation": "Site A - Building Foundation",
      "shift": "Day Shift",
      "status": "Active",
      "productivity": 94,
      "safetyRecord": 4.9,
      "completedJobs": 23,
      "currentJob": "Foundation Pour - Building A",
      "hourlyRate": 65.0,
      "overtime": 12.5,
      "weeklyHours": 45,
      "certifications": ["Concrete Specialist", "Heavy Equipment Operator"],
      "equipment": ["Excavator", "Concrete Pump", "Rebar Cutter"],
      "startDate": "2024-01-08",
      "nextRotation": "2024-02-15",
      "avatar": "https://picsum.photos/100/100?random=401&keyword=construction"
    },
    {
      "id": "CREW002",
      "name": "Framing Masters",
      "foreman": "Jake Thompson",
      "foremanPhone": "+1-555-0202",
      "memberCount": 8,
      "primarySkill": "Structural Framing",
      "skills": ["Wood Framing", "Steel Assembly", "Blueprint Reading"],
      "currentLocation": "Site B - Floor 2",
      "shift": "Day Shift",
      "status": "Active",
      "productivity": 89,
      "safetyRecord": 4.7,
      "completedJobs": 18,
      "currentJob": "Second Floor Framing",
      "hourlyRate": 68.0,
      "overtime": 8.0,
      "weeklyHours": 42,
      "certifications": ["Structural Framing", "Fall Protection"],
      "equipment": ["Nail Guns", "Circular Saws", "Level Tools"],
      "startDate": "2024-01-10",
      "nextRotation": "2024-02-20",
      "avatar": "https://picsum.photos/100/100?random=402&keyword=construction"
    },
    {
      "id": "CREW003",
      "name": "Electrical Installation Team",
      "foreman": "Diana Martinez",
      "foremanPhone": "+1-555-0203",
      "memberCount": 5,
      "primarySkill": "Electrical Systems",
      "skills": ["Wiring", "Panel Installation", "Lighting Systems"],
      "currentLocation": "Mall Section C",
      "shift": "Night Shift",
      "status": "Active",
      "productivity": 92,
      "safetyRecord": 4.8,
      "completedJobs": 31,
      "currentJob": "Electrical Panel Upgrade",
      "hourlyRate": 72.0,
      "overtime": 15.0,
      "weeklyHours": 40,
      "certifications": ["Licensed Electrician", "Arc Flash Safety"],
      "equipment": ["Wire Pullers", "Conduit Benders", "Multimeters"],
      "startDate": "2024-01-12",
      "nextRotation": "2024-02-25",
      "avatar": "https://picsum.photos/100/100?random=403&keyword=construction"
    },
    {
      "id": "CREW004",
      "name": "HVAC Installers",
      "foreman": "Robert Lee",
      "foremanPhone": "+1-555-0204",
      "memberCount": 4,
      "primarySkill": "HVAC Systems",
      "skills": ["Ductwork", "Equipment Installation", "System Testing"],
      "currentLocation": "Hospital Wing",
      "shift": "Day Shift",
      "status": "On Break",
      "productivity": 88,
      "safetyRecord": 4.6,
      "completedJobs": 15,
      "currentJob": "HVAC System Installation",
      "hourlyRate": 70.0,
      "overtime": 6.0,
      "weeklyHours": 38,
      "certifications": ["EPA Certification", "Refrigeration License"],
      "equipment": ["Duct Machines", "Gauges", "Vacuum Pumps"],
      "startDate": "2024-01-15",
      "nextRotation": "2024-03-01",
      "avatar": "https://picsum.photos/100/100?random=404&keyword=construction"
    },
    {
      "id": "CREW005",
      "name": "Finishing Crew Alpha",
      "foreman": "Sandra Kim",
      "foremanPhone": "+1-555-0205",
      "memberCount": 7,
      "primarySkill": "Interior Finishing",
      "skills": ["Drywall", "Painting", "Flooring", "Trim Installation"],
      "currentLocation": "Office Building Floor 3",
      "shift": "Day Shift",
      "status": "Active",
      "productivity": 96,
      "safetyRecord": 4.9,
      "completedJobs": 42,
      "currentJob": "Interior Finishing - Offices",
      "hourlyRate": 58.0,
      "overtime": 10.0,
      "weeklyHours": 44,
      "certifications": ["Lead-Safe Work Practices", "EPA RRP"],
      "equipment": ["Spray Equipment", "Sanders", "Paint Brushes"],
      "startDate": "2024-01-05",
      "nextRotation": "2024-02-18",
      "avatar": "https://picsum.photos/100/100?random=405&keyword=construction"
    },
    {
      "id": "CREW006",
      "name": "Plumbing Specialists",
      "foreman": "Tony Wilson",
      "foremanPhone": "+1-555-0206",
      "memberCount": 4,
      "primarySkill": "Plumbing Systems",
      "skills": ["Pipe Installation", "Fixture Setup", "Water Systems"],
      "currentLocation": "Residential Building A",
      "shift": "Day Shift",
      "status": "Scheduled",
      "productivity": 85,
      "safetyRecord": 4.5,
      "completedJobs": 26,
      "currentJob": "Bathroom Plumbing Installation",
      "hourlyRate": 66.0,
      "overtime": 4.0,
      "weeklyHours": 40,
      "certifications": ["Master Plumber", "Backflow Prevention"],
      "equipment": ["Pipe Cutters", "Soldering Tools", "Snake Machines"],
      "startDate": "2024-01-18",
      "nextRotation": "2024-03-05",
      "avatar": "https://picsum.photos/100/100?random=406&keyword=construction"
    }
  ];

  List<Map<String, dynamic>> skillItems = [
    {"label": "All", "value": "All"},
    {"label": "Foundation Work", "value": "Foundation Work"},
    {"label": "Structural Framing", "value": "Structural Framing"},
    {"label": "Electrical Systems", "value": "Electrical Systems"},
    {"label": "HVAC Systems", "value": "HVAC Systems"},
    {"label": "Interior Finishing", "value": "Interior Finishing"},
    {"label": "Plumbing Systems", "value": "Plumbing Systems"},
  ];

  List<Map<String, dynamic>> statusItems = [
    {"label": "All", "value": "All"},
    {"label": "Active", "value": "Active"},
    {"label": "On Break", "value": "On Break"},
    {"label": "Scheduled", "value": "Scheduled"},
    {"label": "Off Duty", "value": "Off Duty"},
  ];

  List<Map<String, dynamic>> shiftItems = [
    {"label": "All", "value": "All"},
    {"label": "Day Shift", "value": "Day Shift"},
    {"label": "Night Shift", "value": "Night Shift"},
    {"label": "Weekend", "value": "Weekend"},
  ];

  List<Map<String, dynamic>> get filteredCrews {
    return crews.where((crew) {
      bool matchesSearch = searchQuery.isEmpty ||
          "${crew["name"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
          "${crew["foreman"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
          "${crew["id"]}".toLowerCase().contains(searchQuery.toLowerCase());
      
      bool matchesSkill = selectedSkill == "All" || crew["primarySkill"] == selectedSkill;
      bool matchesStatus = selectedStatus == "All" || crew["status"] == selectedStatus;
      bool matchesShift = selectedShift == "All" || crew["shift"] == selectedShift;
      
      return matchesSearch && matchesSkill && matchesStatus && matchesShift;
    }).toList();
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "Active": return successColor;
      case "On Break": return warningColor;
      case "Scheduled": return infoColor;
      case "Off Duty": return disabledColor;
      default: return disabledColor;
    }
  }

  Color _getProductivityColor(int productivity) {
    if (productivity >= 95) return successColor;
    if (productivity >= 85) return primaryColor;
    if (productivity >= 75) return warningColor;
    return dangerColor;
  }

  Widget _buildOverviewCards() {
    int totalCrews = crews.length;
    int activeCrews = crews.where((crew) => crew["status"] == "Active").length;
    double avgProductivity = crews.fold(0.0, (sum, crew) => sum + (crew["productivity"] as int)) / totalCrews;
    int totalMembers = crews.fold(0, (sum, crew) => sum + (crew["memberCount"] as int));

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
                        Icon(Icons.engineering, color: primaryColor, size: 20),
                        SizedBox(width: spXs),
                        Text(
                          "Total Crews",
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
                      "$totalCrews",
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
                          "Active Crews",
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
                      "$activeCrews",
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
                          "Avg Productivity",
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
                      "${avgProductivity.toStringAsFixed(1)}%",
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
                        Icon(Icons.people, color: warningColor, size: 20),
                        SizedBox(width: spXs),
                        Text(
                          "Total Workers",
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
                      "$totalMembers",
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

  Widget _buildCrewCard(Map<String, dynamic> crew) {
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
                backgroundImage: NetworkImage("${crew["avatar"]}"),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${crew["name"]}",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "${crew["primarySkill"]}",
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
                  color: _getStatusColor("${crew["status"]}").withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Text(
                  "${crew["status"]}",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: _getStatusColor("${crew["status"]}"),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              Icon(Icons.supervisor_account, size: 16, color: disabledBoldColor),
              SizedBox(width: spXs),
              Text(
                "Foreman: ${crew["foreman"]}",
                style: TextStyle(
                  fontSize: 14,
                  color: disabledBoldColor,
                ),
              ),
              Spacer(),
              Icon(Icons.people, size: 16, color: disabledBoldColor),
              SizedBox(width: spXs),
              Text(
                "${crew["memberCount"]} workers",
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
              Icon(Icons.location_on, size: 16, color: disabledBoldColor),
              SizedBox(width: spXs),
              Expanded(
                child: Text(
                  "${crew["currentLocation"]}",
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                  ),
                ),
              ),
              Icon(Icons.schedule, size: 16, color: disabledBoldColor),
              SizedBox(width: spXs),
              Text(
                "${crew["shift"]}",
                style: TextStyle(
                  fontSize: 14,
                  color: disabledBoldColor,
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
                      "Productivity",
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
                            value: (crew["productivity"] as int) / 100,
                            backgroundColor: disabledColor,
                            valueColor: AlwaysStoppedAnimation<Color>(
                              _getProductivityColor(crew["productivity"] as int),
                            ),
                          ),
                        ),
                        SizedBox(width: spSm),
                        Text(
                          "${crew["productivity"]}%",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: _getProductivityColor(crew["productivity"] as int),
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
                    "Safety Record",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
                  SizedBox(height: spXs),
                  Row(
                    children: List.generate(5, (index) {
                      return Icon(
                        index < (crew["safetyRecord"] as double).floor()
                          ? Icons.star
                          : (index < (crew["safetyRecord"] as double) ? Icons.star_half : Icons.star_border),
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
                "Jobs: ${crew["completedJobs"]} completed",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
              Spacer(),
              Icon(Icons.attach_money, size: 16, color: disabledBoldColor),
              SizedBox(width: spXs),
              Text(
                "\$${(crew["hourlyRate"] as double).toStringAsFixed(0)}/hr",
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
              Icon(Icons.work_history, size: 16, color: disabledBoldColor),
              SizedBox(width: spXs),
              Text(
                "Weekly: ${crew["weeklyHours"]}h (OT: ${(crew["overtime"] as double).toStringAsFixed(1)}h)",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: infoColor.withAlpha(10),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Current Job:",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: disabledBoldColor,
                  ),
                ),
                SizedBox(height: spXs),
                Text(
                  "${crew["currentJob"]}",
                  style: TextStyle(
                    fontSize: 14,
                    color: primaryColor,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              Expanded(
                child: QButton(
                  label: "View Crew",
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

  Widget _buildCrewList() {
    List<Map<String, dynamic>> filtered = filteredCrews;
    
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
              "No crews found",
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
      children: filtered.map((crew) => _buildCrewCard(crew)).toList(),
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
            "Active Crews",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          Column(
            children: crews
                .where((crew) => crew["status"] == "Active")
                .take(3)
                .map((crew) => _buildCrewCard(crew))
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
                  label: "Search crews...",
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
                  label: "Primary Skill",
                  items: skillItems,
                  value: selectedSkill,
                  onChanged: (value, label) {
                    selectedSkill = value;
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
            label: "Shift",
            items: shiftItems,
            value: selectedShift,
            onChanged: (value, label) {
              selectedShift = value;
              setState(() {});
            },
          ),
          SizedBox(height: spLg),
          _buildCrewList(),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Crew Management",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Overview", icon: Icon(Icons.dashboard)),
        Tab(text: "Manage", icon: Icon(Icons.engineering)),
      ],
      tabChildren: [
        _buildOverviewTab(),
        _buildManageTab(),
      ],
    );
  }
}
