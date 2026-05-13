import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class SmaEventAttendeesView extends StatefulWidget {
  const SmaEventAttendeesView({super.key});

  @override
  State<SmaEventAttendeesView> createState() => _SmaEventAttendeesViewState();
}

class _SmaEventAttendeesViewState extends State<SmaEventAttendeesView> {
  String searchQuery = "";
  String selectedFilter = "All";
  List<String> filterOptions = ["All", "Going", "Interested", "Maybe", "Organizers"];
  
  Map<String, dynamic> eventInfo = {
    "title": "Tech Innovation Summit 2024",
    "date": "2024-06-20",
    "location": "San Francisco Convention Center",
    "totalAttendees": 1250,
    "totalInterested": 3400
  };
  
  List<Map<String, dynamic>> attendees = [
    {
      "id": 1,
      "name": "Sarah Johnson",
      "username": "sarah_j",
      "image": "https://picsum.photos/60/60?random=1&keyword=woman",
      "status": "Going",
      "role": "Organizer",
      "title": "AI Research Director",
      "company": "TechCorp",
      "isFollowing": true,
      "isVerified": true,
      "mutualFriends": 15,
      "registeredDate": "2024-06-01",
      "isOnline": true,
      "bio": "Leading AI researcher passionate about machine learning innovation"
    },
    {
      "id": 2,
      "name": "Mike Chen",
      "username": "mikechen_dev",
      "image": "https://picsum.photos/60/60?random=2&keyword=man",
      "status": "Going",
      "role": "Speaker",
      "title": "Cloud Solutions Architect",
      "company": "CloudTech Inc",
      "isFollowing": false,
      "isVerified": true,
      "mutualFriends": 8,
      "registeredDate": "2024-06-02",
      "isOnline": false,
      "bio": "Expert in cloud infrastructure and scalable system design"
    },
    {
      "id": 3,
      "name": "Emma Davis",
      "username": "emma_designer",
      "image": "https://picsum.photos/60/60?random=3&keyword=girl",
      "status": "Going",
      "role": "Attendee",
      "title": "UX Designer",
      "company": "Design Studio",
      "isFollowing": true,
      "isVerified": false,
      "mutualFriends": 23,
      "registeredDate": "2024-06-03",
      "isOnline": true,
      "bio": "Passionate about creating intuitive user experiences"
    },
    {
      "id": 4,
      "name": "David Wilson",
      "username": "david_w",
      "image": "https://picsum.photos/60/60?random=4&keyword=person",
      "status": "Interested",
      "role": "Attendee",
      "title": "Data Scientist",
      "company": "Analytics Pro",
      "isFollowing": false,
      "isVerified": false,
      "mutualFriends": 3,
      "registeredDate": "2024-06-04",
      "isOnline": false,
      "bio": "Data enthusiast focused on predictive analytics and ML"
    },
    {
      "id": 5,
      "name": "Lisa Park",
      "username": "lisa_park_photo",
      "image": "https://picsum.photos/60/60?random=5&keyword=woman",
      "status": "Going",
      "role": "Attendee",
      "title": "Product Manager",
      "company": "StartupCorp",
      "isFollowing": true,
      "isVerified": true,
      "mutualFriends": 12,
      "registeredDate": "2024-06-05",
      "isOnline": false,
      "bio": "Building innovative products that solve real-world problems"
    },
    {
      "id": 6,
      "name": "Alex Rodriguez",
      "username": "alex_dev",
      "image": "https://picsum.photos/60/60?random=6&keyword=developer",
      "status": "Maybe",
      "role": "Attendee",
      "title": "Full Stack Developer",
      "company": "WebTech Solutions",
      "isFollowing": false,
      "isVerified": false,
      "mutualFriends": 7,
      "registeredDate": "2024-06-06",
      "isOnline": true,
      "bio": "Full-stack developer specializing in modern web technologies"
    },
    {
      "id": 7,
      "name": "Rachel Green",
      "username": "rachel_marketing",
      "image": "https://picsum.photos/60/60?random=7&keyword=professional",
      "status": "Going",
      "role": "Attendee",
      "title": "Marketing Director",
      "company": "Growth Agency",
      "isFollowing": true,
      "isVerified": false,
      "mutualFriends": 19,
      "registeredDate": "2024-06-07",
      "isOnline": false,
      "bio": "Growth marketing expert focused on tech startups and SaaS"
    },
    {
      "id": 8,
      "name": "Tom Anderson",
      "username": "tom_security",
      "image": "https://picsum.photos/60/60?random=8&keyword=security",
      "status": "Interested",
      "role": "Attendee",
      "title": "Security Engineer",
      "company": "CyberSafe Inc",
      "isFollowing": false,
      "isVerified": true,
      "mutualFriends": 31,
      "registeredDate": "2024-06-08",
      "isOnline": false,
      "bio": "Cybersecurity specialist focused on enterprise security solutions"
    }
  ];

