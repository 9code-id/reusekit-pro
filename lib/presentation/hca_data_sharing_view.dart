import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class HcaDataSharingView extends StatefulWidget {
  const HcaDataSharingView({super.key});

  @override
  State<HcaDataSharingView> createState() => _HcaDataSharingViewState();
}

class _HcaDataSharingViewState extends State<HcaDataSharingView> {
  // Data sharing preferences
  bool shareWithHealthcareProviders = true;
  bool shareForResearchPurposes = false;
  bool shareWithFamilyMembers = true;
  bool shareWithEmergencyContacts = true;
  bool shareWithInsuranceProvider = false;
  bool shareAnonymousData = true;
  bool shareLocationData = false;
  bool shareBiometricData = true;
  
  // Specific data categories
  Map<String, bool> dataCategories = {
    "basicInfo": true,
    "medicalHistory": true,
    "medications": true,
    "allergies": true,
    "vitals": true,
    "labResults": true,
    "imaging": false,
    "mentalHealth": false,
    "lifestyle": true,
    "emergencyInfo": true,
  };

  String dataRetentionPeriod = "5_years";
  String exportFormat = "pdf";
  
  List<Map<String, dynamic>> retentionOptions = [
    {"label": "1 Year", "value": "1_year"},
    {"label": "3 Years", "value": "3_years"},
    {"label": "5 Years", "value": "5_years"},
    {"label": "10 Years", "value": "10_years"},
    {"label": "Indefinitely", "value": "indefinite"},
  ];

  List<Map<String, dynamic>> formatOptions = [
    {"label": "PDF Document", "value": "pdf"},
    {"label": "Excel Spreadsheet", "value": "excel"},
    {"label": "JSON Format", "value": "json"},
    {"label": "HL7 FHIR", "value": "fhir"},
  ];

  List<Map<String, dynamic>> sharedConnections = [
    {
      "id": 1,
      "name": "Dr. Sarah Martinez",
      "type": "Primary Care Physician",
      "institution": "City Medical Center",
      "permissions": ["basicInfo", "medicalHistory", "medications", "vitals", "labResults"],
      "lastAccess": "2024-01-15T14:30:00Z",
      "status": "active",
      "image": "https://picsum.photos/50/50?random=1",
      "phone": "(555) 123-4567",
      "email": "s.martinez@citymedical.com"
    },
    {
      "id": 2,
      "name": "Memorial Hospital",
      "type": "Healthcare Institution",
      "institution": "Memorial Healthcare System",
      "permissions": ["basicInfo", "emergencyInfo", "allergies", "medications"],
      "lastAccess": "2024-01-10T09:15:00Z",
      "status": "active",
      "image": "https://picsum.photos/50/50?random=2",
      "phone": "(555) 234-5678",
      "email": "records@memorial.org"
    },
    {
      "id": 3,
      "name": "Cancer Research Institute",
      "type": "Research Organization",
      "institution": "National Cancer Research Center",
      "permissions": ["labResults", "imaging", "medications"],
      "lastAccess": "2024-01-08T16:45:00Z",
      "status": "pending",
      "image": "https://picsum.photos/50/50?random=3",
      "phone": "(555) 345-6789",
      "email": "data@ncrc.org"
    },
    {
      "id": 4,
      "name": "John Smith (Spouse)",
      "type": "Family Member",
      "institution": "Personal Contact",
      "permissions": ["basicInfo", "emergencyInfo", "medications", "allergies"],
      "lastAccess": "2024-01-14T20:00:00Z",
      "status": "active",
      "image": "https://picsum.photos/50/50?random=4",
      "phone": "(555) 456-7890",
      "email": "john.smith@email.com"
    }
  ];

