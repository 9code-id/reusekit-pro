import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlEvent2View extends StatefulWidget {
  @override
  State<GrlEvent2View> createState() => _GrlEvent2ViewState();
}

class _GrlEvent2ViewState extends State<GrlEvent2View> {
  Map<String, dynamic> event = {
    "id": 1,
    "title": "AI in Healthcare Summit 2024",
    "description": "Join leading experts to discuss the future of artificial intelligence in healthcare and medical research. This comprehensive summit brings together healthcare professionals, researchers, technologists, and innovators to explore cutting-edge AI applications in medical diagnosis, treatment optimization, and patient care.\n\nDiscover how machine learning algorithms are revolutionizing medical imaging, drug discovery, and personalized medicine. Learn about the latest breakthroughs in AI-powered diagnostic tools and explore real-world case studies from leading medical institutions.",
    "image": "https://picsum.photos/800/400?random=1&keyword=medical-conference",
    "date": "2024-12-25",
    "time": "09:00",
    "endTime": "17:00",
    "location": "San Francisco Convention Center",
    "address": "747 Howard St, San Francisco, CA 94103",
    "price": 299.0,
    "category": "Conference",
    "organizer": "MedTech Events",
    "organizerImage": "https://picsum.photos/100/100?random=org&keyword=medical",
    "attendees": 1247,
    "maxAttendees": 2000,
    "isOnline": false,
    "isFeatured": true,
    "tags": ["AI", "Healthcare", "Technology", "Research", "Innovation"],
    "agenda": [
      {
        "time": "09:00 - 09:30",
        "title": "Registration & Welcome Coffee",
        "speaker": null,
        "type": "break"
      },
      {
        "time": "09:30 - 10:30",
        "title": "Opening Keynote: The Future of AI in Medicine",
        "speaker": "Dr. Sarah Johnson",
        "type": "keynote"
      },
      {
        "time": "10:30 - 11:00",
        "title": "Coffee Break",
        "speaker": null,
        "type": "break"
      },
      {
        "time": "11:00 - 12:00",
        "title": "Panel: Machine Learning in Diagnostic Imaging",
        "speaker": "Prof. Michael Chen, Dr. Lisa Rodriguez",
        "type": "panel"
      },
      {
        "time": "12:00 - 13:00",
        "title": "Lunch Break",
        "speaker": null,
        "type": "break"
      },
      {
        "time": "13:00 - 14:00",
        "title": "Workshop: Implementing AI in Clinical Practice",
        "speaker": "Dr. Amanda Kim",
        "type": "workshop"
      },
      {
        "time": "14:00 - 15:00",
        "title": "Case Studies: Successful AI Implementations",
        "speaker": "Various Speakers",
        "type": "presentation"
      },
      {
        "time": "15:00 - 15:30",
        "title": "Afternoon Break",
        "speaker": null,
        "type": "break"
      },
      {
        "time": "15:30 - 16:30",
        "title": "Future Trends and Q&A Session",
        "speaker": "All Speakers",
        "type": "discussion"
      },
      {
        "time": "16:30 - 17:00",
        "title": "Closing Remarks & Networking",
        "speaker": null,
        "type": "networking"
      }
    ],
    "speakers": [
      {
        "name": "Dr. Sarah Johnson",
        "title": "AI Research Director at Stanford Medical",
        "bio": "Leading researcher in AI applications for healthcare with 15+ years of experience in machine learning and medical informatics.",
        "image": "https://picsum.photos/150/150?random=1&keyword=woman-doctor",
        "company": "Stanford Medical Center"
      },
      {
        "name": "Prof. Michael Chen",
        "title": "Healthcare Innovation Lead",
        "bio": "Professor of Medical Technology and pioneer in AI-driven diagnostic solutions for complex medical conditions.",
        "image": "https://picsum.photos/150/150?random=2&keyword=man-professor",
        "company": "MIT Medical School"
      },
      {
        "name": "Dr. Lisa Rodriguez",
        "title": "Medical AI Specialist",
        "bio": "Expert in machine learning applications for medical imaging and computer-aided diagnosis systems.",
        "image": "https://picsum.photos/150/150?random=3&keyword=woman-scientist",
        "company": "Johns Hopkins Hospital"
      },
      {
        "name": "Dr. Amanda Kim",
        "title": "Clinical AI Implementation Expert",
        "bio": "Specialist in translating AI research into practical clinical applications and workflow integration.",
        "image": "https://picsum.photos/150/150?random=4&keyword=woman-professional",
        "company": "Mayo Clinic"
      }
    ],
    "amenities": [
      "Welcome Kit & Materials",
      "All-Day Refreshments",
      "Networking Lunch",
      "Certificate of Attendance",
      "Access to Digital Resources",
      "Post-Event Recording Access"
    ],
    "requirements": [
      "Valid Photo ID Required",
      "Business Casual Dress Code",
      "Laptop Recommended for Workshops",
      "No Prerequisites Required"
    ]
  };

