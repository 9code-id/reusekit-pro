import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GeaVoiceChatView extends StatefulWidget {
  const GeaVoiceChatView({super.key});

  @override
  State<GeaVoiceChatView> createState() => _GeaVoiceChatViewState();
}

class _GeaVoiceChatViewState extends State<GeaVoiceChatView> {
  bool isMicEnabled = true;
  bool isSpeakerEnabled = true;
  bool isInVoiceChat = false;
  String selectedRoom = "Party Chat";
  double micVolume = 0.8;
  double speakerVolume = 0.9;

  List<Map<String, dynamic>> voiceRooms = [
    {
      "id": 1,
      "name": "Party Chat",
      "type": "party",
      "maxMembers": 5,
      "currentMembers": 3,
      "isPrivate": true,
      "icon": Icons.groups,
      "color": Color(0xFF9C27B0),
    },
    {
      "id": 2,
      "name": "Guild Hall",
      "type": "guild",
      "maxMembers": 20,
      "currentMembers": 12,
      "isPrivate": false,
      "icon": Icons.group,
      "color": Color(0xFF2196F3),
    },
    {
      "id": 3,
      "name": "Raid Planning",
      "type": "raid",
      "maxMembers": 10,
      "currentMembers": 8,
      "isPrivate": true,
      "icon": Icons.sports_esports,
      "color": Color(0xFFF44336),
    },
    {
      "id": 4,
      "name": "General Chat",
      "type": "public",
      "maxMembers": 50,
      "currentMembers": 34,
      "isPrivate": false,
      "icon": Icons.public,
      "color": Color(0xFF4CAF50),
    },
  ];

  List<Map<String, dynamic>> participants = [
    {
      "id": 1,
      "username": "DragonSlayer99",
      "level": 45,
      "isTalking": true,
      "isMuted": false,
      "isDeafened": false,
      "volume": 0.85,
      "avatar": "https://picsum.photos/50/50?random=1&keyword=avatar",
      "status": "online",
      "role": "Leader",
    },
    {
      "id": 2,
      "username": "MagicMaster",
      "level": 38,
      "isTalking": false,
      "isMuted": false,
      "isDeafened": false,
      "volume": 0.7,
      "avatar": "https://picsum.photos/50/50?random=2&keyword=avatar",
      "status": "online",
      "role": "Member",
    },
    {
      "id": 3,
      "username": "You",
      "level": 42,
      "isTalking": false,
      "isMuted": false,
      "isDeafened": false,
      "volume": 0.8,
      "avatar": "https://picsum.photos/50/50?random=3&keyword=avatar",
      "status": "online",
      "role": "Member",
    },
    {
      "id": 4,
      "username": "HealerQueen",
      "level": 41,
      "isTalking": false,
      "isMuted": true,
      "isDeafened": false,
      "volume": 0.9,
      "avatar": "https://picsum.photos/50/50?random=4&keyword=avatar",
      "status": "away",
      "role": "Member",
    },
    {
      "id": 5,
      "username": "TankWarrior",
      "level": 50,
      "isTalking": false,
      "isMuted": false,
      "isDeafened": true,
      "volume": 0.6,
      "avatar": "https://picsum.photos/50/50?random=5&keyword=avatar",
      "status": "online",
      "role": "Co-Leader",
    },
  ];

