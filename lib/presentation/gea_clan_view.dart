import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GeaClanView extends StatefulWidget {
  const GeaClanView({super.key});

  @override
  State<GeaClanView> createState() => _GeaClanViewState();
}

class _GeaClanViewState extends State<GeaClanView> {
  int selectedTab = 0;
  String searchQuery = "";
  String selectedRegion = "All";

  // Current user's clan data
  Map<String, dynamic>? myClan = {
    "id": 1,
    "name": "Elite Warriors",
    "tag": "[EW]",
    "level": 15,
    "members": 87,
    "maxMembers": 100,
    "rank": 156,
    "points": 12450,
    "region": "Global",
    "description": "Competitive clan for skilled players. We focus on teamwork and strategy.",
    "emblem": "https://picsum.photos/80/80?random=1&keyword=emblem",
    "leader": "ClanMaster",
    "founded": "2023-03-15",
    "requirements": ["Level 30+", "Gold Rank", "Active Daily"],
    "isPublic": true,
    "warWins": 45,
    "warLosses": 12,
    "memberRole": "Officer",
  };

  List<Map<String, dynamic>> availableClans = [
    {
      "id": 2,
      "name": "Phoenix Rising",
      "tag": "[PR]",
      "level": 12,
      "members": 92,
      "maxMembers": 100,
      "rank": 89,
      "points": 15780,
      "region": "US East",
      "description": "Friendly clan welcoming all skill levels. We help each other improve!",
      "emblem": "https://picsum.photos/80/80?random=2&keyword=phoenix",
      "leader": "PhoenixLeader",
      "requirements": ["Level 15+", "Active Weekly"],
      "isPublic": true,
      "warWins": 38,
      "warLosses": 15,
    },
    {
      "id": 3,
      "name": "Shadow Hunters",
      "tag": "[SH]",
      "level": 18,
      "members": 78,
      "maxMembers": 80,
      "rank": 45,
      "points": 18965,
      "region": "Europe",
      "description": "Elite clan for competitive players. High skill requirement.",
      "emblem": "https://picsum.photos/80/80?random=3&keyword=shadow",
      "leader": "ShadowMaster",
      "requirements": ["Level 40+", "Diamond Rank", "Clan War Experience"],
      "isPublic": false,
      "warWins": 67,
      "warLosses": 8,
    },
    {
      "id": 4,
      "name": "Casual Gamers",
      "tag": "[CG]",
      "level": 8,
      "members": 45,
      "maxMembers": 50,
      "rank": 342,
      "points": 8750,
      "region": "Asia",
      "description": "Relaxed clan for casual players. No pressure, just fun!",
      "emblem": "https://picsum.photos/80/80?random=4&keyword=casual",
      "leader": "ChillGamer",
      "requirements": ["Level 10+", "Respectful"],
      "isPublic": true,
      "warWins": 12,
      "warLosses": 5,
    },
  ];

  List<Map<String, dynamic>> clanMembers = [
    {
      "name": "ClanMaster",
      "role": "Leader",
      "level": 48,
      "rank": "Master",
      "points": 2450,
      "lastActive": "Online",
      "joinDate": "2023-03-15",
      "avatar": "https://picsum.photos/60/60?random=11&keyword=leader",
    },
    {
      "name": "ViceCommander",
      "role": "Co-Leader",
      "level": 45,
      "rank": "Diamond",
      "points": 2180,
      "lastActive": "2 hours ago",
      "joinDate": "2023-03-20",
      "avatar": "https://picsum.photos/60/60?random=12&keyword=commander",
    },
    {
      "name": "WarGeneral",
      "role": "Officer",
      "level": 42,
      "rank": "Diamond",
      "points": 1950,
      "lastActive": "1 hour ago",
      "joinDate": "2023-04-01",
      "avatar": "https://picsum.photos/60/60?random=13&keyword=general",
    },
    {
      "name": "ProSniper",
      "role": "Member",
      "level": 38,
      "rank": "Platinum",
      "points": 1650,
      "lastActive": "Online",
      "joinDate": "2023-05-10",
      "avatar": "https://picsum.photos/60/60?random=14&keyword=sniper",
    },
    {
      "name": "YoungWarrior",
      "role": "Member",
      "level": 35,
      "rank": "Gold",
      "points": 1420,
      "lastActive": "30 minutes ago",
      "joinDate": "2023-06-01",
      "avatar": "https://picsum.photos/60/60?random=15&keyword=warrior",
    },
  ];

