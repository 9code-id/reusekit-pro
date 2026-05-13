import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlLog3View extends StatefulWidget {
  @override
  State<GrlLog3View> createState() => _GrlLog3ViewState();
}

class _GrlLog3ViewState extends State<GrlLog3View> {
  String searchQuery = "";
  String selectedSeverity = "All";
  String selectedCategory = "All";

  List<Map<String, dynamic>> securityLogs = [
    {
      "incidentId": "SEC-001",
      "timestamp": "2024-12-20 17:15:42",
      "severity": "High",
      "category": "Intrusion Attempt",
      "source": "Firewall",
      "sourceIP": "203.45.67.89",
      "targetIP": "192.168.1.100",
      "targetPort": 22,
      "protocol": "SSH",
      "description": "Multiple failed SSH login attempts detected",
      "details": "15 failed login attempts from IP 203.45.67.89 within 5 minutes",
      "userAgent": "OpenSSH_8.0",
      "attackType": "Brute Force",
      "riskScore": 85,
      "blocked": true,
      "actionTaken": "IP Blocked for 24 hours",
      "affectedAssets": ["Web Server 1", "Database Server"],
    },
    {
      "incidentId": "SEC-002",
      "timestamp": "2024-12-20 16:45:18",
      "severity": "Critical",
      "category": "Malware Detection",
      "source": "Antivirus",
      "sourceIP": "192.168.1.205",
      "targetIP": "192.168.1.205",
      "targetPort": null,
      "protocol": "File System",
      "description": "Ransomware detected and quarantined",
      "details": "Trojan.Win32.Ransomware.ABC found in C:\\Users\\john\\Downloads\\document.exe",
      "userAgent": "Windows Defender",
      "attackType": "Malware",
      "riskScore": 95,
      "blocked": true,
      "actionTaken": "File quarantined, system isolated",
      "affectedAssets": ["Workstation WS-205"],
    },
    {
      "incidentId": "SEC-003",
      "timestamp": "2024-12-20 16:30:55",
      "severity": "Medium",
      "category": "Suspicious Activity",
      "source": "IDS",
      "sourceIP": "192.168.1.150",
      "targetIP": "8.8.8.8",
      "targetPort": 53,
      "protocol": "DNS",
      "description": "Unusual DNS query pattern detected",
      "details": "Workstation making DNS queries to known malicious domains",
      "userAgent": "Chrome/120.0.0.0",
      "attackType": "DNS Tunneling",
      "riskScore": 65,
      "blocked": false,
      "actionTaken": "User notified, monitoring increased",
      "affectedAssets": ["Workstation WS-150"],
    },
    {
      "incidentId": "SEC-004",
      "timestamp": "2024-12-20 16:00:23",
      "severity": "Low",
      "category": "Policy Violation",
      "source": "DLP",
      "sourceIP": "192.168.1.175",
      "targetIP": "gmail.com",
      "targetPort": 443,
      "protocol": "HTTPS",
      "description": "Sensitive data transmission detected",
      "details": "Employee attempted to send document containing SSN via personal email",
      "userAgent": "Chrome/120.0.0.0",
      "attackType": "Data Exfiltration",
      "riskScore": 45,
      "blocked": true,
      "actionTaken": "Email blocked, HR notified",
      "affectedAssets": ["Workstation WS-175"],
    },
    {
      "incidentId": "SEC-005",
      "timestamp": "2024-12-20 15:30:10",
      "severity": "High",
      "category": "Unauthorized Access",
      "source": "Active Directory",
      "sourceIP": "192.168.1.88",
      "targetIP": "192.168.1.10",
      "targetPort": 389,
      "protocol": "LDAP",
      "description": "Privilege escalation attempt detected",
      "details": "User attempted to access admin resources without proper permissions",
      "userAgent": "PowerShell/7.0",
      "attackType": "Privilege Escalation",
      "riskScore": 80,
      "blocked": true,
      "actionTaken": "Account suspended, investigation initiated",
      "affectedAssets": ["Domain Controller", "File Server"],
    },
  ];

