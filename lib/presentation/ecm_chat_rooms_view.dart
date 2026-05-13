import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class EcmChatRoomsView extends StatefulWidget {
  const EcmChatRoomsView({super.key});

  @override
  State<EcmChatRoomsView> createState() => _EcmChatRoomsViewState();
}

class _EcmChatRoomsViewState extends State<EcmChatRoomsView> {
  String searchQuery = "";
  String selectedCategory = "All";
  bool showOnlineOnly = false;
  
  List<Map<String, dynamic>> categoryOptions = [
    {"label": "All Rooms", "value": "All"},
    {"label": "General", "value": "General"},
    {"label": "Networking", "value": "Networking"},
    {"label": "Speakers", "value": "Speakers"},
    {"label": "Sponsors", "value": "Sponsors"},
    {"label": "Q&A", "value": "Q&A"},
  ];

  List<Map<String, dynamic>> chatRooms = [
    {
      "id": "1",
      "name": "General Discussion",
      "description": "Main conference discussion room",
      "category": "General",
      "participants": 248,
      "online_count": 34,
      "last_message": "Great presentation on AI trends!",
      "last_message_time": "2024-01-15T10:30:00Z",
      "last_message_sender": "Sarah Johnson",
      "is_moderator": false,
      "is_muted": false,
      "unread_count": 5,
      "is_pinned": true,
      "room_type": "public",
      "avatar": "https://picsum.photos/100/100?random=1&keyword=conference"
    },
    {
      "id": "2",
      "name": "Networking Lounge",
      "description": "Connect with fellow attendees",
      "category": "Networking",
      "participants": 156,
      "online_count": 22,
      "last_message": "Looking for backend developers to connect with",
      "last_message_time": "2024-01-15T10:15:00Z",
      "last_message_sender": "Mike Chen",
      "is_moderator": false,
      "is_muted": false,
      "unread_count": 12,
      "is_pinned": false,
      "room_type": "public",
      "avatar": "https://picsum.photos/100/100?random=2&keyword=networking"
    },
    {
      "id": "3",
      "name": "Speaker Q&A",
      "description": "Ask questions to our speakers",
      "category": "Q&A",
      "participants": 89,
      "online_count": 15,
      "last_message": "When will the slides be available?",
      "last_message_time": "2024-01-15T09:45:00Z",
      "last_message_sender": "Emily Rodriguez",
      "is_moderator": true,
      "is_muted": false,
      "unread_count": 3,
      "is_pinned": true,
      "room_type": "moderated",
      "avatar": "https://picsum.photos/100/100?random=3&keyword=speaker"
    },
    {
      "id": "4",
      "name": "Tech Talk Discussion",
      "description": "Discuss the latest tech presentations",
      "category": "General",
      "participants": 134,
      "online_count": 28,
      "last_message": "The AI demo was incredible!",
      "last_message_time": "2024-01-15T09:30:00Z",
      "last_message_sender": "David Wilson",
      "is_moderator": false,
      "is_muted": true,
      "unread_count": 0,
      "is_pinned": false,
      "room_type": "public",
      "avatar": "https://picsum.photos/100/100?random=4&keyword=technology"
    },
    {
      "id": "5",
      "name": "Sponsor Showcase",
      "description": "Learn about our sponsors and partners",
      "category": "Sponsors",
      "participants": 67,
      "online_count": 8,
      "last_message": "Check out our new product demo!",
      "last_message_time": "2024-01-15T09:00:00Z",
      "last_message_sender": "TechCorp Team",
      "is_moderator": false,
      "is_muted": false,
      "unread_count": 1,
      "is_pinned": false,
      "room_type": "sponsored",
      "avatar": "https://picsum.photos/100/100?random=5&keyword=sponsor"
    },
  ];

