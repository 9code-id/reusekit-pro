import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class RhaApplicationTrackingView extends StatefulWidget {
  const RhaApplicationTrackingView({super.key});

  @override
  State<RhaApplicationTrackingView> createState() => _RhaApplicationTrackingViewState();
}

class _RhaApplicationTrackingViewState extends State<RhaApplicationTrackingView> {
  String searchQuery = "";
  String selectedTimeRange = "30_days";
  String selectedDepartment = "";
  String selectedPosition = "";
  
  List<Map<String, dynamic>> timeRangeItems = [
    {"label": "Last 7 Days", "value": "7_days"},
    {"label": "Last 30 Days", "value": "30_days"},
    {"label": "Last 3 Months", "value": "3_months"},
    {"label": "Last 6 Months", "value": "6_months"},
    {"label": "This Year", "value": "this_year"},
    {"label": "All Time", "value": "all_time"},
  ];

  List<Map<String, dynamic>> departmentItems = [
    {"label": "All Departments", "value": ""},
    {"label": "Engineering", "value": "engineering"},
    {"label": "Marketing", "value": "marketing"},
    {"label": "Sales", "value": "sales"},
    {"label": "HR", "value": "hr"},
    {"label": "Finance", "value": "finance"},
    {"label": "Operations", "value": "operations"},
  ];

  List<Map<String, dynamic>> positionItems = [
    {"label": "All Positions", "value": ""},
    {"label": "Software Engineer", "value": "software_engineer"},
    {"label": "Product Manager", "value": "product_manager"},
    {"label": "Designer", "value": "designer"},
    {"label": "Sales Rep", "value": "sales_rep"},
    {"label": "Marketing Manager", "value": "marketing_manager"},
  ];