  List<Map<String, dynamic>> dataAccessLog = [
    {
      "accessor": "Dr. Sarah Martinez",
      "dataType": "Lab Results",
      "accessTime": "2024-01-15T14:30:00Z",
      "purpose": "Routine Review",
      "ipAddress": "192.168.1.100"
    },
    {
      "accessor": "Memorial Hospital",
      "dataType": "Emergency Information",
      "accessTime": "2024-01-10T09:15:00Z",
      "purpose": "Emergency Visit",
      "ipAddress": "10.0.0.25"
    },
    {
      "accessor": "John Smith",
      "dataType": "Medication List",
      "accessTime": "2024-01-08T20:00:00Z",
      "purpose": "Caregiver Access",
      "ipAddress": "172.16.0.45"
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Data Sharing"),
        actions: [
          IconButton(
            icon: Icon(Icons.history),
            onPressed: () {
              _showAccessLog();
            },
          ),
          IconButton(
            icon: Icon(Icons.security),
            onPressed: () {
              _showPrivacySettings();
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Privacy Overview
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spLg),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [primaryColor, primaryColor.withAlpha(180)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowMd],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.security,
                        color: Colors.white,
                        size: 28,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "Data Privacy & Sharing",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: fsH5,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "Control who has access to your health data and how it's used. Your privacy is our priority.",
                    style: TextStyle(
                      color: Colors.white.withAlpha(230),
                      fontSize: 14,
                      height: 1.4,
                    ),
                  ),
                  SizedBox(height: spMd),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildPrivacyStat("Active Connections", "${sharedConnections.where((c) => c["status"] == "active").length}", Icons.people),
                      _buildPrivacyStat("Data Categories", "${dataCategories.values.where((v) => v).length}/10", Icons.category),
                      _buildPrivacyStat("Last Export", "3 days ago", Icons.download),
                    ],
                  ),
                ],
              ),
            ),
            
            SizedBox(height: spLg),
            
            // Quick Actions
            Row(
              children: [
                Expanded(
                  child: QButton(
                    label: "Export My Data",
                    icon: Icons.download,
                    size: bs.sm,
                    onPressed: () {
                      _showExportDialog();
                    },
                  ),
                ),
                SizedBox(width: spMd),
                Expanded(
                  child: QButton(
                    label: "Share with Provider",
                    icon: Icons.share,
                    color: successColor,
                    size: bs.sm,
                    onPressed: () {
                      _showShareDialog();
                    },
                  ),
                ),
              ],
            ),
            
            SizedBox(height: spLg),
            
            // General Sharing Preferences
            Text(
              "General Sharing Preferences",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            
            SizedBox(height: spMd),
            
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Column(
                spacing: spMd,
                children: [
                  _buildSharingOption(
                    "Healthcare Providers",
                    "Share with doctors, nurses, and medical staff",
                    shareWithHealthcareProviders,
                    Icons.medical_services,
                    (value) {
                      shareWithHealthcareProviders = value;
                      setState(() {});
                    },
                  ),
                  _buildSharingOption(
                    "Research Purposes",
                    "Anonymous data for medical research studies",
                    shareForResearchPurposes,
                    Icons.science,
                    (value) {
                      shareForResearchPurposes = value;
                      setState(() {});
                    },
                  ),
                  _buildSharingOption(
                    "Family Members",
                    "Share with designated family members and caregivers",
                    shareWithFamilyMembers,
                    Icons.family_restroom,
                    (value) {
                      shareWithFamilyMembers = value;
                      setState(() {});
                    },
                  ),
                  _buildSharingOption(
                    "Emergency Contacts",
                    "Share critical information during emergencies",
                    shareWithEmergencyContacts,
                    Icons.emergency,
                    (value) {
                      shareWithEmergencyContacts = value;
                      setState(() {});
                    },
                  ),
                  _buildSharingOption(
                    "Insurance Provider",
                    "Share relevant data with insurance companies",
                    shareWithInsuranceProvider,
                    Icons.business,
                    (value) {
                      shareWithInsuranceProvider = value;
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),
            
            SizedBox(height: spLg),
            
            // Data Categories
            Text(
              "Data Categories",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            
            SizedBox(height: spSm),
            
            Text(
              "Choose which types of health data can be shared",
              style: TextStyle(
                fontSize: 14,
                color: disabledBoldColor,
              ),
            ),
            
            SizedBox(height: spMd),
            
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Column(
                spacing: spSm,
                children: [
                  _buildDataCategoryOption("Basic Information", "Name, age, contact details", "basicInfo", Icons.person),
                  _buildDataCategoryOption("Medical History", "Past conditions, surgeries, treatments", "medicalHistory", Icons.history),
                  _buildDataCategoryOption("Current Medications", "Prescription and over-the-counter medications", "medications", Icons.medication),
                  _buildDataCategoryOption("Allergies", "Drug, food, and environmental allergies", "allergies", Icons.warning),
                  _buildDataCategoryOption("Vital Signs", "Blood pressure, heart rate, temperature", "vitals", Icons.monitor_heart),
                  _buildDataCategoryOption("Lab Results", "Blood tests, urine tests, other lab work", "labResults", Icons.biotech),
                  _buildDataCategoryOption("Medical Imaging", "X-rays, CT scans, MRIs", "imaging", Icons.medical_information),
                  _buildDataCategoryOption("Mental Health", "Psychological assessments, therapy notes", "mentalHealth", Icons.psychology),
                  _buildDataCategoryOption("Lifestyle Data", "Exercise, diet, sleep patterns", "lifestyle", Icons.fitness_center),
                  _buildDataCategoryOption("Emergency Information", "Emergency contacts, critical conditions", "emergencyInfo", Icons.emergency),
                ],
              ),
            ),
            
            SizedBox(height: spLg),
            
            // Data Retention Settings
            Text(
              "Data Retention & Export",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            
            SizedBox(height: spMd),
            
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Column(
                spacing: spMd,
                children: [
                  QDropdownField(
                    label: "Data Retention Period",
                    items: retentionOptions,
                    value: dataRetentionPeriod,
                    onChanged: (value, label) {
                      dataRetentionPeriod = value;
                      setState(() {});
                    },
                  ),
                  QDropdownField(
                    label: "Export Format",
                    items: formatOptions,
                    value: exportFormat,
                    onChanged: (value, label) {
                      exportFormat = value;
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),
            
            SizedBox(height: spLg),
            
            // Shared Connections
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Shared Connections",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    _showShareDialog();
                  },
                  child: Text(
                    "Add Connection",
                    style: TextStyle(
                      fontSize: 14,
                      color: primaryColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            
            SizedBox(height: spMd),
            
            // Connections List
            ...List.generate(sharedConnections.length, (index) {
              final connection = sharedConnections[index];
              return Container(
                margin: EdgeInsets.only(bottom: spMd),
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusLg),
                  boxShadow: [shadowSm],
                  border: connection["status"] == "pending" 
                    ? Border.all(color: warningColor.withAlpha(100), width: 2)
                    : null,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 24,
                          backgroundImage: NetworkImage("${connection["image"]}"),
                        ),
                        SizedBox(width: spMd),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${connection["name"]}",
                                style: TextStyle(
                                  fontSize: fsH6,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                              Text(
                                "${connection["type"]}",
                                style: TextStyle(
                                  fontSize: 13,
                                  color: disabledBoldColor,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Text(
                                "${connection["institution"]}",
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
                            color: _getStatusColor(connection["status"]),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Text(
                            "${connection["status"]}".toUpperCase(),
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                    
                    SizedBox(height: spMd),
                    
                    // Permissions
                    Text(
                      "Shared Data:",
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Wrap(
                      spacing: spXs,
                      children: (connection["permissions"] as List).map<Widget>((permission) {
                        return Container(
                          padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                          decoration: BoxDecoration(
                            color: successColor.withAlpha(25),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Text(
                            _getPermissionLabel(permission),
                            style: TextStyle(
                              fontSize: 11,
                              color: successColor,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                    
                    SizedBox(height: spMd),
                    
                    // Last Access and Actions
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Last Access:",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Text(
                                _formatLastAccess(connection["lastAccess"]),
                                style: TextStyle(
                                  fontSize: 12,
                                  color: primaryColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                        if (connection["status"] == "pending")
                          Row(
                            children: [
                              QButton(
                                label: "Approve",
                                color: successColor,
                                size: bs.sm,
                                onPressed: () {
                                  _approveConnection(connection);
                                },
                              ),
                              SizedBox(width: spSm),
                              QButton(
                                label: "Deny",
                                color: dangerColor,
                                size: bs.sm,
                                onPressed: () {
                                  _denyConnection(connection);
                                },
                              ),
                            ],
                          ),
                        if (connection["status"] == "active")
                          Row(
                            children: [
                              QButton(
                                label: "Edit",
                                size: bs.sm,
                                onPressed: () {
                                  _editConnection(connection);
                                },
                              ),
                              SizedBox(width: spSm),
                              QButton(
                                label: "Revoke",
                                color: dangerColor,
                                size: bs.sm,
                                onPressed: () {
                                  _revokeConnection(connection);
                                },
                              ),
                            ],
                          ),
                      ],
                    ),
                  ],
                ),
              );
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildPrivacyStat(String label, String value, IconData icon) {
    return Column(
      children: [
        Icon(
          icon,
          size: 20,
          color: Colors.white,
        ),
        SizedBox(height: spXs),
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
            fontSize: 11,
            color: Colors.white.withAlpha(200),
          ),
        ),
      ],
    );
  }

  Widget _buildSharingOption(String title, String description, bool value, IconData icon, Function(bool) onChanged) {
    return Row(
      children: [
        Icon(
          icon,
          size: 24,
          color: value ? primaryColor : disabledBoldColor,
        ),
        SizedBox(width: spMd),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Text(
                description,
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
        ),
        SizedBox(width: spMd),
        Switch(
          value: value,
          onChanged: onChanged,
          activeColor: primaryColor,
        ),
      ],
    );
  }

  Widget _buildDataCategoryOption(String title, String description, String key, IconData icon) {
    return Row(
      children: [
        Icon(
          icon,
          size: 20,
          color: dataCategories[key]! ? primaryColor : disabledBoldColor,
        ),
        SizedBox(width: spMd),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Text(
                description,
                style: TextStyle(
                  fontSize: 11,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
        ),
        SizedBox(width: spMd),
        Switch(
          value: dataCategories[key]!,
          onChanged: (value) {
            dataCategories[key] = value;
            setState(() {});
          },
          activeColor: primaryColor,
        ),
      ],
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "active":
        return successColor;
      case "pending":
        return warningColor;
      case "revoked":
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  String _getPermissionLabel(String permission) {
    switch (permission) {
      case "basicInfo":
        return "Basic Info";
      case "medicalHistory":
        return "Medical History";
      case "medications":
        return "Medications";
      case "allergies":
        return "Allergies";
      case "vitals":
        return "Vital Signs";
      case "labResults":
        return "Lab Results";
      case "imaging":
        return "Medical Imaging";
      case "mentalHealth":
        return "Mental Health";
      case "lifestyle":
        return "Lifestyle";
      case "emergencyInfo":
        return "Emergency Info";
      default:
        return permission;
    }
  }

  String _formatLastAccess(String dateString) {
    final date = DateTime.parse(dateString);
    final now = DateTime.now();
    final difference = now.difference(date);
    
    if (difference.inDays == 0) {
      return "Today";
    } else if (difference.inDays == 1) {
      return "Yesterday";
    } else if (difference.inDays < 7) {
      return "${difference.inDays} days ago";
    } else {
      return "${date.day}/${date.month}/${date.year}";
    }
  }

  void _showExportDialog() {
    // Show data export dialog
  }

  void _showShareDialog() {
    // Show share with provider dialog
  }

  void _showAccessLog() {
    // Show data access log
  }

  void _showPrivacySettings() {
    // Show privacy settings
  }

  void _approveConnection(Map<String, dynamic> connection) {
    connection["status"] = "active";
    setState(() {});
    ss("Connection approved successfully!");
  }

  void _denyConnection(Map<String, dynamic> connection) {
    sharedConnections.remove(connection);
    setState(() {});
    ss("Connection request denied.");
  }

  void _editConnection(Map<String, dynamic> connection) {
    // Edit connection permissions
  }

  void _revokeConnection(Map<String, dynamic> connection) async {
    bool isConfirmed = await confirm("Are you sure you want to revoke access for ${connection["name"]}?");
    if (isConfirmed) {
      connection["status"] = "revoked";
      setState(() {});
      ss("Access revoked for ${connection["name"]}.");
    }
  }
}
