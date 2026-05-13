import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class EcmGuestListView extends StatefulWidget {
  const EcmGuestListView({super.key});

  @override
  State<EcmGuestListView> createState() => _EcmGuestListViewState();
}

class _EcmGuestListViewState extends State<EcmGuestListView> {
  String searchQuery = "";
  String selectedCategory = "all";
  bool showCheckInOnly = false;

  List<Map<String, dynamic>> guests = [
    {
      "id": 1,
      "name": "Dr. Amanda Foster",
      "title": "Keynote Speaker",
      "company": "Tech University",
      "category": "speaker",
      "bio": "Leading AI researcher with 15+ years of experience in machine learning",
      "avatar": "https://picsum.photos/80/80?random=1&face",
      "email": "amanda.foster@techuni.edu",
      "phone": "+1 555-0130",
      "checked_in": true,
      "check_in_time": "08:30 AM",
      "session_time": "09:00 - 10:00 AM",
      "session_topic": "Future of Artificial Intelligence",
      "special_requirements": "Wireless microphone, presentation remote",
      "room": "Main Auditorium",
    },
    {
      "id": 2,
      "name": "Robert Chen",
      "title": "Panel Moderator",
      "company": "Innovation Labs",
      "category": "moderator",
      "bio": "Experienced tech journalist and event moderator",
      "avatar": "https://picsum.photos/80/80?random=2&face",
      "email": "robert.chen@innovlabs.com",
      "phone": "+1 555-0131",
      "checked_in": false,
      "check_in_time": null,
      "session_time": "10:30 - 11:30 AM",
      "session_topic": "Startup Ecosystem Panel Discussion",
      "special_requirements": "Handheld microphone, water bottle",
      "room": "Conference Room B",
    },
    {
      "id": 3,
      "name": "Sarah Martinez",
      "title": "Workshop Facilitator",
      "company": "Design Studio",
      "category": "facilitator",
      "bio": "UX Design expert with focus on accessible design principles",
      "avatar": "https://picsum.photos/80/80?random=3&face",
      "email": "sarah.martinez@designstudio.com",
      "phone": "+1 555-0132",
      "checked_in": true,
      "check_in_time": "08:45 AM",
      "session_time": "02:00 - 04:00 PM",
      "session_topic": "Inclusive Design Workshop",
      "special_requirements": "Flipchart, markers, sticky notes",
      "room": "Workshop Room A",
    },
    {
      "id": 4,
      "name": "James Wilson",
      "title": "Special Guest",
      "company": "Global Corp",
      "category": "vip",
      "bio": "CEO of Global Corp, technology innovation leader",
      "avatar": "https://picsum.photos/80/80?random=4&face",
      "email": "james.wilson@globalcorp.com",
      "phone": "+1 555-0133",
      "checked_in": false,
      "check_in_time": null,
      "session_time": "11:45 AM - 12:15 PM",
      "session_topic": "Opening Remarks",
      "special_requirements": "VIP lounge access, dedicated assistant",
      "room": "Main Auditorium",
    },
    {
      "id": 5,
      "name": "Maria Rodriguez",
      "title": "Networking Host",
      "company": "EventPro",
      "category": "host",
      "bio": "Professional event host specializing in tech networking events",
      "avatar": "https://picsum.photos/80/80?random=5&face",
      "email": "maria.rodriguez@eventpro.com",
      "phone": "+1 555-0134",
      "checked_in": true,
      "check_in_time": "08:00 AM",
      "session_time": "05:00 - 07:00 PM",
      "session_topic": "Networking Reception",
      "special_requirements": "Cordless microphone, name tag templates",
      "room": "Exhibition Hall",
    },
  ];

