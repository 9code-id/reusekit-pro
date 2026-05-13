import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class BrsQueueStatusView extends StatefulWidget {
  const BrsQueueStatusView({super.key});

  @override
  State<BrsQueueStatusView> createState() => _BrsQueueStatusViewState();
}

class _BrsQueueStatusViewState extends State<BrsQueueStatusView> {
  Map<String, dynamic> currentQueuePosition = {
    "position": 3,
    "totalInQueue": 8,
    "estimatedWaitTime": 25,
    "barberName": "Mike Thompson",
    "shopName": "Elite Cuts Barbershop",
    "service": "Premium Haircut & Beard Trim",
    "appointmentTime": "10:00",
    "currentTime": "09:35",
    "status": "waiting",
  };

  List<Map<String, dynamic>> queueAhead = [
    {
      "position": 1,
      "customerInitials": "JD",
      "service": "Quick Trim",
      "estimatedDuration": 15,
      "status": "in_progress",
      "startTime": "09:30",
    },
    {
      "position": 2,
      "customerInitials": "SM",
      "service": "Haircut & Shave",
      "estimatedDuration": 45,
      "status": "waiting",
      "startTime": "09:45",
    },
  ];

  List<Map<String, dynamic>> queueBehind = [
    {
      "position": 4,
      "customerInitials": "RW",
      "service": "Beard Styling",
      "estimatedDuration": 20,
      "status": "waiting",
      "estimatedStartTime": "10:25",
    },
    {
      "position": 5,
      "customerInitials": "AL",
      "service": "Premium Package",
      "estimatedDuration": 60,
      "status": "waiting",
      "estimatedStartTime": "10:45",
    },
    {
      "position": 6,
      "customerInitials": "MK",
      "service": "Hair Wash",
      "estimatedDuration": 15,
      "status": "waiting",
      "estimatedStartTime": "11:45",
    },
    {
      "position": 7,
      "customerInitials": "TH",
      "service": "Full Service",
      "estimatedDuration": 75,
      "status": "waiting",
      "estimatedStartTime": "12:00",
    },
    {
      "position": 8,
      "customerInitials": "KL",
      "service": "Quick Shave",
      "estimatedDuration": 10,
      "status": "waiting",
      "estimatedStartTime": "13:15",
    },
  ];

