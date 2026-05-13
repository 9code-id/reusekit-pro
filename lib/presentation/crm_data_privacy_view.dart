import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class CrmDataPrivacyView extends StatefulWidget {
  const CrmDataPrivacyView({super.key});

  @override
  State<CrmDataPrivacyView> createState() => _CrmDataPrivacyViewState();
}

class _CrmDataPrivacyViewState extends State<CrmDataPrivacyView> {
  final formKey = GlobalKey<FormState>();
  
  // Privacy Settings
  bool dataMinimization = true;
  bool consentTracking = true;
  bool rightToErasure = true;
  bool dataPortability = false;
  bool anonymization = true;
  String dataRetentionPeriod = "7";
  
  // Consent Management
  bool explicitConsent = true;
  bool granularConsent = false;
  bool consentWithdrawal = true;
  bool consentAuditLog = true;
  
  // Data Processing
  bool purposeLimitation = true;
  bool accessLogging = true;
  bool dataEncryption = true;
  bool crossBorderTransfer = false;
  String encryptionLevel = "AES256";
  
  // Privacy Controls
  bool dataSubjectRights = true;
  bool privacyByDesign = true;
  bool impactAssessment = false;
  bool thirdPartySharing = false;

  List<Map<String, dynamic>> retentionOptions = [
    {"label": "1 year", "value": "1"},
    {"label": "3 years", "value": "3"},
    {"label": "5 years", "value": "5"},
    {"label": "7 years", "value": "7"},
    {"label": "10 years", "value": "10"},
  ];

  List<Map<String, dynamic>> encryptionOptions = [
    {"label": "AES-128", "value": "AES128"},
    {"label": "AES-256", "value": "AES256"},
    {"label": "RSA-2048", "value": "RSA2048"},
    {"label": "RSA-4096", "value": "RSA4096"},
  ];

  List<Map<String, dynamic>> privacyRequests = [
    {
      "id": "REQ001",
      "type": "Data Access",
      "customer": "John Smith",
      "email": "john.smith@email.com",
      "date": "2024-12-15",
      "status": "Pending",
      "priority": "High",
    },
    {
      "id": "REQ002",
      "type": "Data Deletion",
      "customer": "Sarah Johnson",
      "email": "sarah.j@email.com",
      "date": "2024-12-14",
      "status": "Completed",
      "priority": "Medium",
    },
    {
      "id": "REQ003",
      "type": "Data Portability",
      "customer": "Mike Davis",
      "email": "mike.davis@email.com",
      "date": "2024-12-13",
      "status": "In Progress",
      "priority": "Low",
    },
    {
      "id": "REQ004",
      "type": "Consent Withdrawal",
      "customer": "Emma Wilson",
      "email": "emma.w@email.com",
      "date": "2024-12-12",
      "status": "Completed",
      "priority": "High",
    },
  ];

  List<Map<String, dynamic>> auditLogs = [
    {
      "timestamp": "2024-12-15 14:30:00",
      "action": "Data Access",
      "user": "admin@company.com",
      "customer": "John Smith",
      "details": "Customer data accessed for support ticket #12345",
    },
    {
      "timestamp": "2024-12-15 12:15:00",
      "action": "Consent Updated",
      "user": "sarah.j@email.com",
      "customer": "Sarah Johnson",
      "details": "Marketing consent withdrawn",
    },
    {
      "timestamp": "2024-12-15 10:00:00",
      "action": "Data Export",
      "user": "system",
      "customer": "Mike Davis",
      "details": "Personal data exported for portability request",
    },
    {
      "timestamp": "2024-12-14 16:45:00",
      "action": "Data Deletion",
      "user": "admin@company.com",
      "customer": "Emma Wilson",
      "details": "Customer account and associated data deleted",
    },
  ];

  void _savePrivacySettings() async {
    if (formKey.currentState!.validate()) {
      showLoading();
      await Future.delayed(Duration(seconds: 2));
      hideLoading();
      ss("Privacy settings updated successfully");
    }
  }

  void _processPrivacyRequest(Map<String, dynamic> request, String action) async {
    bool isConfirmed = await confirm("$action privacy request ${request["id"]}?");
    if (isConfirmed) {
      showLoading();
      await Future.delayed(Duration(seconds: 2));
      hideLoading();
      setState(() {
        request["status"] = action == "Approve" ? "Completed" : "Rejected";
      });
      ss("Privacy request ${action.toLowerCase()}d successfully");
    }
  }

  void _exportAuditLog() async {
    showLoading();
    await Future.delayed(Duration(seconds: 2));
    hideLoading();
    ss("Audit log exported successfully");
  }

