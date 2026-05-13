import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GeaChatView extends StatefulWidget {
  const GeaChatView({super.key});

  @override
  State<GeaChatView> createState() => _GeaChatViewState();
}

class _GeaChatViewState extends State<GeaChatView> {
  String selectedChannel = "Global";
  String messageText = "";
  bool isTyping = false;

  List<Map<String, dynamic>> channels = [
    {
      "name": "Global",
      "type": "public",
      "members": 1248,
      "icon": Icons.public,
      "color": Color(0xFF4CAF50),
      "unread": 0,
    },
    {
      "name": "Guild",
      "type": "guild",
      "members": 45,
      "icon": Icons.group,
      "color": Color(0xFF2196F3),
      "unread": 3,
    },
    {
      "name": "Party",
      "type": "party",
      "members": 5,
      "icon": Icons.groups,
      "color": Color(0xFF9C27B0),
      "unread": 1,
    },
    {
      "name": "Trade",
      "type": "trade",
      "members": 892,
      "icon": Icons.swap_horiz,
      "color": Color(0xFFFF9800),
      "unread": 0,
    },
    {
      "name": "Help",
      "type": "help",
      "members": 567,
      "icon": Icons.help,
      "color": Color(0xFF607D8B),
      "unread": 0,
    },
  ];

  List<Map<String, dynamic>> messages = [
    {
      "id": 1,
      "username": "DragonSlayer99",
      "level": 45,
      "message": "Anyone want to team up for the dungeon raid?",
      "timestamp": "10:30 AM",
      "type": "normal",
      "isOwn": false,
      "avatar": "https://picsum.photos/40/40?random=1&keyword=avatar",
      "badge": "VIP",
    },
    {
      "id": 2,
      "username": "MagicMaster",
      "level": 38,
      "message": "I'm in! What level dungeon?",
      "timestamp": "10:31 AM",
      "type": "normal",
      "isOwn": false,
      "avatar": "https://picsum.photos/40/40?random=2&keyword=avatar",
      "badge": null,
    },
    {
      "id": 3,
      "username": "You",
      "level": 42,
      "message": "Level 40+ dungeon. Need a healer and tank",
      "timestamp": "10:32 AM",
      "type": "normal",
      "isOwn": true,
      "avatar": "https://picsum.photos/40/40?random=3&keyword=avatar",
      "badge": "Pro",
    },
    {
      "id": 4,
      "username": "HealerQueen",
      "level": 41,
      "message": "Healer here! Ready to go 💖",
      "timestamp": "10:33 AM",
      "type": "normal",
      "isOwn": false,
      "avatar": "https://picsum.photos/40/40?random=4&keyword=avatar",
      "badge": null,
    },
    {
      "id": 5,
      "username": "TankWarrior",
      "level": 50,
      "message": "Tank reporting for duty! 🛡️",
      "timestamp": "10:34 AM",
      "type": "normal",
      "isOwn": false,
      "avatar": "https://picsum.photos/40/40?random=5&keyword=avatar",
      "badge": "Elite",
    },
    {
      "id": 6,
      "username": "System",
      "level": 0,
      "message": "Party formed: DragonSlayer99, MagicMaster, You, HealerQueen, TankWarrior",
      "timestamp": "10:35 AM",
      "type": "system",
      "isOwn": false,
      "avatar": null,
      "badge": null,
    },
    {
      "id": 7,
      "username": "NoobPlayer01",
      "level": 12,
      "message": "Can someone help me with the tutorial quest?",
      "timestamp": "10:36 AM",
      "type": "normal",
      "isOwn": false,
      "avatar": "https://picsum.photos/40/40?random=6&keyword=avatar",
      "badge": "Newbie",
    },
  ];

  List<Map<String, dynamic>> quickMessages = [
    {"text": "GG", "icon": Icons.thumb_up},
    {"text": "Need help", "icon": Icons.help},
    {"text": "Thanks!", "icon": Icons.favorite},
    {"text": "Let's go!", "icon": Icons.play_arrow},
    {"text": "Party up?", "icon": Icons.group_add},
    {"text": "Trade?", "icon": Icons.swap_horiz},
  ];

  Color _getBadgeColor(String? badge) {
    switch (badge) {
      case "VIP":
        return Color(0xFFFFD700);
      case "Pro":
        return Color(0xFF9C27B0);
      case "Elite":
        return Color(0xFFF44336);
      case "Newbie":
        return Color(0xFF4CAF50);
      default:
        return disabledBoldColor;
    }
  }

  Widget _buildMessage(Map<String, dynamic> message) {
    final isSystem = message["type"] == "system";
    final isOwn = message["isOwn"] == true;
    
    if (isSystem) {
      return Container(
        margin: EdgeInsets.symmetric(vertical: spXs),
        padding: EdgeInsets.all(spXs),
        decoration: BoxDecoration(
          color: infoColor.withAlpha(30),
          borderRadius: BorderRadius.circular(radiusSm),
        ),
        child: Text(
          "${message["message"]}",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 12,
            color: infoColor,
            fontStyle: FontStyle.italic,
          ),
        ),
      );
    }
    
