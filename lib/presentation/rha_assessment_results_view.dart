import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class RhaAssessmentResultsView extends StatefulWidget {
  const RhaAssessmentResultsView({super.key});

  @override
  State<RhaAssessmentResultsView> createState() => _RhaAssessmentResultsViewState();
}

class _RhaAssessmentResultsViewState extends State<RhaAssessmentResultsView> {
  int currentTab = 0;
  String selectedPeriod = "all";
  String selectedStatus = "all";
  bool loading = false;

  List<Map<String, dynamic>> assessmentResults = [
    {
      "id": "AR001",
      "employeeName": "Sarah Johnson",
      "employeeId": "EMP001",
      "assessmentTitle": "Software Development Skills",
      "category": "Technical",
      "score": 87,
      "maxScore": 100,
      "grade": "A",
      "status": "completed",
      "completedAt": "2024-12-15 14:30:00",
      "duration": "45 minutes",
      "attempts": 1,
      "sections": [
        {"name": "Problem Solving", "score": 90, "maxScore": 100},
        {"name": "Code Quality", "score": 85, "maxScore": 100},
        {"name": "System Design", "score": 86, "maxScore": 100}
      ]
    },
    {
      "id": "AR002",
      "employeeName": "Michael Chen",
      "employeeId": "EMP002",
      "assessmentTitle": "Leadership Assessment",
      "category": "Behavioral",
      "score": 72,
      "maxScore": 100,
      "grade": "B",
      "status": "completed",
      "completedAt": "2024-12-14 16:45:00",
      "duration": "60 minutes",
      "attempts": 2,
      "sections": [
        {"name": "Team Management", "score": 75, "maxScore": 100},
        {"name": "Communication", "score": 78, "maxScore": 100},
        {"name": "Decision Making", "score": 63, "maxScore": 100}
      ]
    },
    {
      "id": "AR003",
      "employeeName": "Emily Rodriguez",
      "employeeId": "EMP003",
      "assessmentTitle": "Data Analysis Skills",
      "category": "Technical",
      "score": 94,
      "maxScore": 100,
      "grade": "A+",
      "status": "completed",
      "completedAt": "2024-12-13 11:20:00",
      "duration": "75 minutes",
      "attempts": 1,
      "sections": [
        {"name": "Statistical Analysis", "score": 96, "maxScore": 100},
        {"name": "Data Visualization", "score": 92, "maxScore": 100},
        {"name": "Report Writing", "score": 94, "maxScore": 100}
      ]
    },
    {
      "id": "AR004",
      "employeeName": "David Thompson",
      "employeeId": "EMP004",
      "assessmentTitle": "Customer Service Excellence",
      "category": "Soft Skills",
      "score": 0,
      "maxScore": 100,
      "grade": "Incomplete",
      "status": "in_progress",
      "completedAt": null,
      "duration": "Ongoing",
      "attempts": 1,
      "sections": []
    }
  ];

  List<Map<String, dynamic>> periodOptions = [
    {"label": "All Time", "value": "all"},
    {"label": "Last 7 Days", "value": "7days"},
    {"label": "Last 30 Days", "value": "30days"},
    {"label": "Last 3 Months", "value": "3months"},
    {"label": "Last 6 Months", "value": "6months"},
  ];

