import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class SmaProfileView extends StatefulWidget {
  const SmaProfileView({super.key});

  @override
  State<SmaProfileView> createState() => _SmaProfileViewState();
}

class _SmaProfileViewState extends State<SmaProfileView> {
  Map<String, dynamic> profile = {
    "name": "Alex Johnson",
    "username": "@alexjohnson",
    "bio": "Singer, songwriter, and music producer. Creating music that touches hearts and souls.",
    "profileImage": "https://picsum.photos/200/200?random=1&keyword=musician",
    "coverImage": "https://picsum.photos/400/200?random=2&keyword=studio",
    "followers": 125430,
    "following": 892,
    "albums": 8,
    "singles": 24,
    "isVerified": true,
    "location": "Los Angeles, CA",
    "website": "www.alexjohnsonmusic.com",
    "joinDate": "2020-03-15",
  };

  List<Map<String, dynamic>> recentReleases = [
    {
      "title": "Midnight Dreams",
      "type": "Album",
      "releaseDate": "2024-05-15",
      "cover": "https://picsum.photos/120/120?random=3&keyword=album",
      "plays": 2845000,
      "likes": 45200,
    },
    {
      "title": "Summer Vibes",
      "type": "Single",
      "releaseDate": "2024-03-22",
      "cover": "https://picsum.photos/120/120?random=4&keyword=music",
      "plays": 1230000,
      "likes": 28900,
    },
    {
      "title": "Acoustic Sessions",
      "type": "EP",
      "releaseDate": "2024-01-10",
      "cover": "https://picsum.photos/120/120?random=5&keyword=acoustic",
      "plays": 890000,
      "likes": 19500,
    },
  ];

  List<Map<String, dynamic>> topTracks = [
    {
      "title": "Dancing in the Rain",
      "album": "Midnight Dreams",
      "duration": "3:42",
      "plays": 5420000,
      "cover": "https://picsum.photos/60/60?random=6&keyword=dance",
    },
    {
      "title": "Golden Hour",
      "album": "Summer Vibes",
      "duration": "4:15",
      "plays": 3890000,
      "cover": "https://picsum.photos/60/60?random=7&keyword=sunset",
    },
    {
      "title": "Whispered Secrets",
      "album": "Acoustic Sessions",
      "duration": "3:28",
      "plays": 2145000,
      "cover": "https://picsum.photos/60/60?random=8&keyword=whisper",
    },
    {
      "title": "City Lights",
      "album": "Midnight Dreams",
      "duration": "3:58",
      "plays": 1780000,
      "cover": "https://picsum.photos/60/60?random=9&keyword=city",
    },
  ];

