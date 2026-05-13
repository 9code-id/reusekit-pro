import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class RhaApplicationManagementView extends StatefulWidget {
  const RhaApplicationManagementView({super.key});

  @override
  State<RhaApplicationManagementView> createState() => _RhaApplicationManagementViewState();
}

class _RhaApplicationManagementViewState extends State<RhaApplicationManagementView> {
  String selectedStatus = "";
  String selectedPosition = "";
  String selectedSource = "";
  String selectedTimeframe = "";
  int selectedTabIndex = 0;

  List<Map<String, dynamic>> statusOptions = [
    {"label": "All Status", "value": ""},
    {"label": "New", "value": "new"},
    {"label": "Under Review", "value": "under_review"},
    {"label": "Shortlisted", "value": "shortlisted"},
    {"label": "Interview Scheduled", "value": "interview_scheduled"},
    {"label": "Rejected", "value": "rejected"},
    {"label": "On Hold", "value": "on_hold"},
  ];

  List<Map<String, dynamic>> positions = [
    {"label": "All Positions", "value": ""},
    {"label": "Senior Software Engineer", "value": "senior_swe"},
    {"label": "Product Manager", "value": "pm"},
    {"label": "UX Designer", "value": "ux_designer"},
    {"label": "Data Scientist", "value": "data_scientist"},
    {"label": "DevOps Engineer", "value": "devops"},
  ];

  List<Map<String, dynamic>> sources = [
    {"label": "All Sources", "value": ""},
    {"label": "Company Website", "value": "website"},
    {"label": "LinkedIn", "value": "linkedin"},
    {"label": "Indeed", "value": "indeed"},
    {"label": "Referral", "value": "referral"},
    {"label": "Recruitment Agency", "value": "agency"},
  ];

  List<Map<String, dynamic>> timeframes = [
    {"label": "All Time", "value": ""},
    {"label": "Today", "value": "today"},
    {"label": "This Week", "value": "week"},
    {"label": "This Month", "value": "month"},
    {"label": "Last 3 Months", "value": "quarter"},
  ];

