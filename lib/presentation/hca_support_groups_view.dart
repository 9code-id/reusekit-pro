import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class HcaSupportGroupsView extends StatefulWidget {
  const HcaSupportGroupsView({super.key});

  @override
  State<HcaSupportGroupsView> createState() => _HcaSupportGroupsViewState();
}

class _HcaSupportGroupsViewState extends State<HcaSupportGroupsView> {
  String selectedFilter = "All";
  String searchQuery = "";
  bool showMyGroups = false;
  
  List<Map<String, dynamic>> filterOptions = [
    {"label": "All Groups", "value": "All"},
    {"label": "Mental Health", "value": "mental_health"},
    {"label": "Chronic Conditions", "value": "chronic"},
    {"label": "Addiction Recovery", "value": "addiction"},
    {"label": "Cancer Support", "value": "cancer"},
    {"label": "Caregivers", "value": "caregivers"},
    {"label": "Grief & Loss", "value": "grief"},
    {"label": "Youth Support", "value": "youth"},
  ];

  List<Map<String, dynamic>> supportGroups = [
    {
      "id": 1,
      "name": "Diabetes Warriors",
      "description": "Supporting each other through the daily challenges of managing diabetes with practical tips, emotional support, and shared experiences.",
      "category": "chronic",
      "memberCount": 234,
      "meetingType": "Virtual",
      "meetingFrequency": "Weekly",
      "nextMeeting": "2024-01-18T19:00:00Z",
      "facilitator": "Dr. Sarah Martinez, CDE",
      "facilitatorCredentials": "Certified Diabetes Educator",
      "facilitatorImage": "https://picsum.photos/50/50?random=1",
      "isJoined": true,
      "isPrivate": false,
      "tags": ["diabetes", "support", "lifestyle"],
      "createdDate": "2023-06-15",
      "image": "https://picsum.photos/300/150?random=1&keyword=support",
      "location": "Online",
      "rating": 4.8,
      "rules": [
        "Be respectful and supportive",
        "No medical advice - share experiences only",
        "Maintain confidentiality",
        "Be punctual for meetings"
      ],
      "upcomingEvents": [
        {
          "title": "Weekly Check-in",
          "date": "2024-01-18T19:00:00Z",
          "type": "Virtual Meeting"
        },
        {
          "title": "Nutrition Workshop",
          "date": "2024-01-25T18:00:00Z",
          "type": "Educational Session"
        }
      ]
    },
    {
      "id": 2,
      "name": "Anxiety & Depression Support Circle",
      "description": "A safe space for individuals dealing with anxiety and depression to share their journey, coping strategies, and find mutual support.",
      "category": "mental_health",
      "memberCount": 189,
      "meetingType": "Hybrid",
      "meetingFrequency": "Bi-weekly",
      "nextMeeting": "2024-01-20T18:30:00Z",
      "facilitator": "Lisa Thompson, LCSW",
      "facilitatorCredentials": "Licensed Clinical Social Worker",
      "facilitatorImage": "https://picsum.photos/50/50?random=2",
      "isJoined": false,
      "isPrivate": true,
      "tags": ["anxiety", "depression", "mental health"],
      "createdDate": "2023-03-22",
      "image": "https://picsum.photos/300/150?random=2&keyword=mental",
      "location": "Community Center & Online",
      "rating": 4.9,
      "rules": [
        "Screening required before joining",
        "Strict confidentiality policy",
        "No recording of sessions",
        "Professional facilitation only"
      ],
      "upcomingEvents": [
        {
          "title": "Group Therapy Session",
          "date": "2024-01-20T18:30:00Z",
          "type": "Support Meeting"
        },
        {
          "title": "Mindfulness Workshop",
          "date": "2024-02-03T17:00:00Z",
          "type": "Skill Building"
        }
      ]
    },
    {
      "id": 3,
      "name": "Cancer Survivors Network",
      "description": "Connecting cancer survivors and their families for ongoing support, celebrating milestones, and sharing hope through recovery.",
      "category": "cancer",
      "memberCount": 156,
      "meetingType": "In-person",
      "meetingFrequency": "Monthly",
      "nextMeeting": "2024-01-22T14:00:00Z",
      "facilitator": "Michael Rodriguez, LMFT",
      "facilitatorCredentials": "Licensed Marriage & Family Therapist",
      "facilitatorImage": "https://picsum.photos/50/50?random=3",
      "isJoined": true,
      "isPrivate": false,
      "tags": ["cancer", "survivors", "recovery"],
      "createdDate": "2022-11-08",
      "image": "https://picsum.photos/300/150?random=3&keyword=hope",
      "location": "Memorial Hospital, Room 210",
      "rating": 5.0,
      "rules": [
        "Open to survivors and families",
        "Share at your comfort level",
        "Respect everyone's journey",
        "Medical questions to professionals only"
      ],
      "upcomingEvents": [
        {
          "title": "Monthly Gathering",
          "date": "2024-01-22T14:00:00Z",
          "type": "Support Meeting"
        },
        {
          "title": "Nutrition After Treatment",
          "date": "2024-02-19T14:00:00Z",
          "type": "Educational Workshop"
        }
      ]
    },
    {
      "id": 4,
      "name": "Caregiver's Haven",
      "description": "Supporting family caregivers with resources, respite, and understanding from others who share similar experiences and challenges.",
      "category": "caregivers",
      "memberCount": 98,
      "meetingType": "Virtual",
      "meetingFrequency": "Weekly",
      "nextMeeting": "2024-01-19T20:00:00Z",
      "facilitator": "Jennifer Park, RN",
      "facilitatorCredentials": "Registered Nurse, Geriatric Specialist",
      "facilitatorImage": "https://picsum.photos/50/50?random=4",
      "isJoined": false,
      "isPrivate": false,
      "tags": ["caregiving", "family", "respite"],
      "createdDate": "2023-08-12",
      "image": "https://picsum.photos/300/150?random=4&keyword=care",
      "location": "Online",
      "rating": 4.7,
      "rules": [
        "Respect privacy of care recipients",
        "Focus on caregiver wellness",
        "Share resources freely",
        "Support without judgment"
      ],
      "upcomingEvents": [
        {
          "title": "Weekly Support Circle",
          "date": "2024-01-19T20:00:00Z",
          "type": "Support Meeting"
        },
        {
          "title": "Self-Care Workshop",
          "date": "2024-01-26T19:00:00Z",
          "type": "Wellness Session"
        }
      ]
    },
    {
      "id": 5,
      "name": "Young Adults Facing Health Challenges",
      "description": "A support group specifically for young adults (18-35) dealing with chronic illnesses, mental health challenges, or major health transitions.",
      "category": "youth",
      "memberCount": 67,
      "meetingType": "Hybrid",
      "meetingFrequency": "Bi-weekly",
      "nextMeeting": "2024-01-24T19:30:00Z",
      "facilitator": "Alex Chen, LPCC",
      "facilitatorCredentials": "Licensed Professional Clinical Counselor",
      "facilitatorImage": "https://picsum.photos/50/50?random=5",
      "isJoined": true,
      "isPrivate": true,
      "tags": ["young adults", "chronic illness", "mental health"],
      "createdDate": "2023-09-30",
      "image": "https://picsum.photos/300/150?random=5&keyword=youth",
      "location": "Youth Center & Online",
      "rating": 4.6,
      "rules": [
        "Age verification required (18-35)",
        "Peer-focused discussions",
        "Technology-friendly environment",
        "Flexible participation options"
      ],
      "upcomingEvents": [
        {
          "title": "Peer Support Meeting",
          "date": "2024-01-24T19:30:00Z",
          "type": "Support Meeting"
        },
        {
          "title": "Career & Health Balance",
          "date": "2024-02-07T19:00:00Z",
          "type": "Life Skills Workshop"
        }
      ]
    },
    {
      "id": 6,
      "name": "Grief & Loss Healing Circle",
      "description": "A compassionate space for those who have experienced loss, offering support through the healing process and connecting with others who understand.",
      "category": "grief",
      "memberCount": 43,
      "meetingType": "In-person",
      "meetingFrequency": "Weekly",
      "nextMeeting": "2024-01-21T16:00:00Z",
      "facilitator": "Dr. Patricia Williams, Ph.D.",
      "facilitatorCredentials": "Clinical Psychologist, Grief Specialist",
      "facilitatorImage": "https://picsum.photos/50/50?random=6",
      "isJoined": false,
      "isPrivate": true,
      "tags": ["grief", "loss", "bereavement"],
      "createdDate": "2022-05-18",
      "image": "https://picsum.photos/300/150?random=6&keyword=peaceful",
      "location": "Peaceful Gardens Community Room",
      "rating": 4.9,
      "rules": [
        "Pre-screening and intake required",
        "Confidentiality is paramount",
        "Share only what feels comfortable",
        "Professional guidance available"
      ],
      "upcomingEvents": [
        {
          "title": "Weekly Healing Circle",
          "date": "2024-01-21T16:00:00Z",
          "type": "Support Meeting"
        },
        {
          "title": "Memorial Art Therapy",
          "date": "2024-01-28T15:00:00Z",
          "type": "Creative Therapy"
        }
      ]
    }
  ];

