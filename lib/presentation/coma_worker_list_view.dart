import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class ComaWorkerListView extends StatefulWidget {
  const ComaWorkerListView({super.key});

  @override
  State<ComaWorkerListView> createState() => _ComaWorkerListViewState();
}

class _ComaWorkerListViewState extends State<ComaWorkerListView> {
  String searchQuery = "";
  String selectedDepartment = "All";
  String selectedStatus = "All";
  String selectedSkill = "All";
  int currentTab = 0;

  List<Map<String, dynamic>> workers = [
    {
      "id": "WKR001",
      "name": "John Smith",
      "position": "Senior Foreman",
      "department": "General Construction",
      "phone": "+1-555-0301",
      "email": "j.smith@company.com",
      "primarySkill": "Project Management",
      "skills": ["Leadership", "Safety Management", "Quality Control"],
      "experience": 15,
      "hourlyRate": 75.0,
      "currentAssignment": "Riverside Office Complex",
      "status": "Active",
      "availability": "Full Time",
      "shiftPreference": "Day Shift",
      "safetyRating": 5.0,
      "performance": 96,
      "certifications": ["OSHA 30", "Project Management", "First Aid"],
      "emergencyContact": "Jane Smith (+1-555-0302)",
      "hireDate": "2019-03-15",
      "lastTraining": "2024-01-10",
      "weeklyHours": 45,
      "overtime": 8.0,
      "avatar": "https://picsum.photos/100/100?random=501&keyword=man"
    },
    {
      "id": "WKR002",
      "name": "Maria Rodriguez",
      "position": "Electrician",
      "department": "Electrical",
      "phone": "+1-555-0303",
      "email": "m.rodriguez@company.com",
      "primarySkill": "Commercial Wiring",
      "skills": ["Panel Installation", "Motor Controls", "Lighting Systems"],
      "experience": 8,
      "hourlyRate": 68.0,
      "currentAssignment": "Downtown Mall Renovation",
      "status": "Active",
      "availability": "Full Time",
      "shiftPreference": "Day Shift",
      "safetyRating": 4.8,
      "performance": 92,
      "certifications": ["Licensed Electrician", "Arc Flash Training", "NFPA 70E"],
      "emergencyContact": "Carlos Rodriguez (+1-555-0304)",
      "hireDate": "2020-07-22",
      "lastTraining": "2024-01-08",
      "weeklyHours": 42,
      "overtime": 6.0,
      "avatar": "https://picsum.photos/100/100?random=502&keyword=woman"
    },
    {
      "id": "WKR003",
      "name": "David Chen",
      "position": "HVAC Technician",
      "department": "HVAC",
      "phone": "+1-555-0305",
      "email": "d.chen@company.com",
      "primarySkill": "Climate Control Systems",
      "skills": ["Ductwork", "Equipment Installation", "System Diagnostics"],
      "experience": 12,
      "hourlyRate": 72.0,
      "currentAssignment": "Hospital Wing Extension",
      "status": "Active",
      "availability": "Full Time",
      "shiftPreference": "Day Shift",
      "safetyRating": 4.9,
      "performance": 94,
      "certifications": ["EPA 608", "NATE Certification", "Refrigeration License"],
      "emergencyContact": "Linda Chen (+1-555-0306)",
      "hireDate": "2018-11-05",
      "lastTraining": "2024-01-12",
      "weeklyHours": 40,
      "overtime": 4.0,
      "avatar": "https://picsum.photos/100/100?random=503&keyword=man"
    },
    {
      "id": "WKR004",
      "name": "Sarah Johnson",
      "position": "Carpenter",
      "department": "General Construction",
      "phone": "+1-555-0307",
      "email": "s.johnson@company.com",
      "primarySkill": "Finish Carpentry",
      "skills": ["Framing", "Cabinet Installation", "Trim Work"],
      "experience": 6,
      "hourlyRate": 62.0,
      "currentAssignment": "Corporate Headquarters",
      "status": "On Leave",
      "availability": "Part Time",
      "shiftPreference": "Day Shift",
      "safetyRating": 4.7,
      "performance": 88,
      "certifications": ["Carpentry Certification", "Fall Protection"],
      "emergencyContact": "Mark Johnson (+1-555-0308)",
      "hireDate": "2021-02-14",
      "lastTraining": "2023-12-15",
      "weeklyHours": 35,
      "overtime": 0.0,
      "avatar": "https://picsum.photos/100/100?random=504&keyword=woman"
    },
    {
      "id": "WKR005",
      "name": "Michael Brown",
      "position": "Concrete Worker",
      "department": "General Construction",
      "phone": "+1-555-0309",
      "email": "m.brown@company.com",
      "primarySkill": "Concrete Finishing",
      "skills": ["Formwork", "Rebar Installation", "Surface Finishing"],
      "experience": 10,
      "hourlyRate": 65.0,
      "currentAssignment": "Foundation Work - Building A",
      "status": "Active",
      "availability": "Full Time",
      "shiftPreference": "Day Shift",
      "safetyRating": 4.6,
      "performance": 90,
      "certifications": ["Concrete Finishing", "Heavy Equipment Operation"],
      "emergencyContact": "Susan Brown (+1-555-0310)",
      "hireDate": "2019-08-30",
      "lastTraining": "2024-01-05",
      "weeklyHours": 44,
      "overtime": 12.0,
      "avatar": "https://picsum.photos/100/100?random=505&keyword=man"
    },
    {
      "id": "WKR006",
      "name": "Lisa Davis",
      "position": "Plumber",
      "department": "Plumbing",
      "phone": "+1-555-0311",
      "email": "l.davis@company.com",
      "primarySkill": "Pipe Installation",
      "skills": ["Fixture Setup", "Drain Cleaning", "Water Heater Installation"],
      "experience": 9,
      "hourlyRate": 70.0,
      "currentAssignment": "Residential Complex Phase 2",
      "status": "Active",
      "availability": "Full Time",
      "shiftPreference": "Day Shift",
      "safetyRating": 4.8,
      "performance": 93,
      "certifications": ["Master Plumber", "Backflow Prevention", "Gas Line Certification"],
      "emergencyContact": "Tom Davis (+1-555-0312)",
      "hireDate": "2020-01-12",
      "lastTraining": "2024-01-15",
      "weeklyHours": 41,
      "overtime": 5.0,
      "avatar": "https://picsum.photos/100/100?random=506&keyword=woman"
    },
    {
      "id": "WKR007",
      "name": "Robert Wilson",
      "position": "Painter",
      "department": "Interior Finishing",
      "phone": "+1-555-0313",
      "email": "r.wilson@company.com",
      "primarySkill": "Interior Painting",
      "skills": ["Spray Painting", "Surface Preparation", "Color Matching"],
      "experience": 7,
      "hourlyRate": 58.0,
      "currentAssignment": "Office Building Floor 3",
      "status": "Active",
      "availability": "Full Time",
      "shiftPreference": "Day Shift",
      "safetyRating": 4.5,
      "performance": 87,
      "certifications": ["Lead-Safe Work Practices", "EPA RRP"],
      "emergencyContact": "Amy Wilson (+1-555-0314)",
      "hireDate": "2021-06-08",
      "lastTraining": "2023-11-20",
      "weeklyHours": 40,
      "overtime": 2.0,
      "avatar": "https://picsum.photos/100/100?random=507&keyword=man"
    },
    {
      "id": "WKR008",
      "name": "Jennifer Lee",
      "position": "Safety Inspector",
      "department": "Safety & Quality",
      "phone": "+1-555-0315",
      "email": "j.lee@company.com",
      "primarySkill": "Safety Compliance",
      "skills": ["Inspection", "Risk Assessment", "Training"],
      "experience": 13,
      "hourlyRate": 78.0,
      "currentAssignment": "Multi-Project Support",
      "status": "Active",
      "availability": "Full Time",
      "shiftPreference": "Day Shift",
      "safetyRating": 5.0,
      "performance": 98,
      "certifications": ["CSP", "CIH", "OSHA 500", "ISO 45001"],
      "emergencyContact": "Kevin Lee (+1-555-0316)",
      "hireDate": "2017-04-25",
      "lastTraining": "2024-01-20",
      "weeklyHours": 42,
      "overtime": 3.0,
      "avatar": "https://picsum.photos/100/100?random=508&keyword=woman"
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
    {"label": "Terminated", "value": "Terminated"},
    {"label": "Training", "value": "Training"},
  ];

  List<Map<String, dynamic>> skillItems = [
    {"label": "All", "value": "All"},
    {"label": "Project Management", "value": "Project Management"},
    {"label": "Commercial Wiring", "value": "Commercial Wiring"},
    {"label": "Climate Control Systems", "value": "Climate Control Systems"},
    {"label": "Finish Carpentry", "value": "Finish Carpentry"},
    {"label": "Concrete Finishing", "value": "Concrete Finishing"},
    {"label": "Pipe Installation", "value": "Pipe Installation"},
    {"label": "Interior Painting", "value": "Interior Painting"},
    {"label": "Safety Compliance", "value": "Safety Compliance"},
  ];

  List<Map<String, dynamic>> get filteredWorkers {
    return workers.where((worker) {
      bool matchesSearch = searchQuery.isEmpty ||
          "${worker["name"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
          "${worker["position"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
          "${worker["id"]}".toLowerCase().contains(searchQuery.toLowerCase());
      
      bool matchesDepartment = selectedDepartment == "All" || worker["department"] == selectedDepartment;
      bool matchesStatus = selectedStatus == "All" || worker["status"] == selectedStatus;
      bool matchesSkill = selectedSkill == "All" || worker["primarySkill"] == selectedSkill;
      
      return matchesSearch && matchesDepartment && matchesStatus && matchesSkill;
    }).toList();
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "Active": return successColor;
      case "On Leave": return warningColor;
      case "Terminated": return dangerColor;
      case "Training": return infoColor;
      default: return disabledColor;
    }
  }

