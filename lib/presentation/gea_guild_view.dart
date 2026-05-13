import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GeaGuildView extends StatefulWidget {
  const GeaGuildView({super.key});

  @override
  State<GeaGuildView> createState() => _GeaGuildViewState();
}

class _GeaGuildViewState extends State<GeaGuildView> {
  int selectedTab = 0;
  String searchQuery = "";
  String selectedCategory = "All";

  // Current user's guild data
  Map<String, dynamic>? myGuild = {
    "id": 1,
    "name": "Dragon Masters",
    "category": "PvE",
    "level": 22,
    "members": 156,
    "maxMembers": 200,
    "prestige": 45680,
    "description": "Elite PvE guild focused on raids and dungeon clearing. We help members progress and achieve their goals.",
    "banner": "https://picsum.photos/400/150?random=1&keyword=dragon",
    "leader": "DragonLord",
    "founded": "2023-01-10",
    "requirements": ["Level 35+", "Active Participation", "Voice Chat"],
    "isRecruiting": true,
    "memberRole": "Officer",
    "weeklyActivity": 95,
    "guildHall": "Mystic Castle",
  };

  List<Map<String, dynamic>> availableGuilds = [
    {
      "id": 2,
      "name": "Shadow Syndicate",
      "category": "PvP",
      "level": 18,
      "members": 89,
      "maxMembers": 100,
      "prestige": 38940,
      "description": "Hardcore PvP guild for competitive players. We dominate battlegrounds and arena.",
      "banner": "https://picsum.photos/400/150?random=2&keyword=shadow",
      "leader": "ShadowKing",
      "requirements": ["Level 40+", "PvP Experience", "High Skill Rating"],
      "isRecruiting": true,
      "weeklyActivity": 88,
    },
    {
      "id": 3,
      "name": "Peaceful Traders",
      "category": "Trading",
      "level": 14,
      "members": 124,
      "maxMembers": 150,
      "prestige": 26580,
      "description": "Merchant guild focused on trading, crafting, and economic activities.",
      "banner": "https://picsum.photos/400/150?random=3&keyword=trade",
      "leader": "MerchantMaster",
      "requirements": ["Level 20+", "Active Trading", "Helpful Attitude"],
      "isRecruiting": true,
      "weeklyActivity": 72,
    },
    {
      "id": 4,
      "name": "Casual Explorers",
      "category": "Social",
      "level": 11,
      "members": 67,
      "maxMembers": 80,
      "prestige": 15420,
      "description": "Friendly social guild for casual players. We explore together and have fun!",
      "banner": "https://picsum.photos/400/150?random=4&keyword=explore",
      "leader": "Explorer",
      "requirements": ["Level 15+", "Friendly", "Weekly Participation"],
      "isRecruiting": true,
      "weeklyActivity": 65,
    },
  ];

  List<Map<String, dynamic>> guildMembers = [
    {
      "name": "DragonLord",
      "role": "Guild Master",
      "level": 55,
      "class": "Warrior",
      "contribution": 5240,
      "lastActive": "Online",
      "joinDate": "2023-01-10",
      "avatar": "https://picsum.photos/60/60?random=21&keyword=dragon",
    },
    {
      "name": "ViceLeader",
      "role": "Vice Master",
      "level": 52,
      "class": "Mage",
      "contribution": 4680,
      "lastActive": "1 hour ago",
      "joinDate": "2023-01-15",
      "avatar": "https://picsum.photos/60/60?random=22&keyword=mage",
    },
    {
      "name": "RaidCommander",
      "role": "Officer",
      "level": 49,
      "class": "Paladin",
      "contribution": 3950,
      "lastActive": "Online",
      "joinDate": "2023-02-01",
      "avatar": "https://picsum.photos/60/60?random=23&keyword=paladin",
    },
    {
      "name": "Healer Supreme",
      "role": "Officer",
      "level": 47,
      "class": "Cleric",
      "contribution": 3720,
      "lastActive": "30 minutes ago",
      "joinDate": "2023-02-10",
      "avatar": "https://picsum.photos/60/60?random=24&keyword=healer",
    },
    {
      "name": "ShadowAssassin",
      "role": "Member",
      "level": 44,
      "class": "Rogue",
      "contribution": 2890,
      "lastActive": "2 hours ago",
      "joinDate": "2023-03-05",
      "avatar": "https://picsum.photos/60/60?random=25&keyword=assassin",
    },
  ];

  List<Map<String, dynamic>> guildActivities = [
    {
      "type": "Raid",
      "name": "Dragon's Lair",
      "difficulty": "Mythic",
      "time": "Today 20:00",
      "participants": 15,
      "maxParticipants": 20,
      "rewards": ["Epic Gear", "Guild Points"],
    },
    {
      "type": "Event",
      "name": "Guild War",
      "difficulty": "PvP",
      "time": "Tomorrow 19:00",
      "participants": 35,
      "maxParticipants": 50,
      "rewards": ["Prestige Points", "Rare Items"],
    },
    {
      "type": "Social",
      "name": "Weekly Meeting",
      "difficulty": "Social",
      "time": "Sunday 18:00",
      "participants": 25,
      "maxParticipants": 50,
      "rewards": ["Guild Bonuses", "Planning"],
    },
  ];

