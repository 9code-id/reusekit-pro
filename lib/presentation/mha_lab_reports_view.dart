import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class MhaLabReportsView extends StatefulWidget {
  const MhaLabReportsView({super.key});

  @override
  State<MhaLabReportsView> createState() => _MhaLabReportsViewState();
}

class _MhaLabReportsViewState extends State<MhaLabReportsView> {
  int currentTab = 0;
  String searchQuery = "";
  String selectedFilter = "All";
  bool loading = false;
  
  List<Map<String, dynamic>> filterOptions = [
    {"label": "All Reports", "value": "All"},
    {"label": "Normal", "value": "Normal"},
    {"label": "Abnormal", "value": "Abnormal"},
    {"label": "Critical", "value": "Critical"},
    {"label": "Pending", "value": "Pending"},
  ];
  
  List<Map<String, dynamic>> labReports = [
    {
      "id": "LAB001",
      "testName": "Complete Blood Count (CBC)",
      "date": "2024-01-15",
      "status": "Completed",
      "result": "Normal",
      "doctorName": "Dr. Sarah Wilson",
      "labName": "City Diagnostic Center",
      "criticalValues": 0,
      "abnormalValues": 0,
      "totalTests": 12,
      "downloadUrl": "cbc_report_001.pdf",
      "parameters": [
        {"name": "Hemoglobin", "value": "14.2", "unit": "g/dL", "range": "12.0-15.5", "status": "Normal"},
        {"name": "RBC Count", "value": "4.8", "unit": "million/uL", "range": "4.5-5.9", "status": "Normal"},
        {"name": "WBC Count", "value": "7200", "unit": "/uL", "range": "4000-11000", "status": "Normal"},
        {"name": "Platelet Count", "value": "285", "unit": "thousand/uL", "range": "150-450", "status": "Normal"},
      ],
    },
    {
      "id": "LAB002",
      "testName": "Lipid Profile",
      "date": "2024-01-10",
      "status": "Completed",
      "result": "Abnormal",
      "doctorName": "Dr. Michael Chen",
      "labName": "Health Plus Laboratory",
      "criticalValues": 0,
      "abnormalValues": 2,
      "totalTests": 5,
      "downloadUrl": "lipid_report_002.pdf",
      "parameters": [
        {"name": "Total Cholesterol", "value": "245", "unit": "mg/dL", "range": "<200", "status": "High"},
        {"name": "LDL Cholesterol", "value": "165", "unit": "mg/dL", "range": "<100", "status": "High"},
        {"name": "HDL Cholesterol", "value": "45", "unit": "mg/dL", "range": ">40", "status": "Normal"},
        {"name": "Triglycerides", "value": "180", "unit": "mg/dL", "range": "<150", "status": "Normal"},
      ],
    },
    {
      "id": "LAB003",
      "testName": "Thyroid Function Test",
      "date": "2024-01-08",
      "status": "Completed",
      "result": "Critical",
      "doctorName": "Dr. Emily Rodriguez",
      "labName": "Metro Medical Lab",
      "criticalValues": 1,
      "abnormalValues": 1,
      "totalTests": 3,
      "downloadUrl": "thyroid_report_003.pdf",
      "parameters": [
        {"name": "TSH", "value": "12.5", "unit": "mIU/L", "range": "0.27-4.2", "status": "Critical"},
        {"name": "Free T4", "value": "0.8", "unit": "ng/dL", "range": "0.93-1.7", "status": "Low"},
        {"name": "Free T3", "value": "3.1", "unit": "pg/mL", "range": "2.0-4.4", "status": "Normal"},
      ],
    },
    {
      "id": "LAB004",
      "testName": "Blood Sugar Test",
      "date": "2024-01-05",
      "status": "Processing",
      "result": "Pending",
      "doctorName": "Dr. James Parker",
      "labName": "Quick Test Laboratory",
      "criticalValues": 0,
      "abnormalValues": 0,
      "totalTests": 2,
      "downloadUrl": null,
      "parameters": [],
    },
  ];
  
  List<Map<String, dynamic>> healthTrends = [
    {
      "parameter": "Hemoglobin",
      "unit": "g/dL",
      "currentValue": 14.2,
      "previousValue": 13.8,
      "trend": "up",
      "status": "Normal",
      "dates": ["Jan 15", "Dec 10", "Nov 8", "Oct 5"],
      "values": [14.2, 13.8, 13.5, 13.2],
    },
    {
      "parameter": "Total Cholesterol",
      "unit": "mg/dL",
      "currentValue": 245,
      "previousValue": 220,
      "trend": "up",
      "status": "High",
      "dates": ["Jan 10", "Oct 15", "Jul 20", "Apr 12"],
      "values": [245, 220, 210, 195],
    },
    {
      "parameter": "Blood Sugar",
      "unit": "mg/dL",
      "currentValue": 98,
      "previousValue": 105,
      "trend": "down",
      "status": "Normal",
      "dates": ["Dec 20", "Sep 18", "Jun 22", "Mar 15"],
      "values": [98, 105, 110, 115],
    },
  ];

