import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class RhaRejectionManagementView extends StatefulWidget {
  const RhaRejectionManagementView({super.key});

  @override
  State<RhaRejectionManagementView> createState() => _RhaRejectionManagementViewState();
}

class _RhaRejectionManagementViewState extends State<RhaRejectionManagementView> {
  int currentTab = 0;
  String searchQuery = "";
  String selectedReason = "";
  String selectedDepartment = "";
  String selectedTimeframe = "30_days";
  
  List<Map<String, dynamic>> rejectionReasonItems = [
    {"label": "All Reasons", "value": ""},
    {"label": "Insufficient Experience", "value": "insufficient_experience"},
    {"label": "Skills Mismatch", "value": "skills_mismatch"},
    {"label": "Cultural Fit", "value": "cultural_fit"},
    {"label": "Salary Expectations", "value": "salary_expectations"},
    {"label": "Failed Assessment", "value": "failed_assessment"},
    {"label": "Poor Interview Performance", "value": "poor_interview"},
    {"label": "Background Check Issues", "value": "background_check"},
    {"label": "References", "value": "references"},
    {"label": "Overqualified", "value": "overqualified"},
    {"label": "Position Filled", "value": "position_filled"},
    {"label": "Other", "value": "other"},
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

  List<Map<String, dynamic>> timeframeItems = [
    {"label": "Last 7 Days", "value": "7_days"},
    {"label": "Last 30 Days", "value": "30_days"},
    {"label": "Last 3 Months", "value": "3_months"},
    {"label": "Last 6 Months", "value": "6_months"},
    {"label": "This Year", "value": "this_year"},
    {"label": "All Time", "value": "all_time"},
  ];

  List<Map<String, dynamic>> rejectedApplications = [
    {
      "id": "APP001",
      "candidateName": "Sarah Mitchell",
      "position": "Senior Software Engineer",
      "department": "Engineering",
      "email": "sarah.mitchell@email.com",
      "phone": "+1 (555) 123-4567",
      "appliedDate": "2024-01-10",
      "rejectedDate": "2024-01-18",
      "rejectionReason": "insufficient_experience",
      "rejectionStage": "Technical Interview",
      "rejectedBy": "John Smith",
      "rejectionNotes": "Candidate showed good potential but lacks 3+ years of React experience required for this senior role. Strong fundamentals but needs more hands-on experience with complex applications.",
      "feedbackProvided": true,
      "feedbackSent": "2024-01-19",
      "candidateResponse": "Thank you for the feedback. I understand the requirements better now.",
      "talentPool": true,
      "score": 65,
      "interviewStages": 3,
      "timeToReject": 8,
      "source": "LinkedIn",
      "recruiter": "Jessica Miller",
    },
    {
      "id": "APP002",
      "candidateName": "Michael Chen",
      "position": "Marketing Manager",
      "department": "Marketing",
      "email": "michael.chen@email.com",
      "phone": "+1 (555) 234-5678",
      "appliedDate": "2024-01-05",
      "rejectedDate": "2024-01-15",
      "rejectionReason": "cultural_fit",
      "rejectionStage": "Team Interview",
      "rejectedBy": "Sarah Wilson",
      "rejectionNotes": "Excellent marketing skills and experience, but communication style doesn't align with our collaborative team culture. May be better suited for more autonomous roles.",
      "feedbackProvided": true,
      "feedbackSent": "2024-01-16",
      "candidateResponse": "I appreciate the honest feedback and hope to work on my collaboration skills.",
      "talentPool": false,
      "score": 78,
      "interviewStages": 4,
      "timeToReject": 10,
      "source": "Career Portal",
      "recruiter": "Mark Thompson",
    },
    {
      "id": "APP003",
      "candidateName": "Emily Rodriguez",
      "position": "UX Designer",
      "department": "Engineering",
      "email": "emily.rodriguez@email.com",
      "phone": "+1 (555) 345-6789",
      "appliedDate": "2024-01-08",
      "rejectedDate": "2024-01-20",
      "rejectionReason": "skills_mismatch",
      "rejectionStage": "Portfolio Review",
      "rejectedBy": "Lisa Chen",
      "rejectionNotes": "Strong visual design skills but limited experience with user research and usability testing. Portfolio shows mainly visual work without UX process documentation.",
      "feedbackProvided": true,
      "feedbackSent": "2024-01-21",
      "candidateResponse": null,
      "talentPool": true,
      "score": 58,
      "interviewStages": 1,
      "timeToReject": 12,
      "source": "Dribbble",
      "recruiter": "David Brown",
    },
    {
      "id": "APP004",
      "candidateName": "Robert Kim",
      "position": "Sales Representative",
      "department": "Sales",
      "email": "robert.kim@email.com",
      "phone": "+1 (555) 456-7890",
      "appliedDate": "2024-01-12",
      "rejectedDate": "2024-01-22",
      "rejectionReason": "failed_assessment",
      "rejectionStage": "Sales Simulation",
      "rejectedBy": "Jennifer Davis",
      "rejectionNotes": "Good communication skills but struggled with objection handling and closing techniques in role-play scenarios. Needs more sales training and experience.",
      "feedbackProvided": false,
      "feedbackSent": null,
      "candidateResponse": null,
      "talentPool": false,
      "score": 42,
      "interviewStages": 2,
      "timeToReject": 10,
      "source": "Indeed",
      "recruiter": "Andrew Miller",
    },
    {
      "id": "APP005",
      "candidateName": "Lisa Park",
      "position": "Financial Analyst",
      "department": "Finance",
      "email": "lisa.park@email.com",
      "phone": "+1 (555) 567-8901",
      "appliedDate": "2024-01-15",
      "rejectedDate": "2024-01-25",
      "rejectionReason": "overqualified",
      "rejectionStage": "Final Interview",
      "rejectedBy": "Tom Anderson",
      "rejectionNotes": "Exceptional qualifications and experience, but significantly overqualified for this entry-level position. Concerns about retention and salary expectations.",
      "feedbackProvided": true,
      "feedbackSent": "2024-01-26",
      "candidateResponse": "I understand the concern. I'm willing to consider other senior positions if available.",
      "talentPool": true,
      "score": 92,
      "interviewStages": 4,
      "timeToReject": 10,
      "source": "Referral",
      "recruiter": "Jessica Miller",
    },
  ];

  List<Map<String, dynamic>> rejectionTemplates = [
    {
      "id": "TEMP001",
      "name": "Insufficient Experience",
      "subject": "Thank you for your interest in {{position}} at {{company}}",
      "body": "Dear {{candidateName}},\n\nThank you for taking the time to apply for the {{position}} role at {{company}}. We were impressed by your background and enthusiasm.\n\nAfter careful consideration, we have decided to move forward with candidates whose experience more closely aligns with our current requirements. While your skills show great promise, we are looking for someone with {{specificRequirement}}.\n\nWe encourage you to apply for future opportunities that may be a better match for your experience level.\n\nBest regards,\n{{recruiterName}}",
      "category": "experience",
      "usageCount": 45,
      "lastUsed": "2024-01-20",
    },
    {
      "id": "TEMP002",
      "name": "Skills Mismatch",
      "subject": "Update on your {{position}} application",
      "body": "Dear {{candidateName}},\n\nThank you for your interest in the {{position}} role at {{company}}.\n\nWhile we were impressed by your qualifications, we have decided to move forward with candidates whose skill set more closely matches our specific technical requirements for this position.\n\nWe will keep your information on file and may reach out for future opportunities that align better with your expertise.\n\nThank you again for your time and interest.\n\nBest regards,\n{{recruiterName}}",
      "category": "skills",
      "usageCount": 32,
      "lastUsed": "2024-01-18",
    },
    {
      "id": "TEMP003",
      "name": "Position Filled",
      "subject": "Status update for {{position}} role",
      "body": "Dear {{candidateName}},\n\nThank you for your application for the {{position}} role at {{company}}.\n\nWe want to inform you that we have filled this position with another candidate. This decision was not a reflection of your qualifications, as we received many strong applications.\n\nWe will keep your resume on file and encourage you to apply for future openings that match your skills and experience.\n\nThank you for your interest in joining our team.\n\nBest regards,\n{{recruiterName}}",
      "category": "filled",
      "usageCount": 28,
      "lastUsed": "2024-01-22",
    },
  ];

  List<Map<String, dynamic>> get filteredRejections {
    return rejectedApplications.where((app) {
      bool matchesSearch = searchQuery.isEmpty ||
          "${app["candidateName"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
          "${app["position"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
          "${app["id"]}".toLowerCase().contains(searchQuery.toLowerCase());
      
      bool matchesReason = selectedReason.isEmpty ||
          "${app["rejectionReason"]}" == selectedReason;
      
      bool matchesDepartment = selectedDepartment.isEmpty ||
          "${app["department"]}".toLowerCase() == selectedDepartment.toLowerCase();
      
      return matchesSearch && matchesReason && matchesDepartment;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Rejection Management",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Rejected Applications", icon: Icon(Icons.cancel)),
        Tab(text: "Rejection Analytics", icon: Icon(Icons.bar_chart)),
        Tab(text: "Feedback Management", icon: Icon(Icons.feedback)),
        Tab(text: "Templates", icon: Icon(Icons.email)),
      ],
      tabChildren: [
        _buildRejectedApplications(),
        _buildRejectionAnalytics(),
        _buildFeedbackManagement(),
        _buildTemplateManagement(),
      ],
    );
  }

