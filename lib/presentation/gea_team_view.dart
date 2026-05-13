import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GeaTeamView extends StatefulWidget {
  const GeaTeamView({super.key});

  @override
  State<GeaTeamView> createState() => _GeaTeamViewState();
}

class _GeaTeamViewState extends State<GeaTeamView> {
  int selectedTab = 0;
  String searchQuery = "";
  String selectedRole = "All";
  bool showOnlineOnly = false;

  final List<Map<String, dynamic>> teamMembers = [
    {
      "id": "T001",
      "name": "AlphaStrike",
      "role": "Captain",
      "level": 58,
      "rank": "Diamond",
      "status": "Online",
      "avatar": "https://picsum.photos/60/60?random=10",
      "winRate": 87.5,
      "kda": "3.2",
      "joinDate": "2024-01-15",
      "lastActive": "Now",
      "gamesPlayed": 1247,
      "mvpCount": 89,
      "isLeader": true,
    },
    {
      "id": "T002",
      "name": "ShadowNinja",
      "role": "Vice Captain",
      "level": 54,
      "rank": "Diamond",
      "status": "In Game",
      "avatar": "https://picsum.photos/60/60?random=11",
      "winRate": 82.1,
      "kda": "2.8",
      "joinDate": "2024-01-20",
      "lastActive": "5 mins ago",
      "gamesPlayed": 892,
      "mvpCount": 67,
      "isLeader": false,
    },
    {
      "id": "T003",
      "name": "FireStorm",
      "role": "Assault",
      "level": 47,
      "rank": "Platinum",
      "status": "Online",
      "avatar": "https://picsum.photos/60/60?random=12",
      "winRate": 76.8,
      "kda": "2.1",
      "joinDate": "2024-02-10",
      "lastActive": "Now",
      "gamesPlayed": 634,
      "mvpCount": 34,
      "isLeader": false,
    },
    {
      "id": "T004",
      "name": "IceQueen",
      "role": "Support",
      "level": 51,
      "rank": "Platinum",
      "status": "Away",
      "avatar": "https://picsum.photos/60/60?random=13",
      "winRate": 79.3,
      "kda": "1.9",
      "joinDate": "2024-02-25",
      "lastActive": "1 hour ago",
      "gamesPlayed": 728,
      "mvpCount": 41,
      "isLeader": false,
    },
    {
      "id": "T005",
      "name": "TechGuru",
      "role": "Strategist",
      "level": 49,
      "rank": "Gold",
      "status": "Offline",
      "avatar": "https://picsum.photos/60/60?random=14",
      "winRate": 74.2,
      "kda": "2.4",
      "joinDate": "2024-03-05",
      "lastActive": "2 days ago",
      "gamesPlayed": 456,
      "mvpCount": 28,
      "isLeader": false,
    },
  ];

  final List<Map<String, dynamic>> teamStats = [
    {"label": "Team Rank", "value": "#23", "change": "+5"},
    {"label": "Win Rate", "value": "84.2%", "change": "+2.1%"},
    {"label": "Total Games", "value": "328", "change": "+12"},
    {"label": "Championships", "value": "3", "change": "+1"},
  ];

  final List<Map<String, dynamic>> recentMatches = [
    {
      "opponent": "Lightning Bolts",
      "result": "Victory",
      "score": "16-12",
      "map": "Dust Valley",
      "date": "2024-03-15",
      "duration": "28:45",
      "mvp": "AlphaStrike"
    },
    {
      "opponent": "Storm Raiders",
      "result": "Victory",
      "score": "16-8",
      "map": "Neon City",
      "date": "2024-03-14",
      "duration": "22:30",
      "mvp": "ShadowNinja"
    },
    {
      "opponent": "Fire Dragons",
      "result": "Defeat",
      "score": "12-16",
      "map": "Ancient Temple",
      "date": "2024-03-13",
      "duration": "32:18",
      "mvp": "FireStorm"
    },
  ];