  List<Map<String, dynamic>> get filteredReports {
    var reports = labReports;
    
    if (selectedFilter != "All") {
      reports = reports.where((report) => report["result"] == selectedFilter).toList();
    }
    
    if (searchQuery.isNotEmpty) {
      reports = reports.where((report) => 
        (report["testName"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
        (report["id"] as String).toLowerCase().contains(searchQuery.toLowerCase())
      ).toList();
    }
    
    return reports;
  }

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Lab Reports",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "All Reports", icon: Icon(Icons.description)),
        Tab(text: "Health Trends", icon: Icon(Icons.trending_up)),
        Tab(text: "Critical Alerts", icon: Icon(Icons.warning)),
      ],
      tabChildren: [
        _buildReportsTab(),
        _buildTrendsTab(),
        _buildAlertsTab(),
      ],
    );
  }

  Widget _buildReportsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Search and filter
          Row(
            children: [
              Expanded(
                child: QTextField(
                  label: "Search reports...",
                  value: searchQuery,
                  onChanged: (value) {
                    searchQuery = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              GestureDetector(
                onTap: () {
                  _showFilterDialog();
                },
                child: Container(
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    border: Border.all(color: primaryColor),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Icon(
                    Icons.filter_list,
                    color: primaryColor,
                  ),
                ),
              ),
            ],
          ),
          
          SizedBox(height: spMd),
          
          // Summary stats
          Row(
            children: [
              Expanded(child: _buildStatCard("Total Reports", "${labReports.length}", Icons.description, primaryColor)),
              SizedBox(width: spSm),
              Expanded(child: _buildStatCard("Abnormal", "${labReports.where((r) => r["result"] == "Abnormal").length}", Icons.warning, warningColor)),
              SizedBox(width: spSm),
              Expanded(child: _buildStatCard("Critical", "${labReports.where((r) => r["result"] == "Critical").length}", Icons.error, dangerColor)),
            ],
          ),
          
          SizedBox(height: spMd),
          
          // Reports list
          if (loading) ...[
            Center(
              child: Padding(
                padding: EdgeInsets.all(spLg),
                child: CircularProgressIndicator(),
              ),
            ),
          ] else if (filteredReports.isEmpty) ...[
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spLg),
              decoration: BoxDecoration(
                color: Colors.grey[50],
                borderRadius: BorderRadius.circular(radiusMd),
                border: Border.all(color: disabledOutlineBorderColor),
              ),
              child: Column(
                children: [
                  Icon(
                    Icons.description,
                    size: 48,
                    color: disabledBoldColor,
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "No Reports Found",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: disabledBoldColor,
                    ),
                  ),
                  SizedBox(height: spXs),
                  Text(
                    "No lab reports match your search criteria",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ),
            ),
          ] else ...[
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: filteredReports.length,
              itemBuilder: (context, index) {
                final report = filteredReports[index];
                return _buildReportCard(report);
              },
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: color.withAlpha(30),
        borderRadius: BorderRadius.circular(radiusMd),
        border: Border.all(color: color.withAlpha(100)),
      ),
      child: Column(
        children: [
          Icon(
            icon,
            color: color,
            size: 24,
          ),
          SizedBox(height: spSm),
          Text(
            value,
            style: TextStyle(
              fontSize: fsH5,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          Text(
            title,
            style: TextStyle(
              fontSize: 12,
              color: color,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildReportCard(Map<String, dynamic> report) {
    Color statusColor = report["result"] == "Normal" 
        ? successColor 
        : report["result"] == "Abnormal" 
            ? warningColor 
            : report["result"] == "Critical"
                ? dangerColor
                : disabledBoldColor;
    
    return Container(
      margin: EdgeInsets.only(bottom: spMd),
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        border: Border.all(color: statusColor.withAlpha(100)),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Report header
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${report["testName"]}",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "Report ID: ${report["id"]}",
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
                  color: statusColor.withAlpha(30),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Text(
                  "${report["result"]}",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: statusColor,
                  ),
                ),
              ),
            ],
          ),
          
          SizedBox(height: spSm),
          
          // Report details
          Row(
            children: [
              Icon(
                Icons.calendar_today,
                color: disabledBoldColor,
                size: 16,
              ),
              SizedBox(width: spXs),
              Text(
                "Date: ${report["date"]}",
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
              Icon(
                Icons.person,
                color: disabledBoldColor,
                size: 16,
              ),
              SizedBox(width: spXs),
              Text(
                "Ordered by: ${report["doctorName"]}",
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
              Icon(
                Icons.local_hospital,
                color: disabledBoldColor,
                size: 16,
              ),
              SizedBox(width: spXs),
              Text(
                "Lab: ${report["labName"]}",
                style: TextStyle(
                  fontSize: 14,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
          
          if (report["status"] == "Completed") ...[
            SizedBox(height: spSm),
            
            // Test summary
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.grey[50],
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        Text(
                          "${report["totalTests"]}",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "Total Tests",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Text(
                          "${report["abnormalValues"]}",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: warningColor,
                          ),
                        ),
                        Text(
                          "Abnormal",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Text(
                          "${report["criticalValues"]}",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: dangerColor,
                          ),
                        ),
                        Text(
                          "Critical",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            
            SizedBox(height: spSm),
            
            // Action buttons
            Row(
              children: [
                Expanded(
                  child: QButton(
                    label: "View Details",
                    size: bs.sm,
                    onPressed: () {
                      _showReportDetails(report);
                    },
                  ),
                ),
                if (report["downloadUrl"] != null) ...[
                  SizedBox(width: spSm),
                  GestureDetector(
                    onTap: () {
                      ss("Report downloaded successfully");
                    },
                    child: Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        border: Border.all(color: primaryColor),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Icon(
                        Icons.download,
                        color: primaryColor,
                        size: 20,
                      ),
                    ),
                  ),
                  SizedBox(width: spSm),
                  GestureDetector(
                    onTap: () {
                      //navigateTo('ShareReportView', arguments: report);
                    },
                    child: Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        border: Border.all(color: primaryColor),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Icon(
                        Icons.share,
                        color: primaryColor,
                        size: 20,
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ] else ...[
            SizedBox(height: spSm),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: warningColor.withAlpha(30),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Text(
                "Report is being processed. You will be notified once ready.",
                style: TextStyle(
                  fontSize: 14,
                  color: warningColor,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildTrendsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Health Parameter Trends",
            style: TextStyle(
              fontSize: fsH5,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          Text(
            "Track your health parameters over time",
            style: TextStyle(
              fontSize: 14,
              color: disabledBoldColor,
            ),
          ),
          
          SizedBox(height: spMd),
          
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: healthTrends.length,
            itemBuilder: (context, index) {
              final trend = healthTrends[index];
              return _buildTrendCard(trend);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildTrendCard(Map<String, dynamic> trend) {
    Color trendColor = trend["trend"] == "up" 
        ? (trend["status"] == "Normal" ? successColor : dangerColor)
        : successColor;
    
    IconData trendIcon = trend["trend"] == "up" 
        ? Icons.trending_up 
        : Icons.trending_down;
    
    return Container(
      margin: EdgeInsets.only(bottom: spMd),
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        border: Border.all(color: disabledOutlineBorderColor),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${trend["parameter"]}",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "${trend["currentValue"]} ${trend["unit"]}",
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
                  color: trendColor.withAlpha(30),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      trendIcon,
                      color: trendColor,
                      size: 16,
                    ),
                    SizedBox(width: spXs),
                    Text(
                      "${trend["status"]}",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: trendColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          
          SizedBox(height: spMd),
          
          // Mini chart representation
          Container(
            height: 60,
            child: Row(
              children: (trend["values"] as List<double>).asMap().entries.map((entry) {
                int index = entry.key;
                double value = entry.value;
                double maxValue = (trend["values"] as List<double>).reduce((a, b) => a > b ? a : b);
                double height = (value / maxValue) * 40;
                
                return Expanded(
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 2),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          height: height,
                          decoration: BoxDecoration(
                            color: index == (trend["values"] as List).length - 1 
                                ? primaryColor 
                                : primaryColor.withAlpha(100),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "${(trend["dates"] as List<String>)[index]}",
                          style: TextStyle(
                            fontSize: 10,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
          
          SizedBox(height: spMd),
          
          // Previous comparison
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.grey[50],
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Row(
              children: [
                Text(
                  "Previous: ${trend["previousValue"]} ${trend["unit"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
                Spacer(),
                Text(
                  "Change: ${((trend["currentValue"] - trend["previousValue"]) as double).toStringAsFixed(1)}",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: trendColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAlertsTab() {
    List<Map<String, dynamic>> criticalReports = labReports.where((report) => 
      report["result"] == "Critical" || report["result"] == "Abnormal"
    ).toList();
    
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Critical Health Alerts",
            style: TextStyle(
              fontSize: fsH5,
              fontWeight: FontWeight.bold,
              color: dangerColor,
            ),
          ),
          SizedBox(height: spSm),
          Text(
            "Important findings that need medical attention",
            style: TextStyle(
              fontSize: 14,
              color: disabledBoldColor,
            ),
          ),
          
          SizedBox(height: spMd),
          
          if (criticalReports.isEmpty) ...[
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spLg),
              decoration: BoxDecoration(
                color: successColor.withAlpha(30),
                borderRadius: BorderRadius.circular(radiusMd),
                border: Border.all(color: successColor.withAlpha(100)),
              ),
              child: Column(
                children: [
                  Icon(
                    Icons.check_circle,
                    size: 48,
                    color: successColor,
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "No Critical Alerts",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: successColor,
                    ),
                  ),
                  SizedBox(height: spXs),
                  Text(
                    "All your recent test results are within normal ranges",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      color: successColor,
                    ),
                  ),
                ],
              ),
            ),
          ] else ...[
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: criticalReports.length,
              itemBuilder: (context, index) {
                final report = criticalReports[index];
                return _buildAlertCard(report);
              },
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildAlertCard(Map<String, dynamic> report) {
    Color alertColor = report["result"] == "Critical" ? dangerColor : warningColor;
    
    return Container(
      margin: EdgeInsets.only(bottom: spMd),
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: alertColor.withAlpha(30),
        borderRadius: BorderRadius.circular(radiusMd),
        border: Border.all(color: alertColor),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                report["result"] == "Critical" ? Icons.error : Icons.warning,
                color: alertColor,
                size: 24,
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${report["testName"]}",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: alertColor,
                      ),
                    ),
                    Text(
                      "Date: ${report["date"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: alertColor,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: alertColor,
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Text(
                  "${report["result"]}",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          
          SizedBox(height: spMd),
          
          Text(
            "Recommended Actions:",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: alertColor,
            ),
          ),
          SizedBox(height: spSm),
          
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "• Consult with ${report["doctorName"]} immediately",
                  style: TextStyle(
                    fontSize: 14,
                    color: alertColor,
                  ),
                ),
                Text(
                  "• Follow prescribed medication if any",
                  style: TextStyle(
                    fontSize: 14,
                    color: alertColor,
                  ),
                ),
                Text(
                  "• Schedule follow-up tests as recommended",
                  style: TextStyle(
                    fontSize: 14,
                    color: alertColor,
                  ),
                ),
              ],
            ),
          ),
          
          SizedBox(height: spMd),
          
          Row(
            children: [
              Expanded(
                child: QButton(
                  label: "Book Consultation",
                  size: bs.sm,
                  onPressed: () {
                    //navigateTo('BookAppointmentView', arguments: {"doctor": report["doctorName"]});
                  },
                ),
              ),
              SizedBox(width: spSm),
              GestureDetector(
                onTap: () {
                  _showReportDetails(report);
                },
                child: Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    border: Border.all(color: alertColor),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Icon(
                    Icons.visibility,
                    color: alertColor,
                    size: 20,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _showFilterDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Filter Reports"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: filterOptions.map((option) {
              return RadioListTile<String>(
                title: Text("${option["label"]}"),
                value: option["value"],
                groupValue: selectedFilter,
                onChanged: (value) {
                  setState(() {
                    selectedFilter = value!;
                  });
                  Navigator.pop(context);
                },
              );
            }).toList(),
          ),
        );
      },
    );
  }

  void _showReportDetails(Map<String, dynamic> report) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("${report["testName"]}"),
          content: Container(
            width: double.maxFinite,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Report ID: ${report["id"]}",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
                  SizedBox(height: spSm),
                  
                  if ((report["parameters"] as List).isNotEmpty) ...[
                    Text(
                      "Test Parameters:",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spSm),
                    
                    ...(report["parameters"] as List<Map<String, dynamic>>).map((param) {
                      Color paramColor = param["status"] == "Normal" 
                          ? successColor 
                          : param["status"] == "High" || param["status"] == "Low"
                              ? warningColor
                              : dangerColor;
                      
                      return Container(
                        margin: EdgeInsets.only(bottom: spSm),
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: paramColor.withAlpha(30),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    "${param["name"]}",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: primaryColor,
                                    ),
                                  ),
                                ),
                                Text(
                                  "${param["status"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: paramColor,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: spXs),
                            Row(
                              children: [
                                Text(
                                  "Value: ${param["value"]} ${param["unit"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                Spacer(),
                                Text(
                                  "Range: ${param["range"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ],
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("Close"),
            ),
          ],
        );
      },
    );
  }
}
