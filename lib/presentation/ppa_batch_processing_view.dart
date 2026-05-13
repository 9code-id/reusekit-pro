import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class PpaBatchProcessingView extends StatefulWidget {
  const PpaBatchProcessingView({super.key});

  @override
  State<PpaBatchProcessingView> createState() => _PpaBatchProcessingViewState();
}

class _PpaBatchProcessingViewState extends State<PpaBatchProcessingView> {
  List<Map<String, dynamic>> batchJobs = [
    {
      "id": "batch_001",
      "name": "Wedding Album Processing",
      "status": "Processing",
      "progress": 65,
      "totalPhotos": 150,
      "processedPhotos": 98,
      "startTime": "2024-06-16T10:30:00",
      "estimatedTime": "15 minutes",
      "operations": ["Auto Enhance", "Color Correction", "Noise Reduction"],
    },
    {
      "id": "batch_002", 
      "name": "Birthday Collection",
      "status": "Queued",
      "progress": 0,
      "totalPhotos": 85,
      "processedPhotos": 0,
      "startTime": "2024-06-16T11:00:00",
      "estimatedTime": "12 minutes",
      "operations": ["Auto Enhance", "Face Detection", "Red Eye Removal"],
    },
    {
      "id": "batch_003",
      "name": "Vacation Photos",
      "status": "Completed",
      "progress": 100,
      "totalPhotos": 200,
      "processedPhotos": 200,
      "startTime": "2024-06-16T09:15:00",
      "estimatedTime": "18 minutes",
      "operations": ["Auto Enhance", "Exposure Correction", "Saturation Boost"],
    },
    {
      "id": "batch_004",
      "name": "Portrait Session",
      "status": "Error",
      "progress": 25,
      "totalPhotos": 50,
      "processedPhotos": 12,
      "startTime": "2024-06-16T08:45:00",
      "estimatedTime": "8 minutes",
      "operations": ["Auto Enhance", "Skin Smoothing", "Background Blur"],
    },
  ];

  String selectedOperation = "Auto Enhance";
  bool enableAutoEnhance = true;
  bool enableColorCorrection = false;
  bool enableNoiseReduction = false;
  bool enableFaceDetection = false;