  List<Map<String, dynamic>> get filteredGuilds {
    return availableGuilds.where((guild) {
      final matchesSearch = searchQuery.isEmpty ||
          (guild["name"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
          (guild["description"] as String).toLowerCase().contains(searchQuery.toLowerCase());
      final matchesCategory = selectedCategory == "All" || guild["category"] == selectedCategory;
      return matchesSearch && matchesCategory;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Guilds",
      selectedIndex: selectedTab,
      tabs: [
        Tab(text: "My Guild", icon: Icon(Icons.castle)),
        Tab(text: "Browse", icon: Icon(Icons.explore)),
        Tab(text: "Create", icon: Icon(Icons.add_business)),
      ],
      tabChildren: [
        // My Guild Tab
        if (myGuild != null)
          SingleChildScrollView(
            padding: EdgeInsets.all(spMd),
            child: Column(
              spacing: spMd,
              children: [
                // Guild Banner
                Container(
                  height: 120,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(radiusMd),
                    child: Stack(
                      children: [
                        Image.network(
                          "${myGuild!["banner"]}",
                          width: double.infinity,
                          height: 120,
                          fit: BoxFit.cover,
                        ),
                        Container(
                          width: double.infinity,
                          height: 120,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Colors.transparent,
                                Colors.black.withAlpha(150),
                              ],
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: spSm,
                          left: spSm,
                          right: spSm,
                          child: Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "${myGuild!["name"]}",
                                      style: TextStyle(
                                        fontSize: fsH5,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                    Text(
                                      "Level ${myGuild!["level"]} ${myGuild!["category"]} Guild",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                                decoration: BoxDecoration(
                                  color: successColor,
                                  borderRadius: BorderRadius.circular(radiusSm),
                                ),
                                child: Text(
                                  "${myGuild!["memberRole"]}",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // Guild Stats
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
                              "${myGuild!["members"]}/${myGuild!["maxMembers"]}",
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
                              "${((myGuild!["prestige"] as int) / 1000).toStringAsFixed(1)}K",
                              style: TextStyle(
                                fontSize: fsH4,
                                fontWeight: FontWeight.bold,
                                color: warningColor,
                              ),
                            ),
                            Text(
                              "Prestige",
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
                              "${myGuild!["weeklyActivity"]}%",
                              style: TextStyle(
                                fontSize: fsH4,
                                fontWeight: FontWeight.bold,
                                color: successColor,
                              ),
                            ),
                            Text(
                              "Activity",
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

                // Guild Description
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
                            Icons.info,
                            color: primaryColor,
                            size: 20,
                          ),
                          SizedBox(width: spXs),
                          Text(
                            "Guild Information",
                            style: TextStyle(
                              fontSize: fsH6,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        "${myGuild!["description"]}",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.location_city,
                            size: 16,
                            color: primaryColor,
                          ),
                          SizedBox(width: spXs),
                          Text(
                            "Guild Hall: ${myGuild!["guildHall"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: primaryColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                // Upcoming Activities
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
                            Icons.event,
                            color: primaryColor,
                            size: 20,
                          ),
                          SizedBox(width: spXs),
                          Text(
                            "Upcoming Activities",
                            style: TextStyle(
                              fontSize: fsH6,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                        ],
                      ),
                      ...guildActivities.map((activity) {
                        return Container(
                          padding: EdgeInsets.all(spSm),
                          margin: EdgeInsets.only(bottom: spXs),
                          decoration: BoxDecoration(
                            color: activity["type"] == "Raid" 
                                ? dangerColor.withAlpha(20) 
                                : activity["type"] == "Event" 
                                    ? warningColor.withAlpha(20) 
                                    : successColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                activity["type"] == "Raid" 
                                    ? Icons.shield 
                                    : activity["type"] == "Event" 
                                        ? Icons.emoji_events 
                                        : Icons.group,
                                color: activity["type"] == "Raid" 
                                    ? dangerColor 
                                    : activity["type"] == "Event" 
                                        ? warningColor 
                                        : successColor,
                                size: 20,
                              ),
                              SizedBox(width: spSm),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "${activity["name"]}",
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: primaryColor,
                                      ),
                                    ),
                                    Text(
                                      "${activity["time"]} • ${activity["participants"]}/${activity["maxParticipants"]} joined",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              QButton(
                                label: "Join",
                                size: bs.sm,
                                onPressed: () {
                                  //navigateTo('GuildActivityView', arguments: activity)
                                },
                              ),
                            ],
                          ),
                        );
                      }),
                    ],
                  ),
                ),

                // Guild Members (Top Contributors)
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
                            "Top Contributors",
                            style: TextStyle(
                              fontSize: fsH6,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          Spacer(),
                          QButton(
                            label: "View All",
                            size: bs.sm,
                            onPressed: () {
                              //navigateTo('GuildMembersView')
                            },
                          ),
                        ],
                      ),
                      ...guildMembers.take(5).map((member) {
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
                                            color: member["role"] == "Guild Master" 
                                                ? dangerColor 
                                                : member["role"] == "Vice Master" 
                                                    ? warningColor 
                                                    : successColor,
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
                                      "Lv.${member["level"]} ${member["class"]} • ${member["contribution"]} pts",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Text(
                                "${member["lastActive"]}",
                                style: TextStyle(
                                  fontSize: 10,
                                  color: member["lastActive"] == "Online" 
                                      ? successColor 
                                      : disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        );
                      }),
                    ],
                  ),
                ),

                // Guild Actions
                Row(
                  children: [
                    Expanded(
                      child: QButton(
                        label: "Guild Chat",
                        size: bs.sm,
                        onPressed: () {
                          //navigateTo('GuildChatView')
                        },
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: QButton(
                        label: "Guild Hall",
                        size: bs.sm,
                        onPressed: () {
                          //navigateTo('GuildHallView')
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )
        else
          // No Guild State
          SingleChildScrollView(
            padding: EdgeInsets.all(spMd),
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.all(sp2xl),
                  child: Column(
                    children: [
                      Icon(
                        Icons.castle,
                        size: 64,
                        color: disabledBoldColor,
                      ),
                      SizedBox(height: spSm),
                      Text(
                        "No Guild",
                        style: TextStyle(
                          fontSize: fsH5,
                          fontWeight: FontWeight.bold,
                          color: disabledBoldColor,
                        ),
                      ),
                      Text(
                        "Join a guild to participate in raids, events, and social activities",
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
                              label: "Browse Guilds",
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
                              label: "Create Guild",
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

        // Browse Guilds Tab
        SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: Column(
            spacing: spMd,
            children: [
              // Search and Filter
              QTextField(
                label: "Search guilds...",
                value: searchQuery,
                onChanged: (value) {
                  searchQuery = value;
                  setState(() {});
                },
              ),

              QDropdownField(
                label: "Category",
                items: [
                  {"label": "All", "value": "All"},
                  {"label": "PvE", "value": "PvE"},
                  {"label": "PvP", "value": "PvP"},
                  {"label": "Trading", "value": "Trading"},
                  {"label": "Social", "value": "Social"},
                  {"label": "Crafting", "value": "Crafting"},
                ],
                value: selectedCategory,
                onChanged: (value, label) {
                  selectedCategory = value;
                  setState(() {});
                },
              ),

              // Guilds List
              ...filteredGuilds.map((guild) {
                return Container(
                  margin: EdgeInsets.only(bottom: spSm),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Guild Banner
                      ClipRRect(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(radiusMd),
                          topRight: Radius.circular(radiusMd),
                        ),
                        child: Stack(
                          children: [
                            Image.network(
                              "${guild["banner"]}",
                              height: 100,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                            Container(
                              height: 100,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                    Colors.transparent,
                                    Colors.black.withAlpha(150),
                                  ],
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: spSm,
                              left: spSm,
                              right: spSm,
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "${guild["name"]}",
                                          style: TextStyle(
                                            fontSize: fsH6,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                          ),
                                        ),
                                        Text(
                                          "Level ${guild["level"]} ${guild["category"]} Guild",
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  if (guild["isRecruiting"])
                                    Container(
                                      padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                                      decoration: BoxDecoration(
                                        color: successColor,
                                        borderRadius: BorderRadius.circular(radiusSm),
                                      ),
                                      child: Text(
                                        "Recruiting",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Guild Details
                      Padding(
                        padding: EdgeInsets.all(spSm),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: spSm,
                          children: [
                            Text(
                              "${guild["description"]}",
                              style: TextStyle(
                                fontSize: 14,
                                color: disabledBoldColor,
                              ),
                            ),

                            // Guild Stats
                            Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Members: ${guild["members"]}/${guild["maxMembers"]}",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: primaryColor,
                                        ),
                                      ),
                                      Text(
                                        "Prestige: ${((guild["prestige"] as int) / 1000).toStringAsFixed(1)}K",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: warningColor,
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
                                        "Leader: ${guild["leader"]}",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                      Text(
                                        "Activity: ${guild["weeklyActivity"]}%",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: successColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),

                            // Requirements
                            if ((guild["requirements"] as List).isNotEmpty)
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
                                  ...(guild["requirements"] as List<String>).map((req) {
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
                                    label: "Apply to Join",
                                    size: bs.sm,
                                    onPressed: () {
                                      //navigateTo('JoinGuildView', arguments: guild)
                                    },
                                  ),
                                ),
                                SizedBox(width: spSm),
                                QButton(
                                  icon: Icons.info,
                                  size: bs.sm,
                                  onPressed: () {
                                    //navigateTo('GuildDetailsView', arguments: guild)
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }),
            ],
          ),
        ),

        // Create Guild Tab
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
                      Icons.add_business,
                      size: 64,
                      color: primaryColor,
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "Create Your Guild",
                      style: TextStyle(
                        fontSize: fsH5,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "Establish your own guild and lead a community of adventurers",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(height: spSm),
                    QButton(
                      label: "Create Guild",
                      size: bs.md,
                      onPressed: () {
                        //navigateTo('CreateGuildView')
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