  List<Map<String, dynamic>> applications = [
    {
      "id": "APP001",
      "candidateName": "Sarah Johnson",
      "position": "Senior Software Engineer",
      "department": "Engineering",
      "email": "sarah.johnson@email.com",
      "phone": "+1 (555) 123-4567",
      "submittedDate": "2024-01-15T10:30:00Z",
      "currentStatus": "technical_interview",
      "statusHistory": [
        {
          "status": "submitted",
          "timestamp": "2024-01-15T10:30:00Z",
          "duration": "0 days",
          "notes": "Application submitted via career portal",
          "actor": "System",
        },
        {
          "status": "initial_review",
          "timestamp": "2024-01-16T09:15:00Z",
          "duration": "1 day",
          "notes": "Resume passed initial screening criteria",
          "actor": "HR Team",
        },
        {
          "status": "phone_screening",
          "timestamp": "2024-01-18T14:00:00Z",
          "duration": "2 days",
          "notes": "Completed 30-minute phone screening, positive feedback",
          "actor": "Jessica Miller",
        },
        {
          "status": "technical_assessment",
          "timestamp": "2024-01-20T10:00:00Z",
          "duration": "2 days",
          "notes": "Coding assessment completed with 85% score",
          "actor": "System",
        },
        {
          "status": "technical_interview",
          "timestamp": "2024-01-22T11:00:00Z",
          "duration": "2 days",
          "notes": "In progress - scheduled with senior engineers",
          "actor": "John Smith",
        },
      ],
      "nextSteps": [
        "Technical Interview (In Progress)",
        "Team Culture Interview", 
        "Final Interview with Manager",
        "Background Check",
        "Offer Decision",
      ],
      "estimatedCompletion": "2024-02-05",
      "priority": "high",
      "source": "Career Portal",
      "recruiter": "Jessica Miller",
      "hiringManager": "John Smith",
    },
    {
      "id": "APP002",
      "candidateName": "Michael Chen",
      "position": "Marketing Manager",
      "department": "Marketing",
      "email": "michael.chen@email.com",
      "phone": "+1 (555) 234-5678",
      "submittedDate": "2024-01-12T16:45:00Z",
      "currentStatus": "offer_extended",
      "statusHistory": [
        {
          "status": "submitted",
          "timestamp": "2024-01-12T16:45:00Z",
          "duration": "0 days",
          "notes": "Application submitted with strong portfolio",
          "actor": "System",
        },
        {
          "status": "initial_review",
          "timestamp": "2024-01-13T10:00:00Z",
          "duration": "1 day",
          "notes": "Excellent marketing background, MBA degree",
          "actor": "HR Team",
        },
        {
          "status": "first_interview",
          "timestamp": "2024-01-16T14:30:00Z",
          "duration": "3 days",
          "notes": "Strong strategic thinking and communication skills",
          "actor": "Sarah Wilson",
        },
        {
          "status": "case_study",
          "timestamp": "2024-01-18T09:00:00Z",
          "duration": "2 days",
          "notes": "Presented comprehensive marketing strategy",
          "actor": "Marketing Team",
        },
        {
          "status": "final_interview",
          "timestamp": "2024-01-20T15:00:00Z",
          "duration": "2 days",
          "notes": "Impressed leadership team with vision",
          "actor": "David Brown",
        },
        {
          "status": "reference_check",
          "timestamp": "2024-01-22T11:30:00Z",
          "duration": "2 days",
          "notes": "All references provided positive feedback",
          "actor": "HR Team",
        },
        {
          "status": "offer_extended",
          "timestamp": "2024-01-23T17:00:00Z",
          "duration": "1 day",
          "notes": "Offer package: \$95,000 + benefits",
          "actor": "HR Team",
        },
      ],
      "nextSteps": [
        "Awaiting Candidate Response",
        "Offer Negotiation (if needed)",
        "Onboarding Preparation",
      ],
      "estimatedCompletion": "2024-01-30",
      "priority": "high",
      "source": "LinkedIn",
      "recruiter": "Sarah Wilson",
      "hiringManager": "David Brown",
    },
    {
      "id": "APP003",
      "candidateName": "Emily Rodriguez",
      "position": "UX Designer",
      "department": "Engineering",
      "email": "emily.rodriguez@email.com",
      "phone": "+1 (555) 345-6789",
      "submittedDate": "2024-01-10T11:20:00Z",
      "currentStatus": "rejected",
      "statusHistory": [
        {
          "status": "submitted",
          "timestamp": "2024-01-10T11:20:00Z",
          "duration": "0 days",
          "notes": "Portfolio submission with 3 years experience",
          "actor": "System",
        },
        {
          "status": "portfolio_review",
          "timestamp": "2024-01-12T13:45:00Z",
          "duration": "2 days",
          "notes": "Portfolio shows creativity but lacks technical depth",
          "actor": "Design Team",
        },
        {
          "status": "phone_screening",
          "timestamp": "2024-01-15T10:15:00Z",
          "duration": "3 days",
          "notes": "Good cultural fit but limited experience with required tools",
          "actor": "Lisa Chen",
        },
        {
          "status": "rejected",
          "timestamp": "2024-01-16T14:30:00Z",
          "duration": "1 day",
          "notes": "Not enough experience with React and development tools",
          "actor": "Lisa Chen",
        },
      ],
      "nextSteps": [],
      "estimatedCompletion": "2024-01-16",
      "priority": "medium",
      "source": "Job Board",
      "recruiter": "Lisa Chen",
      "hiringManager": "Tom Anderson",
    },
    {
      "id": "APP004",
      "candidateName": "Robert Kim",
      "position": "Sales Representative",
      "department": "Sales",
      "email": "robert.kim@email.com",
      "phone": "+1 (555) 456-7890",
      "submittedDate": "2024-01-20T09:30:00Z",
      "currentStatus": "initial_review",
      "statusHistory": [
        {
          "status": "submitted",
          "timestamp": "2024-01-20T09:30:00Z",
          "duration": "0 days",
          "notes": "Application with 4 years B2B sales experience",
          "actor": "System",
        },
        {
          "status": "initial_review",
          "timestamp": "2024-01-21T14:00:00Z",
          "duration": "1 day",
          "notes": "Currently under review by HR team",
          "actor": "HR Team",
        },
      ],
      "nextSteps": [
        "Complete Initial Review",
        "Phone Screening",
        "Sales Role Play Interview",
        "Final Interview",
        "Reference Check",
      ],
      "estimatedCompletion": "2024-02-10",
      "priority": "medium",
      "source": "Referral",
      "recruiter": "Mark Thompson",
      "hiringManager": "Jennifer Davis",
    },
  ];

