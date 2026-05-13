import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class FsmCompletionConfirmationsView extends StatefulWidget {
  const FsmCompletionConfirmationsView({super.key});

  @override
  State<FsmCompletionConfirmationsView> createState() => _FsmCompletionConfirmationsViewState();
}

class _FsmCompletionConfirmationsViewState extends State<FsmCompletionConfirmationsView> {
  int selectedTab = 0;
  bool autoConfirmations = true;
  bool requirePhotos = true;
  bool requireSignature = true;
  bool requireNotes = false;
  bool sendReceipt = true;
  
  String completionNotes = "";
  List<String> completionPhotos = [];

  List<Map<String, dynamic>> pendingConfirmations = [
    {
      "id": "1",
      "jobId": "JOB-2024-001",
      "customerName": "Sarah Johnson",
      "serviceType": "HVAC Maintenance",
      "address": "1234 Oak Street, Downtown",
      "completedTime": "2024-03-15 14:30",
      "technicianName": "John Smith",
      "status": "pending_confirmation",
      "hasPhotos": true,
      "hasSignature": false,
      "hasNotes": true,
      "estimatedDuration": "2h 30m",
      "actualDuration": "2h 45m",
      "priority": "High"
    },
    {
      "id": "2",
      "jobId": "JOB-2024-002",
      "customerName": "Mike Rodriguez",
      "serviceType": "Plumbing Repair",
      "address": "5678 Pine Avenue, Riverside",
      "completedTime": "2024-03-15 16:45",
      "technicianName": "John Smith",
      "status": "awaiting_customer",
      "hasPhotos": true,
      "hasSignature": true,
      "hasNotes": false,
      "estimatedDuration": "1h 30m",
      "actualDuration": "1h 15m",
      "priority": "Medium"
    },
    {
      "id": "3",
      "jobId": "JOB-2024-003",
      "customerName": "Lisa Chen",
      "serviceType": "Electrical Inspection",
      "address": "9012 Maple Drive, Northside",
      "completedTime": "2024-03-15 17:20",
      "technicianName": "John Smith",
      "status": "incomplete_data",
      "hasPhotos": false,
      "hasSignature": false,
      "hasNotes": true,
      "estimatedDuration": "1h 00m",
      "actualDuration": "1h 10m",
      "priority": "Low"
    }
  ];

