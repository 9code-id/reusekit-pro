import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class CmaPhoneCallView extends StatefulWidget {
  const CmaPhoneCallView({super.key});

  @override
  State<CmaPhoneCallView> createState() => _CmaPhoneCallViewState();
}

class _CmaPhoneCallViewState extends State<CmaPhoneCallView> {
  String contactNumber = "";
  String selectedContact = "";
  String callNote = "";
  bool isRecording = false;
  bool isMuted = false;
  bool isSpeakerOn = false;
  bool isOnCall = false;
  String callTimer = "00:00:00";
  String callStatus = "Ready to call";
  
  List<Map<String, dynamic>> recentContacts = [
    {
      "id": 1,
      "name": "John Smith",
      "phone": "+1 (555) 123-4567",
      "company": "ABC Corp",
      "last_call": DateTime.now().subtract(Duration(hours: 2)),
      "call_count": 5,
      "avatar": "https://picsum.photos/60/60?random=1&keyword=person",
      "status": "available",
    },
    {
      "id": 2,
      "name": "Sarah Johnson",
      "phone": "+1 (555) 987-6543",
      "company": "XYZ Industries",
      "last_call": DateTime.now().subtract(Duration(days: 1)),
      "call_count": 3,
      "avatar": "https://picsum.photos/60/60?random=2&keyword=person",
      "status": "busy",
    },
    {
      "id": 3,
      "name": "Mike Davis",
      "phone": "+1 (555) 456-7890",
      "company": "Tech Solutions",
      "last_call": DateTime.now().subtract(Duration(days: 3)),
      "call_count": 8,
      "avatar": "https://picsum.photos/60/60?random=3&keyword=person",
      "status": "available",
    },
    {
      "id": 4,
      "name": "Emma Wilson",
      "phone": "+1 (555) 789-0123",
      "company": "Design Studio",
      "last_call": DateTime.now().subtract(Duration(days: 5)),
      "call_count": 2,
      "avatar": "https://picsum.photos/60/60?random=4&keyword=person",
      "status": "offline",
    },
    {
      "id": 5,
      "name": "Robert Brown",
      "phone": "+1 (555) 321-6547",
      "company": "Marketing Plus",
      "last_call": DateTime.now().subtract(Duration(days: 7)),
      "call_count": 6,
      "avatar": "https://picsum.photos/60/60?random=5&keyword=person",
      "status": "available",
    },
  ];

  List<Map<String, dynamic>> contactOptions = [
    {"label": "John Smith - ABC Corp", "value": "1"},
    {"label": "Sarah Johnson - XYZ Industries", "value": "2"},
    {"label": "Mike Davis - Tech Solutions", "value": "3"},
    {"label": "Emma Wilson - Design Studio", "value": "4"},
    {"label": "Robert Brown - Marketing Plus", "value": "5"},
  ];

  Color getStatusColor(String status) {
    switch (status) {
      case "available":
        return successColor;
      case "busy":
        return dangerColor;
      case "offline":
        return disabledBoldColor;
      default:
        return disabledColor;
    }
  }

  void _makeCall() {
    setState(() {
      isOnCall = true;
      callStatus = "Calling...";
    });
    
    // Simulate call connection after 3 seconds
    Future.delayed(Duration(seconds: 3), () {
      if (mounted) {
        setState(() {
          callStatus = "Connected";
        });
        _startCallTimer();
      }
    });
  }

  void _endCall() {
    setState(() {
      isOnCall = false;
      callStatus = "Call ended";
      callTimer = "00:00:00";
      isRecording = false;
      isMuted = false;
      isSpeakerOn = false;
    });
    
    // Reset status after 2 seconds
    Future.delayed(Duration(seconds: 2), () {
      if (mounted) {
        setState(() {
          callStatus = "Ready to call";
        });
      }
    });
  }

  void _startCallTimer() {
    // This would normally use a timer to update callTimer
    // For demo purposes, we'll just show a static time
    setState(() {
      callTimer = "00:03:45";
    });
  }

