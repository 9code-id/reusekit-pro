import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class BfaScheduledTransfersView extends StatefulWidget {
  const BfaScheduledTransfersView({super.key});

  @override
  State<BfaScheduledTransfersView> createState() => _BfaScheduledTransfersViewState();
}

class _BfaScheduledTransfersViewState extends State<BfaScheduledTransfersView> {
  String selectedFilter = "all";
  String searchQuery = "";
  
  // Sample scheduled transfers
  List<Map<String, dynamic>> scheduledTransfers = [
    {
      "id": "sched001",
      "type": "recurring",
      "recipientName": "John Williams",
      "recipientAccount": "****1234",
      "bankName": "ABC Bank",
      "amount": 500.0,
      "frequency": "monthly",
      "nextDate": "2024-12-25T10:00:00Z",
      "lastExecuted": "2024-11-25T10:00:00Z",
      "description": "Monthly allowance",
      "status": "active",
      "totalExecutions": 12,
      "remainingExecutions": 0, // 0 means infinite
      "startDate": "2024-01-25T10:00:00Z",
      "endDate": null,
      "isActive": true,
    },
    {
      "id": "sched002",
      "type": "one_time",
      "recipientName": "Sarah Johnson",
      "recipientAccount": "****5678",
      "bankName": "XYZ Bank",
      "amount": 1250.0,
      "frequency": "one_time",
      "nextDate": "2024-12-20T14:00:00Z",
      "lastExecuted": null,
      "description": "Christmas gift",
      "status": "pending",
      "totalExecutions": 0,
      "remainingExecutions": 1,
      "startDate": "2024-12-20T14:00:00Z",
      "endDate": "2024-12-20T14:00:00Z",
      "isActive": true,
    },
    {
      "id": "sched003",
      "type": "recurring",
      "recipientName": "Michael Brown",
      "recipientAccount": "****9012",
      "bankName": "DEF Bank",
      "amount": 300.0,
      "frequency": "weekly",
      "nextDate": "2024-12-22T09:00:00Z",
      "lastExecuted": "2024-12-15T09:00:00Z",
      "description": "Weekly grocery allowance",
      "status": "active",
      "totalExecutions": 8,
      "remainingExecutions": 4,
      "startDate": "2024-10-27T09:00:00Z",
      "endDate": "2025-01-19T09:00:00Z",
      "isActive": true,
    },
    {
      "id": "sched004",
      "type": "recurring",
      "recipientName": "Emma Davis",
      "recipientAccount": "****3456",
      "bankName": "GHI Bank",
      "amount": 750.0,
      "frequency": "bi_weekly",
      "nextDate": "2024-12-28T16:00:00Z",
      "lastExecuted": "2024-12-14T16:00:00Z",
      "description": "Bi-weekly payment",
      "status": "active",
      "totalExecutions": 6,
      "remainingExecutions": 6,
      "startDate": "2024-09-14T16:00:00Z",
      "endDate": "2025-03-14T16:00:00Z",
      "isActive": true,
    },
    {
      "id": "sched005",
      "type": "recurring",
      "recipientName": "David Wilson",
      "recipientAccount": "****7890",
      "bankName": "JKL Bank",
      "amount": 200.0,
      "frequency": "monthly",
      "nextDate": null,
      "lastExecuted": "2024-11-30T12:00:00Z",
      "description": "Monthly subscription",
      "status": "paused",
      "totalExecutions": 11,
      "remainingExecutions": 1,
      "startDate": "2024-01-30T12:00:00Z",
      "endDate": "2024-12-30T12:00:00Z",
      "isActive": false,
    },
    {
      "id": "sched006",
      "type": "recurring",
      "recipientName": "Lisa Anderson",
      "recipientAccount": "****2468",
      "bankName": "MNO Bank",
      "amount": 450.0,
      "frequency": "monthly",
      "nextDate": null,
      "lastExecuted": "2024-10-15T11:00:00Z",
      "description": "Monthly rent payment",
      "status": "completed",
      "totalExecutions": 12,
      "remainingExecutions": 0,
      "startDate": "2023-11-15T11:00:00Z",
      "endDate": "2024-10-15T11:00:00Z",
      "isActive": false,
    },
  ];

  List<Map<String, dynamic>> filterItems = [
    {"label": "All Transfers", "value": "all"},
    {"label": "Active", "value": "active"},
    {"label": "Pending", "value": "pending"},
    {"label": "Paused", "value": "paused"},
    {"label": "Completed", "value": "completed"},
  ];

