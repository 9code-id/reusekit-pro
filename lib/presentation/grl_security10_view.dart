import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlSecurity10View extends StatefulWidget {
  @override
  State<GrlSecurity10View> createState() => _GrlSecurity10ViewState();
}

class _GrlSecurity10ViewState extends State<GrlSecurity10View> {
  String selectedTab = 'threats';
  
  List<Map<String, dynamic>> securityThreats = [
    {
      "title": "Suspicious Login Attempt",
      "description": "Multiple failed login attempts detected from IP 203.45.67.89",
      "severity": "high",
      "time": "5 minutes ago",
      "location": "Unknown Location",
      "status": "blocked",
      "icon": Icons.login,
      "actions": ["Block IP", "Report Threat"],
    },
    {
      "title": "Unusual Device Access",
      "description": "New device logged in from Boston, MA - different from usual locations",
      "severity": "medium",
      "time": "2 hours ago",
      "location": "Boston, MA",
      "status": "monitoring",
      "icon": Icons.devices,
      "actions": ["Verify Device", "Block Device"],
    },
    {
      "title": "Password Breach Alert",
      "description": "Your password appears in a known data breach. Consider changing it.",
      "severity": "high",
      "time": "1 day ago",
      "location": "N/A",
      "status": "unresolved",
      "icon": Icons.warning,
      "actions": ["Change Password", "Enable 2FA"],
    },
    {
      "title": "Malware Scan Warning",
      "description": "Potentially malicious link detected in recent activity",
      "severity": "medium",
      "time": "2 days ago",
      "location": "Web Browser",
      "status": "resolved",
      "icon": Icons.bug_report,
      "actions": ["Scan Device", "Review Links"],
    },
  ];

