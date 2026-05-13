import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class EmaEventDetailView extends StatefulWidget {
  const EmaEventDetailView({super.key});

  @override
  State<EmaEventDetailView> createState() => _EmaEventDetailViewState();
}

class _EmaEventDetailViewState extends State<EmaEventDetailView> {
  bool isBookmarked = false;
  bool isAttending = false;
  int selectedTicketType = 0;
  int ticketQuantity = 1;
  
  final event = {
    "id": "1",
    "title": "Tech Conference 2025",
    "description": "Join industry leaders for an immersive conference featuring cutting-edge technology presentations, networking opportunities, and hands-on workshops. Learn about the latest trends in AI, blockchain, and software development.",
    "date": "2025-01-15",
    "time": "09:00",
    "venue": "Grand Convention Center",
    "location": "Downtown Tech District, 123 Innovation Ave",
    "organizer": "TechEvents Inc.",
    "category": "Technology",
    "image": "https://picsum.photos/400/300?random=1&keyword=conference",
    "price": 150.0,
    "capacity": 500,
    "attendees": 342,
    "rating": 4.8,
    "reviews": 156,
    "status": "upcoming",
    "tags": ["Technology", "Networking", "Innovation"],
    "gallery": [
      "https://picsum.photos/300/200?random=10&keyword=conference",
      "https://picsum.photos/300/200?random=11&keyword=tech",
      "https://picsum.photos/300/200?random=12&keyword=event",
      "https://picsum.photos/300/200?random=13&keyword=seminar"
    ]
  };

  final ticketTypes = [
    {"name": "Early Bird", "price": 120.0, "description": "Limited time offer"},
    {"name": "Regular", "price": 150.0, "description": "Standard admission"},
    {"name": "VIP", "price": 250.0, "description": "Premium access with perks"},
  ];

  final reviews = [
    {
      "name": "Sarah Johnson",
      "rating": 5,
      "comment": "Amazing event! Great speakers and excellent networking opportunities.",
      "date": "2024-12-20",
      "avatar": "https://picsum.photos/60/60?random=20&keyword=person"
    },
    {
      "name": "Michael Chen",
      "rating": 4,
      "comment": "Very informative sessions. Well organized and professional.",
      "date": "2024-12-18",
      "avatar": "https://picsum.photos/60/60?random=21&keyword=person"
    },
    {
      "name": "Emily Davis",
      "rating": 5,
      "comment": "Exceeded expectations! Will definitely attend next year.",
      "date": "2024-12-15",
      "avatar": "https://picsum.photos/60/60?random=22&keyword=person"
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildEventHeader(),
            _buildEventInfo(),
            _buildDescription(),
            _buildEventTags(),
            _buildTicketTypes(),
            _buildGallery(),
            _buildReviews(),
            _buildSimilarEvents(),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomBar(),
    );
  }

