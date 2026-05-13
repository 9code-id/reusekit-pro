import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class LcaVideoConferencingView extends StatefulWidget {
  const LcaVideoConferencingView({super.key});

  @override
  State<LcaVideoConferencingView> createState() => _LcaVideoConferencingViewState();
}

class _LcaVideoConferencingViewState extends State<LcaVideoConferencingView> {
  int currentTab = 0;
  bool isMicEnabled = true;
  bool isCameraEnabled = true;
  bool isScreenSharing = false;
  bool isRecording = false;
  String selectedMeeting = "";
  
  List<Map<String, dynamic>> scheduledMeetings = [
    {
      "id": "meeting_001",
      "title": "Client Consultation - Smith Case",
      "clientName": "John Smith",
      "caseNumber": "LIT-2024-001",
      "scheduledTime": "2024-03-25T14:00:00Z",
      "duration": 60,
      "status": "scheduled",
      "participantCount": 3,
      "meetingType": "consultation",
      "isRecordingEnabled": true,
      "roomId": "room_smith_001",
      "participants": [
        {
          "name": "John Smith",
          "role": "Client",
          "email": "john.smith@email.com",
          "avatar": "https://picsum.photos/100/100?random=1&keyword=person"
        },
        {
          "name": "Attorney Sarah",
          "role": "Lead Attorney",
          "email": "sarah@lawfirm.com",
          "avatar": "https://picsum.photos/100/100?random=2&keyword=person"
        },
        {
          "name": "Paralegal Mike",
          "role": "Paralegal",
          "email": "mike@lawfirm.com",
          "avatar": "https://picsum.photos/100/100?random=3&keyword=person"
        }
      ]
    },
    {
      "id": "meeting_002",
      "title": "Deposition - Wilson vs State",
      "clientName": "Sarah Wilson",
      "caseNumber": "FAM-2024-003",
      "scheduledTime": "2024-03-22T10:00:00Z",
      "duration": 120,
      "status": "in_progress",
      "participantCount": 5,
      "meetingType": "deposition",
      "isRecordingEnabled": true,
      "roomId": "room_wilson_002",
      "participants": [
        {
          "name": "Sarah Wilson",
          "role": "Client",
          "email": "sarah.wilson@email.com",
          "avatar": "https://picsum.photos/100/100?random=4&keyword=person"
        },
        {
          "name": "Judge Roberts",
          "role": "Judge",
          "email": "judge.roberts@court.gov",
          "avatar": "https://picsum.photos/100/100?random=5&keyword=person"
        }
      ]
    },
    {
      "id": "meeting_003",
      "title": "Settlement Discussion",
      "clientName": "Michael Davis",
      "caseNumber": "COR-2024-007",
      "scheduledTime": "2024-03-28T16:30:00Z",
      "duration": 90,
      "status": "scheduled",
      "participantCount": 4,
      "meetingType": "settlement",
      "isRecordingEnabled": false,
      "roomId": "room_davis_003",
      "participants": [
        {
          "name": "Michael Davis",
          "role": "Client",
          "email": "michael.davis@email.com",
          "avatar": "https://picsum.photos/100/100?random=6&keyword=person"
        }
      ]
    }
  ];

