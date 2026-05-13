import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class EcmVipManagementView extends StatefulWidget {
  const EcmVipManagementView({super.key});

  @override
  State<EcmVipManagementView> createState() => _EcmVipManagementViewState();
}

class _EcmVipManagementViewState extends State<EcmVipManagementView> {
  String selectedFilter = "all";
  String searchQuery = "";

  List<Map<String, dynamic>> vipGuests = [
    {
      "id": 1,
      "name": "James Wilson",
      "title": "CEO",
      "company": "Global Corp",
      "tier": "Platinum",
      "avatar": "https://picsum.photos/80/80?random=1&face",
      "email": "james.wilson@globalcorp.com",
      "phone": "+1 555-0140",
      "checked_in": true,
      "check_in_time": "08:15 AM",
      "assistant": "Emily Johnson",
      "assistant_phone": "+1 555-0141",
      "special_requirements": [
        "Private meeting room access",
        "Dedicated assistant",
        "VIP parking spot",
        "Priority dining reservations"
      ],
      "itinerary": [
        {"time": "09:00 AM", "activity": "Welcome Reception", "location": "VIP Lounge"},
        {"time": "10:00 AM", "activity": "Keynote Speech", "location": "Main Auditorium"},
        {"time": "11:30 AM", "activity": "Executive Panel", "location": "Executive Suite"},
        {"time": "01:00 PM", "activity": "VIP Lunch", "location": "Sky Restaurant"},
      ],
      "preferences": {
        "dietary": "No dairy products",
        "seating": "Front row center",
        "transport": "Private car service",
        "accommodation": "Presidential Suite"
      },
      "meetings": [
        {"time": "02:30 PM", "with": "Sarah Chen", "topic": "Partnership Discussion"},
        {"time": "04:00 PM", "with": "Michael Rodriguez", "topic": "Investment Opportunity"},
      ],
    },
    {
      "id": 2,
      "name": "Dr. Amanda Foster",
      "title": "Chief Technology Officer",
      "company": "Innovation Labs",
      "tier": "Gold",
      "avatar": "https://picsum.photos/80/80?random=2&face",
      "email": "amanda.foster@innovlabs.com",
      "phone": "+1 555-0142",
      "checked_in": true,
      "check_in_time": "08:45 AM",
      "assistant": null,
      "assistant_phone": null,
      "special_requirements": [
        "Technical equipment for presentation",
        "High-speed internet access",
        "Quiet space for calls"
      ],
      "itinerary": [
        {"time": "09:30 AM", "activity": "Tech Demo Setup", "location": "Demo Room"},
        {"time": "11:00 AM", "activity": "Technology Showcase", "location": "Exhibition Hall"},
        {"time": "02:00 PM", "activity": "Innovation Workshop", "location": "Workshop Room"},
      ],
      "preferences": {
        "dietary": "Vegetarian",
        "seating": "Near presentation screen",
        "transport": "Taxi service",
        "accommodation": "Business Suite"
      },
      "meetings": [
        {"time": "03:30 PM", "with": "Tech Team", "topic": "Product Demo Review"},
      ],
    },
    {
      "id": 3,
      "name": "Robert Martinez",
      "title": "Managing Director",
      "company": "Investment Partners",
      "tier": "Platinum",
      "avatar": "https://picsum.photos/80/80?random=3&face",
      "email": "robert.martinez@investpart.com",
      "phone": "+1 555-0143",
      "checked_in": false,
      "check_in_time": null,
      "assistant": "David Kim",
      "assistant_phone": "+1 555-0144",
      "special_requirements": [
        "Private security escort",
        "Secure meeting room",
        "Direct access to VIP entrance",
        "Media interview setup"
      ],
      "itinerary": [
        {"time": "10:30 AM", "activity": "Arrival & Check-in", "location": "VIP Entrance"},
        {"time": "11:00 AM", "activity": "Media Interview", "location": "Press Room"},
        {"time": "12:00 PM", "activity": "Investor Panel", "location": "Executive Suite"},
        {"time": "03:00 PM", "activity": "Private Meetings", "location": "Board Room"},
      ],
      "preferences": {
        "dietary": "Gluten-free",
        "seating": "Executive section",
        "transport": "Helicopter transfer",
        "accommodation": "Penthouse Suite"
      },
      "meetings": [
        {"time": "01:30 PM", "with": "Startup Founders", "topic": "Funding Opportunities"},
        {"time": "04:30 PM", "with": "Board Members", "topic": "Strategic Planning"},
      ],
    },
  ];