  int selectedTab = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Cover Image and Profile Section
            Stack(
              children: [
                // Cover Image
                Container(
                  height: 200,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage("${profile["coverImage"]}"),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Container(
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
                ),
                
                // AppBar
                Positioned(
                  top: 40,
                  left: 0,
                  right: 0,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: spMd),
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () => back(),
                          child: Container(
                            padding: EdgeInsets.all(spXs),
                            decoration: BoxDecoration(
                              color: Colors.black.withAlpha(100),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Icon(
                              Icons.arrow_back,
                              color: Colors.white,
                              size: 20,
                            ),
                          ),
                        ),
                        Spacer(),
                        GestureDetector(
                          onTap: () {},
                          child: Container(
                            padding: EdgeInsets.all(spXs),
                            decoration: BoxDecoration(
                              color: Colors.black.withAlpha(100),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Icon(
                              Icons.more_vert,
                              color: Colors.white,
                              size: 20,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // Profile Info
                Positioned(
                  bottom: spMd,
                  left: spMd,
                  right: spMd,
                  child: Row(
                    children: [
                      // Profile Image
                      Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(radiusLg),
                          border: Border.all(
                            color: Colors.white,
                            width: 3,
                          ),
                          image: DecorationImage(
                            image: NetworkImage("${profile["profileImage"]}"),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  "${profile["name"]}",
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                if ((profile["isVerified"] as bool)) ...[
                                  SizedBox(width: spXs),
                                  Icon(
                                    Icons.verified,
                                    color: primaryColor,
                                    size: 18,
                                  ),
                                ],
                              ],
                            ),
                            Text(
                              "${profile["username"]}",
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.white.withAlpha(200),
                              ),
                            ),
                            SizedBox(height: spXs),
                            Row(
                              children: [
                                Icon(
                                  Icons.location_on,
                                  color: Colors.white.withAlpha(180),
                                  size: 14,
                                ),
                                SizedBox(width: 4),
                                Text(
                                  "${profile["location"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.white.withAlpha(180),
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
              ],
            ),

            Padding(
              padding: EdgeInsets.all(spMd),
              child: Column(
                spacing: spMd,
                children: [
                  // Stats Row
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
                                "${((profile["followers"] as int) / 1000).toInt()}K",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                              Text(
                                "Followers",
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
                                "${profile["following"]}",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                              Text(
                                "Following",
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
                                "${(profile["albums"] as int) + (profile["singles"] as int)}",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                              Text(
                                "Releases",
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

                  // Bio Section
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
                          "About",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        SizedBox(height: spSm),
                        Text(
                          "${profile["bio"]}",
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                            height: 1.5,
                          ),
                        ),
                        SizedBox(height: spSm),
                        Row(
                          children: [
                            Icon(
                              Icons.link,
                              color: primaryColor,
                              size: 16,
                            ),
                            SizedBox(width: spXs),
                            Text(
                              "${profile["website"]}",
                              style: TextStyle(
                                fontSize: 14,
                                color: primaryColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: spXs),
                        Row(
                          children: [
                            Icon(
                              Icons.calendar_today,
                              color: disabledBoldColor,
                              size: 16,
                            ),
                            SizedBox(width: spXs),
                            Text(
                              "Joined ${DateTime.parse(profile["joinDate"]).dMMMy}",
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

                  // Action Buttons
                  Row(
                    children: [
                      Expanded(
                        child: QButton(
                          label: "Follow",
                          size: bs.md,
                          onPressed: () {
                            ss("Following ${profile["name"]}");
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: disabledOutlineBorderColor,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: QButton(
                          icon: Icons.message,
                          size: bs.md,
                          onPressed: () {
                            si("Opening message to ${profile["name"]}");
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: disabledOutlineBorderColor,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: QButton(
                          icon: Icons.share,
                          size: bs.md,
                          onPressed: () {
                            si("Sharing ${profile["name"]}'s profile");
                          },
                        ),
                      ),
                    ],
                  ),

                  // Content Tabs
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusMd),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  selectedTab = 0;
                                  setState(() {});
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(vertical: spSm),
                                  decoration: BoxDecoration(
                                    color: selectedTab == 0 ? primaryColor : Colors.transparent,
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(radiusMd),
                                      bottomLeft: selectedTab == 0 ? Radius.circular(radiusSm) : Radius.zero,
                                    ),
                                  ),
                                  child: Text(
                                    "Recent Releases",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: selectedTab == 0 ? Colors.white : disabledBoldColor,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  selectedTab = 1;
                                  setState(() {});
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(vertical: spSm),
                                  decoration: BoxDecoration(
                                    color: selectedTab == 1 ? primaryColor : Colors.transparent,
                                    borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(radiusMd),
                                      bottomRight: selectedTab == 1 ? Radius.circular(radiusSm) : Radius.zero,
                                    ),
                                  ),
                                  child: Text(
                                    "Top Tracks",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: selectedTab == 1 ? Colors.white : disabledBoldColor,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Container(
                          padding: EdgeInsets.all(spMd),
                          child: selectedTab == 0 ? _buildRecentReleases() : _buildTopTracks(),
                        ),
                      ],
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

  Widget _buildRecentReleases() {
    return Column(
      spacing: spSm,
      children: List.generate(recentReleases.length, (index) {
        final release = recentReleases[index];
        return Container(
          padding: EdgeInsets.all(spSm),
          decoration: BoxDecoration(
            color: Colors.grey[50],
            borderRadius: BorderRadius.circular(radiusSm),
            border: Border.all(
              color: disabledOutlineBorderColor,
              width: 1,
            ),
          ),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(radiusXs),
                child: Image.network(
                  "${release["cover"]}",
                  width: 60,
                  height: 60,
                  fit: BoxFit.cover,
                ),
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
                            "${release["title"]}",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: spXs,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: primaryColor,
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            "${release["type"]}",
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 4),
                    Text(
                      "Released ${DateTime.parse(release["releaseDate"]).dMMMy}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(height: 4),
                    Row(
                      children: [
                        Icon(
                          Icons.play_arrow,
                          color: primaryColor,
                          size: 16,
                        ),
                        SizedBox(width: 4),
                        Text(
                          "${((release["plays"] as int) / 1000000).toStringAsFixed(1)}M plays",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                        SizedBox(width: spSm),
                        Icon(
                          Icons.favorite,
                          color: dangerColor,
                          size: 16,
                        ),
                        SizedBox(width: 4),
                        Text(
                          "${((release["likes"] as int) / 1000).toStringAsFixed(0)}K",
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
              GestureDetector(
                onTap: () {},
                child: Icon(
                  Icons.play_circle_fill,
                  color: primaryColor,
                  size: 28,
                ),
              ),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildTopTracks() {
    return Column(
      spacing: spSm,
      children: List.generate(topTracks.length, (index) {
        final track = topTracks[index];
        return Container(
          padding: EdgeInsets.all(spSm),
          decoration: BoxDecoration(
            color: Colors.grey[50],
            borderRadius: BorderRadius.circular(radiusSm),
            border: Border.all(
              color: disabledOutlineBorderColor,
              width: 1,
            ),
          ),
          child: Row(
            children: [
              Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  color: primaryColor,
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Center(
                  child: Text(
                    "${index + 1}",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              SizedBox(width: spSm),
              ClipRRect(
                borderRadius: BorderRadius.circular(radiusXs),
                child: Image.network(
                  "${track["cover"]}",
                  width: 40,
                  height: 40,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${track["title"]}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "${track["album"]} • ${track["duration"]}",
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
                    "${((track["plays"] as int) / 1000000).toStringAsFixed(1)}M",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Text(
                    "plays",
                    style: TextStyle(
                      fontSize: 10,
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ),
              SizedBox(width: spSm),
              GestureDetector(
                onTap: () {},
                child: Icon(
                  Icons.play_circle_fill,
                  color: primaryColor,
                  size: 24,
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
