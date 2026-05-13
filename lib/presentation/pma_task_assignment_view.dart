import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class PmaTaskAssignmentView extends StatefulWidget {
  const PmaTaskAssignmentView({super.key});

  @override
  State<PmaTaskAssignmentView> createState() => _PmaTaskAssignmentViewState();
}

class _PmaTaskAssignmentViewState extends State<PmaTaskAssignmentView> {
  String selectedProject = "all";
  String selectedDepartment = "all";
  String searchQuery = "";
  String selectedAssignmentType = "individual";

  List<Map<String, dynamic>> projects = [
    {"label": "All Projects", "value": "all"},
    {"label": "Mobile App Redesign", "value": "mobile_app"},
    {"label": "Website Development", "value": "website_dev"},
    {"label": "Marketing Campaign", "value": "marketing"},
    {"label": "Product Launch", "value": "product_launch"},
  ];

  List<Map<String, dynamic>> departments = [
    {"label": "All Departments", "value": "all"},
    {"label": "Development", "value": "development"},
    {"label": "Design", "value": "design"},
    {"label": "Marketing", "value": "marketing"},
    {"label": "QA Testing", "value": "qa"},
    {"label": "Management", "value": "management"},
  ];

  List<Map<String, dynamic>> assignmentTypes = [
    {"label": "Individual Assignment", "value": "individual"},
    {"label": "Team Assignment", "value": "team"},
    {"label": "Bulk Assignment", "value": "bulk"},
  ];

  List<Map<String, dynamic>> teamMembers = [
    {
      "id": "1",
      "name": "John Doe",
      "email": "john.doe@company.com",
      "department": "design",
      "role": "Senior UI/UX Designer",
      "avatar": "https://picsum.photos/60/60?random=1",
      "status": "available",
      "currentTasks": 5,
      "maxTasks": 8,
      "skillLevel": "senior",
      "hourlyRate": 75,
      "workload": 62,
      "skills": ["UI Design", "UX Research", "Figma", "Prototyping"],
      "experience": "5 years",
      "lastActive": "Online",
    },
    {
      "id": "2",
      "name": "Sarah Smith",
      "email": "sarah.smith@company.com",
      "department": "development",
      "role": "Frontend Developer",
      "avatar": "https://picsum.photos/60/60?random=2",
      "status": "busy",
      "currentTasks": 7,
      "maxTasks": 7,
      "skillLevel": "senior",
      "hourlyRate": 80,
      "workload": 100,
      "skills": ["React", "Vue.js", "TypeScript", "CSS"],
      "experience": "6 years",
      "lastActive": "2 hours ago",
    },
    {
      "id": "3",
      "name": "Mike Johnson",
      "email": "mike.johnson@company.com",
      "department": "development",
      "role": "Backend Developer",
      "avatar": "https://picsum.photos/60/60?random=3",
      "status": "available",
      "currentTasks": 4,
      "maxTasks": 6,
      "skillLevel": "mid",
      "hourlyRate": 65,
      "workload": 67,
      "skills": ["Node.js", "Python", "PostgreSQL", "AWS"],
      "experience": "4 years",
      "lastActive": "Online",
    },
    {
      "id": "4",
      "name": "Lisa Brown",
      "email": "lisa.brown@company.com",
      "department": "management",
      "role": "Project Manager",
      "avatar": "https://picsum.photos/60/60?random=4",
      "status": "available",
      "currentTasks": 3,
      "maxTasks": 10,
      "skillLevel": "senior",
      "hourlyRate": 90,
      "workload": 30,
      "skills": ["Agile", "Scrum", "Leadership", "Planning"],
      "experience": "8 years",
      "lastActive": "1 hour ago",
    },
    {
      "id": "5",
      "name": "David Wilson",
      "email": "david.wilson@company.com",
      "department": "qa",
      "role": "QA Engineer",
      "avatar": "https://picsum.photos/60/60?random=5",
      "status": "on_leave",
      "currentTasks": 2,
      "maxTasks": 5,
      "skillLevel": "mid",
      "hourlyRate": 55,
      "workload": 40,
      "skills": ["Manual Testing", "Automation", "Selenium", "Jest"],
      "experience": "3 years",
      "lastActive": "Yesterday",
    },
    {
      "id": "6",
      "name": "Emma Davis",
      "email": "emma.davis@company.com",
      "department": "marketing",
      "role": "Marketing Specialist",
      "avatar": "https://picsum.photos/60/60?random=6",
      "status": "available",
      "currentTasks": 6,
      "maxTasks": 8,
      "skillLevel": "mid",
      "hourlyRate": 50,
      "workload": 75,
      "skills": ["Content Writing", "SEO", "Social Media", "Analytics"],
      "experience": "3 years",
      "lastActive": "Online",
    },
  ];