  List<Map<String, dynamic>> filterOptions = [
    {"label": "All VIPs", "value": "all"},
    {"label": "Platinum Tier", "value": "platinum"},
    {"label": "Gold Tier", "value": "gold"},
    {"label": "Checked In", "value": "checked_in"},
    {"label": "Pending", "value": "pending"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("VIP Management"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              si("Add VIP feature not implemented");
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
            _buildVIPStatistics(),
            _buildSearchAndFilters(),
            _buildVIPList(),
          ],
        ),
      ),
    );
  }

  Widget _buildVIPStatistics() {
    int totalVIPs = vipGuests.length;
    int checkedInVIPs = vipGuests.where((v) => v["checked_in"] == true).length;
    int platinumVIPs = vipGuests.where((v) => v["tier"] == "Platinum").length;
    int goldVIPs = vipGuests.where((v) => v["tier"] == "Gold").length;

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
                  Icons.star,
                  size: 28,
                  color: warningColor,
                ),
                SizedBox(height: spXs),
                Text(
                  "$totalVIPs",
                  style: TextStyle(
                    fontSize: fsH4,
                    fontWeight: FontWeight.bold,
                    color: warningColor,
                  ),
                ),
                Text(
                  "Total VIPs",
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
                  "$checkedInVIPs",
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
                  Icons.workspace_premium,
                  size: 28,
                  color: Colors.purple,
                ),
                SizedBox(height: spXs),
                Text(
                  "$platinumVIPs",
                  style: TextStyle(
                    fontSize: fsH4,
                    fontWeight: FontWeight.bold,
                    color: Colors.purple,
                  ),
                ),
                Text(
                  "Platinum",
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
                  Icons.military_tech,
                  size: 28,
                  color: Colors.amber,
                ),
                SizedBox(height: spXs),
                Text(
                  "$goldVIPs",
                  style: TextStyle(
                    fontSize: fsH4,
                    fontWeight: FontWeight.bold,
                    color: Colors.amber,
                  ),
                ),
                Text(
                  "Gold",
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
                  label: "Search VIPs...",
                  value: searchQuery,
                  hint: "Name, company, or tier",
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
          QDropdownField(
            label: "Filter by",
            items: filterOptions,
            value: selectedFilter,
            onChanged: (value, label) {
              selectedFilter = value;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  Widget _buildVIPList() {
    List<Map<String, dynamic>> filteredVIPs = vipGuests.where((vip) {
      bool filterMatch = selectedFilter == "all" ||
                        (selectedFilter == "platinum" && vip["tier"] == "Platinum") ||
                        (selectedFilter == "gold" && vip["tier"] == "Gold") ||
                        (selectedFilter == "checked_in" && vip["checked_in"] == true) ||
                        (selectedFilter == "pending" && vip["checked_in"] == false);
      
      bool searchMatch = searchQuery.isEmpty ||
                        vip["name"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
                        vip["company"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
                        vip["tier"].toString().toLowerCase().contains(searchQuery.toLowerCase());
      
      return filterMatch && searchMatch;
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
                "VIP Guests",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Spacer(),
              Text(
                "${filteredVIPs.length} VIPs",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
          if (filteredVIPs.isEmpty) ...[
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
                    "No VIP guests found",
                    style: TextStyle(
                      fontSize: 14,
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ),
            ),
          ] else ...[
            ...filteredVIPs.map((vip) => _buildVIPCard(vip)),
          ],
        ],
      ),
    );
  }

  Widget _buildVIPCard(Map<String, dynamic> vip) {
    bool isCheckedIn = vip["checked_in"] as bool;
    String tier = vip["tier"];
    Color tierColor = tier == "Platinum" ? Colors.purple : Colors.amber;
    
    List<Map<String, dynamic>> itinerary = (vip["itinerary"] as List).cast<Map<String, dynamic>>();
    List<Map<String, dynamic>> meetings = (vip["meetings"] as List).cast<Map<String, dynamic>>();
    List<String> requirements = (vip["special_requirements"] as List).cast<String>();

    return Container(
      padding: EdgeInsets.all(spSm),
      margin: EdgeInsets.only(bottom: spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusSm),
        boxShadow: [shadowMd],
        border: Border(
          left: BorderSide(
            width: 5,
            color: tierColor,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Row(
            children: [
              Stack(
                children: [
                  CircleAvatar(
                    radius: 35,
                    backgroundImage: NetworkImage("${vip["avatar"]}"),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      padding: EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: tierColor,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 2),
                      ),
                      child: Icon(
                        tier == "Platinum" ? Icons.workspace_premium : Icons.military_tech,
                        size: 16,
                        color: Colors.white,
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
                        Expanded(
                          child: Text(
                            "${vip["name"]}",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                          decoration: BoxDecoration(
                            color: tierColor,
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Text(
                            "$tier VIP",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Text(
                      "${vip["title"]}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "${vip["company"]}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
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
                            "at ${vip["check_in_time"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          
          // Contact Information
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
                Text(
                  "Contact Information",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Row(
                  children: [
                    Icon(Icons.email, size: 14, color: disabledBoldColor),
                    SizedBox(width: spXs),
                    Text("${vip["email"]}", style: TextStyle(fontSize: 12, color: disabledBoldColor)),
                  ],
                ),
                Row(
                  children: [
                    Icon(Icons.phone, size: 14, color: disabledBoldColor),
                    SizedBox(width: spXs),
                    Text("${vip["phone"]}", style: TextStyle(fontSize: 12, color: disabledBoldColor)),
                  ],
                ),
                if (vip["assistant"] != null) ...[
                  Row(
                    children: [
                      Icon(Icons.support_agent, size: 14, color: infoColor),
                      SizedBox(width: spXs),
                      Text("Assistant: ${vip["assistant"]} - ${vip["assistant_phone"]}", 
                          style: TextStyle(fontSize: 12, color: infoColor, fontWeight: FontWeight.w600)),
                    ],
                  ),
                ],
              ],
            ),
          ),

          // Special Requirements
          if (requirements.isNotEmpty) ...[
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: warningColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusXs),
                border: Border.all(color: warningColor.withAlpha(50)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spXs,
                children: [
                  Row(
                    children: [
                      Icon(Icons.priority_high, size: 16, color: warningColor),
                      SizedBox(width: spXs),
                      Text(
                        "Special Requirements",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: warningColor,
                        ),
                      ),
                    ],
                  ),
                  ...requirements.map((req) => Row(
                    children: [
                      Icon(Icons.check, size: 12, color: warningColor),
                      SizedBox(width: spXs),
                      Expanded(
                        child: Text(
                          req,
                          style: TextStyle(fontSize: 12, color: warningColor),
                        ),
                      ),
                    ],
                  )),
                ],
              ),
            ),
          ],

          // Today's Itinerary
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: infoColor.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusXs),
              border: Border.all(color: infoColor.withAlpha(50)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spXs,
              children: [
                Row(
                  children: [
                    Icon(Icons.schedule, size: 16, color: infoColor),
                    SizedBox(width: spXs),
                    Text(
                      "Today's Itinerary",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: infoColor,
                      ),
                    ),
                  ],
                ),
                ...itinerary.take(3).map((item) => Row(
                  children: [
                    Text(
                      "${item["time"]}",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: infoColor,
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: Text(
                        "${item["activity"]} - ${item["location"]}",
                        style: TextStyle(fontSize: 12, color: infoColor),
                      ),
                    ),
                  ],
                )),
                if (itinerary.length > 3) ...[
                  Text(
                    "... and ${itinerary.length - 3} more activities",
                    style: TextStyle(
                      fontSize: 12,
                      color: infoColor,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
              ],
            ),
          ),

          // Scheduled Meetings
          if (meetings.isNotEmpty) ...[
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: successColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusXs),
                border: Border.all(color: successColor.withAlpha(50)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spXs,
                children: [
                  Row(
                    children: [
                      Icon(Icons.meeting_room, size: 16, color: successColor),
                      SizedBox(width: spXs),
                      Text(
                        "Scheduled Meetings",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: successColor,
                        ),
                      ),
                    ],
                  ),
                  ...meetings.map((meeting) => Row(
                    children: [
                      Text(
                        "${meeting["time"]}",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: successColor,
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Text(
                          "${meeting["with"]} - ${meeting["topic"]}",
                          style: TextStyle(fontSize: 12, color: successColor),
                        ),
                      ),
                    ],
                  )),
                ],
              ),
            ),
          ],

          // Action Buttons
          Row(
            children: [
              Expanded(
                child: QButton(
                  label: isCheckedIn ? "View Profile" : "Check In",
                  size: bs.sm,
                  onPressed: () {
                    if (!isCheckedIn) {
                      vip["checked_in"] = true;
                      vip["check_in_time"] = DateTime.now().toString().substring(11, 16);
                      setState(() {});
                      ss("${vip["name"]} checked in successfully");
                    } else {
                      si("Profile view not implemented");
                    }
                  },
                ),
              ),
              SizedBox(width: spSm),
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
                icon: Icons.call,
                size: bs.sm,
                onPressed: () {
                  ss("Calling ${vip["name"]}...");
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