  List<Map<String, dynamic>> get filteredSecurityLogs {
    return securityLogs.where((log) {
      final matchesSearch = log["description"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
          log["incidentId"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
          log["sourceIP"].toString().contains(searchQuery) ||
          log["attackType"].toString().toLowerCase().contains(searchQuery.toLowerCase());
      final matchesSeverity = selectedSeverity == "All" || log["severity"] == selectedSeverity;
      final matchesCategory = selectedCategory == "All" || log["category"] == selectedCategory;
      return matchesSearch && matchesSeverity && matchesCategory;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Security Logs"),
        actions: [
          IconButton(
            icon: Icon(Icons.shield),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.report),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            _buildSearchAndFilters(),
            _buildSecurityStats(),
            _buildSecurityLogList(),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchAndFilters() {
    return Column(
      spacing: spSm,
      children: [
        Row(
          children: [
            Expanded(
              child: QTextField(
                label: "Search security logs",
                value: searchQuery,
                hint: "Search by incident ID, IP, attack type...",
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
              onPressed: () {},
            ),
          ],
        ),
        Row(
          children: [
            Expanded(
              child: QDropdownField(
                label: "Severity",
                items: [
                  {"label": "All", "value": "All"},
                  {"label": "Critical", "value": "Critical"},
                  {"label": "High", "value": "High"},
                  {"label": "Medium", "value": "Medium"},
                  {"label": "Low", "value": "Low"},
                ],
                value: selectedSeverity,
                onChanged: (value, label) {
                  selectedSeverity = value;
                  setState(() {});
                },
              ),
            ),
            SizedBox(width: spSm),
            Expanded(
              child: QDropdownField(
                label: "Category",
                items: [
                  {"label": "All", "value": "All"},
                  {"label": "Intrusion Attempt", "value": "Intrusion Attempt"},
                  {"label": "Malware Detection", "value": "Malware Detection"},
                  {"label": "Suspicious Activity", "value": "Suspicious Activity"},
                  {"label": "Policy Violation", "value": "Policy Violation"},
                  {"label": "Unauthorized Access", "value": "Unauthorized Access"},
                ],
                value: selectedCategory,
                onChanged: (value, label) {
                  selectedCategory = value;
                  setState(() {});
                },
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSecurityStats() {
    final criticalCount = securityLogs.where((log) => log["severity"] == "Critical").length;
    final highCount = securityLogs.where((log) => log["severity"] == "High").length;
    final blockedCount = securityLogs.where((log) => log["blocked"] == true).length;
    final averageRiskScore = securityLogs.isNotEmpty
        ? (securityLogs.fold(0.0, (sum, log) => sum + (log["riskScore"] as int)) / securityLogs.length)
        : 0.0;

    return Row(
      children: [
        Expanded(
          child: _buildStatCard(
            "Critical",
            criticalCount.toString(),
            Icons.dangerous,
            dangerColor,
          ),
        ),
        SizedBox(width: spSm),
        Expanded(
          child: _buildStatCard(
            "High Risk",
            highCount.toString(),
            Icons.warning,
            warningColor,
          ),
        ),
        SizedBox(width: spSm),
        Expanded(
          child: _buildStatCard(
            "Blocked",
            blockedCount.toString(),
            Icons.block,
            successColor,
          ),
        ),
        SizedBox(width: spSm),
        Expanded(
          child: _buildStatCard(
            "Avg Risk",
            "${averageRiskScore.toStringAsFixed(0)}%",
            Icons.analytics,
            infoColor,
          ),
        ),
      ],
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        children: [
          Icon(
            icon,
            color: color,
            size: 24,
          ),
          SizedBox(height: spXs),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 11,
              color: disabledBoldColor,
            ),
          ),
          SizedBox(height: spXs),
          Text(
            value,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSecurityLogList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Security Incidents (${filteredSecurityLogs.length})",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        SizedBox(height: spSm),
        ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: filteredSecurityLogs.length,
          itemBuilder: (context, index) {
            final log = filteredSecurityLogs[index];
            return _buildSecurityLogCard(log);
          },
        ),
      ],
    );
  }

  Widget _buildSecurityLogCard(Map<String, dynamic> log) {
    final riskScore = log["riskScore"] as int;
    final isBlocked = log["blocked"] as bool;
    final affectedAssets = log["affectedAssets"] as List;

    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
        border: Border(
          left: BorderSide(
            width: 4,
            color: _getSeverityColor(log["severity"]),
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
                  children: [
                    Text(
                      "${log["incidentId"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "${log["timestamp"]}",
                      style: TextStyle(
                        fontSize: 14,
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
                      color: _getSeverityColor(log["severity"]).withAlpha(30),
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                    child: Text(
                      "${log["severity"]}",
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                        color: _getSeverityColor(log["severity"]),
                      ),
                    ),
                  ),
                  SizedBox(height: spXs),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                    decoration: BoxDecoration(
                      color: isBlocked ? successColor.withAlpha(30) : dangerColor.withAlpha(30),
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                    child: Text(
                      isBlocked ? "Blocked" : "Allowed",
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                        color: isBlocked ? successColor : dangerColor,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: _getCategoryColor(log["category"]).withAlpha(20),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      _getCategoryIcon(log["category"]),
                      size: 16,
                      color: _getCategoryColor(log["category"]),
                    ),
                    SizedBox(width: spXs),
                    Text(
                      "${log["category"]} - ${log["attackType"]}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: _getCategoryColor(log["category"]),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spXs),
                Text(
                  "${log["description"]}",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spXs),
                Text(
                  "${log["details"]}",
                  style: TextStyle(
                    fontSize: 13,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
          Row(
            children: [
              Icon(
                Icons.router,
                size: 16,
                color: disabledBoldColor,
              ),
              SizedBox(width: spXs),
              Text(
                "Source: ${log["sourceIP"]}",
                style: TextStyle(
                  fontSize: 13,
                  color: disabledBoldColor,
                ),
              ),
              SizedBox(width: spSm),
              Icon(
                Icons.gps_fixed,
                size: 16,
                color: disabledBoldColor,
              ),
              SizedBox(width: spXs),
              Text(
                "Target: ${log["targetIP"]}",
                style: TextStyle(
                  fontSize: 13,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
          if (log["targetPort"] != null) ...[
            Row(
              children: [
                Icon(
                  Icons.network_check,
                  size: 16,
                  color: disabledBoldColor,
                ),
                SizedBox(width: spXs),
                Text(
                  "Protocol: ${log["protocol"]} | Port: ${log["targetPort"]}",
                  style: TextStyle(
                    fontSize: 13,
                    color: disabledBoldColor,
                  ),
                ),
                Spacer(),
                Icon(
                  Icons.source,
                  size: 16,
                  color: disabledBoldColor,
                ),
                SizedBox(width: spXs),
                Text(
                  "Source: ${log["source"]}",
                  style: TextStyle(
                    fontSize: 13,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ],
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: riskScore >= 80 ? dangerColor.withAlpha(20) : 
                     riskScore >= 60 ? warningColor.withAlpha(20) : 
                     successColor.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.assessment,
                  size: 16,
                  color: riskScore >= 80 ? dangerColor : 
                         riskScore >= 60 ? warningColor : 
                         successColor,
                ),
                SizedBox(width: spXs),
                Text(
                  "Risk Score: $riskScore%",
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: riskScore >= 80 ? dangerColor : 
                           riskScore >= 60 ? warningColor : 
                           successColor,
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: LinearProgressIndicator(
                    value: riskScore / 100,
                    backgroundColor: disabledColor,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      riskScore >= 80 ? dangerColor : 
                      riskScore >= 60 ? warningColor : 
                      successColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
          if (affectedAssets.isNotEmpty) ...[
            Row(
              children: [
                Icon(
                  Icons.devices,
                  size: 16,
                  color: disabledBoldColor,
                ),
                SizedBox(width: spXs),
                Expanded(
                  child: Text(
                    "Affected Assets: ${affectedAssets.join(", ")}",
                    style: TextStyle(
                      fontSize: 13,
                      color: disabledBoldColor,
                    ),
                  ),
                ),
              ],
            ),
          ],
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: infoColor.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.security,
                  size: 16,
                  color: infoColor,
                ),
                SizedBox(width: spXs),
                Expanded(
                  child: Text(
                    "Action Taken: ${log["actionTaken"]}",
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: infoColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Row(
            children: [
              Text(
                "${log["userAgent"]}",
                style: TextStyle(
                  fontSize: 11,
                  color: disabledBoldColor,
                  fontStyle: FontStyle.italic,
                ),
              ),
              Spacer(),
              QButton(
                label: "Investigate",
                size: bs.sm,
                onPressed: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }

  Color _getSeverityColor(String severity) {
    switch (severity) {
      case "Critical":
        return dangerColor;
      case "High":
        return warningColor;
      case "Medium":
        return infoColor;
      case "Low":
        return successColor;
      default:
        return disabledBoldColor;
    }
  }

  Color _getCategoryColor(String category) {
    switch (category) {
      case "Intrusion Attempt":
        return dangerColor;
      case "Malware Detection":
        return warningColor;
      case "Suspicious Activity":
        return infoColor;
      case "Policy Violation":
        return secondaryColor;
      case "Unauthorized Access":
        return primaryColor;
      default:
        return disabledBoldColor;
    }
  }

  IconData _getCategoryIcon(String category) {
    switch (category) {
      case "Intrusion Attempt":
        return Icons.security;
      case "Malware Detection":
        return Icons.bug_report;
      case "Suspicious Activity":
        return Icons.visibility;
      case "Policy Violation":
        return Icons.policy;
      case "Unauthorized Access":
        return Icons.no_accounts;
      default:
        return Icons.info;
    }
  }
}
