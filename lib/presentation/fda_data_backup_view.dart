import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class FdaDataBackupView extends StatefulWidget {
  const FdaDataBackupView({super.key});

  @override
  State<FdaDataBackupView> createState() => _FdaDataBackupViewState();
}

class _FdaDataBackupViewState extends State<FdaDataBackupView> {
  bool autoBackupEnabled = true;
  String backupFrequency = "weekly";
  bool includeOrderHistory = true;
  bool includePaymentMethods = false;
  bool includeFavorites = true;
  bool includeAddresses = true;
  bool includePreferences = true;
  bool encryptBackup = true;
  String cloudProvider = "google";
  
  DateTime lastBackup = DateTime.now().subtract(Duration(days: 3));
  DateTime nextBackup = DateTime.now().add(Duration(days: 4));
  String backupSize = "25.4 MB";
  int totalBackups = 12;
  
  List<Map<String, dynamic>> backupHistory = [
    {
      "date": DateTime.now().subtract(Duration(days: 3)),
      "size": "25.4 MB",
      "type": "Automatic",
      "status": "Completed",
      "items": 1247
    },
    {
      "date": DateTime.now().subtract(Duration(days: 10)),
      "size": "24.8 MB",
      "type": "Automatic",
      "status": "Completed",
      "items": 1198
    },
    {
      "date": DateTime.now().subtract(Duration(days: 17)),
      "size": "23.1 MB",
      "type": "Manual",
      "status": "Completed",
      "items": 1156
    },
    {
      "date": DateTime.now().subtract(Duration(days: 24)),
      "size": "22.7 MB",
      "type": "Automatic",
      "status": "Failed",
      "items": 0
    },
  ];

