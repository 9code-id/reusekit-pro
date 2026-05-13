import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlSocial10View extends StatefulWidget {
  @override
  State<GrlSocial10View> createState() => _GrlSocial10ViewState();
}

class _GrlSocial10ViewState extends State<GrlSocial10View> {
  List<Map<String, dynamic>> notifications = [
    {
      "id": 1,
      "type": "like",
      "user": {
        "name": "Sarah Johnson",
        "avatar": "https://picsum.photos/50/50?random=170",
      },
      "message": "liked your photo",
      "timestamp": "2 minutes ago",
      "isRead": false,
      "postImage": "https://picsum.photos/60/60?random=180",
      "action": null,
    },
    {
      "id": 2,
      "type": "follow",
      "user": {
        "name": "Mike Wilson",
        "avatar": "https://picsum.photos/50/50?random=171",
      },
      "message": "started following you",
      "timestamp": "5 minutes ago",
      "isRead": false,
      "postImage": null,
      "action": "follow_back",
    },
    {
      "id": 3,
      "type": "comment",
      "user": {
        "name": "Emily Chen",
        "avatar": "https://picsum.photos/50/50?random=172",
      },
      "message": "commented on your post: \"Amazing work! How did you achieve this effect?\"",
      "timestamp": "10 minutes ago",
      "isRead": false,
      "postImage": "https://picsum.photos/60/60?random=181",
      "action": "reply",
    },
    {
      "id": 4,
      "type": "mention",
      "user": {
        "name": "David Brown",
        "avatar": "https://picsum.photos/50/50?random=173",
      },
      "message": "mentioned you in a comment",
      "timestamp": "1 hour ago",
      "isRead": true,
      "postImage": "https://picsum.photos/60/60?random=182",
      "action": null,
    },
    {
      "id": 5,
      "type": "post",
      "user": {
        "name": "Lisa Garcia",
        "avatar": "https://picsum.photos/50/50?random=174",
      },
      "message": "shared a new post",
      "timestamp": "2 hours ago",
      "isRead": true,
      "postImage": "https://picsum.photos/60/60?random=183",
      "action": null,
    },
    {
      "id": 6,
      "type": "like",
      "user": {
        "name": "Chris Evans",
        "avatar": "https://picsum.photos/50/50?random=175",
      },
      "message": "liked your story",
      "timestamp": "3 hours ago",
      "isRead": true,
      "postImage": null,
      "action": null,
    },
    {
      "id": 7,
      "type": "group",
      "user": {
        "name": "UI/UX Designers",
        "avatar": "https://picsum.photos/50/50?random=176",
      },
      "message": "You have 5 new posts in this group",
      "timestamp": "4 hours ago",
      "isRead": true,
      "postImage": null,
      "action": "view_group",
    },
    {
      "id": 8,
      "type": "friend_request",
      "user": {
        "name": "Anna Taylor",
        "avatar": "https://picsum.photos/50/50?random=177",
      },
      "message": "sent you a friend request",
      "timestamp": "1 day ago",
      "isRead": false,
      "postImage": null,
      "action": "friend_request",
    },
  ];

