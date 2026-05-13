import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlProfile8View extends StatefulWidget {
  @override
  State<GrlProfile8View> createState() => _GrlProfile8ViewState();
}

class _GrlProfile8ViewState extends State<GrlProfile8View> {
  Map<String, dynamic> user = {
    "name": "Marcus Johnson",
    "username": "@marcusmusic",
    "avatar": "https://picsum.photos/100/100?random=23&keyword=musician",
    "profession": "Singer-Songwriter",
    "genre": "Indie Folk",
    "location": "Nashville, TN",
    "memberSince": "2019",
    "followers": 45600,
    "monthlyListeners": 128000,
    "totalPlays": 2450000,
    "albums": 4,
    "singles": 12,
    "verified": true,
    "label": "Independent",
    "bio": "Crafting melodies that tell stories. From small coffee shops to big stages, sharing music that connects hearts and souls.",
  };

  List<Map<String, dynamic>> albums = [
    {
      "title": "Midnight Reflections",
      "year": 2024,
      "cover": "https://picsum.photos/200/200?random=24&keyword=album",
      "tracks": 11,
      "duration": "42:18",
      "plays": 856000,
      "rating": 4.8,
    },
    {
      "title": "Road to Nowhere",
      "year": 2023,
      "cover": "https://picsum.photos/200/200?random=25&keyword=music",
      "tracks": 9,
      "duration": "36:45",
      "plays": 1200000,
      "rating": 4.9,
    },
    {
      "title": "Acoustic Sessions Vol. 1",
      "year": 2022,
      "cover": "https://picsum.photos/200/200?random=26&keyword=guitar",
      "tracks": 7,
      "duration": "28:32",
      "plays": 680000,
      "rating": 4.7,
    },
    {
      "title": "First Light",
      "year": 2021,
      "cover": "https://picsum.photos/200/200?random=27&keyword=sunrise",
      "tracks": 10,
      "duration": "38:15",
      "plays": 920000,
      "rating": 4.6,
    },
  ];

  List<Map<String, dynamic>> popularTracks = [
    {
      "title": "Whispers in the Wind",
      "album": "Midnight Reflections",
      "duration": "3:42",
      "plays": 245000,
      "rating": 4.9,
    },
    {
      "title": "Coffee Shop Dreams",
      "album": "Road to Nowhere",
      "duration": "4:15",
      "plays": 312000,
      "rating": 4.8,
    },
    {
      "title": "Mountain High",
      "album": "First Light",
      "duration": "3:28",
      "plays": 189000,
      "rating": 4.7,
    },
    {
      "title": "Hometown Blues",
      "album": "Acoustic Sessions Vol. 1",
      "duration": "4:02",
      "plays": 156000,
      "rating": 4.6,
    },
  ];

  List<Map<String, dynamic>> upcomingShows = [
    {
      "venue": "The Bluebird Cafe",
      "city": "Nashville, TN",
      "date": "Dec 28, 2024",
      "time": "8:00 PM",
      "ticketsAvailable": true,
      "price": 35,
    },
    {
      "venue": "Austin Music Hall",
      "city": "Austin, TX",
      "date": "Jan 15, 2025",
      "time": "7:30 PM",
      "ticketsAvailable": true,
      "price": 45,
    },
    {
      "venue": "The Troubadour",
      "city": "Los Angeles, CA",
      "date": "Jan 22, 2025",
      "time": "9:00 PM",
      "ticketsAvailable": false,
      "price": 55,
    },
  ];

  List<Map<String, dynamic>> achievements = [
    {
      "icon": Icons.music_note,
      "title": "Streaming Milestone",
      "description": "1M+ total streams",
      "year": "2024",
    },
    {
      "icon": Icons.album,
      "title": "Album of the Year",
      "description": "Nashville Music Awards",
      "year": "2023",
    },
    {
      "icon": Icons.mic,
      "title": "Best New Artist",
      "description": "Indie Folk Association",
      "year": "2022",
    },
    {
      "icon": Icons.radio,
      "title": "Radio Play Achievement",
      "description": "Top 40 Indie Charts",
      "year": "2021",
    },
  ];

