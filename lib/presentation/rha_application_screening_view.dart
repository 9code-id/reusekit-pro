import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class RhaApplicationScreeningView extends StatefulWidget {
  const RhaApplicationScreeningView({super.key});

  @override
  State<RhaApplicationScreeningView> createState() => _RhaApplicationScreeningViewState();
}

class _RhaApplicationScreeningViewState extends State<RhaApplicationScreeningView> {
  int currentTab = 0;
  String searchQuery = "";
  String selectedDepartment = "";
  String selectedSkillLevel = "";
  String selectedStatus = "pending";
  
  List<Map<String, dynamic>> departmentItems = [
    {"label": "All Departments", "value": ""},
    {"label": "Engineering", "value": "engineering"},
    {"label": "Marketing", "value": "marketing"},
    {"label": "Sales", "value": "sales"},
    {"label": "HR", "value": "hr"},
    {"label": "Finance", "value": "finance"},
  ];

  List<Map<String, dynamic>> skillLevelItems = [
    {"label": "All Levels", "value": ""},
    {"label": "Entry Level", "value": "entry"},
    {"label": "Mid Level", "value": "mid"},
    {"label": "Senior Level", "value": "senior"},
    {"label": "Expert Level", "value": "expert"},
  ];

  List<Map<String, dynamic>> applications = [
    {
      "id": "APP001",
      "candidateName": "Sarah Johnson",
      "position": "Senior Software Engineer",
      "department": "Engineering",
      "email": "sarah.johnson@email.com",
      "phone": "+1 (555) 123-4567",
      "experience": "5 years",
      "skillLevel": "senior",
      "appliedDate": "2024-01-15",
      "status": "pending",
      "score": 85,
      "resumeUrl": "https://example.com/resume1.pdf",
      "coverLetter": "I am excited to apply for this position...",
      "skills": ["Flutter", "React", "Node.js", "AWS"],
      "education": "MS Computer Science",
      "expectedSalary": 120000,
      "availability": "Immediate",
    },
    {
      "id": "APP002", 
      "candidateName": "Michael Chen",
      "position": "Marketing Manager",
      "department": "Marketing",
      "email": "michael.chen@email.com",
      "phone": "+1 (555) 234-5678",
      "experience": "7 years",
      "skillLevel": "senior",
      "appliedDate": "2024-01-14",
      "status": "screening",
      "score": 92,
      "resumeUrl": "https://example.com/resume2.pdf",
      "coverLetter": "With extensive marketing experience...",
      "skills": ["Digital Marketing", "SEO", "Analytics", "Strategy"],
      "education": "MBA Marketing",
      "expectedSalary": 95000,
      "availability": "2 weeks notice",
    },
    {
      "id": "APP003",
      "candidateName": "Emily Rodriguez",
      "position": "UX Designer", 
      "department": "Engineering",
      "email": "emily.rodriguez@email.com",
      "phone": "+1 (555) 345-6789",
      "experience": "4 years",
      "skillLevel": "mid",
      "appliedDate": "2024-01-13",
      "status": "approved",
      "score": 78,
      "resumeUrl": "https://example.com/resume3.pdf",
      "coverLetter": "As a passionate UX designer...",
      "skills": ["Figma", "Sketch", "User Research", "Prototyping"],
      "education": "BS Design",
      "expectedSalary": 85000,
      "availability": "1 month notice",
    },
  ];

