import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class FsmRealTimeSchedulingView extends StatefulWidget {
  const FsmRealTimeSchedulingView({super.key});

  @override
  State<FsmRealTimeSchedulingView> createState() => _FsmRealTimeSchedulingViewState();
}

class _FsmRealTimeSchedulingViewState extends State<FsmRealTimeSchedulingView> {
  List<Map<String, dynamic>> realTimeEvents = [
    {
      "id": "1",
      "type": "Job Completed",
      "technician": "John Smith",
      "job": "HVAC Repair - Office Building",
      "timestamp": DateTime.now().subtract(Duration(minutes: 5)),
      "status": "Success",
      "impact": "Slot available for new assignment",
      "nextAction": "Auto-assign pending job"
    },
    {
      "id": "2",
      "type": "Emergency Request",
      "client": "Downtown Hospital",
      "job": "Power System Failure",
      "timestamp": DateTime.now().subtract(Duration(minutes: 2)),
      "status": "Critical",
      "impact": "Requires immediate technician",
      "nextAction": "Dispatch available emergency tech"
    },
    {
      "id": "3",
      "type": "Schedule Conflict",
      "technician": "Sarah Johnson",
      "job": "Installation overrunning into next slot",
      "timestamp": DateTime.now().subtract(Duration(minutes: 8)),
      "status": "Warning",
      "impact": "Next job will be delayed by 1.5 hours",
      "nextAction": "Reschedule or reassign next job"
    },
    {
      "id": "4",
      "type": "Technician Available",
      "technician": "Mike Davis",
      "job": "Finished route 30 minutes early",
      "timestamp": DateTime.now().subtract(Duration(minutes: 1)),
      "status": "Opportunity",
      "impact": "Can pick up additional job",
      "nextAction": "Check pending high-priority jobs"
    }
  ];

  List<Map<String, dynamic>> liveSchedule = [
    {
      "technician": "John Smith",
      "status": "Available",
      "currentLocation": "Downtown Area",
      "nextJob": null,
      "timeSlots": [
        {"time": "09:00", "status": "Completed", "job": "HVAC Maintenance"},
        {"time": "11:30", "status": "Available", "job": null},
        {"time": "14:00", "status": "Scheduled", "job": "Electrical Check"},
        {"time": "16:30", "status": "Available", "job": null}
      ]
    },
    {
      "technician": "Sarah Johnson",
      "status": "On Job",
      "currentLocation": "Industrial Zone",
      "nextJob": "Factory Installation (Running late)",
      "timeSlots": [
        {"time": "08:00", "status": "In Progress", "job": "System Installation"},
        {"time": "12:00", "status": "Delayed", "job": "Equipment Check"},
        {"time": "15:00", "status": "At Risk", "job": "Maintenance Work"},
        {"time": "17:30", "status": "Scheduled", "job": "Safety Inspection"}
      ]
    },
    {
      "technician": "Mike Davis",
      "status": "Available",
      "currentLocation": "Commercial District",
      "nextJob": null,
      "timeSlots": [
        {"time": "09:30", "status": "Completed", "job": "Plumbing Repair"},
        {"time": "11:00", "status": "Available", "job": null},
        {"time": "13:30", "status": "Available", "job": null},
        {"time": "16:00", "status": "Scheduled", "job": "Emergency Call"}
      ]
    },
    {
      "technician": "Emma Wilson",
      "status": "Traveling",
      "currentLocation": "En route to Mall",
      "nextJob": "Security System Check in 15 minutes",
      "timeSlots": [
        {"time": "10:00", "status": "Traveling", "job": "Security Check"},
        {"time": "13:00", "status": "Scheduled", "job": "System Upgrade"},
        {"time": "15:30", "status": "Scheduled", "job": "Inspection"},
        {"time": "18:00", "status": "Available", "job": null}
      ]
    }
  ];

  List<Map<String, dynamic>> autoSuggestions = [
    {
      "type": "Auto Assignment",
      "description": "Assign emergency job E002 to Mike Davis (closest available)",
      "impact": "Response time: 12 minutes",
      "confidence": 95,
      "action": "assign"
    },
    {
      "type": "Schedule Optimization",
      "description": "Swap jobs between John and Emma to reduce total travel time",
      "impact": "Save 45 minutes total travel",
      "confidence": 88,
      "action": "optimize"
    },
    {
      "type": "Delay Prevention", 
      "description": "Move Sarah's 15:00 job to tomorrow to prevent cascade delays",
      "impact": "Prevent 3 delayed appointments",
      "confidence": 92,
      "action": "reschedule"
    }
  ];