  final List<Map<String, dynamic>> upcomingEvents = [
    {
      "type": "Tournament",
      "name": "Spring Championship",
      "date": "2024-03-20",
      "time": "19:00",
      "prize": "\$5,000",
      "status": "Registered"
    },
    {
      "type": "Scrim",
      "name": "vs Thunder Hawks",
      "date": "2024-03-18",
      "time": "20:30",
      "prize": "Practice",
      "status": "Confirmed"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Cyber Warriors",
      selectedIndex: selectedTab,
      tabs: [
        Tab(text: "Overview", icon: Icon(Icons.dashboard)),
        Tab(text: "Members", icon: Icon(Icons.group)),
        Tab(text: "Matches", icon: Icon(Icons.sports_esports)),
        Tab(text: "Schedule", icon: Icon(Icons.calendar_today)),
      ],
      tabChildren: [
        _buildOverviewTab(),
        _buildMembersTab(),
        _buildMatchesTab(),
        _buildScheduleTab(),
      ],
    );
  }

  Widget _buildOverviewTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Team Banner
          Container(
            width: double.infinity,
            height: 150,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [primaryColor, primaryColor.withAlpha(150)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(radiusMd),
              image: DecorationImage(
                image: NetworkImage("https://picsum.photos/400/150?random=100"),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                  primaryColor.withAlpha(120),
                  BlendMode.overlay,
                ),
              ),
            ),
            child: Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(radiusMd),
                gradient: LinearGradient(
                  colors: [Colors.black.withAlpha(80), Colors.transparent],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 3),
                          image: DecorationImage(
                            image: NetworkImage("https://picsum.photos/60/60?random=101"),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SizedBox(width: spMd),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Cyber Warriors",
                              style: TextStyle(
                                fontSize: fsH4,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              "EST. 2024 • 5 Members • Competitive Team",
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.white.withAlpha(200),
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
                          "RANK #23",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          // Team Stats
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
                  "Team Statistics",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spMd),
                ResponsiveGridView(
                  minItemWidth: 150,
                  children: teamStats.map((stat) => _buildStatCard(stat)).toList(),
                ),
              ],
            ),
          ),

          // Active Members
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
                Row(
                  children: [
                    Text(
                      "Active Members",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Spacer(),
                    GestureDetector(
                      onTap: () {
                        selectedTab = 1;
                        setState(() {});
                      },
                      child: Text(
                        "View All",
                        style: TextStyle(
                          fontSize: 14,
                          color: primaryColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spMd),
                ...teamMembers.take(3).map((member) => _buildMemberPreview(member)),
              ],
            ),
          ),

          // Recent Match
          if (recentMatches.isNotEmpty)
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
                    "Latest Match",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spMd),
                  _buildMatchCard(recentMatches.first),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildMembersTab() {
    List<Map<String, dynamic>> filteredMembers = teamMembers.where((member) {
      bool matchesSearch = member["name"].toLowerCase().contains(searchQuery.toLowerCase());
      bool matchesRole = selectedRole == "All" || member["role"] == selectedRole;
      bool matchesStatus = !showOnlineOnly || (member["status"] == "Online" || member["status"] == "In Game");
      return matchesSearch && matchesRole && matchesStatus;
    }).toList();

    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Search and Filters
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              spacing: spSm,
              children: [
                Row(
                  spacing: spSm,
                  children: [
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: spMd, vertical: spSm),
                        decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.search, color: disabledBoldColor),
                            SizedBox(width: spSm),
                            Expanded(
                              child: Text(
                                searchQuery.isEmpty ? "Search members..." : searchQuery,
                                style: TextStyle(
                                  color: searchQuery.isEmpty ? disabledBoldColor : Colors.black,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    QButton(
                      icon: Icons.person_add,
                      size: bs.sm,
                      onPressed: () {
                        //navigateTo(GeaInviteMemberView())
                      },
                    ),
                  ],
                ),
                
                Row(
                  spacing: spSm,
                  children: [
                    Expanded(
                      child: QDropdownField(
                        label: "Role",
                        items: [
                          {"label": "All Roles", "value": "All"},
                          {"label": "Captain", "value": "Captain"},
                          {"label": "Vice Captain", "value": "Vice Captain"},
                          {"label": "Assault", "value": "Assault"},
                          {"label": "Support", "value": "Support"},
                          {"label": "Strategist", "value": "Strategist"},
                        ],
                        value: selectedRole,
                        onChanged: (value, label) {
                          selectedRole = value;
                          setState(() {});
                        },
                      ),
                    ),
                  ],
                ),
                
                Row(
                  children: [
                    Expanded(
                      child: QSwitch(
                        items: [
                          {
                            "label": "Show Online Only",
                            "value": true,
                            "checked": showOnlineOnly,
                          }
                        ],
                        value: [
                          if (showOnlineOnly)
                            {
                              "label": "Show Online Only",
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
              ],
            ),
          ),

          // Members List
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
                  "Team Members (${filteredMembers.length})",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spMd),
                if (filteredMembers.isEmpty)
                  Center(
                    child: Column(
                      children: [
                        Icon(Icons.people_outline, size: 64, color: disabledBoldColor),
                        SizedBox(height: spSm),
                        Text(
                          "No members found",
                          style: TextStyle(
                            color: disabledBoldColor,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  )
                else
                  ...filteredMembers.map((member) => _buildMemberCard(member)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMatchesTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Match Stats
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              children: [
                Text(
                  "Match Performance",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spMd),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildPerfStat("Played", "328", Icons.sports_esports),
                    _buildPerfStat("Won", "276", Icons.emoji_events),
                    _buildPerfStat("Lost", "52", Icons.close),
                    _buildPerfStat("Win Rate", "84.2%", Icons.trending_up),
                  ],
                ),
              ],
            ),
          ),

          // Recent Matches
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
                Row(
                  children: [
                    Text(
                      "Recent Matches",
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
                        //navigateTo(GeaMatchHistoryView())
                      },
                    ),
                  ],
                ),
                SizedBox(height: spMd),
                ...recentMatches.map((match) => _buildMatchCard(match)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildScheduleTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Quick Actions
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
                  "Quick Actions",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spMd),
                Row(
                  spacing: spSm,
                  children: [
                    Expanded(
                      child: QButton(
                        label: "Schedule Match",
                        icon: Icons.add_circle,
                        onPressed: () {
                          //navigateTo(GeaScheduleMatchView())
                        },
                      ),
                    ),
                    Expanded(
                      child: QButton(
                        label: "Team Practice",
                        icon: Icons.fitness_center,
                        onPressed: () {
                          //navigateTo(GeaTeamPracticeView())
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Upcoming Events
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
                  "Upcoming Events",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spMd),
                if (upcomingEvents.isEmpty)
                  Center(
                    child: Column(
                      children: [
                        Icon(Icons.event_note, size: 64, color: disabledBoldColor),
                        SizedBox(height: spSm),
                        Text(
                          "No upcoming events",
                          style: TextStyle(
                            color: disabledBoldColor,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  )
                else
                  ...upcomingEvents.map((event) => _buildEventCard(event)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(Map<String, dynamic> stat) {
    bool isPositive = stat["change"].startsWith("+");
    
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Column(
        children: [
          Text(
            "${stat["value"]}",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Text(
            "${stat["label"]}",
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),
          if (stat["change"] != null)
            Container(
              padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
              decoration: BoxDecoration(
                color: isPositive ? successColor : dangerColor,
                borderRadius: BorderRadius.circular(radiusXs),
              ),
              child: Text(
                "${stat["change"]}",
                style: TextStyle(
                  fontSize: 10,
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildMemberPreview(Map<String, dynamic> member) {
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      child: Row(
        children: [
          Stack(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: NetworkImage("${member["avatar"]}"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              if (member["status"] == "Online" || member["status"] == "In Game")
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    width: 12,
                    height: 12,
                    decoration: BoxDecoration(
                      color: _getStatusColor(member["status"]),
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 2),
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
                    Text(
                      "${member["name"]}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    if (member["isLeader"])
                      Container(
                        margin: EdgeInsets.only(left: spXs),
                        padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                        decoration: BoxDecoration(
                          color: warningColor,
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Text(
                          "LEADER",
                          style: TextStyle(
                            fontSize: 8,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                  ],
                ),
                Text(
                  "${member["role"]} • Level ${member["level"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
          Text(
            "${member["status"]}",
            style: TextStyle(
              fontSize: 12,
              color: _getStatusColor(member["status"]),
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMemberCard(Map<String, dynamic> member) {
    return Container(
      margin: EdgeInsets.only(bottom: spMd),
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(radiusSm),
        border: member["isLeader"] ? Border.all(color: warningColor, width: 2) : null,
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
                    image: NetworkImage("${member["avatar"]}"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              if (member["status"] == "Online" || member["status"] == "In Game")
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    width: 16,
                    height: 16,
                    decoration: BoxDecoration(
                      color: _getStatusColor(member["status"]),
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 2),
                    ),
                  ),
                ),
            ],
          ),
          SizedBox(width: spMd),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      "${member["name"]}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    if (member["isLeader"])
                      Container(
                        margin: EdgeInsets.only(left: spSm),
                        padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                        decoration: BoxDecoration(
                          color: warningColor,
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Text(
                          "LEADER",
                          style: TextStyle(
                            fontSize: 10,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                  ],
                ),
                Text(
                  "${member["role"]} • Level ${member["level"]} • ${member["rank"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
                Text(
                  "${member["winRate"]}% WR • ${member["kda"]} KDA • ${member["mvpCount"]} MVPs",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
                Text(
                  "Last active: ${member["lastActive"]}",
                  style: TextStyle(
                    fontSize: 10,
                    color: disabledColor,
                  ),
                ),
              ],
            ),
          ),
          Column(
            children: [
              QButton(
                icon: Icons.message,
                size: bs.sm,
                onPressed: () {
                  //navigateTo(GeaChatView(memberId: member["id"]))
                },
              ),
              SizedBox(height: spXs),
              QButton(
                icon: Icons.more_vert,
                size: bs.sm,
                onPressed: () {
                  _showMemberOptions(member);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMatchCard(Map<String, dynamic> match) {
    bool isWin = match["result"] == "Victory";
    
    return Container(
      margin: EdgeInsets.only(bottom: spMd),
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: isWin ? successColor.withAlpha(5) : dangerColor.withAlpha(5),
        border: Border(
          left: BorderSide(
            width: 4,
            color: isWin ? successColor : dangerColor,
          ),
        ),
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                "${match["result"]}",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: isWin ? successColor : dangerColor,
                ),
              ),
              Spacer(),
              Text(
                "${match["score"]}",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          SizedBox(height: spXs),
          Row(
            children: [
              Text(
                "vs ${match["opponent"]}",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Spacer(),
              Text(
                "${match["date"]}",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
          Text(
            "${match["map"]} • ${match["duration"]} • MVP: ${match["mvp"]}",
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEventCard(Map<String, dynamic> event) {
    return Container(
      margin: EdgeInsets.only(bottom: spMd),
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Row(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(10),
              shape: BoxShape.circle,
            ),
            child: Icon(
              event["type"] == "Tournament" ? Icons.emoji_events : Icons.sports_esports,
              color: primaryColor,
              size: 24,
            ),
          ),
          SizedBox(width: spMd),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${event["name"]}",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "${event["type"]} • ${event["date"]} at ${event["time"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
                Text(
                  "Prize: ${event["prize"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: successColor,
                    fontWeight: FontWeight.w600,
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
              "${event["status"]}",
              style: TextStyle(
                fontSize: 12,
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPerfStat(String label, String value, IconData icon) {
    return Column(
      children: [
        Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: primaryColor.withAlpha(10),
            shape: BoxShape.circle,
          ),
          child: Icon(
            icon,
            color: primaryColor,
            size: 24,
          ),
        ),
        SizedBox(height: spXs),
        Text(
          value,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: disabledBoldColor,
          ),
        ),
      ],
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "Online":
        return successColor;
      case "In Game":
        return warningColor;
      case "Away":
        return infoColor;
      case "Offline":
        return disabledBoldColor;
      default:
        return disabledBoldColor;
    }
  }

  void _showMemberOptions(Map<String, dynamic> member) {
    // Show member options dialog
  }
}