  List<Map<String, dynamic>> categoryOptions = [
    {"label": "All Categories", "value": "all"},
    {"label": "Speakers", "value": "speaker"},
    {"label": "Moderators", "value": "moderator"},
    {"label": "Facilitators", "value": "facilitator"},
    {"label": "VIP Guests", "value": "vip"},
    {"label": "Hosts", "value": "host"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Guest List"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              si("Add guest feature not implemented");
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: spMd,
          children: [
            _buildSearchAndFilters(),
            _buildGuestStatistics(),
            _buildGuestList(),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchAndFilters() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusSm),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Text(
            "Search & Filters",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Row(
            children: [
              Expanded(
                child: QTextField(
                  label: "Search guests...",
                  value: searchQuery,
                  hint: "Name, company, or session topic",
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
                      "label": "Show checked-in only",
                      "value": true,
                      "checked": showCheckInOnly,
                    }
                  ],
                  value: [
                    if (showCheckInOnly)
                      {
                        "label": "Show checked-in only",
                        "value": true,
                        "checked": true
                      }
                  ],
                  onChanged: (values, ids) {
                    showCheckInOnly = values.isNotEmpty;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildGuestStatistics() {
    int totalGuests = guests.length;
    int checkedInGuests = guests.where((g) => g["checked_in"] == true).length;
    int speakers = guests.where((g) => g["category"] == "speaker").length;
    int vipGuests = guests.where((g) => g["category"] == "vip").length;

    return Row(
      children: [
        Expanded(
          child: Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusSm),
              boxShadow: [shadowSm],
            ),
            child: Column(
              children: [
                Icon(
                  Icons.people,
                  size: 28,
                  color: primaryColor,
                ),
                SizedBox(height: spXs),
                Text(
                  "$totalGuests",
                  style: TextStyle(
                    fontSize: fsH4,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "Total Guests",
                  textAlign: TextAlign.center,
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
              borderRadius: BorderRadius.circular(radiusSm),
              boxShadow: [shadowSm],
            ),
            child: Column(
              children: [
                Icon(
                  Icons.check_circle,
                  size: 28,
                  color: successColor,
                ),
                SizedBox(height: spXs),
                Text(
                  "$checkedInGuests",
                  style: TextStyle(
                    fontSize: fsH4,
                    fontWeight: FontWeight.bold,
                    color: successColor,
                  ),
                ),
                Text(
                  "Checked In",
                  textAlign: TextAlign.center,
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
              borderRadius: BorderRadius.circular(radiusSm),
              boxShadow: [shadowSm],
            ),
            child: Column(
              children: [
                Icon(
                  Icons.mic,
                  size: 28,
                  color: infoColor,
                ),
                SizedBox(height: spXs),
                Text(
                  "$speakers",
                  style: TextStyle(
                    fontSize: fsH4,
                    fontWeight: FontWeight.bold,
                    color: infoColor,
                  ),
                ),
                Text(
                  "Speakers",
                  textAlign: TextAlign.center,
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
              borderRadius: BorderRadius.circular(radiusSm),
              boxShadow: [shadowSm],
            ),
            child: Column(
              children: [
                Icon(
                  Icons.star,
                  size: 28,
                  color: warningColor,
                ),
                SizedBox(height: spXs),
                Text(
                  "$vipGuests",
                  style: TextStyle(
                    fontSize: fsH4,
                    fontWeight: FontWeight.bold,
                    color: warningColor,
                  ),
                ),
                Text(
                  "VIP Guests",
                  textAlign: TextAlign.center,
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
    );
  }

  Widget _buildGuestList() {
    List<Map<String, dynamic>> filteredGuests = guests.where((guest) {
      bool categoryMatch = selectedCategory == "all" || guest["category"] == selectedCategory;
      bool checkInMatch = !showCheckInOnly || guest["checked_in"] == true;
      bool searchMatch = searchQuery.isEmpty || 
                        guest["name"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
                        guest["company"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
                        guest["session_topic"].toString().toLowerCase().contains(searchQuery.toLowerCase());
      
      return categoryMatch && checkInMatch && searchMatch;
    }).toList();

    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusSm),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Row(
            children: [
              Text(
                "Guest List",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Spacer(),
              Text(
                "${filteredGuests.length} guests",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
          if (filteredGuests.isEmpty) ...[
            Container(
              height: 100,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey[50],
                borderRadius: BorderRadius.circular(radiusXs),
                border: Border.all(color: disabledOutlineBorderColor),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.search_off,
                    size: 32,
                    color: disabledBoldColor,
                  ),
                  SizedBox(height: spXs),
                  Text(
                    "No guests found",
                    style: TextStyle(
                      fontSize: 14,
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ),
            ),
          ] else ...[
            ...filteredGuests.map((guest) => _buildGuestCard(guest)),
          ],
        ],
      ),
    );
  }

  Widget _buildGuestCard(Map<String, dynamic> guest) {
    bool isCheckedIn = guest["checked_in"] as bool;
    String category = guest["category"];
    
    Color categoryColor = category == "speaker" ? infoColor :
                         category == "vip" ? warningColor :
                         category == "moderator" ? successColor :
                         category == "facilitator" ? dangerColor :
                         primaryColor;

    return Container(
      padding: EdgeInsets.all(spSm),
      margin: EdgeInsets.only(bottom: spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusSm),
        boxShadow: [shadowSm],
        border: Border(
          left: BorderSide(
            width: 4,
            color: isCheckedIn ? successColor : warningColor,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 30,
                backgroundImage: NetworkImage("${guest["avatar"]}"),
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
                            "${guest["name"]}",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                          decoration: BoxDecoration(
                            color: categoryColor,
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            "${guest["title"]}",
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Text(
                      "${guest["company"]}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "${guest["bio"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.grey[50],
              borderRadius: BorderRadius.circular(radiusXs),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spXs,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.schedule,
                      size: 14,
                      color: primaryColor,
                    ),
                    SizedBox(width: spXs),
                    Expanded(
                      child: Text(
                        "${guest["session_time"]} - ${guest["session_topic"]}",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: primaryColor,
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Icon(
                      Icons.location_on,
                      size: 14,
                      color: infoColor,
                    ),
                    SizedBox(width: spXs),
                    Text(
                      "${guest["room"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: infoColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Icon(
                      Icons.email,
                      size: 14,
                      color: disabledBoldColor,
                    ),
                    SizedBox(width: spXs),
                    Text(
                      "${guest["email"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Icon(
                      Icons.phone,
                      size: 14,
                      color: disabledBoldColor,
                    ),
                    SizedBox(width: spXs),
                    Text(
                      "${guest["phone"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          if (guest["special_requirements"] != null) ...[
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: warningColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusXs),
                border: Border.all(color: warningColor.withAlpha(50)),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.warning,
                    size: 16,
                    color: warningColor,
                  ),
                  SizedBox(width: spXs),
                  Expanded(
                    child: Text(
                      "Special Requirements: ${guest["special_requirements"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: warningColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
          Row(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: isCheckedIn ? successColor : dangerColor,
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      isCheckedIn ? Icons.check_circle : Icons.access_time,
                      size: 14,
                      color: Colors.white,
                    ),
                    SizedBox(width: spXs),
                    Text(
                      isCheckedIn ? "Checked In" : "Pending",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              if (isCheckedIn) ...[
                SizedBox(width: spSm),
                Text(
                  "at ${guest["check_in_time"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ],
              Spacer(),
              if (category == "vip") ...[
                Icon(
                  Icons.star,
                  size: 16,
                  color: warningColor,
                ),
                SizedBox(width: spXs),
                Text(
                  "VIP",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: warningColor,
                  ),
                ),
              ],
            ],
          ),
          Row(
            children: [
              Expanded(
                child: QButton(
                  label: "View Profile",
                  size: bs.sm,
                  onPressed: () {
                    si("Profile view not implemented");
                  },
                ),
              ),
              SizedBox(width: spSm),
              if (!isCheckedIn)
                Expanded(
                  child: QButton(
                    label: "Check In",
                    size: bs.sm,
                    onPressed: () {
                      guest["checked_in"] = true;
                      guest["check_in_time"] = DateTime.now().toString().substring(11, 16);
                      setState(() {});
                      ss("${guest["name"]} checked in successfully");
                    },
                  ),
                ),
              if (isCheckedIn)
                Expanded(
                  child: QButton(
                    label: "Send Message",
                    size: bs.sm,
                    onPressed: () {
                      si("Message feature not implemented");
                    },
                  ),
                ),
              SizedBox(width: spSm),
              QButton(
                icon: Icons.more_vert,
                size: bs.sm,
                onPressed: () {
                  si("More options not implemented");
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