  Color _getStatusColor(String status) {
    switch (status) {
      case "online":
        return successColor;
      case "away":
        return warningColor;
      case "busy":
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  Color _getRoleColor(String role) {
    switch (role) {
      case "Leader":
        return Color(0xFFFFD700);
      case "Co-Leader":
        return Color(0xFFFF9800);
      case "Member":
        return primaryColor;
      default:
        return disabledBoldColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentRoom = voiceRooms.firstWhere((room) => room["name"] == selectedRoom);
    
    return Scaffold(
      appBar: AppBar(
        title: Text("Voice Chat"),
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              //navigateTo('VoiceChatSettingsView')
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            // Voice Room Selector
            Container(
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
                    "Voice Rooms",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  
                  ...voiceRooms.map((room) {
                    final isSelected = room["name"] == selectedRoom;
                    final isConnected = isInVoiceChat && isSelected;
                    
                    return GestureDetector(
                      onTap: () {
                        selectedRoom = room["name"] as String;
                        setState(() {});
                      },
                      child: Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: isSelected 
                              ? (room["color"] as Color).withAlpha(30)
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(radiusSm),
                          border: Border.all(
                            color: isSelected 
                                ? (room["color"] as Color)
                                : disabledColor,
                          ),
                        ),
                        child: Row(
                          children: [
                            Container(
                              padding: EdgeInsets.all(spXs),
                              decoration: BoxDecoration(
                                color: room["color"] as Color,
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Icon(
                                room["icon"] as IconData,
                                color: Colors.white,
                                size: 20,
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
                                        "${room["name"]}",
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: primaryColor,
                                        ),
                                      ),
                                      if (room["isPrivate"] == true) ...[
                                        SizedBox(width: spXs),
                                        Icon(
                                          Icons.lock,
                                          size: 14,
                                          color: disabledBoldColor,
                                        ),
                                      ],
                                    ],
                                  ),
                                  
                                  Text(
                                    "${room["currentMembers"]}/${room["maxMembers"]} members",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            
                            if (isConnected)
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: spXs,
                                  vertical: 2,
                                ),
                                decoration: BoxDecoration(
                                  color: successColor,
                                  borderRadius: BorderRadius.circular(radiusSm),
                                ),
                                child: Text(
                                  "CONNECTED",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                    );
                  }),
                ],
              ),
            ),

            // Voice Controls
            Container(
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
                    "Voice Controls",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),

                  // Main Controls
                  Row(
                    children: [
                      Expanded(
                        child: QButton(
                          label: isInVoiceChat ? "Leave Voice" : "Join Voice",
                          size: bs.md,
                          onPressed: () {
                            isInVoiceChat = !isInVoiceChat;
                            setState(() {});
                          },
                        ),
                      ),
                      if (isInVoiceChat) ...[
                        SizedBox(width: spSm),
                        GestureDetector(
                          onTap: () {
                            isMicEnabled = !isMicEnabled;
                            setState(() {});
                          },
                          child: Container(
                            padding: EdgeInsets.all(spSm),
                            decoration: BoxDecoration(
                              color: isMicEnabled 
                                  ? successColor 
                                  : dangerColor,
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Icon(
                              isMicEnabled ? Icons.mic : Icons.mic_off,
                              color: Colors.white,
                              size: 24,
                            ),
                          ),
                        ),
                        SizedBox(width: spXs),
                        GestureDetector(
                          onTap: () {
                            isSpeakerEnabled = !isSpeakerEnabled;
                            setState(() {});
                          },
                          child: Container(
                            padding: EdgeInsets.all(spSm),
                            decoration: BoxDecoration(
                              color: isSpeakerEnabled 
                                  ? successColor 
                                  : dangerColor,
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Icon(
                              isSpeakerEnabled ? Icons.volume_up : Icons.volume_off,
                              color: Colors.white,
                              size: 24,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),

                  if (isInVoiceChat) ...[
                    // Volume Controls
                    Column(
                      spacing: spSm,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.mic,
                              size: 20,
                              color: primaryColor,
                            ),
                            SizedBox(width: spSm),
                            Expanded(
                              child: Slider(
                                value: micVolume,
                                onChanged: (value) {
                                  micVolume = value;
                                  setState(() {});
                                },
                                activeColor: primaryColor,
                                inactiveColor: disabledColor,
                              ),
                            ),
                            Text(
                              "${(micVolume * 100).toInt()}%",
                              style: TextStyle(
                                fontSize: 12,
                                color: primaryColor,
                              ),
                            ),
                          ],
                        ),
                        
                        Row(
                          children: [
                            Icon(
                              Icons.volume_up,
                              size: 20,
                              color: primaryColor,
                            ),
                            SizedBox(width: spSm),
                            Expanded(
                              child: Slider(
                                value: speakerVolume,
                                onChanged: (value) {
                                  speakerVolume = value;
                                  setState(() {});
                                },
                                activeColor: primaryColor,
                                inactiveColor: disabledColor,
                              ),
                            ),
                            Text(
                              "${(speakerVolume * 100).toInt()}%",
                              style: TextStyle(
                                fontSize: 12,
                                color: primaryColor,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ],
              ),
            ),

            // Current Room Info & Participants
            if (isInVoiceChat)
              Container(
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
                        Icon(
                          currentRoom["icon"] as IconData,
                          color: currentRoom["color"] as Color,
                          size: 24,
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Text(
                            "Connected to ${currentRoom["name"]}",
                            style: TextStyle(
                              fontSize: fsH6,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: spXs,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: successColor,
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Text(
                            "LIVE",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),

                    Text(
                      "Participants",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),

                    // Participants List
                    ...participants.map((participant) {
                      final isSelf = participant["username"] == "You";
                      
                      return Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: participant["isTalking"] == true
                              ? successColor.withAlpha(30)
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(radiusSm),
                          border: participant["isTalking"] == true
                              ? Border.all(color: successColor)
                              : null,
                        ),
                        child: Row(
                          children: [
                            Stack(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(radiusLg),
                                  child: Image.network(
                                    "${participant["avatar"]}",
                                    width: 40,
                                    height: 40,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Positioned(
                                  bottom: 0,
                                  right: 0,
                                  child: Container(
                                    width: 12,
                                    height: 12,
                                    decoration: BoxDecoration(
                                      color: _getStatusColor(participant["status"] as String),
                                      shape: BoxShape.circle,
                                      border: Border.all(color: Colors.white, width: 2),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            
                            SizedBox(width: spSm),
                            
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        "${participant["username"]}",
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: primaryColor,
                                        ),
                                      ),
                                      SizedBox(width: spXs),
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 4,
                                          vertical: 1,
                                        ),
                                        decoration: BoxDecoration(
                                          color: _getRoleColor(participant["role"] as String),
                                          borderRadius: BorderRadius.circular(radiusXs),
                                        ),
                                        child: Text(
                                          "${participant["role"]}",
                                          style: TextStyle(
                                            fontSize: 8,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  
                                  Text(
                                    "Level ${participant["level"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            // Voice Status Icons
                            Row(
                              children: [
                                if (participant["isTalking"] == true)
                                  Icon(
                                    Icons.graphic_eq,
                                    color: successColor,
                                    size: 20,
                                  ),
                                if (participant["isMuted"] == true)
                                  Icon(
                                    Icons.mic_off,
                                    color: dangerColor,
                                    size: 20,
                                  ),
                                if (participant["isDeafened"] == true)
                                  Icon(
                                    Icons.volume_off,
                                    color: dangerColor,
                                    size: 20,
                                  ),
                                if (!isSelf) ...[
                                  SizedBox(width: spXs),
                                  GestureDetector(
                                    onTap: () {
                                      //navigateTo('ParticipantControlsView', arguments: participant)
                                    },
                                    child: Icon(
                                      Icons.more_vert,
                                      color: disabledBoldColor,
                                      size: 20,
                                    ),
                                  ),
                                ],
                              ],
                            ),
                          ],
                        ),
                      );
                    }),
                  ],
                ),
              ),

            // Quick Actions
            if (isInVoiceChat)
              Container(
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
                      "Quick Actions",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    
                    Row(
                      children: [
                        Expanded(
                          child: QButton(
                            label: "Push to Talk",
                            size: bs.sm,
                            onPressed: () {
                              //navigateTo('PushToTalkView')
                            },
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: QButton(
                            label: "Voice Test",
                            size: bs.sm,
                            onPressed: () {
                              //navigateTo('VoiceTestView')
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
}