  List<Map<String, dynamic>> get filteredApplications {
    return applications.where((app) {
      bool matchesSearch = searchQuery.isEmpty ||
          "${app["candidateName"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
          "${app["position"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
          "${app["id"]}".toLowerCase().contains(searchQuery.toLowerCase());
      
      bool matchesDepartment = selectedDepartment.isEmpty ||
          "${app["department"]}".toLowerCase() == selectedDepartment.toLowerCase();
      
      return matchesSearch && matchesDepartment;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Application Tracking"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: spMd,
          children: [
            _buildFiltersSection(),
            _buildTrackingMetrics(),
            _buildApplicationsList(),
          ],
        ),
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
            "Search & Filter Applications",
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
                  label: "Search applications",
                  value: searchQuery,
                  hint: "Enter candidate name, position, or ID",
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
                  label: "Time Range",
                  items: timeRangeItems,
                  value: selectedTimeRange,
                  onChanged: (value, label) {
                    selectedTimeRange = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
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
                  label: "Position",
                  items: positionItems,
                  value: selectedPosition,
                  onChanged: (value, label) {
                    selectedPosition = value;
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

  Widget _buildTrackingMetrics() {
    int totalApplications = applications.length;
    int inProgress = applications.where((app) => 
      !["rejected", "offer_accepted", "withdrawn"].contains("${app["currentStatus"]}")).length;
    double avgProcessingTime = 12.5; // days
    int completedThisMonth = 15;
    
    return Row(
      children: [
        _buildMetricCard("Total Tracked", "$totalApplications", Icons.track_changes, primaryColor, flex: 1),
        SizedBox(width: spSm),
        _buildMetricCard("In Progress", "$inProgress", Icons.hourglass_empty, warningColor, flex: 1),
        SizedBox(width: spSm),
        _buildMetricCard("Avg. Time", "${avgProcessingTime.toInt()} days", Icons.schedule, infoColor, flex: 1),
        SizedBox(width: spSm),
        _buildMetricCard("Completed", "$completedThisMonth", Icons.check_circle, successColor, flex: 1),
      ],
    );
  }

  Widget _buildMetricCard(String title, String value, IconData icon, Color color, {int flex = 1}) {
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
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildApplicationsList() {
    if (filteredApplications.isEmpty) {
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
              Icons.track_changes,
              size: 64,
              color: disabledColor,
            ),
            SizedBox(height: spSm),
            Text(
              "No applications to track",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.w600,
                color: disabledBoldColor,
              ),
            ),
            SizedBox(height: spXs),
            Text(
              "Applications will appear here as they progress",
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
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: spSm,
      children: [
        Text(
          "Application Tracking (${filteredApplications.length})",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        ...filteredApplications.map((application) => _buildTrackingCard(application)).toList(),
      ],
    );
  }

  Widget _buildTrackingCard(Map<String, dynamic> application) {
    List<Map<String, dynamic>> statusHistory = (application["statusHistory"] as List).cast<Map<String, dynamic>>();
    List<String> nextSteps = (application["nextSteps"] as List).cast<String>();
    Color priorityColor = _getPriorityColor("${application["priority"]}");
    
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
        border: Border(
          left: BorderSide(
            width: 4,
            color: priorityColor,
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
                      "${application["position"]} • ${application["department"]}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "ID: ${application["id"]} • Source: ${application["source"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledColor,
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                spacing: spXs,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: spSm,
                      vertical: spXs,
                    ),
                    decoration: BoxDecoration(
                      color: priorityColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Text(
                      "${application["priority"]}".toUpperCase(),
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: priorityColor,
                      ),
                    ),
                  ),
                  Text(
                    "Est. ${DateTime.parse("${application["estimatedCompletion"]}").dMMMy}",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledColor,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: infoColor.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spSm,
              children: [
                Text(
                  "Current Status: ${_formatStatusLabel("${application["currentStatus"]}")}",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: infoColor,
                  ),
                ),
                Text(
                  "Recruiter: ${application["recruiter"]} • Manager: ${application["hiringManager"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: infoColor,
                  ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: spXs,
            children: [
              Text(
                "Progress Timeline",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              ...statusHistory.asMap().entries.map((entry) {
                int index = entry.key;
                Map<String, dynamic> status = entry.value;
                bool isLast = index == statusHistory.length - 1;
                
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      children: [
                        Container(
                          width: 12,
                          height: 12,
                          decoration: BoxDecoration(
                            color: isLast ? primaryColor : successColor,
                            shape: BoxShape.circle,
                          ),
                        ),
                        if (!isLast)
                          Container(
                            width: 2,
                            height: 30,
                            color: disabledColor.withAlpha(100),
                          ),
                      ],
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: spXs,
                        children: [
                          Row(
                            children: [
                              Text(
                                _formatStatusLabel("${status["status"]}"),
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: isLast ? primaryColor : disabledBoldColor,
                                ),
                              ),
                              Spacer(),
                              Text(
                                "${status["duration"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledColor,
                                ),
                              ),
                            ],
                          ),
                          Text(
                            "${status["notes"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledColor,
                            ),
                          ),
                          Text(
                            "By: ${status["actor"]} • ${DateTime.parse("${status["timestamp"]}").dMMMy}",
                            style: TextStyle(
                              fontSize: 11,
                              color: disabledColor,
                            ),
                          ),
                          if (!isLast) SizedBox(height: spXs),
                        ],
                      ),
                    ),
                  ],
                );
              }).toList(),
            ],
          ),
          if (nextSteps.isNotEmpty)
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: warningColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spXs,
                children: [
                  Text(
                    "Next Steps",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: warningColor,
                    ),
                  ),
                  ...nextSteps.take(3).map((step) {
                    return Row(
                      children: [
                        Icon(
                          Icons.arrow_forward,
                          size: 12,
                          color: warningColor,
                        ),
                        SizedBox(width: spXs),
                        Text(
                          step,
                          style: TextStyle(
                            fontSize: 12,
                            color: warningColor,
                          ),
                        ),
                      ],
                    );
                  }).toList(),
                  if (nextSteps.length > 3)
                    Text(
                      "+${nextSteps.length - 3} more steps",
                      style: TextStyle(
                        fontSize: 12,
                        color: warningColor,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                ],
              ),
            ),
          Row(
            children: [
              QButton(
                label: "View Full Timeline",
                size: bs.sm,
                onPressed: () {
                  _showFullTimeline(application);
                },
              ),
              SizedBox(width: spSm),
              QButton(
                label: "Add Update",
                size: bs.sm,
                onPressed: () {
                  _addStatusUpdate(application);
                },
              ),
              SizedBox(width: spSm),
              QButton(
                label: "Contact",
                size: bs.sm,
                onPressed: () {
                  _contactCandidate(application);
                },
              ),
              Spacer(),
              QButton(
                icon: Icons.more_vert,
                size: bs.sm,
                onPressed: () {
                  _showMoreOptions(application);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Color _getPriorityColor(String priority) {
    switch (priority.toLowerCase()) {
      case 'high':
        return dangerColor;
      case 'medium':
        return warningColor;
      case 'low':
        return successColor;
      default:
        return disabledBoldColor;
    }
  }

  String _formatStatusLabel(String status) {
    return status.split('_').map((word) => 
      word[0].toUpperCase() + word.substring(1)
    ).join(' ');
  }

  void _showFullTimeline(Map<String, dynamic> application) {
    si("Showing full timeline for ${application["candidateName"]}");
  }

  void _addStatusUpdate(Map<String, dynamic> application) {
    si("Adding status update for ${application["candidateName"]}");
  }

  void _contactCandidate(Map<String, dynamic> application) {
    si("Contacting ${application["candidateName"]}");
  }

  void _showMoreOptions(Map<String, dynamic> application) {
    si("Showing more options for ${application["candidateName"]}");
  }
}
