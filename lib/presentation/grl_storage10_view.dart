import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlStorage10View extends StatefulWidget {
  @override
  State<GrlStorage10View> createState() => _GrlStorage10ViewState();
}

class _GrlStorage10ViewState extends State<GrlStorage10View> {
  bool enableAutoCleanup = true;
  bool enableSmartStorage = false;
  bool enableCompressionAlerts = true;
  bool enableLowStorageAlerts = true;
  String cleanupFrequency = "Weekly";
  String compressionLevel = "Medium";
  String alertThreshold = "85%";

  List<Map<String, dynamic>> frequencyOptions = [
    {"label": "Daily", "value": "Daily"},
    {"label": "Weekly", "value": "Weekly"},
    {"label": "Monthly", "value": "Monthly"},
    {"label": "Never", "value": "Never"},
  ];

  List<Map<String, dynamic>> compressionOptions = [
    {"label": "Low", "value": "Low"},
    {"label": "Medium", "value": "Medium"},
    {"label": "High", "value": "High"},
    {"label": "Maximum", "value": "Maximum"},
  ];

  List<Map<String, dynamic>> thresholdOptions = [
    {"label": "70%", "value": "70%"},
    {"label": "80%", "value": "80%"},
    {"label": "85%", "value": "85%"},
    {"label": "90%", "value": "90%"},
    {"label": "95%", "value": "95%"},
  ];

  List<Map<String, dynamic>> storageRules = [
    {
      "name": "Auto-delete screenshots older than 30 days",
      "description": "Automatically remove old screenshots to free up space",
      "enabled": true,
      "category": "Images",
      "icon": Icons.screenshot,
      "color": successColor
    },
    {
      "name": "Compress videos larger than 100MB",
      "description": "Reduce video file sizes while maintaining quality",
      "enabled": false,
      "category": "Videos",
      "icon": Icons.video_file,
      "color": dangerColor
    },
    {
      "name": "Move old downloads to cloud storage",
      "description": "Automatically backup downloads older than 60 days",
      "enabled": true,
      "category": "Downloads",
      "icon": Icons.cloud_upload,
      "color": infoColor
    },
    {
      "name": "Clear app cache weekly",
      "description": "Remove temporary files from applications",
      "enabled": true,
      "category": "System",
      "icon": Icons.cached,
      "color": warningColor
    },
    {
      "name": "Archive documents older than 1 year",
      "description": "Compress and store old documents efficiently",
      "enabled": false,
      "category": "Documents",
      "icon": Icons.archive,
      "color": primaryColor
    }
  ];

  List<Map<String, dynamic>> excludedLocations = [
    {
      "path": "/System/",
      "reason": "System files",
      "icon": Icons.settings,
      "color": dangerColor
    },
    {
      "path": "/Documents/Important/",
      "reason": "User protected",
      "icon": Icons.folder_special,
      "color": warningColor
    },
    {
      "path": "/Pictures/Family/",
      "reason": "User protected",
      "icon": Icons.photo_library,
      "color": successColor
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Storage Settings"),
        actions: [
          IconButton(
            icon: Icon(Icons.help_outline),
            onPressed: () {
              si("Opening storage settings help");
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildGeneralSettings(),
            _buildAutoCleanupSettings(),
            _buildSmartStorageSettings(),
            _buildStorageRules(),
            _buildExcludedLocations(),
            _buildAdvancedSettings(),
            _buildActionButtons(),
          ],
        ),
      ),
    );
  }