  List<Map<String, dynamic>> get filteredRooms {
    List<Map<String, dynamic>> filtered = chatRooms;
    
    if (selectedCategory != "All") {
      filtered = filtered.where((room) => room["category"] == selectedCategory).toList();
    }
    
    if (showOnlineOnly) {
      filtered = filtered.where((room) => (room["online_count"] as int) > 0).toList();
    }
    
    if (searchQuery.isNotEmpty) {
      filtered = filtered.where((room) {
        return room["name"].toLowerCase().contains(searchQuery.toLowerCase()) ||
               room["description"].toLowerCase().contains(searchQuery.toLowerCase());
      }).toList();
    }
    
    // Sort by pinned first, then by last message time
    filtered.sort((a, b) {
      if (a["is_pinned"] != b["is_pinned"]) {
        return b["is_pinned"] ? 1 : -1;
      }
      return DateTime.parse(b["last_message_time"]).compareTo(DateTime.parse(a["last_message_time"]));
    });
    
    return filtered;
  }

  String _formatTime(String timestamp) {
    DateTime time = DateTime.parse(timestamp);
    DateTime now = DateTime.now();
    Duration difference = now.difference(time);
    
    if (difference.inMinutes < 60) {
      return "${difference.inMinutes}m ago";
    } else if (difference.inHours < 24) {
      return "${difference.inHours}h ago";
    } else {
      return time.dMMMy;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Chat Rooms"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {},
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
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: primaryColor.withAlpha(10),
                borderRadius: BorderRadius.circular(radiusMd),
                border: Border.all(color: primaryColor.withAlpha(30)),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.chat_bubble_outline,
                    color: primaryColor,
                    size: 24,
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Conference Chat Rooms",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "Connect and discuss with other attendees",
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
            ),

            Row(
              children: [
                Expanded(
                  child: QTextField(
                    label: "Search rooms",
                    value: searchQuery,
                    hint: "Search by room name or description",
                    onChanged: (value) {
                      searchQuery = value;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spSm),
                QButton(
                  icon: Icons.search,
                  size: bs.sm,
                  onPressed: () {},
                ),
              ],
            ),

            Row(
              children: [
                Expanded(
                  child: QDropdownField(
                    label: "Category",
                    items: categoryOptions,
                    value: selectedCategory,
                    onChanged: (value, label) {
                      selectedCategory = value;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QSwitch(
                    items: [
                      {
                        "label": "Online Only",
                        "value": true,
                        "checked": showOnlineOnly,
                      }
                    ],
                    value: [
                      if (showOnlineOnly)
                        {
                          "label": "Online Only",
                          "value": true,
                          "checked": true
                        }
                    ],
                    onChanged: (values, ids) {
                      showOnlineOnly = values.isNotEmpty;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),

            Container(
              padding: EdgeInsets.all(spSm),
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
                      Icon(
                        Icons.forum,
                        color: primaryColor,
                        size: 20,
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "Active Chat Rooms",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Spacer(),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: spXs,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: successColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Text(
                          "${filteredRooms.length} rooms",
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                            color: successColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  if (filteredRooms.isEmpty)
                    Container(
                      padding: EdgeInsets.all(spMd),
                      child: Column(
                        children: [
                          Icon(
                            Icons.chat_bubble_outline,
                            size: 48,
                            color: disabledColor,
                          ),
                          SizedBox(height: spSm),
                          Text(
                            "No chat rooms found",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: disabledBoldColor,
                            ),
                          ),
                          Text(
                            "Try adjusting your search or filters",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledColor,
                            ),
                          ),
                        ],
                      ),
                    )
                  else
                    ...List.generate(filteredRooms.length, (index) {
                      final room = filteredRooms[index];
                      return GestureDetector(
                        onTap: () {},
                        child: Container(
                          margin: EdgeInsets.only(bottom: spSm),
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: room["unread_count"] > 0 
                                ? primaryColor.withAlpha(5)
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(radiusSm),
                            border: Border.all(
                              color: room["unread_count"] > 0 
                                  ? primaryColor.withAlpha(30)
                                  : disabledOutlineBorderColor,
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Stack(
                                    children: [
                                      Container(
                                        width: 50,
                                        height: 50,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(radiusSm),
                                          image: DecorationImage(
                                            image: NetworkImage("${room["avatar"]}"),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      if (room["is_pinned"])
                                        Positioned(
                                          top: 0,
                                          right: 0,
                                          child: Container(
                                            padding: EdgeInsets.all(2),
                                            decoration: BoxDecoration(
                                              color: warningColor,
                                              borderRadius: BorderRadius.circular(radiusXs),
                                            ),
                                            child: Icon(
                                              Icons.push_pin,
                                              size: 8,
                                              color: Colors.white,
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
                                            Expanded(
                                              child: Text(
                                                "${room["name"]}",
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                  color: primaryColor,
                                                ),
                                              ),
                                            ),
                                            if (room["unread_count"] > 0)
                                              Container(
                                                padding: EdgeInsets.symmetric(
                                                  horizontal: spXs,
                                                  vertical: 2,
                                                ),
                                                decoration: BoxDecoration(
                                                  color: primaryColor,
                                                  borderRadius: BorderRadius.circular(radiusXs),
                                                ),
                                                child: Text(
                                                  "${room["unread_count"]}",
                                                  style: TextStyle(
                                                    fontSize: 10,
                                                    fontWeight: FontWeight.w600,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                          ],
                                        ),
                                        Text(
                                          "${room["description"]}",
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: disabledBoldColor,
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.people,
                                              size: 12,
                                              color: disabledColor,
                                            ),
                                            SizedBox(width: 4),
                                            Text(
                                              "${room["participants"]} members",
                                              style: TextStyle(
                                                fontSize: 11,
                                                color: disabledColor,
                                              ),
                                            ),
                                            SizedBox(width: spSm),
                                            Container(
                                              width: 6,
                                              height: 6,
                                              decoration: BoxDecoration(
                                                color: successColor,
                                                borderRadius: BorderRadius.circular(3),
                                              ),
                                            ),
                                            SizedBox(width: 4),
                                            Text(
                                              "${room["online_count"]} online",
                                              style: TextStyle(
                                                fontSize: 11,
                                                color: successColor,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text(
                                        _formatTime(room["last_message_time"]),
                                        style: TextStyle(
                                          fontSize: 10,
                                          color: disabledColor,
                                        ),
                                      ),
                                      SizedBox(height: spXs),
                                      Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          if (room["is_moderator"])
                                            Container(
                                              padding: EdgeInsets.all(2),
                                              decoration: BoxDecoration(
                                                color: infoColor.withAlpha(20),
                                                borderRadius: BorderRadius.circular(radiusXs),
                                              ),
                                              child: Icon(
                                                Icons.admin_panel_settings,
                                                size: 10,
                                                color: infoColor,
                                              ),
                                            ),
                                          if (room["is_muted"])
                                            Container(
                                              padding: EdgeInsets.all(2),
                                              decoration: BoxDecoration(
                                                color: disabledColor.withAlpha(20),
                                                borderRadius: BorderRadius.circular(radiusXs),
                                              ),
                                              child: Icon(
                                                Icons.volume_off,
                                                size: 10,
                                                color: disabledColor,
                                              ),
                                            ),
                                          Container(
                                            padding: EdgeInsets.symmetric(
                                              horizontal: 4,
                                              vertical: 2,
                                            ),
                                            decoration: BoxDecoration(
                                              color: room["room_type"] == "public"
                                                  ? successColor.withAlpha(20)
                                                  : room["room_type"] == "moderated"
                                                      ? warningColor.withAlpha(20)
                                                      : infoColor.withAlpha(20),
                                              borderRadius: BorderRadius.circular(radiusXs),
                                            ),
                                            child: Text(
                                              "${room["room_type"]}",
                                              style: TextStyle(
                                                fontSize: 8,
                                                fontWeight: FontWeight.w600,
                                                color: room["room_type"] == "public"
                                                    ? successColor
                                                    : room["room_type"] == "moderated"
                                                        ? warningColor
                                                        : infoColor,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              if (room["last_message"] != null && room["last_message"].isNotEmpty) ...[
                                SizedBox(height: spXs),
                                Container(
                                  padding: EdgeInsets.all(spXs),
                                  decoration: BoxDecoration(
                                    color: disabledColor.withAlpha(10),
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                  child: Row(
                                    children: [
                                      Text(
                                        "${room["last_message_sender"]}: ",
                                        style: TextStyle(
                                          fontSize: 11,
                                          fontWeight: FontWeight.w600,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                      Expanded(
                                        child: Text(
                                          "${room["last_message"]}",
                                          style: TextStyle(
                                            fontSize: 11,
                                            color: disabledBoldColor,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ],
                          ),
                        ),
                      );
                    }),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: primaryColor,
        child: Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
