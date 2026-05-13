import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlSettings10View extends StatefulWidget {
  @override
  State<GrlSettings10View> createState() => _GrlSettings10ViewState();
}

class _GrlSettings10ViewState extends State<GrlSettings10View> {
  bool enableAdvancedMode = false;
  bool enableBetaFeatures = false;
  bool enableExperimentalApi = false;
  bool enableDataExport = true;
  bool enableCloudSync = true;
  String selectedDataFormat = "JSON";
  String selectedExportFrequency = "Weekly";
  String selectedSyncInterval = "Real-time";
  bool autoBackupEnabled = true;
  bool compressionEnabled = false;
  
  final List<Map<String, dynamic>> dataFormats = [
    {"label": "JSON", "value": "JSON"},
    {"label": "CSV", "value": "CSV"},
    {"label": "XML", "value": "XML"},
    {"label": "Excel", "value": "Excel"},
  ];
  
  final List<Map<String, dynamic>> exportFrequencies = [
    {"label": "Daily", "value": "Daily"},
    {"label": "Weekly", "value": "Weekly"},
    {"label": "Monthly", "value": "Monthly"},
    {"label": "Manual", "value": "Manual"},
  ];
  
  final List<Map<String, dynamic>> syncIntervals = [
    {"label": "Real-time", "value": "Real-time"},
    {"label": "Every 5 minutes", "value": "5min"},
    {"label": "Every 15 minutes", "value": "15min"},
    {"label": "Hourly", "value": "hourly"},
  ];
  
