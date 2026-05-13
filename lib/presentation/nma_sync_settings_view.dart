import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class NmaSyncSettingsView extends StatefulWidget {
  const NmaSyncSettingsView({super.key});

  @override
  State<NmaSyncSettingsView> createState() => _NmaSyncSettingsViewState();
}

class _NmaSyncSettingsViewState extends State<NmaSyncSettingsView> {
  bool autoSync = true;
  bool wifiOnlySync = true;
  bool syncBookmarks = true;
  bool syncReadingHistory = true;
  bool syncPreferences = true;
  bool syncOfflineArticles = false;
  bool backgroundSync = true;
  
  String syncFrequency = "Every 6 hours";
  String syncQuality = "Standard";
  String lastSyncTime = "2024-12-16 14:30";
  String syncAccount = "john.doe@email.com";
  
  int syncedArticles = 1247;
  int syncedBookmarks = 89;
  int pendingSync = 12;
  
  List<Map<String, dynamic>> syncHistory = [
    {
      "id": 1,
      "type": "Full Sync",
      "timestamp": "2024-12-16T14:30:00Z",
      "status": "completed",
      "itemsCount": 156,
      "duration": "2m 34s",
      "dataTransferred": "4.2 MB"
    },
    {
      "id": 2,
      "type": "Bookmarks",
      "timestamp": "2024-12-16T12:15:00Z",
      "status": "completed",
      "itemsCount": 8,
      "duration": "15s",
      "dataTransferred": "128 KB"
    },
    {
      "id": 3,
      "type": "Reading History",
      "timestamp": "2024-12-16T10:45:00Z",
      "status": "completed",
      "itemsCount": 23,
      "duration": "1m 12s",
      "dataTransferred": "890 KB"
    },
    {
      "id": 4,
      "type": "Auto Sync",
      "timestamp": "2024-12-16T08:30:00Z",
      "status": "failed",
      "itemsCount": 0,
      "duration": "0s",
      "dataTransferred": "0 B",
      "error": "Network connection timeout"
    },
    {
      "id": 5,
      "type": "Preferences",
      "timestamp": "2024-12-15T22:20:00Z",
      "status": "completed",
      "itemsCount": 5,
      "duration": "8s",
      "dataTransferred": "45 KB"
    }
  ];