  bool autoRefresh = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Queue Status"),
        actions: [
          QButton(
            icon: autoRefresh ? Icons.pause : Icons.play_arrow,
            size: bs.sm,
            onPressed: () {
              autoRefresh = !autoRefresh;
              setState(() {});
              ss(autoRefresh ? "Auto-refresh enabled" : "Auto-refresh paused");
            },
          ),
          QButton(
            icon: Icons.refresh,
            size: bs.sm,
            onPressed: () {
              _refreshQueueStatus();
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            _buildCurrentStatusCard(),
            _buildQueueProgress(),
            _buildEstimatedTimeCard(),
            _buildQueueListSection("People Ahead of You", queueAhead, true),
            _buildQueueListSection("People Behind You", queueBehind, false),
            _buildQuickActions(),
          ],
        ),
      ),
    );
  }

  Widget _buildCurrentStatusCard() {
    int position = currentQueuePosition["position"] as int;
    int total = currentQueuePosition["totalInQueue"] as int;
    String status = currentQueuePosition["status"] as String;
    
    Color statusColor = status == "in_progress" 
        ? successColor 
        : status == "next" 
        ? warningColor 
        : primaryColor;

    String statusText = status == "in_progress" 
        ? "IN PROGRESS" 
        : status == "next" 
        ? "YOU'RE NEXT!" 
        : "WAITING";

    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [statusColor, statusColor.withAlpha(153)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowMd],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: Colors.white.withAlpha(51),
                  borderRadius: BorderRadius.circular(radiusMd),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "#$position",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      "of $total",
                      style: TextStyle(
                        fontSize: 10,
                        color: Colors.white.withAlpha(204),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: spMd),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      statusText,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      "${currentQueuePosition["service"]}",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white.withAlpha(204),
                      ),
                    ),
                    Text(
                      "with ${currentQueuePosition["barberName"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.white.withAlpha(153),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: spMd),
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white.withAlpha(51),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    Text(
                      "Appointment",
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.white.withAlpha(204),
                      ),
                    ),
                    Text(
                      "${currentQueuePosition["appointmentTime"]}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Text(
                      "Current Time",
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.white.withAlpha(204),
                      ),
                    ),
                    Text(
                      "${currentQueuePosition["currentTime"]}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Text(
                      "Wait Time",
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.white.withAlpha(204),
                      ),
                    ),
                    Text(
                      "${currentQueuePosition["estimatedWaitTime"]} min",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
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

  Widget _buildQueueProgress() {
    int position = currentQueuePosition["position"] as int;
    int total = currentQueuePosition["totalInQueue"] as int;
    double progress = (total - position) / total;

    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Queue Progress",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Text(
                "${(progress * 100).toInt()}% Complete",
                style: TextStyle(
                  fontSize: 14,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          LinearProgressIndicator(
            value: progress,
            backgroundColor: disabledColor.withAlpha(51),
            valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
          ),
          SizedBox(height: spSm),
          Text(
            "${total - position} people have been served",
            style: TextStyle(
              fontSize: 12,
              color: disabledColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEstimatedTimeCard() {
    int estimatedWait = currentQueuePosition["estimatedWaitTime"] as int;
    DateTime estimatedStartTime = DateTime.now().add(Duration(minutes: estimatedWait));

    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Row(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: warningColor.withAlpha(51),
              borderRadius: BorderRadius.circular(radiusMd),
            ),
            child: Icon(
              Icons.schedule,
              color: warningColor,
              size: 32,
            ),
          ),
          SizedBox(width: spMd),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Estimated Start Time",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "${estimatedStartTime.hour.toString().padLeft(2, '0')}:${estimatedStartTime.minute.toString().padLeft(2, '0')}",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: warningColor,
                  ),
                ),
                Text(
                  "Approximately $estimatedWait minutes from now",
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
    );
  }

  Widget _buildQueueListSection(String title, List<Map<String, dynamic>> queueList, bool isAhead) {
    if (queueList.isEmpty) return SizedBox.shrink();

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: isAhead ? warningColor.withAlpha(51) : infoColor.withAlpha(51),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(radiusMd),
                topRight: Radius.circular(radiusMd),
              ),
            ),
            child: Row(
              children: [
                Icon(
                  isAhead ? Icons.arrow_upward : Icons.arrow_downward,
                  color: isAhead ? warningColor : infoColor,
                  size: 20,
                ),
                SizedBox(width: spSm),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: isAhead ? warningColor : infoColor,
                  ),
                ),
                Spacer(),
                Text(
                  "${queueList.length} ${queueList.length == 1 ? 'person' : 'people'}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
          ...queueList.map((person) => _buildQueuePersonCard(person, isAhead)),
        ],
      ),
    );
  }

  Widget _buildQueuePersonCard(Map<String, dynamic> person, bool isAhead) {
    String status = person["status"] as String;
    Color statusColor = status == "in_progress" ? successColor : disabledBoldColor;

    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: disabledColor.withAlpha(51),
            width: 1,
          ),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: statusColor.withAlpha(51),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Center(
              child: Text(
                "${person["customerInitials"]}",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: statusColor,
                ),
              ),
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
                      "Position #${person["position"]}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    if (status == "in_progress") ...[
                      SizedBox(width: spXs),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: spXs,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: successColor.withAlpha(51),
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Text(
                          "IN PROGRESS",
                          style: TextStyle(
                            fontSize: 8,
                            fontWeight: FontWeight.bold,
                            color: successColor,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
                Text(
                  "${person["service"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                "${person["estimatedDuration"]} min",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: disabledBoldColor,
                ),
              ),
              if (person.containsKey("startTime"))
                Text(
                  "Started: ${person["startTime"]}",
                  style: TextStyle(
                    fontSize: 10,
                    color: disabledColor,
                  ),
                )
              else if (person.containsKey("estimatedStartTime"))
                Text(
                  "Est: ${person["estimatedStartTime"]}",
                  style: TextStyle(
                    fontSize: 10,
                    color: disabledColor,
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActions() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Quick Actions",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Row(
            children: [
              Expanded(
                child: QButton(
                  label: "Leave Queue",
                  size: bs.sm,
                  onPressed: () {
                    _showLeaveQueueDialog();
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QButton(
                  label: "Get Directions",
                  size: bs.sm,
                  onPressed: () {
                    _getDirections();
                  },
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: QButton(
                  label: "Call Shop",
                  size: bs.sm,
                  onPressed: () {
                    _callShop();
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QButton(
                  label: "Share Status",
                  size: bs.sm,
                  onPressed: () {
                    _shareQueueStatus();
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _refreshQueueStatus() {
    // Simulate refresh
    ss("Queue status refreshed");
  }

  void _showLeaveQueueDialog() async {
    bool isConfirmed = await confirm("Are you sure you want to leave the queue? You'll lose your current position.");
    if (isConfirmed) {
      ss("You have left the queue");
      // Navigate back
    }
  }

  void _getDirections() {
    ss("Opening directions to ${currentQueuePosition["shopName"]}");
  }

  void _callShop() {
    ss("Calling ${currentQueuePosition["shopName"]}");
  }

  void _shareQueueStatus() {
    ss("Queue status shared");
  }
}
