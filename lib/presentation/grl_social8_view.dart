import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlSocial8View extends StatefulWidget {
  @override
  State<GrlSocial8View> createState() => _GrlSocial8ViewState();
}

class _GrlSocial8ViewState extends State<GrlSocial8View> {
  List<Map<String, dynamic>> liveStreams = [
    {
      "id": 1,
      "title": "UI/UX Design Tips & Tricks",
      "streamer": {
        "name": "Sarah Design",
        "avatar": "https://picsum.photos/50/50?random=110",
        "isVerified": true,
      },
      "thumbnail": "https://picsum.photos/300/200?random=120",
      "viewers": 1247,
      "duration": "2:45:30",
      "category": "Design",
      "isLive": true,
    },
    {
      "id": 2,
      "title": "Gaming Stream - Apex Legends",
      "streamer": {
        "name": "ProGamer_X",
        "avatar": "https://picsum.photos/50/50?random=111",
        "isVerified": false,
      },
      "thumbnail": "https://picsum.photos/300/200?random=121",
      "viewers": 856,
      "duration": "1:23:15",
      "category": "Gaming",
      "isLive": true,
    },
    {
      "id": 3,
      "title": "Cooking Italian Pasta",
      "streamer": {
        "name": "Chef Maria",
        "avatar": "https://picsum.photos/50/50?random=112",
        "isVerified": true,
      },
      "thumbnail": "https://picsum.photos/300/200?random=122",
      "viewers": 2134,
      "duration": "45:22",
      "category": "Cooking",
      "isLive": true,
    },
  ];

  List<Map<String, dynamic>> categories = [
    {"name": "All", "icon": Icons.apps, "isSelected": true},
    {"name": "Gaming", "icon": Icons.sports_esports, "isSelected": false},
    {"name": "Music", "icon": Icons.music_note, "isSelected": false},
    {"name": "Art", "icon": Icons.palette, "isSelected": false},
    {"name": "Tech", "icon": Icons.computer, "isSelected": false},
    {"name": "Cooking", "icon": Icons.restaurant, "isSelected": false},
  ];