  List<String> frequencyOptions = ["Real-time", "Every hour", "Every 3 hours", "Every 6 hours", "Every 12 hours", "Daily", "Manual only"];
  List<String> qualityOptions = ["Basic", "Standard", "High", "Ultra"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sync Settings"),
        actions: [
          IconButton(
            icon: Icon(Icons.sync),
            onPressed: () {
              _syncNow();
            },
          ),
          IconButton(
            icon: Icon(Icons.history),
            onPressed: () {
              _showSyncHistory();
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Sync Status Card
            Container(
              width: double.infinity,
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
                      Icon(Icons.cloud_done, color: successColor, size: 24),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Sync Status",
                              style: TextStyle(
                                fontSize: fsH6,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              "Last synced: $lastSyncTime",
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
                          color: successColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Text(
                          "UP TO DATE",
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                            color: successColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spMd),
                  Row(
                    children: [
                      Expanded(
                        child: _buildSyncStat("Articles", "$syncedArticles", Icons.article),
                      ),
                      Expanded(
                        child: _buildSyncStat("Bookmarks", "$syncedBookmarks", Icons.bookmark),
                      ),
                      Expanded(
                        child: _buildSyncStat("Pending", "$pendingSync", Icons.pending_actions),
                      ),
                    ],
                  ),
                  SizedBox(height: spMd),
                  Container(
                    width: double.infinity,
                    child: QButton(
                      label: "Sync Now",
                      size: bs.sm,
                      onPressed: () {
                        _syncNow();
                      },
                    ),
                  ),
                ],
              ),
            ),
            
            SizedBox(height: spMd),

            // Account Information
            Container(
              width: double.infinity,
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
                    "Sync Account",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spSm),
                  Row(
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: primaryColor.withAlpha(20),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(Icons.person, color: primaryColor),
                      ),
                      SizedBox(width: spMd),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              syncAccount,
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              "Premium Account",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      QButton(
                        label: "Change",
                        size: bs.sm,
                        onPressed: () {
                          _changeAccount();
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),

            SizedBox(height: spMd),

            // Sync Settings
            Text(
              "Sync Settings",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spSm),

            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                children: [
                  _buildSwitchTile(
                    "Auto Sync",
                    "Automatically sync data when changes are detected",
                    autoSync,
                    Icons.sync,
                    (value) {
                      autoSync = value;
                      setState(() {});
                    },
                  ),
                  Divider(height: 1),
                  _buildSwitchTile(
                    "WiFi Only",
                    "Only sync when connected to WiFi",
                    wifiOnlySync,
                    Icons.wifi,
                    (value) {
                      wifiOnlySync = value;
                      setState(() {});
                    },
                  ),
                  Divider(height: 1),
                  _buildSwitchTile(
                    "Background Sync",
                    "Allow syncing when app is in background",
                    backgroundSync,
                    Icons.wallpaper,
                    (value) {
                      backgroundSync = value;
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),

            SizedBox(height: spMd),

            // Sync Frequency and Quality
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Padding(
                padding: EdgeInsets.all(spMd),
                child: Column(
                  children: [
                    QDropdownField(
                      label: "Sync Frequency",
                      items: frequencyOptions.map((freq) => {
                        "label": freq,
                        "value": freq,
                      }).toList(),
                      value: syncFrequency,
                      onChanged: (value, label) {
                        syncFrequency = value;
                        setState(() {});
                      },
                    ),
                    SizedBox(height: spMd),
                    QDropdownField(
                      label: "Sync Quality",
                      items: qualityOptions.map((quality) => {
                        "label": quality,
                        "value": quality,
                      }).toList(),
                      value: syncQuality,
                      onChanged: (value, label) {
                        syncQuality = value;
                        setState(() {});
                      },
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: spMd),

            // Data Types to Sync
            Text(
              "Data to Sync",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spSm),

            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                children: [
                  _buildSwitchTile(
                    "Bookmarks",
                    "Sync saved articles and bookmarks",
                    syncBookmarks,
                    Icons.bookmark,
                    (value) {
                      syncBookmarks = value;
                      setState(() {});
                    },
                  ),
                  Divider(height: 1),
                  _buildSwitchTile(
                    "Reading History",
                    "Sync articles you've read and progress",
                    syncReadingHistory,
                    Icons.history,
                    (value) {
                      syncReadingHistory = value;
                      setState(() {});
                    },
                  ),
                  Divider(height: 1),
                  _buildSwitchTile(
                    "Preferences",
                    "Sync app settings and customizations",
                    syncPreferences,
                    Icons.settings,
                    (value) {
                      syncPreferences = value;
                      setState(() {});
                    },
                  ),
                  Divider(height: 1),
                  _buildSwitchTile(
                    "Offline Articles",
                    "Sync downloaded articles across devices",
                    syncOfflineArticles,
                    Icons.offline_pin,
                    (value) {
                      syncOfflineArticles = value;
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),

            SizedBox(height: spMd),

            // Advanced Options
            Container(
              width: double.infinity,
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
                    "Advanced Options",
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
                          label: "Force Full Sync",
                          size: bs.sm,
                          onPressed: () {
                            _forceFullSync();
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QButton(
                          label: "Clear Sync Data",
                          size: bs.sm,
                          onPressed: () {
                            _clearSyncData();
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  Container(
                    width: double.infinity,
                    child: QButton(
                      label: "Reset Sync Settings",
                      size: bs.sm,
                      onPressed: () {
                        _resetSyncSettings();
                      },
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: spMd),

            // Sync Statistics
            Container(
              width: double.infinity,
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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Sync Statistics",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          _showSyncHistory();
                        },
                        child: Text(
                          "View History",
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
                  _buildStatRow("Total Data Synced", "142.5 MB"),
                  SizedBox(height: spSm),
                  _buildStatRow("Last Sync Duration", "2m 34s"),
                  SizedBox(height: spSm),
                  _buildStatRow("Successful Syncs", "156 of 162"),
                  SizedBox(height: spSm),
                  _buildStatRow("Next Scheduled Sync", "20:30 Today"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSyncStat(String label, String value, IconData icon) {
    return Column(
      children: [
        Icon(icon, color: primaryColor, size: 20),
        SizedBox(height: spXs),
        Text(
          value,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: disabledBoldColor,
          ),
        ),
      ],
    );
  }

  Widget _buildSwitchTile(String title, String subtitle, bool value, IconData icon, Function(bool) onChanged) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: spMd, vertical: spSm),
      child: Row(
        children: [
          Icon(icon, color: primaryColor, size: 20),
          SizedBox(width: spMd),
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

  Widget _buildStatRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            color: disabledBoldColor,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: primaryColor,
          ),
        ),
      ],
    );
  }

  void _syncNow() async {
    showLoading();
    await Future.delayed(Duration(seconds: 3));
    hideLoading();
    
    lastSyncTime = DateTime.now().toString().substring(0, 16);
    pendingSync = 0;
    setState(() {});
    
    ss("Sync completed successfully");
  }

  void _showSyncHistory() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Sync History"),
        content: Container(
          width: double.maxFinite,
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: syncHistory.length,
            itemBuilder: (context, index) {
              final sync = syncHistory[index];
              return ListTile(
                leading: Icon(
                  sync["status"] == "completed" ? Icons.check_circle : Icons.error,
                  color: sync["status"] == "completed" ? successColor : dangerColor,
                ),
                title: Text("${sync["type"]}"),
                subtitle: Text("${DateTime.parse(sync["timestamp"]).toString().substring(0, 16)} • ${sync["duration"]}"),
                trailing: Text("${sync["dataTransferred"]}"),
              );
            },
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Close"),
          ),
        ],
      ),
    );
  }

  void _changeAccount() {
    // navigateTo AccountSelectionView
    ss("Opening account selection");
  }

  void _forceFullSync() async {
    bool isConfirmed = await confirm("Force a complete sync of all data? This may take longer than usual.");
    if (isConfirmed) {
      showLoading();
      await Future.delayed(Duration(seconds: 5));
      hideLoading();
      ss("Full sync completed");
    }
  }

  void _clearSyncData() async {
    bool isConfirmed = await confirm("Clear all sync data? This will remove all synced content from this device.");
    if (isConfirmed) {
      showLoading();
      await Future.delayed(Duration(seconds: 2));
      hideLoading();
      ss("Sync data cleared");
    }
  }

  void _resetSyncSettings() async {
    bool isConfirmed = await confirm("Reset all sync settings to default values?");
    if (isConfirmed) {
      autoSync = true;
      wifiOnlySync = true;
      syncBookmarks = true;
      syncReadingHistory = true;
      syncPreferences = true;
      syncOfflineArticles = false;
      backgroundSync = true;
      syncFrequency = "Every 6 hours";
      syncQuality = "Standard";
      setState(() {});
      ss("Sync settings reset to defaults");
    }
  }
}