  Widget _buildEventHeader() {
    return Container(
      height: 300,
      child: Stack(
        children: [
          Container(
            width: double.infinity,
            height: 300,
            child: Image.network(
              "${event["image"]}",
              fit: BoxFit.cover,
            ),
          ),
          Container(
            width: double.infinity,
            height: 300,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.transparent,
                  Colors.black.withAlpha(179),
                ],
              ),
            ),
          ),
          Positioned(
            top: 50,
            left: spMd,
            child: GestureDetector(
              onTap: () => back(),
              child: Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.white.withAlpha(230),
                  borderRadius: BorderRadius.circular(radiusLg),
                ),
                child: Icon(
                  Icons.arrow_back,
                  color: primaryColor,
                  size: 24,
                ),
              ),
            ),
          ),
          Positioned(
            top: 50,
            right: spMd,
            child: Row(
              children: [
                GestureDetector(
                  onTap: () {
                    isBookmarked = !isBookmarked;
                    setState(() {});
                  },
                  child: Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: Colors.white.withAlpha(230),
                      borderRadius: BorderRadius.circular(radiusLg),
                    ),
                    child: Icon(
                      isBookmarked ? Icons.bookmark : Icons.bookmark_border,
                      color: isBookmarked ? warningColor : primaryColor,
                      size: 24,
                    ),
                  ),
                ),
                SizedBox(width: spSm),
                GestureDetector(
                  onTap: () {
                    ss("Event shared successfully");
                  },
                  child: Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: Colors.white.withAlpha(230),
                      borderRadius: BorderRadius.circular(radiusLg),
                    ),
                    child: Icon(
                      Icons.share,
                      color: primaryColor,
                      size: 24,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: spMd,
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
                    color: Colors.white,
                    fontSize: fsH3,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: spXs),
                Row(
                  children: [
                    Icon(
                      Icons.calendar_today,
                      color: Colors.white,
                      size: 16,
                    ),
                    SizedBox(width: spXs),
                    Text(
                      "${DateTime.parse(event["date"] as String).dMMMy} at ${event["time"]}",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
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
  }

  Widget _buildEventInfo() {
    return Container(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.location_on,
                          color: primaryColor,
                          size: 20,
                        ),
                        SizedBox(width: spXs),
                        Expanded(
                          child: Text(
                            "${event["venue"]}",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: primaryColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "${event["location"]}",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: spMd),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    "\$${(event["price"] as double).toStringAsFixed(0)}",
                    style: TextStyle(
                      fontSize: fsH4,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Text(
                    "per ticket",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: spMd),
          Row(
            children: [
              Expanded(
                child: _buildInfoCard(
                  Icons.people,
                  "Attendees",
                  "${event["attendees"]}/${event["capacity"]}",
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: _buildInfoCard(
                  Icons.star,
                  "Rating",
                  "${event["rating"]} (${event["reviews"]})",
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: _buildInfoCard(
                  Icons.business,
                  "Organizer",
                  "${event["organizer"]}",
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInfoCard(IconData icon, String label, String value) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusSm),
        boxShadow: [shadowSm],
      ),
      child: Column(
        children: [
          Icon(
            icon,
            color: primaryColor,
            size: 24,
          ),
          SizedBox(height: spXs),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: spXs),
          Text(
            value,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: primaryColor,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildDescription() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "About This Event",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          Text(
            "${event["description"]}",
            style: TextStyle(
              fontSize: 14,
              color: disabledBoldColor,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEventTags() {
    return Container(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Tags",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          Wrap(
            spacing: spSm,
            runSpacing: spXs,
            children: (event["tags"] as List).map((tag) {
              return Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: primaryColor.withAlpha(26),
                  borderRadius: BorderRadius.circular(radiusSm),
                  border: Border.all(color: primaryColor.withAlpha(51)),
                ),
                child: Text(
                  "$tag",
                  style: TextStyle(
                    fontSize: 12,
                    color: primaryColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildTicketTypes() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Ticket Types",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          Column(
            children: List.generate(ticketTypes.length, (index) {
              final ticket = ticketTypes[index];
              return GestureDetector(
                onTap: () {
                  selectedTicketType = index;
                  setState(() {});
                },
                child: Container(
                  margin: EdgeInsets.only(bottom: spSm),
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: selectedTicketType == index ? primaryColor.withAlpha(26) : Colors.white,
                    borderRadius: BorderRadius.circular(radiusSm),
                    border: Border.all(
                      color: selectedTicketType == index ? primaryColor : disabledOutlineBorderColor,
                      width: selectedTicketType == index ? 2 : 1,
                    ),
                  ),
                  child: Row(
                    children: [
                      Radio(
                        value: index,
                        groupValue: selectedTicketType,
                        onChanged: (value) {
                          selectedTicketType = value as int;
                          setState(() {});
                        },
                        activeColor: primaryColor,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${ticket["name"]}",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              "${ticket["description"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        "\$${(ticket["price"] as double).toStringAsFixed(0)}",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildGallery() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Event Gallery",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              GestureDetector(
                onTap: () {
                  // navigateTo(EmaEventGalleryView())
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
          SizedBox(height: spSm),
          QHorizontalScroll(
            children: (event["gallery"] as List).map((image) {
              return Container(
                width: 150,
                height: 100,
                margin: EdgeInsets.only(right: spSm),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(radiusSm),
                  boxShadow: [shadowSm],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(radiusSm),
                  child: Image.network(
                    "$image",
                    fit: BoxFit.cover,
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildReviews() {
    return Container(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Reviews & Ratings",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          ...reviews.take(2).map((review) {
            return Container(
              margin: EdgeInsets.only(bottom: spSm),
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusSm),
                boxShadow: [shadowSm],
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 20,
                    backgroundImage: NetworkImage("${review["avatar"]}"),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              "${review["name"]}",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: primaryColor,
                              ),
                            ),
                            Spacer(),
                            Row(
                              children: List.generate(5, (index) {
                                return Icon(
                                  index < (review["rating"] as int) ? Icons.star : Icons.star_border,
                                  color: warningColor,
                                  size: 16,
                                );
                              }),
                            ),
                          ],
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "${review["comment"]}",
                          style: TextStyle(
                            fontSize: 13,
                            color: disabledBoldColor,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "${DateTime.parse(review["date"] as String).dMMMy}",
                          style: TextStyle(
                            fontSize: 11,
                            color: disabledColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
          if (reviews.length > 2)
            GestureDetector(
              onTap: () {
                // Show all reviews
              },
              child: Text(
                "View all ${reviews.length} reviews",
                style: TextStyle(
                  fontSize: 14,
                  color: primaryColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildSimilarEvents() {
    final similarEvents = [
      {
        "title": "AI Summit 2025",
        "date": "2025-02-20",
        "price": 180.0,
        "image": "https://picsum.photos/150/100?random=30&keyword=ai"
      },
      {
        "title": "Blockchain Conference",
        "date": "2025-03-10",
        "price": 200.0,
        "image": "https://picsum.photos/150/100?random=31&keyword=blockchain"
      },
    ];

    return Container(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Similar Events",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          Column(
            children: similarEvents.map((event) {
              return Container(
                margin: EdgeInsets.only(bottom: spSm),
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusSm),
                  boxShadow: [shadowSm],
                ),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(radiusSm),
                      child: Image.network(
                        "${event["image"]}",
                        width: 80,
                        height: 60,
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${event["title"]}",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: primaryColor,
                            ),
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "${DateTime.parse(event["date"] as String).dMMMy}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      "\$${(event["price"] as double).toStringAsFixed(0)}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomBar() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [shadowSm],
      ),
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: disabledOutlineBorderColor),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () {
                    if (ticketQuantity > 1) {
                      ticketQuantity--;
                      setState(() {});
                    }
                  },
                  child: Container(
                    padding: EdgeInsets.all(spSm),
                    child: Icon(
                      Icons.remove,
                      color: primaryColor,
                      size: 20,
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: spSm),
                  child: Text(
                    "$ticketQuantity",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: primaryColor,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    ticketQuantity++;
                    setState(() {});
                  },
                  child: Container(
                    padding: EdgeInsets.all(spSm),
                    child: Icon(
                      Icons.add,
                      color: primaryColor,
                      size: 20,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: spMd),
          Expanded(
            child: QButton(
              label: "Book Now - \$${((ticketTypes[selectedTicketType]["price"] as double) * ticketQuantity).toStringAsFixed(0)}",
              size: bs.md,
              onPressed: () {
                ss("Booking confirmed!");
              },
            ),
          ),
        ],
      ),
    );
  }
}