  final List<Map<String, dynamic>> integrationServices = [
    {
      "name": "Google Drive",
      "icon": Icons.cloud,
      "connected": true,
      "description": "Sync data with Google Drive",
    },
    {
      "name": "Dropbox",
      "icon": Icons.cloud_upload,
      "connected": false,
      "description": "Backup to Dropbox storage",
    },
    {
      "name": "OneDrive",
      "icon": Icons.cloud_sync,
      "connected": true,
      "description": "Microsoft OneDrive integration",
    },
    {
      "name": "iCloud",
      "icon": Icons.cloud_circle,
      "connected": false,
      "description": "Apple iCloud synchronization",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Advanced Settings"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildAdvancedModeSection(),
            _buildBetaFeaturesSection(),
            _buildDataManagementSection(),
            _buildCloudIntegrationSection(),
            _buildExportImportSection(),
            _buildAdvancedOptionsSection(),
            _buildDangerZoneSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildAdvancedModeSection() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: primaryColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Icon(
                  Icons.settings_applications,
                  color: primaryColor,
                  size: 24,
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Advanced Mode",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "Unlock advanced features and settings",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: warningColor.withAlpha(10),
              border: Border.all(color: warningColor.withAlpha(30)),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.warning_amber,
                  color: warningColor,
                  size: 20,
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: Text(
                    "Advanced mode enables experimental features that may affect app stability",
                    style: TextStyle(
                      fontSize: 12,
                      color: warningColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
          QSwitch(
            items: [
              {
                "label": "Enable Advanced Mode",
                "value": true,
                "checked": enableAdvancedMode,
              }
            ],
            value: [
              if (enableAdvancedMode)
                {
                  "label": "Enable Advanced Mode",
                  "value": true,
                  "checked": true
                }
            ],
            onChanged: (values, ids) {
              setState(() {
                enableAdvancedMode = values.isNotEmpty;
              });
            },
          ),
        ],
      ),
    );
  }

  Widget _buildBetaFeaturesSection() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: infoColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Icon(
                  Icons.science,
                  color: infoColor,
                  size: 24,
                ),
              ),
              SizedBox(width: spSm),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Beta Features",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Text(
                    "Try experimental features before release",
                    style: TextStyle(
                      fontSize: 14,
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ),
            ],
          ),
          QSwitch(
            items: [
              {
                "label": "Enable Beta Features",
                "value": true,
                "checked": enableBetaFeatures,
              }
            ],
            value: [
              if (enableBetaFeatures)
                {
                  "label": "Enable Beta Features",
                  "value": true,
                  "checked": true
                }
            ],
            onChanged: (values, ids) {
              setState(() {
                enableBetaFeatures = values.isNotEmpty;
              });
            },
          ),
          if (enableBetaFeatures) ...[
            Divider(color: disabledOutlineBorderColor),
            QSwitch(
              items: [
                {
                  "label": "Experimental API Access",
                  "value": true,
                  "checked": enableExperimentalApi,
                }
              ],
              value: [
                if (enableExperimentalApi)
                  {
                    "label": "Experimental API Access",
                    "value": true,
                    "checked": true
                  }
              ],
              onChanged: (values, ids) {
                setState(() {
                  enableExperimentalApi = values.isNotEmpty;
                });
              },
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildDataManagementSection() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: successColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Icon(
                  Icons.storage,
                  color: successColor,
                  size: 24,
                ),
              ),
              SizedBox(width: spSm),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Data Management",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Text(
                    "Configure data handling preferences",
                    style: TextStyle(
                      fontSize: 14,
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ),
            ],
          ),
          QSwitch(
            items: [
              {
                "label": "Enable Data Export",
                "value": true,
                "checked": enableDataExport,
              }
            ],
            value: [
              if (enableDataExport)
                {
                  "label": "Enable Data Export",
                  "value": true,
                  "checked": true
                }
            ],
            onChanged: (values, ids) {
              setState(() {
                enableDataExport = values.isNotEmpty;
              });
            },
          ),
          if (enableDataExport) ...[
            QDropdownField(
              label: "Default Export Format",
              items: dataFormats,
              value: selectedDataFormat,
              onChanged: (value, label) {
                selectedDataFormat = value;
                setState(() {});
              },
            ),
            QDropdownField(
              label: "Export Frequency",
              items: exportFrequencies,
              value: selectedExportFrequency,
              onChanged: (value, label) {
                selectedExportFrequency = value;
                setState(() {});
              },
            ),
          ],
          QSwitch(
            items: [
              {
                "label": "Auto Backup",
                "value": true,
                "checked": autoBackupEnabled,
              }
            ],
            value: [
              if (autoBackupEnabled)
                {
                  "label": "Auto Backup",
                  "value": true,
                  "checked": true
                }
            ],
            onChanged: (values, ids) {
              setState(() {
                autoBackupEnabled = values.isNotEmpty;
              });
            },
          ),
          QSwitch(
            items: [
              {
                "label": "Enable Compression",
                "value": true,
                "checked": compressionEnabled,
              }
            ],
            value: [
              if (compressionEnabled)
                {
                  "label": "Enable Compression",
                  "value": true,
                  "checked": true
                }
            ],
            onChanged: (values, ids) {
              setState(() {
                compressionEnabled = values.isNotEmpty;
              });
            },
          ),
        ],
      ),
    );
  }

  Widget _buildCloudIntegrationSection() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: infoColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Icon(
                  Icons.cloud_sync,
                  color: infoColor,
                  size: 24,
                ),
              ),
              SizedBox(width: spSm),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Cloud Integration",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Text(
                    "Connect with cloud storage services",
                    style: TextStyle(
                      fontSize: 14,
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ),
            ],
          ),
          QSwitch(
            items: [
              {
                "label": "Enable Cloud Sync",
                "value": true,
                "checked": enableCloudSync,
              }
            ],
            value: [
              if (enableCloudSync)
                {
                  "label": "Enable Cloud Sync",
                  "value": true,
                  "checked": true
                }
            ],
            onChanged: (values, ids) {
              setState(() {
                enableCloudSync = values.isNotEmpty;
              });
            },
          ),
          if (enableCloudSync) ...[
            QDropdownField(
              label: "Sync Interval",
              items: syncIntervals,
              value: selectedSyncInterval,
              onChanged: (value, label) {
                selectedSyncInterval = value;
                setState(() {});
              },
            ),
            Divider(color: disabledOutlineBorderColor),
            Text(
              "Connected Services",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: primaryColor,
              ),
            ),
            ...integrationServices.map((service) => _buildServiceTile(service)),
          ],
        ],
      ),
    );
  }

  Widget _buildServiceTile(Map<String, dynamic> service) {
    bool isConnected = service["connected"] as bool;
    
    return Container(
      padding: EdgeInsets.all(spSm),
      margin: EdgeInsets.only(bottom: spXs),
      decoration: BoxDecoration(
        color: isConnected 
            ? successColor.withAlpha(10) 
            : disabledColor.withAlpha(10),
        border: Border.all(
          color: isConnected 
              ? successColor.withAlpha(30) 
              : disabledOutlineBorderColor,
        ),
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Row(
        children: [
          Icon(
            service["icon"] as IconData,
            color: isConnected ? successColor : disabledBoldColor,
            size: 24,
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${service["name"]}",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: isConnected ? primaryColor : disabledBoldColor,
                  ),
                ),
                Text(
                  "${service["description"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
          QButton(
            label: isConnected ? "Disconnect" : "Connect",
            size: bs.sm,
            onPressed: () {
              // Handle connection toggle
            },
          ),
        ],
      ),
    );
  }

  Widget _buildExportImportSection() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: secondaryColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Icon(
                  Icons.import_export,
                  color: secondaryColor,
                  size: 24,
                ),
              ),
              SizedBox(width: spSm),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Export & Import",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Text(
                    "Manage your data exports and imports",
                    style: TextStyle(
                      fontSize: 14,
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: QButton(
                  label: "Export All Data",
                  size: bs.sm,
                  onPressed: () {
                    // Handle export
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QButton(
                  label: "Import Data",
                  size: bs.sm,
                  onPressed: () {
                    // Handle import
                  },
                ),
              ),
            ],
          ),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: infoColor.withAlpha(10),
              border: Border.all(color: infoColor.withAlpha(30)),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.info_outline,
                  color: infoColor,
                  size: 20,
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: Text(
                    "Last export: 2 days ago • Next scheduled: Tomorrow",
                    style: TextStyle(
                      fontSize: 12,
                      color: infoColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAdvancedOptionsSection() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: warningColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Icon(
                  Icons.tune,
                  color: warningColor,
                  size: 24,
                ),
              ),
              SizedBox(width: spSm),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Advanced Options",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Text(
                    "Fine-tune application behavior",
                    style: TextStyle(
                      fontSize: 14,
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ),
            ],
          ),
          _buildAdvancedOption(
            "Clear Cache",
            "Remove all cached data and files",
            Icons.cleaning_services,
            () {
              // Handle clear cache
            },
          ),
          _buildAdvancedOption(
            "Reset Preferences",
            "Restore all settings to default values",
            Icons.settings_backup_restore,
            () {
              // Handle reset preferences
            },
          ),
          _buildAdvancedOption(
            "Download Debug Log",
            "Export diagnostic information for support",
            Icons.bug_report,
            () {
              // Handle download debug log
            },
          ),
          _buildAdvancedOption(
            "Force Sync",
            "Manually trigger data synchronization",
            Icons.sync,
            () {
              // Handle force sync
            },
          ),
        ],
      ),
    );
  }

  Widget _buildAdvancedOption(String title, String description, IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(spSm),
        decoration: BoxDecoration(
          border: Border.all(color: disabledOutlineBorderColor),
          borderRadius: BorderRadius.circular(radiusSm),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: disabledBoldColor,
              size: 20,
            ),
            SizedBox(width: spSm),
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
                    description,
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              color: disabledBoldColor,
              size: 16,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDangerZoneSection() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
        border: Border.all(color: dangerColor.withAlpha(30)),
      ),
      child: Column(
        spacing: spSm,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: dangerColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Icon(
                  Icons.warning,
                  color: dangerColor,
                  size: 24,
                ),
              ),
              SizedBox(width: spSm),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Danger Zone",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: dangerColor,
                    ),
                  ),
                  Text(
                    "Irreversible actions - proceed with caution",
                    style: TextStyle(
                      fontSize: 14,
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: dangerColor.withAlpha(10),
              border: Border.all(color: dangerColor.withAlpha(30)),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.error_outline,
                  color: dangerColor,
                  size: 20,
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: Text(
                    "These actions cannot be undone. Make sure you have backups.",
                    style: TextStyle(
                      fontSize: 12,
                      color: dangerColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Row(
            children: [
              Expanded(
                child: QButton(
                  label: "Delete All Data",
                  size: bs.sm,
                  onPressed: () async {
                    bool isConfirmed = await confirm("Are you sure you want to delete all data? This action cannot be undone.");
                    if (isConfirmed) {
                      // Handle delete all data
                    }
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QButton(
                  label: "Reset App",
                  size: bs.sm,
                  onPressed: () async {
                    bool isConfirmed = await confirm("Are you sure you want to reset the app to factory settings?");
                    if (isConfirmed) {
                      // Handle app reset
                    }
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