  List<Map<String, dynamic>> confirmationHistory = [
    {
      "id": "1",
      "jobId": "JOB-2024-004",
      "customerName": "Robert Smith",
      "serviceType": "HVAC Installation",
      "completedDate": "2024-03-14",
      "confirmedDate": "2024-03-14",
      "confirmationType": "auto",
      "customerRating": 5,
      "customerFeedback": "Excellent service! Very professional and thorough.",
      "technicianName": "John Smith",
      "duration": "4h 15m",
      "status": "confirmed"
    },
    {
      "id": "2",
      "jobId": "JOB-2024-005",
      "customerName": "Emma Davis",
      "serviceType": "Plumbing Maintenance",
      "completedDate": "2024-03-14",
      "confirmedDate": "2024-03-15",
      "confirmationType": "manual",
      "customerRating": 4,
      "customerFeedback": "Good work, arrived on time.",
      "technicianName": "John Smith",
      "duration": "2h 00m",
      "status": "confirmed"
    },
    {
      "id": "3",
      "jobId": "JOB-2024-006",
      "customerName": "David Wilson",
      "serviceType": "Electrical Repair",
      "completedDate": "2024-03-13",
      "confirmedDate": "",
      "confirmationType": "pending",
      "customerRating": 0,
      "customerFeedback": "",
      "technicianName": "John Smith",
      "duration": "3h 30m",
      "status": "timeout"
    }
  ];

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Completion Confirmations",
      selectedIndex: selectedTab,
      tabs: [
        Tab(text: "Pending", icon: Icon(Icons.pending_actions)),
        Tab(text: "Settings", icon: Icon(Icons.settings)),
        Tab(text: "History", icon: Icon(Icons.history)),
      ],
      tabChildren: [
        _buildPendingTab(),
        _buildSettingsTab(),
        _buildHistoryTab(),
      ],
    );
  }

  Widget _buildPendingTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Status Overview
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: autoConfirmations ? successColor.withAlpha(20) : warningColor.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusLg),
              border: Border.all(
                color: autoConfirmations ? successColor : warningColor,
                width: 2,
              ),
            ),
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: autoConfirmations ? successColor : warningColor,
                    borderRadius: BorderRadius.circular(radiusMd),
                  ),
                  child: Icon(
                    autoConfirmations ? Icons.check_circle : Icons.pause_circle,
                    color: Colors.white,
                    size: 24,
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        autoConfirmations ? "Auto Confirmations ON" : "Manual Approval Required",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        autoConfirmations 
                          ? "Jobs are confirmed automatically when complete"
                          : "Manual review required for each completion",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ),
                QButton(
                  label: autoConfirmations ? "Disable" : "Enable",
                  size: bs.sm,
                  onPressed: () {
                    autoConfirmations = !autoConfirmations;
                    setState(() {});
                    ss(autoConfirmations ? "Auto confirmations enabled" : "Auto confirmations disabled");
                  },
                ),
              ],
            ),
          ),

          // Quick Stats
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 160,
            children: [
              _buildStatCard("Pending", "${pendingConfirmations.where((c) => c["status"] == "pending_confirmation").length}", Icons.pending, warningColor),
              _buildStatCard("Awaiting Customer", "${pendingConfirmations.where((c) => c["status"] == "awaiting_customer").length}", Icons.hourglass_empty, infoColor),
              _buildStatCard("Incomplete", "${pendingConfirmations.where((c) => c["status"] == "incomplete_data").length}", Icons.warning, dangerColor),
              _buildStatCard("Today Completed", "8", Icons.check_circle, successColor),
            ],
          ),

          // Pending Confirmations List
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusLg),
              boxShadow: [shadowMd],
            ),
            child: Column(
              spacing: spSm,
              children: [
                Row(
                  children: [
                    Icon(Icons.pending_actions, color: primaryColor),
                    SizedBox(width: spSm),
                    Text(
                      "Pending Confirmations",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Spacer(),
                    QButton(
                      label: "Confirm All",
                      icon: Icons.check_circle,
                      size: bs.sm,
                      onPressed: () {
                        ss("All eligible confirmations processed");
                      },
                    ),
                  ],
                ),
                if (pendingConfirmations.isEmpty)
                  Container(
                    padding: EdgeInsets.all(spLg),
                    child: Column(
                      children: [
                        Icon(Icons.check_circle_outline, size: 48, color: successColor),
                        SizedBox(height: spSm),
                        Text(
                          "No pending confirmations",
                          style: TextStyle(
                            fontSize: 16,
                            color: disabledBoldColor,
                          ),
                        ),
                        Text(
                          "All jobs have been confirmed",
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ...pendingConfirmations.map((confirmation) => _buildConfirmationCard(confirmation)),
              ],
            ),
          ),

          // Quick Actions
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusLg),
              boxShadow: [shadowMd],
            ),
            child: Column(
              spacing: spSm,
              children: [
                Text(
                  "Quick Actions",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Row(
                  spacing: spSm,
                  children: [
                    Expanded(
                      child: QButton(
                        label: "Create Report",
                        icon: Icons.description,
                        size: bs.sm,
                        onPressed: () {
                          ss("Generating completion report");
                        },
                      ),
                    ),
                    Expanded(
                      child: QButton(
                        label: "Send Reminders",
                        icon: Icons.send,
                        size: bs.sm,
                        onPressed: () {
                          ss("Sending confirmation reminders");
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Confirmation Settings
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusLg),
              boxShadow: [shadowMd],
            ),
            child: Column(
              spacing: spSm,
              children: [
                Text(
                  "Confirmation Settings",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                _buildSwitchItem("Auto Confirmations", "Automatically confirm completed jobs", autoConfirmations, (value) {
                  autoConfirmations = value;
                  setState(() {});
                }),
                _buildSwitchItem("Send Receipt", "Email receipt to customer upon confirmation", sendReceipt, (value) {
                  sendReceipt = value;
                  setState(() {});
                }),
              ],
            ),
          ),

          // Required Documentation
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusLg),
              boxShadow: [shadowMd],
            ),
            child: Column(
              spacing: spSm,
              children: [
                Text(
                  "Required Documentation",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                _buildSwitchItem("Photos Required", "Require photos for job completion", requirePhotos, (value) {
                  requirePhotos = value;
                  setState(() {});
                }),
                _buildSwitchItem("Signature Required", "Require customer signature", requireSignature, (value) {
                  requireSignature = value;
                  setState(() {});
                }),
                _buildSwitchItem("Notes Required", "Require completion notes", requireNotes, (value) {
                  requireNotes = value;
                  setState(() {});
                }),
              ],
            ),
          ),

          // Confirmation Templates
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusLg),
              boxShadow: [shadowMd],
            ),
            child: Column(
              spacing: spSm,
              children: [
                Row(
                  children: [
                    Text(
                      "Confirmation Templates",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Spacer(),
                    QButton(
                      label: "Edit Templates",
                      size: bs.sm,
                      onPressed: () {
                        ss("Opening template editor");
                      },
                    ),
                  ],
                ),
                _buildTemplatePreview("Customer Confirmation", "Hi [Customer], your [Service] has been completed successfully. Please confirm receipt and provide feedback."),
                _buildTemplatePreview("Manager Notification", "Job [JobID] has been completed by [Technician] and is awaiting customer confirmation."),
                _buildTemplatePreview("Receipt Email", "Thank you for choosing our services. Your [Service] has been completed. Total: [Amount]."),
              ],
            ),
          ),

          // Completion Form
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusLg),
              boxShadow: [shadowMd],
            ),
            child: Column(
              spacing: spSm,
              children: [
                Text(
                  "Mark Job as Complete",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                QTextField(
                  label: "Completion Notes",
                  value: completionNotes,
                  hint: "Describe the work completed and any observations",
                  onChanged: (value) {
                    completionNotes = value;
                    setState(() {});
                  },
                ),
                if (requirePhotos) ...[
                  SizedBox(height: spSm),
                  QMultiImagePicker(
                    label: "Completion Photos",
                    value: completionPhotos,
                    hint: "Take photos of completed work",
                    maxImages: 5,
                    onChanged: (value) {
                      completionPhotos = value;
                      setState(() {});
                    },
                  ),
                ],
                SizedBox(height: spSm),
                Row(
                  spacing: spSm,
                  children: [
                    Expanded(
                      child: QButton(
                        label: "Save Draft",
                        icon: Icons.save,
                        size: bs.sm,
                        onPressed: () {
                          ss("Completion data saved as draft");
                        },
                      ),
                    ),
                    Expanded(
                      child: QButton(
                        label: "Complete Job",
                        icon: Icons.check_circle,
                        size: bs.sm,
                        onPressed: () {
                          ss("Job marked as complete");
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHistoryTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // History Summary
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusLg),
              boxShadow: [shadowMd],
            ),
            child: Column(
              spacing: spSm,
              children: [
                Text(
                  "This Week's Summary",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                ResponsiveGridView(
                  padding: EdgeInsets.zero,
                  minItemWidth: 140,
                  children: [
                    _buildSummaryCard("Completed", "42", Icons.check_circle, successColor),
                    _buildSummaryCard("Confirmed", "38", Icons.verified, primaryColor),
                    _buildSummaryCard("Pending", "3", Icons.hourglass_empty, warningColor),
                    _buildSummaryCard("Avg Rating", "4.8", Icons.star, warningColor),
                  ],
                ),
              ],
            ),
          ),

          // Filter Options
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusLg),
              boxShadow: [shadowMd],
            ),
            child: Column(
              spacing: spSm,
              children: [
                Text(
                  "Filter History",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Row(
                  spacing: spSm,
                  children: [
                    Expanded(
                      child: QButton(
                        label: "All",
                        size: bs.sm,
                        onPressed: () {
                          ss("Showing all confirmations");
                        },
                      ),
                    ),
                    Expanded(
                      child: QButton(
                        label: "Confirmed",
                        size: bs.sm,
                        onPressed: () {
                          ss("Filtering confirmed jobs");
                        },
                      ),
                    ),
                    Expanded(
                      child: QButton(
                        label: "Timeout",
                        size: bs.sm,
                        onPressed: () {
                          ss("Filtering timeout cases");
                        },
                      ),
                    ),
                  ],
                ),
                Row(
                  spacing: spSm,
                  children: [
                    Expanded(
                      child: QButton(
                        label: "Today",
                        size: bs.sm,
                        onPressed: () {
                          ss("Filtering today's completions");
                        },
                      ),
                    ),
                    Expanded(
                      child: QButton(
                        label: "This Week",
                        size: bs.sm,
                        onPressed: () {
                          ss("Filtering this week");
                        },
                      ),
                    ),
                    Expanded(
                      child: QButton(
                        label: "Custom",
                        size: bs.sm,
                        onPressed: () {
                          ss("Custom date range");
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Confirmation History List
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusLg),
              boxShadow: [shadowMd],
            ),
            child: Column(
              spacing: spSm,
              children: [
                Row(
                  children: [
                    Icon(Icons.history, color: primaryColor),
                    SizedBox(width: spSm),
                    Text(
                      "Confirmation History",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Spacer(),
                    QButton(
                      label: "Export",
                      icon: Icons.download,
                      size: bs.sm,
                      onPressed: () {
                        ss("Exporting confirmation history");
                      },
                    ),
                  ],
                ),
                ...confirmationHistory.map((history) => _buildHistoryCard(history)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowMd],
      ),
      child: Column(
        spacing: spXs,
        children: [
          Icon(icon, color: color, size: 32),
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
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildConfirmationCard(Map<String, dynamic> confirmation) {
    Color statusColor = _getStatusColor(confirmation["status"] as String);
    Color priorityColor = _getPriorityColor(confirmation["priority"] as String);
    
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: statusColor.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusLg),
        border: Border.all(color: statusColor.withAlpha(30)),
      ),
      child: Column(
        spacing: spSm,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(spXs),
                decoration: BoxDecoration(
                  color: statusColor,
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Icon(
                  _getStatusIcon(confirmation["status"] as String),
                  color: Colors.white,
                  size: 16,
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            "${confirmation["customerName"]}",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                          decoration: BoxDecoration(
                            color: priorityColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Text(
                            "${confirmation["priority"]}",
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color: priorityColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Text(
                      "${confirmation["serviceType"]} (${confirmation["jobId"]})",
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
          Row(
            children: [
              Icon(Icons.location_on, color: disabledBoldColor, size: 16),
              SizedBox(width: spXs),
              Expanded(
                child: Text(
                  "${confirmation["address"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Icon(Icons.schedule, color: disabledBoldColor, size: 16),
              SizedBox(width: spXs),
              Text(
                "Completed: ${DateTime.parse(confirmation["completedTime"] as String).dMMMy} at ${TimeOfDay.fromDateTime(DateTime.parse(confirmation["completedTime"] as String)).format(context)}",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
          // Documentation Status
          Row(
            spacing: spSm,
            children: [
              _buildDocumentationStatus("Photos", confirmation["hasPhotos"] as bool),
              _buildDocumentationStatus("Signature", confirmation["hasSignature"] as bool),
              _buildDocumentationStatus("Notes", confirmation["hasNotes"] as bool),
            ],
          ),
          if (confirmation["status"] == "pending_confirmation" || confirmation["status"] == "incomplete_data")
            Row(
              spacing: spSm,
              children: [
                Expanded(
                  child: QButton(
                    label: "Review",
                    icon: Icons.visibility,
                    size: bs.sm,
                    onPressed: () {
                      ss("Reviewing job ${confirmation["jobId"]}");
                    },
                  ),
                ),
                Expanded(
                  child: QButton(
                    label: "Confirm",
                    icon: Icons.check_circle,
                    size: bs.sm,
                    onPressed: () {
                      confirmation["status"] = "confirmed";
                      setState(() {});
                      ss("Job ${confirmation["jobId"]} confirmed");
                    },
                  ),
                ),
                QButton(
                  icon: Icons.message,
                  size: bs.sm,
                  onPressed: () {
                    ss("Messaging customer");
                  },
                ),
              ],
            ),
        ],
      ),
    );
  }

  Widget _buildDocumentationStatus(String label, bool hasData) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
      decoration: BoxDecoration(
        color: hasData ? successColor.withAlpha(20) : dangerColor.withAlpha(20),
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            hasData ? Icons.check : Icons.close,
            color: hasData ? successColor : dangerColor,
            size: 12,
          ),
          SizedBox(width: spXs),
          Text(
            label,
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w600,
              color: hasData ? successColor : dangerColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSwitchItem(String title, String subtitle, bool value, Function(bool) onChanged) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: primaryColor.withAlpha(5),
        borderRadius: BorderRadius.circular(radiusMd),
      ),
      child: Row(
        children: [
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

  Widget _buildTemplatePreview(String title, String content) {
    return Container(
      padding: EdgeInsets.all(spSm),
      margin: EdgeInsets.only(bottom: spXs),
      decoration: BoxDecoration(
        color: primaryColor.withAlpha(5),
        borderRadius: BorderRadius.circular(radiusMd),
      ),
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
          SizedBox(height: spXs),
          Text(
            content,
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
              fontStyle: FontStyle.italic,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: color.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusMd),
      ),
      child: Column(
        spacing: spXs,
        children: [
          Icon(icon, color: color, size: 24),
          Text(
            value,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 10,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHistoryCard(Map<String, dynamic> history) {
    Color statusColor = _getHistoryStatusColor(history["status"] as String);
    
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: statusColor.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusMd),
        border: Border.all(color: statusColor.withAlpha(30)),
      ),
      child: Column(
        spacing: spXs,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(spXs),
                decoration: BoxDecoration(
                  color: statusColor,
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Icon(
                  _getHistoryStatusIcon(history["status"] as String),
                  color: Colors.white,
                  size: 14,
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${history["customerName"]} - ${history["serviceType"]}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "${history["jobId"]} • ${history["technicianName"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              if ((history["customerRating"] as int) > 0)
                Row(
                  children: List.generate(5, (index) {
                    return Icon(
                      index < (history["customerRating"] as int) ? Icons.star : Icons.star_border,
                      color: warningColor,
                      size: 12,
                    );
                  }),
                ),
            ],
          ),
          Row(
            children: [
              Icon(Icons.schedule, color: disabledBoldColor, size: 14),
              SizedBox(width: spXs),
              Text(
                "Completed: ${history["completedDate"]} | Duration: ${history["duration"]}",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
          if ((history["customerFeedback"] as String).isNotEmpty)
            Container(
              padding: EdgeInsets.all(spXs),
              decoration: BoxDecoration(
                color: infoColor.withAlpha(10),
                borderRadius: BorderRadius.circular(radiusXs),
              ),
              child: Row(
                children: [
                  Icon(Icons.feedback, color: infoColor, size: 14),
                  SizedBox(width: spXs),
                  Expanded(
                    child: Text(
                      "${history["customerFeedback"]}",
                      style: TextStyle(
                        fontSize: 11,
                        color: infoColor,
                        fontStyle: FontStyle.italic,
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

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'pending_confirmation': return warningColor;
      case 'awaiting_customer': return infoColor;
      case 'incomplete_data': return dangerColor;
      case 'confirmed': return successColor;
      default: return disabledBoldColor;
    }
  }

  IconData _getStatusIcon(String status) {
    switch (status.toLowerCase()) {
      case 'pending_confirmation': return Icons.pending;
      case 'awaiting_customer': return Icons.hourglass_empty;
      case 'incomplete_data': return Icons.warning;
      case 'confirmed': return Icons.check_circle;
      default: return Icons.info;
    }
  }

  Color _getPriorityColor(String priority) {
    switch (priority.toLowerCase()) {
      case 'high': return dangerColor;
      case 'medium': return warningColor;
      case 'low': return successColor;
      default: return disabledBoldColor;
    }
  }

  Color _getHistoryStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'confirmed': return successColor;
      case 'timeout': return dangerColor;
      case 'pending': return warningColor;
      default: return disabledBoldColor;
    }
  }

  IconData _getHistoryStatusIcon(String status) {
    switch (status.toLowerCase()) {
      case 'confirmed': return Icons.check_circle;
      case 'timeout': return Icons.timer_off;
      case 'pending': return Icons.pending;
      default: return Icons.info;
    }
  }
}