  List<Map<String, dynamic>> fanReviews = [
    {
      "fanName": "Sarah M.",
      "rating": 5,
      "comment": "Marcus's music has gotten me through so many tough times. His lyrics are poetry and his voice is pure magic.",
      "location": "Chicago, IL",
      "verified": true,
    },
    {
      "fanName": "David K.",
      "rating": 5,
      "comment": "Saw him live in Austin - absolutely incredible performance! The intimate acoustic set was unforgettable.",
      "location": "Austin, TX",
      "verified": true,
    },
    {
      "fanName": "Emma R.",
      "rating": 4,
      "comment": "Love the new album! 'Whispers in the Wind' has been on repeat. Can't wait for the tour to come to my city.",
      "location": "Portland, OR",
      "verified": false,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Artist Profile"),
        actions: [
          IconButton(
            icon: Icon(Icons.favorite_border),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.share),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Artist Header
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.purple.shade50,
                    Colors.white,
                  ],
                ),
              ),
              child: Padding(
                padding: EdgeInsets.all(spLg),
                child: Column(
                  children: [
                    // Avatar and Basic Info
                    Row(
                      children: [
                        Stack(
                          children: [
                            Container(
                              width: 90,
                              height: 90,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(color: primaryColor, width: 3),
                                boxShadow: [shadowLg],
                              ),
                              child: ClipOval(
                                child: Image.network(
                                  "${user["avatar"]}",
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            if (user["verified"] == true)
                              Positioned(
                                bottom: 0,
                                right: 0,
                                child: Container(
                                  width: 24,
                                  height: 24,
                                  decoration: BoxDecoration(
                                    color: primaryColor,
                                    shape: BoxShape.circle,
                                    border: Border.all(color: Colors.white, width: 2),
                                  ),
                                  child: Icon(
                                    Icons.check,
                                    color: Colors.white,
                                    size: 12,
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
                                    "${user["name"]}",
                                    style: TextStyle(
                                      fontSize: fsH4,
                                      fontWeight: FontWeight.bold,
                                      color: primaryColor,
                                    ),
                                  ),
                                  if (user["verified"] == true) ...[
                                    SizedBox(width: spXs),
                                    Icon(
                                      Icons.verified,
                                      color: primaryColor,
                                      size: 20,
                                    ),
                                  ],
                                ],
                              ),
                              Text(
                                "${user["username"]}",
                                style: TextStyle(
                                  fontSize: 16,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Text(
                                "${user["profession"]} • ${user["genre"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: secondaryColor,
                                ),
                              ),
                              SizedBox(height: spXs),
                              Row(
                                children: [
                                  Icon(Icons.location_on, size: 14, color: disabledColor),
                                  SizedBox(width: spXs),
                                  Text(
                                    "${user["location"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledColor,
                                    ),
                                  ),
                                  SizedBox(width: spSm),
                                  Text(
                                    "Since ${user["memberSince"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledColor,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    
                    SizedBox(height: spMd),
                    
                    // Bio
                    Text(
                      "${user["bio"]}",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                        height: 1.5,
                      ),
                    ),
                    
                    SizedBox(height: spMd),
                    
                    // Music Stats
                    Row(
                      children: [
                        Expanded(
                          child: _buildStatColumn(
                            "${(user["followers"] as int) / 1000}K",
                            "Followers",
                            primaryColor,
                          ),
                        ),
                        Expanded(
                          child: _buildStatColumn(
                            "${(user["monthlyListeners"] as int) / 1000}K",
                            "Monthly Listeners",
                            successColor,
                          ),
                        ),
                        Expanded(
                          child: _buildStatColumn(
                            "${(user["totalPlays"] as int) / 1000000}M",
                            "Total Plays",
                            warningColor,
                          ),
                        ),
                        Expanded(
                          child: _buildStatColumn(
                            "${user["albums"]}",
                            "Albums",
                            infoColor,
                          ),
                        ),
                      ],
                    ),
                    
                    SizedBox(height: spMd),
                    
                    // Action Buttons
                    Row(
                      children: [
                        Expanded(
                          child: QButton(
                            label: "Follow",
                            size: bs.sm,
                            onPressed: () {},
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: QButton(
                            label: "Play Music",
                            color: successColor,
                            size: bs.sm,
                            onPressed: () {},
                          ),
                        ),
                        SizedBox(width: spSm),
                        QButton(
                          icon: Icons.message,
                          size: bs.sm,
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            
            Padding(
              padding: EdgeInsets.all(spMd),
              child: Column(
                spacing: spMd,
                children: [
                  // Albums Section
                  Container(
                    width: double.infinity,
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
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Discography",
                              style: TextStyle(
                                fontSize: fsH6,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {},
                              child: Text(
                                "View All",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: secondaryColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: spMd),
                        QHorizontalScroll(
                          children: albums.map((album) {
                            return Container(
                              width: 160,
                              margin: EdgeInsets.only(right: spSm),
                              decoration: BoxDecoration(
                                color: Colors.grey.shade50,
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(radiusSm),
                                    ),
                                    child: Image.network(
                                      "${album["cover"]}",
                                      width: 160,
                                      height: 160,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(spSm),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "${album["title"]}",
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
                                            color: primaryColor,
                                          ),
                                        ),
                                        SizedBox(height: spXs),
                                        Text(
                                          "${album["year"]} • ${album["tracks"]} tracks",
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: disabledColor,
                                          ),
                                        ),
                                        SizedBox(height: spXs),
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.play_circle,
                                              size: 14,
                                              color: disabledColor,
                                            ),
                                            SizedBox(width: spXs),
                                            Text(
                                              "${(album["plays"] as int) / 1000}K plays",
                                              style: TextStyle(
                                                fontSize: 12,
                                                color: disabledColor,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: spXs),
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.star,
                                              size: 14,
                                              color: warningColor,
                                            ),
                                            SizedBox(width: spXs),
                                            Text(
                                              "${album["rating"]}",
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
                                ],
                              ),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                  ),

                  // Popular Tracks
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(spMd),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusLg),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Popular Tracks",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        SizedBox(height: spMd),
                        Column(
                          children: popularTracks.map((track) {
                            int index = popularTracks.indexOf(track);
                            return Container(
                              margin: EdgeInsets.only(bottom: spSm),
                              padding: EdgeInsets.all(spSm),
                              decoration: BoxDecoration(
                                color: Colors.grey.shade50,
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    width: 24,
                                    height: 24,
                                    decoration: BoxDecoration(
                                      color: primaryColor.withAlpha(20),
                                      shape: BoxShape.circle,
                                    ),
                                    child: Center(
                                      child: Text(
                                        "${index + 1}",
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                          color: primaryColor,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: spMd),
                                  Icon(
                                    Icons.play_circle,
                                    color: successColor,
                                    size: 20,
                                  ),
                                  SizedBox(width: spMd),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "${track["title"]}",
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
                                            color: primaryColor,
                                          ),
                                        ),
                                        Text(
                                          "${track["album"]} • ${track["duration"]}",
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: disabledColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Icon(
                                            Icons.star,
                                            size: 12,
                                            color: warningColor,
                                          ),
                                          SizedBox(width: spXs),
                                          Text(
                                            "${track["rating"]}",
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: disabledBoldColor,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Text(
                                        "${(track["plays"] as int) / 1000}K plays",
                                        style: TextStyle(
                                          fontSize: 10,
                                          color: disabledColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                  ),

                  // Upcoming Shows
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(spMd),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusLg),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Upcoming Shows",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        SizedBox(height: spMd),
                        Column(
                          children: upcomingShows.map((show) {
                            return Container(
                              margin: EdgeInsets.only(bottom: spSm),
                              padding: EdgeInsets.all(spSm),
                              decoration: BoxDecoration(
                                color: Colors.grey.shade50,
                                borderRadius: BorderRadius.circular(radiusSm),
                                border: Border.all(
                                  color: show["ticketsAvailable"] == true 
                                      ? successColor.withAlpha(100)
                                      : dangerColor.withAlpha(100),
                                ),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "${show["venue"]}",
                                              style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600,
                                                color: primaryColor,
                                              ),
                                            ),
                                            Text(
                                              "${show["city"]}",
                                              style: TextStyle(
                                                fontSize: 12,
                                                color: disabledBoldColor,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: spSm,
                                          vertical: spXs,
                                        ),
                                        decoration: BoxDecoration(
                                          color: show["ticketsAvailable"] == true 
                                              ? successColor.withAlpha(20)
                                              : dangerColor.withAlpha(20),
                                          borderRadius: BorderRadius.circular(radiusSm),
                                        ),
                                        child: Text(
                                          show["ticketsAvailable"] == true 
                                              ? "Available" 
                                              : "Sold Out",
                                          style: TextStyle(
                                            fontSize: 10,
                                            color: show["ticketsAvailable"] == true 
                                                ? successColor 
                                                : dangerColor,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: spXs),
                                  Row(
                                    children: [
                                      Icon(Icons.calendar_today, size: 14, color: disabledColor),
                                      SizedBox(width: spXs),
                                      Text(
                                        "${show["date"]}",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: disabledColor,
                                        ),
                                      ),
                                      SizedBox(width: spMd),
                                      Icon(Icons.schedule, size: 14, color: disabledColor),
                                      SizedBox(width: spXs),
                                      Text(
                                        "${show["time"]}",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: disabledColor,
                                        ),
                                      ),
                                      Spacer(),
                                      Text(
                                        "\$${show["price"]}",
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: primaryColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                  ),

                  // Achievements
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(spMd),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusLg),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Achievements",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        SizedBox(height: spMd),
                        ResponsiveGridView(
                          padding: EdgeInsets.zero,
                          minItemWidth: 200,
                          children: achievements.map((achievement) {
                            return Container(
                              padding: EdgeInsets.all(spSm),
                              decoration: BoxDecoration(
                                color: primaryColor.withAlpha(20),
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Column(
                                children: [
                                  Icon(
                                    achievement["icon"] as IconData,
                                    color: primaryColor,
                                    size: 24,
                                  ),
                                  SizedBox(height: spXs),
                                  Text(
                                    "${achievement["title"]}",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      color: primaryColor,
                                    ),
                                  ),
                                  Text(
                                    "${achievement["year"]}",
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: warningColor,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    "${achievement["description"]}",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: disabledColor,
                                      height: 1.3,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                  ),

                  // Fan Reviews
                  Container(
                    width: double.infinity,
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
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Fan Reviews",
                              style: TextStyle(
                                fontSize: fsH6,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {},
                              child: Text(
                                "View All",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: secondaryColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: spMd),
                        Column(
                          children: fanReviews.take(2).map((review) {
                            return Container(
                              margin: EdgeInsets.only(bottom: spSm),
                              padding: EdgeInsets.all(spSm),
                              decoration: BoxDecoration(
                                color: Colors.grey.shade50,
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        "${review["fanName"]}",
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          color: primaryColor,
                                        ),
                                      ),
                                      if (review["verified"] == true) ...[
                                        SizedBox(width: spXs),
                                        Icon(
                                          Icons.verified,
                                          color: successColor,
                                          size: 14,
                                        ),
                                      ],
                                      SizedBox(width: spSm),
                                      Text(
                                        "${review["location"]}",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: disabledColor,
                                        ),
                                      ),
                                      Spacer(),
                                      Row(
                                        children: List.generate(5, (index) {
                                          return Icon(
                                            index < (review["rating"] as int) 
                                                ? Icons.star 
                                                : Icons.star_border,
                                            color: warningColor,
                                            size: 14,
                                          );
                                        }),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: spXs),
                                  Text(
                                    "${review["comment"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                      height: 1.4,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                  ),

                  // Contact & Social
                  Row(
                    children: [
                      Expanded(
                        child: QButton(
                          label: "Buy Tickets",
                          size: bs.md,
                          onPressed: () {},
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QButton(
                          label: "View Merch",
                          color: secondaryColor,
                          size: bs.md,
                          onPressed: () {},
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
    );
  }

  Widget _buildStatColumn(String value, String label, Color color) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        Text(
          label,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 12,
            color: disabledColor,
          ),
        ),
      ],
    );
  }
}