  bool isAttending = false;
  bool isBookmarked = false;
  int currentTab = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Hero Image with Event Info
            Stack(
              children: [
                Image.network(
                  "${event["image"]}",
                  height: 280,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
                Container(
                  height: 280,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        Colors.black.withAlpha(180),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  top: MediaQuery.of(context).padding.top + spSm,
                  left: spMd,
                  child: Container(
                    padding: EdgeInsets.all(spXs),
                    decoration: BoxDecoration(
                      color: Colors.black.withAlpha(100),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Icon(Icons.arrow_back, color: Colors.white, size: 24),
                  ),
                ),
                Positioned(
                  top: MediaQuery.of(context).padding.top + spSm,
                  right: spMd,
                  child: Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(spXs),
                        decoration: BoxDecoration(
                          color: Colors.black.withAlpha(100),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Icon(Icons.share, color: Colors.white, size: 20),
                      ),
                      SizedBox(width: spSm),
                      GestureDetector(
                        onTap: () {
                          isBookmarked = !isBookmarked;
                          setState(() {});
                        },
                        child: Container(
                          padding: EdgeInsets.all(spXs),
                          decoration: BoxDecoration(
                            color: Colors.black.withAlpha(100),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Icon(
                            isBookmarked ? Icons.bookmark : Icons.bookmark_border,
                            color: isBookmarked ? warningColor : Colors.white,
                            size: 20,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  bottom: spLg,
                  left: spMd,
                  right: spMd,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                        decoration: BoxDecoration(
                          color: primaryColor,
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Text(
                          "${event["category"]}",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      SizedBox(height: spSm),
                      Text(
                        "${event["title"]}",
                        style: TextStyle(
                          fontSize: fsH3,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: spSm),
                      Row(
                        children: [
                          Icon(Icons.calendar_today, color: Colors.white, size: 16),
                          SizedBox(width: spXs),
                          Text(
                            "${event["date"]} • ${event["time"]} - ${event["endTime"]}",
                            style: TextStyle(color: Colors.white, fontSize: 14),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),

            Padding(
              padding: EdgeInsets.all(spMd),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Event Quick Info
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.all(spMd),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(radiusLg),
                            boxShadow: [shadowSm],
                          ),
                          child: Column(
                            children: [
                              Icon(Icons.location_on, color: primaryColor, size: 24),
                              SizedBox(height: spXs),
                              Text(
                                "${event["location"]}",
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: primaryColor,
                                  fontSize: 12,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.all(spMd),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(radiusLg),
                            boxShadow: [shadowSm],
                          ),
                          child: Column(
                            children: [
                              Icon(Icons.people, color: successColor, size: 24),
                              SizedBox(height: spXs),
                              Text(
                                "${event["attendees"]}/${event["maxAttendees"]}",
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: successColor,
                                  fontSize: 12,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.all(spMd),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(radiusLg),
                            boxShadow: [shadowSm],
                          ),
                          child: Column(
                            children: [
                              Icon(Icons.attach_money, color: warningColor, size: 24),
                              SizedBox(height: spXs),
                              Text(
                                "\$${(event["price"] as double).toStringAsFixed(0)}",
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: warningColor,
                                  fontSize: 12,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: spLg),

                  // Organizer Info
                  Container(
                    padding: EdgeInsets.all(spMd),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusLg),
                      boxShadow: [shadowSm],
                    ),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 25,
                          backgroundImage: NetworkImage("${event["organizerImage"]}"),
                        ),
                        SizedBox(width: spMd),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Organized by",
                                style: TextStyle(
                                  color: disabledBoldColor,
                                  fontSize: 12,
                                ),
                              ),
                              Text(
                                "${event["organizer"]}",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                  fontSize: 16,
                                ),
                              ),
                              Text(
                                "Professional event organizer",
                                style: TextStyle(
                                  color: disabledBoldColor,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                        QButton(
                          label: "Follow",
                          size: bs.sm,
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: spLg),

                  // Tab Navigation
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusLg),
                      boxShadow: [shadowSm],
                    ),
                    child: Row(
                      children: [
                        _buildTabButton("About", 0),
                        _buildTabButton("Agenda", 1),
                        _buildTabButton("Speakers", 2),
                        _buildTabButton("Details", 3),
                      ],
                    ),
                  ),

                  SizedBox(height: spLg),

                  // Tab Content
                  if (currentTab == 0) _buildAboutTab(),
                  if (currentTab == 1) _buildAgendaTab(),
                  if (currentTab == 2) _buildSpeakersTab(),
                  if (currentTab == 3) _buildDetailsTab(),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(spMd),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [shadowLg],
        ),
        child: Row(
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Price",
                  style: TextStyle(
                    color: disabledBoldColor,
                    fontSize: 12,
                  ),
                ),
                Text(
                  "\$${(event["price"] as double).toStringAsFixed(0)}",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
              ],
            ),
            SizedBox(width: spLg),
            Expanded(
              child: QButton(
                label: isAttending ? "Cancel Registration" : "Register Now",
                size: bs.md,
                onPressed: () {
                  isAttending = !isAttending;
                  setState(() {});
                  if (isAttending) {
                    ss("Successfully registered for the event!");
                  } else {
                    si("Registration cancelled");
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTabButton(String title, int index) {
    bool isSelected = currentTab == index;
    return Expanded(
      child: GestureDetector(
        onTap: () {
          currentTab = index;
          setState(() {});
        },
        child: Container(
          padding: EdgeInsets.symmetric(vertical: spMd),
          decoration: BoxDecoration(
            color: isSelected ? primaryColor : Colors.transparent,
            borderRadius: BorderRadius.circular(radiusLg),
          ),
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: isSelected ? Colors.white : disabledBoldColor,
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
              fontSize: 12,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAboutTab() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "About this Event",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        SizedBox(height: spMd),
        Text(
          "${event["description"]}",
          style: TextStyle(
            fontSize: 16,
            height: 1.6,
            color: primaryColor,
          ),
        ),
        SizedBox(height: spLg),
        
        Text(
          "Event Tags",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        SizedBox(height: spMd),
        Wrap(
          spacing: spSm,
          runSpacing: spSm,
          children: (event["tags"] as List).map<Widget>((tag) {
            return Container(
              padding: EdgeInsets.symmetric(horizontal: spMd, vertical: spSm),
              decoration: BoxDecoration(
                color: primaryColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusLg),
              ),
              child: Text(
                "#$tag",
                style: TextStyle(
                  color: primaryColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildAgendaTab() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Event Schedule",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        SizedBox(height: spMd),
        Column(
          children: (event["agenda"] as List).map<Widget>((item) {
            return Container(
              margin: EdgeInsets.only(bottom: spMd),
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                    decoration: BoxDecoration(
                      color: _getAgendaTypeColor(item["type"]).withAlpha(40),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Text(
                      "${item["time"]}",
                      style: TextStyle(
                        color: _getAgendaTypeColor(item["type"]),
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  SizedBox(width: spMd),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${item["title"]}",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        if (item["speaker"] != null) ...[
                          SizedBox(height: spXs),
                          Text(
                            "Speaker: ${item["speaker"]}",
                            style: TextStyle(
                              color: disabledBoldColor,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                  Icon(
                    _getAgendaTypeIcon(item["type"]),
                    color: _getAgendaTypeColor(item["type"]),
                    size: 20,
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildSpeakersTab() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Featured Speakers",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        SizedBox(height: spMd),
        Column(
          children: (event["speakers"] as List).map<Widget>((speaker) {
            return Container(
              margin: EdgeInsets.only(bottom: spMd),
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundImage: NetworkImage("${speaker["image"]}"),
                  ),
                  SizedBox(width: spMd),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${speaker["name"]}",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "${speaker["title"]}",
                          style: TextStyle(
                            color: disabledBoldColor,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          "${speaker["company"]}",
                          style: TextStyle(
                            color: disabledColor,
                            fontSize: 12,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "${speaker["bio"]}",
                          style: TextStyle(
                            color: primaryColor,
                            fontSize: 13,
                            height: 1.4,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildDetailsTab() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Location
        Text(
          "Location & Address",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        SizedBox(height: spMd),
        Container(
          padding: EdgeInsets.all(spMd),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(radiusLg),
            boxShadow: [shadowSm],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.location_on, color: primaryColor, size: 20),
                  SizedBox(width: spSm),
                  Text(
                    "${event["location"]}",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                ],
              ),
              SizedBox(height: spXs),
              Text(
                "${event["address"]}",
                style: TextStyle(
                  color: disabledBoldColor,
                  fontSize: 14,
                ),
              ),
              SizedBox(height: spMd),
              QButton(
                label: "View on Map",
                size: bs.sm,
                onPressed: () {},
              ),
            ],
          ),
        ),

        SizedBox(height: spLg),

        // What's Included
        Text(
          "What's Included",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        SizedBox(height: spMd),
        Container(
          padding: EdgeInsets.all(spMd),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(radiusLg),
            boxShadow: [shadowSm],
          ),
          child: Column(
            children: (event["amenities"] as List).map<Widget>((amenity) {
              return Padding(
                padding: EdgeInsets.only(bottom: spSm),
                child: Row(
                  children: [
                    Icon(Icons.check_circle, color: successColor, size: 20),
                    SizedBox(width: spSm),
                    Expanded(
                      child: Text(
                        amenity,
                        style: TextStyle(
                          color: primaryColor,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ),

        SizedBox(height: spLg),

        // Requirements
        Text(
          "Requirements & Guidelines",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        SizedBox(height: spMd),
        Container(
          padding: EdgeInsets.all(spMd),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(radiusLg),
            boxShadow: [shadowSm],
          ),
          child: Column(
            children: (event["requirements"] as List).map<Widget>((requirement) {
              return Padding(
                padding: EdgeInsets.only(bottom: spSm),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 6),
                      width: 6,
                      height: 6,
                      decoration: BoxDecoration(
                        color: warningColor,
                        shape: BoxShape.circle,
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: Text(
                        requirement,
                        style: TextStyle(
                          color: primaryColor,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  Color _getAgendaTypeColor(String type) {
    switch (type) {
      case "keynote":
        return primaryColor;
      case "panel":
        return successColor;
      case "workshop":
        return infoColor;
      case "presentation":
        return warningColor;
      case "discussion":
        return dangerColor;
      case "networking":
        return Colors.purple;
      default:
        return disabledColor;
    }
  }

  IconData _getAgendaTypeIcon(String type) {
    switch (type) {
      case "keynote":
        return Icons.mic;
      case "panel":
        return Icons.group;
      case "workshop":
        return Icons.build;
      case "presentation":
        return Icons.slideshow;
      case "discussion":
        return Icons.forum;
      case "networking":
        return Icons.connect_without_contact;
      case "break":
        return Icons.coffee;
      default:
        return Icons.event;
    }
  }
}
