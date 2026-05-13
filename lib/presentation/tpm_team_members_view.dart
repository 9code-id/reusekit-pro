import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class TpmTeamMembersView extends StatefulWidget {
  const TpmTeamMembersView({super.key});

  @override
  State<TpmTeamMembersView> createState() => _TpmTeamMembersViewState();
}

class _TpmTeamMembersViewState extends State<TpmTeamMembersView> {
  String searchQuery = "";
  String selectedRole = "";
  String selectedSkill = "";
  String selectedAvailability = "";
  bool showAddMemberForm = false;
  
  // New member form fields
  String memberName = "";
  String memberEmail = "";
  String memberRole = "";
  String memberPhone = "";
  String memberSkills = "";
  String memberDepartment = "";
  double memberHourlyRate = 0.0;
  String memberAvailability = "";

  List<Map<String, dynamic>> teamMembers = [
    {
      "id": "1",
      "name": "Sarah Johnson",
      "email": "sarah.johnson@company.com",
      "role": "Senior Developer",
      "department": "Engineering",
      "skills": ["Flutter", "React", "Node.js", "AWS"],
      "avatar": "https://picsum.photos/100/100?random=1&keyword=woman",
      "status": "Active",
      "availability": "Available",
      "hourlyRate": 85.0,
      "phone": "+1 (555) 123-4567",
      "joinDate": "2023-01-15",
      "completedProjects": 12,
      "currentProjects": 3,
      "performance": 95,
      "location": "New York, NY",
      "timeZone": "EST",
      "workingHours": "9:00 AM - 5:00 PM"
    },
    {
      "id": "2",
      "name": "Michael Chen",
      "email": "michael.chen@company.com",
      "role": "UI/UX Designer",
      "department": "Design",
      "skills": ["Figma", "Adobe XD", "Sketch", "Prototyping"],
      "avatar": "https://picsum.photos/100/100?random=2&keyword=man",
      "status": "Active",
      "availability": "Busy",
      "hourlyRate": 75.0,
      "phone": "+1 (555) 234-5678",
      "joinDate": "2023-03-10",
      "completedProjects": 8,
      "currentProjects": 2,
      "performance": 92,
      "location": "San Francisco, CA",
      "timeZone": "PST",
      "workingHours": "10:00 AM - 6:00 PM"
    },
    {
      "id": "3",
      "name": "Emma Rodriguez",
      "email": "emma.rodriguez@company.com",
      "role": "Project Manager",
      "department": "Operations",
      "skills": ["Agile", "Scrum", "Jira", "Confluence"],
      "avatar": "https://picsum.photos/100/100?random=3&keyword=woman",
      "status": "Active",
      "availability": "Available",
      "hourlyRate": 90.0,
      "phone": "+1 (555) 345-6789",
      "joinDate": "2022-11-20",
      "completedProjects": 15,
      "currentProjects": 4,
      "performance": 98,
      "location": "Austin, TX",
      "timeZone": "CST",
      "workingHours": "8:00 AM - 4:00 PM"
    },
    {
      "id": "4",
      "name": "David Kim",
      "email": "david.kim@company.com",
      "role": "Backend Developer",
      "department": "Engineering",
      "skills": ["Python", "Django", "PostgreSQL", "Docker"],
      "avatar": "https://picsum.photos/100/100?random=4&keyword=man",
      "status": "Active",
      "availability": "On Leave",
      "hourlyRate": 80.0,
      "phone": "+1 (555) 456-7890",
      "joinDate": "2023-05-08",
      "completedProjects": 7,
      "currentProjects": 1,
      "performance": 88,
      "location": "Seattle, WA",
      "timeZone": "PST",
      "workingHours": "9:00 AM - 5:00 PM"
    },
    {
      "id": "5",
      "name": "Lisa Thompson",
      "email": "lisa.thompson@company.com",
      "role": "QA Engineer",
      "department": "Quality Assurance",
      "skills": ["Selenium", "TestRail", "Postman", "Automation"],
      "avatar": "https://picsum.photos/100/100?random=5&keyword=woman",
      "status": "Active",
      "availability": "Available",
      "hourlyRate": 70.0,
      "phone": "+1 (555) 567-8901",
      "joinDate": "2023-02-14",
      "completedProjects": 10,
      "currentProjects": 2,
      "performance": 91,
      "location": "Denver, CO",
      "timeZone": "MST",
      "workingHours": "8:30 AM - 4:30 PM"
    },
    {
      "id": "6",
      "name": "James Wilson",
      "email": "james.wilson@company.com",
      "role": "DevOps Engineer",
      "department": "Infrastructure",
      "skills": ["AWS", "Kubernetes", "Jenkins", "Terraform"],
      "avatar": "https://picsum.photos/100/100?random=6&keyword=man",
      "status": "Active",
      "availability": "Busy",
      "hourlyRate": 95.0,
      "phone": "+1 (555) 678-9012",
      "joinDate": "2022-09-30",
      "completedProjects": 18,
      "currentProjects": 5,
      "performance": 96,
      "location": "Boston, MA",
      "timeZone": "EST",
      "workingHours": "7:00 AM - 3:00 PM"
    }
  ];