  Widget _buildSectionCard(String title, String subtitle, List<Widget> children) {
    return Container(
      margin: EdgeInsets.only(bottom: spMd),
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spXs),
          Text(
            subtitle,
            style: TextStyle(
              fontSize: 14,
              color: disabledBoldColor,
            ),
          ),
          SizedBox(height: spMd),
          ...children,
        ],
      ),
    );
  }

  Widget _buildSwitchRow(String title, String subtitle, bool value, Function(bool) onChanged) {
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spXs),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeColor: primaryColor,
          ),
        ],
      ),
    );
  }

  Widget _buildPrivacyOverview() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Privacy Score
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [primaryColor, primaryColor.withAlpha(180)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(radiusMd),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.privacy_tip,
                      color: Colors.white,
                      size: 32,
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Privacy Compliance Score",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            "Based on GDPR requirements",
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.white.withAlpha(200),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: spMd,
                        vertical: spSm,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white.withAlpha(50),
                        borderRadius: BorderRadius.circular(radiusLg),
                      ),
                      child: Text(
                        "87%",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Quick Stats
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: successColor.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Column(
                    children: [
                      Text(
                        "${privacyRequests.where((r) => r["status"] == "Completed").length}",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: successColor,
                        ),
                      ),
                      Text(
                        "Requests Completed",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 12,
                          color: successColor,
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
                    color: warningColor.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Column(
                    children: [
                      Text(
                        "${privacyRequests.where((r) => r["status"] == "Pending").length}",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: warningColor,
                        ),
                      ),
                      Text(
                        "Pending Requests",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 12,
                          color: warningColor,
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
                    color: infoColor.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Column(
                    children: [
                      Text(
                        "${auditLogs.length}",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: infoColor,
                        ),
                      ),
                      Text(
                        "Audit Entries",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 12,
                          color: infoColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),

          // Recent Privacy Requests
          Container(
            padding: EdgeInsets.all(spMd),
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
                    Expanded(
                      child: Text(
                        "Recent Privacy Requests",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ),
                    QButton(
                      label: "View All",
                      size: bs.sm,
                      onPressed: () {},
                    ),
                  ],
                ),
                SizedBox(height: spMd),
                ...privacyRequests.take(3).map((request) {
                  return Container(
                    margin: EdgeInsets.only(bottom: spSm),
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: disabledOutlineBorderColor,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 4,
                          height: 40,
                          decoration: BoxDecoration(
                            color: request["status"] == "Completed"
                                ? successColor
                                : request["status"] == "Pending"
                                    ? warningColor
                                    : infoColor,
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${request["type"]} - ${request["customer"]}",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: primaryColor,
                                ),
                              ),
                              Text(
                                "${request["date"]} • ${request["status"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        if (request["status"] == "Pending")
                          QButton(
                            label: "Process",
                            size: bs.sm,
                            onPressed: () => _processPrivacyRequest(request, "Approve"),
                          ),
                      ],
                    ),
                  );
                }).toList(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPrivacySettings() {
    return Form(
      key: formKey,
      child: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            // Data Protection Settings
            _buildSectionCard(
              "Data Protection",
              "Configure core data protection settings",
              [
                _buildSwitchRow(
                  "Data Minimization",
                  "Collect only necessary data",
                  dataMinimization,
                  (value) => setState(() => dataMinimization = value),
                ),
                _buildSwitchRow(
                  "Consent Tracking",
                  "Track user consent for data processing",
                  consentTracking,
                  (value) => setState(() => consentTracking = value),
                ),
                _buildSwitchRow(
                  "Right to Erasure",
                  "Allow users to request data deletion",
                  rightToErasure,
                  (value) => setState(() => rightToErasure = value),
                ),
                _buildSwitchRow(
                  "Data Portability",
                  "Enable data export in machine-readable format",
                  dataPortability,
                  (value) => setState(() => dataPortability = value),
                ),
                _buildSwitchRow(
                  "Data Anonymization",
                  "Automatically anonymize old data",
                  anonymization,
                  (value) => setState(() => anonymization = value),
                ),
                QDropdownField(
                  label: "Data Retention Period",
                  items: retentionOptions,
                  value: dataRetentionPeriod,
                  onChanged: (value, label) {
                    dataRetentionPeriod = value;
                    setState(() {});
                  },
                ),
              ],
            ),

            // Consent Management
            _buildSectionCard(
              "Consent Management",
              "Manage user consent and preferences",
              [
                _buildSwitchRow(
                  "Explicit Consent",
                  "Require explicit opt-in for data processing",
                  explicitConsent,
                  (value) => setState(() => explicitConsent = value),
                ),
                _buildSwitchRow(
                  "Granular Consent",
                  "Allow separate consent for different purposes",
                  granularConsent,
                  (value) => setState(() => granularConsent = value),
                ),
                _buildSwitchRow(
                  "Consent Withdrawal",
                  "Enable easy consent withdrawal",
                  consentWithdrawal,
                  (value) => setState(() => consentWithdrawal = value),
                ),
                _buildSwitchRow(
                  "Consent Audit Log",
                  "Maintain records of consent changes",
                  consentAuditLog,
                  (value) => setState(() => consentAuditLog = value),
                ),
              ],
            ),

            // Data Processing Security
            _buildSectionCard(
              "Data Processing Security",
              "Configure data processing and security measures",
              [
                _buildSwitchRow(
                  "Purpose Limitation",
                  "Use data only for stated purposes",
                  purposeLimitation,
                  (value) => setState(() => purposeLimitation = value),
                ),
                _buildSwitchRow(
                  "Access Logging",
                  "Log all data access activities",
                  accessLogging,
                  (value) => setState(() => accessLogging = value),
                ),
                _buildSwitchRow(
                  "Data Encryption",
                  "Encrypt sensitive data at rest and in transit",
                  dataEncryption,
                  (value) => setState(() => dataEncryption = value),
                ),
                if (dataEncryption)
                  QDropdownField(
                    label: "Encryption Level",
                    items: encryptionOptions,
                    value: encryptionLevel,
                    onChanged: (value, label) {
                      encryptionLevel = value;
                      setState(() {});
                    },
                  ),
                _buildSwitchRow(
                  "Cross-Border Transfer",
                  "Allow data transfer outside EU/EEA",
                  crossBorderTransfer,
                  (value) => setState(() => crossBorderTransfer = value),
                ),
              ],
            ),

            // Privacy Controls
            _buildSectionCard(
              "Privacy Controls",
              "Additional privacy and compliance controls",
              [
                _buildSwitchRow(
                  "Data Subject Rights",
                  "Enable automated data subject rights handling",
                  dataSubjectRights,
                  (value) => setState(() => dataSubjectRights = value),
                ),
                _buildSwitchRow(
                  "Privacy by Design",
                  "Implement privacy-first system design",
                  privacyByDesign,
                  (value) => setState(() => privacyByDesign = value),
                ),
                _buildSwitchRow(
                  "Impact Assessment",
                  "Require privacy impact assessments",
                  impactAssessment,
                  (value) => setState(() => impactAssessment = value),
                ),
                _buildSwitchRow(
                  "Third-Party Sharing",
                  "Allow data sharing with partners",
                  thirdPartySharing,
                  (value) => setState(() => thirdPartySharing = value),
                ),
              ],
            ),

            // Save Button
            Container(
              width: double.infinity,
              child: QButton(
                label: "Save Privacy Settings",
                size: bs.md,
                onPressed: _savePrivacySettings,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAuditLog() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Export Controls
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Audit Log Export",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "Export privacy audit log for compliance reporting",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ),
                QButton(
                  label: "Export",
                  icon: Icons.download,
                  size: bs.sm,
                  onPressed: _exportAuditLog,
                ),
              ],
            ),
          ),

          // Audit Entries
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Recent Audit Entries",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spMd),
                ...auditLogs.map((entry) {
                  return Container(
                    margin: EdgeInsets.only(bottom: spSm),
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: disabledOutlineBorderColor,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: spSm,
                                vertical: spXs,
                              ),
                              decoration: BoxDecoration(
                                color: primaryColor.withAlpha(20),
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Text(
                                "${entry["action"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: primaryColor,
                                ),
                              ),
                            ),
                            Spacer(),
                            Text(
                              "${entry["timestamp"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: spSm),
                        Text(
                          "User: ${entry["user"]}",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "Customer: ${entry["customer"]}",
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "${entry["details"]}",
                          style: TextStyle(
                            fontSize: 14,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Data Privacy",
      selectedIndex: 0,
      tabs: [
        Tab(text: "Overview", icon: Icon(Icons.dashboard)),
        Tab(text: "Settings", icon: Icon(Icons.settings)),
        Tab(text: "Audit Log", icon: Icon(Icons.history)),
      ],
      tabChildren: [
        _buildPrivacyOverview(),
        _buildPrivacySettings(),
        _buildAuditLog(),
      ],
    );
  }
}
