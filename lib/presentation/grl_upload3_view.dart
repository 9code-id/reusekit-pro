import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlUpload3View extends StatefulWidget {
  @override
  State<GrlUpload3View> createState() => _GrlUpload3ViewState();
}

class _GrlUpload3ViewState extends State<GrlUpload3View> {
  int currentTab = 0;
  String selectedCloudProvider = "Google Drive";
  String selectedUploadQuality = "High";
  bool autoUpload = true;
  bool uploadOnWifi = true;
  bool compressFiles = false;
  bool encryptFiles = true;
  bool notifyOnComplete = true;
  bool backupMetadata = true;
  String uploadLocation = "/uploads";
  String maxFileSize = "100";
  String bandwidthLimit = "unlimited";
  String concurrentUploads = "3";

  List<Map<String, dynamic>> cloudProviders = [
    {"label": "Google Drive", "value": "Google Drive"},
    {"label": "Dropbox", "value": "Dropbox"},
    {"label": "OneDrive", "value": "OneDrive"},
    {"label": "Amazon S3", "value": "Amazon S3"},
    {"label": "iCloud", "value": "iCloud"},
  ];

  List<Map<String, dynamic>> qualityOptions = [
    {"label": "Low", "value": "Low"},
    {"label": "Medium", "value": "Medium"},
    {"label": "High", "value": "High"},
    {"label": "Original", "value": "Original"},
  ];

  List<Map<String, dynamic>> bandwidthOptions = [
    {"label": "Unlimited", "value": "unlimited"},
    {"label": "1 MB/s", "value": "1"},
    {"label": "5 MB/s", "value": "5"},
    {"label": "10 MB/s", "value": "10"},
    {"label": "20 MB/s", "value": "20"},
  ];

  List<Map<String, dynamic>> concurrentOptions = [
    {"label": "1", "value": "1"},
    {"label": "2", "value": "2"},
    {"label": "3", "value": "3"},
    {"label": "5", "value": "5"},
    {"label": "10", "value": "10"},
  ];

  List<Map<String, dynamic>> accounts = [
    {
      "provider": "Google Drive",
      "email": "user@gmail.com",
      "storage": "15 GB",
      "used": "8.2 GB",
      "connected": true,
      "lastSync": "2024-01-15 10:30:00"
    },
    {
      "provider": "Dropbox",
      "email": "user@company.com",
      "storage": "2 GB",
      "used": "1.1 GB",
      "connected": true,
      "lastSync": "2024-01-14 16:45:00"
    },
    {
      "provider": "OneDrive",
      "email": "user@outlook.com",
      "storage": "5 GB",
      "used": "2.8 GB",
      "connected": false,
      "lastSync": "2024-01-10 09:15:00"
    },
  ];