  List<Map<String, dynamic>> get filteredClans {
    return availableClans.where((clan) {
      final matchesSearch = searchQuery.isEmpty ||
          (clan["name"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
          (clan["tag"] as String).toLowerCase().contains(searchQuery.toLowerCase());
      final matchesRegion = selectedRegion == "All" || clan["region"] == selectedRegion;
      return matchesSearch && matchesRegion;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Clans",
      selectedIndex: selectedTab,
      tabs: [
        Tab(text: "My Clan", icon: Icon(Icons.home)),
        Tab(text: "Browse", icon: Icon(Icons.search)),
        Tab(text: "Create", icon: Icon(Icons.add)),
      ],
      tabChildren: [
        // My Clan Tab
        if (myClan != null)
          SingleChildScrollView(
            padding: EdgeInsets.all(spMd),
            child: Column(
              spacing: spMd,
              children: [
                // Clan Header
                Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    spacing: spSm,
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 30,
                            backgroundImage: NetworkImage("${myClan!["emblem"]}"),
                          ),
                          SizedBox(width: spSm),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      "${myClan!["name"]}",
                                      style: TextStyle(
                                        fontSize: fsH5,
                                        fontWeight: FontWeight.bold,
                                        color: primaryColor,
                                      ),
                                    ),
                                    SizedBox(width: spXs),
                                    Text(
                                      "${myClan!["tag"]}",
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                  ],
                                ),
                                Text(
                                  "Level ${myClan!["level"]} • Rank #${myClan!["rank"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                Text(
                                  "Your Role: ${myClan!["memberRole"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: successColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Text(
                        "${myClan!["description"]}",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ),

                // Clan Stats
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(radiusMd),
                          boxShadow: [shadowSm],
                        ),
                        child: Column(
                          children: [
                            Text(
                              "${myClan!["members"]}/${myClan!["maxMembers"]}",
                              style: TextStyle(
                                fontSize: fsH4,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              "Members",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(radiusMd),
                          boxShadow: [shadowSm],
                        ),
                        child: Column(
                          children: [
                            Text(
                              "${((myClan!["points"] as int) / 1000).toStringAsFixed(1)}K",
                              style: TextStyle(
                                fontSize: fsH4,
                                fontWeight: FontWeight.bold,
                                color: successColor,
                              ),
                            ),
                            Text(
                              "Points",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(radiusMd),
                          boxShadow: [shadowSm],
                        ),
                        child: Column(
                          children: [
                            Text(
                              "${myClan!["warWins"]}/${myClan!["warLosses"]}",
                              style: TextStyle(
                                fontSize: fsH4,
                                fontWeight: FontWeight.bold,
                                color: warningColor,
                              ),
                            ),
                            Text(
                              "W/L Ratio",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),

                // Clan Members
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
                            Icons.people,
                            color: primaryColor,
                            size: 20,
                          ),
                          SizedBox(width: spXs),
                          Text(
                            "Clan Members",
                            style: TextStyle(
                              fontSize: fsH6,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          Spacer(),
                          QButton(
                            icon: Icons.person_add,
                            size: bs.sm,
                            onPressed: () {
                              //navigateTo('InviteMemberView')
                            },
                          ),
                        ],
                      ),
                      ...clanMembers.map((member) {
                        return Container(
                          padding: EdgeInsets.all(spSm),
                          margin: EdgeInsets.only(bottom: spXs),
                          decoration: BoxDecoration(
                            color: Colors.grey.withAlpha(10),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Row(
                            children: [
                              CircleAvatar(
                                radius: 20,
                                backgroundImage: NetworkImage("${member["avatar"]}"),
                              ),
                              SizedBox(width: spSm),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          "${member["name"]}",
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
                                            color: primaryColor,
                                          ),
                                        ),
                                        SizedBox(width: spXs),
                                        Container(
                                          padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                          decoration: BoxDecoration(
                                            color: member["role"] == "Leader" 
                                                ? dangerColor 
                                                : member["role"] == "Co-Leader" 
                                                    ? warningColor 
                                                    : member["role"] == "Officer" 
                                                        ? successColor 
                                                        : disabledBoldColor,
                                            borderRadius: BorderRadius.circular(radiusXs),
                                          ),
                                          child: Text(
                                            "${member["role"]}",
                                            style: TextStyle(
                                              fontSize: 10,
                                              color: Colors.white,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Text(
                                      "Lv.${member["level"]} • ${member["rank"]} • ${member["points"]} pts",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    "${member["lastActive"]}",
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: member["lastActive"] == "Online" 
                                          ? successColor 
                                          : disabledBoldColor,
                                    ),
                                  ),
                                  Text(
                                    "Joined ${member["joinDate"]}",
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      }),
                    ],
                  ),
                ),

                // Clan Actions
                Row(
                  children: [
                    Expanded(
                      child: QButton(
                        label: "Start Clan War",
                        size: bs.sm,
                        onPressed: () {
                          //navigateTo('ClanWarView')
                        },
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: QButton(
                        label: "Clan Chat",
                        size: bs.sm,
                        onPressed: () {
                          //navigateTo('ClanChatView')
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )
        else
          // No Clan State
          SingleChildScrollView(
            padding: EdgeInsets.all(spMd),
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.all(sp2xl),
                  child: Column(
                    children: [
                      Icon(
                        Icons.group_add,
                        size: 64,
                        color: disabledBoldColor,
                      ),
                      SizedBox(height: spSm),
                      Text(
                        "No Clan",
                        style: TextStyle(
                          fontSize: fsH5,
                          fontWeight: FontWeight.bold,
                          color: disabledBoldColor,
                        ),
                      ),
                      Text(
                        "Join or create a clan to connect with other players",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),
                      SizedBox(height: spSm),
                      Row(
                        children: [
                          Expanded(
                            child: QButton(
                              label: "Browse Clans",
                              size: bs.sm,
                              onPressed: () {
                                setState(() {
                                  selectedTab = 1;
                                });
                              },
                            ),
                          ),
                          SizedBox(width: spSm),
                          Expanded(
                            child: QButton(
                              label: "Create Clan",
                              size: bs.sm,
                              onPressed: () {
                                setState(() {
                                  selectedTab = 2;
                                });
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

        // Browse Clans Tab
        SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: Column(
            spacing: spMd,
            children: [
              // Search and Filter
              QTextField(
                label: "Search clans...",
                value: searchQuery,
                onChanged: (value) {
                  searchQuery = value;
                  setState(() {});
                },
              ),

              QDropdownField(
                label: "Region",
                items: [
                  {"label": "All", "value": "All"},
                  {"label": "Global", "value": "Global"},
                  {"label": "US East", "value": "US East"},
                  {"label": "US West", "value": "US West"},
                  {"label": "Europe", "value": "Europe"},
                  {"label": "Asia", "value": "Asia"},
                ],
                value: selectedRegion,
                onChanged: (value, label) {
                  selectedRegion = value;
                  setState(() {});
                },
              ),

              // Clans List
              ...filteredClans.map((clan) {
                return Container(
                  margin: EdgeInsets.only(bottom: spSm),
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
                          CircleAvatar(
                            radius: 25,
                            backgroundImage: NetworkImage("${clan["emblem"]}"),
                          ),
                          SizedBox(width: spSm),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      "${clan["name"]}",
                                      style: TextStyle(
                                        fontSize: fsH6,
                                        fontWeight: FontWeight.bold,
                                        color: primaryColor,
                                      ),
                                    ),
                                    SizedBox(width: spXs),
                                    Text(
                                      "${clan["tag"]}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                    if (!clan["isPublic"]) ...[
                                      SizedBox(width: spXs),
                                      Icon(
                                        Icons.lock,
                                        size: 16,
                                        color: warningColor,
                                      ),
                                    ],
                                  ],
                                ),
                                Text(
                                  "Level ${clan["level"]} • Rank #${clan["rank"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                Text(
                                  "Leader: ${clan["leader"]}",
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

                      Text(
                        "${clan["description"]}",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),

                      // Clan Stats
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Members: ${clan["members"]}/${clan["maxMembers"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: primaryColor,
                                  ),
                                ),
                                Text(
                                  "Points: ${((clan["points"] as int) / 1000).toStringAsFixed(1)}K",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: successColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Region: ${clan["region"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                Text(
                                  "Wars: ${clan["warWins"]}W/${clan["warLosses"]}L",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: warningColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),

                      // Requirements
                      if ((clan["requirements"] as List).isNotEmpty)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Requirements:",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: primaryColor,
                              ),
                            ),
                            SizedBox(height: spXs),
                            ...(clan["requirements"] as List<String>).map((req) {
                              return Padding(
                                padding: EdgeInsets.only(left: spSm),
                                child: Text(
                                  "• $req",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              );
                            }),
                          ],
                        ),

                      // Action Buttons
                      Row(
                        children: [
                          Expanded(
                            child: QButton(
                              label: clan["isPublic"] ? "Join Clan" : "Request to Join",
                              size: bs.sm,
                              onPressed: () {
                                //navigateTo('JoinClanView', arguments: clan)
                              },
                            ),
                          ),
                          SizedBox(width: spSm),
                          QButton(
                            icon: Icons.info,
                            size: bs.sm,
                            onPressed: () {
                              //navigateTo('ClanDetailsView', arguments: clan)
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              }),

              if (filteredClans.isEmpty)
                Container(
                  padding: EdgeInsets.all(sp2xl),
                  child: Column(
                    children: [
                      Icon(
                        Icons.search_off,
                        size: 64,
                        color: disabledBoldColor,
                      ),
                      SizedBox(height: spSm),
                      Text(
                        "No clans found",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: disabledBoldColor,
                        ),
                      ),
                      Text(
                        "Try adjusting your search criteria",
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
        ),

        // Create Clan Tab
        SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: Column(
            spacing: spMd,
            children: [
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: primaryColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusMd),
                  border: Border.all(color: primaryColor.withAlpha(50)),
                ),
                child: Column(
                  children: [
                    Icon(
                      Icons.group_add,
                      size: 64,
                      color: primaryColor,
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "Create Your Clan",
                      style: TextStyle(
                        fontSize: fsH5,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "Start your own clan and build a community of like-minded players",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(height: spSm),
                    QButton(
                      label: "Create Clan",
                      size: bs.md,
                      onPressed: () {
                        //navigateTo('CreateClanView')
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