  Widget _buildDialPad() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          Row(
            children: [
              Icon(Icons.phone, color: primaryColor, size: 24),
              SizedBox(width: spSm),
              Text(
                "Make a Call",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          
          // Contact Selection
          QDropdownField(
            label: "Select Contact",
            items: contactOptions,
            value: selectedContact,
            onChanged: (value, label) {
              selectedContact = value;
              final contact = recentContacts.firstWhere((c) => "${c["id"]}" == value);
              contactNumber = "${contact["phone"]}";
              setState(() {});
            },
          ),
          
          // Manual Number Entry
          QTextField(
            label: "Phone Number",
            value: contactNumber,
            hint: "+1 (555) 123-4567",
            onChanged: (value) {
              contactNumber = value;
              setState(() {});
            },
          ),
          
          // Call Status Display
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: isOnCall ? successColor.withAlpha(30) : infoColor.withAlpha(30),
              borderRadius: BorderRadius.circular(radiusMd),
            ),
            child: Row(
              children: [
                Icon(
                  isOnCall ? Icons.phone_in_talk : Icons.phone_enabled,
                  color: isOnCall ? successColor : infoColor,
                  size: 20,
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        callStatus,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: isOnCall ? successColor : infoColor,
                        ),
                      ),
                      if (isOnCall)
                        Text(
                          "Duration: $callTimer",
                          style: TextStyle(
                            fontSize: 12,
                            color: isOnCall ? successColor : infoColor,
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          
          // Call Controls
          if (!isOnCall)
            Container(
              width: double.infinity,
              child: QButton(
                label: "Start Call",
                icon: Icons.phone,
                size: bs.md,
                onPressed: contactNumber.isNotEmpty ? _makeCall : null,
              ),
            )
          else
            Row(
              children: [
                Expanded(
                  child: QButton(
                    label: isMuted ? "Unmute" : "Mute",
                    icon: isMuted ? Icons.mic_off : Icons.mic,
                    color: isMuted ? warningColor : primaryColor,
                    size: bs.sm,
                    onPressed: () {
                      isMuted = !isMuted;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QButton(
                    label: isSpeakerOn ? "Speaker Off" : "Speaker On",
                    icon: isSpeakerOn ? Icons.volume_up : Icons.volume_down,
                    color: isSpeakerOn ? infoColor : primaryColor,
                    size: bs.sm,
                    onPressed: () {
                      isSpeakerOn = !isSpeakerOn;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QButton(
                    label: isRecording ? "Stop Rec" : "Record",
                    icon: isRecording ? Icons.stop : Icons.fiber_manual_record,
                    color: isRecording ? dangerColor : primaryColor,
                    size: bs.sm,
                    onPressed: () {
                      isRecording = !isRecording;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),
          
          if (isOnCall)
            Container(
              width: double.infinity,
              child: QButton(
                label: "End Call",
                icon: Icons.call_end,
                color: dangerColor,
                size: bs.md,
                onPressed: _endCall,
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildRecentContacts() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(spMd),
            child: Row(
              children: [
                Icon(Icons.recent_actors, color: primaryColor, size: 20),
                SizedBox(width: spSm),
                Text(
                  "Recent Contacts",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
              ],
            ),
          ),
          Divider(height: 1),
          ListView.separated(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: recentContacts.length,
            separatorBuilder: (context, index) => Divider(height: 1),
            itemBuilder: (context, index) {
              final contact = recentContacts[index];
              return _buildContactCard(contact);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildContactCard(Map<String, dynamic> contact) {
    return Container(
      padding: EdgeInsets.all(spMd),
      child: Row(
        children: [
          // Avatar
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(radiusLg),
              image: DecorationImage(
                image: NetworkImage("${contact["avatar"]}"),
                fit: BoxFit.cover,
              ),
            ),
            child: Stack(
              children: [
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    width: 14,
                    height: 14,
                    decoration: BoxDecoration(
                      color: getStatusColor("${contact["status"]}"),
                      borderRadius: BorderRadius.circular(radiusLg),
                      border: Border.all(color: Colors.white, width: 2),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: spSm),
          
          // Contact Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${contact["name"]}",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "${contact["company"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
                Text(
                  "${contact["phone"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
          
          // Call Stats
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                "${contact["call_count"]} calls",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: primaryColor,
                ),
              ),
              Text(
                "${(contact["last_call"] as DateTime).dMMMy}",
                style: TextStyle(
                  fontSize: 10,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
          SizedBox(width: spSm),
          
          // Call Button
          QButton(
            icon: Icons.phone,
            size: bs.sm,
            onPressed: () {
              contactNumber = "${contact["phone"]}";
              selectedContact = "${contact["id"]}";
              setState(() {});
              _makeCall();
            },
          ),
        ],
      ),
    );
  }

  Widget _buildCallNotes() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          Row(
            children: [
              Icon(Icons.note_add, color: primaryColor, size: 20),
              SizedBox(width: spSm),
              Text(
                "Call Notes",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          
          QMemoField(
            label: "Add call notes...",
            value: callNote,
            hint: "Record important points from your call",
            onChanged: (value) {
              callNote = value;
              setState(() {});
            },
          ),
          
          Row(
            children: [
              Expanded(
                child: QButton(
                  label: "Save Notes",
                  icon: Icons.save,
                  size: bs.md,
                  onPressed: callNote.isNotEmpty ? () {
                    ss("Call notes saved successfully");
                    callNote = "";
                    setState(() {});
                  } : null,
                ),
              ),
              SizedBox(width: spSm),
              QButton(
                icon: Icons.clear,
                color: disabledBoldColor,
                size: bs.sm,
                onPressed: () {
                  callNote = "";
                  setState(() {});
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActions() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          Text(
            "Quick Actions",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: [
              _buildActionCard("Call Log", "View call history", Icons.history, infoColor, () {}),
              _buildActionCard("Voicemail", "Check messages", Icons.voicemail, warningColor, () {}),
              _buildActionCard("Conference", "Start meeting", Icons.group_add, successColor, () {}),
              _buildActionCard("Call Queue", "Manage queue", Icons.queue, primaryColor, () {}),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActionCard(String title, String subtitle, IconData icon, Color color, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(spMd),
        decoration: BoxDecoration(
          color: color.withAlpha(30),
          borderRadius: BorderRadius.circular(radiusMd),
          border: Border.all(color: color.withAlpha(100)),
        ),
        child: Column(
          children: [
            Icon(icon, color: color, size: 32),
            SizedBox(height: spSm),
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            Text(
              subtitle,
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Phone Call"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            _buildDialPad(),
            _buildRecentContacts(),
            _buildCallNotes(),
            _buildQuickActions(),
          ],
        ),
      ),
    );
  }
}