  List<Map<String, dynamic>> get filteredAttendees {
    var filtered = attendees.where((attendee) {
      final matchesSearch = (attendee["name"] as String)
          .toLowerCase()
          .contains(searchQuery.toLowerCase()) ||
          (attendee["username"] as String)
              .toLowerCase()
              .contains(searchQuery.toLowerCase()) ||
          (attendee["company"] as String)
              .toLowerCase()
              .contains(searchQuery.toLowerCase());
      
      bool matchesFilter = true;
      switch (selectedFilter) {
        case "Going":
          matchesFilter = attendee["status"] == "Going";
          break;
        case "Interested":
          matchesFilter = attendee["status"] == "Interested";
          break;
        case "Maybe":
          matchesFilter = attendee["status"] == "Maybe";
          break;
        case "Organizers":
          matchesFilter = attendee["role"] == "Organizer" || attendee["role"] == "Speaker";
          break;
      }
      
      return matchesSearch && matchesFilter;
    }).toList();
    
    return filtered;
  }

  Color getStatusColor(String status) {
    switch (status) {
      case "Going":
        return successColor;
      case "Interested":
        return warningColor;
      case "Maybe":
        return infoColor;
      default:
        return disabledBoldColor;
    }
  }

  Color getRoleColor(String role) {
    switch (role) {
      case "Organizer":
        return primaryColor;
      case "Speaker":
        return infoColor;
      default:
        return disabledBoldColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Event Attendees"),
        actions: [
          IconButton(
            onPressed: () {
              si("Exported attendees list");
            },
            icon: Icon(Icons.download),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            // Event Info Header
            Card(
              child: Container(
                padding: EdgeInsets.all(spMd),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spSm,
                  children: [
                    Text(
                      "${eventInfo["title"]}",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.calendar_today,
                          size: 16,
                          color: disabledBoldColor,
                        ),
                        SizedBox(width: spXs),
                        Text(
                          "${DateTime.parse(eventInfo["date"] as String).dMMMy}",
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                          ),
                        ),
                        SizedBox(width: spMd),
                        Icon(
                          Icons.location_on,
                          size: 16,
                          color: disabledBoldColor,
                        ),
                        SizedBox(width: spXs),
                        Expanded(
                          child: Text(
                            "${eventInfo["location"]}",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            // Stats Summary
            Card(
              child: Container(
                padding: EdgeInsets.all(spMd),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          Text(
                            "${((eventInfo["totalAttendees"] as int) / 1000).toStringAsFixed(1)}K",
                            style: TextStyle(
                              fontSize: fsH5,
                              fontWeight: FontWeight.bold,
                              color: successColor,
                            ),
                          ),
                          Text(
                            "Going",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: 1,
                      height: 40,
                      color: disabledColor,
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          Text(
                            "${((eventInfo["totalInterested"] as int) / 1000).toStringAsFixed(1)}K",
                            style: TextStyle(
                              fontSize: fsH5,
                              fontWeight: FontWeight.bold,
                              color: warningColor,
                            ),
                          ),
                          Text(
                            "Interested",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: 1,
                      height: 40,
                      color: disabledColor,
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          Text(
                            "${attendees.where((a) => a["isOnline"] as bool).length}",
                            style: TextStyle(
                              fontSize: fsH5,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          Text(
                            "Online Now",
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
              ),
            ),

            // Search and Filter Section
            Card(
              child: Container(
                padding: EdgeInsets.all(spSm),
                child: Column(
                  spacing: spSm,
                  children: [
                    QTextField(
                      label: "Search Attendees",
                      value: searchQuery,
                      hint: "Search by name, username, or company...",
                      onChanged: (value) {
                        searchQuery = value;
                        setState(() {});
                      },
                    ),
                    QDropdownField(
                      label: "Filter by Status",
                      value: selectedFilter,
                      items: filterOptions.map((filter) => {
                        "label": filter,
                        "value": filter,
                      }).toList(),
                      onChanged: (value, label) {
                        selectedFilter = value;
                        setState(() {});
                      },
                    ),
                  ],
                ),
              ),
            ),

            // Results Count
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: spXs),
              child: Text(
                "${filteredAttendees.length} attendees found",
                style: TextStyle(
                  fontSize: 14,
                  color: disabledBoldColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),

            // Attendees List
            ...filteredAttendees.map((attendee) {
              return Card(
                child: Container(
                  padding: EdgeInsets.all(spSm),
                  child: Column(
                    spacing: spSm,
                    children: [
                      Row(
                        children: [
                          // Profile Image with Online Status
                          Stack(
                            children: [
                              Container(
                                width: 60,
                                height: 60,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(radiusSm),
                                  image: DecorationImage(
                                    image: NetworkImage("${attendee["image"]}"),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              if (attendee["isOnline"] as bool) ...[
                                Positioned(
                                  bottom: 2,
                                  right: 2,
                                  child: Container(
                                    width: 14,
                                    height: 14,
                                    decoration: BoxDecoration(
                                      color: successColor,
                                      shape: BoxShape.circle,
                                      border: Border.all(color: Colors.white, width: 2),
                                    ),
                                  ),
                                ),
                              ],
                            ],
                          ),
                          SizedBox(width: spSm),
                          
                          // User Info
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      "${attendee["name"]}",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    if (attendee["isVerified"] as bool) ...[
                                      SizedBox(width: spXs),
                                      Icon(
                                        Icons.verified,
                                        color: primaryColor,
                                        size: 16,
                                      ),
                                    ],
                                    Spacer(),
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: spSm,
                                        vertical: spXs,
                                      ),
                                      decoration: BoxDecoration(
                                        color: getStatusColor(attendee["status"] as String).withAlpha(25),
                                        borderRadius: BorderRadius.circular(radiusXs),
                                      ),
                                      child: Text(
                                        "${attendee["status"]}",
                                        style: TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.w600,
                                          color: getStatusColor(attendee["status"] as String),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: spXs),
                                Text(
                                  "@${attendee["username"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                SizedBox(height: spXs),
                                Row(
                                  children: [
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: spSm,
                                        vertical: spXs,
                                      ),
                                      decoration: BoxDecoration(
                                        color: getRoleColor(attendee["role"] as String).withAlpha(25),
                                        borderRadius: BorderRadius.circular(radiusXs),
                                      ),
                                      child: Text(
                                        "${attendee["role"]}",
                                        style: TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.w600,
                                          color: getRoleColor(attendee["role"] as String),
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: spSm),
                                    Expanded(
                                      child: Text(
                                        "${attendee["title"]} at ${attendee["company"]}",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),

                      // Bio
                      if ((attendee["bio"] as String).isNotEmpty) ...[
                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: primaryColor.withAlpha(25),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Text(
                            "${attendee["bio"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        ),
                      ],

                      // Additional Info
                      Row(
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.group,
                                size: 12,
                                color: disabledBoldColor,
                              ),
                              SizedBox(width: spXs),
                              Text(
                                "${attendee["mutualFriends"]} mutual friends",
                                style: TextStyle(
                                  fontSize: 10,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(width: spMd),
                          Row(
                            children: [
                              Icon(
                                Icons.calendar_today,
                                size: 12,
                                color: disabledBoldColor,
                              ),
                              SizedBox(width: spXs),
                              Text(
                                "Joined ${DateTime.parse(attendee["registeredDate"] as String).dMMMy}",
                                style: TextStyle(
                                  fontSize: 10,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                          Spacer(),
                          
                          // Action Buttons
                          Row(
                            spacing: spXs,
                            children: [
                              QButton(
                                icon: Icons.message,
                                size: bs.sm,
                                onPressed: () {
                                  //navigateTo(SmaChatView(userId: attendee["id"]))
                                },
                              ),
                              QButton(
                                label: (attendee["isFollowing"] as bool) ? "Following" : "Follow",
                                size: bs.sm,
                                onPressed: () {
                                  attendee["isFollowing"] = !(attendee["isFollowing"] as bool);
                                  if (attendee["isFollowing"] as bool) {
                                    ss("Following ${attendee["name"]}");
                                  } else {
                                    si("Unfollowed ${attendee["name"]}");
                                  }
                                  setState(() {});
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),

            // Load More Button
            if (filteredAttendees.length >= 8) ...[
              Container(
                width: double.infinity,
                child: QButton(
                  label: "Load More Attendees",
                  size: bs.md,
                  onPressed: () {
                    si("Loading more attendees...");
                  },
                ),
              ),
            ],

            // Empty State
            if (filteredAttendees.isEmpty) ...[
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(spXl),
                child: Column(
                  children: [
                    Icon(
                      Icons.people_outline,
                      size: 64,
                      color: disabledColor,
                    ),
                    SizedBox(height: spMd),
                    Text(
                      "No attendees found",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "Try adjusting your search or filter criteria",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