  Widget _buildGeneralSettings() {
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
              Icon(
                Icons.settings,
                color: primaryColor,
                size: 24,
              ),
              SizedBox(width: spSm),
              Text(
                "General Settings",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          QSwitch(
            label: "Enable Low Storage Alerts",
            items: [
              {
                "label": "Enable alerts when storage is running low",
                "value": true,
                "checked": enableLowStorageAlerts,
              }
            ],
            value: [if (enableLowStorageAlerts) {"label": "Enable alerts when storage is running low", "value": true, "checked": true}],
            onChanged: (values, ids) {
              enableLowStorageAlerts = values.isNotEmpty;
              setState(() {});
            },
          ),
          QDropdownField(
            label: "Alert Threshold",
            items: thresholdOptions,
            value: alertThreshold,
            onChanged: (value, label) {
              alertThreshold = value;
              setState(() {});
            },
          ),
          QSwitch(
            label: "Enable Compression Alerts",
            items: [
              {
                "label": "Notify when files can be compressed",
                "value": true,
                "checked": enableCompressionAlerts,
              }
            ],
            value: [if (enableCompressionAlerts) {"label": "Notify when files can be compressed", "value": true, "checked": true}],
            onChanged: (values, ids) {
              enableCompressionAlerts = values.isNotEmpty;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  Widget _buildAutoCleanupSettings() {
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
              Icon(
                Icons.cleaning_services,
                color: successColor,
                size: 24,
              ),
              SizedBox(width: spSm),
              Text(
                "Auto Cleanup",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          QSwitch(
            label: "Enable Automatic Cleanup",
            items: [
              {
                "label": "Automatically clean temporary and junk files",
                "value": true,
                "checked": enableAutoCleanup,
              }
            ],
            value: [if (enableAutoCleanup) {"label": "Automatically clean temporary and junk files", "value": true, "checked": true}],
            onChanged: (values, ids) {
              enableAutoCleanup = values.isNotEmpty;
              setState(() {});
            },
          ),
          if (enableAutoCleanup) ...[
            QDropdownField(
              label: "Cleanup Frequency",
              items: frequencyOptions,
              value: cleanupFrequency,
              onChanged: (value, label) {
                cleanupFrequency = value;
                setState(() {});
              },
            ),
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: successColor.withAlpha(10),
                borderRadius: BorderRadius.circular(radiusSm),
                border: Border.all(color: successColor.withAlpha(40)),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.info_outline,
                    color: successColor,
                    size: 16,
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Text(
                      "Next cleanup scheduled for Monday at 2:00 AM",
                      style: TextStyle(
                        fontSize: 12,
                        color: successColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildSmartStorageSettings() {
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
              Icon(
                Icons.psychology,
                color: infoColor,
                size: 24,
              ),
              SizedBox(width: spSm),
              Text(
                "Smart Storage",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          QSwitch(
            label: "Enable Smart Storage Management",
            items: [
              {
                "label": "Use AI to optimize storage automatically",
                "value": true,
                "checked": enableSmartStorage,
              }
            ],
            value: [if (enableSmartStorage) {"label": "Use AI to optimize storage automatically", "value": true, "checked": true}],
            onChanged: (values, ids) {
              enableSmartStorage = values.isNotEmpty;
              setState(() {});
            },
          ),
          if (enableSmartStorage) ...[
            QDropdownField(
              label: "Compression Level",
              items: compressionOptions,
              value: compressionLevel,
              onChanged: (value, label) {
                compressionLevel = value;
                setState(() {});
              },
            ),
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: infoColor.withAlpha(10),
                borderRadius: BorderRadius.circular(radiusSm),
                border: Border.all(color: infoColor.withAlpha(40)),
              ),
              child: Column(
                spacing: spXs,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Smart Storage Benefits:",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: infoColor,
                    ),
                  ),
                  Text(
                    "• Automatic file compression based on usage",
                    style: TextStyle(
                      fontSize: 12,
                      color: infoColor,
                    ),
                  ),
                  Text(
                    "• Intelligent cloud backup suggestions",
                    style: TextStyle(
                      fontSize: 12,
                      color: infoColor,
                    ),
                  ),
                  Text(
                    "• Predictive storage optimization",
                    style: TextStyle(
                      fontSize: 12,
                      color: infoColor,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildStorageRules() {
    return Column(
      spacing: spSm,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Storage Rules",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        ...storageRules.map((rule) => _buildStorageRuleCard(rule)),
      ],
    );
  }

  Widget _buildStorageRuleCard(Map<String, dynamic> rule) {
    return Container(
      padding: EdgeInsets.all(spMd),
      margin: EdgeInsets.only(bottom: spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
        border: Border(
          left: BorderSide(
            width: 4,
            color: rule["color"] as Color,
          ),
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: (rule["color"] as Color).withAlpha(20),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Icon(
              rule["icon"] as IconData,
              color: rule["color"] as Color,
              size: 20,
            ),
          ),
          SizedBox(width: spMd),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${rule["name"]}",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "${rule["description"]}",
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                  decoration: BoxDecoration(
                    color: (rule["color"] as Color).withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusXs),
                  ),
                  child: Text(
                    "${rule["category"]}",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: rule["color"] as Color,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Switch(
            value: rule["enabled"],
            onChanged: (value) {
              rule["enabled"] = value;
              setState(() {});
            },
            activeColor: rule["color"] as Color,
          ),
        ],
      ),
    );
  }

  Widget _buildExcludedLocations() {
    return Column(
      spacing: spSm,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              "Excluded Locations",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            Spacer(),
            GestureDetector(
              onTap: () {
                si("Adding new excluded location");
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: primaryColor,
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.add,
                      color: Colors.white,
                      size: 16,
                    ),
                    SizedBox(width: spXs),
                    Text(
                      "Add",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        ...excludedLocations.map((location) => _buildExcludedLocationItem(location)),
      ],
    );
  }

  Widget _buildExcludedLocationItem(Map<String, dynamic> location) {
    return Container(
      padding: EdgeInsets.all(spMd),
      margin: EdgeInsets.only(bottom: spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Row(
        children: [
          Icon(
            location["icon"] as IconData,
            color: location["color"] as Color,
            size: 20,
          ),
          SizedBox(width: spMd),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${location["path"]}",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "Excluded: ${location["reason"]}",
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              si("Removing excluded location: ${location["path"]}");
            },
            child: Icon(
              Icons.remove_circle_outline,
              color: dangerColor,
              size: 20,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAdvancedSettings() {
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
              Icon(
                Icons.tune,
                color: warningColor,
                size: 24,
              ),
              SizedBox(width: spSm),
              Text(
                "Advanced Settings",
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
                child: QButton(
                  label: "Reset to Default",
                  icon: Icons.restore,
                  size: bs.sm,
                  onPressed: () {
                    _resetToDefault();
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QButton(
                  label: "Import Settings",
                  icon: Icons.file_upload,
                  size: bs.sm,
                  onPressed: () {
                    si("Importing storage settings");
                  },
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: QButton(
                  label: "Export Settings",
                  icon: Icons.file_download,
                  size: bs.sm,
                  onPressed: () {
                    ss("Storage settings exported");
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QButton(
                  label: "Clear Cache",
                  icon: Icons.clear_all,
                  size: bs.sm,
                  onPressed: () {
                    _clearCache();
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        children: [
          Container(
            width: double.infinity,
            child: QButton(
              label: "Save Settings",
              icon: Icons.save,
              size: bs.md,
              onPressed: () {
                _saveSettings();
              },
            ),
          ),
          Row(
            children: [
              Expanded(
                child: QButton(
                  label: "Test Settings",
                  icon: Icons.play_arrow,
                  size: bs.sm,
                  onPressed: () {
                    _testSettings();
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QButton(
                  label: "Run Cleanup",
                  icon: Icons.cleaning_services,
                  size: bs.sm,
                  onPressed: () {
                    _runCleanup();
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _resetToDefault() async {
    bool isConfirmed = await confirm("Reset all storage settings to default values?");
    if (isConfirmed) {
      enableAutoCleanup = true;
      enableSmartStorage = false;
      enableCompressionAlerts = true;
      enableLowStorageAlerts = true;
      cleanupFrequency = "Weekly";
      compressionLevel = "Medium";
      alertThreshold = "85%";
      
      for (var rule in storageRules) {
        rule["enabled"] = false;
      }
      
      setState(() {});
      ss("Settings reset to default values");
    }
  }

  void _clearCache() async {
    showLoading();
    await Future.delayed(Duration(seconds: 2));
    hideLoading();
    ss("Storage cache cleared successfully");
  }

  void _saveSettings() async {
    showLoading();
    await Future.delayed(Duration(seconds: 1));
    hideLoading();
    ss("Storage settings saved successfully");
  }

  void _testSettings() async {
    showLoading();
    await Future.delayed(Duration(seconds: 2));
    hideLoading();
    si("Settings test completed. All configurations are valid.");
  }

  void _runCleanup() async {
    bool isConfirmed = await confirm("Run storage cleanup now using current settings?");
    if (isConfirmed) {
      showLoading();
      await Future.delayed(Duration(seconds: 3));
      hideLoading();
      ss("Storage cleanup completed. Freed up 1.2 GB");
    }
  }
}
