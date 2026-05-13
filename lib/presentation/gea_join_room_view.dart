import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GeaJoinRoomView extends StatefulWidget {
  const GeaJoinRoomView({super.key});

  @override
  State<GeaJoinRoomView> createState() => _GeaJoinRoomViewState();
}

class _GeaJoinRoomViewState extends State<GeaJoinRoomView> {
  final formKey = GlobalKey<FormState>();
  
  String roomCode = "";
  String password = "";
  bool isJoining = false;

  // Simulated room data based on room code
  Map<String, dynamic>? roomInfo;

  void searchRoom() {
    if (roomCode.isEmpty) {
      se("Please enter a room code");
      return;
    }

    setState(() {
      isJoining = true;
    });

    // Simulate room search
    Future.delayed(Duration(seconds: 1), () {
      setState(() {
        isJoining = false;
        // Simulate finding room
        roomInfo = {
          "id": 1,
          "name": "Elite Battle Arena",
          "code": roomCode.toUpperCase(),
          "host": "ProSniper",
          "hostAvatar": "https://picsum.photos/60/60?random=1&keyword=gamer",
          "mode": "Battle Royale",
          "map": "Apocalypse Zone",
          "players": 8,
          "maxPlayers": 10,
          "ping": 25,
          "region": "US East",
          "isPrivate": roomCode.length > 6,
          "hasPassword": roomCode.length > 6,
          "difficulty": "Hard",
          "status": "Waiting",
          "level": "35+",
          "description": "Competitive Battle Royale for experienced players. Good communication required.",
          "allowSpectators": true,
          "autoStart": true,
        };
      });
    });
  }

  void joinRoom() {
    if (formKey.currentState!.validate()) {
      showLoading();
      
      // Simulate joining room
      Future.delayed(Duration(seconds: 2), () {
        hideLoading();
        ss("Successfully joined the room!");
        //navigateTo('GameLobbyView', arguments: roomInfo)
        back();
      });
    }
  }

