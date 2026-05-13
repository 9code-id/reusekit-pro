import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class ElaBreakoutRoomsView extends StatefulWidget {
  const ElaBreakoutRoomsView({super.key});

  @override
  State<ElaBreakoutRoomsView> createState() => _ElaBreakoutRoomsViewState();
}

class _ElaBreakoutRoomsViewState extends State<ElaBreakoutRoomsView> {
  int numberOfRooms = 3;
  String assignmentMethod = "automatic";
  int roomDuration = 15;
  bool allowParticipantsToReturn = true;
  bool recordBreakoutRooms = false;
  
  List<Map<String, dynamic>> participants = [
    {
      "id": 1,
      "name": "Alice Johnson",
      "email": "alice@student.edu",
      "role": "Student",
      "currentRoom": 1,
      "avatarUrl": "https://picsum.photos/100/100?random=1",
    },
    {
      "id": 2,
      "name": "Bob Smith",
      "email": "bob@student.edu",
      "role": "Student",
      "currentRoom": 1,
      "avatarUrl": "https://picsum.photos/100/100?random=2",
    },
    {
      "id": 3,
      "name": "Carol Davis",
      "email": "carol@student.edu",
      "role": "Student",
      "currentRoom": 2,
      "avatarUrl": "https://picsum.photos/100/100?random=3",
    },
    {
      "id": 4,
      "name": "David Wilson",
      "email": "david@student.edu",
      "role": "Student",
      "currentRoom": 2,
      "avatarUrl": "https://picsum.photos/100/100?random=4",
    },
    {
      "id": 5,
      "name": "Emma Brown",
      "email": "emma@student.edu",
      "role": "Student",
      "currentRoom": 3,
      "avatarUrl": "https://picsum.photos/100/100?random=5",
    },
    {
      "id": 6,
      "name": "Frank Miller",
      "email": "frank@student.edu",
      "role": "Student",
      "currentRoom": 3,
      "avatarUrl": "https://picsum.photos/100/100?random=6",
    },
    {
      "id": 7,
      "name": "Grace Lee",
      "email": "grace@student.edu",
      "role": "Student",
      "currentRoom": null,
      "avatarUrl": "https://picsum.photos/100/100?random=7",
    },
    {
      "id": 8,
      "name": "Henry Clark",
      "email": "henry@student.edu",
      "role": "Student",
      "currentRoom": null,
      "avatarUrl": "https://picsum.photos/100/100?random=8",
    },
  ];

  List<Map<String, dynamic>> breakoutRooms = [];
  bool roomsCreated = false;
  bool roomsActive = false;
  
  @override
  void initState() {
    super.initState();
    _generateBreakoutRooms();
  }

  void _generateBreakoutRooms() {
    breakoutRooms = List.generate(numberOfRooms, (index) {
      return {
        "id": index + 1,
        "name": "Room ${index + 1}",
        "participants": participants.where((p) => p["currentRoom"] == index + 1).toList(),
        "isActive": false,
        "topic": _getRoomTopic(index + 1),
        "createdAt": DateTime.now(),
      };
    });
    roomsCreated = true;
    setState(() {});
  }

  String _getRoomTopic(int roomNumber) {
    final topics = [
      "Calculus Problem Solving",
      "Physics Equations Discussion",
      "Chemistry Lab Analysis",
      "Biology Cell Structure",
      "Math Geometry Proofs",
    ];
    return topics[(roomNumber - 1) % topics.length];
  }