  Widget _buildRejectedApplications() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          _buildFiltersSection(),
          _buildRejectionStats(),
          _buildRejectionsList(),
        ],
      ),
    );
  }

  Widget _buildRejectionAnalytics() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          _buildAnalyticsHeader(),
          _buildRejectionReasonChart(),
          _buildRejectionTrends(),
        ],
      ),
    );
  }

  Widget _buildFeedbackManagement() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          _buildFeedbackStats(),
          _buildPendingFeedback(),
        ],
      ),
    );
  }

  Widget _buildTemplateManagement() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          _buildTemplateHeader(),
          _buildTemplatesList(),
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
            "Filter Rejected Applications",
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
                  label: "Rejection Reason",
                  items: rejectionReasonItems,
                  value: selectedReason,
                  onChanged: (value, label) {
                    selectedReason = value;
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
                  label: "Timeframe",
                  items: timeframeItems,
                  value: selectedTimeframe,
                  onChanged: (value, label) {
                    selectedTimeframe = value;
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

  Widget _buildRejectionStats() {
    int totalRejections = rejectedApplications.length;
    int feedbackProvided = rejectedApplications.where((app) => app["feedbackProvided"] == true).length;
    int talentPoolAdded = rejectedApplications.where((app) => app["talentPool"] == true).length;
    double avgScore = rejectedApplications.fold(0.0, (sum, app) => sum + (app["score"] as num)) / totalRejections;
    
    return Row(
      children: [
        _buildStatCard("Total Rejections", "$totalRejections", Icons.cancel, dangerColor, flex: 1),
        SizedBox(width: spSm),
        _buildStatCard("Feedback Given", "$feedbackProvided", Icons.feedback, successColor, flex: 1),
        SizedBox(width: spSm),
        _buildStatCard("Talent Pool", "$talentPoolAdded", Icons.people, infoColor, flex: 1),
        SizedBox(width: spSm),
        _buildStatCard("Avg Score", "${avgScore.toInt()}", Icons.star, warningColor, flex: 1),
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

  Widget _buildRejectionsList() {
    if (filteredRejections.isEmpty) {
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
              Icons.search_off,
              size: 64,
              color: disabledColor,
            ),
            SizedBox(height: spSm),
            Text(
              "No rejected applications found",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.w600,
                color: disabledBoldColor,
              ),
            ),
            SizedBox(height: spXs),
            Text(
              "Try adjusting your filters",
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
          "Rejected Applications (${filteredRejections.length})",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        ...filteredRejections.map((application) => _buildRejectionCard(application)).toList(),
      ],
    );
  }

  Widget _buildRejectionCard(Map<String, dynamic> application) {
    bool feedbackProvided = application["feedbackProvided"] == true;
    bool inTalentPool = application["talentPool"] == true;
    
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
        border: Border(
          left: BorderSide(
            width: 4,
            color: dangerColor,
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
                      "ID: ${application["id"]} • Rejected: ${application["rejectedDate"]}",
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
                      color: dangerColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Text(
                      _formatRejectionReason("${application["rejectionReason"]}"),
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: dangerColor,
                      ),
                    ),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (feedbackProvided)
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: spXs,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: successColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Icon(
                            Icons.feedback,
                            size: 12,
                            color: successColor,
                          ),
                        ),
                      if (feedbackProvided && inTalentPool) SizedBox(width: spXs),
                      if (inTalentPool)
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: spXs,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: infoColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Icon(
                            Icons.people,
                            size: 12,
                            color: infoColor,
                          ),
                        ),
                    ],
                  ),
                ],
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
              SizedBox(width: spMd),
              Icon(
                Icons.schedule,
                size: 16,
                color: disabledBoldColor,
              ),
              SizedBox(width: spXs),
              Text(
                "Stage: ${application["rejectionStage"]}",
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
                Icons.person,
                size: 16,
                color: disabledBoldColor,
              ),
              SizedBox(width: spXs),
              Text(
                "Rejected by: ${application["rejectedBy"]}",
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
          if ("${application["rejectionNotes"]}".isNotEmpty)
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: dangerColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spXs,
                children: [
                  Text(
                    "Rejection Notes:",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: dangerColor,
                    ),
                  ),
                  Text(
                    "${application["rejectionNotes"]}",
                    style: TextStyle(
                      fontSize: 14,
                      color: dangerColor,
                    ),
                  ),
                ],
              ),
            ),
          if (application["candidateResponse"] != null && "${application["candidateResponse"]}".isNotEmpty)
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: infoColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spXs,
                children: [
                  Text(
                    "Candidate Response:",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: infoColor,
                    ),
                  ),
                  Text(
                    "${application["candidateResponse"]}",
                    style: TextStyle(
                      fontSize: 14,
                      color: infoColor,
                    ),
                  ),
                ],
              ),
            ),
          Row(
            children: [
              QButton(
                label: "View Details",
                size: bs.sm,
                onPressed: () {
                  _viewRejectionDetails(application);
                },
              ),
              SizedBox(width: spSm),
              if (!feedbackProvided)
                QButton(
                  label: "Send Feedback",
                  size: bs.sm,
                  onPressed: () {
                    _sendFeedback(application);
                  },
                )
              else
                QButton(
                  label: "View Feedback",
                  size: bs.sm,
                  onPressed: () {
                    _viewFeedback(application);
                  },
                ),
              SizedBox(width: spSm),
              if (!inTalentPool)
                QButton(
                  label: "Add to Talent Pool",
                  size: bs.sm,
                  onPressed: () {
                    _addToTalentPool(application);
                  },
                ),
              Spacer(),
              Text(
                "Time: ${application["timeToReject"]} days",
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

  Widget _buildAnalyticsHeader() {
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
            "Rejection Analytics",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Text(
            "Analyze rejection patterns and improve hiring processes",
            style: TextStyle(
              fontSize: 14,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRejectionReasonChart() {
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
            "Rejection Reasons Distribution",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Text(
            "Most common reasons for candidate rejection",
            style: TextStyle(
              fontSize: 14,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRejectionTrends() {
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
            "Rejection Trends",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Text(
            "Track rejection rates over time",
            style: TextStyle(
              fontSize: 14,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeedbackStats() {
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
            "Feedback Management",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Text(
            "Track and manage candidate feedback delivery",
            style: TextStyle(
              fontSize: 14,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPendingFeedback() {
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
            "Pending Feedback",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Text(
            "Candidates awaiting rejection feedback",
            style: TextStyle(
              fontSize: 14,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTemplateHeader() {
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
            "Rejection Email Templates",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Text(
            "Manage and customize rejection email templates",
            style: TextStyle(
              fontSize: 14,
              color: disabledBoldColor,
            ),
          ),
          Row(
            children: [
              QButton(
                label: "Create Template",
                size: bs.sm,
                onPressed: () {
                  _createTemplate();
                },
              ),
              SizedBox(width: spSm),
              QButton(
                label: "Import Templates",
                size: bs.sm,
                onPressed: () {
                  _importTemplates();
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTemplatesList() {
    return Column(
      spacing: spSm,
      children: rejectionTemplates.map((template) => _buildTemplateCard(template)).toList(),
    );
  }

  Widget _buildTemplateCard(Map<String, dynamic> template) {
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
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spXs,
                  children: [
                    Text(
                      "${template["name"]}",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "${template["subject"]}",
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
                  color: infoColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Text(
                  "${template["category"]}".toUpperCase(),
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: infoColor,
                  ),
                ),
              ),
            ],
          ),
          Text(
            "${template["body"]}".length > 150 
                ? "${template["body"]}".substring(0, 150) + "..."
                : "${template["body"]}",
            style: TextStyle(
              fontSize: 14,
              color: disabledColor,
            ),
          ),
          Row(
            children: [
              Text(
                "Used ${template["usageCount"]} times",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
              SizedBox(width: spMd),
              Text(
                "Last used: ${template["lastUsed"]}",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledColor,
                ),
              ),
              Spacer(),
              QButton(
                label: "Edit",
                size: bs.sm,
                onPressed: () {
                  _editTemplate(template);
                },
              ),
              SizedBox(width: spSm),
              QButton(
                label: "Use Template",
                size: bs.sm,
                onPressed: () {
                  _useTemplate(template);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  String _formatRejectionReason(String reason) {
    return reason.split('_').map((word) => 
      word[0].toUpperCase() + word.substring(1)
    ).join(' ');
  }

  void _viewRejectionDetails(Map<String, dynamic> application) {
    si("Viewing rejection details for ${application["candidateName"]}");
  }

  void _sendFeedback(Map<String, dynamic> application) {
    si("Sending feedback to ${application["candidateName"]}");
  }

  void _viewFeedback(Map<String, dynamic> application) {
    si("Viewing feedback for ${application["candidateName"]}");
  }

  void _addToTalentPool(Map<String, dynamic> application) {
    ss("${application["candidateName"]} added to talent pool");
    application["talentPool"] = true;
    setState(() {});
  }

  void _createTemplate() {
    si("Creating new rejection email template");
  }

  void _importTemplates() {
    si("Importing rejection email templates");
  }

  void _editTemplate(Map<String, dynamic> template) {
    si("Editing template: ${template["name"]}");
  }

  void _useTemplate(Map<String, dynamic> template) {
    si("Using template: ${template["name"]}");
  }
}