  List<Map<String, dynamic>> get filteredTransfers {
    List<Map<String, dynamic>> filtered = scheduledTransfers;
    
    // Filter by status
    if (selectedFilter != "all") {
      filtered = filtered.where((t) => t["status"] == selectedFilter).toList();
    }
    
    // Filter by search query
    if (searchQuery.isNotEmpty) {
      filtered = filtered.where((t) => 
        (t["recipientName"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
        (t["description"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
        (t["bankName"] as String).toLowerCase().contains(searchQuery.toLowerCase())
      ).toList();
    }
    
    return filtered;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Scheduled Transfers"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              _showCreateScheduledTransfer();
            },
          ),
          IconButton(
            icon: Icon(Icons.calendar_today),
            onPressed: () {
              _showTransferCalendar();
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            // Summary Stats
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spLg),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [primaryColor, primaryColor.withAlpha(150)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(radiusLg),
              ),
              child: Column(
                children: [
                  Text(
                    "Scheduled Transfers",
                    style: TextStyle(
                      fontSize: fsH5,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: spSm),
                  Row(
                    children: [
                      Expanded(
                        child: _buildStatCard(
                          "Active",
                          "${scheduledTransfers.where((t) => t["status"] == "active").length}",
                          Icons.schedule
                        ),
                      ),
                      Container(
                        width: 1,
                        height: 40,
                        color: Colors.white.withAlpha(60),
                      ),
                      Expanded(
                        child: _buildStatCard(
                          "This Month",
                          "\$${_calculateMonthlyTotal().currency}",
                          Icons.calendar_month
                        ),
                      ),
                      Container(
                        width: 1,
                        height: 40,
                        color: Colors.white.withAlpha(60),
                      ),
                      Expanded(
                        child: _buildStatCard(
                          "Total",
                          "${scheduledTransfers.length}",
                          Icons.repeat
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Search and Filter
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spLg),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Column(
                spacing: spSm,
                children: [
                  Row(
                    spacing: spSm,
                    children: [
                      Expanded(
                        child: QTextField(
                          label: "Search transfers...",
                          value: searchQuery,
                          hint: "Name, description, or bank",
                          onChanged: (value) {
                            searchQuery = value;
                            setState(() {});
                          },
                        ),
                      ),
                      Container(
                        height: 48,
                        child: QButton(
                          icon: Icons.search,
                          size: bs.sm,
                          onPressed: () {
                            // Search action
                          },
                        ),
                      ),
                    ],
                  ),

                  QCategoryPicker(
                    label: "Filter by Status",
                    items: filterItems,
                    value: selectedFilter,
                    onChanged: (index, label, value, item) {
                      selectedFilter = value;
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),

            // Upcoming Transfers
            if (filteredTransfers.where((t) => t["status"] == "active" || t["status"] == "pending").isNotEmpty) ...[
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(spLg),
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
                      "Upcoming Transfers",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),

                    ...filteredTransfers
                        .where((t) => t["status"] == "active" || t["status"] == "pending")
                        .where((t) => t["nextDate"] != null)
                        .take(3)
                        .map((transfer) => _buildUpcomingTransferItem(transfer)),
                  ],
                ),
              ),
            ],

            // All Scheduled Transfers
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.all(spLg),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "All Transfers (${filteredTransfers.length})",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            _showBulkActions();
                          },
                          child: Text(
                            "Bulk Actions",
                            style: TextStyle(
                              fontSize: 14,
                              color: infoColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  if (filteredTransfers.isEmpty) ...[
                    Padding(
                      padding: EdgeInsets.all(spLg),
                      child: Column(
                        children: [
                          Icon(
                            Icons.schedule,
                            size: 64,
                            color: disabledColor,
                          ),
                          SizedBox(height: spSm),
                          Text(
                            "No scheduled transfers found",
                            style: TextStyle(
                              fontSize: fsH6,
                              fontWeight: FontWeight.bold,
                              color: disabledBoldColor,
                            ),
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "Create scheduled transfers to automate your payments",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                          SizedBox(height: spSm),
                          QButton(
                            label: "Schedule Transfer",
                            icon: Icons.add_alarm,
                            size: bs.sm,
                            onPressed: () {
                              _showCreateScheduledTransfer();
                            },
                          ),
                        ],
                      ),
                    ),
                  ] else ...[
                    ...List.generate(filteredTransfers.length, (index) {
                      final transfer = filteredTransfers[index];
                      return _buildTransferItem(transfer, index == filteredTransfers.length - 1);
                    }),
                  ],
                ],
              ),
            ),

            // Quick Actions
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spLg),
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
                          label: "New Schedule",
                          icon: Icons.add_alarm,
                          size: bs.sm,
                          onPressed: () {
                            _showCreateScheduledTransfer();
                          },
                        ),
                      ),
                      Expanded(
                        child: QButton(
                          label: "Calendar View",
                          icon: Icons.calendar_today,
                          size: bs.sm,
                          onPressed: () {
                            _showTransferCalendar();
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
                          label: "Export",
                          icon: Icons.download,
                          size: bs.sm,
                          onPressed: () {
                            ss("Transfer schedule exported");
                          },
                        ),
                      ),
                      Expanded(
                        child: QButton(
                          label: "Templates",
                          icon: Icons.bookmark,
                          size: bs.sm,
                          onPressed: () {
                            //navigateTo('BfaTransferTemplatesView')
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
      ),
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon) {
    return Column(
      children: [
        Icon(
          icon,
          color: Colors.white,
          size: 24,
        ),
        SizedBox(height: spXs),
        Text(
          value,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        Text(
          title,
          style: TextStyle(
            fontSize: 12,
            color: Colors.white.withAlpha(200),
          ),
        ),
      ],
    );
  }

  Widget _buildUpcomingTransferItem(Map<String, dynamic> transfer) {
    DateTime nextDate = DateTime.parse(transfer["nextDate"]);
    int daysUntil = nextDate.difference(DateTime.now()).inDays;
    
    return Container(
      padding: EdgeInsets.all(spSm),
      margin: EdgeInsets.only(bottom: spXs),
      decoration: BoxDecoration(
        color: daysUntil <= 1 ? warningColor.withAlpha(20) : Colors.grey[50],
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(
          color: daysUntil <= 1 ? warningColor.withAlpha(100) : disabledOutlineBorderColor,
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: daysUntil <= 1 ? warningColor : primaryColor,
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Icon(
              Icons.schedule,
              color: Colors.white,
              size: 16,
            ),
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${transfer["recipientName"]} • \$${(transfer["amount"] as double).currency}",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
                Text(
                  daysUntil == 0 ? "Today" : 
                  daysUntil == 1 ? "Tomorrow" : 
                  "In $daysUntil days",
                  style: TextStyle(
                    fontSize: 12,
                    color: daysUntil <= 1 ? warningColor : disabledBoldColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          Text(
            "${nextDate.dMMMy}",
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTransferItem(Map<String, dynamic> transfer, bool isLast) {
    String status = transfer["status"];
    Color statusColor = status == "active" ? successColor : 
                       status == "pending" ? warningColor : 
                       status == "paused" ? infoColor : disabledBoldColor;
    
    String frequency = transfer["frequency"];
    String frequencyText = frequency == "one_time" ? "One Time" :
                          frequency == "weekly" ? "Weekly" :
                          frequency == "bi_weekly" ? "Bi-weekly" :
                          frequency == "monthly" ? "Monthly" :
                          frequency == "quarterly" ? "Quarterly" : "Yearly";

    return Container(
      padding: EdgeInsets.all(spLg),
      decoration: BoxDecoration(
        border: isLast ? null : Border(
          bottom: BorderSide(
            color: disabledOutlineBorderColor,
            width: 1,
          ),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: statusColor.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusLg),
            ),
            child: Icon(
              transfer["type"] == "recurring" ? Icons.repeat : Icons.schedule,
              color: statusColor,
              size: 24,
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
                        "${transfer["recipientName"]}",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                      decoration: BoxDecoration(
                        color: statusColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Text(
                        status.toUpperCase(),
                        style: TextStyle(
                          fontSize: 10,
                          color: statusColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spXs),
                Text(
                  "${transfer["description"]}",
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                  ),
                ),
                SizedBox(height: spXs),
                Row(
                  children: [
                    Icon(
                      Icons.account_balance,
                      size: 14,
                      color: disabledBoldColor,
                    ),
                    SizedBox(width: spXs),
                    Text(
                      "${transfer["bankName"]} • ${transfer["recipientAccount"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spXs),
                Row(
                  children: [
                    Icon(
                      Icons.repeat,
                      size: 14,
                      color: disabledBoldColor,
                    ),
                    SizedBox(width: spXs),
                    Text(
                      "$frequencyText • ${transfer["totalExecutions"]} executions",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    if (transfer["nextDate"] != null) ...[
                      SizedBox(width: spSm),
                      Icon(
                        Icons.schedule,
                        size: 14,
                        color: disabledBoldColor,
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "Next: ${DateTime.parse(transfer["nextDate"]).dMMMy}",
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
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                "\$${(transfer["amount"] as double).currency}",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              SizedBox(height: spXs),
              GestureDetector(
                onTap: () {
                  _showTransferOptions(transfer);
                },
                child: Container(
                  padding: EdgeInsets.all(spXs),
                  decoration: BoxDecoration(
                    color: disabledColor.withAlpha(40),
                    borderRadius: BorderRadius.circular(radiusXs),
                  ),
                  child: Icon(
                    Icons.more_vert,
                    color: disabledBoldColor,
                    size: 16,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  double _calculateMonthlyTotal() {
    return scheduledTransfers
        .where((t) => t["status"] == "active" && t["frequency"] == "monthly")
        .fold(0.0, (sum, t) => sum + (t["amount"] as double));
  }

  void _showCreateScheduledTransfer() {
    ss("Redirecting to create scheduled transfer");
    //navigateTo('BfaCreateScheduledTransferView')
  }

  void _showTransferCalendar() {
    ss("Opening transfer calendar view");
    //navigateTo('BfaTransferCalendarView')
  }

  void _showBulkActions() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          padding: EdgeInsets.all(spLg),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Bulk Actions",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              SizedBox(height: spSm),
              ListTile(
                leading: Icon(Icons.pause),
                title: Text("Pause All Active"),
                onTap: () {
                  ss("Pausing all active transfers");
                  back();
                },
              ),
              ListTile(
                leading: Icon(Icons.play_arrow),
                title: Text("Resume All Paused"),
                onTap: () {
                  ss("Resuming all paused transfers");
                  back();
                },
              ),
              ListTile(
                leading: Icon(Icons.download),
                title: Text("Export Schedule"),
                onTap: () {
                  ss("Exporting transfer schedule");
                  back();
                },
              ),
              ListTile(
                leading: Icon(Icons.delete_outline, color: dangerColor),
                title: Text("Delete Completed", style: TextStyle(color: dangerColor)),
                onTap: () async {
                  bool isConfirmed = await confirm("Delete all completed transfers?");
                  if (isConfirmed) {
                    scheduledTransfers.removeWhere((t) => t["status"] == "completed");
                    setState(() {});
                    ss("Completed transfers deleted");
                  }
                  back();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _showTransferOptions(Map<String, dynamic> transfer) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          padding: EdgeInsets.all(spLg),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "${transfer["recipientName"]}",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              SizedBox(height: spSm),
              if (transfer["status"] == "active") ...[
                ListTile(
                  leading: Icon(Icons.pause),
                  title: Text("Pause Transfer"),
                  onTap: () {
                    transfer["status"] = "paused";
                    transfer["isActive"] = false;
                    setState(() {});
                    ss("Transfer paused");
                    back();
                  },
                ),
              ],
              if (transfer["status"] == "paused") ...[
                ListTile(
                  leading: Icon(Icons.play_arrow),
                  title: Text("Resume Transfer"),
                  onTap: () {
                    transfer["status"] = "active";
                    transfer["isActive"] = true;
                    setState(() {});
                    ss("Transfer resumed");
                    back();
                  },
                ),
              ],
              ListTile(
                leading: Icon(Icons.edit),
                title: Text("Edit Transfer"),
                onTap: () {
                  back();
                  //navigateTo('BfaEditScheduledTransferView', transfer: transfer)
                },
              ),
              ListTile(
                leading: Icon(Icons.send),
                title: Text("Execute Now"),
                onTap: () {
                  back();
                  ss("Transfer executed immediately");
                },
              ),
              ListTile(
                leading: Icon(Icons.history),
                title: Text("View History"),
                onTap: () {
                  back();
                  //navigateTo('BfaTransferHistoryView', scheduledTransfer: transfer)
                },
              ),
              ListTile(
                leading: Icon(Icons.delete_outline, color: dangerColor),
                title: Text("Delete Transfer", style: TextStyle(color: dangerColor)),
                onTap: () async {
                  bool isConfirmed = await confirm("Delete this scheduled transfer?");
                  if (isConfirmed) {
                    scheduledTransfers.removeWhere((t) => t["id"] == transfer["id"]);
                    setState(() {});
                    ss("Scheduled transfer deleted");
                  }
                  back();
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
