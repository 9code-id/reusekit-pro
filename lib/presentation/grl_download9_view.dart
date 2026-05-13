import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlDownload9View extends StatefulWidget {
  @override
  State<GrlDownload9View> createState() => _GrlDownload9ViewState();
}

class _GrlDownload9ViewState extends State<GrlDownload9View> {
  bool loading = false;
  int maxConcurrentDownloads = 3;
  double downloadSpeedLimit = 0; // 0 means unlimited
  bool autoRetryFailed = true;
  bool pauseOnLowBattery = false;
  bool downloadOnWifiOnly = false;
  String defaultDownloadLocation = "/Downloads/";
  bool autoOrganizeFiles = true;
  bool enableNotifications = true;
  bool autoDeleteAfterDays = false;
  int deleteAfterDays = 30;
  
  List<Map<String, dynamic>> downloadLocationOptions = [
    {"label": "/Downloads/", "value": "/Downloads/"},
    {"label": "/Documents/", "value": "/Documents/"},
    {"label": "/Desktop/", "value": "/Desktop/"},
    {"label": "/Pictures/", "value": "/Pictures/"},
    {"label": "/Videos/", "value": "/Videos/"},
    {"label": "Custom...", "value": "Custom"},
  ];

  List<Map<String, dynamic>> speedLimitOptions = [
    {"label": "Unlimited", "value": 0},
    {"label": "1 MB/s", "value": 1},
    {"label": "2 MB/s", "value": 2},
    {"label": "5 MB/s", "value": 5},
    {"label": "10 MB/s", "value": 10},
  ];

  Map<String, dynamic> downloadStats = {
    "totalDownloads": 156,
    "successfulDownloads": 148,
    "failedDownloads": 8,
    "totalDataDownloaded": "12.4 GB",
    "averageSpeed": "6.2 MB/s",
    "totalTime": "4h 32m",
  };

  Future<void> _saveSettings() async {
    showLoading();
    await Future.delayed(Duration(seconds: 1));
    hideLoading();
    
    ss("Settings saved successfully");
  }

  Future<void> _resetSettings() async {
    bool isConfirmed = await confirm("Are you sure you want to reset all settings to default values?");
    if (isConfirmed) {
      maxConcurrentDownloads = 3;
      downloadSpeedLimit = 0;
      autoRetryFailed = true;
      pauseOnLowBattery = false;
      downloadOnWifiOnly = false;
      defaultDownloadLocation = "/Downloads/";
      autoOrganizeFiles = true;
      enableNotifications = true;
      autoDeleteAfterDays = false;
      deleteAfterDays = 30;
      
      setState(() {});
      ss("Settings reset to default values");
    }
  }

  Future<void> _clearDownloadHistory() async {
    bool isConfirmed = await confirm("Are you sure you want to clear all download history?");
    if (isConfirmed) {
      ss("Download history cleared");
    }
  }

  Future<void> _exportSettings() async {
    showLoading();
    await Future.delayed(Duration(seconds: 1));
    hideLoading();
    
    ss("Settings exported successfully");
  }