  List<Map<String, dynamic>> recommendations = [
    {
      "title": "Enable Two-Factor Authentication",
      "description": "Add an extra layer of security to your account",
      "priority": "high",
      "completed": false,
      "icon": Icons.security,
      "estimatedTime": "5 minutes",
    },
    {
      "title": "Update Password",
      "description": "Your password hasn't been changed in 6 months",
      "priority": "medium",
      "completed": false,
      "icon": Icons.key,
      "estimatedTime": "3 minutes",
    },
    {
      "title": "Review App Permissions",
      "description": "Some apps have unnecessary access to your data",
      "priority": "medium",
      "completed": true,
      "icon": Icons.app_settings_alt,
      "estimatedTime": "10 minutes",
    },
    {
      "title": "Enable Biometric Lock",
      "description": "Use fingerprint or face recognition for quick access",
      "priority": "low",
      "completed": false,
      "icon": Icons.fingerprint,
      "estimatedTime": "2 minutes",
    },
    {
      "title": "Backup Your Data",
      "description": "Create encrypted backups of important data",
      "priority": "high",
      "completed": true,
      "icon": Icons.backup,
      "estimatedTime": "15 minutes",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Security Center"),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              ss("Security scan refreshed");
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Security Score Header
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [_getOverallSecurityColor(), _getOverallSecurityColor().withAlpha(180)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              boxShadow: [shadowSm],
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.security,
                      color: Colors.white,
                      size: 32,
                    ),
                    SizedBox(width: spMd),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Security Score",
                            style: TextStyle(
                              fontSize: fsH5,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            _getSecurityStatusText(),
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.white70,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(spMd),
                      decoration: BoxDecoration(
                        color: Colors.white.withAlpha(51),
                        borderRadius: BorderRadius.circular(radiusLg),
                      ),
                      child: Text(
                        "${_calculateSecurityScore()}%",
                        style: TextStyle(
                          fontSize: fsH4,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spMd),
                Row(
                  children: [
                    Expanded(
                      child: _buildScoreItem("Threats", "${securityThreats.where((t) => t["status"] != "resolved").length}", dangerColor),
                    ),
                    SizedBox(width: spMd),
                    Expanded(
                      child: _buildScoreItem("Recommendations", "${recommendations.where((r) => !(r["completed"] as bool)).length}", warningColor),
                    ),
                    SizedBox(width: spMd),
                    Expanded(
                      child: _buildScoreItem("Protected", "${recommendations.where((r) => r["completed"] as bool).length}", successColor),
                    ),
                  ],
                ),
              ],
            ),
          ),
          
          // Tab Selector
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [shadowSm],
            ),
            child: Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      selectedTab = 'threats';
                      setState(() {});
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: spSm),
                      decoration: BoxDecoration(
                        color: selectedTab == 'threats' ? primaryColor : Colors.transparent,
                        borderRadius: BorderRadius.circular(radiusLg),
                      ),
                      child: Text(
                        "Security Threats",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: selectedTab == 'threats' ? Colors.white : disabledBoldColor,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      selectedTab = 'recommendations';
                      setState(() {});
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: spSm),
                      decoration: BoxDecoration(
                        color: selectedTab == 'recommendations' ? primaryColor : Colors.transparent,
                        borderRadius: BorderRadius.circular(radiusLg),
                      ),
                      child: Text(
                        "Recommendations",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: selectedTab == 'recommendations' ? Colors.white : disabledBoldColor,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          
          // Content
          Expanded(
            child: selectedTab == 'threats' ? _buildThreatsView() : _buildRecommendationsView(),
          ),
        ],
      ),
    );
  }

  Widget _buildScoreItem(String label, String value, Color color) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white.withAlpha(51),
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Column(
        children: [
          Text(
            value,
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: Colors.white70,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildThreatsView() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (securityThreats.any((t) => t["status"] != "resolved")) ...[
            Text(
              "Active Threats",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: dangerColor,
              ),
            ),
            SizedBox(height: spMd),
            ...securityThreats.where((t) => t["status"] != "resolved").map((threat) => _buildThreatCard(threat)).toList(),
            SizedBox(height: spMd),
          ],
          
          Text(
            "Recent Activity",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          
          SizedBox(height: spMd),
          
          ...securityThreats.map((threat) => _buildThreatCard(threat)).toList(),
        ],
      ),
    );
  }

  Widget _buildThreatCard(Map<String, dynamic> threat) {
    return Container(
      margin: EdgeInsets.only(bottom: spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
        border: Border(
          left: BorderSide(
            width: 4,
            color: _getSeverityColor(threat["severity"]),
          ),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: _getSeverityColor(threat["severity"]).withAlpha(51),
                    borderRadius: BorderRadius.circular(radiusLg),
                  ),
                  child: Icon(
                    threat["icon"] as IconData,
                    color: _getSeverityColor(threat["severity"]),
                    size: 20,
                  ),
                ),
                SizedBox(width: spMd),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${threat["title"]}",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "${threat["time"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: spSm,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: _getStatusColor(threat["status"]).withAlpha(51),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Text(
                    "${threat["status"]}".toUpperCase(),
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: _getStatusColor(threat["status"]),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: spMd),
            Text(
              "${threat["description"]}",
              style: TextStyle(
                fontSize: 14,
                color: disabledBoldColor,
              ),
            ),
            if (threat["location"] != "N/A") ...[
              SizedBox(height: spSm),
              Row(
                children: [
                  Icon(
                    Icons.location_on,
                    size: 14,
                    color: disabledBoldColor,
                  ),
                  SizedBox(width: spXs),
                  Text(
                    "${threat["location"]}",
                    style: TextStyle(
                      fontSize: 14,
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ),
            ],
            if (threat["status"] != "resolved") ...[
              SizedBox(height: spMd),
              Wrap(
                spacing: spSm,
                children: (threat["actions"] as List<String>).map((action) => QButton(
                  label: action,
                  size: bs.sm,
                  onPressed: () {
                    ss("$action executed");
                  },
                )).toList(),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildRecommendationsView() {
    List<Map<String, dynamic>> pendingRecs = recommendations.where((r) => !(r["completed"] as bool)).toList();
    List<Map<String, dynamic>> completedRecs = recommendations.where((r) => r["completed"] as bool).toList();
    
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (pendingRecs.isNotEmpty) ...[
            Text(
              "Recommended Actions",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spMd),
            ...pendingRecs.map((rec) => _buildRecommendationCard(rec)).toList(),
            SizedBox(height: spMd),
          ],
          
          if (completedRecs.isNotEmpty) ...[
            Text(
              "Completed",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: successColor,
              ),
            ),
            SizedBox(height: spMd),
            ...completedRecs.map((rec) => _buildRecommendationCard(rec)).toList(),
          ],
          
          SizedBox(height: spMd),
          
          // Quick Actions
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusLg),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Quick Security Actions",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spMd),
                Row(
                  children: [
                    Expanded(
                      child: QButton(
                        label: "Run Security Scan",
                        size: bs.sm,
                        onPressed: () async {
                          showLoading();
                          await Future.delayed(Duration(seconds: 3));
                          hideLoading();
                          ss("Security scan completed - no issues found");
                        },
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: primaryColor),
                          borderRadius: BorderRadius.circular(radiusLg),
                        ),
                        child: QButton(
                          label: "Security Report",
                          size: bs.sm,
                          onPressed: () {
                            ss("Security report downloaded");
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecommendationCard(Map<String, dynamic> rec) {
    bool completed = rec["completed"] as bool;
    
    return Container(
      margin: EdgeInsets.only(bottom: spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
        border: Border(
          left: BorderSide(
            width: 4,
            color: completed ? successColor : _getPriorityColor(rec["priority"]),
          ),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(spMd),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: (completed ? successColor : _getPriorityColor(rec["priority"])).withAlpha(51),
                borderRadius: BorderRadius.circular(radiusLg),
              ),
              child: Icon(
                completed ? Icons.check_circle : (rec["icon"] as IconData),
                color: completed ? successColor : _getPriorityColor(rec["priority"]),
                size: 20,
              ),
            ),
            SizedBox(width: spMd),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        "${rec["title"]}",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          decoration: completed ? TextDecoration.lineThrough : null,
                        ),
                      ),
                      if (!completed) ...[
                        SizedBox(width: spXs),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: spXs,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: _getPriorityColor(rec["priority"]),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            "${rec["priority"]}".toUpperCase(),
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                  SizedBox(height: spXs),
                  Text(
                    "${rec["description"]}",
                    style: TextStyle(
                      fontSize: 14,
                      color: disabledBoldColor,
                    ),
                  ),
                  if (!completed) ...[
                    SizedBox(height: spXs),
                    Text(
                      "Estimated time: ${rec["estimatedTime"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ],
                ],
              ),
            ),
            if (!completed)
              QButton(
                label: "Fix Now",
                size: bs.sm,
                onPressed: () {
                  rec["completed"] = true;
                  setState(() {});
                  ss("${rec["title"]} completed successfully");
                },
              ),
          ],
        ),
      ),
    );
  }

  Color _getSeverityColor(String severity) {
    switch (severity) {
      case 'high':
        return dangerColor;
      case 'medium':
        return warningColor;
      case 'low':
        return infoColor;
      default:
        return primaryColor;
    }
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'blocked':
        return dangerColor;
      case 'monitoring':
        return warningColor;
      case 'resolved':
        return successColor;
      case 'unresolved':
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  Color _getPriorityColor(String priority) {
    switch (priority) {
      case 'high':
        return dangerColor;
      case 'medium':
        return warningColor;
      case 'low':
        return infoColor;
      default:
        return primaryColor;
    }
  }

  Color _getOverallSecurityColor() {
    int score = _calculateSecurityScore();
    if (score >= 80) return successColor;
    if (score >= 60) return warningColor;
    return dangerColor;
  }

  String _getSecurityStatusText() {
    int score = _calculateSecurityScore();
    if (score >= 80) return "Your security is excellent";
    if (score >= 60) return "Your security needs improvement";
    return "Your security is at risk";
  }

  int _calculateSecurityScore() {
    int threats = securityThreats.where((t) => t["status"] != "resolved").length;
    int pending = recommendations.where((r) => !(r["completed"] as bool)).length;
    int completed = recommendations.where((r) => r["completed"] as bool).length;
    
    int baseScore = 100;
    baseScore -= threats * 15;
    baseScore -= pending * 10;
    baseScore += completed * 5;
    
    return baseScore.clamp(0, 100);
  }
}