  List<Map<String, dynamic>> applications = [
    {
      "id": "APP001",
      "candidateName": "Sarah Johnson",
      "candidateEmail": "sarah.johnson@email.com",
      "candidatePhone": "+1 (555) 123-4567",
      "candidateAvatar": "https://picsum.photos/80/80?random=1&person",
      "position": "Senior Software Engineer",
      "appliedDate": "2024-12-18",
      "status": "new",
      "statusLabel": "New",
      "source": "website",
      "sourceLabel": "Company Website",
      "experience": "8 years",
      "location": "San Francisco, CA",
      "currentCompany": "Google",
      "expectedSalary": 150000,
      "availability": "2 weeks notice",
      "resumeUrl": "resume_sarah_johnson.pdf",
      "coverLetterUrl": "cover_letter_sarah.pdf",
      "matchScore": 95,
      "skills": ["React", "Node.js", "Python", "AWS", "Docker"],
      "education": "MS Computer Science, Stanford",
      "lastActivity": "2024-12-18T09:30:00",
    },
    {
      "id": "APP002",
      "candidateName": "Michael Chen",
      "candidateEmail": "michael.chen@email.com",
      "candidatePhone": "+1 (555) 234-5678",
      "candidateAvatar": "https://picsum.photos/80/80?random=2&person",
      "position": "Product Manager",
      "appliedDate": "2024-12-17",
      "status": "under_review",
      "statusLabel": "Under Review",
      "source": "linkedin",
      "sourceLabel": "LinkedIn",
      "experience": "6 years",
      "location": "Seattle, WA",
      "currentCompany": "Microsoft",
      "expectedSalary": 135000,
      "availability": "1 month notice",
      "resumeUrl": "resume_michael_chen.pdf",
      "coverLetterUrl": "",
      "matchScore": 88,
      "skills": ["Product Strategy", "Analytics", "Agile", "Leadership"],
      "education": "MBA, Wharton School",
      "lastActivity": "2024-12-17T14:20:00",
    },
    {
      "id": "APP003",
      "candidateName": "Emily Rodriguez",
      "candidateEmail": "emily.rodriguez@email.com",
      "candidatePhone": "+1 (555) 345-6789",
      "candidateAvatar": "https://picsum.photos/80/80?random=3&person",
      "position": "UX Designer",
      "appliedDate": "2024-12-16",
      "status": "shortlisted",
      "statusLabel": "Shortlisted",
      "source": "referral",
      "sourceLabel": "Referral",
      "experience": "7 years",
      "location": "Remote",
      "currentCompany": "Adobe",
      "expectedSalary": 120000,
      "availability": "Immediate",
      "resumeUrl": "resume_emily_rodriguez.pdf",
      "coverLetterUrl": "cover_letter_emily.pdf",
      "matchScore": 92,
      "skills": ["Figma", "Design Systems", "User Research", "Prototyping"],
      "education": "BFA Design, RISD",
      "lastActivity": "2024-12-16T11:45:00",
    },
    {
      "id": "APP004",
      "candidateName": "David Kim",
      "candidateEmail": "david.kim@email.com",
      "candidatePhone": "+1 (555) 456-7890",
      "candidateAvatar": "https://picsum.photos/80/80?random=4&person",
      "position": "Data Scientist",
      "appliedDate": "2024-12-15",
      "status": "interview_scheduled",
      "statusLabel": "Interview Scheduled",
      "source": "indeed",
      "sourceLabel": "Indeed",
      "experience": "5 years",
      "location": "Los Angeles, CA",
      "currentCompany": "Netflix",
      "expectedSalary": 140000,
      "availability": "3 weeks notice",
      "resumeUrl": "resume_david_kim.pdf",
      "coverLetterUrl": "",
      "matchScore": 90,
      "skills": ["Python", "Machine Learning", "TensorFlow", "SQL"],
      "education": "PhD Statistics, UCLA",
      "lastActivity": "2024-12-15T16:10:00",
    },
    {
      "id": "APP005",
      "candidateName": "Lisa Wang",
      "candidateEmail": "lisa.wang@email.com",
      "candidatePhone": "+1 (555) 567-8901",
      "candidateAvatar": "https://picsum.photos/80/80?random=5&person",
      "position": "DevOps Engineer",
      "appliedDate": "2024-12-14",
      "status": "on_hold",
      "statusLabel": "On Hold",
      "source": "agency",
      "sourceLabel": "Recruitment Agency",
      "experience": "9 years",
      "location": "Austin, TX",
      "currentCompany": "Atlassian",
      "expectedSalary": 145000,
      "availability": "1 month notice",
      "resumeUrl": "resume_lisa_wang.pdf",
      "coverLetterUrl": "cover_letter_lisa.pdf",
      "matchScore": 85,
      "skills": ["Kubernetes", "Docker", "AWS", "Terraform", "CI/CD"],
      "education": "BS Computer Engineering, UT Austin",
      "lastActivity": "2024-12-14T10:30:00",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Application Management",
      selectedIndex: selectedTabIndex,
      tabs: [
        Tab(text: "Dashboard", icon: Icon(Icons.dashboard)),
        Tab(text: "Applications", icon: Icon(Icons.list)),
        Tab(text: "Bulk Actions", icon: Icon(Icons.checklist)),
      ],
      tabChildren: [
        _buildDashboardTab(),
        _buildApplicationsTab(),
        _buildBulkActionsTab(),
      ],
    );
  }