  List<Map<String, dynamic>> syncRules = [
    {
      "name": "Work Documents",
      "pattern": "*.docx,*.xlsx,*.pptx",
      "destination": "/work",
      "enabled": true,
      "lastRun": "2024-01-15 09:00:00"
    },
    {
      "name": "Media Files",
      "pattern": "*.jpg,*.png,*.mp4",
      "destination": "/media",
      "enabled": true,
      "lastRun": "2024-01-15 08:30:00"
    },
    {
      "name": "Code Projects",
      "pattern": "*.dart,*.js,*.py",
      "destination": "/code",
      "enabled": false,
      "lastRun": "2024-01-12 14:20:00"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Cloud Upload Settings",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Settings", icon: Icon(Icons.settings)),
        Tab(text: "Accounts", icon: Icon(Icons.account_circle)),
        Tab(text: "Sync Rules", icon: Icon(Icons.sync)),
      ],
      tabChildren: [
        _buildSettingsTab(),
        _buildAccountsTab(),
        _buildSyncRulesTab(),
      ],
    );
  }

  Widget _buildSettingsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          _buildGeneralSettingsCard(),
          _buildUploadSettingsCard(),
          _buildAdvancedSettingsCard(),
          _buildNotificationSettingsCard(),
        ],
      ),
    );
  }

  Widget _buildGeneralSettingsCard() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Text(
            "General Settings",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          QDropdownField(
            label: "Default Cloud Provider",
            items: cloudProviders,
            value: selectedCloudProvider,
            onChanged: (value, label) {
              selectedCloudProvider = value;
              setState(() {});
            },
          ),
          QTextField(
            label: "Upload Location",
            value: uploadLocation,
            hint: "Default upload directory",
            onChanged: (value) {
              uploadLocation = value;
              setState(() {});
            },
          ),
          QDropdownField(
            label: "Upload Quality",
            items: qualityOptions,
            value: selectedUploadQuality,
            onChanged: (value, label) {
              selectedUploadQuality = value;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  Widget _buildUploadSettingsCard() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Text(
            "Upload Settings",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          QSwitch(
            items: [
              {
                "label": "Auto Upload",
                "value": true,
                "checked": autoUpload,
              }
            ],
            value: [
              if (autoUpload)
                {"label": "Auto Upload", "value": true, "checked": true}
            ],
            onChanged: (values, ids) {
              autoUpload = values.isNotEmpty;
              setState(() {});
            },
          ),
          QSwitch(
            items: [
              {
                "label": "Upload only on Wi-Fi",
                "value": true,
                "checked": uploadOnWifi,
              }
            ],
            value: [
              if (uploadOnWifi)
                {"label": "Upload only on Wi-Fi", "value": true, "checked": true}
            ],
            onChanged: (values, ids) {
              uploadOnWifi = values.isNotEmpty;
              setState(() {});
            },
          ),
          QTextField(
            label: "Max File Size (MB)",
            value: maxFileSize,
            hint: "Maximum file size for upload",
            onChanged: (value) {
              maxFileSize = value;
              setState(() {});
            },
          ),
          QDropdownField(
            label: "Bandwidth Limit",
            items: bandwidthOptions,
            value: bandwidthLimit,
            onChanged: (value, label) {
              bandwidthLimit = value;
              setState(() {});
            },
          ),
          QDropdownField(
            label: "Concurrent Uploads",
            items: concurrentOptions,
            value: concurrentUploads,
            onChanged: (value, label) {
              concurrentUploads = value;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  Widget _buildAdvancedSettingsCard() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Text(
            "Advanced Settings",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          QSwitch(
            items: [
              {
                "label": "Compress Files",
                "value": true,
                "checked": compressFiles,
              }
            ],
            value: [
              if (compressFiles)
                {"label": "Compress Files", "value": true, "checked": true}
            ],
            onChanged: (values, ids) {
              compressFiles = values.isNotEmpty;
              setState(() {});
            },
          ),
          QSwitch(
            items: [
              {
                "label": "Encrypt Files",
                "value": true,
                "checked": encryptFiles,
              }
            ],
            value: [
              if (encryptFiles)
                {"label": "Encrypt Files", "value": true, "checked": true}
            ],
            onChanged: (values, ids) {
              encryptFiles = values.isNotEmpty;
              setState(() {});
            },
          ),
          QSwitch(
            items: [
              {
                "label": "Backup Metadata",
                "value": true,
                "checked": backupMetadata,
              }
            ],
            value: [
              if (backupMetadata)
                {"label": "Backup Metadata", "value": true, "checked": true}
            ],
            onChanged: (values, ids) {
              backupMetadata = values.isNotEmpty;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  Widget _buildNotificationSettingsCard() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Text(
            "Notifications",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          QSwitch(
            items: [
              {
                "label": "Notify on Upload Complete",
                "value": true,
                "checked": notifyOnComplete,
              }
            ],
            value: [
              if (notifyOnComplete)
                {"label": "Notify on Upload Complete", "value": true, "checked": true}
            ],
            onChanged: (values, ids) {
              notifyOnComplete = values.isNotEmpty;
              setState(() {});
            },
          ),
          Container(
            width: double.infinity,
            child: QButton(
              label: "Save Settings",
              size: bs.md,
              onPressed: () async {
                showLoading();
                await Future.delayed(Duration(seconds: 2));
                hideLoading();
                ss("Settings saved successfully");
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAccountsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          Row(
            children: [
              Text(
                "Connected Accounts",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Spacer(),
              QButton(
                label: "Add Account",
                size: bs.sm,
                onPressed: () => _showAddAccountDialog(),
              ),
            ],
          ),
          ...accounts.map((account) => _buildAccountCard(account)),
        ],
      ),
    );
  }

  Widget _buildAccountCard(Map<String, dynamic> account) {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
        border: Border.all(
          color: (account["connected"] as bool) ? successColor.withAlpha(50) : dangerColor.withAlpha(50),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(spXs),
                decoration: BoxDecoration(
                  color: primaryColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Icon(
                  _getProviderIcon(account["provider"] as String),
                  color: primaryColor,
                  size: 20,
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${account["provider"]}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "${account["email"]}",
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
                  color: (account["connected"] as bool) ? successColor : dangerColor,
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  (account["connected"] as bool) ? "Connected" : "Disconnected",
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: disabledColor.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Column(
              spacing: spXs,
              children: [
                Row(
                  children: [
                    Text(
                      "Storage Used:",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Spacer(),
                    Text(
                      "${account["used"]} / ${account["storage"]}",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(radiusXs),
                  child: LinearProgressIndicator(
                    value: _calculateStoragePercentage(account["used"] as String, account["storage"] as String),
                    backgroundColor: disabledColor.withAlpha(30),
                    valueColor: AlwaysStoppedAnimation<Color>(
                      _calculateStoragePercentage(account["used"] as String, account["storage"] as String) > 0.8 
                        ? dangerColor 
                        : primaryColor,
                    ),
                    minHeight: 4,
                  ),
                ),
                Row(
                  children: [
                    Text(
                      "Last Sync:",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Spacer(),
                    Text(
                      "${DateTime.parse(account["lastSync"] as String).dMMMy}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Row(
            children: [
              Expanded(
                child: QButton(
                  label: (account["connected"] as bool) ? "Disconnect" : "Connect",
                  size: bs.sm,
                  onPressed: () => _toggleConnection(account),
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QButton(
                  label: "Sync Now",
                  size: bs.sm,
                  onPressed: () => _syncAccount(account),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSyncRulesTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          Row(
            children: [
              Text(
                "Sync Rules",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Spacer(),
              QButton(
                label: "Add Rule",
                size: bs.sm,
                onPressed: () => _showAddRuleDialog(),
              ),
            ],
          ),
          ...syncRules.map((rule) => _buildSyncRuleCard(rule)),
        ],
      ),
    );
  }

  Widget _buildSyncRuleCard(Map<String, dynamic> rule) {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
        border: Border.all(
          color: (rule["enabled"] as bool) ? successColor.withAlpha(50) : disabledColor.withAlpha(50),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  "${rule["name"]}",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 4),
                decoration: BoxDecoration(
                  color: (rule["enabled"] as bool) ? successColor : disabledColor,
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  (rule["enabled"] as bool) ? "Enabled" : "Disabled",
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: disabledColor.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spXs,
              children: [
                Row(
                  children: [
                    Icon(Icons.pattern, size: 16, color: disabledBoldColor),
                    SizedBox(width: spXs),
                    Text(
                      "Pattern:",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
                Text(
                  "${rule["pattern"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: primaryColor,
                    fontFamily: 'monospace',
                  ),
                ),
                SizedBox(height: spXs),
                Row(
                  children: [
                    Icon(Icons.folder, size: 16, color: disabledBoldColor),
                    SizedBox(width: spXs),
                    Text(
                      "Destination:",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
                Text(
                  "${rule["destination"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: primaryColor,
                    fontFamily: 'monospace',
                  ),
                ),
                SizedBox(height: spXs),
                Row(
                  children: [
                    Icon(Icons.schedule, size: 16, color: disabledBoldColor),
                    SizedBox(width: spXs),
                    Text(
                      "Last Run:",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: disabledBoldColor,
                      ),
                    ),
                    Spacer(),
                    Text(
                      "${DateTime.parse(rule["lastRun"] as String).dMMMy}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Row(
            children: [
              Expanded(
                child: QButton(
                  label: (rule["enabled"] as bool) ? "Disable" : "Enable",
                  size: bs.sm,
                  onPressed: () => _toggleRule(rule),
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QButton(
                  label: "Run Now",
                  size: bs.sm,
                  onPressed: () => _runRule(rule),
                ),
              ),
              SizedBox(width: spSm),
              QButton(
                icon: Icons.delete,
                size: bs.sm,
                onPressed: () => _deleteRule(rule),
              ),
            ],
          ),
        ],
      ),
    );
  }

  IconData _getProviderIcon(String provider) {
    switch (provider) {
      case "Google Drive":
        return Icons.cloud;
      case "Dropbox":
        return Icons.cloud_queue;
      case "OneDrive":
        return Icons.cloud_circle;
      case "Amazon S3":
        return Icons.cloud_upload;
      case "iCloud":
        return Icons.cloud_done;
      default:
        return Icons.cloud;
    }
  }

  double _calculateStoragePercentage(String used, String total) {
    double usedGB = double.tryParse(used.replaceAll(RegExp(r'[^0-9.]'), '')) ?? 0;
    double totalGB = double.tryParse(total.replaceAll(RegExp(r'[^0-9.]'), '')) ?? 1;
    return usedGB / totalGB;
  }

  void _showAddAccountDialog() {
    // Show add account dialog
    si("Add Account dialog would open here");
  }

  void _toggleConnection(Map<String, dynamic> account) async {
    showLoading();
    await Future.delayed(Duration(seconds: 1));
    hideLoading();
    
    bool currentStatus = account["connected"] as bool;
    account["connected"] = !currentStatus;
    setState(() {});
    
    if (account["connected"]) {
      ss("${account["provider"]} connected successfully");
    } else {
      sw("${account["provider"]} disconnected");
    }
  }

  void _syncAccount(Map<String, dynamic> account) async {
    showLoading();
    await Future.delayed(Duration(seconds: 2));
    hideLoading();
    
    account["lastSync"] = DateTime.now().toIso8601String();
    setState(() {});
    
    ss("${account["provider"]} synced successfully");
  }

  void _showAddRuleDialog() {
    // Show add rule dialog
    si("Add Sync Rule dialog would open here");
  }

  void _toggleRule(Map<String, dynamic> rule) {
    rule["enabled"] = !(rule["enabled"] as bool);
    setState(() {});
    
    if (rule["enabled"]) {
      ss("Rule '${rule["name"]}' enabled");
    } else {
      sw("Rule '${rule["name"]}' disabled");
    }
  }

  void _runRule(Map<String, dynamic> rule) async {
    showLoading();
    await Future.delayed(Duration(seconds: 2));
    hideLoading();
    
    rule["lastRun"] = DateTime.now().toIso8601String();
    setState(() {});
    
    ss("Rule '${rule["name"]}' executed successfully");
  }

  void _deleteRule(Map<String, dynamic> rule) async {
    bool isConfirmed = await confirm("Are you sure you want to delete this sync rule?");
    if (isConfirmed) {
      syncRules.remove(rule);
      setState(() {});
      ss("Sync rule deleted successfully");
    }
  }
}