  List<Map<String, dynamic>> get filteredApplications {
    return applications.where((app) {
      bool matchesSearch = searchQuery.isEmpty ||
          "${app["candidateName"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
          "${app["position"]}".toLowerCase().contains(searchQuery.toLowerCase());
      
      bool matchesDepartment = selectedDepartment.isEmpty ||
          "${app["department"]}".toLowerCase() == selectedDepartment.toLowerCase();
      
      bool matchesSkillLevel = selectedSkillLevel.isEmpty ||
          "${app["skillLevel"]}" == selectedSkillLevel;
          
      bool matchesStatus = selectedStatus.isEmpty ||
          "${app["status"]}" == selectedStatus;
      
      return matchesSearch && matchesDepartment && matchesSkillLevel && matchesStatus;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Application Screening",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Pending Review", icon: Icon(Icons.pending_actions)),
        Tab(text: "In Screening", icon: Icon(Icons.fact_check)),
        Tab(text: "Approved", icon: Icon(Icons.check_circle)),
        Tab(text: "Rejected", icon: Icon(Icons.cancel)),
      ],
      tabChildren: [
        _buildScreeningContent("pending"),
        _buildScreeningContent("screening"),
        _buildScreeningContent("approved"),
        _buildScreeningContent("rejected"),
      ],
    );
  }

  Widget _buildScreeningContent(String status) {
    selectedStatus = status;
    List<Map<String, dynamic>> statusApplications = filteredApplications;
    
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          _buildFiltersSection(),
          _buildStatisticsCards(),
          _buildApplicationsList(statusApplications),
        ],
      ),
    );
  }

  Widget _buildFiltersSection() {
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
            "Filter Applications",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Row(
            children: [
              Expanded(
                child: QTextField(
                  label: "Search candidates or positions",
                  value: searchQuery,
                  hint: "Enter candidate name or position title",
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
                  label: "Skill Level",
                  items: skillLevelItems,
                  value: selectedSkillLevel,
                  onChanged: (value, label) {
                    selectedSkillLevel = value;
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

  Widget _buildStatisticsCards() {
    int totalApplications = applications.length;
    int pendingCount = applications.where((app) => "${app["status"]}" == "pending").length;
    int screeningCount = applications.where((app) => "${app["status"]}" == "screening").length;
    int approvedCount = applications.where((app) => "${app["status"]}" == "approved").length;
    
    return Row(
      children: [
        _buildStatCard("Total Applications", "$totalApplications", Icons.description, primaryColor, flex: 1),
        SizedBox(width: spSm),
        _buildStatCard("Pending Review", "$pendingCount", Icons.pending_actions, warningColor, flex: 1),
        SizedBox(width: spSm),
        _buildStatCard("In Screening", "$screeningCount", Icons.fact_check, infoColor, flex: 1),
        SizedBox(width: spSm),
        _buildStatCard("Approved", "$approvedCount", Icons.check_circle, successColor, flex: 1),
      ],
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color color, {int flex = 1}) {
    return Expanded(
      flex: flex,
      child: Container(
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
                Spacer(),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
                ),
              ],
            ),
            Text(
              title,
              style: TextStyle(
                fontSize: 12,
                color: disabledBoldColor,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildApplicationsList(List<Map<String, dynamic>> applications) {
    if (applications.isEmpty) {
      return Container(
        padding: EdgeInsets.all(spLg),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(radiusMd),
          boxShadow: [shadowSm],
        ),
        child: Column(
          children: [
            Icon(
              Icons.inbox,
              size: 64,
              color: disabledColor,
            ),
            SizedBox(height: spSm),
            Text(
              "No applications found",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.w600,
                color: disabledBoldColor,
              ),
            ),
            SizedBox(height: spXs),
            Text(
              "Try adjusting your filters or check back later",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: disabledColor,
              ),
            ),
          ],
        ),
      );
    }

    return Column(
      spacing: spSm,
      children: applications.map((application) => _buildApplicationCard(application)).toList(),
    );
  }

  Widget _buildApplicationCard(Map<String, dynamic> application) {
    Color statusColor = _getStatusColor("${application["status"]}");
    
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
        border: Border(
          left: BorderSide(
            width: 4,
            color: statusColor,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spXs,
                  children: [
                    Text(
                      "${application["candidateName"]}",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "${application["position"]}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: disabledBoldColor,
                      ),
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
                  color: statusColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Text(
                  "${application["status"]}".toUpperCase(),
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: statusColor,
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Icon(
                Icons.email,
                size: 16,
                color: disabledBoldColor,
              ),
              SizedBox(width: spXs),
              Text(
                "${application["email"]}",
                style: TextStyle(
                  fontSize: 14,
                  color: disabledBoldColor,
                ),
              ),
              SizedBox(width: spSm),
              Icon(
                Icons.phone,
                size: 16,
                color: disabledBoldColor,
              ),
              SizedBox(width: spXs),
              Text(
                "${application["phone"]}",
                style: TextStyle(
                  fontSize: 14,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Icon(
                Icons.business,
                size: 16,
                color: disabledBoldColor,
              ),
              SizedBox(width: spXs),
              Text(
                "${application["department"]}",
                style: TextStyle(
                  fontSize: 14,
                  color: disabledBoldColor,
                ),
              ),
              SizedBox(width: spSm),
              Icon(
                Icons.work,
                size: 16,
                color: disabledBoldColor,
              ),
              SizedBox(width: spXs),
              Text(
                "${application["experience"]}",
                style: TextStyle(
                  fontSize: 14,
                  color: disabledBoldColor,
                ),
              ),
              Spacer(),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: spSm,
                  vertical: spXs,
                ),
                decoration: BoxDecoration(
                  color: primaryColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.star,
                      size: 14,
                      color: primaryColor,
                    ),
                    SizedBox(width: spXs),
                    Text(
                      "${application["score"]}/100",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          if ((application["skills"] as List).isNotEmpty)
            Wrap(
              spacing: spXs,
              runSpacing: spXs,
              children: (application["skills"] as List).take(4).map((skill) {
                return Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: spSm,
                    vertical: spXs,
                  ),
                  decoration: BoxDecoration(
                    color: infoColor.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Text(
                    "$skill",
                    style: TextStyle(
                      fontSize: 12,
                      color: infoColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                );
              }).toList(),
            ),
          Row(
            children: [
              QButton(
                label: "View Details",
                size: bs.sm,
                onPressed: () {
                  _showApplicationDetails(application);
                },
              ),
              SizedBox(width: spSm),
              if ("${application["status"]}" == "pending") ...[
                QButton(
                  label: "Start Screening",
                  size: bs.sm,
                  onPressed: () {
                    _startScreening(application);
                  },
                ),
                SizedBox(width: spSm),
                QButton(
                  label: "Quick Reject",
                  size: bs.sm,
                  onPressed: () {
                    _quickReject(application);
                  },
                ),
              ],
              if ("${application["status"]}" == "screening") ...[
                QButton(
                  label: "Approve",
                  size: bs.sm,
                  onPressed: () {
                    _approveApplication(application);
                  },
                ),
                SizedBox(width: spSm),
                QButton(
                  label: "Reject",
                  size: bs.sm,
                  onPressed: () {
                    _rejectApplication(application);
                  },
                ),
              ],
              Spacer(),
              Text(
                "Applied: ${application["appliedDate"]}",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'pending':
        return warningColor;
      case 'screening':
        return infoColor;
      case 'approved':
        return successColor;
      case 'rejected':
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  void _showApplicationDetails(Map<String, dynamic> application) {
    si("Showing application details for ${application["candidateName"]}");
  }

  void _startScreening(Map<String, dynamic> application) {
    ss("Started screening process for ${application["candidateName"]}");
    application["status"] = "screening";
    setState(() {});
  }

  void _quickReject(Map<String, dynamic> application) async {
    bool isConfirmed = await confirm("Are you sure you want to reject this application?");
    if (isConfirmed) {
      application["status"] = "rejected";
      setState(() {});
      sw("Application rejected for ${application["candidateName"]}");
    }
  }

  void _approveApplication(Map<String, dynamic> application) {
    ss("Application approved for ${application["candidateName"]}");
    application["status"] = "approved";
    setState(() {});
  }

  void _rejectApplication(Map<String, dynamic> application) async {
    bool isConfirmed = await confirm("Are you sure you want to reject this application?");
    if (isConfirmed) {
      application["status"] = "rejected";
      setState(() {});
      sw("Application rejected for ${application["candidateName"]}");
    }
  }
}