  Widget _buildRoomSetup() {
    if (roomsCreated && roomsActive) return SizedBox.shrink();
    
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
            "Breakout Room Setup",
            style: TextStyle(
              fontSize: fsH5,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: spMd),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Number of Rooms",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: spSm),
                      decoration: BoxDecoration(
                        border: Border.all(color: disabledColor),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<int>(
                          value: numberOfRooms,
                          items: List.generate(8, (index) => index + 2)
                              .map((num) => DropdownMenuItem(
                                    value: num,
                                    child: Text("$num Rooms"),
                                  ))
                              .toList(),
                          onChanged: (value) {
                            numberOfRooms = value!;
                            _generateBreakoutRooms();
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Duration (minutes)",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: spSm),
                      decoration: BoxDecoration(
                        border: Border.all(color: disabledColor),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<int>(
                          value: roomDuration,
                          items: [5, 10, 15, 20, 30, 45, 60]
                              .map((duration) => DropdownMenuItem(
                                    value: duration,
                                    child: Text("$duration min"),
                                  ))
                              .toList(),
                          onChanged: (value) {
                            roomDuration = value!;
                            setState(() {});
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: spMd),
          Text(
            "Assignment Method",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: spSm),
          QCategoryPicker(
            items: [
              {"label": "Automatic", "value": "automatic"},
              {"label": "Manual", "value": "manual"},
              {"label": "Let participants choose", "value": "participant_choice"},
            ],
            value: assignmentMethod,
            onChanged: (index, label, value, item) {
              assignmentMethod = value;
              setState(() {});
            },
          ),
          SizedBox(height: spMd),
          Row(
            children: [
              Icon(
                allowParticipantsToReturn ? Icons.check_box : Icons.check_box_outline_blank,
                color: allowParticipantsToReturn ? primaryColor : disabledBoldColor,
              ),
              SizedBox(width: spSm),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    allowParticipantsToReturn = !allowParticipantsToReturn;
                    setState(() {});
                  },
                  child: Text(
                    "Allow participants to return to main room anytime",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              Icon(
                recordBreakoutRooms ? Icons.check_box : Icons.check_box_outline_blank,
                color: recordBreakoutRooms ? primaryColor : disabledBoldColor,
              ),
              SizedBox(width: spSm),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    recordBreakoutRooms = !recordBreakoutRooms;
                    setState(() {});
                  },
                  child: Text(
                    "Record breakout room sessions",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: spMd),
          Container(
            width: double.infinity,
            child: QButton(
              label: roomsActive ? "Close All Rooms" : "Start Breakout Rooms",
              onPressed: () {
                if (roomsActive) {
                  _closeAllRooms();
                } else {
                  _startBreakoutRooms();
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRoomManagement() {
    if (!roomsCreated) return SizedBox.shrink();
    
    return Container(
      margin: EdgeInsets.only(top: spMd),
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
              Text(
                "Room Management",
                style: TextStyle(
                  fontSize: fsH5,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Spacer(),
              if (roomsActive)
                Container(
                  padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                  decoration: BoxDecoration(
                    color: successColor.withAlpha(25),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 8,
                        height: 8,
                        decoration: BoxDecoration(
                          color: successColor,
                          shape: BoxShape.circle,
                        ),
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "ACTIVE",
                        style: TextStyle(
                          color: successColor,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
          SizedBox(height: spMd),
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: breakoutRooms.map((room) => _buildRoomCard(room)).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildRoomCard(Map<String, dynamic> room) {
    final roomParticipants = room["participants"] as List<Map<String, dynamic>>;
    
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: roomsActive ? primaryColor.withAlpha(25) : Colors.grey.withAlpha(25),
        borderRadius: BorderRadius.circular(radiusMd),
        border: Border.all(
          color: roomsActive ? primaryColor : disabledColor,
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.meeting_room,
                color: roomsActive ? primaryColor : disabledBoldColor,
                size: 20,
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Text(
                  "${room["name"]}",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: roomsActive ? primaryColor : disabledBoldColor,
                  ),
                ),
              ),
              QButton(
                icon: Icons.settings,
                size: bs.sm,
                onPressed: () {
                  _showRoomSettings(room);
                },
              ),
            ],
          ),
          SizedBox(height: spSm),
          Text(
            "${room["topic"]}",
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
              fontStyle: FontStyle.italic,
            ),
          ),
          SizedBox(height: spSm),
          Text(
            "Participants (${roomParticipants.length})",
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: disabledBoldColor,
            ),
          ),
          SizedBox(height: spXs),
          ...roomParticipants.take(3).map((participant) => _buildParticipantRow(participant)),
          if (roomParticipants.length > 3)
            Text(
              "+${roomParticipants.length - 3} more",
              style: TextStyle(
                fontSize: 10,
                color: disabledBoldColor,
              ),
            ),
          SizedBox(height: spSm),
          Row(
            children: [
              Expanded(
                child: QButton(
                  label: roomsActive ? "Join Room" : "Preview",
                  size: bs.sm,
                  onPressed: () {
                    if (roomsActive) {
                      ss("Joining ${room["name"]}");
                    } else {
                      si("Room preview opened");
                    }
                  },
                ),
              ),
              SizedBox(width: spXs),
              QButton(
                icon: Icons.message,
                size: bs.sm,
                onPressed: () {
                  _sendMessageToRoom(room);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildParticipantRow(Map<String, dynamic> participant) {
    return Container(
      margin: EdgeInsets.only(bottom: spXs),
      child: Row(
        children: [
          Container(
            width: 20,
            height: 20,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(radiusLg),
              image: DecorationImage(
                image: NetworkImage("${participant["avatarUrl"]}"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(width: spXs),
          Expanded(
            child: Text(
              "${participant["name"]}",
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w600,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUnassignedParticipants() {
    final unassigned = participants.where((p) => p["currentRoom"] == null).toList();
    if (unassigned.isEmpty) return SizedBox.shrink();
    
    return Container(
      margin: EdgeInsets.only(top: spMd),
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
            "Unassigned Participants (${unassigned.length})",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: spSm),
          ...unassigned.map((participant) => _buildUnassignedParticipantCard(participant)),
        ],
      ),
    );
  }

  Widget _buildUnassignedParticipantCard(Map<String, dynamic> participant) {
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: warningColor.withAlpha(25),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: warningColor),
      ),
      child: Row(
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(radiusLg),
              image: DecorationImage(
                image: NetworkImage("${participant["avatarUrl"]}"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${participant["name"]}",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  "${participant["email"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: spSm),
            decoration: BoxDecoration(
              border: Border.all(color: disabledColor),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<int>(
                hint: Text("Assign", style: TextStyle(fontSize: 12)),
                items: breakoutRooms
                    .map((room) => DropdownMenuItem(
                          value: room["id"] as int,
                          child: Text("${room["name"]}", style: TextStyle(fontSize: 12)),
                        ))
                    .toList(),
                onChanged: (roomId) {
                  _assignParticipantToRoom(participant, roomId!);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _startBreakoutRooms() {
    roomsActive = true;
    breakoutRooms = breakoutRooms.map((room) {
      room["isActive"] = true;
      return room;
    }).toList();
    setState(() {});
    ss("Breakout rooms started! Participants are being moved to their rooms.");
  }

  void _closeAllRooms() {
    roomsActive = false;
    breakoutRooms = breakoutRooms.map((room) {
      room["isActive"] = false;
      return room;
    }).toList();
    setState(() {});
    sw("All breakout rooms closed. Participants returned to main room.");
  }

  void _assignParticipantToRoom(Map<String, dynamic> participant, int roomId) {
    participant["currentRoom"] = roomId;
    _generateBreakoutRooms();
    ss("${participant["name"]} assigned to Room $roomId");
  }

  void _showRoomSettings(Map<String, dynamic> room) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("${room["name"]} Settings"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("Room Topic: ${room["topic"]}"),
            SizedBox(height: spSm),
            Text("Participants: ${(room["participants"] as List).length}"),
            SizedBox(height: spSm),
            Text("Created: ${(room["createdAt"] as DateTime).dMMMy}"),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => back(),
            child: Text("Close"),
          ),
          TextButton(
            onPressed: () {
              back();
              ss("Room settings updated");
            },
            child: Text("Update"),
          ),
        ],
      ),
    );
  }

  void _sendMessageToRoom(Map<String, dynamic> room) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Message to ${room["name"]}"),
        content: TextField(
          decoration: InputDecoration(
            hintText: "Type your message...",
            border: OutlineInputBorder(),
          ),
          maxLines: 3,
        ),
        actions: [
          TextButton(
            onPressed: () => back(),
            child: Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              back();
              ss("Message sent to ${room["name"]}");
            },
            child: Text("Send"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Breakout Rooms"),
        actions: [
          QButton(
            icon: Icons.help,
            size: bs.sm,
            onPressed: () {
              si("Breakout rooms help opened");
            },
          ),
          SizedBox(width: spSm),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildRoomSetup(),
            _buildRoomManagement(),
            _buildUnassignedParticipants(),
          ],
        ),
      ),
    );
  }
}