  List<Map<String, dynamic>> meetingHistory = [
    {
      "id": "hist_001",
      "title": "Contract Review Meeting",
      "clientName": "ABC Corporation",
      "caseNumber": "COR-2024-005",
      "meetingDate": "2024-03-18T15:00:00Z",
      "duration": 45,
      "attendees": 3,
      "recordingAvailable": true,
      "recordingUrl": "https://recordings.lawfirm.com/meeting_001.mp4",
      "notes": "Discussed contract amendments and liability clauses"
    },
    {
      "id": "hist_002",
      "title": "Pre-trial Conference",
      "clientName": "Johnson Family",
      "caseNumber": "FAM-2024-002",
      "meetingDate": "2024-03-15T11:00:00Z",
      "duration": 75,
      "attendees": 4,
      "recordingAvailable": true,
      "recordingUrl": "https://recordings.lawfirm.com/meeting_002.mp4",
      "notes": "Prepared for upcoming trial proceedings"
    }
  ];

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Video Conferencing",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Meetings", icon: Icon(Icons.video_call)),
        Tab(text: "Schedule", icon: Icon(Icons.calendar_today)),
        Tab(text: "History", icon: Icon(Icons.history)),
        Tab(text: "Settings", icon: Icon(Icons.settings)),
      ],
      tabChildren: [
        _buildMeetingsTab(),
        _buildScheduleTab(),
        _buildHistoryTab(),
        _buildSettingsTab(),
      ],
    );
  }

  Widget _buildMeetingsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Quick Start Meeting
          _buildQuickStartSection(),
          
          SizedBox(height: spLg),
          
          // Upcoming Meetings
          _buildUpcomingMeetings(),
          
          SizedBox(height: spLg),
          
          // Active Meetings
          _buildActiveMeetings(),
        ],
      ),
    );
  }

  Widget _buildQuickStartSection() {
    return Container(
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
            "Quick Start",
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
                  label: "Start Instant Meeting",
                  icon: Icons.video_call,
                  size: bs.md,
                  onPressed: _startInstantMeeting,
                ),
              ),
              SizedBox(width: spMd),
              Expanded(
                child: QButton(
                  label: "Join Meeting",
                  icon: Icons.meeting_room,
                  size: bs.md,
                  onPressed: _showJoinMeetingDialog,
                ),
              ),
            ],
          ),
          
          SizedBox(height: spMd),
          
          // Device Status
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.grey[50],
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Row(
              children: [
                _buildDeviceStatus("Camera", isCameraEnabled, Icons.videocam),
                SizedBox(width: spMd),
                _buildDeviceStatus("Microphone", isMicEnabled, Icons.mic),
                SizedBox(width: spMd),
                _buildDeviceStatus("Speaker", true, Icons.volume_up),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDeviceStatus(String device, bool isEnabled, IconData icon) {
    return Expanded(
      child: Row(
        children: [
          Icon(
            icon,
            size: 16,
            color: isEnabled ? successColor : dangerColor,
          ),
          SizedBox(width: spXs),
          Text(
            device,
            style: TextStyle(
              fontSize: 12,
              color: isEnabled ? successColor : dangerColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUpcomingMeetings() {
    final upcomingMeetings = scheduledMeetings
        .where((meeting) => meeting["status"] == "scheduled")
        .toList();

    return Container(
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
            "Upcoming Meetings",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          
          SizedBox(height: spMd),
          
          if (upcomingMeetings.isEmpty)
            Center(
              child: Text(
                "No upcoming meetings scheduled",
                style: TextStyle(
                  color: disabledBoldColor,
                ),
              ),
            )
          else
            ...upcomingMeetings.map((meeting) => _buildMeetingCard(meeting)).toList(),
        ],
      ),
    );
  }

  Widget _buildActiveMeetings() {
    final activeMeetings = scheduledMeetings
        .where((meeting) => meeting["status"] == "in_progress")
        .toList();

    if (activeMeetings.isEmpty) return SizedBox.shrink();

    return Container(
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
            "Active Meetings",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: dangerColor,
            ),
          ),
          
          SizedBox(height: spMd),
          
          ...activeMeetings.map((meeting) => _buildActiveMeetingCard(meeting)).toList(),
        ],
      ),
    );
  }

  Widget _buildMeetingCard(Map<String, dynamic> meeting) {
    Color typeColor = meeting["meetingType"] == "consultation" ? primaryColor :
                     meeting["meetingType"] == "deposition" ? warningColor :
                     meeting["meetingType"] == "settlement" ? successColor : infoColor;

    return Container(
      margin: EdgeInsets.only(bottom: spMd),
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(radiusMd),
        border: Border(
          left: BorderSide(
            width: 4,
            color: typeColor,
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
                      "${meeting["title"]}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "${meeting["clientName"]} • ${meeting["caseNumber"]}",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: typeColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "${meeting["meetingType"]}".toUpperCase(),
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: typeColor,
                  ),
                ),
              ),
            ],
          ),
          
          SizedBox(height: spMd),
          
          Row(
            children: [
              Icon(
                Icons.schedule,
                size: 16,
                color: disabledBoldColor,
              ),
              SizedBox(width: spXs),
              Text(
                DateTime.parse("${meeting["scheduledTime"]}").dMMMykkss,
                style: TextStyle(
                  fontSize: 14,
                  color: disabledBoldColor,
                ),
              ),
              SizedBox(width: spMd),
              Icon(
                Icons.timer,
                size: 16,
                color: disabledBoldColor,
              ),
              SizedBox(width: spXs),
              Text(
                "${meeting["duration"]} min",
                style: TextStyle(
                  fontSize: 14,
                  color: disabledBoldColor,
                ),
              ),
              SizedBox(width: spMd),
              Icon(
                Icons.people,
                size: 16,
                color: disabledBoldColor,
              ),
              SizedBox(width: spXs),
              Text(
                "${meeting["participantCount"]} participants",
                style: TextStyle(
                  fontSize: 14,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
          
          SizedBox(height: spMd),
          
          // Participants Preview
          Row(
            children: [
              Text(
                "Participants: ",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: disabledBoldColor,
                ),
              ),
              ...((meeting["participants"] as List).take(3).map((participant) => 
                Container(
                  margin: EdgeInsets.only(left: 4),
                  child: CircleAvatar(
                    radius: 12,
                    backgroundImage: NetworkImage("${participant["avatar"]}"),
                  ),
                ),
              )).toList(),
              if ((meeting["participants"] as List).length > 3)
                Container(
                  margin: EdgeInsets.only(left: 4),
                  child: CircleAvatar(
                    radius: 12,
                    backgroundColor: primaryColor,
                    child: Text(
                      "+${(meeting["participants"] as List).length - 3}",
                      style: TextStyle(
                        fontSize: 8,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
            ],
          ),
          
          SizedBox(height: spMd),
          
          Row(
            children: [
              QButton(
                label: "Join Meeting",
                icon: Icons.video_call,
                size: bs.sm,
                onPressed: () => _joinMeeting(meeting),
              ),
              SizedBox(width: spSm),
              QButton(
                label: "Details",
                icon: Icons.info,
                size: bs.sm,
                onPressed: () => _showMeetingDetails(meeting),
              ),
              if (meeting["isRecordingEnabled"])
                Padding(
                  padding: EdgeInsets.only(left: spSm),
                  child: Icon(
                    Icons.fiber_manual_record,
                    size: 16,
                    color: dangerColor,
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActiveMeetingCard(Map<String, dynamic> meeting) {
    return Container(
      margin: EdgeInsets.only(bottom: spMd),
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: dangerColor.withAlpha(20),
        borderRadius: BorderRadius.circular(radiusMd),
        border: Border.all(color: dangerColor.withAlpha(50)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(spXs),
                decoration: BoxDecoration(
                  color: dangerColor,
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Icon(
                  Icons.circle,
                  size: 8,
                  color: Colors.white,
                ),
              ),
              SizedBox(width: spSm),
              Text(
                "LIVE",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: dangerColor,
                ),
              ),
              Spacer(),
              Text(
                "In Progress",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: dangerColor,
                ),
              ),
            ],
          ),
          
          SizedBox(height: spSm),
          
          Text(
            "${meeting["title"]}",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          
          SizedBox(height: spXs),
          
          Text(
            "${meeting["clientName"]} • ${meeting["participantCount"]} participants",
            style: TextStyle(
              fontSize: 14,
              color: disabledBoldColor,
            ),
          ),
          
          SizedBox(height: spMd),
          
          QButton(
            label: "Join Active Meeting",
            icon: Icons.meeting_room,
            size: bs.sm,
            onPressed: () => _joinMeeting(meeting),
          ),
        ],
      ),
    );
  }

  Widget _buildScheduleTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Schedule New Meeting",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          
          SizedBox(height: spLg),
          
          _buildScheduleForm(),
        ],
      ),
    );
  }

  Widget _buildScheduleForm() {
    String meetingTitle = "";
    String clientName = "";
    String caseNumber = "";
    String selectedDate = DateTime.now().add(Duration(days: 1)).toIso8601String();
    String selectedTime = "10:00";
    int duration = 60;
    bool enableRecording = true;
    
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          QTextField(
            label: "Meeting Title",
            value: meetingTitle,
            hint: "e.g., Client Consultation - Smith Case",
            onChanged: (value) {
              meetingTitle = value;
              setState(() {});
            },
          ),
          
          SizedBox(height: spMd),
          
          Row(
            children: [
              Expanded(
                child: QTextField(
                  label: "Client Name",
                  value: clientName,
                  hint: "Client full name",
                  onChanged: (value) {
                    clientName = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spMd),
              Expanded(
                child: QTextField(
                  label: "Case Number",
                  value: caseNumber,
                  hint: "e.g., LIT-2024-001",
                  onChanged: (value) {
                    caseNumber = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
          
          SizedBox(height: spMd),
          
          Row(
            children: [
              Expanded(
                child: QDatePicker(
                  label: "Meeting Date",
                  value: DateTime.parse(selectedDate),
                  onChanged: (value) {
                    selectedDate = value.toIso8601String();
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spMd),
              Expanded(
                child: QTimePicker(
                  label: "Meeting Time",
                  value: selectedTime.timeOfDay,
                  onChanged: (value) {
                    selectedTime = value!.kkmm;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
          
          SizedBox(height: spMd),
          
          QNumberField(
            label: "Duration (minutes)",
            value: duration.toString(),
            onChanged: (value) {
              duration = int.tryParse(value) ?? 60;
              setState(() {});
            },
          ),
          
          SizedBox(height: spMd),
          
          QSwitch(
            items: [
              {
                "label": "Enable Meeting Recording",
                "value": true,
                "checked": enableRecording,
              }
            ],
            value: [
              if (enableRecording)
                {
                  "label": "Enable Meeting Recording",
                  "value": true,
                  "checked": true
                }
            ],
            onChanged: (values, ids) {
              enableRecording = values.isNotEmpty;
              setState(() {});
            },
          ),
          
          SizedBox(height: spLg),
          
          Container(
            width: double.infinity,
            child: QButton(
              label: "Schedule Meeting",
              icon: Icons.schedule,
              size: bs.md,
              onPressed: () {
                _scheduleMeeting({
                  "title": meetingTitle,
                  "clientName": clientName,
                  "caseNumber": caseNumber,
                  "scheduledTime": selectedDate,
                  "duration": duration,
                  "enableRecording": enableRecording,
                });
              },
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Meeting History",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          
          SizedBox(height: spLg),
          
          ...meetingHistory.map((meeting) => _buildHistoryCard(meeting)).toList(),
        ],
      ),
    );
  }

  Widget _buildHistoryCard(Map<String, dynamic> meeting) {
    return Container(
      margin: EdgeInsets.only(bottom: spMd),
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
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${meeting["title"]}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "${meeting["clientName"]} • ${meeting["caseNumber"]}",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              if (meeting["recordingAvailable"])
                Container(
                  padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                  decoration: BoxDecoration(
                    color: successColor.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusXs),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.play_circle,
                        size: 14,
                        color: successColor,
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "RECORDED",
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: successColor,
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
          
          SizedBox(height: spMd),
          
          Row(
            children: [
              Icon(
                Icons.date_range,
                size: 16,
                color: disabledBoldColor,
              ),
              SizedBox(width: spXs),
              Text(
                DateTime.parse("${meeting["meetingDate"]}").dMMMykkss,
                style: TextStyle(
                  fontSize: 14,
                  color: disabledBoldColor,
                ),
              ),
              SizedBox(width: spMd),
              Icon(
                Icons.timer,
                size: 16,
                color: disabledBoldColor,
              ),
              SizedBox(width: spXs),
              Text(
                "${meeting["duration"]} min",
                style: TextStyle(
                  fontSize: 14,
                  color: disabledBoldColor,
                ),
              ),
              SizedBox(width: spMd),
              Icon(
                Icons.people,
                size: 16,
                color: disabledBoldColor,
              ),
              SizedBox(width: spXs),
              Text(
                "${meeting["attendees"]} attendees",
                style: TextStyle(
                  fontSize: 14,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
          
          if (meeting["notes"] != null) ...[
            SizedBox(height: spMd),
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.grey[50],
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Meeting Notes",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spXs),
                  Text(
                    "${meeting["notes"]}",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ),
            ),
          ],
          
          SizedBox(height: spMd),
          
          Row(
            children: [
              if (meeting["recordingAvailable"])
                QButton(
                  label: "Play Recording",
                  icon: Icons.play_arrow,
                  size: bs.sm,
                  onPressed: () => _playRecording(meeting),
                ),
              if (meeting["recordingAvailable"])
                SizedBox(width: spSm),
              QButton(
                label: "View Details",
                icon: Icons.info,
                size: bs.sm,
                onPressed: () => _showMeetingDetails(meeting),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Video Conference Settings",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          
          SizedBox(height: spLg),
          
          _buildAudioVideoSettings(),
          
          SizedBox(height: spLg),
          
          _buildRecordingSettings(),
          
          SizedBox(height: spLg),
          
          _buildSecuritySettings(),
        ],
      ),
    );
  }

  Widget _buildAudioVideoSettings() {
    return Container(
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
            "Audio & Video",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          
          SizedBox(height: spMd),
          
          QSwitch(
            items: [
              {
                "label": "Auto-start camera",
                "value": "camera",
                "checked": isCameraEnabled,
              }
            ],
            value: [
              if (isCameraEnabled)
                {
                  "label": "Auto-start camera",
                  "value": "camera",
                  "checked": true
                }
            ],
            onChanged: (values, ids) {
              isCameraEnabled = values.any((v) => v["value"] == "camera");
              setState(() {});
            },
          ),
          
          SizedBox(height: spSm),
          
          QSwitch(
            items: [
              {
                "label": "Auto-start microphone",
                "value": "mic",
                "checked": isMicEnabled,
              }
            ],
            value: [
              if (isMicEnabled)
                {
                  "label": "Auto-start microphone",
                  "value": "mic",
                  "checked": true
                }
            ],
            onChanged: (values, ids) {
              isMicEnabled = values.any((v) => v["value"] == "mic");
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  Widget _buildRecordingSettings() {
    return Container(
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
            "Recording Settings",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          
          SizedBox(height: spMd),
          
          QSwitch(
            items: [
              {
                "label": "Auto-record meetings",
                "value": "auto_record",
                "checked": isRecording,
              }
            ],
            value: [
              if (isRecording)
                {
                  "label": "Auto-record meetings",
                  "value": "auto_record",
                  "checked": true
                }
            ],
            onChanged: (values, ids) {
              isRecording = values.any((v) => v["value"] == "auto_record");
              setState(() {});
            },
          ),
          
          SizedBox(height: spMd),
          
          Text(
            "Recording Storage",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: disabledBoldColor,
            ),
          ),
          SizedBox(height: spSm),
          Text(
            "Recordings are stored securely and encrypted. Available for 30 days after meeting.",
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSecuritySettings() {
    return Container(
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
            "Security & Privacy",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          
          SizedBox(height: spMd),
          
          QSwitch(
            items: [
              {
                "label": "Require meeting password",
                "value": "password",
                "checked": true,
              }
            ],
            value: [
              {
                "label": "Require meeting password",
                "value": "password",
                "checked": true
              }
            ],
            onChanged: (values, ids) {
              // Handle password requirement
            },
          ),
          
          SizedBox(height: spSm),
          
          QSwitch(
            items: [
              {
                "label": "Enable waiting room",
                "value": "waiting_room",
                "checked": true,
              }
            ],
            value: [
              {
                "label": "Enable waiting room",
                "value": "waiting_room",
                "checked": true
              }
            ],
            onChanged: (values, ids) {
              // Handle waiting room
            },
          ),
        ],
      ),
    );
  }

  void _startInstantMeeting() {
    ss("Starting instant meeting...");
    // Navigate to meeting room
  }

  void _showJoinMeetingDialog() {
    String meetingId = "";
    String meetingPassword = "";
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Join Meeting"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            QTextField(
              label: "Meeting ID",
              value: meetingId,
              hint: "Enter meeting ID",
              onChanged: (value) {
                meetingId = value;
              },
            ),
            SizedBox(height: spMd),
            QTextField(
              label: "Password (optional)",
              value: meetingPassword,
              hint: "Meeting password",
              onChanged: (value) {
                meetingPassword = value;
              },
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              if (meetingId.isNotEmpty) {
                ss("Joining meeting: $meetingId");
              }
            },
            child: Text("Join"),
          ),
        ],
      ),
    );
  }

  void _joinMeeting(Map<String, dynamic> meeting) {
    ss("Joining meeting: ${meeting["title"]}");
    // Navigate to meeting room
  }

  void _showMeetingDetails(Map<String, dynamic> meeting) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Meeting Details"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Title: ${meeting["title"]}"),
            SizedBox(height: spSm),
            Text("Client: ${meeting["clientName"] ?? meeting["client"]}"),
            SizedBox(height: spSm),
            Text("Room ID: ${meeting["roomId"] ?? meeting["id"]}"),
            if (meeting["scheduledTime"] != null) ...[
              SizedBox(height: spSm),
              Text("Time: ${DateTime.parse("${meeting["scheduledTime"]}").dMMMykkss}"),
            ] else if (meeting["meetingDate"] != null) ...[
              SizedBox(height: spSm),
              Text("Date: ${DateTime.parse("${meeting["meetingDate"]}").dMMMykkss}"),
            ],
          ],
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

  void _scheduleMeeting(Map<String, dynamic> meetingData) {
    if (meetingData["title"].isEmpty || meetingData["clientName"].isEmpty) {
      se("Please fill in all required fields");
      return;
    }
    
    ss("Meeting scheduled successfully");
    // Add to scheduled meetings list
  }

  void _playRecording(Map<String, dynamic> meeting) {
    ss("Playing recording for: ${meeting["title"]}");
    // Open video player
  }
}