  List<Map<String, dynamic>> get filteredGroups {
    var groups = supportGroups;
    
    if (showMyGroups) {
      groups = groups.where((group) => group["isJoined"] == true).toList();
    } else if (selectedFilter != "All") {
      groups = groups.where((group) => group["category"] == selectedFilter).toList();
    }
    
    if (searchQuery.isNotEmpty) {
      groups = groups.where((group) => 
        "${group["name"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
        "${group["description"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
        (group["tags"] as List).any((tag) => tag.toLowerCase().contains(searchQuery.toLowerCase()))
      ).toList();
    }
    
    return groups;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Support Groups"),
        actions: [
          IconButton(
            icon: Icon(Icons.calendar_today),
            onPressed: () {
              // Show upcoming meetings calendar
            },
          ),
          IconButton(
            icon: Icon(Icons.group_add),
            onPressed: () {
              // Create new support group
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Welcome Header
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spLg),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [primaryColor, primaryColor.withAlpha(180)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowMd],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.favorite,
                        color: Colors.white,
                        size: 28,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "Find Your Community",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: fsH5,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "Connect with others who understand your journey. Join support groups for encouragement, resources, and shared experiences.",
                    style: TextStyle(
                      color: Colors.white.withAlpha(230),
                      fontSize: 14,
                      height: 1.4,
                    ),
                  ),
                  SizedBox(height: spMd),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildQuickStat("Active Groups", "${supportGroups.length}", Icons.groups),
                      _buildQuickStat("My Groups", "${supportGroups.where((g) => g["isJoined"]).length}", Icons.bookmark),
                      _buildQuickStat("This Week", "8", Icons.event),
                    ],
                  ),
                ],
              ),
            ),
            
            SizedBox(height: spLg),
            
            // Search Bar
            Row(
              children: [
                Expanded(
                  child: QTextField(
                    label: "Search support groups...",
                    value: searchQuery,
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
                  onPressed: () {
                    // Perform search
                  },
                ),
              ],
            ),
            
            SizedBox(height: spMd),
            
            // Filter Options
            Row(
              children: [
                Expanded(
                  child: QDropdownField(
                    label: "Category",
                    items: filterOptions,
                    value: selectedFilter,
                    onChanged: (value, label) {
                      selectedFilter = value;
                      showMyGroups = false;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spMd),
                Container(
                  width: 120,
                  child: QButton(
                    label: showMyGroups ? "All Groups" : "My Groups",
                    color: showMyGroups ? successColor : primaryColor,
                    size: bs.sm,
                    onPressed: () {
                      showMyGroups = !showMyGroups;
                      if (showMyGroups) {
                        selectedFilter = "All";
                      }
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),
            
            SizedBox(height: spLg),
            
            // Groups Count
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "${filteredGroups.length} Groups Available",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                if (selectedFilter != "All" || showMyGroups || searchQuery.isNotEmpty)
                  GestureDetector(
                    onTap: () {
                      selectedFilter = "All";
                      showMyGroups = false;
                      searchQuery = "";
                      setState(() {});
                    },
                    child: Text(
                      "Clear Filters",
                      style: TextStyle(
                        fontSize: 14,
                        color: dangerColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
              ],
            ),
            
            SizedBox(height: spMd),
            
            // Support Groups List
            ...List.generate(filteredGroups.length, (index) {
              final group = filteredGroups[index];
              return Container(
                margin: EdgeInsets.only(bottom: spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusLg),
                  boxShadow: [shadowSm],
                  border: group["isJoined"] 
                    ? Border.all(color: successColor.withAlpha(100), width: 2)
                    : null,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Group Image Header
                    ClipRRect(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(radiusLg),
                        topRight: Radius.circular(radiusLg),
                      ),
                      child: Stack(
                        children: [
                          Image.network(
                            "${group["image"]}",
                            width: double.infinity,
                            height: 120,
                            fit: BoxFit.cover,
                          ),
                          Positioned(
                            top: spSm,
                            right: spSm,
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                              decoration: BoxDecoration(
                                color: Colors.black.withAlpha(150),
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    Icons.star,
                                    size: 14,
                                    color: warningColor,
                                  ),
                                  SizedBox(width: spXs),
                                  Text(
                                    "${group["rating"]}",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          if (group["isPrivate"])
                            Positioned(
                              top: spSm,
                              left: spSm,
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                                decoration: BoxDecoration(
                                  color: warningColor,
                                  borderRadius: BorderRadius.circular(radiusSm),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      Icons.lock,
                                      size: 12,
                                      color: Colors.white,
                                    ),
                                    SizedBox(width: spXs),
                                    Text(
                                      "Private",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 11,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                    
                    // Group Details
                    Padding(
                      padding: EdgeInsets.all(spMd),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Group Name and Joined Status
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  "${group["name"]}",
                                  style: TextStyle(
                                    fontSize: fsH6,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                              ),
                              if (group["isJoined"])
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                                  decoration: BoxDecoration(
                                    color: successColor,
                                    borderRadius: BorderRadius.circular(radiusSm),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(
                                        Icons.check_circle,
                                        size: 12,
                                        color: Colors.white,
                                      ),
                                      SizedBox(width: spXs),
                                      Text(
                                        "Joined",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 11,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                            ],
                          ),
                          
                          SizedBox(height: spSm),
                          
                          // Description
                          Text(
                            "${group["description"]}",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                              height: 1.4,
                            ),
                          ),
                          
                          SizedBox(height: spMd),
                          
                          // Facilitator Info
                          Row(
                            children: [
                              CircleAvatar(
                                radius: 16,
                                backgroundImage: NetworkImage("${group["facilitatorImage"]}"),
                              ),
                              SizedBox(width: spSm),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "${group["facilitator"]}",
                                      style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.bold,
                                        color: primaryColor,
                                      ),
                                    ),
                                    Text(
                                      "${group["facilitatorCredentials"]}",
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
                          
                          SizedBox(height: spMd),
                          
                          // Group Stats
                          Container(
                            padding: EdgeInsets.all(spSm),
                            decoration: BoxDecoration(
                              color: disabledColor,
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                _buildGroupStat(Icons.people, "${group["memberCount"]}", "Members"),
                                _buildGroupStat(Icons.video_call, "${group["meetingType"]}", "Format"),
                                _buildGroupStat(Icons.schedule, "${group["meetingFrequency"]}", "Frequency"),
                              ],
                            ),
                          ),
                          
                          SizedBox(height: spMd),
                          
                          // Next Meeting Info
                          if (group["nextMeeting"] != null)
                            Container(
                              width: double.infinity,
                              padding: EdgeInsets.all(spSm),
                              decoration: BoxDecoration(
                                color: infoColor.withAlpha(25),
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.event,
                                        size: 16,
                                        color: infoColor,
                                      ),
                                      SizedBox(width: spXs),
                                      Text(
                                        "Next Meeting",
                                        style: TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.bold,
                                          color: infoColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: spXs),
                                  Text(
                                    _formatMeetingTime(group["nextMeeting"]),
                                    style: TextStyle(
                                      fontSize: 13,
                                      color: infoColor,
                                    ),
                                  ),
                                  if (group["location"] != "Online")
                                    Text(
                                      "${group["location"]}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: infoColor,
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          
                          SizedBox(height: spMd),
                          
                          // Tags
                          Wrap(
                            spacing: spXs,
                            children: (group["tags"] as List).map<Widget>((tag) {
                              return Container(
                                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                                decoration: BoxDecoration(
                                  color: _getCategoryColor(group["category"]).withAlpha(25),
                                  borderRadius: BorderRadius.circular(radiusSm),
                                ),
                                child: Text(
                                  "#$tag",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: _getCategoryColor(group["category"]),
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                          
                          SizedBox(height: spMd),
                          
                          // Action Buttons
                          Row(
                            children: [
                              Expanded(
                                child: QButton(
                                  label: "View Details",
                                  size: bs.sm,
                                  onPressed: () {
                                    _showGroupDetails(group);
                                  },
                                ),
                              ),
                              SizedBox(width: spMd),
                              if (!group["isJoined"])
                                Expanded(
                                  child: QButton(
                                    label: group["isPrivate"] ? "Request to Join" : "Join Group",
                                    color: successColor,
                                    size: bs.sm,
                                    onPressed: () {
                                      _joinGroup(group);
                                    },
                                  ),
                                ),
                              if (group["isJoined"])
                                Expanded(
                                  child: QButton(
                                    label: "Leave Group",
                                    color: dangerColor,
                                    size: bs.sm,
                                    onPressed: () {
                                      _leaveGroup(group);
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
              );
            }),
            
            if (filteredGroups.isEmpty)
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(spXl),
                child: Column(
                  children: [
                    Icon(
                      Icons.groups_outlined,
                      size: 64,
                      color: disabledColor,
                    ),
                    SizedBox(height: spMd),
                    Text(
                      "No Support Groups Found",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "Try adjusting your search or filter criteria",
                      textAlign: TextAlign.center,
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
    );
  }

  Widget _buildQuickStat(String label, String value, IconData icon) {
    return Column(
      children: [
        Icon(
          icon,
          size: 20,
          color: Colors.white,
        ),
        SizedBox(height: spXs),
        Text(
          value,
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 11,
            color: Colors.white.withAlpha(200),
          ),
        ),
      ],
    );
  }

  Widget _buildGroupStat(IconData icon, String value, String label) {
    return Column(
      children: [
        Icon(
          icon,
          size: 16,
          color: disabledBoldColor,
        ),
        SizedBox(height: spXs),
        Text(
          value,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 11,
            color: disabledBoldColor,
          ),
        ),
      ],
    );
  }

  Color _getCategoryColor(String category) {
    switch (category) {
      case "mental_health":
        return warningColor;
      case "chronic":
        return dangerColor;
      case "addiction":
        return secondaryColor;
      case "cancer":
        return primaryColor;
      case "caregivers":
        return successColor;
      case "grief":
        return infoColor;
      case "youth":
        return primaryColor;
      default:
        return disabledBoldColor;
    }
  }

  String _formatMeetingTime(String dateString) {
    final date = DateTime.parse(dateString);
    final now = DateTime.now();
    final difference = date.difference(now);
    
    if (difference.inDays == 0) {
      return "Today at ${date.hour}:${date.minute.toString().padLeft(2, '0')}";
    } else if (difference.inDays == 1) {
      return "Tomorrow at ${date.hour}:${date.minute.toString().padLeft(2, '0')}";
    } else {
      return "${date.day}/${date.month} at ${date.hour}:${date.minute.toString().padLeft(2, '0')}";
    }
  }

  void _showGroupDetails(Map<String, dynamic> group) {
    // Show detailed group information
  }

  void _joinGroup(Map<String, dynamic> group) {
    if (group["isPrivate"]) {
      ss("Join request sent! You'll be notified when approved.");
    } else {
      group["isJoined"] = true;
      group["memberCount"] = (group["memberCount"] as int) + 1;
      setState(() {});
      ss("Successfully joined ${group["name"]}!");
    }
  }

  void _leaveGroup(Map<String, dynamic> group) async {
    bool isConfirmed = await confirm("Are you sure you want to leave this support group?");
    if (isConfirmed) {
      group["isJoined"] = false;
      group["memberCount"] = (group["memberCount"] as int) - 1;
      setState(() {});
      ss("Left ${group["name"]} successfully.");
    }
  }
}
