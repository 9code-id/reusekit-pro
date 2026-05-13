import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlFollow5View extends StatefulWidget {
  @override
  State<GrlFollow5View> createState() => _GrlFollow5ViewState();
}

class _GrlFollow5ViewState extends State<GrlFollow5View> {
  int currentTab = 0;
  String searchQuery = "";

  List<Map<String, dynamic>> followers = [
    {
      "id": 1,
      "name": "Emma Wilson",
      "username": "@emmawilson",
      "image": "https://picsum.photos/150/150?random=101&keyword=portrait",
      "bio": "Travel blogger and photographer 📸",
      "isOnline": true,
      "lastSeen": "Just now",
      "isFollowingBack": true,
      "followedDate": "2 weeks ago",
      "mutualFriends": 8,
    },
    {
      "id": 2,
      "name": "Michael Chen",
      "username": "@mikec",
      "image": "https://picsum.photos/150/150?random=102&keyword=portrait",
      "bio": "Software engineer & tech enthusiast",
      "isOnline": false,
      "lastSeen": "3 hours ago",
      "isFollowingBack": false,
      "followedDate": "1 week ago",
      "mutualFriends": 15,
    },
    {
      "id": 3,
      "name": "Sarah Davis",
      "username": "@sarahd",
      "image": "https://picsum.photos/150/150?random=103&keyword=portrait",
      "bio": "Fitness coach | Wellness advocate 💪",
      "isOnline": true,
      "lastSeen": "Just now",
      "isFollowingBack": true,
      "followedDate": "3 days ago",
      "mutualFriends": 4,
    },
    {
      "id": 4,
      "name": "David Rodriguez",
      "username": "@davidr",
      "image": "https://picsum.photos/150/150?random=104&keyword=portrait",
      "bio": "Artist and creative director 🎨",
      "isOnline": false,
      "lastSeen": "1 day ago",
      "isFollowingBack": true,
      "followedDate": "5 days ago",
      "mutualFriends": 12,
    },
  ];

  List<Map<String, dynamic>> following = [
    {
      "id": 5,
      "name": "Lisa Thompson",
      "username": "@lisathompson",
      "image": "https://picsum.photos/150/150?random=105&keyword=portrait",
      "bio": "Content creator & lifestyle blogger",
      "isOnline": true,
      "lastSeen": "Just now",
      "isFollowingBack": true,
      "followedDate": "1 month ago",
      "mutualFriends": 22,
    },
    {
      "id": 6,
      "name": "James Park",
      "username": "@jamespark",
      "image": "https://picsum.photos/150/150?random=106&keyword=portrait",
      "bio": "Musician and producer 🎵",
      "isOnline": false,
      "lastSeen": "2 hours ago",
      "isFollowingBack": false,
      "followedDate": "2 weeks ago",
      "mutualFriends": 6,
    },
    {
      "id": 7,
      "name": "Anna Martinez",
      "username": "@anna_m",
      "image": "https://picsum.photos/150/150?random=107&keyword=portrait",
      "bio": "Food blogger | Recipe creator 👩‍🍳",
      "isOnline": true,
      "lastSeen": "Just now",
      "isFollowingBack": true,
      "followedDate": "3 weeks ago",
      "mutualFriends": 18,
    },
    {
      "id": 8,
      "name": "Tom Anderson",
      "username": "@tom_anderson",
      "image": "https://picsum.photos/150/150?random=108&keyword=portrait",
      "bio": "Photographer & visual storyteller",
      "isOnline": false,
      "lastSeen": "4 hours ago",
      "isFollowingBack": true,
      "followedDate": "1 month ago",
      "mutualFriends": 9,
    },
  ];

  List<Map<String, dynamic>> get currentList {
    List<Map<String, dynamic>> list = currentTab == 0 ? followers : following;
    
    if (searchQuery.isEmpty) return list;
    
    return list.where((user) {
      return "${user["name"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
             "${user["username"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
             "${user["bio"]}".toLowerCase().contains(searchQuery.toLowerCase());
    }).toList();
  }