  bool autoSchedulingEnabled = true;
  bool showEventDetails = false;
  Map<String, dynamic>? selectedEvent;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Real-Time Scheduling"),
        actions: [
          Switch(
            value: autoSchedulingEnabled,
            onChanged: (value) {
              autoSchedulingEnabled = value;
              setState(() {});
              ss(autoSchedulingEnabled ? "Auto-scheduling enabled" : "Auto-scheduling disabled");
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            _buildRealTimeStatus(),
            _buildLiveEvents(),
            _buildLiveScheduleBoard(),
            _buildAutoSuggestions(),
            if (showEventDetails) _buildEventDetails(),
          ],
        ),
      ),
    );
  }

  Widget _buildRealTimeStatus() {
    int activeJobs = liveSchedule.where((tech) => tech["status"] == "On Job").length;
    int availableTechs = liveSchedule.where((tech) => tech["status"] == "Available").length;
    int criticalEvents = realTimeEvents.where((event) => event["status"] == "Critical").length;
    int opportunities = realTimeEvents.where((event) => event["status"] == "Opportunity").length;

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
              Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  color: successColor,
                  shape: BoxShape.circle,
                ),
              ),
              SizedBox(width: spSm),
              Text(
                "Live System Status",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Spacer(),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: autoSchedulingEnabled ? successColor.withAlpha(20) : disabledColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Text(
                  autoSchedulingEnabled ? "Auto-Scheduling ON" : "Manual Mode",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: autoSchedulingEnabled ? successColor : disabledBoldColor,
                  ),
                ),
              ),
            ],
          ),
          Row(
            spacing: spSm,
            children: [
              _buildStatusCard("Active Jobs", "$activeJobs", infoColor),
              _buildStatusCard("Available", "$availableTechs", successColor),
              _buildStatusCard("Critical", "$criticalEvents", dangerColor),
              _buildStatusCard("Opportunities", "$opportunities", warningColor),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatusCard(String title, String value, Color color) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(spSm),
        decoration: BoxDecoration(
          color: color.withAlpha(10),
          borderRadius: BorderRadius.circular(radiusSm),
          border: Border.all(color: color.withAlpha(30)),
        ),
        child: Column(
          spacing: spXs,
          children: [
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
                fontSize: 12,
                color: disabledBoldColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLiveEvents() {
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
              Icon(Icons.notifications_active, color: primaryColor),
              SizedBox(width: spSm),
              Text(
                "Live Events",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Spacer(),
              Text(
                "Last update: ${DateTime.now().kkmm}",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
          Column(
            spacing: spSm,
            children: realTimeEvents.map((event) => _buildEventCard(event)).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildEventCard(Map<String, dynamic> event) {
    Color statusColor = event["status"] == "Critical" ? dangerColor :
                       event["status"] == "Warning" ? warningColor :
                       event["status"] == "Opportunity" ? successColor : infoColor;

    DateTime timestamp = event["timestamp"] as DateTime;
    String timeAgo = _getTimeAgo(timestamp);

    return GestureDetector(
      onTap: () {
        selectedEvent = event;
        showEventDetails = true;
        setState(() {});
      },
      child: Container(
        padding: EdgeInsets.all(spSm),
        decoration: BoxDecoration(
          color: statusColor.withAlpha(10),
          borderRadius: BorderRadius.circular(radiusSm),
          border: Border(
            left: BorderSide(
              width: 4,
              color: statusColor,
            ),
          ),
        ),
        child: Column(
          spacing: spSm,
          children: [
            Row(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                  decoration: BoxDecoration(
                    color: statusColor,
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Text(
                    "${event["type"]}",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
                Spacer(),
                Text(
                  timeAgo,
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: spXs,
                    children: [
                      if (event["technician"] != null)
                        Text(
                          "Technician: ${event["technician"]}",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      if (event["client"] != null)
                        Text(
                          "Client: ${event["client"]}",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      Text(
                        "${event["job"]}",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),
                      Text(
                        "Impact: ${event["impact"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Column(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                      decoration: BoxDecoration(
                        color: primaryColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Text(
                        "View Details",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: primaryColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLiveScheduleBoard() {
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
          Text(
            "Live Schedule Board",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Column(
            spacing: spSm,
            children: liveSchedule.map((techSchedule) => _buildTechnicianSchedule(techSchedule)).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildTechnicianSchedule(Map<String, dynamic> techSchedule) {
    Color statusColor = techSchedule["status"] == "Available" ? successColor :
                       techSchedule["status"] == "On Job" ? infoColor :
                       techSchedule["status"] == "Traveling" ? warningColor : disabledBoldColor;

    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Column(
        spacing: spSm,
        children: [
          Row(
            children: [
              Container(
                width: 12,
                height: 12,
                decoration: BoxDecoration(
                  color: statusColor,
                  shape: BoxShape.circle,
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 2,
                  children: [
                    Text(
                      "${techSchedule["technician"]}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "Location: ${techSchedule["currentLocation"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    if (techSchedule["nextJob"] != null)
                      Text(
                        "Next: ${techSchedule["nextJob"]}",
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
                  color: statusColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Text(
                  "${techSchedule["status"]}",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: statusColor,
                  ),
                ),
              ),
            ],
          ),
          // Time slots
          Row(
            spacing: spXs,
            children: (techSchedule["timeSlots"] as List<Map<String, dynamic>>).map((slot) => 
              _buildTimeSlot(slot)).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildTimeSlot(Map<String, dynamic> slot) {
    Color slotColor = slot["status"] == "Completed" ? successColor :
                     slot["status"] == "In Progress" ? infoColor :
                     slot["status"] == "Scheduled" ? warningColor :
                     slot["status"] == "Delayed" ? dangerColor :
                     slot["status"] == "At Risk" ? dangerColor :
                     slot["status"] == "Traveling" ? warningColor : disabledColor;

    return Expanded(
      child: Container(
        padding: EdgeInsets.all(spXs),
        decoration: BoxDecoration(
          color: slotColor.withAlpha(20),
          borderRadius: BorderRadius.circular(radiusXs),
          border: Border.all(color: slotColor.withAlpha(50)),
        ),
        child: Column(
          spacing: 2,
          children: [
            Text(
              "${slot["time"]}",
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.bold,
                color: slotColor,
              ),
            ),
            Text(
              "${slot["status"]}",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 9,
                color: slotColor,
              ),
            ),
            if (slot["job"] != null)
              Text(
                "${slot["job"]}",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 8,
                  color: disabledBoldColor,
                ),
              )
            else
              Text(
                "Available",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 8,
                  color: disabledColor,
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildAutoSuggestions() {
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
              Icon(Icons.auto_awesome, color: primaryColor),
              SizedBox(width: spSm),
              Text(
                "AI Suggestions",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Spacer(),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: infoColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Text(
                  "${autoSuggestions.length} suggestions",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: infoColor,
                  ),
                ),
              ),
            ],
          ),
          Column(
            spacing: spSm,
            children: autoSuggestions.map((suggestion) => _buildSuggestionCard(suggestion)).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildSuggestionCard(Map<String, dynamic> suggestion) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border(
          left: BorderSide(
            width: 3,
            color: primaryColor,
          ),
        ),
      ),
      child: Column(
        spacing: spSm,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spXs,
                  children: [
                    Text(
                      "${suggestion["type"]}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "${suggestion["description"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "Impact: ${suggestion["impact"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: successColor,
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                spacing: spXs,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                    decoration: BoxDecoration(
                      color: successColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Text(
                      "${suggestion["confidence"]}% confidence",
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: successColor,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          Row(
            spacing: spSm,
            children: [
              Expanded(
                child: QButton(
                  label: "Dismiss",
                  color: disabledBoldColor,
                  size: bs.sm,
                  onPressed: () {
                    ss("Suggestion dismissed");
                  },
                ),
              ),
              Expanded(
                child: QButton(
                  label: "Apply",
                  size: bs.sm,
                  onPressed: () {
                    ss("Suggestion applied successfully");
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildEventDetails() {
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
              Text(
                "Event Details",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Spacer(),
              GestureDetector(
                onTap: () {
                  showEventDetails = false;
                  selectedEvent = null;
                  setState(() {});
                },
                child: Icon(Icons.close, color: disabledBoldColor),
              ),
            ],
          ),
          if (selectedEvent != null) ...[
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: primaryColor.withAlpha(10),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spXs,
                children: [
                  Text(
                    "${selectedEvent!["type"]}",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Text(
                    "${selectedEvent!["job"]}",
                    style: TextStyle(
                      fontSize: 14,
                      color: disabledBoldColor,
                    ),
                  ),
                  if (selectedEvent!["technician"] != null)
                    Text(
                      "Technician: ${selectedEvent!["technician"]}",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                  if (selectedEvent!["client"] != null)
                    Text(
                      "Client: ${selectedEvent!["client"]}",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                  Text(
                    "Impact: ${selectedEvent!["impact"]}",
                    style: TextStyle(
                      fontSize: 14,
                      color: disabledBoldColor,
                    ),
                  ),
                  Text(
                    "Suggested Action: ${selectedEvent!["nextAction"]}",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: primaryColor,
                    ),
                  ),
                ],
              ),
            ),
            Row(
              spacing: spSm,
              children: [
                Expanded(
                  child: QButton(
                    label: "Dismiss",
                    color: disabledBoldColor,
                    size: bs.sm,
                    onPressed: () {
                      showEventDetails = false;
                      selectedEvent = null;
                      setState(() {});
                    },
                  ),
                ),
                Expanded(
                  child: QButton(
                    label: "Take Action",
                    size: bs.sm,
                    onPressed: () {
                      ss("Action initiated for event");
                      showEventDetails = false;
                      selectedEvent = null;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  String _getTimeAgo(DateTime timestamp) {
    Duration diff = DateTime.now().difference(timestamp);
    if (diff.inMinutes < 1) {
      return "Just now";
    } else if (diff.inMinutes < 60) {
      return "${diff.inMinutes} min ago";
    } else {
      return "${diff.inHours}h ago";
    }
  }
}