    return Container(
      margin: EdgeInsets.symmetric(vertical: spXs),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: isOwn ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          if (!isOwn) ...[
            ClipRRect(
              borderRadius: BorderRadius.circular(radiusLg),
              child: Image.network(
                "${message["avatar"]}",
                width: 32,
                height: 32,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(width: spXs),
          ],
          
          Flexible(
            child: Column(
              crossAxisAlignment: isOwn ? CrossAxisAlignment.end : CrossAxisAlignment.start,
              children: [
                if (!isOwn)
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "${message["username"]}",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "Lv.${message["level"]}",
                        style: TextStyle(
                          fontSize: 10,
                          color: disabledBoldColor,
                        ),
                      ),
                      if (message["badge"] != null) ...[
                        SizedBox(width: spXs),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 4,
                            vertical: 1,
                          ),
                          decoration: BoxDecoration(
                            color: _getBadgeColor(message["badge"] as String?),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            "${message["badge"]}",
                            style: TextStyle(
                              fontSize: 8,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                
                SizedBox(height: 2),
                
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: spSm,
                    vertical: spXs,
                  ),
                  decoration: BoxDecoration(
                    color: isOwn ? primaryColor : Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    border: isOwn ? null : Border.all(color: disabledColor),
                  ),
                  child: Text(
                    "${message["message"]}",
                    style: TextStyle(
                      fontSize: 14,
                      color: isOwn ? Colors.white : primaryColor,
                    ),
                  ),
                ),
                
                SizedBox(height: 2),
                
                Text(
                  "${message["timestamp"]}",
                  style: TextStyle(
                    fontSize: 10,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
          
          if (isOwn) ...[
            SizedBox(width: spXs),
            ClipRRect(
              borderRadius: BorderRadius.circular(radiusLg),
              child: Image.network(
                "${message["avatar"]}",
                width: 32,
                height: 32,
                fit: BoxFit.cover,
              ),
            ),
          ],
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final currentChannel = channels.firstWhere((c) => c["name"] == selectedChannel);
    
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Icon(
              currentChannel["icon"] as IconData,
              color: currentChannel["color"] as Color,
              size: 24,
            ),
            SizedBox(width: spSm),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${currentChannel["name"]} Chat",
                  style: TextStyle(fontSize: 16),
                ),
                Text(
                  "${currentChannel["members"]} members",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.people),
            onPressed: () {
              //navigateTo('ChatMembersView')
            },
          ),
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              //navigateTo('ChatSettingsView')
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Channel Selector
          Container(
            height: 60,
            padding: EdgeInsets.symmetric(vertical: spXs),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.symmetric(horizontal: spSm),
              itemCount: channels.length,
              itemBuilder: (context, index) {
                final channel = channels[index];
                final isSelected = channel["name"] == selectedChannel;
                final hasUnread = (channel["unread"] as int) > 0;
                
                return GestureDetector(
                  onTap: () {
                    selectedChannel = channel["name"] as String;
                    setState(() {});
                  },
                  child: Container(
                    margin: EdgeInsets.only(right: spSm),
                    padding: EdgeInsets.symmetric(
                      horizontal: spSm,
                      vertical: spXs,
                    ),
                    decoration: BoxDecoration(
                      color: isSelected ? primaryColor : Colors.white,
                      borderRadius: BorderRadius.circular(radiusLg),
                      border: Border.all(
                        color: isSelected ? primaryColor : disabledColor,
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          channel["icon"] as IconData,
                          color: isSelected 
                              ? Colors.white 
                              : (channel["color"] as Color),
                          size: 20,
                        ),
                        SizedBox(width: spXs),
                        Text(
                          "${channel["name"]}",
                          style: TextStyle(
                            color: isSelected ? Colors.white : primaryColor,
                            fontWeight: FontWeight.w600,
                            fontSize: 12,
                          ),
                        ),
                        if (hasUnread) ...[
                          SizedBox(width: spXs),
                          Container(
                            padding: EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              color: dangerColor,
                              shape: BoxShape.circle,
                            ),
                            child: Text(
                              "${channel["unread"]}",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                );
              },
            ),
          ),

          Divider(height: 1),

          // Messages Area
          Expanded(
            child: Container(
              color: Colors.grey[50],
              child: ListView.builder(
                padding: EdgeInsets.all(spSm),
                itemCount: messages.length,
                itemBuilder: (context, index) {
                  return _buildMessage(messages[index]);
                },
              ),
            ),
          ),

          // Quick Messages
          Container(
            padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(top: BorderSide(color: disabledColor)),
            ),
            child: Row(
              children: [
                Expanded(
                  child: QHorizontalScroll(
                    children: quickMessages.map((quick) {
                      return GestureDetector(
                        onTap: () {
                          messageText = quick["text"] as String;
                          setState(() {});
                        },
                        child: Container(
                          margin: EdgeInsets.only(right: spXs),
                          padding: EdgeInsets.symmetric(
                            horizontal: spSm,
                            vertical: spXs,
                          ),
                          decoration: BoxDecoration(
                            color: primaryColor.withAlpha(30),
                            borderRadius: BorderRadius.circular(radiusLg),
                            border: Border.all(color: primaryColor),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                quick["icon"] as IconData,
                                size: 16,
                                color: primaryColor,
                              ),
                              SizedBox(width: 4),
                              Text(
                                "${quick["text"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: primaryColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
          ),

          // Message Input
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(top: BorderSide(color: disabledColor)),
            ),
            child: Row(
              children: [
                Expanded(
                  child: QTextField(
                    label: "Type your message...",
                    value: messageText,
                    onChanged: (value) {
                      messageText = value;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spSm),
                QButton(
                  icon: Icons.emoji_emotions,
                  size: bs.sm,
                  onPressed: () {
                    //navigateTo('EmojiPickerView')
                  },
                ),
                SizedBox(width: spXs),
                QButton(
                  icon: Icons.send,
                  size: bs.sm,
                  onPressed: messageText.isNotEmpty ? () {
                    //navigateTo('SendMessageView', arguments: {"message": messageText, "channel": selectedChannel})
                    messageText = "";
                    setState(() {});
                  } : null,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