  void _toggleFollow(Map<String, dynamic> user) {
    setState(() {
      if (currentTab == 0) {
        // In followers tab - toggle follow back
        user["isFollowingBack"] = !(user["isFollowingBack"] as bool);
        if (user["isFollowingBack"] as bool) {
          ss("Now following ${user["name"]}");
        } else {
          si("Unfollowed ${user["name"]}");
        }
      } else {
        // In following tab - unfollow
        following.remove(user);
        si("Unfollowed ${user["name"]}");
      }
    });
  }

  void _removeFollower(Map<String, dynamic> user) async {
    bool isConfirmed = await confirm("Remove ${user["name"]} from followers?");
    if (isConfirmed) {
      setState(() {
        followers.remove(user);
      });
      ss("${user["name"]} removed from followers");
    }
  }

  void _showUserOptions(Map<String, dynamic> user) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(radiusLg)),
      ),
      builder: (context) => Container(
        padding: EdgeInsets.all(spMd),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: disabledColor,
                borderRadius: BorderRadius.circular(radius2xl),
              ),
            ),
            SizedBox(height: spMd),
            Row(
              children: [
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: NetworkImage("${user["image"]}"),
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
                        "${user["name"]}",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "${user["username"]}",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: spMd),
            Column(
              children: [
                _buildOptionTile(
                  icon: Icons.person,
                  title: "View Profile",
                  onTap: () {
                    back();
                    si("Viewing ${user["name"]}'s profile");
                  },
                ),
                _buildOptionTile(
                  icon: Icons.message,
                  title: "Send Message",
                  onTap: () {
                    back();
                    si("Message sent to ${user["name"]}");
                  },
                ),
                if (currentTab == 0) ...[
                  _buildOptionTile(
                    icon: Icons.person_remove,
                    title: "Remove Follower",
                    onTap: () {
                      back();
                      _removeFollower(user);
                    },
                    isDestructive: true,
                  ),
                ],
                _buildOptionTile(
                  icon: Icons.block,
                  title: "Block User",
                  onTap: () {
                    back();
                    _blockUser(user);
                  },
                  isDestructive: true,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOptionTile({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    bool isDestructive = false,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: spSm, horizontal: spSm),
        margin: EdgeInsets.only(bottom: spXs),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radiusSm),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: isDestructive ? dangerColor : primaryColor,
              size: 20,
            ),
            SizedBox(width: spSm),
            Text(
              title,
              style: TextStyle(
                fontSize: 16,
                color: isDestructive ? dangerColor : primaryColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _blockUser(Map<String, dynamic> user) async {
    bool isConfirmed = await confirm("Block ${user["name"]}? They won't be able to follow you or see your posts.");
    if (isConfirmed) {
      setState(() {
        followers.removeWhere((f) => f["id"] == user["id"]);
        following.removeWhere((f) => f["id"] == user["id"]);
      });
      ss("${user["name"]} has been blocked");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Connections"),
        actions: [
          QButton(
            icon: Icons.search,
            size: bs.sm,
            onPressed: () {
              si("Opening search");
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Tabs
          Container(
            padding: EdgeInsets.all(spSm),
            child: Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      currentTab = 0;
                      setState(() {});
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: spSm),
                      decoration: BoxDecoration(
                        color: currentTab == 0 ? primaryColor : Colors.transparent,
                        borderRadius: BorderRadius.circular(radiusSm),
                        border: Border.all(
                          color: currentTab == 0 ? primaryColor : disabledColor,
                        ),
                      ),
                      child: Column(
                        children: [
                          Text(
                            "${followers.length}",
                            style: TextStyle(
                              fontSize: fsH6,
                              fontWeight: FontWeight.bold,
                              color: currentTab == 0 ? Colors.white : primaryColor,
                            ),
                          ),
                          Text(
                            "Followers",
                            style: TextStyle(
                              fontSize: 14,
                              color: currentTab == 0 ? Colors.white : disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      currentTab = 1;
                      setState(() {});
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: spSm),
                      decoration: BoxDecoration(
                        color: currentTab == 1 ? primaryColor : Colors.transparent,
                        borderRadius: BorderRadius.circular(radiusSm),
                        border: Border.all(
                          color: currentTab == 1 ? primaryColor : disabledColor,
                        ),
                      ),
                      child: Column(
                        children: [
                          Text(
                            "${following.length}",
                            style: TextStyle(
                              fontSize: fsH6,
                              fontWeight: FontWeight.bold,
                              color: currentTab == 1 ? Colors.white : primaryColor,
                            ),
                          ),
                          Text(
                            "Following",
                            style: TextStyle(
                              fontSize: 14,
                              color: currentTab == 1 ? Colors.white : disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Search
          Padding(
            padding: EdgeInsets.symmetric(horizontal: spMd),
            child: QTextField(
              label: "Search ${currentTab == 0 ? 'followers' : 'following'}",
              value: searchQuery,
              hint: "Search by name or username",
              onChanged: (value) {
                searchQuery = value;
                setState(() {});
              },
            ),
          ),

          SizedBox(height: spSm),

          // List
          Expanded(
            child: currentList.isEmpty
                ? Container(
                    padding: EdgeInsets.all(spLg),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          currentTab == 0 ? Icons.people : Icons.person_search,
                          size: 64,
                          color: disabledColor,
                        ),
                        SizedBox(height: spSm),
                        Text(
                          searchQuery.isEmpty
                              ? "No ${currentTab == 0 ? 'followers' : 'following'} yet"
                              : "No results found",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: disabledBoldColor,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Text(
                          searchQuery.isEmpty
                              ? "When people ${currentTab == 0 ? 'follow you' : 'you follow'}, they'll appear here"
                              : "Try searching with different keywords",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  )
                : ListView.separated(
                    padding: EdgeInsets.all(spMd),
                    itemCount: currentList.length,
                    separatorBuilder: (context, index) => SizedBox(height: spSm),
                    itemBuilder: (context, index) {
                      final user = currentList[index];
                      return Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(radiusLg),
                          boxShadow: [shadowSm],
                        ),
                        child: Row(
                          children: [
                            Stack(
                              children: [
                                Container(
                                  width: 60,
                                  height: 60,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                      image: NetworkImage("${user["image"]}"),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                if (user["isOnline"] as bool)
                                  Positioned(
                                    bottom: 2,
                                    right: 2,
                                    child: Container(
                                      width: 16,
                                      height: 16,
                                      decoration: BoxDecoration(
                                        color: successColor,
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                          color: Colors.white,
                                          width: 2,
                                        ),
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
                                  Text(
                                    "${user["name"]}",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: primaryColor,
                                    ),
                                  ),
                                  Text(
                                    "${user["username"]}",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                  SizedBox(height: spXs),
                                  Text(
                                    "${user["bio"]}",
                                    style: TextStyle(
                                      fontSize: 13,
                                      color: disabledBoldColor,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  SizedBox(height: spXs),
                                  Row(
                                    children: [
                                      Text(
                                        user["isOnline"] as bool ? "Online" : "Last seen ${user["lastSeen"]}",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: user["isOnline"] as bool ? successColor : disabledBoldColor,
                                        ),
                                      ),
                                      if ((user["mutualFriends"] as int) > 0) ...[
                                        Text(" • ", style: TextStyle(color: disabledBoldColor, fontSize: 12)),
                                        Text(
                                          "${user["mutualFriends"]} mutual",
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: primaryColor,
                                          ),
                                        ),
                                      ],
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(width: spSm),
                            Column(
                              children: [
                                if (currentTab == 0)
                                  QButton(
                                    label: (user["isFollowingBack"] as bool) ? "Following" : "Follow Back",
                                    size: bs.sm,
                                    onPressed: () => _toggleFollow(user),
                                  )
                                else
                                  QButton(
                                    label: "Following",
                                    size: bs.sm,
                                    onPressed: () => _toggleFollow(user),
                                  ),
                                SizedBox(height: spXs),
                                QButton(
                                  icon: Icons.more_vert,
                                  size: bs.sm,
                                  onPressed: () => _showUserOptions(user),
                                ),
                              ],
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
}