  List<Map<String, dynamic>> filterTabs = [
    {"name": "All", "count": 8, "isSelected": true},
    {"name": "Unread", "count": 4, "isSelected": false},
    {"name": "Likes", "count": 2, "isSelected": false},
    {"name": "Comments", "count": 1, "isSelected": false},
    {"name": "Follows", "count": 2, "isSelected": false},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Notifications",
          style: TextStyle(
            fontSize: fsH4,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          GestureDetector(
            onTap: () {
              _markAllAsRead();
            },
            child: Text(
              "Mark all read",
              style: TextStyle(
                fontSize: 14,
                color: primaryColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          SizedBox(width: spMd),
        ],
      ),
      body: Column(
        children: [
          // Filter Tabs
          Container(
            height: 50,
            child: QHorizontalScroll(
              children: [
                SizedBox(width: spMd),
                ...List.generate(filterTabs.length, (index) {
                  final tab = filterTabs[index];
                  final isSelected = tab["isSelected"] as bool;
                  
                  return GestureDetector(
                    onTap: () {
                      for (var t in filterTabs) {
                        t["isSelected"] = false;
                      }
                      filterTabs[index]["isSelected"] = true;
                      setState(() {});
                    },
                    child: Container(
                      margin: EdgeInsets.only(right: spSm),
                      padding: EdgeInsets.symmetric(horizontal: spMd, vertical: spSm),
                      decoration: BoxDecoration(
                        color: isSelected ? primaryColor : Colors.transparent,
                        borderRadius: BorderRadius.circular(radiusLg),
                        border: Border.all(
                          color: isSelected ? primaryColor : disabledBoldColor,
                          width: 1,
                        ),
                      ),
                      child: Text(
                        "${tab["name"]} (${tab["count"]})",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: isSelected ? Colors.white : disabledBoldColor,
                        ),
                      ),
                    ),
                  );
                }),
                SizedBox(width: spMd),
              ],
            ),
          ),
          
          SizedBox(height: spMd),
          
          // Notifications List
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: spMd),
              itemCount: notifications.length,
              itemBuilder: (context, index) {
                final notification = notifications[index];
                final user = notification["user"] as Map<String, dynamic>;
                final type = notification["type"] as String;
                final isRead = notification["isRead"] as bool;
                final postImage = notification["postImage"];
                final action = notification["action"];
                
                return Container(
                  margin: EdgeInsets.only(bottom: spMd),
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: isRead ? Colors.white : primaryColor.withAlpha(10),
                    borderRadius: BorderRadius.circular(radiusLg),
                    boxShadow: [shadowSm],
                    border: isRead ? null : Border.all(
                      color: primaryColor.withAlpha(50),
                      width: 1,
                    ),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // User Avatar with Notification Type Icon
                      Stack(
                        children: [
                          Container(
                            width: 45,
                            height: 45,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                image: NetworkImage("${user["avatar"]}"),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: -2,
                            right: -2,
                            child: Container(
                              width: 20,
                              height: 20,
                              decoration: BoxDecoration(
                                color: _getNotificationColor(type),
                                shape: BoxShape.circle,
                                border: Border.all(color: Colors.white, width: 2),
                              ),
                              child: Icon(
                                _getNotificationIcon(type),
                                size: 10,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                      
                      SizedBox(width: spMd),
                      
                      // Notification Content
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            RichText(
                              text: TextSpan(
                                style: TextStyle(
                                  fontSize: 14,
                                  color: primaryColor,
                                ),
                                children: [
                                  TextSpan(
                                    text: "${user["name"]} ",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  TextSpan(
                                    text: "${notification["message"]}",
                                    style: TextStyle(
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                ],
                              ),
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                            ),
                            
                            SizedBox(height: spSm),
                            
                            Row(
                              children: [
                                Text(
                                  "${notification["timestamp"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                
                                if (!isRead) ...[
                                  SizedBox(width: spSm),
                                  Container(
                                    width: 6,
                                    height: 6,
                                    decoration: BoxDecoration(
                                      color: primaryColor,
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                ],
                              ],
                            ),
                            
                            // Action Buttons
                            if (action != null) ...[
                              SizedBox(height: spSm),
                              _buildActionButtons(action),
                            ],
                          ],
                        ),
                      ),
                      
                      // Post Image or Action Icon
                      if (postImage != null)
                        Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(radiusSm),
                            image: DecorationImage(
                              image: NetworkImage("$postImage"),
                              fit: BoxFit.cover,
                            ),
                          ),
                        )
                      else
                        Icon(
                          Icons.chevron_right,
                          color: disabledBoldColor,
                          size: 20,
                        ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  IconData _getNotificationIcon(String type) {
    switch (type) {
      case "like":
        return Icons.favorite;
      case "follow":
        return Icons.person_add;
      case "comment":
        return Icons.chat_bubble;
      case "mention":
        return Icons.alternate_email;
      case "post":
        return Icons.article;
      case "group":
        return Icons.group;
      case "friend_request":
        return Icons.person;
      default:
        return Icons.notifications;
    }
  }

  Color _getNotificationColor(String type) {
    switch (type) {
      case "like":
        return dangerColor;
      case "follow":
        return primaryColor;
      case "comment":
        return infoColor;
      case "mention":
        return warningColor;
      case "post":
        return successColor;
      case "group":
        return primaryColor;
      case "friend_request":
        return primaryColor;
      default:
        return primaryColor;
    }
  }

  Widget _buildActionButtons(String action) {
    switch (action) {
      case "follow_back":
        return Row(
          children: [
            QButton(
              label: "Follow Back",
              size: bs.sm,
              onPressed: () {
                ss("Followed user successfully");
              },
            ),
            SizedBox(width: spSm),
            Container(
              padding: EdgeInsets.symmetric(horizontal: spMd, vertical: spSm),
              decoration: BoxDecoration(
                border: Border.all(color: disabledBoldColor),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Text(
                "Ignore",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        );
      
      case "reply":
        return QButton(
          label: "Reply",
          size: bs.sm,
          onPressed: () {
            ss("Reply feature coming soon");
          },
        );
      
      case "view_group":
        return QButton(
          label: "View Group",
          size: bs.sm,
          onPressed: () {
            ss("Opening group...");
          },
        );
      
      case "friend_request":
        return Row(
          children: [
            QButton(
              label: "Accept",
              size: bs.sm,
              onPressed: () {
                ss("Friend request accepted");
              },
            ),
            SizedBox(width: spSm),
            Container(
              padding: EdgeInsets.symmetric(horizontal: spMd, vertical: spSm),
              decoration: BoxDecoration(
                border: Border.all(color: disabledBoldColor),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Text(
                "Decline",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        );
      
      default:
        return Container();
    }
  }

  void _markAllAsRead() {
    for (var notification in notifications) {
      notification["isRead"] = true;
    }
    
    // Update filter counts
    filterTabs[1]["count"] = 0; // Unread count
    
    setState(() {});
    ss("All notifications marked as read");
  }
}