  List<Map<String, dynamic>> availableTasks = [
    {
      "id": "1",
      "title": "Design User Dashboard",
      "project": "Mobile App Redesign",
      "priority": "high",
      "estimatedHours": 12,
      "requiredSkills": ["UI Design", "Figma"],
      "deadline": "2024-12-25",
    },
    {
      "id": "2",
      "title": "Implement Payment Gateway",
      "project": "Website Development",
      "priority": "critical",
      "estimatedHours": 20,
      "requiredSkills": ["Backend", "API"],
      "deadline": "2024-12-22",
    },
    {
      "id": "3",
      "title": "User Testing Session",
      "project": "Mobile App Redesign",
      "priority": "medium",
      "estimatedHours": 8,
      "requiredSkills": ["QA", "Testing"],
      "deadline": "2024-12-28",
    },
  ];

  List<String> selectedMembers = [];
  String selectedTask = "";

  List<Map<String, dynamic>> get filteredMembers {
    return teamMembers.where((member) {
      bool matchesSearch = searchQuery.isEmpty ||
          (member["name"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
          (member["email"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
          (member["role"] as String).toLowerCase().contains(searchQuery.toLowerCase());
      
      bool matchesDepartment = selectedDepartment == "all" || member["department"] == selectedDepartment;
      
      return matchesSearch && matchesDepartment;
    }).toList();
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'available':
        return successColor;
      case 'busy':
        return warningColor;
      case 'on_leave':
        return dangerColor;
      default:
        return disabledColor;
    }
  }

  String _getStatusLabel(String status) {
    switch (status) {
      case 'available':
        return 'Available';
      case 'busy':
        return 'Busy';
      case 'on_leave':
        return 'On Leave';
      default:
        return 'Unknown';
    }
  }

  Color _getWorkloadColor(int workload) {
    if (workload >= 90) return dangerColor;
    if (workload >= 70) return warningColor;
    if (workload >= 50) return infoColor;
    return successColor;
  }

  Color _getPriorityColor(String priority) {
    switch (priority) {
      case 'critical':
        return dangerColor;
      case 'high':
        return warningColor;
      case 'medium':
        return infoColor;
      case 'low':
        return successColor;
      default:
        return disabledColor;
    }
  }

  void _assignTask() async {
    if (selectedMembers.isEmpty || selectedTask.isEmpty) {
      se("Please select team members and a task to assign");
      return;
    }

    bool isConfirmed = await confirm("Are you sure you want to assign this task to ${selectedMembers.length} member(s)?");
    if (isConfirmed) {
      showLoading();
      await Future.delayed(Duration(seconds: 2));
      hideLoading();
      
      ss("Task assigned successfully to ${selectedMembers.length} team member(s)");
      
      selectedMembers.clear();
      selectedTask = "";
      setState(() {});
    }
  }

  Widget _buildMemberCard(Map<String, dynamic> member) {
    bool isSelected = selectedMembers.contains(member["id"]);
    
    return GestureDetector(
      onTap: () {
        if (selectedAssignmentType == "individual" && selectedMembers.isNotEmpty && !isSelected) {
          selectedMembers.clear();
        }
        
        if (isSelected) {
          selectedMembers.remove(member["id"]);
        } else {
          selectedMembers.add(member["id"] as String);
        }
        setState(() {});
      },
      child: Container(
        margin: EdgeInsets.only(bottom: spMd),
        padding: EdgeInsets.all(spMd),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(radiusMd),
          boxShadow: [shadowSm],
          border: Border.all(
            color: isSelected ? primaryColor : Colors.transparent,
            width: 2,
          ),
        ),
        child: Column(
          spacing: spMd,
          children: [
            Row(
              children: [
                Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(radiusLg),
                      child: Image.network(
                        "${member["avatar"]}",
                        width: 60,
                        height: 60,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Positioned(
                      right: 0,
                      top: 0,
                      child: Container(
                        width: 16,
                        height: 16,
                        decoration: BoxDecoration(
                          color: _getStatusColor(member["status"] as String),
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 2),
                        ),
                      ),
                    ),
                    if (isSelected)
                      Positioned(
                        right: 0,
                        bottom: 0,
                        child: Container(
                          width: 20,
                          height: 20,
                          decoration: BoxDecoration(
                            color: primaryColor,
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white, width: 2),
                          ),
                          child: Icon(
                            Icons.check,
                            color: Colors.white,
                            size: 12,
                          ),
                        ),
                      ),
                  ],
                ),
                SizedBox(width: spMd),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${member["name"]}",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "${member["role"]}",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),
                      Text(
                        "${member["email"]}",
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
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                      decoration: BoxDecoration(
                        color: _getStatusColor(member["status"] as String).withAlpha(30),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Text(
                        _getStatusLabel(member["status"] as String),
                        style: TextStyle(
                          color: _getStatusColor(member["status"] as String),
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "${member["lastActive"]}",
                      style: TextStyle(
                        fontSize: 11,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            
            // Workload & Tasks
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            "Workload: ",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          Text(
                            "${member["workload"]}%",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: _getWorkloadColor(member["workload"] as int),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spXs),
                      Container(
                        height: 6,
                        decoration: BoxDecoration(
                          color: disabledColor,
                          borderRadius: BorderRadius.circular(radiusLg),
                        ),
                        child: FractionallySizedBox(
                          widthFactor: (member["workload"] as int) / 100,
                          alignment: Alignment.centerLeft,
                          child: Container(
                            decoration: BoxDecoration(
                              color: _getWorkloadColor(member["workload"] as int),
                              borderRadius: BorderRadius.circular(radiusLg),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: spMd),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      "Tasks: ${member["currentTasks"]}/${member["maxTasks"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "\$${member["hourlyRate"]}/hour",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            
            // Skills
            if ((member["skills"] as List).isNotEmpty) ...[
              Align(
                alignment: Alignment.centerLeft,
                child: Wrap(
                  spacing: spXs,
                  runSpacing: spXs,
                  children: (member["skills"] as List).take(4).map((skill) => Container(
                    padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                    decoration: BoxDecoration(
                      color: primaryColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Text(
                      "$skill",
                      style: TextStyle(
                        color: primaryColor,
                        fontSize: 10,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  )).toList(),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildTaskCard(Map<String, dynamic> task) {
    bool isSelected = selectedTask == task["id"];
    
    return GestureDetector(
      onTap: () {
        selectedTask = isSelected ? "" : (task["id"] as String);
        setState(() {});
      },
      child: Container(
        margin: EdgeInsets.only(bottom: spMd),
        padding: EdgeInsets.all(spMd),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(radiusMd),
          boxShadow: [shadowSm],
          border: Border.all(
            color: isSelected ? primaryColor : Colors.transparent,
            width: 2,
          ),
        ),
        child: Column(
          spacing: spSm,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  "#${task["id"]}",
                  style: TextStyle(
                    color: disabledBoldColor,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Spacer(),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                  decoration: BoxDecoration(
                    color: _getPriorityColor(task["priority"] as String).withAlpha(30),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Text(
                    "${task["priority"]}".toUpperCase(),
                    style: TextStyle(
                      color: _getPriorityColor(task["priority"] as String),
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                if (isSelected) ...[
                  SizedBox(width: spSm),
                  Icon(
                    Icons.check_circle,
                    color: primaryColor,
                    size: 20,
                  ),
                ],
              ],
            ),
            Text(
              "${task["title"]}",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            Text(
              "${task["project"]}",
              style: TextStyle(
                fontSize: 14,
                color: disabledBoldColor,
              ),
            ),
            Row(
              children: [
                Icon(
                  Icons.schedule,
                  size: 16,
                  color: disabledBoldColor,
                ),
                SizedBox(width: spXs),
                Text(
                  "${task["estimatedHours"]} hours",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
                Spacer(),
                Text(
                  "Due: ${DateTime.parse(task["deadline"] as String).dMMMy}",
                  style: TextStyle(
                    fontSize: 12,
                    color: warningColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            if ((task["requiredSkills"] as List).isNotEmpty) ...[
              Wrap(
                spacing: spXs,
                runSpacing: spXs,
                children: (task["requiredSkills"] as List).map((skill) => Container(
                  padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                  decoration: BoxDecoration(
                    color: infoColor.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Text(
                    "$skill",
                    style: TextStyle(
                      color: infoColor,
                      fontSize: 10,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                )).toList(),
              ),
            ],
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Task Assignment"),
        actions: [
          IconButton(
            icon: Icon(Icons.analytics),
            onPressed: () {
              //navigateTo(PmaWorkloadAnalyticsView())
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Assignment Type & Filters
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                spacing: spMd,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Assignment Configuration",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  QCategoryPicker(
                    label: "Assignment Type",
                    items: assignmentTypes,
                    value: selectedAssignmentType,
                    onChanged: (index, label, value, item) {
                      selectedAssignmentType = value;
                      selectedMembers.clear();
                      setState(() {});
                    },
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: QTextField(
                          label: "Search Team Members",
                          value: searchQuery,
                          hint: "Search by name, email, or role...",
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
                        onPressed: () {
                          setState(() {});
                        },
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: QDropdownField(
                          label: "Department",
                          items: departments,
                          value: selectedDepartment,
                          onChanged: (value, label) {
                            selectedDepartment = value;
                            setState(() {});
                          },
                        ),
                      ),
                      SizedBox(width: spMd),
                      Expanded(
                        child: QDropdownField(
                          label: "Project",
                          items: projects,
                          value: selectedProject,
                          onChanged: (value, label) {
                            selectedProject = value;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Selected Members Summary
            if (selectedMembers.isNotEmpty) ...[
              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: primaryColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusMd),
                  border: Border.all(color: primaryColor.withAlpha(50)),
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
                        SizedBox(width: spSm),
                        Text(
                          "Selected Team Members (${selectedMembers.length})",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Spacer(),
                        GestureDetector(
                          onTap: () {
                            selectedMembers.clear();
                            setState(() {});
                          },
                          child: Container(
                            padding: EdgeInsets.all(spXs),
                            decoration: BoxDecoration(
                              color: dangerColor.withAlpha(30),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Icon(
                              Icons.clear,
                              color: dangerColor,
                              size: 16,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Wrap(
                      spacing: spSm,
                      runSpacing: spSm,
                      children: selectedMembers.map((memberId) {
                        final member = teamMembers.firstWhere((m) => m["id"] == memberId);
                        return Container(
                          padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(radiusSm),
                            boxShadow: [shadowSm],
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(radiusLg),
                                child: Image.network(
                                  "${member["avatar"]}",
                                  width: 20,
                                  height: 20,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              SizedBox(width: spXs),
                              Text(
                                "${member["name"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  color: primaryColor,
                                ),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
            ],

            // Available Tasks
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                spacing: spMd,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Available Tasks",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  ...availableTasks.map((task) => _buildTaskCard(task)).toList(),
                ],
              ),
            ),

            // Team Members List
            Text(
              "Team Members (${filteredMembers.length})",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            
            ...filteredMembers.map((member) => _buildMemberCard(member)).toList(),

            if (filteredMembers.isEmpty) ...[
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(spXl),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  children: [
                    Icon(
                      Icons.people_outline,
                      size: 64,
                      color: disabledColor,
                    ),
                    SizedBox(height: spMd),
                    Text(
                      "No Team Members Found",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
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
              ),
            ],

            // Assignment Button
            if (selectedMembers.isNotEmpty && selectedTask.isNotEmpty) ...[
              Container(
                width: double.infinity,
                child: QButton(
                  label: "Assign Task to ${selectedMembers.length} Member(s)",
                  size: bs.md,
                  onPressed: _assignTask,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