  void clearSearch() {
    setState(() {
      roomCode = "";
      roomInfo = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Join Room"),
        actions: [
          IconButton(
            icon: Icon(Icons.qr_code_scanner),
            onPressed: () {
              //navigateTo('QRScannerView')
            },
          ),
        ],
      ),
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: Column(
            spacing: spMd,
            children: [
              // Join by Code Section
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
                          Icons.vpn_key,
                          color: primaryColor,
                          size: 20,
                        ),
                        SizedBox(width: spXs),
                        Text(
                          "Join by Room Code",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      "Enter the room code provided by the host",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: QTextField(
                            label: "Room Code",
                            value: roomCode,
                            hint: "Enter 6-8 character room code",
                            validator: Validator.required,
                            onChanged: (value) {
                              roomCode = value.toUpperCase();
                              if (roomInfo != null) {
                                roomInfo = null;
                              }
                              setState(() {});
                            },
                          ),
                        ),
                        SizedBox(width: spSm),
                        QButton(
                          label: isJoining ? "Searching..." : "Search",
                          size: bs.sm,
                          onPressed: isJoining ? null : searchRoom,
                        ),
                      ],
                    ),
                    if (roomCode.isNotEmpty && roomInfo == null && !isJoining)
                      Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: warningColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusSm),
                          border: Border.all(color: warningColor.withAlpha(50)),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.info,
                              color: warningColor,
                              size: 16,
                            ),
                            SizedBox(width: spXs),
                            Expanded(
                              child: Text(
                                "Click 'Search' to find the room",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: warningColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
              ),

              // Quick Join Options
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
                          Icons.flash_on,
                          color: successColor,
                          size: 20,
                        ),
                        SizedBox(width: spXs),
                        Text(
                          "Quick Join Options",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: QButton(
                            label: "Random Room",
                            size: bs.sm,
                            onPressed: () {
                              //navigateTo('RandomRoomView')
                            },
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: QButton(
                            label: "Browse Rooms",
                            size: bs.sm,
                            onPressed: () {
                              //navigateTo('RoomBrowserView')
                            },
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: QButton(
                            icon: Icons.qr_code_scanner,
                            label: "Scan QR Code",
                            size: bs.sm,
                            onPressed: () {
                              //navigateTo('QRScannerView')
                            },
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: QButton(
                            icon: Icons.history,
                            label: "Recent Rooms",
                            size: bs.sm,
                            onPressed: () {
                              //navigateTo('RecentRoomsView')
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Room Information (shown when room is found)
              if (roomInfo != null)
                Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                    border: Border.all(color: successColor.withAlpha(50), width: 2),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: spSm,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.check_circle,
                            color: successColor,
                            size: 20,
                          ),
                          SizedBox(width: spXs),
                          Text(
                            "Room Found!",
                            style: TextStyle(
                              fontSize: fsH6,
                              fontWeight: FontWeight.bold,
                              color: successColor,
                            ),
                          ),
                          Spacer(),
                          QButton(
                            icon: Icons.clear,
                            size: bs.sm,
                            onPressed: clearSearch,
                          ),
                        ],
                      ),
                      
                      // Room Header
                      Row(
                        children: [
                          Expanded(
                            child: Row(
                              children: [
                                Text(
                                  "${roomInfo!["name"]}",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                                if (roomInfo!["isPrivate"] == true) ...[
                                  SizedBox(width: spXs),
                                  Icon(
                                    Icons.lock,
                                    size: 16,
                                    color: warningColor,
                                  ),
                                ],
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                            decoration: BoxDecoration(
                              color: roomInfo!["status"] == "Waiting" 
                                  ? successColor.withAlpha(20) 
                                  : warningColor.withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Text(
                              "${roomInfo!["status"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: roomInfo!["status"] == "Waiting" 
                                    ? successColor 
                                    : warningColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),

                      // Host Info
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 15,
                            backgroundImage: NetworkImage("${roomInfo!["hostAvatar"]}"),
                          ),
                          SizedBox(width: spSm),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Host: ${roomInfo!["host"]}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: primaryColor,
                                  ),
                                ),
                                Text(
                                  "${roomInfo!["mode"]} • ${roomInfo!["map"]}",
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

                      // Room Stats
                      Row(
                        children: [
                          Expanded(
                            child: Row(
                              children: [
                                Icon(
                                  Icons.people,
                                  size: 16,
                                  color: primaryColor,
                                ),
                                SizedBox(width: spXs),
                                Text(
                                  "${roomInfo!["players"]}/${roomInfo!["maxPlayers"]}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: primaryColor,
                                  ),
                                ),
                                SizedBox(width: spSm),
                                Text(
                                  "Level ${roomInfo!["level"]}",
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
                              color: roomInfo!["difficulty"] == "Easy" 
                                  ? successColor.withAlpha(20) 
                                  : roomInfo!["difficulty"] == "Medium" 
                                      ? warningColor.withAlpha(20) 
                                      : dangerColor.withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Text(
                              "${roomInfo!["difficulty"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: roomInfo!["difficulty"] == "Easy" 
                                    ? successColor 
                                    : roomInfo!["difficulty"] == "Medium" 
                                        ? warningColor 
                                        : dangerColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),

                      // Connection Info
                      Row(
                        children: [
                          Icon(
                            Icons.wifi,
                            size: 16,
                            color: (roomInfo!["ping"] as int) < 30 
                                ? successColor 
                                : (roomInfo!["ping"] as int) < 60 
                                    ? warningColor 
                                    : dangerColor,
                          ),
                          SizedBox(width: spXs),
                          Text(
                            "${roomInfo!["ping"]}ms",
                            style: TextStyle(
                              fontSize: 12,
                              color: (roomInfo!["ping"] as int) < 30 
                                  ? successColor 
                                  : (roomInfo!["ping"] as int) < 60 
                                      ? warningColor 
                                      : dangerColor,
                            ),
                          ),
                          SizedBox(width: spSm),
                          Text(
                            "${roomInfo!["region"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),

                      // Description
                      if (roomInfo!["description"].toString().isNotEmpty)
                        Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: Colors.grey.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Room Description",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: primaryColor,
                                ),
                              ),
                              SizedBox(height: spXs),
                              Text(
                                "${roomInfo!["description"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ),

                      // Password Field (if required)
                      if (roomInfo!["hasPassword"] == true)
                        QTextField(
                          label: "Room Password",
                          value: password,
                          hint: "Enter the room password",
                          validator: Validator.required,
                          onChanged: (value) {
                            password = value;
                            setState(() {});
                          },
                        ),

                      // Join Button
                      Container(
                        width: double.infinity,
                        child: QButton(
                          label: (roomInfo!["players"] as int) >= (roomInfo!["maxPlayers"] as int) 
                              ? "Room Full" 
                              : "Join Room",
                          size: bs.md,
                          onPressed: (roomInfo!["players"] as int) >= (roomInfo!["maxPlayers"] as int) 
                              ? null 
                              : joinRoom,
                        ),
                      ),
                    ],
                  ),
                ),

              // Recent Room Codes (if any)
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
                          Icons.history,
                          color: disabledBoldColor,
                          size: 20,
                        ),
                        SizedBox(width: spXs),
                        Text(
                          "Recent Room Codes",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                    ...["ROOM123", "BATTLE01", "ELITE99"].map((code) {
                      return Container(
                        padding: EdgeInsets.all(spSm),
                        margin: EdgeInsets.only(bottom: spXs),
                        decoration: BoxDecoration(
                          color: Colors.grey.withAlpha(10),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                code,
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: primaryColor,
                                ),
                              ),
                            ),
                            QButton(
                              label: "Use",
                              size: bs.sm,
                              onPressed: () {
                                roomCode = code;
                                setState(() {});
                                searchRoom();
                              },
                            ),
                          ],
                        ),
                      );
                    }),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
