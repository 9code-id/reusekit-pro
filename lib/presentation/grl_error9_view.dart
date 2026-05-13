import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlError9View extends StatefulWidget {
  @override
  State<GrlError9View> createState() => _GrlError9ViewState();
}

class _GrlError9ViewState extends State<GrlError9View> {
  String storageUsed = "15.8 GB";
  String storageTotal = "16 GB";
  double usagePercentage = 0.98;
  
  List<Map<String, dynamic>> storageBreakdown = [
    {
      "type": "Photos & Videos",
      "size": "8.2 GB",
      "percentage": 0.51,
      "color": successColor,
      "icon": Icons.photo_library,
    },
    {
      "type": "App Data",
      "size": "3.1 GB", 
      "percentage": 0.19,
      "color": primaryColor,
      "icon": Icons.apps,
    },
    {
      "type": "Cache Files",
      "size": "2.8 GB",
      "percentage": 0.18,
      "color": warningColor,
      "icon": Icons.cached,
    },
    {
      "type": "Documents",
      "size": "1.2 GB",
      "percentage": 0.08,
      "color": infoColor,
      "icon": Icons.description,
    },
    {
      "type": "Other",
      "size": "0.5 GB",
      "percentage": 0.03,
      "color": disabledBoldColor,
      "icon": Icons.folder,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Storage Full"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          children: [
            // Storage Full Illustration
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spXl),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    dangerColor.withAlpha(20),
                    Colors.white,
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
                borderRadius: BorderRadius.circular(radiusLg),
              ),
              child: Column(
                children: [
                  Icon(
                    Icons.sd_storage,
                    size: 72,
                    color: dangerColor,
                  ),
                  SizedBox(height: spMd),
                  Text(
                    "Storage Full",
                    style: TextStyle(
                      fontSize: fsH3,
                      fontWeight: FontWeight.bold,
                      color: dangerColor,
                    ),
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "Your device is running out of space",
                    style: TextStyle(
                      fontSize: 16,
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ),
            ),
            
            SizedBox(height: spMd),
            
            // Storage Usage Overview
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
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.pie_chart,
                        size: 20,
                        color: primaryColor,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "Storage Usage",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  
                  SizedBox(height: spMd),
                  
                  // Usage Progress
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "$storageUsed used of $storageTotal",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),
                      Text(
                        "${(usagePercentage * 100).toStringAsFixed(0)}%",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: dangerColor,
                        ),
                      ),
                    ],
                  ),
                  
                  SizedBox(height: spSm),
                  
                  Container(
                    height: 12,
                    decoration: BoxDecoration(
                      color: disabledColor,
                      borderRadius: BorderRadius.circular(radiusLg),
                    ),
                    child: FractionallySizedBox(
                      alignment: Alignment.centerLeft,
                      widthFactor: usagePercentage,
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [warningColor, dangerColor],
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                          ),
                          borderRadius: BorderRadius.circular(radiusLg),
                        ),
                      ),
                    ),
                  ),
                  
                  SizedBox(height: spMd),
                  
                  // Warning Message
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: dangerColor.withAlpha(10),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.warning_amber,
                          size: 16,
                          color: dangerColor,
                        ),
                        SizedBox(width: spXs),
                        Expanded(
                          child: Text(
                            "Only ${((1 - usagePercentage) * 16).toStringAsFixed(1)} GB remaining",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: dangerColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            
            SizedBox(height: spMd),
            
            // Storage Breakdown
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.analytics,
                        size: 20,
                        color: primaryColor,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "Storage Breakdown",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  
                  SizedBox(height: spMd),
                  
                  ...storageBreakdown.map((item) => Container(
                    margin: EdgeInsets.only(bottom: spSm),
                    child: Row(
                      children: [
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: (item["color"] as Color).withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Icon(
                            item["icon"] as IconData,
                            size: 20,
                            color: item["color"] as Color,
                          ),
                        ),
                        SizedBox(width: spMd),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${item["type"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(height: 2),
                              Container(
                                height: 4,
                                decoration: BoxDecoration(
                                  color: disabledColor,
                                  borderRadius: BorderRadius.circular(radius2xl),
                                ),
                                child: FractionallySizedBox(
                                  alignment: Alignment.centerLeft,
                                  widthFactor: item["percentage"] as double,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: item["color"] as Color,
                                      borderRadius: BorderRadius.circular(radius2xl),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: spMd),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              "${item["size"]}",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: item["color"] as Color,
                              ),
                            ),
                            Text(
                              "${((item["percentage"] as double) * 100).toStringAsFixed(0)}%",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  )).toList(),
                ],
              ),
            ),
            
            SizedBox(height: spMd),
            
            // Quick Actions
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.cleaning_services,
                        size: 20,
                        color: successColor,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "Quick Cleanup",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: successColor,
                        ),
                      ),
                    ],
                  ),
                  
                  SizedBox(height: spMd),
                  
                  Row(
                    children: [
                      Expanded(
                        child: _buildCleanupAction(
                          "Clear Cache",
                          "2.8 GB",
                          Icons.cached,
                          warningColor,
                          () {
                            ss("Cache cleared - 2.8 GB freed");
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: _buildCleanupAction(
                          "Delete Temp",
                          "0.9 GB",
                          Icons.delete_sweep,
                          infoColor,
                          () {
                            ss("Temporary files deleted - 0.9 GB freed");
                          },
                        ),
                      ),
                    ],
                  ),
                  
                  SizedBox(height: spSm),
                  
                  Row(
                    children: [
                      Expanded(
                        child: _buildCleanupAction(
                          "Optimize",
                          "1.2 GB",
                          Icons.tune,
                          primaryColor,
                          () {
                            si("Storage optimized - 1.2 GB freed");
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: _buildCleanupAction(
                          "Backup & Delete",
                          "3.1 GB",
                          Icons.backup,
                          successColor,
                          () {
                            si("Files backed up and deleted - 3.1 GB freed");
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            
            SizedBox(height: spMd),
            
            // Storage Recommendations
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: infoColor.withAlpha(10),
                borderRadius: BorderRadius.circular(radiusLg),
                border: Border.all(
                  color: infoColor.withAlpha(30),
                  width: 1,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.lightbulb_outline,
                        size: 20,
                        color: infoColor,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "Storage Tips",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: infoColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spMd),
                  
                  _buildTipItem("Move photos and videos to cloud storage", Icons.cloud_upload),
                  _buildTipItem("Uninstall unused apps and games", Icons.delete_outline),
                  _buildTipItem("Delete old downloads and documents", Icons.file_download_off),
                  _buildTipItem("Use streaming instead of downloading", Icons.stream),
                  _buildTipItem("Enable automatic cloud backup", Icons.backup),
                ],
              ),
            ),
            
            SizedBox(height: spMd),
            
            // Action Buttons
            Column(
              children: [
                Container(
                  width: double.infinity,
                  child: QButton(
                    label: "Free Up Space Now",
                    size: bs.md,
                    onPressed: () {
                      // navigateTo(StorageCleanupView());
                    },
                  ),
                ),
                
                SizedBox(height: spMd),
                
                Container(
                  width: double.infinity,
                  child: QButton(
                    label: "Manage Storage Settings",
                    size: bs.md,
                    onPressed: () {
                      // navigateTo(StorageSettingsView());
                    },
                  ),
                ),
              ],
            ),
            
            SizedBox(height: spMd),
            
            // Upgrade Storage Option
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    primaryColor.withAlpha(10),
                    primaryColor.withAlpha(30),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(radiusLg),
                border: Border.all(
                  color: primaryColor.withAlpha(50),
                  width: 1,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.upgrade,
                        size: 20,
                        color: primaryColor,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "Upgrade Storage",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spMd),
                  Text(
                    "Get more storage space with cloud storage plans starting from \$2.99/month. Never worry about running out of space again!",
                    style: TextStyle(
                      fontSize: 14,
                      color: disabledBoldColor,
                      height: 1.4,
                    ),
                  ),
                  SizedBox(height: spMd),
                  Container(
                    width: double.infinity,
                    child: QButton(
                      label: "View Storage Plans",
                      size: bs.sm,
                      onPressed: () {
                        // navigateTo(StoragePlansView());
                      },
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

  Widget _buildCleanupAction(String title, String size, IconData icon, Color color, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(spMd),
        decoration: BoxDecoration(
          color: color.withAlpha(10),
          borderRadius: BorderRadius.circular(radiusLg),
          border: Border.all(
            color: color.withAlpha(30),
            width: 1,
          ),
        ),
        child: Column(
          children: [
            Icon(
              icon,
              size: 28,
              color: color,
            ),
            SizedBox(height: spSm),
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: color,
              ),
            ),
            Text(
              size,
              style: TextStyle(
                fontSize: 10,
                color: disabledBoldColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTipItem(String tip, IconData icon) {
    return Padding(
      padding: EdgeInsets.only(bottom: spSm),
      child: Row(
        children: [
          Icon(
            icon,
            size: 16,
            color: infoColor,
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Text(
              tip,
              style: TextStyle(
                fontSize: 14,
                color: disabledBoldColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
