import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlFollow7View extends StatefulWidget {
  @override
  State<GrlFollow7View> createState() => _GrlFollow7ViewState();
}

class _GrlFollow7ViewState extends State<GrlFollow7View> {
  String searchQuery = "";

  List<Map<String, dynamic>> blockedUsers = [
    {
      "id": 1,
      "name": "John Doe",
      "username": "@johndoe",
      "image": "https://picsum.photos/150/150?random=301&keyword=portrait",
      "blockedDate": "2 weeks ago",
      "reason": "Spam",
    },
    {
      "id": 2,
      "name": "Jane Smith", 
      "username": "@janesmith",
      "image": "https://picsum.photos/150/150?random=302&keyword=portrait",
      "blockedDate": "1 month ago",
      "reason": "Harassment",
    },
    {
      "id": 3,
      "name": "Bob Wilson",
      "username": "@bobwilson",
      "image": "https://picsum.photos/150/150?random=303&keyword=portrait",
      "blockedDate": "3 days ago", 
      "reason": "Inappropriate content",
    },
  ];

  List<Map<String, dynamic>> get filteredUsers {
    if (searchQuery.isEmpty) return blockedUsers;
    
    return blockedUsers.where((user) {
      return "${user["name"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
             "${user["username"]}".toLowerCase().contains(searchQuery.toLowerCase());
    }).toList();
  }

  void _unblockUser(Map<String, dynamic> user) async {
    bool isConfirmed = await confirm("Unblock ${user["name"]}? They will be able to follow you and see your posts again.");
    if (isConfirmed) {
      setState(() {
        blockedUsers.remove(user);
      });
      ss("${user["name"]} has been unblocked");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Blocked Users"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: spMd,
          children: [
            // Search
            QTextField(
              label: "Search blocked users",
              value: searchQuery,
              hint: "Search by name or username",
              onChanged: (value) {
                searchQuery = value;
                setState(() {});
              },
            ),

            // Header
            Row(
              children: [
                Text(
                  "Blocked Users",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Spacer(),
                Text(
                  "${filteredUsers.length} users",
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),

            // Blocked Users List
            if (filteredUsers.isEmpty)
              Container(
                padding: EdgeInsets.all(spLg),
                child: Column(
                  children: [
                    Icon(
                      Icons.block,
                      size: 64,
                      color: disabledColor,
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "No blocked users",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      searchQuery.isNotEmpty
                          ? "No blocked users match your search"
                          : "When you block someone, they'll appear here",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              )
            else
              ...filteredUsers.map((user) {
                return Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusLg),
                    boxShadow: [shadowSm],
                  ),
                  child: Row(
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
                              "Blocked ${user["blockedDate"]} • ${user["reason"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: dangerColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: spSm),
                      QButton(
                        label: "Unblock",
                        size: bs.sm,
                        onPressed: () => _unblockUser(user),
                      ),
                    ],
                  ),
                );
              }).toList(),
          ],
        ),
      ),
    );
  }
}