  List<Map<String, dynamic>> operationOptions = [
    {"label": "Auto Enhance", "value": "Auto Enhance"},
    {"label": "Color Correction", "value": "Color Correction"},
    {"label": "Noise Reduction", "value": "Noise Reduction"},
    {"label": "Face Detection", "value": "Face Detection"},
    {"label": "Red Eye Removal", "value": "Red Eye Removal"},
    {"label": "Exposure Correction", "value": "Exposure Correction"},
    {"label": "Saturation Boost", "value": "Saturation Boost"},
    {"label": "Skin Smoothing", "value": "Skin Smoothing"},
    {"label": "Background Blur", "value": "Background Blur"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Batch Processing"),
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              _showBatchSettings();
            },
          ),
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              _showCreateBatchDialog();
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
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: infoColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusMd),
                border: Border.all(color: infoColor.withAlpha(50)),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.batch_prediction,
                    color: infoColor,
                    size: 24,
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Batch Processing Center",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: infoColor,
                          ),
                        ),
                        Text(
                          "Process multiple photos simultaneously with automated enhancements",
                          style: TextStyle(
                            color: disabledBoldColor,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            Row(
              children: [
                Expanded(
                  child: _buildStatCard("Active Jobs", "${batchJobs.where((job) => job["status"] == "Processing").length}", Icons.play_circle, successColor),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: _buildStatCard("Queued", "${batchJobs.where((job) => job["status"] == "Queued").length}", Icons.queue, warningColor),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: _buildStatCard("Completed", "${batchJobs.where((job) => job["status"] == "Completed").length}", Icons.check_circle, primaryColor),
                ),
              ],
            ),

            Text(
              "Processing Queue",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),

            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: batchJobs.length,
              itemBuilder: (context, index) {
                final job = batchJobs[index];
                return _buildBatchJobCard(job);
              },
            ),

            QButton(
              label: "Create New Batch Job",
              size: bs.md,
              icon: Icons.add,
              onPressed: () {
                _showCreateBatchDialog();
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        children: [
          Icon(
            icon,
            color: color,
            size: 28,
          ),
          SizedBox(height: spXs),
          Text(
            value,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          Text(
            title,
            style: TextStyle(
              color: disabledBoldColor,
              fontSize: 12,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildBatchJobCard(Map<String, dynamic> job) {
    Color statusColor = _getStatusColor(job["status"]);
    
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
        border: Border(
          left: BorderSide(
            width: 4,
            color: statusColor,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${job["name"]}",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "Job ID: ${job["id"]}",
                      style: TextStyle(
                        color: disabledBoldColor,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: statusColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Text(
                  "${job["status"]}",
                  style: TextStyle(
                    color: statusColor,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          
          SizedBox(height: spSm),
          
          if (job["status"] == "Processing") ...[
            Row(
              children: [
                Expanded(
                  child: LinearProgressIndicator(
                    value: (job["progress"] as int) / 100,
                    backgroundColor: disabledColor,
                    valueColor: AlwaysStoppedAnimation<Color>(statusColor),
                  ),
                ),
                SizedBox(width: spSm),
                Text(
                  "${job["progress"]}%",
                  style: TextStyle(
                    color: statusColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            SizedBox(height: spXs),
          ],
          
          Row(
            children: [
              Icon(
                Icons.photo,
                color: disabledBoldColor,
                size: 16,
              ),
              SizedBox(width: spXs),
              Text(
                "${job["processedPhotos"]}/${job["totalPhotos"]} photos",
                style: TextStyle(
                  color: disabledBoldColor,
                  fontSize: 14,
                ),
              ),
              Spacer(),
              Icon(
                Icons.schedule,
                color: disabledBoldColor,
                size: 16,
              ),
              SizedBox(width: spXs),
              Text(
                "${job["estimatedTime"]}",
                style: TextStyle(
                  color: disabledBoldColor,
                  fontSize: 14,
                ),
              ),
            ],
          ),
          
          SizedBox(height: spSm),
          
          Wrap(
            spacing: spXs,
            children: (job["operations"] as List).map((operation) {
              return Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: primaryColor.withAlpha(10),
                  borderRadius: BorderRadius.circular(radiusSm),
                  border: Border.all(color: primaryColor.withAlpha(30)),
                ),
                child: Text(
                  operation.toString(),
                  style: TextStyle(
                    color: primaryColor,
                    fontSize: 11,
                  ),
                ),
              );
            }).toList(),
          ),
          
          SizedBox(height: spSm),
          
          Row(
            children: [
              if (job["status"] == "Processing") ...[
                QButton(
                  label: "Pause",
                  size: bs.sm,
                  icon: Icons.pause,
                  onPressed: () {
                    _pauseBatchJob(job["id"]);
                  },
                ),
                SizedBox(width: spSm),
              ],
              if (job["status"] == "Queued") ...[
                QButton(
                  label: "Start",
                  size: bs.sm,
                  icon: Icons.play_arrow,
                  onPressed: () {
                    _startBatchJob(job["id"]);
                  },
                ),
                SizedBox(width: spSm),
              ],
              if (job["status"] == "Error") ...[
                QButton(
                  label: "Retry",
                  size: bs.sm,
                  icon: Icons.refresh,
                  onPressed: () {
                    _retryBatchJob(job["id"]);
                  },
                ),
                SizedBox(width: spSm),
              ],
              QButton(
                label: "Details",
                size: bs.sm,
                icon: Icons.info,
                onPressed: () {
                  _showJobDetails(job);
                },
              ),
              Spacer(),
              GestureDetector(
                onTap: () {
                  _deleteBatchJob(job["id"]);
                },
                child: Icon(
                  Icons.delete,
                  color: dangerColor,
                  size: 20,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "Processing":
        return successColor;
      case "Queued":
        return warningColor;
      case "Completed":
        return primaryColor;
      case "Error":
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  void _showCreateBatchDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Create New Batch Job"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("Select photos and operations to create a new batch processing job."),
              SizedBox(height: spSm),
              QDropdownField(
                label: "Default Operation",
                items: operationOptions,
                value: selectedOperation,
                onChanged: (value, label) {
                  selectedOperation = value;
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("Cancel"),
            ),
            QButton(
              label: "Create",
              size: bs.sm,
              onPressed: () {
                Navigator.pop(context);
                ss("New batch job created successfully!");
              },
            ),
          ],
        );
      },
    );
  }

  void _showBatchSettings() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Batch Processing Settings"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              QSwitch(
                label: "Auto Enhancement",
                items: [
                  {
                    "label": "Enable auto enhancement",
                    "value": true,
                    "checked": enableAutoEnhance,
                  }
                ],
                value: [
                  if (enableAutoEnhance)
                    {
                      "label": "Enable auto enhancement",
                      "value": true,
                      "checked": true
                    }
                ],
                onChanged: (values, ids) {
                  enableAutoEnhance = values.isNotEmpty;
                },
              ),
              QSwitch(
                label: "Color Correction",
                items: [
                  {
                    "label": "Apply color correction",
                    "value": true,
                    "checked": enableColorCorrection,
                  }
                ],
                value: [
                  if (enableColorCorrection)
                    {
                      "label": "Apply color correction",
                      "value": true,
                      "checked": true
                    }
                ],
                onChanged: (values, ids) {
                  enableColorCorrection = values.isNotEmpty;
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("Cancel"),
            ),
            QButton(
              label: "Save",
              size: bs.sm,
              onPressed: () {
                Navigator.pop(context);
                ss("Settings saved successfully!");
              },
            ),
          ],
        );
      },
    );
  }

  void _showJobDetails(Map<String, dynamic> job) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Job Details"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Name: ${job["name"]}"),
              Text("Status: ${job["status"]}"),
              Text("Progress: ${job["progress"]}%"),
              Text("Photos: ${job["processedPhotos"]}/${job["totalPhotos"]}"),
              Text("Start Time: ${job["startTime"]}"),
              Text("Estimated Time: ${job["estimatedTime"]}"),
            ],
          ),
          actions: [
            QButton(
              label: "Close",
              size: bs.sm,
              onPressed: () => Navigator.pop(context),
            ),
          ],
        );
      },
    );
  }

  void _pauseBatchJob(String jobId) {
    si("Batch job paused");
  }

  void _startBatchJob(String jobId) {
    ss("Batch job started");
  }

  void _retryBatchJob(String jobId) {
    si("Retrying batch job");
  }

  void _deleteBatchJob(String jobId) async {
    bool isConfirmed = await confirm("Are you sure you want to delete this batch job?");
    if (isConfirmed) {
      ss("Batch job deleted successfully");
    }
  }
}
