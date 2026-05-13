import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class CrmAgentListView extends StatefulWidget {
  const CrmAgentListView({super.key});

  @override
  State<CrmAgentListView> createState() => _CrmAgentListViewState();
}

class _CrmAgentListViewState extends State<CrmAgentListView> {
  String selectedStatus = "All Status";
  String selectedDepartment = "All Departments";
  String sortBy = "Performance";
  String searchQuery = "";
  
  List<Map<String, dynamic>> statusOptions = [
    {"label": "All Status", "value": "All Status"},
    {"label": "Active", "value": "Active"},
    {"label": "Inactive", "value": "Inactive"},
    {"label": "On Leave", "value": "On Leave"},
  ];
  
  List<Map<String, dynamic>> departmentOptions = [
    {"label": "All Departments", "value": "All Departments"},
    {"label": "Sales", "value": "Sales"},
    {"label": "Marketing", "value": "Marketing"},
    {"label": "Customer Support", "value": "Customer Support"},
    {"label": "Technical", "value": "Technical"},
  ];
  
  List<Map<String, dynamic>> sortOptions = [
    {"label": "Performance", "value": "Performance"},
    {"label": "Name", "value": "Name"},
    {"label": "Revenue", "value": "Revenue"},
    {"label": "Join Date", "value": "Join Date"},
  ];
  
  List<Map<String, dynamic>> agents = [
    {
      "id": "AG001",
      "name": "Sarah Johnson",
      "email": "sarah.johnson@company.com",
      "phone": "+1 (555) 123-4567",
      "avatar": "https://picsum.photos/60/60?random=1&keyword=woman",
      "department": "Sales",
      "position": "Senior Sales Representative",
      "team": "Enterprise Sales Team",
      "manager": "Alex Rodriguez",
      "status": "Active",
      "joinDate": "2022-03-15",
      "lastActive": "2024-12-19 10:30",
      "performance": 94.5,
      "dealsCompleted": 45,
      "totalRevenue": 250000.0,
      "monthlyTarget": 50000.0,
      "currentMonthRevenue": 48000.0,
      "experience": "5 years",
      "skills": ["B2B Sales", "Lead Generation", "CRM Management"],
      "certifications": ["Salesforce Certified", "HubSpot Sales"],
      "languages": ["English", "Spanish"],
    },
    {
      "id": "AG002",
      "name": "Mike Chen",
      "email": "mike.chen@company.com",
      "phone": "+1 (555) 234-5678",
      "avatar": "https://picsum.photos/60/60?random=2&keyword=man",
      "department": "Sales",
      "position": "Sales Representative",
      "team": "SMB Sales Team",
      "manager": "Sarah Johnson",
      "status": "Active",
      "joinDate": "2023-01-20",
      "lastActive": "2024-12-19 09:15",
      "performance": 87.2,
      "dealsCompleted": 32,
      "totalRevenue": 180000.0,
      "monthlyTarget": 35000.0,
      "currentMonthRevenue": 32000.0,
      "experience": "3 years",
      "skills": ["SMB Sales", "Account Management", "Pipeline Management"],
      "certifications": ["Google Ads Certified"],
      "languages": ["English", "Mandarin"],
    },
    {
      "id": "AG003",
      "name": "Emily Davis",
      "email": "emily.davis@company.com",
      "phone": "+1 (555) 345-6789",
      "avatar": "https://picsum.photos/60/60?random=3&keyword=woman",
      "department": "Customer Support",
      "position": "Customer Success Manager",
      "team": "Customer Success Team",
      "manager": "Lisa Wang",
      "status": "Active",
      "joinDate": "2021-09-10",
      "lastActive": "2024-12-19 11:45",
      "performance": 96.8,
      "dealsCompleted": 0,
      "totalRevenue": 0.0,
      "monthlyTarget": 0.0,
      "currentMonthRevenue": 0.0,
      "experience": "4 years",
      "skills": ["Customer Retention", "Product Training", "Support Management"],
      "certifications": ["Customer Success Certified", "Zendesk Expert"],
      "languages": ["English", "French"],
    },
    {
      "id": "AG004",
      "name": "David Wilson",
      "email": "david.wilson@company.com",
      "phone": "+1 (555) 456-7890",
      "avatar": "https://picsum.photos/60/60?random=4&keyword=man",
      "department": "Marketing",
      "position": "Digital Marketing Specialist",
      "team": "Digital Marketing Team",
      "manager": "Kevin Park",
      "status": "Active",
      "joinDate": "2022-11-05",
      "lastActive": "2024-12-19 08:20",
      "performance": 82.1,
      "dealsCompleted": 0,
      "totalRevenue": 0.0,
      "monthlyTarget": 0.0,
      "currentMonthRevenue": 0.0,
      "experience": "2 years",
      "skills": ["SEO", "Content Marketing", "Social Media", "Analytics"],
      "certifications": ["Google Analytics", "Facebook Ads"],
      "languages": ["English"],
    },
    {
      "id": "AG005",
      "name": "Jessica Miller",
      "email": "jessica.miller@company.com",
      "phone": "+1 (555) 567-8901",
      "avatar": "https://picsum.photos/60/60?random=5&keyword=woman",
      "department": "Sales",
      "position": "Junior Sales Representative",
      "team": "SMB Sales Team",
      "manager": "Alex Rodriguez",
      "status": "On Leave",
      "joinDate": "2023-08-12",
      "lastActive": "2024-12-10 16:30",
      "performance": 74.6,
      "dealsCompleted": 18,
      "totalRevenue": 85000.0,
      "monthlyTarget": 25000.0,
      "currentMonthRevenue": 15000.0,
      "experience": "1 year",
      "skills": ["Lead Qualification", "Cold Calling", "Email Marketing"],
      "certifications": ["Sales Fundamentals"],
      "languages": ["English"],
    },
    {
      "id": "AG006",
      "name": "Tom Anderson",
      "email": "tom.anderson@company.com",
      "phone": "+1 (555) 678-9012",
      "avatar": "https://picsum.photos/60/60?random=6&keyword=man",
      "department": "Technical",
      "position": "Solutions Engineer",
      "team": "Technical Team",
      "manager": "Robert Kim",
      "status": "Inactive",
      "joinDate": "2020-05-18",
      "lastActive": "2024-11-28 14:20",
      "performance": 89.3,
      "dealsCompleted": 0,
      "totalRevenue": 0.0,
      "monthlyTarget": 0.0,
      "currentMonthRevenue": 0.0,
      "experience": "6 years",
      "skills": ["Technical Sales", "Solution Architecture", "API Integration"],
      "certifications": ["AWS Certified", "Azure Solutions Architect"],
      "languages": ["English", "German"],
    },
  ];