  Widget _buildDashboardTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildApplicationStats(),
          _buildStatusBreakdown(),
          _buildRecentActivity(),
        ],
      ),
    );
  }

  Widget _buildApplicationStats() {
    Map<String, int> statusCounts = {};
    Map<String, int> sourceCounts = {};
    
    for (var app in applications) {
      String status = app["status"];
      String source = app["sourceLabel"];
      
      statusCounts[status] = (statusCounts[status] ?? 0) + 1;
      sourceCounts[source] = (sourceCounts[source] ?? 0) + 1;
    }

    int todayApplications = applications.where((app) => app["appliedDate"] == "2024-12-18").length;
    int weekApplications = applications.where((app) => _isThisWeek(app["appliedDate"])).length;

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
              Icon(Icons.analytics, color: primaryColor),
              SizedBox(width: spSm),
              Text(
                "Application Statistics",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 150,
            children: [
              _buildStatCard("Total Applications", applications.length, Icons.assignment, primaryColor),
              _buildStatCard("Today", todayApplications, Icons.today, successColor),
              _buildStatCard("This Week", weekApplications, Icons.date_range, infoColor),
              _buildStatCard("Shortlisted", statusCounts["shortlisted"] ?? 0, Icons.star, warningColor),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(String title, int value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: color.withAlpha(20),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: color.withAlpha(50)),
      ),
      child: Column(
        spacing: spXs,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: color, size: 20),
              Spacer(),
              Text(
                "$value",
                style: TextStyle(
                  fontSize: 20,
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
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusBreakdown() {
    Map<String, int> statusCounts = {};
    Map<String, Color> statusColors = {
      "new": infoColor,
      "under_review": warningColor,
      "shortlisted": successColor,
      "interview_scheduled": primaryColor,
      "rejected": dangerColor,
      "on_hold": disabledBoldColor,
    };

    for (var app in applications) {
      String status = app["status"];
      statusCounts[status] = (statusCounts[status] ?? 0) + 1;
    }

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
              Icon(Icons.pie_chart, color: primaryColor),
              SizedBox(width: spSm),
              Text(
                "Status Breakdown",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: statusCounts.entries.map((entry) {
              String status = entry.key;
              int count = entry.value;
              Color color = statusColors[status] ?? disabledBoldColor;
              String label = _getStatusLabel(status);
              
              return Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: color.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                  border: Border.all(color: color.withAlpha(50)),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 12,
                      height: 12,
                      decoration: BoxDecoration(
                        color: color,
                        shape: BoxShape.circle,
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: Text(
                        label,
                        style: TextStyle(
                          fontSize: 14,
                          color: primaryColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Text(
                      "$count",
                      style: TextStyle(
                        fontSize: 16,
                        color: color,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildRecentActivity() {
    List<Map<String, dynamic>> recentApps = applications.take(3).toList();

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
              Icon(Icons.history, color: primaryColor),
              SizedBox(width: spSm),
              Text(
                "Recent Applications",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Spacer(),
              GestureDetector(
                onTap: () => setState(() => selectedTabIndex = 1),
                child: Text(
                  "View All",
                  style: TextStyle(
                    fontSize: 14,
                    color: primaryColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          Column(
            spacing: spSm,
            children: recentApps.map((app) {
              return Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusSm),
                  border: Border.all(color: disabledOutlineBorderColor),
                ),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 20,
                      backgroundImage: NetworkImage("${app["candidateAvatar"]}"),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${app["candidateName"]}",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          Text(
                            "${app["position"]}",
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
                        color: _getStatusColor(app["status"]).withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Text(
                        "${app["statusLabel"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: _getStatusColor(app["status"]),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    SizedBox(width: spSm),
                    QButton(
                      icon: Icons.arrow_forward,
                      size: bs.sm,
                      onPressed: () => _viewApplication(app),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildApplicationsTab() {
    List<Map<String, dynamic>> filteredApplications = applications.where((app) {
      bool matchesStatus = selectedStatus.isEmpty || app["status"] == selectedStatus;
      bool matchesPosition = selectedPosition.isEmpty || app["position"].toString().toLowerCase().contains(selectedPosition.toLowerCase());
      bool matchesSource = selectedSource.isEmpty || app["source"] == selectedSource;
      return matchesStatus && matchesPosition && matchesSource;
    }).toList();

    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildApplicationFilters(),
          _buildApplicationsList(filteredApplications),
        ],
      ),
    );
  }

  Widget _buildApplicationFilters() {
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
              Icon(Icons.filter_list, color: primaryColor),
              SizedBox(width: spSm),
              Text(
                "Filter Applications",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Spacer(),
              GestureDetector(
                onTap: () => _clearFilters(),
                child: Text(
                  "Clear All",
                  style: TextStyle(
                    fontSize: 14,
                    color: dangerColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
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
                label: "Position",
                items: positions,
                value: selectedPosition,
                onChanged: (value, label) {
                  selectedPosition = value;
                  setState(() {});
                },
              ),
              QDropdownField(
                label: "Source",
                items: sources,
                value: selectedSource,
                onChanged: (value, label) {
                  selectedSource = value;
                  setState(() {});
                },
              ),
              QDropdownField(
                label: "Timeframe",
                items: timeframes,
                value: selectedTimeframe,
                onChanged: (value, label) {
                  selectedTimeframe = value;
                  setState(() {});
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildApplicationsList(List<Map<String, dynamic>> applications) {
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
              Icon(Icons.list, color: primaryColor),
              SizedBox(width: spSm),
              Text(
                "Applications",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Spacer(),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: primaryColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Text(
                  "${applications.length} applications",
                  style: TextStyle(
                    fontSize: 12,
                    color: primaryColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          Column(
            spacing: spSm,
            children: applications.map((app) {
              return Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusSm),
                  border: Border.all(color: disabledOutlineBorderColor),
                ),
                child: Column(
                  spacing: spSm,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 25,
                          backgroundImage: NetworkImage("${app["candidateAvatar"]}"),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${app["candidateName"]}",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                              Text(
                                "${app["position"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                          decoration: BoxDecoration(
                            color: _getStatusColor(app["status"]).withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Text(
                            "${app["statusLabel"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: _getStatusColor(app["status"]),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        SizedBox(width: spSm),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                          decoration: BoxDecoration(
                            color: successColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Text(
                            "${app["matchScore"]}%",
                            style: TextStyle(
                              fontSize: 12,
                              color: successColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(Icons.email, size: 16, color: disabledBoldColor),
                        SizedBox(width: spXs),
                        Text(
                          "${app["candidateEmail"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                        SizedBox(width: spSm),
                        Icon(Icons.phone, size: 16, color: disabledBoldColor),
                        SizedBox(width: spXs),
                        Text(
                          "${app["candidatePhone"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                    QHorizontalScroll(
                      children: (app["skills"] as List).map((skill) {
                        return Container(
                          padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                          decoration: BoxDecoration(
                            color: infoColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Text(
                            "$skill",
                            style: TextStyle(
                              fontSize: 12,
                              color: infoColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                    Row(
                      children: [
                        Text(
                          "Applied: ${app["appliedDate"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                        SizedBox(width: spSm),
                        Text(
                          "Source: ${app["sourceLabel"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                        Spacer(),
                        Text(
                          "\$${((app["expectedSalary"] as int).toDouble()).currency}",
                          style: TextStyle(
                            fontSize: 14,
                            color: primaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: QButton(
                            label: "View Details",
                            size: bs.sm,
                            onPressed: () => _viewApplication(app),
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: QButton(
                            label: "Update Status",
                            size: bs.sm,
                            onPressed: () => _updateStatus(app),
                          ),
                        ),
                        SizedBox(width: spSm),
                        QButton(
                          icon: Icons.more_vert,
                          size: bs.sm,
                          onPressed: () => _showApplicationOptions(app),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildBulkActionsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildBulkActionsSection(),
        ],
      ),
    );
  }

  Widget _buildBulkActionsSection() {
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
              Icon(Icons.checklist, color: primaryColor),
              SizedBox(width: spSm),
              Text(
                "Bulk Actions",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          Text(
            "Select multiple applications to perform bulk actions:",
            style: TextStyle(
              fontSize: 14,
              color: disabledBoldColor,
            ),
          ),
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: [
              _buildBulkActionCard("Change Status", Icons.update, "Update status for selected applications", primaryColor),
              _buildBulkActionCard("Send Email", Icons.email, "Send bulk email to candidates", successColor),
              _buildBulkActionCard("Export Data", Icons.download, "Export application data to CSV", infoColor),
              _buildBulkActionCard("Archive", Icons.archive, "Archive completed applications", warningColor),
              _buildBulkActionCard("Delete", Icons.delete, "Permanently delete applications", dangerColor),
              _buildBulkActionCard("Add Tags", Icons.tag, "Add tags to selected applications", primaryColor),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBulkActionCard(String title, IconData icon, String description, Color color) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: color.withAlpha(20),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: color.withAlpha(50)),
      ),
      child: Column(
        spacing: spSm,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: color, size: 24),
              SizedBox(width: spSm),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
                ),
              ),
            ],
          ),
          Text(
            description,
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),
          Container(
            width: double.infinity,
            child: QButton(
              label: "Select & Execute",
              size: bs.sm,
              onPressed: () => _performBulkAction(title),
            ),
          ),
        ],
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "new":
        return infoColor;
      case "under_review":
        return warningColor;
      case "shortlisted":
        return successColor;
      case "interview_scheduled":
        return primaryColor;
      case "rejected":
        return dangerColor;
      case "on_hold":
        return disabledBoldColor;
      default:
        return disabledBoldColor;
    }
  }

  String _getStatusLabel(String status) {
    switch (status) {
      case "new":
        return "New";
      case "under_review":
        return "Under Review";
      case "shortlisted":
        return "Shortlisted";
      case "interview_scheduled":
        return "Interview Scheduled";
      case "rejected":
        return "Rejected";
      case "on_hold":
        return "On Hold";
      default:
        return status;
    }
  }

  bool _isThisWeek(String dateStr) {
    DateTime date = DateTime.parse(dateStr);
    DateTime now = DateTime.now();
    DateTime startOfWeek = now.subtract(Duration(days: now.weekday - 1));
    return date.isAfter(startOfWeek);
  }

  void _clearFilters() {
    setState(() {
      selectedStatus = "";
      selectedPosition = "";
      selectedSource = "";
      selectedTimeframe = "";
    });
    ss("Filters cleared");
  }

  void _viewApplication(Map<String, dynamic> app) {
    si("View application details for ${app["candidateName"]}");
  }

  void _updateStatus(Map<String, dynamic> app) {
    si("Update status for ${app["candidateName"]}");
  }

  void _showApplicationOptions(Map<String, dynamic> app) {
    si("Show options for application ${app["id"]}");
  }

  void _performBulkAction(String action) {
    si("Perform bulk action: $action");
  }
}
