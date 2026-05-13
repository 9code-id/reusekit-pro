import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlScanner8View extends StatefulWidget {
  @override
  State<GrlScanner8View> createState() => _GrlScanner8ViewState();
}

class _GrlScanner8ViewState extends State<GrlScanner8View> {
  bool soundEnabled = true;
  bool vibrationEnabled = true;
  bool autoSave = true;
  bool continuousMode = false;
  bool flashAutoMode = true;
  double scanDelay = 1.0;
  String defaultFormat = "QR Code";
  String saveLocation = "Gallery";
  
  List<Map<String, dynamic>> formatOptions = [
    {"label": "QR Code", "value": "QR"},
    {"label": "Barcode", "value": "Barcode"},
    {"label": "Both", "value": "Both"},
  ];
  
  List<Map<String, dynamic>> saveOptions = [
    {"label": "Gallery", "value": "Gallery"},
    {"label": "Documents", "value": "Documents"},
    {"label": "Cloud Storage", "value": "Cloud"},
  ];
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Scanner Settings"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            // General Settings
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowMd],
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
                  
                  // Sound Toggle
                  Row(
                    children: [
                      Icon(
                        Icons.volume_up,
                        color: primaryColor,
                        size: 24,
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Sound",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              "Play sound when scanning",
                              style: TextStyle(
                                fontSize: 14,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Switch(
                        value: soundEnabled,
                        activeColor: primaryColor,
                        onChanged: (value) {
                          setState(() {
                            soundEnabled = value;
                          });
                        },
                      ),
                    ],
                  ),
                  
                  Divider(),
                  
                  // Vibration Toggle
                  Row(
                    children: [
                      Icon(
                        Icons.vibration,
                        color: primaryColor,
                        size: 24,
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Vibration",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              "Vibrate when scanning",
                              style: TextStyle(
                                fontSize: 14,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Switch(
                        value: vibrationEnabled,
                        activeColor: primaryColor,
                        onChanged: (value) {
                          setState(() {
                            vibrationEnabled = value;
                          });
                        },
                      ),
                    ],
                  ),
                  
                  Divider(),
                  
                  // Auto Save Toggle
                  Row(
                    children: [
                      Icon(
                        Icons.save,
                        color: primaryColor,
                        size: 24,
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Auto Save",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              "Automatically save scan results",
                              style: TextStyle(
                                fontSize: 14,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Switch(
                        value: autoSave,
                        activeColor: primaryColor,
                        onChanged: (value) {
                          setState(() {
                            autoSave = value;
                          });
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
            
            // Scanning Behavior
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowMd],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spSm,
                children: [
                  Text(
                    "Scanning Behavior",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  
                  // Continuous Mode
                  Row(
                    children: [
                      Icon(
                        Icons.repeat,
                        color: primaryColor,
                        size: 24,
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Continuous Mode",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              "Keep scanning without stopping",
                              style: TextStyle(
                                fontSize: 14,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Switch(
                        value: continuousMode,
                        activeColor: primaryColor,
                        onChanged: (value) {
                          setState(() {
                            continuousMode = value;
                          });
                        },
                      ),
                    ],
                  ),
                  
                  Divider(),
                  
                  // Flash Auto Mode
                  Row(
                    children: [
                      Icon(
                        Icons.flash_auto,
                        color: primaryColor,
                        size: 24,
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Auto Flash",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              "Automatically adjust flash in low light",
                              style: TextStyle(
                                fontSize: 14,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Switch(
                        value: flashAutoMode,
                        activeColor: primaryColor,
                        onChanged: (value) {
                          setState(() {
                            flashAutoMode = value;
                          });
                        },
                      ),
                    ],
                  ),
                  
                  Divider(),
                  
                  // Scan Delay
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: spSm,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.timer,
                            color: primaryColor,
                            size: 24,
                          ),
                          SizedBox(width: spSm),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Scan Delay",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Text(
                                  "Delay between scans: ${scanDelay.toStringAsFixed(1)}s",
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
                      Slider(
                        value: scanDelay,
                        min: 0.5,
                        max: 5.0,
                        divisions: 9,
                        activeColor: primaryColor,
                        inactiveColor: disabledColor,
                        onChanged: (value) {
                          setState(() {
                            scanDelay = value;
                          });
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
            
            // Format & Storage
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowMd],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spSm,
                children: [
                  Text(
                    "Format & Storage",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  
                  // Default Format
                  QDropdownField(
                    label: "Default Scan Format",
                    items: formatOptions,
                    value: defaultFormat,
                    onChanged: (value, label) {
                      defaultFormat = value;
                      setState(() {});
                    },
                  ),
                  
                  // Save Location
                  QDropdownField(
                    label: "Save Location",
                    items: saveOptions,
                    value: saveLocation,
                    onChanged: (value, label) {
                      saveLocation = value;
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),
            
            // Privacy & Security
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowMd],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spSm,
                children: [
                  Text(
                    "Privacy & Security",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  
                  _buildSettingItem(
                    Icons.history,
                    "Clear Scan History",
                    "Remove all saved scan results",
                    onTap: () => _clearHistory(),
                  ),
                  
                  Divider(),
                  
                  _buildSettingItem(
                    Icons.security,
                    "Privacy Settings",
                    "Manage data collection and sharing",
                    onTap: () => _showPrivacySettings(),
                  ),
                  
                  Divider(),
                  
                  _buildSettingItem(
                    Icons.backup,
                    "Backup & Sync",
                    "Sync scan data across devices",
                    onTap: () => _showBackupSettings(),
                  ),
                ],
              ),
            ),
            
            // About & Support
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowMd],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spSm,
                children: [
                  Text(
                    "About & Support",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  
                  _buildSettingItem(
                    Icons.info,
                    "App Version",
                    "v2.1.0 (Build 210)",
                    showArrow: false,
                  ),
                  
                  Divider(),
                  
                  _buildSettingItem(
                    Icons.help,
                    "Help & Support",
                    "Get help and contact support",
                    onTap: () => _showHelp(),
                  ),
                  
                  Divider(),
                  
                  _buildSettingItem(
                    Icons.rate_review,
                    "Rate App",
                    "Rate and review on app store",
                    onTap: () => _rateApp(),
                  ),
                ],
              ),
            ),
            
            // Reset Settings
            Container(
              width: double.infinity,
              child: QButton(
                label: "Reset to Default",
                size: bs.md,
                onPressed: () {
                  _resetSettings();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildSettingItem(
    IconData icon,
    String title,
    String subtitle, {
    VoidCallback? onTap,
    bool showArrow = true,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          Icon(
            icon,
            color: primaryColor,
            size: 24,
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
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
          if (showArrow)
            Icon(
              Icons.arrow_forward,
              color: disabledBoldColor,
              size: 20,
            ),
        ],
      ),
    );
  }
  
  void _clearHistory() async {
    bool isConfirmed = await confirm("Are you sure you want to clear all scan history?");
    if (isConfirmed) {
      ss("Scan history cleared");
    }
  }
  
  void _showPrivacySettings() {
    ss("Privacy settings opened");
  }
  
  void _showBackupSettings() {
    ss("Backup settings opened");
  }
  
  void _showHelp() {
    ss("Help center opened");
  }
  
  void _rateApp() {
    ss("App store opened for rating");
  }
  
  void _resetSettings() async {
    bool isConfirmed = await confirm("Reset all settings to default values?");
    if (isConfirmed) {
      setState(() {
        soundEnabled = true;
        vibrationEnabled = true;
        autoSave = true;
        continuousMode = false;
        flashAutoMode = true;
        scanDelay = 1.0;
        defaultFormat = "QR Code";
        saveLocation = "Gallery";
      });
      ss("Settings reset to default");
    }
  }
}
