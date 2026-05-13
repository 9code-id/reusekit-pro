import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlUpload7View extends StatefulWidget {
  @override
  State<GrlUpload7View> createState() => _GrlUpload7ViewState();
}

class _GrlUpload7ViewState extends State<GrlUpload7View> {
  String selectedPlatform = "ftp";
  String ftpHost = "";
  String ftpUsername = "";
  String ftpPassword = "";
  String ftpPort = "21";
  String ftpDirectory = "/uploads";
  bool useSSL = true;
  bool passiveMode = true;
  String transferMode = "binary";

  List<Map<String, dynamic>> platformItems = [
    {"label": "FTP Server", "value": "ftp"},
    {"label": "SFTP Server", "value": "sftp"},
    {"label": "WebDAV", "value": "webdav"},
    {"label": "Amazon S3", "value": "s3"},
    {"label": "Google Cloud", "value": "gcp"},
  ];

  List<Map<String, dynamic>> transferModeItems = [
    {"label": "Binary", "value": "binary"},
    {"label": "ASCII", "value": "ascii"},
    {"label": "Auto", "value": "auto"},
  ];

  List<Map<String, dynamic>> transferHistory = [
    {
      "name": "project_files.zip",
      "size": "125.4 MB",
      "destination": "ftp://server.company.com/uploads/",
      "status": "completed",
      "duration": "2m 34s",
      "speed": "850 KB/s",
      "timestamp": "2 hours ago"
    },
    {
      "name": "backup_database.sql",
      "size": "45.7 MB",
      "destination": "sftp://backup.server.com/db/",
      "status": "completed",
      "duration": "1m 12s",
      "speed": "630 KB/s",
      "timestamp": "5 hours ago"
    },
    {
      "name": "media_assets/",
      "size": "2.1 GB",
      "destination": "s3://my-bucket/assets/",
      "status": "failed",
      "duration": "12m 45s",
      "speed": "2.8 MB/s",
      "timestamp": "1 day ago"
    },
    {
      "name": "documents.tar.gz",
      "size": "78.9 MB",
      "destination": "webdav://cloud.example.com/docs/",
      "status": "uploading",
      "duration": "3m 21s",
      "speed": "1.2 MB/s",
      "timestamp": "Now"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Server Upload"),
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: spMd,
          children: [
            // Server Status
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    infoColor,
                    infoColor.withAlpha(180),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(radiusLg),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spMd,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.dns,
                        color: Colors.white,
                        size: 28,
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Text(
                          "Server Connection",
                          style: TextStyle(
                            fontSize: fsH5,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: spSm,
                          vertical: spXs,
                        ),
                        decoration: BoxDecoration(
                          color: successColor,
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Text(
                          "CONNECTED",
                          style: TextStyle(
                            fontSize: 10,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "1.2 MB/s",
                              style: TextStyle(
                                fontSize: fsH4,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              "Upload Speed",
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.white.withAlpha(200),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "247",
                              style: TextStyle(
                                fontSize: fsH4,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              "Files Uploaded",
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.white.withAlpha(200),
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

            // Server Configuration
            Text(
              "Server Configuration",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
              ),
            ),

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
                    label: "Platform Type",
                    items: platformItems,
                    value: selectedPlatform,
                    onChanged: (value, label) {
                      selectedPlatform = value;
                      setState(() {});
                    },
                  ),

                  QTextField(
                    label: "Host/Server Address",
                    value: ftpHost,
                    hint: "ftp.example.com or 192.168.1.100",
                    onChanged: (value) {
                      ftpHost = value;
                      setState(() {});
                    },
                  ),

                  Row(
                    spacing: spSm,
                    children: [
                      Expanded(
                        flex: 3,
                        child: QTextField(
                          label: "Username",
                          value: ftpUsername,
                          onChanged: (value) {
                            ftpUsername = value;
                            setState(() {});
                          },
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: QTextField(
                          label: "Port",
                          value: ftpPort,
                          onChanged: (value) {
                            ftpPort = value;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),

                  QTextField(
                    label: "Password",
                    value: ftpPassword,
                    obscureText: true,
                    onChanged: (value) {
                      ftpPassword = value;
                      setState(() {});
                    },
                  ),

                  QTextField(
                    label: "Remote Directory",
                    value: ftpDirectory,
                    hint: "/uploads or /var/www/files",
                    onChanged: (value) {
                      ftpDirectory = value;
                      setState(() {});
                    },
                  ),

                  QDropdownField(
                    label: "Transfer Mode",
                    items: transferModeItems,
                    value: transferMode,
                    onChanged: (value, label) {
                      transferMode = value;
                      setState(() {});
                    },
                  ),

                  Row(
                    children: [
                      Expanded(
                        child: QSwitch(
                          items: [
                            {
                              "label": "Use SSL/TLS",
                              "value": true,
                              "checked": useSSL,
                            }
                          ],
                          value: [
                            if (useSSL)
                              {
                                "label": "Use SSL/TLS",
                                "value": true,
                                "checked": true
                              }
                          ],
                          onChanged: (values, ids) {
                            useSSL = values.isNotEmpty;
                            setState(() {});
                          },
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
                              "label": "Passive Mode",
                              "value": true,
                              "checked": passiveMode,
                            }
                          ],
                          value: [
                            if (passiveMode)
                              {
                                "label": "Passive Mode",
                                "value": true,
                                "checked": true
                              }
                          ],
                          onChanged: (values, ids) {
                            passiveMode = values.isNotEmpty;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Test Connection Button
            Container(
              width: double.infinity,
              child: QButton(
                label: "Test Connection",
                color: warningColor,
                size: bs.md,
                onPressed: () {},
              ),
            ),

            // Transfer History
            Text(
              "Transfer History",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
              ),
            ),

            ...transferHistory.map((transfer) => Container(
              margin: EdgeInsets.only(bottom: spSm),
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
                border: Border.all(
                  color: _getTransferStatusColor(transfer["status"]).withAlpha(50),
                ),
              ),
              child: Column(
                spacing: spSm,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: _getTransferStatusColor(transfer["status"]).withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Icon(
                          _getTransferStatusIcon(transfer["status"]),
                          color: _getTransferStatusColor(transfer["status"]),
                          size: 20,
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${transfer["name"]}",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              "${transfer["size"]} • ${transfer["timestamp"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: spSm,
                          vertical: spXs,
                        ),
                        decoration: BoxDecoration(
                          color: _getTransferStatusColor(transfer["status"]),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Text(
                          "${transfer["status"]}".toUpperCase(),
                          style: TextStyle(
                            fontSize: 10,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: disabledColor.withAlpha(50),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Column(
                      spacing: spXs,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.cloud_upload,
                              size: 14,
                              color: disabledBoldColor,
                            ),
                            SizedBox(width: spXs),
                            Expanded(
                              child: Text(
                                "${transfer["destination"]}",
                                style: TextStyle(
                                  fontSize: 11,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Duration: ${transfer["duration"]}",
                              style: TextStyle(
                                fontSize: 11,
                                color: disabledBoldColor,
                              ),
                            ),
                            Text(
                              "Speed: ${transfer["speed"]}",
                              style: TextStyle(
                                fontSize: 11,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  if (transfer["status"] == "uploading") ...[
                    LinearProgressIndicator(
                      backgroundColor: disabledColor,
                      valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
                    ),
                  ],
                ],
              ),
            )),

            // Action Buttons
            Row(
              spacing: spSm,
              children: [
                Expanded(
                  child: QButton(
                    label: "Select Files",
                    color: secondaryColor,
                    size: bs.md,
                    onPressed: () {},
                  ),
                ),
                Expanded(
                  child: QButton(
                    label: "Start Upload",
                    size: bs.md,
                    onPressed: () {},
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Color _getTransferStatusColor(String status) {
    switch (status) {
      case "completed":
        return successColor;
      case "uploading":
        return primaryColor;
      case "failed":
        return dangerColor;
      case "queued":
        return warningColor;
      default:
        return disabledBoldColor;
    }
  }

  IconData _getTransferStatusIcon(String status) {
    switch (status) {
      case "completed":
        return Icons.check_circle;
      case "uploading":
        return Icons.cloud_upload;
      case "failed":
        return Icons.error;
      case "queued":
        return Icons.schedule;
      default:
        return Icons.help;
    }
  }
}