  List<Map<String, dynamic>> roleOptions = [
    {"label": "All Roles", "value": ""},
    {"label": "Senior Developer", "value": "Senior Developer"},
    {"label": "UI/UX Designer", "value": "UI/UX Designer"},
    {"label": "Project Manager", "value": "Project Manager"},
    {"label": "Backend Developer", "value": "Backend Developer"},
    {"label": "QA Engineer", "value": "QA Engineer"},
    {"label": "DevOps Engineer", "value": "DevOps Engineer"},
  ];

  List<Map<String, dynamic>> skillOptions = [
    {"label": "All Skills", "value": ""},
    {"label": "Flutter", "value": "Flutter"},
    {"label": "React", "value": "React"},
    {"label": "Python", "value": "Python"},
    {"label": "AWS", "value": "AWS"},
    {"label": "Figma", "value": "Figma"},
    {"label": "Agile", "value": "Agile"},
  ];

  List<Map<String, dynamic>> availabilityOptions = [
    {"label": "All Status", "value": ""},
    {"label": "Available", "value": "Available"},
    {"label": "Busy", "value": "Busy"},
    {"label": "On Leave", "value": "On Leave"},
  ];

  List<Map<String, dynamic>> get filteredMembers {
    return teamMembers.where((member) {
      bool matchesSearch = searchQuery.isEmpty ||
          (member["name"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
          (member["email"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
          (member["role"] as String).toLowerCase().contains(searchQuery.toLowerCase());
      
      bool matchesRole = selectedRole.isEmpty || member["role"] == selectedRole;
      
      bool matchesSkill = selectedSkill.isEmpty || 
          (member["skills"] as List).any((skill) => skill.toString().contains(selectedSkill));
      
      bool matchesAvailability = selectedAvailability.isEmpty || 
          member["availability"] == selectedAvailability;
      
      return matchesSearch && matchesRole && matchesSkill && matchesAvailability;
    }).toList();
  }

  Color _getAvailabilityColor(String availability) {
    switch (availability) {
      case "Available":
        return successColor;
      case "Busy":
        return warningColor;
      case "On Leave":
        return dangerColor;
      default:
        return disabledColor;
    }
  }

  Widget _buildMemberCard(Map<String, dynamic> member) {
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(spSm),
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      width: 60,
                      height: 60,
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
                        children: [
                          Text(
                            "${member["name"]}",
                            style: TextStyle(
                              fontSize: fsH6,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "${member["role"]}",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(height: spXs),
                          Row(
                            children: [
                              Icon(
                                Icons.business,
                                size: 14,
                                color: disabledColor,
                              ),
                              SizedBox(width: spXs),
                              Text(
                                "${member["department"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledColor,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: spSm,
                        vertical: spXs,
                      ),
                      decoration: BoxDecoration(
                        color: _getAvailabilityColor(member["availability"] as String).withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Text(
                        "${member["availability"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: _getAvailabilityColor(member["availability"] as String),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spSm),
                
                // Stats Row
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: primaryColor.withAlpha(10),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Column(
                          children: [
                            Text(
                              "${member["completedProjects"]}",
                              style: TextStyle(
                                fontSize: fsH6,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              "Completed",
                              style: TextStyle(
                                fontSize: 11,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: warningColor.withAlpha(10),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Column(
                          children: [
                            Text(
                              "${member["currentProjects"]}",
                              style: TextStyle(
                                fontSize: fsH6,
                                fontWeight: FontWeight.bold,
                                color: warningColor,
                              ),
                            ),
                            Text(
                              "Active",
                              style: TextStyle(
                                fontSize: 11,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: successColor.withAlpha(10),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Column(
                          children: [
                            Text(
                              "${member["performance"]}%",
                              style: TextStyle(
                                fontSize: fsH6,
                                fontWeight: FontWeight.bold,
                                color: successColor,
                              ),
                            ),
                            Text(
                              "Performance",
                              style: TextStyle(
                                fontSize: 11,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spSm),
                
                // Skills
                if ((member["skills"] as List).isNotEmpty) ...[
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Skills:",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: disabledBoldColor,
                      ),
                    ),
                  ),
                  SizedBox(height: spXs),
                  Wrap(
                    spacing: spXs,
                    runSpacing: spXs,
                    children: (member["skills"] as List).map((skill) {
                      return Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: spSm,
                          vertical: spXs,
                        ),
                        decoration: BoxDecoration(
                          color: infoColor.withAlpha(10),
                          borderRadius: BorderRadius.circular(radiusSm),
                          border: Border.all(
                            color: infoColor.withAlpha(30),
                            width: 1,
                          ),
                        ),
                        child: Text(
                          "$skill",
                          style: TextStyle(
                            fontSize: 11,
                            color: infoColor,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                  SizedBox(height: spSm),
                ],
                
                // Contact Info Row
                Row(
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          Icon(
                            Icons.email,
                            size: 14,
                            color: disabledColor,
                          ),
                          SizedBox(width: spXs),
                          Expanded(
                            child: Text(
                              "${member["email"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spXs),
                Row(
                  children: [
                    Icon(
                      Icons.phone,
                      size: 14,
                      color: disabledColor,
                    ),
                    SizedBox(width: spXs),
                    Text(
                      "${member["phone"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Spacer(),
                    Text(
                      "\$${((member["hourlyRate"] as double)).currency}/hr",
                      style: TextStyle(
                        fontSize: 12,
                        color: successColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(5),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(radiusMd),
                bottomRight: Radius.circular(radiusMd),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () {
                    // Navigate to member detail
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.person,
                        size: 16,
                        color: primaryColor,
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "View Profile",
                        style: TextStyle(
                          fontSize: 12,
                          color: primaryColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 1,
                  height: 16,
                  color: disabledOutlineBorderColor,
                ),
                GestureDetector(
                  onTap: () {
                    // Navigate to workload
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.work,
                        size: 16,
                        color: primaryColor,
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "Workload",
                        style: TextStyle(
                          fontSize: 12,
                          color: primaryColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 1,
                  height: 16,
                  color: disabledOutlineBorderColor,
                ),
                GestureDetector(
                  onTap: () {
                    // Edit member
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.edit,
                        size: 16,
                        color: primaryColor,
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "Edit",
                        style: TextStyle(
                          fontSize: 12,
                          color: primaryColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAddMemberForm() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowMd],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.person_add,
                color: primaryColor,
                size: 24,
              ),
              SizedBox(width: spSm),
              Text(
                "Add New Team Member",
                style: TextStyle(
                  fontSize: fsH5,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Spacer(),
              GestureDetector(
                onTap: () {
                  showAddMemberForm = false;
                  setState(() {});
                },
                child: Icon(
                  Icons.close,
                  color: disabledBoldColor,
                  size: 20,
                ),
              ),
            ],
          ),
          SizedBox(height: spMd),
          
          // Personal Information
          Text(
            "Personal Information",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: disabledBoldColor,
            ),
          ),
          SizedBox(height: spSm),
          
          QTextField(
            label: "Full Name",
            value: memberName,
            hint: "Enter member's full name",
            onChanged: (value) {
              memberName = value;
              setState(() {});
            },
          ),
          SizedBox(height: spSm),
          
          QTextField(
            label: "Email Address",
            value: memberEmail,
            hint: "Enter email address",
            onChanged: (value) {
              memberEmail = value;
              setState(() {});
            },
          ),
          SizedBox(height: spSm),
          
          QTextField(
            label: "Phone Number",
            value: memberPhone,
            hint: "Enter phone number",
            onChanged: (value) {
              memberPhone = value;
              setState(() {});
            },
          ),
          SizedBox(height: spMd),
          
          // Professional Information
          Text(
            "Professional Information",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: disabledBoldColor,
            ),
          ),
          SizedBox(height: spSm),
          
          QDropdownField(
            label: "Role",
            items: [
              {"label": "Senior Developer", "value": "Senior Developer"},
              {"label": "UI/UX Designer", "value": "UI/UX Designer"},
              {"label": "Project Manager", "value": "Project Manager"},
              {"label": "Backend Developer", "value": "Backend Developer"},
              {"label": "QA Engineer", "value": "QA Engineer"},
              {"label": "DevOps Engineer", "value": "DevOps Engineer"},
            ],
            value: memberRole,
            onChanged: (value, label) {
              memberRole = value;
              setState(() {});
            },
          ),
          SizedBox(height: spSm),
          
          QTextField(
            label: "Department",
            value: memberDepartment,
            hint: "Enter department",
            onChanged: (value) {
              memberDepartment = value;
              setState(() {});
            },
          ),
          SizedBox(height: spSm),
          
          QTextField(
            label: "Skills",
            value: memberSkills,
            hint: "Enter skills separated by commas",
            onChanged: (value) {
              memberSkills = value;
              setState(() {});
            },
          ),
          SizedBox(height: spSm),
          
          QNumberField(
            label: "Hourly Rate (\$)",
            value: memberHourlyRate.toString(),
            onChanged: (value) {
              memberHourlyRate = double.tryParse("$value") ?? 0.0;
              setState(() {});
            },
          ),
          SizedBox(height: spSm),
          
          QDropdownField(
            label: "Availability Status",
            items: [
              {"label": "Available", "value": "Available"},
              {"label": "Busy", "value": "Busy"},
              {"label": "On Leave", "value": "On Leave"},
            ],
            value: memberAvailability,
            onChanged: (value, label) {
              memberAvailability = value;
              setState(() {});
            },
          ),
          SizedBox(height: spMd),
          
          Row(
            children: [
              Expanded(
                child: QButton(
                  label: "Cancel",
                  color: disabledColor,
                  size: bs.md,
                  onPressed: () {
                    showAddMemberForm = false;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QButton(
                  label: "Add Member",
                  size: bs.md,
                  onPressed: () {
                    if (memberName.isNotEmpty && memberEmail.isNotEmpty) {
                      // Add logic to save member
                      ss("Team member added successfully");
                      showAddMemberForm = false;
                      // Reset form
                      memberName = "";
                      memberEmail = "";
                      memberRole = "";
                      memberPhone = "";
                      memberSkills = "";
                      memberDepartment = "";
                      memberHourlyRate = 0.0;
                      memberAvailability = "";
                      setState(() {});
                    }
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Team Members"),
        actions: [
          IconButton(
            onPressed: () {
              showAddMemberForm = !showAddMemberForm;
              setState(() {});
            },
            icon: Icon(Icons.person_add),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Stats
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: primaryColor.withAlpha(10),
                borderRadius: BorderRadius.circular(radiusMd),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.group,
                        color: primaryColor,
                        size: 28,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "Team Overview",
                        style: TextStyle(
                          fontSize: fsH5,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spMd),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Column(
                            children: [
                              Text(
                                "${teamMembers.length}",
                                style: TextStyle(
                                  fontSize: fsH4,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                              Text(
                                "Total Members",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Column(
                            children: [
                              Text(
                                "${teamMembers.where((m) => m["availability"] == "Available").length}",
                                style: TextStyle(
                                  fontSize: fsH4,
                                  fontWeight: FontWeight.bold,
                                  color: successColor,
                                ),
                              ),
                              Text(
                                "Available",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Column(
                            children: [
                              Text(
                                "${teamMembers.where((m) => m["availability"] == "Busy").length}",
                                style: TextStyle(
                                  fontSize: fsH4,
                                  fontWeight: FontWeight.bold,
                                  color: warningColor,
                                ),
                              ),
                              Text(
                                "Busy",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: spMd),
            
            // Add Member Form
            if (showAddMemberForm) ...[
              _buildAddMemberForm(),
              SizedBox(height: spMd),
            ],
            
            // Search and Filters
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                children: [
                  QTextField(
                    label: "Search Members",
                    value: searchQuery,
                    hint: "Search by name, email, or role",
                    onChanged: (value) {
                      searchQuery = value;
                      setState(() {});
                    },
                  ),
                  SizedBox(height: spSm),
                  Row(
                    children: [
                      Expanded(
                        child: QDropdownField(
                          label: "Filter by Role",
                          items: roleOptions,
                          value: selectedRole,
                          onChanged: (value, label) {
                            selectedRole = value;
                            setState(() {});
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QDropdownField(
                          label: "Filter by Skill",
                          items: skillOptions,
                          value: selectedSkill,
                          onChanged: (value, label) {
                            selectedSkill = value;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  QDropdownField(
                    label: "Filter by Availability",
                    items: availabilityOptions,
                    value: selectedAvailability,
                    onChanged: (value, label) {
                      selectedAvailability = value;
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),
            SizedBox(height: spMd),
            
            // Results Header
            Row(
              children: [
                Text(
                  "Team Members",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Spacer(),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: spSm,
                    vertical: spXs,
                  ),
                  decoration: BoxDecoration(
                    color: primaryColor.withAlpha(10),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Text(
                    "${filteredMembers.length} members",
                    style: TextStyle(
                      fontSize: 12,
                      color: primaryColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: spSm),
            
            // Members List
            if (filteredMembers.isEmpty)
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(spLg),
                decoration: BoxDecoration(
                  color: disabledColor.withAlpha(10),
                  borderRadius: BorderRadius.circular(radiusMd),
                ),
                child: Column(
                  children: [
                    Icon(
                      Icons.search_off,
                      size: 48,
                      color: disabledColor,
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "No members found",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "Try adjusting your search criteria",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledColor,
                      ),
                    ),
                  ],
                ),
              )
            else
              ...filteredMembers.map((member) => _buildMemberCard(member)).toList(),
          ],
        ),
      ),
    );
  }
}