  bool isBackingUp = false;
  bool isRestoring = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Data Backup"),
        actions: [
          IconButton(
            icon: Icon(Icons.cloud_upload),
            onPressed: _performManualBackup,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            _buildBackupStatusCard(),
            _buildAutoBackupSettings(),
            _buildBackupContentSettings(),
            _buildCloudStorageSettings(),
            _buildBackupHistorySection(),
            _buildRestoreSection(),
            _buildActionButtons(),
          ],
        ),
      ),
    );
  }

  Widget _buildBackupStatusCard() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [primaryColor, primaryColor.withAlpha(200)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowMd],
      ),
      child: Column(
        spacing: spSm,
        children: [
          Row(
            children: [
              Icon(
                Icons.cloud_done,
                color: Colors.white,
                size: 32,
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Backup Status",
                      style: TextStyle(
                        color: Colors.white.withAlpha(200),
                        fontSize: 14,
                      ),
                    ),
                    Text(
                      autoBackupEnabled ? "Active" : "Inactive",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: Colors.white.withAlpha(40),
                  borderRadius: BorderRadius.circular(radiusLg),
                ),
                child: Text(
                  backupSize,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white.withAlpha(40),
              borderRadius: BorderRadius.circular(radiusMd),
            ),
            child: Column(
              spacing: spXs,
              children: [
                _buildStatusRow("Last backup", "${lastBackup.dMMMy} at ${lastBackup.kkmm}"),
                _buildStatusRow("Next backup", autoBackupEnabled ? "${nextBackup.dMMMy}" : "Manual only"),
                _buildStatusRow("Total backups", "$totalBackups backups"),
                _buildStatusRow("Encryption", encryptBackup ? "Enabled" : "Disabled"),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusRow(String label, String value) {
    return Row(
      children: [
        Text(
          "$label: ",
          style: TextStyle(
            color: Colors.white.withAlpha(200),
            fontSize: 12,
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
              fontSize: 12,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildAutoBackupSettings() {
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
              Icon(Icons.schedule, color: primaryColor),
              SizedBox(width: spSm),
              Text(
                "Automatic Backup",
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
                child: QSwitch(
                  items: [
                    {
                      "label": "Enable automatic backup",
                      "value": true,
                      "checked": autoBackupEnabled,
                    }
                  ],
                  value: autoBackupEnabled ? [{"label": "Enable automatic backup", "value": true, "checked": true}] : [],
                  onChanged: (values, ids) {
                    autoBackupEnabled = values.isNotEmpty;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
          if (autoBackupEnabled) ...[
            QDropdownField(
              label: "Backup Frequency",
              items: [
                {"label": "Daily", "value": "daily"},
                {"label": "Weekly", "value": "weekly"},
                {"label": "Monthly", "value": "monthly"},
              ],
              value: backupFrequency,
              onChanged: (value, label) {
                backupFrequency = value;
                setState(() {});
              },
            ),
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: infoColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusSm),
                border: Border.all(color: infoColor.withAlpha(100)),
              ),
              child: Row(
                children: [
                  Icon(Icons.info, color: infoColor, size: 20),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Text(
                      "Backups will be performed automatically based on your selected frequency.",
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
        ],
      ),
    );
  }

  Widget _buildBackupContentSettings() {
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
              Icon(Icons.folder, color: primaryColor),
              SizedBox(width: spSm),
              Text(
                "Backup Content",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          Text(
            "Choose what data to include in your backups",
            style: TextStyle(
              color: disabledBoldColor,
              fontSize: 12,
            ),
          ),
          Column(
            spacing: spXs,
            children: [
              _buildContentSetting(
                "Order History",
                "All your past orders and receipts",
                includeOrderHistory,
                (value) {
                  includeOrderHistory = value;
                  setState(() {});
                },
                Icons.receipt,
              ),
              _buildContentSetting(
                "Payment Methods",
                "Saved cards and payment info",
                includePaymentMethods,
                (value) {
                  includePaymentMethods = value;
                  setState(() {});
                },
                Icons.payment,
              ),
              _buildContentSetting(
                "Favorites & Wishlist",
                "Saved restaurants and favorite items",
                includeFavorites,
                (value) {
                  includeFavorites = value;
                  setState(() {});
                },
                Icons.favorite,
              ),
              _buildContentSetting(
                "Delivery Addresses",
                "Home, work, and other saved addresses",
                includeAddresses,
                (value) {
                  includeAddresses = value;
                  setState(() {});
                },
                Icons.location_on,
              ),
              _buildContentSetting(
                "App Preferences",
                "Settings, notifications, and preferences",
                includePreferences,
                (value) {
                  includePreferences = value;
                  setState(() {});
                },
                Icons.settings,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildContentSetting(String title, String subtitle, bool value, Function(bool) onChanged, IconData icon) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: value ? primaryColor.withAlpha(20) : Colors.grey.withAlpha(20),
        borderRadius: BorderRadius.circular(radiusSm),
        border: value ? Border.all(color: primaryColor.withAlpha(100)) : null,
      ),
      child: Row(
        children: [
          Icon(
            icon,
            color: value ? primaryColor : disabledBoldColor,
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
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 12,
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

  Widget _buildCloudStorageSettings() {
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
              Icon(Icons.cloud, color: primaryColor),
              SizedBox(width: spSm),
              Text(
                "Cloud Storage",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          QDropdownField(
            label: "Cloud Provider",
            items: [
              {"label": "Google Drive", "value": "google"},
              {"label": "iCloud", "value": "icloud"},
              {"label": "Dropbox", "value": "dropbox"},
              {"label": "OneDrive", "value": "onedrive"},
            ],
            value: cloudProvider,
            onChanged: (value, label) {
              cloudProvider = value;
              setState(() {});
            },
          ),
          Row(
            children: [
              Expanded(
                child: QSwitch(
                  items: [
                    {
                      "label": "Encrypt backup data",
                      "value": true,
                      "checked": encryptBackup,
                    }
                  ],
                  value: encryptBackup ? [{"label": "Encrypt backup data", "value": true, "checked": true}] : [],
                  onChanged: (values, ids) {
                    encryptBackup = values.isNotEmpty;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.grey.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Column(
              spacing: spXs,
              children: [
                Row(
                  children: [
                    Icon(Icons.storage, size: 16, color: disabledBoldColor),
                    SizedBox(width: spSm),
                    Text(
                      "Storage Info",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
                _buildStorageRow("Used space", "25.4 MB"),
                _buildStorageRow("Available space", "14.6 GB"),
                _buildStorageRow("Total backups", "$totalBackups"),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStorageRow(String label, String value) {
    return Row(
      children: [
        Text(
          "$label: ",
          style: TextStyle(
            fontSize: 12,
            color: disabledBoldColor,
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: TextStyle(
              fontSize: 12,
              color: primaryColor,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBackupHistorySection() {
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
              Icon(Icons.history, color: primaryColor),
              SizedBox(width: spSm),
              Expanded(
                child: Text(
                  "Backup History",
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
                onPressed: () {
                  // navigateTo(FullBackupHistoryView())
                },
              ),
            ],
          ),
          Column(
            spacing: spXs,
            children: backupHistory.take(3).map((backup) => _buildBackupHistoryItem(backup)).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildBackupHistoryItem(Map<String, dynamic> backup) {
    final DateTime date = backup["date"];
    final String status = backup["status"];
    final Color statusColor = status == "Completed" ? successColor : 
                             status == "Failed" ? dangerColor : warningColor;

    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.grey.withAlpha(20),
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Row(
        children: [
          Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              color: statusColor,
              shape: BoxShape.circle,
            ),
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      "${date.dMMMy}",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(width: spSm),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                      decoration: BoxDecoration(
                        color: statusColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Text(
                        "${backup["type"]}",
                        style: TextStyle(
                          fontSize: 10,
                          color: statusColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      "${backup["size"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    if (status == "Completed") ...[
                      Text(
                        " • ${backup["items"]} items",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ],
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
            decoration: BoxDecoration(
              color: statusColor.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusXs),
            ),
            child: Text(
              status,
              style: TextStyle(
                fontSize: 10,
                color: statusColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRestoreSection() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: warningColor.withAlpha(20),
        borderRadius: BorderRadius.circular(radiusMd),
        border: Border.all(color: warningColor.withAlpha(100)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Row(
            children: [
              Icon(Icons.restore, color: warningColor),
              SizedBox(width: spSm),
              Text(
                "Restore Data",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: warningColor,
                ),
              ),
            ],
          ),
          Text(
            "Restore your data from a previous backup. This will replace your current data.",
            style: TextStyle(
              color: warningColor,
              fontSize: 12,
            ),
          ),
          Row(
            children: [
              Expanded(
                child: QButton(
                  label: "Restore from Latest",
                  size: bs.sm,
                  onPressed: () {
                    _restoreFromBackup(backupHistory.first);
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QButton(
                  label: "Choose Backup",
                  size: bs.sm,
                  onPressed: _chooseBackupToRestore,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons() {
    return Column(
      spacing: spSm,
      children: [
        Container(
          width: double.infinity,
          child: QButton(
            label: isBackingUp ? "Backing up..." : "Backup Now",
            onPressed: isBackingUp ? null : _performManualBackup,
          ),
        ),
        Row(
          children: [
            Expanded(
              child: QButton(
                label: "Export Data",
                size: bs.sm,
                onPressed: _exportData,
              ),
            ),
            SizedBox(width: spSm),
            Expanded(
              child: QButton(
                label: "Import Data",
                size: bs.sm,
                onPressed: _importData,
              ),
            ),
          ],
        ),
      ],
    );
  }

  void _performManualBackup() async {
    setState(() {
      isBackingUp = true;
    });

    showLoading();

    // Simulate backup process
    await Future.delayed(Duration(seconds: 3));

    hideLoading();

    setState(() {
      isBackingUp = false;
      lastBackup = DateTime.now();
      
      // Add to backup history
      backupHistory.insert(0, {
        "date": DateTime.now(),
        "size": "25.6 MB",
        "type": "Manual",
        "status": "Completed",
        "items": 1251
      });
    });

    ss("Manual backup completed successfully!");
  }

  void _restoreFromBackup(Map<String, dynamic> backup) async {
    bool isConfirmed = await confirm("This will replace all your current data with the backup from ${(backup["date"] as DateTime).dMMMy}. Continue?");
    
    if (isConfirmed) {
      setState(() {
        isRestoring = true;
      });

      showLoading();

      // Simulate restore process
      await Future.delayed(Duration(seconds: 4));

      hideLoading();

      setState(() {
        isRestoring = false;
      });

      ss("Data restored successfully from backup!");
    }
  }

  void _chooseBackupToRestore() {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(radiusLg)),
      ),
      builder: (context) => Container(
        padding: EdgeInsets.all(spMd),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          spacing: spSm,
          children: [
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: disabledColor,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            Text(
              "Choose Backup to Restore",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spSm),
            ...backupHistory.where((b) => b["status"] == "Completed").map((backup) => 
              ListTile(
                leading: Icon(Icons.backup, color: primaryColor),
                title: Text("${(backup["date"] as DateTime).dMMMy}"),
                subtitle: Text("${backup["size"]} • ${backup["items"]} items"),
                trailing: Icon(Icons.arrow_forward_ios),
                onTap: () {
                  Navigator.pop(context);
                  _restoreFromBackup(backup);
                },
              ),
            ).toList(),
          ],
        ),
      ),
    );
  }

  void _exportData() {
    ss("Data exported to downloads folder");
  }

  void _importData() {
    // navigateTo(ImportDataView())
  }
}
