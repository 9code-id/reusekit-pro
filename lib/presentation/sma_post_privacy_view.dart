import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class SmaPostPrivacyView extends StatefulWidget {
  const SmaPostPrivacyView({super.key});

  @override
  State<SmaPostPrivacyView> createState() => _SmaPostPrivacyViewState();
}

class _SmaPostPrivacyViewState extends State<SmaPostPrivacyView> {
  String selectedPrivacyLevel = "friends";
  List<String> hiddenFromIds = [];
  List<String> specificFriendsIds = [];
  bool preventSharing = false;
  bool allowComments = true;
  bool allowReactions = true;
  bool showLocationInfo = true;

  List<Map<String, dynamic>> privacyOptions = [
    {
      "id": "public",
      "title": "Public",
      "description": "Anyone can see this post",
      "icon": Icons.public,
      "color": Colors.green,
    },
    {
      "id": "friends",
      "title": "Friends",
      "description": "Only your friends can see this post",
      "icon": Icons.people,
      "color": Colors.blue,
    },
    {
      "id": "close_friends",
      "title": "Close Friends",
      "description": "Only your close friends can see this post",
      "icon": Icons.favorite,
      "color": Colors.pink,
    },
    {
      "id": "specific_friends",
      "title": "Specific Friends",
      "description": "Only selected friends can see this post",
      "icon": Icons.person_add,
      "color": Colors.orange,
    },
    {
      "id": "only_me",
      "title": "Only Me",
      "description": "Only you can see this post",
      "icon": Icons.lock,
      "color": Colors.red,
    },
  ];

  List<Map<String, dynamic>> friends = [
    {
      "id": "friend_001",
      "name": "Alice Johnson",
      "username": "@alice_j",
      "avatar": "https://picsum.photos/100/100?random=1&keyword=woman",
      "isClose": true,
    },
    {
      "id": "friend_002",
      "name": "Bob Smith",
      "username": "@bobsmith",
      "avatar": "https://picsum.photos/100/100?random=2&keyword=man",
      "isClose": false,
    },
    {
      "id": "friend_003",
      "name": "Carol Williams",
      "username": "@carol_w",
      "avatar": "https://picsum.photos/100/100?random=3&keyword=woman",
      "isClose": true,
    },
    {
      "id": "friend_004",
      "name": "David Brown",
      "username": "@david_b",
      "avatar": "https://picsum.photos/100/100?random=4&keyword=man",
      "isClose": false,
    },
    {
      "id": "friend_005",
      "name": "Emily Davis",
      "username": "@emily_d",
      "avatar": "https://picsum.photos/100/100?random=5&keyword=woman",
      "isClose": true,
    },
  ];

  void _selectPrivacyLevel(String privacyId) {
    selectedPrivacyLevel = privacyId;
    setState(() {});
  }

  void _toggleHiddenFromFriend(String friendId) {
    if (hiddenFromIds.contains(friendId)) {
      hiddenFromIds.remove(friendId);
    } else {
      hiddenFromIds.add(friendId);
    }
    setState(() {});
  }

  void _toggleSpecificFriend(String friendId) {
    if (specificFriendsIds.contains(friendId)) {
      specificFriendsIds.remove(friendId);
    } else {
      specificFriendsIds.add(friendId);
    }
    setState(() {});
  }