  List<Map<String, dynamic>> get filteredAgents {
    List<Map<String, dynamic>> filtered = agents;
    
    if (selectedStatus != "All Status") {
      filtered = filtered.where((agent) => agent["status"] == selectedStatus).toList();
    }
    
    if (selectedDepartment != "All Departments") {
      filtered = filtered.where((agent) => agent["department"] == selectedDepartment).toList();
    }
    
    if (searchQuery.isNotEmpty) {
      filtered = filtered.where((agent) =>
        (agent["name"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
        (agent["email"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
        (agent["id"] as String).toLowerCase().contains(searchQuery.toLowerCase())).toList();
    }
    
    // Sort agents
    filtered.sort((a, b) {
      switch (sortBy) {
        case "Name":
          return (a["name"] as String).compareTo(b["name"] as String);
        case "Revenue":
          return (b["totalRevenue"] as double).compareTo(a["totalRevenue"] as double);
        case "Join Date":
          return DateTime.parse(b["joinDate"]).compareTo(DateTime.parse(a["joinDate"]));
        case "Performance":
        default:
          return (b["performance"] as double).compareTo(a["performance"] as double);
      }
    });
    
    return filtered;
  }
  
  Color _getStatusColor(String status) {
    switch (status) {
      case "Active":
        return successColor;
      case "On Leave":
        return warningColor;
      case "Inactive":
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }
  
  Color _getPerformanceColor(double performance) {
    if (performance >= 90) return successColor;
    if (performance >= 75) return warningColor;
    return dangerColor;
  }

  @override
  Widget build(BuildContext context) {
    int activeAgents = agents.where((agent) => agent["status"] == "Active").length;
    double avgPerformance = agents.isEmpty ? 0.0 : 
      agents.fold(0.0, (sum, item) => sum + (item["performance"] as double)) / agents.length;
    double totalRevenue = agents.fold(0.0, (sum, item) => sum + (item["totalRevenue"] as double));
    
    return Scaffold(
      appBar: AppBar(
        title: Text("Agent Directory"),
        actions: [
          QButton(
            icon: Icons.person_add,
            size: bs.sm,
            onPressed: () {
              ss("Add new agent feature coming soon");
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
                        "Filters & Search",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.w600,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  QTextField(
                    label: "Search Agents",
                    value: searchQuery,
                    hint: "Search by name, email, or ID",
                    onChanged: (value) {
                      searchQuery = value;
                      setState(() {});
                    },
                  ),
                  ResponsiveGridView(
                    padding: EdgeInsets.zero,
                    minItemWidth: 200,
                    children: [
                      QDropdownField(
                        label: "Status",
                        items: statusOptions,
                        value: selectedStatus,
                        onChanged: (value, label) {
                          selectedStatus = value;
                          setState(() {});
                        },
                      ),
                      QDropdownField(
                        label: "Department",
                        items: departmentOptions,
                        value: selectedDepartment,
                        onChanged: (value, label) {
                          selectedDepartment = value;
                          setState(() {});
                        },
                      ),
                      QDropdownField(
                        label: "Sort By",
                        items: sortOptions,
                        value: sortBy,
                        onChanged: (value, label) {
                          sortBy = value;
                          setState(() {});
                        },
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
                            child: Icon(Icons.people, color: primaryColor, size: 20),
                          ),
                          SizedBox(width: spSm),
                          Text(
                            "Total Agents",
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
                        "${agents.length}",
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
                            child: Icon(Icons.check_circle, color: successColor, size: 20),
                          ),
                          SizedBox(width: spSm),
                          Text(
                            "Active Agents",
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
                        "$activeAgents",
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
                        "${avgPerformance.toStringAsFixed(1)}%",
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
            
            // Agents List
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
                        Icon(Icons.people, color: primaryColor, size: 20),
                        SizedBox(width: spXs),
                        Text(
                          "Agents",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.w600,
                            color: primaryColor,
                          ),
                        ),
                        Spacer(),
                        Text(
                          "${filteredAgents.length} results",
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
                    itemCount: filteredAgents.length,
                    itemBuilder: (context, index) {
                      final agent = filteredAgents[index];
                      final statusColor = _getStatusColor(agent["status"]);
                      final performanceColor = _getPerformanceColor(agent["performance"] as double);
                      final isSalesAgent = (agent["totalRevenue"] as double) > 0;
                      
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
                                    "${agent["avatar"]}",
                                    width: 60,
                                    height: 60,
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
                                            "${agent["name"]}",
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
                                              color: statusColor.withAlpha(20),
                                              borderRadius: BorderRadius.circular(radiusXs),
                                            ),
                                            child: Text(
                                              "${agent["status"]}",
                                              style: TextStyle(
                                                fontSize: 10,
                                                fontWeight: FontWeight.w600,
                                                color: statusColor,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: spXs),
                                      Text(
                                        "${agent["position"]} • ${agent["department"]}",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                      SizedBox(height: spXs),
                                      Text(
                                        "${agent["email"]}",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: infoColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Container(
                                      padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                      decoration: BoxDecoration(
                                        color: performanceColor.withAlpha(20),
                                        borderRadius: BorderRadius.circular(radiusXs),
                                      ),
                                      child: Text(
                                        "${(agent["performance"] as double).toStringAsFixed(1)}%",
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600,
                                          color: performanceColor,
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: spXs),
                                    Text(
                                      "ID: ${agent["id"]}",
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
                            
                            // Agent Details
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
                                              "Team",
                                              style: TextStyle(
                                                fontSize: 12,
                                                color: disabledBoldColor,
                                              ),
                                            ),
                                            Text(
                                              "${agent["team"]}",
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
                                              "Manager",
                                              style: TextStyle(
                                                fontSize: 12,
                                                color: disabledBoldColor,
                                              ),
                                            ),
                                            Text(
                                              "${agent["manager"]}",
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
                                              "Experience",
                                              style: TextStyle(
                                                fontSize: 12,
                                                color: disabledBoldColor,
                                              ),
                                            ),
                                            Text(
                                              "${agent["experience"]}",
                                              style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600,
                                                color: primaryColor,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  
                                  if (isSalesAgent) ...[
                                    SizedBox(height: spSm),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "Deals Completed",
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  color: disabledBoldColor,
                                                ),
                                              ),
                                              Text(
                                                "${agent["dealsCompleted"]}",
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
                                                "Total Revenue",
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  color: disabledBoldColor,
                                                ),
                                              ),
                                              Text(
                                                "\$${(agent["totalRevenue"] as double).currency}",
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w600,
                                                  color: successColor,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        if ((agent["monthlyTarget"] as double) > 0)
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "Target Progress",
                                                  style: TextStyle(
                                                    fontSize: 12,
                                                    color: disabledBoldColor,
                                                  ),
                                                ),
                                                Text(
                                                  "${(((agent["currentMonthRevenue"] as double) / (agent["monthlyTarget"] as double)) * 100).toStringAsFixed(0)}%",
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
                                  ],
                                  
                                  SizedBox(height: spSm),
                                  
                                  // Skills
                                  if ((agent["skills"] as List).isNotEmpty) ...[
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        "Skills",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: disabledBoldColor,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: spXs),
                                    Wrap(
                                      spacing: spXs,
                                      runSpacing: spXs,
                                      children: (agent["skills"] as List).map((skill) {
                                        return Container(
                                          padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                          decoration: BoxDecoration(
                                            color: infoColor.withAlpha(20),
                                            borderRadius: BorderRadius.circular(radiusXs),
                                          ),
                                          child: Text(
                                            "$skill",
                                            style: TextStyle(
                                              fontSize: 10,
                                              color: infoColor,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        );
                                      }).toList(),
                                    ),
                                  ],
                                ],
                              ),
                            ),
                            
                            // Action Buttons
                            SizedBox(height: spSm),
                            Row(
                              children: [
                                Expanded(
                                  child: QButton(
                                    label: "View Profile",
                                    size: bs.sm,
                                    onPressed: () {
                                      ss("Opening ${agent["name"]}'s profile");
                                    },
                                  ),
                                ),
                                SizedBox(width: spSm),
                                QButton(
                                  icon: Icons.phone,
                                  size: bs.sm,
                                  onPressed: () {
                                    ss("Calling ${agent["name"]}");
                                  },
                                ),
                                SizedBox(width: spXs),
                                QButton(
                                  icon: Icons.email,
                                  size: bs.sm,
                                  onPressed: () {
                                    ss("Emailing ${agent["name"]}");
                                  },
                                ),
                              ],
                            ),
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