  List<Map<String, dynamic>> featuredStreamers = [
    {
      "id": 1,
      "name": "TechGuru",
      "avatar": "https://picsum.photos/60/60?random=130",
      "followers": "125K",
      "isFollowing": false,
      "isLive": true,
      "category": "Technology",
    },
    {
      "id": 2,
      "name": "ArtMaster",
      "avatar": "https://picsum.photos/60/60?random=131",
      "followers": "89K",
      "isFollowing": true,
      "isLive": false,
      "category": "Art & Design",
    },
    {
      "id": 3,
      "name": "MusicLover",
      "avatar": "https://picsum.photos/60/60?random=132",
      "followers": "67K",
      "isFollowing": false,
      "isLive": true,
      "category": "Music",
    },
    {
      "id": 4,
      "name": "FoodieChef",
      "avatar": "https://picsum.photos/60/60?random=133",
      "followers": "234K",
      "isFollowing": true,
      "isLive": false,
      "category": "Cooking",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Live Streams",
          style: TextStyle(
            fontSize: fsH4,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          Icon(Icons.search, size: 24),
          SizedBox(width: spMd),
          Icon(Icons.notifications_outlined, size: 24),
          SizedBox(width: spMd),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Categories
            Container(
              height: 50,
              child: QHorizontalScroll(
                children: [
                  SizedBox(width: spMd),
                  ...List.generate(categories.length, (index) {
                    final category = categories[index];
                    final isSelected = category["isSelected"] as bool;
                    
                    return GestureDetector(
                      onTap: () {
                        for (var cat in categories) {
                          cat["isSelected"] = false;
                        }
                        categories[index]["isSelected"] = true;
                        setState(() {});
                      },
                      child: Container(
                        margin: EdgeInsets.only(right: spSm),
                        padding: EdgeInsets.symmetric(horizontal: spMd, vertical: spSm),
                        decoration: BoxDecoration(
                          color: isSelected ? primaryColor : Colors.transparent,
                          borderRadius: BorderRadius.circular(radiusLg),
                          border: Border.all(
                            color: isSelected ? primaryColor : disabledBoldColor,
                            width: 1,
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              category["icon"] as IconData,
                              size: 16,
                              color: isSelected ? Colors.white : disabledBoldColor,
                            ),
                            SizedBox(width: spXs),
                            Text(
                              "${category["name"]}",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: isSelected ? Colors.white : disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
                  SizedBox(width: spMd),
                ],
              ),
            ),
            
            SizedBox(height: spMd),
            
            // Featured Live Streams
            Padding(
              padding: EdgeInsets.symmetric(horizontal: spMd),
              child: Text(
                "Live Now",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            
            SizedBox(height: spSm),
            
            ...List.generate(liveStreams.length, (index) {
              final stream = liveStreams[index];
              final streamer = stream["streamer"] as Map<String, dynamic>;
              
              return Container(
                margin: EdgeInsets.only(bottom: spMd, left: spMd, right: spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusLg),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Stream Thumbnail
                    Stack(
                      children: [
                        Container(
                          height: 200,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(radiusLg),
                              topRight: Radius.circular(radiusLg),
                            ),
                            image: DecorationImage(
                              image: NetworkImage("${stream["thumbnail"]}"),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        
                        // Live Badge
                        Positioned(
                          top: spSm,
                          left: spSm,
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                            decoration: BoxDecoration(
                              color: dangerColor,
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  width: 6,
                                  height: 6,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                                SizedBox(width: spXs),
                                Text(
                                  "LIVE",
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        
                        // Viewers Count
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
                                  Icons.visibility,
                                  size: 12,
                                  color: Colors.white,
                                ),
                                SizedBox(width: spXs),
                                Text(
                                  "${_formatNumber(stream["viewers"] as int)}",
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        
                        // Duration
                        Positioned(
                          bottom: spSm,
                          right: spSm,
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                            decoration: BoxDecoration(
                              color: Colors.black.withAlpha(150),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Text(
                              "${stream["duration"]}",
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        
                        // Play Button
                        Positioned.fill(
                          child: Center(
                            child: Container(
                              width: 60,
                              height: 60,
                              decoration: BoxDecoration(
                                color: Colors.white.withAlpha(200),
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                Icons.play_arrow,
                                size: 30,
                                color: primaryColor,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    
                    // Stream Info
                    Padding(
                      padding: EdgeInsets.all(spMd),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${stream["title"]}",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          
                          SizedBox(height: spSm),
                          
                          Row(
                            children: [
                              Container(
                                width: 35,
                                height: 35,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                    image: NetworkImage("${streamer["avatar"]}"),
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
                                          "${streamer["name"]}",
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
                                            color: primaryColor,
                                          ),
                                        ),
                                        if (streamer["isVerified"] as bool)
                                          Padding(
                                            padding: EdgeInsets.only(left: spXs),
                                            child: Icon(
                                              Icons.verified,
                                              size: 16,
                                              color: primaryColor,
                                            ),
                                          ),
                                      ],
                                    ),
                                    SizedBox(height: spXs),
                                    Text(
                                      "${stream["category"]}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: disabledBoldColor,
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
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }),
            
            SizedBox(height: spMd),
            
            // Featured Streamers
            Padding(
              padding: EdgeInsets.symmetric(horizontal: spMd),
              child: Text(
                "Featured Streamers",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            
            SizedBox(height: spSm),
            
            Container(
              height: 200,
              child: QHorizontalScroll(
                children: [
                  SizedBox(width: spMd),
                  ...List.generate(featuredStreamers.length, (index) {
                    final streamer = featuredStreamers[index];
                    final isFollowing = streamer["isFollowing"] as bool;
                    final isLive = streamer["isLive"] as bool;
                    
                    return Container(
                      width: 150,
                      margin: EdgeInsets.only(right: spMd),
                      padding: EdgeInsets.all(spMd),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(radiusLg),
                        boxShadow: [shadowSm],
                      ),
                      child: Column(
                        children: [
                          Stack(
                            children: [
                              Container(
                                width: 60,
                                height: 60,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                    image: NetworkImage("${streamer["avatar"]}"),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              if (isLive)
                                Positioned(
                                  bottom: 0,
                                  right: 0,
                                  child: Container(
                                    width: 16,
                                    height: 16,
                                    decoration: BoxDecoration(
                                      color: successColor,
                                      shape: BoxShape.circle,
                                      border: Border.all(color: Colors.white, width: 2),
                                    ),
                                  ),
                                ),
                            ],
                          ),
                          
                          SizedBox(height: spSm),
                          
                          Text(
                            "${streamer["name"]}",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                            textAlign: TextAlign.center,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          
                          SizedBox(height: spXs),
                          
                          Text(
                            "${streamer["category"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                            textAlign: TextAlign.center,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          
                          SizedBox(height: spXs),
                          
                          Text(
                            "${streamer["followers"]} followers",
                            style: TextStyle(
                              fontSize: 10,
                              color: primaryColor,
                              fontWeight: FontWeight.w600,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          
                          SizedBox(height: spSm),
                          
                          QButton(
                            label: isFollowing ? "Following" : "Follow",
                            size: bs.sm,
                            color: isFollowing ? disabledBoldColor : primaryColor,
                            onPressed: () {
                              featuredStreamers[index]["isFollowing"] = !isFollowing;
                              setState(() {});
                            },
                          ),
                        ],
                      ),
                    );
                  }),
                  SizedBox(width: spMd),
                ],
              ),
            ),
            
            SizedBox(height: spMd),
          ],
        ),
      ),
    );
  }

  String _formatNumber(int number) {
    if (number >= 1000000) {
      return "${(number / 1000000).toStringAsFixed(1)}M";
    } else if (number >= 1000) {
      return "${(number / 1000).toStringAsFixed(1)}K";
    }
    return number.toString();
  }
}