  void _savePrivacySettings() {
    Map<String, dynamic> selectedOption = privacyOptions.firstWhere((option) => option["id"] == selectedPrivacyLevel);
    
    String message = "Privacy set to: ${selectedOption["title"]}";
    
    if (hiddenFromIds.isNotEmpty) {
      message += "\nHidden from ${hiddenFromIds.length} friend${hiddenFromIds.length > 1 ? 's' : ''}";
    }
    
    if (selectedPrivacyLevel == "specific_friends" && specificFriendsIds.isNotEmpty) {
      message += "\nVisible to ${specificFriendsIds.length} specific friend${specificFriendsIds.length > 1 ? 's' : ''}";
    }

    ss(message);
    back();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Post Privacy"),
        actions: [
          QButton(
            label: "Save",
            size: bs.sm,
            onPressed: _savePrivacySettings,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Privacy Preview
            Container(
              width: double.infinity,
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
                    "Privacy Preview",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spSm),
                  
                  Row(
                    children: [
                      Icon(
                        privacyOptions.firstWhere((option) => option["id"] == selectedPrivacyLevel)["icon"] as IconData,
                        color: privacyOptions.firstWhere((option) => option["id"] == selectedPrivacyLevel)["color"] as Color,
                        size: 20,
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "${privacyOptions.firstWhere((option) => option["id"] == selectedPrivacyLevel)["title"]}",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 4),
                  Text(
                    "${privacyOptions.firstWhere((option) => option["id"] == selectedPrivacyLevel)["description"]}",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
                  
                  if (hiddenFromIds.isNotEmpty) ...[
                    SizedBox(height: spSm),
                    Text(
                      "Hidden from ${hiddenFromIds.length} friend${hiddenFromIds.length > 1 ? 's' : ''}",
                      style: TextStyle(
                        fontSize: 12,
                        color: warningColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                  
                  if (selectedPrivacyLevel == "specific_friends" && specificFriendsIds.isNotEmpty) ...[
                    SizedBox(height: spSm),
                    Text(
                      "Visible to ${specificFriendsIds.length} specific friend${specificFriendsIds.length > 1 ? 's' : ''}",
                      style: TextStyle(
                        fontSize: 12,
                        color: successColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ],
              ),
            ),

            // Privacy Levels
            Text(
              "Who can see this post?",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            
            Column(
              children: privacyOptions.map((option) {
                bool isSelected = selectedPrivacyLevel == option["id"];
                return GestureDetector(
                  onTap: () => _selectPrivacyLevel("${option["id"]}"),
                  child: Container(
                    width: double.infinity,
                    margin: EdgeInsets.only(bottom: spSm),
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: isSelected ? (option["color"] as Color).withValues(alpha: 0.1) : Colors.white,
                      borderRadius: BorderRadius.circular(radiusMd),
                      boxShadow: [shadowSm],
                      border: Border.all(
                        color: isSelected ? option["color"] as Color : Colors.transparent,
                        width: 2,
                      ),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: (option["color"] as Color).withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Icon(
                            option["icon"] as IconData,
                            color: option["color"] as Color,
                            size: 20,
                          ),
                        ),
                        SizedBox(width: spSm),
                        
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${option["title"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                              Text(
                                "${option["description"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        
                        if (isSelected)
                          Icon(
                            Icons.check_circle,
                            color: option["color"] as Color,
                            size: 20,
                          ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),

            // Specific Friends Selection (if selected)
            if (selectedPrivacyLevel == "specific_friends") ...[
              Text(
                "Select Specific Friends",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              
              Column(
                children: friends.map((friend) {
                  bool isSelected = specificFriendsIds.contains(friend["id"]);
                  return GestureDetector(
                    onTap: () => _toggleSpecificFriend("${friend["id"]}"),
                    child: Container(
                      width: double.infinity,
                      margin: EdgeInsets.only(bottom: spXs),
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: isSelected ? successColor.withValues(alpha: 0.1) : Colors.white,
                        borderRadius: BorderRadius.circular(radiusSm),
                        boxShadow: [shadowSm],
                        border: Border.all(
                          color: isSelected ? successColor : Colors.transparent,
                          width: 1,
                        ),
                      ),
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 16,
                            backgroundImage: NetworkImage("${friend["avatar"]}"),
                          ),
                          SizedBox(width: spSm),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      "${friend["name"]}",
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: primaryColor,
                                      ),
                                    ),
                                    if (friend["isClose"] as bool) ...[
                                      SizedBox(width: 4),
                                      Icon(
                                        Icons.favorite,
                                        color: dangerColor,
                                        size: 12,
                                      ),
                                    ],
                                  ],
                                ),
                                Text(
                                  "${friend["username"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          if (isSelected)
                            Icon(
                              Icons.check_circle,
                              color: successColor,
                              size: 20,
                            ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
            ],

            // Hide From Friends
            if (selectedPrivacyLevel == "friends" || selectedPrivacyLevel == "public") ...[
              Text(
                "Hide From",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.grey.withValues(alpha: 0.05),
                  borderRadius: BorderRadius.circular(radiusSm),
                  border: Border.all(
                    color: Colors.grey.withValues(alpha: 0.2),
                    width: 1,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Select friends you want to hide this post from:",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(height: spSm),
                    
                    Column(
                      children: friends.map((friend) {
                        bool isHidden = hiddenFromIds.contains(friend["id"]);
                        return GestureDetector(
                          onTap: () => _toggleHiddenFromFriend("${friend["id"]}"),
                          child: Container(
                            width: double.infinity,
                            margin: EdgeInsets.only(bottom: spXs),
                            padding: EdgeInsets.all(spSm),
                            decoration: BoxDecoration(
                              color: isHidden ? warningColor.withValues(alpha: 0.1) : Colors.white,
                              borderRadius: BorderRadius.circular(radiusSm),
                              border: Border.all(
                                color: isHidden ? warningColor : Colors.grey.withValues(alpha: 0.2),
                                width: 1,
                              ),
                            ),
                            child: Row(
                              children: [
                                CircleAvatar(
                                  radius: 14,
                                  backgroundImage: NetworkImage("${friend["avatar"]}"),
                                ),
                                SizedBox(width: spSm),
                                Expanded(
                                  child: Text(
                                    "${friend["name"]}",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: primaryColor,
                                    ),
                                  ),
                                ),
                                if (isHidden)
                                  Icon(
                                    Icons.visibility_off,
                                    color: warningColor,
                                    size: 16,
                                  ),
                              ],
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
            ],

            // Additional Settings
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.grey.withValues(alpha: 0.05),
                borderRadius: BorderRadius.circular(radiusSm),
                border: Border.all(
                  color: Colors.grey.withValues(alpha: 0.2),
                  width: 1,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Additional Settings",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spMd),

                  // Prevent Sharing
                  QSwitch(
                    items: [
                      {
                        "label": "Prevent others from sharing this post",
                        "value": true,
                        "checked": preventSharing,
                      }
                    ],
                    value: [
                      if (preventSharing)
                        {
                          "label": "Prevent others from sharing this post",
                          "value": true,
                          "checked": true
                        }
                    ],
                    onChanged: (values, ids) {
                      preventSharing = values.isNotEmpty;
                      setState(() {});
                    },
                  ),
                  SizedBox(height: spSm),

                  // Allow Comments
                  QSwitch(
                    items: [
                      {
                        "label": "Allow comments",
                        "value": true,
                        "checked": allowComments,
                      }
                    ],
                    value: [
                      if (allowComments)
                        {
                          "label": "Allow comments",
                          "value": true,
                          "checked": true
                        }
                    ],
                    onChanged: (values, ids) {
                      allowComments = values.isNotEmpty;
                      setState(() {});
                    },
                  ),
                  SizedBox(height: spSm),

                  // Allow Reactions
                  QSwitch(
                    items: [
                      {
                        "label": "Allow reactions",
                        "value": true,
                        "checked": allowReactions,
                      }
                    ],
                    value: [
                      if (allowReactions)
                        {
                          "label": "Allow reactions",
                          "value": true,
                          "checked": true
                        }
                    ],
                    onChanged: (values, ids) {
                      allowReactions = values.isNotEmpty;
                      setState(() {});
                    },
                  ),
                  SizedBox(height: spSm),

                  // Show Location
                  QSwitch(
                    items: [
                      {
                        "label": "Show location information",
                        "value": true,
                        "checked": showLocationInfo,
                      }
                    ],
                    value: [
                      if (showLocationInfo)
                        {
                          "label": "Show location information",
                          "value": true,
                          "checked": true
                        }
                    ],
                    onChanged: (values, ids) {
                      showLocationInfo = values.isNotEmpty;
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),

            // Privacy Tips
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: infoColor.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.info,
                        color: infoColor,
                        size: 16,
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "Privacy Tips",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: infoColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spXs),
                  Text(
                    "• You can change privacy settings anytime after posting\n• Friends can see who else can view your posts\n• Close friends will see a special indicator on your posts",
                    style: TextStyle(
                      fontSize: 12,
                      color: infoColor,
                      height: 1.4,
                    ),
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