  Color _getPerformanceColor(int performance) {
    if (performance >= 95) return successColor;
    if (performance >= 85) return primaryColor;
    if (performance >= 75) return warningColor;
    return dangerColor;
  }

  Widget _buildOverviewCards() {
    int totalWorkers = workers.length;
    int activeWorkers = workers.where((worker) => worker["status"] == "Active").length;
    double avgPerformance = workers.fold(0.0, (sum, worker) => sum + (worker["performance"] as int)) / totalWorkers;
    double avgSafety = workers.fold(0.0, (sum, worker) => sum + (worker["safetyRating"] as double)) / totalWorkers;

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
                        Icon(Icons.person, color: primaryColor, size: 20),
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
                      "$totalWorkers",
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
                          "Active Workers",
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
                      "$activeWorkers",
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
                          "Avg Performance",
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
                      "${avgPerformance.toStringAsFixed(1)}%",
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

  Widget _buildWorkerCard(Map<String, dynamic> worker) {
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
                backgroundImage: NetworkImage("${worker["avatar"]}"),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${worker["name"]}",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "${worker["position"]} • ${worker["department"]}",
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
                  color: _getStatusColor("${worker["status"]}").withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Text(
                  "${worker["status"]}",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: _getStatusColor("${worker["status"]}"),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              Icon(Icons.work_history, size: 16, color: disabledBoldColor),
              SizedBox(width: spXs),
              Text(
                "${worker["experience"]} years experience",
                style: TextStyle(
                  fontSize: 14,
                  color: disabledBoldColor,
                ),
              ),
              Spacer(),
              Icon(Icons.attach_money, size: 16, color: disabledBoldColor),
              SizedBox(width: spXs),
              Text(
                "\$${(worker["hourlyRate"] as double).toStringAsFixed(0)}/hr",
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
              Icon(Icons.assignment, size: 16, color: disabledBoldColor),
              SizedBox(width: spXs),
              Expanded(
                child: Text(
                  "${worker["currentAssignment"]}",
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
                      "Performance",
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
                            value: (worker["performance"] as int) / 100,
                            backgroundColor: disabledColor,
                            valueColor: AlwaysStoppedAnimation<Color>(
                              _getPerformanceColor(worker["performance"] as int),
                            ),
                          ),
                        ),
                        SizedBox(width: spSm),
                        Text(
                          "${worker["performance"]}%",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: _getPerformanceColor(worker["performance"] as int),
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
                        index < (worker["safetyRating"] as double).floor()
                          ? Icons.star
                          : (index < (worker["safetyRating"] as double) ? Icons.star_half : Icons.star_border),
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
              Icon(Icons.access_time, size: 16, color: disabledBoldColor),
              SizedBox(width: spXs),
              Text(
                "Weekly: ${worker["weeklyHours"]}h",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
              if ((worker["overtime"] as double) > 0) ...[
                SizedBox(width: spMd),
                Icon(Icons.schedule, size: 16, color: warningColor),
                SizedBox(width: spXs),
                Text(
                  "OT: ${(worker["overtime"] as double).toStringAsFixed(1)}h",
                  style: TextStyle(
                    fontSize: 12,
                    color: warningColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ],
          ),
          SizedBox(height: spXs),
          Row(
            children: [
              Icon(Icons.phone, size: 16, color: disabledBoldColor),
              SizedBox(width: spXs),
              Text(
                "${worker["phone"]}",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
              Spacer(),
              Icon(Icons.calendar_month, size: 16, color: disabledBoldColor),
              SizedBox(width: spXs),
              Text(
                "Hired: ${worker["hireDate"]}",
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
                  "Primary Skill: ${worker["primarySkill"]}",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spXs),
                Text(
                  "Skills: ${(worker["skills"] as List).join(", ")}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
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
                  label: "View Profile",
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

  Widget _buildWorkerList() {
    List<Map<String, dynamic>> filtered = filteredWorkers;
    
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
              "No workers found",
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
      children: filtered.map((worker) => _buildWorkerCard(worker)).toList(),
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
            "Top Performers",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          Column(
            children: workers
                .where((worker) => (worker["performance"] as int) >= 95)
                .take(3)
                .map((worker) => _buildWorkerCard(worker))
                .toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildWorkerListTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: QTextField(
                  label: "Search workers...",
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
            label: "Primary Skill",
            items: skillItems,
            value: selectedSkill,
            onChanged: (value, label) {
              selectedSkill = value;
              setState(() {});
            },
          ),
          SizedBox(height: spLg),
          _buildWorkerList(),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Worker List",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Overview", icon: Icon(Icons.dashboard)),
        Tab(text: "All Workers", icon: Icon(Icons.people)),
      ],
      tabChildren: [
        _buildOverviewTab(),
        _buildWorkerListTab(),
      ],
    );
  }
}