  Future<void> _importSettings() async {
    showLoading();
    await Future.delayed(Duration(seconds: 1));
    hideLoading();
    
    ss("Settings imported successfully");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Download Settings"),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: _saveSettings,
          ),
          IconButton(
            icon: Icon(Icons.more_vert),
            onPressed: () {
              si("More options");
            },
          ),
        ],
      ),
      body: loading ? 
        Center(child: CircularProgressIndicator()) : 
        SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: Column(
            spacing: spMd,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Download Performance Settings
              Container(
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
                          Icons.speed,
                          color: primaryColor,
                          size: 24,
                        ),
                        SizedBox(width: spSm),
                        Text(
                          "Performance Settings",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                    
                    // Max Concurrent Downloads
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Max Concurrent Downloads: $maxConcurrentDownloads",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: primaryColor,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Slider(
                          value: maxConcurrentDownloads.toDouble(),
                          min: 1,
                          max: 10,
                          divisions: 9,
                          onChanged: (value) {
                            maxConcurrentDownloads = value.round();
                            setState(() {});
                          },
                        ),
                        Text(
                          "Number of files that can download simultaneously",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),

                    // Speed Limit
                    QDropdownField(
                      label: "Download Speed Limit",
                      items: speedLimitOptions.map((option) => {
                        "label": option["label"],
                        "value": option["value"],
                      }).toList(),
                      value: downloadSpeedLimit,
                      onChanged: (value, label) {
                        downloadSpeedLimit = value;
                        setState(() {});
                      },
                    ),

                    // Auto Retry Failed Downloads
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Auto Retry Failed Downloads",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: primaryColor,
                                ),
                              ),
                              Text(
                                "Automatically retry downloads that fail",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Switch(
                          value: autoRetryFailed,
                          onChanged: (value) {
                            autoRetryFailed = value;
                            setState(() {});
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Network & Battery Settings
              Container(
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
                          Icons.network_check,
                          color: primaryColor,
                          size: 24,
                        ),
                        SizedBox(width: spSm),
                        Text(
                          "Network & Battery",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),

                    // Download on WiFi Only
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Download on WiFi Only",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: primaryColor,
                                ),
                              ),
                              Text(
                                "Pause downloads when using mobile data",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Switch(
                          value: downloadOnWifiOnly,
                          onChanged: (value) {
                            downloadOnWifiOnly = value;
                            setState(() {});
                          },
                        ),
                      ],
                    ),

                    // Pause on Low Battery
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Pause on Low Battery",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: primaryColor,
                                ),
                              ),
                              Text(
                                "Automatically pause downloads when battery is low",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Switch(
                          value: pauseOnLowBattery,
                          onChanged: (value) {
                            pauseOnLowBattery = value;
                            setState(() {});
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // File Management Settings
              Container(
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
                          Icons.folder_open,
                          color: primaryColor,
                          size: 24,
                        ),
                        SizedBox(width: spSm),
                        Text(
                          "File Management",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),

                    // Default Download Location
                    QDropdownField(
                      label: "Default Download Location",
                      items: downloadLocationOptions,
                      value: defaultDownloadLocation,
                      onChanged: (value, label) {
                        if (value == "Custom") {
                          si("Open folder picker");
                        } else {
                          defaultDownloadLocation = value;
                          setState(() {});
                        }
                      },
                    ),

                    // Auto Organize Files
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Auto Organize Files",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: primaryColor,
                                ),
                              ),
                              Text(
                                "Automatically organize downloads by file type",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Switch(
                          value: autoOrganizeFiles,
                          onChanged: (value) {
                            autoOrganizeFiles = value;
                            setState(() {});
                          },
                        ),
                      ],
                    ),

                    // Auto Delete After Days
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Auto Delete Old Downloads",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: primaryColor,
                                ),
                              ),
                              Text(
                                "Automatically delete downloads after specified days",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Switch(
                          value: autoDeleteAfterDays,
                          onChanged: (value) {
                            autoDeleteAfterDays = value;
                            setState(() {});
                          },
                        ),
                      ],
                    ),

                    if (autoDeleteAfterDays) ...[
                      QNumberField(
                        label: "Delete After (Days)",
                        value: deleteAfterDays.toString(),
                        onChanged: (value) {
                          deleteAfterDays = int.tryParse(value) ?? 30;
                          setState(() {});
                        },
                      ),
                    ],
                  ],
                ),
              ),

              // Notification Settings
              Container(
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
                          Icons.notifications,
                          color: primaryColor,
                          size: 24,
                        ),
                        SizedBox(width: spSm),
                        Text(
                          "Notifications",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),

                    // Enable Notifications
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Enable Download Notifications",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: primaryColor,
                                ),
                              ),
                              Text(
                                "Show notifications when downloads complete",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Switch(
                          value: enableNotifications,
                          onChanged: (value) {
                            enableNotifications = value;
                            setState(() {});
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Download Statistics
              Container(
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
                          Icons.bar_chart,
                          color: primaryColor,
                          size: 24,
                        ),
                        SizedBox(width: spSm),
                        Text(
                          "Download Statistics",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),

                    ResponsiveGridView(
                      padding: EdgeInsets.zero,
                      minItemWidth: 150,
                      children: [
                        Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: infoColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Column(
                            children: [
                              Text(
                                "${downloadStats["totalDownloads"]}",
                                style: TextStyle(
                                  fontSize: fsH4,
                                  fontWeight: FontWeight.bold,
                                  color: infoColor,
                                ),
                              ),
                              Text(
                                "Total Downloads",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: successColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Column(
                            children: [
                              Text(
                                "${downloadStats["successfulDownloads"]}",
                                style: TextStyle(
                                  fontSize: fsH4,
                                  fontWeight: FontWeight.bold,
                                  color: successColor,
                                ),
                              ),
                              Text(
                                "Successful",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: dangerColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Column(
                            children: [
                              Text(
                                "${downloadStats["failedDownloads"]}",
                                style: TextStyle(
                                  fontSize: fsH4,
                                  fontWeight: FontWeight.bold,
                                  color: dangerColor,
                                ),
                              ),
                              Text(
                                "Failed",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: warningColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Column(
                            children: [
                              Text(
                                "${downloadStats["totalDataDownloaded"]}",
                                style: TextStyle(
                                  fontSize: fsH4,
                                  fontWeight: FontWeight.bold,
                                  color: warningColor,
                                ),
                              ),
                              Text(
                                "Total Data",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: primaryColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Column(
                            children: [
                              Text(
                                "${downloadStats["averageSpeed"]}",
                                style: TextStyle(
                                  fontSize: fsH4,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                              Text(
                                "Avg Speed",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: secondaryColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Column(
                            children: [
                              Text(
                                "${downloadStats["totalTime"]}",
                                style: TextStyle(
                                  fontSize: fsH4,
                                  fontWeight: FontWeight.bold,
                                  color: secondaryColor,
                                ),
                              ),
                              Text(
                                "Total Time",
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
                  ],
                ),
              ),

              // Action Buttons
              Container(
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
                    Text(
                      "Actions",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: QButton(
                            label: "Save Settings",
                            size: bs.sm,
                            icon: Icons.save,
                            onPressed: _saveSettings,
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: QButton(
                            label: "Reset to Default",
                            size: bs.sm,
                            icon: Icons.restore,
                            onPressed: _resetSettings,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: QButton(
                            label: "Export Settings",
                            size: bs.sm,
                            icon: Icons.file_upload,
                            onPressed: _exportSettings,
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: QButton(
                            label: "Import Settings",
                            size: bs.sm,
                            icon: Icons.file_download,
                            onPressed: _importSettings,
                          ),
                        ),
                      ],
                    ),
                    Container(
                      width: double.infinity,
                      child: QButton(
                        label: "Clear Download History",
                        size: bs.sm,
                        icon: Icons.clear_all,
                        onPressed: _clearDownloadHistory,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
    );
  }
}