  List<Map<String, dynamic>> statusOptions = [
    {"label": "All Statuses", "value": "all"},
    {"label": "Completed", "value": "completed"},
    {"label": "In Progress", "value": "in_progress"},
    {"label": "Failed", "value": "failed"},
    {"label": "Expired", "value": "expired"},
  ];

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Assessment Results",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "All Results", icon: Icon(Icons.assessment)),
        Tab(text: "Analytics", icon: Icon(Icons.analytics)),
        Tab(text: "Certificates", icon: Icon(Icons.verified)),
      ],
      tabChildren: [
        _buildResultsTab(),
        _buildAnalyticsTab(),
        _buildCertificatesTab(),
      ],
    );
  }

  Widget _buildResultsTab() {
    if (loading) {
      return Center(child: CircularProgressIndicator());
    }

    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          _buildFilters(),
          _buildSummaryCards(),
          _buildResultsList(),
        ],
      ),
    );
  }

  Widget _buildFilters() {
    return Container(
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
                "Filter Results",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: QDropdownField(
                  label: "Time Period",
                  items: periodOptions,
                  value: selectedPeriod,
                  onChanged: (value, label) {
                    selectedPeriod = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QDropdownField(
                  label: "Status",
                  items: statusOptions,
                  value: selectedStatus,
                  onChanged: (value, label) {
                    selectedStatus = value;
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

  Widget _buildSummaryCards() {
    return Row(
      children: [
        Expanded(
          child: _buildSummaryCard(
            "Total Assessments",
            "127",
            Icons.quiz,
            primaryColor,
          ),
        ),
        SizedBox(width: spSm),
        Expanded(
          child: _buildSummaryCard(
            "Average Score",
            "84.2%",
            Icons.trending_up,
            successColor,
          ),
        ),
        SizedBox(width: spSm),
        Expanded(
          child: _buildSummaryCard(
            "Completion Rate",
            "92.1%",
            Icons.check_circle,
            infoColor,
          ),
        ),
      ],
    );
  }

  Widget _buildSummaryCard(String title, String value, IconData icon, Color color) {
    return Container(
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
                  color: color.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Icon(icon, color: color, size: 20),
              ),
              Spacer(),
            ],
          ),
          SizedBox(height: spSm),
          Text(
            value,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spXs),
          Text(
            title,
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildResultsList() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(spSm),
            child: Row(
              children: [
                Icon(Icons.list_alt, color: primaryColor, size: 20),
                SizedBox(width: spXs),
                Text(
                  "Recent Results",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Spacer(),
                QButton(
                  label: "Export",
                  icon: Icons.download,
                  size: bs.sm,
                  onPressed: () {},
                ),
              ],
            ),
          ),
          ...assessmentResults.map((result) => _buildResultItem(result)),
        ],
      ),
    );
  }

  Widget _buildResultItem(Map<String, dynamic> result) {
    Color statusColor = result["status"] == "completed" 
        ? successColor 
        : result["status"] == "in_progress" 
            ? warningColor 
            : dangerColor;

    return Container(
      margin: EdgeInsets.only(bottom: spXs),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        border: Border(
          left: BorderSide(color: statusColor, width: 4),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spXs,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${result["employeeName"]}",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "${result["assessmentTitle"]}",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 4),
                decoration: BoxDecoration(
                  color: statusColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Text(
                  "${result["grade"]}",
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
              Icon(Icons.category, size: 16, color: disabledBoldColor),
              SizedBox(width: spXs),
              Text(
                "${result["category"]}",
                style: TextStyle(fontSize: 12, color: disabledBoldColor),
              ),
              SizedBox(width: spSm),
              Icon(Icons.timer, size: 16, color: disabledBoldColor),
              SizedBox(width: spXs),
              Text(
                "${result["duration"]}",
                style: TextStyle(fontSize: 12, color: disabledBoldColor),
              ),
              if (result["status"] == "completed") ...[
                SizedBox(width: spSm),
                Icon(Icons.refresh, size: 16, color: disabledBoldColor),
                SizedBox(width: spXs),
                Text(
                  "Attempt ${result["attempts"]}",
                  style: TextStyle(fontSize: 12, color: disabledBoldColor),
                ),
              ],
            ],
          ),
          if (result["status"] == "completed") ...[
            Container(
              width: double.infinity,
              height: 8,
              decoration: BoxDecoration(
                color: disabledColor,
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: FractionallySizedBox(
                alignment: Alignment.centerLeft,
                widthFactor: (result["score"] as int) / (result["maxScore"] as int),
                child: Container(
                  decoration: BoxDecoration(
                    color: statusColor,
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                ),
              ),
            ),
            SizedBox(height: spXs),
            Row(
              children: [
                Text(
                  "Score: ${result["score"]}/${result["maxScore"]} (${((result["score"] as int) * 100 / (result["maxScore"] as int)).toStringAsFixed(1)}%)",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: statusColor,
                  ),
                ),
                Spacer(),
                QButton(
                  label: "View Details",
                  size: bs.sm,
                  onPressed: () {},
                ),
              ],
            ),
          ] else ...[
            Row(
              children: [
                Text(
                  "Status: ${result["status"].toString().replaceAll('_', ' ').toUpperCase()}",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: statusColor,
                  ),
                ),
                Spacer(),
                QButton(
                  label: "Continue",
                  size: bs.sm,
                  onPressed: () {},
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildAnalyticsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          _buildPerformanceChart(),
          _buildCategoryBreakdown(),
          _buildTrendAnalysis(),
        ],
      ),
    );
  }

  Widget _buildPerformanceChart() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Performance Overview",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          Container(
            height: 200,
            width: double.infinity,
            decoration: BoxDecoration(
              color: disabledColor.withAlpha(10),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Center(
              child: Text(
                "Performance Chart Placeholder\n\nShowing score trends over time",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: disabledBoldColor,
                  fontSize: 14,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryBreakdown() {
    List<Map<String, dynamic>> categories = [
      {"name": "Technical Skills", "average": 87.2, "count": 45},
      {"name": "Soft Skills", "average": 79.5, "count": 32},
      {"name": "Leadership", "average": 73.8, "count": 28},
      {"name": "Behavioral", "average": 82.1, "count": 22},
    ];

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
            "Category Performance",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          ...categories.map((category) => Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: disabledColor.withAlpha(5),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${category["name"]}",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: primaryColor,
                        ),
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "${category["count"]} assessments",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Text(
                  "${(category["average"] as double).toStringAsFixed(1)}%",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: (category["average"] as double) >= 80 ? successColor : warningColor,
                  ),
                ),
              ],
            ),
          )),
        ],
      ),
    );
  }

  Widget _buildTrendAnalysis() {
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
            "Trend Analysis",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          _buildTrendItem("Average Score", "+2.3%", "vs last month", successColor),
          _buildTrendItem("Completion Rate", "+0.8%", "vs last month", successColor),
          _buildTrendItem("First Attempt Success", "-1.2%", "vs last month", dangerColor),
          _buildTrendItem("Assessment Volume", "+15.4%", "vs last month", infoColor),
        ],
      ),
    );
  }

  Widget _buildTrendItem(String title, String change, String period, Color color) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: color.withAlpha(5),
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
                Text(
                  period,
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
          Text(
            change,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCertificatesTab() {
    List<Map<String, dynamic>> certificates = [
      {
        "id": "CERT001",
        "title": "Software Development Excellence",
        "employeeName": "Emily Rodriguez",
        "issueDate": "2024-12-13",
        "validUntil": "2025-12-13",
        "score": 94,
        "status": "active"
      },
      {
        "id": "CERT002",
        "title": "Leadership Competency",
        "employeeName": "Sarah Johnson",
        "issueDate": "2024-12-10",
        "validUntil": "2025-12-10",
        "score": 87,
        "status": "active"
      },
      {
        "id": "CERT003",
        "title": "Customer Service Mastery",
        "employeeName": "Michael Chen",
        "issueDate": "2024-11-28",
        "validUntil": "2025-11-28",
        "score": 89,
        "status": "active"
      }
    ];

    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          _buildCertificatesHeader(),
          ...certificates.map((cert) => _buildCertificateItem(cert)),
        ],
      ),
    );
  }

  Widget _buildCertificatesHeader() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Row(
        children: [
          Icon(Icons.verified, color: primaryColor, size: 24),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Assessment Certificates",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "Digital certificates for completed assessments",
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
          QButton(
            label: "Generate Batch",
            size: bs.sm,
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildCertificateItem(Map<String, dynamic> cert) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
        border: Border(
          left: BorderSide(color: successColor, width: 4),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spXs,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${cert["title"]}",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "${cert["employeeName"]}",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 4),
                decoration: BoxDecoration(
                  color: successColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Text(
                  "Score: ${cert["score"]}%",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: successColor,
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Icon(Icons.calendar_today, size: 16, color: disabledBoldColor),
              SizedBox(width: spXs),
              Text(
                "Issued: ${cert["issueDate"]}",
                style: TextStyle(fontSize: 12, color: disabledBoldColor),
              ),
              SizedBox(width: spSm),
              Icon(Icons.event, size: 16, color: disabledBoldColor),
              SizedBox(width: spXs),
              Text(
                "Valid until: ${cert["validUntil"]}",
                style: TextStyle(fontSize: 12, color: disabledBoldColor),
              ),
            ],
          ),
          Row(
            children: [
              Text(
                "Certificate ID: ${cert["id"]}",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: primaryColor,
                ),
              ),
              Spacer(),
              QButton(
                label: "Download",
                icon: Icons.download,
                size: bs.sm,
                onPressed: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }
}
