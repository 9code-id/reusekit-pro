import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlStory10View extends StatefulWidget {
  @override
  State<GrlStory10View> createState() => _GrlStory10ViewState();
}

class _GrlStory10ViewState extends State<GrlStory10View> {
  bool isLive = true;
  int viewerCount = 1532;
  bool isFollowing = false;
  String chatMessage = "";
  
  List<Map<String, dynamic>> liveComments = [
    {
      "username": "fitness_lover",
      "avatar": "https://picsum.photos/50/50?random=80&keyword=athlete",
      "message": "Great workout! 💪",
      "time": "now",
      "isPinned": false
    },
    {
      "username": "health_enthusiast",
      "avatar": "https://picsum.photos/50/50?random=81&keyword=gym",
      "message": "Can you show the next exercise?",
      "time": "5s",
      "isPinned": false
    },
    {
      "username": "workout_buddy",
      "avatar": "https://picsum.photos/50/50?random=82&keyword=fitness",
      "message": "Following along from home! 🏠",
      "time": "12s",
      "isPinned": true
    },
    {
      "username": "trainer_mike",
      "avatar": "https://picsum.photos/50/50?random=83&keyword=coach",
      "message": "Perfect form! Keep it up everyone! 🔥",
      "time": "18s",
      "isPinned": false
    },
  ];

  List<Map<String, dynamic>> liveViewers = [
    {
      "username": "gym_rat",
      "avatar": "https://picsum.photos/50/50?random=90&keyword=weightlifter",
    },
    {
      "username": "cardio_queen",
      "avatar": "https://picsum.photos/50/50?random=91&keyword=runner",
    },
    {
      "username": "yoga_master",
      "avatar": "https://picsum.photos/50/50?random=92&keyword=yoga",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // Live Video Background
          Container(
            width: double.infinity,
            height: double.infinity,
            child: Image.network(
              "https://picsum.photos/400/800?random=300&keyword=workout",
              fit: BoxFit.cover,
            ),
          ),

          // Gradient Overlay
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black.withAlpha(150),
                  Colors.transparent,
                  Colors.black.withAlpha(200),
                ],
              ),
            ),
          ),

          // Header
          Positioned(
            top: 50,
            left: spMd,
            right: spMd,
            child: Row(
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundImage: NetworkImage(
                    "https://picsum.photos/80/80?random=11&keyword=trainer"
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "fitness_coach_sarah",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      Row(
                        children: [
                          Container(
                            width: 8,
                            height: 8,
                            decoration: BoxDecoration(
                              color: Colors.red,
                              shape: BoxShape.circle,
                            ),
                          ),
                          SizedBox(width: 4),
                          Text(
                            "LIVE Workout Session",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                if (!isFollowing)
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        isFollowing = true;
                      });
                      ss("Now following fitness_coach_sarah!");
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: spSm,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: primaryColor,
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Text(
                        "Follow",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ),
                SizedBox(width: spSm),
                GestureDetector(
                  onTap: () => back(),
                  child: Icon(
                    Icons.close,
                    color: Colors.white,
                    size: 24,
                  ),
                ),
              ],
            ),
          ),

          // Live Viewer Count
          Positioned(
            top: 110,
            left: spMd,
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: spSm,
                vertical: 4,
              ),
              decoration: BoxDecoration(
                color: Colors.black.withAlpha(150),
                borderRadius: BorderRadius.circular(radiusXs),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.remove_red_eye,
                    color: Colors.white,
                    size: 14,
                  ),
                  SizedBox(width: 4),
                  Text(
                    "${viewerCount}",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Workout Timer/Info (Center)
          Positioned(
            top: MediaQuery.of(context).size.height * 0.4,
            left: spMd,
            right: spMd,
            child: Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.black.withAlpha(150),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Column(
                children: [
                  Text(
                    "HIIT Cardio Blast",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: spSm),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: spSm,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: primaryColor,
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Text(
                          "Exercise 3/8",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(width: spSm),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: spSm,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.orange,
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Text(
                          "0:45 remaining",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          // Live Viewer Avatars (Right Side)
          Positioned(
            right: spMd,
            top: 150,
            child: Column(
              children: [
                ...liveViewers.take(5).map((viewer) {
                  return Container(
                    margin: EdgeInsets.only(bottom: spSm),
                    child: CircleAvatar(
                      radius: 15,
                      backgroundColor: Colors.white,
                      child: CircleAvatar(
                        radius: 13,
                        backgroundImage: NetworkImage(
                          "${viewer["avatar"]}"
                        ),
                      ),
                    ),
                  );
                }).toList(),
                if (viewerCount > 5)
                  Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                      color: Colors.black.withAlpha(150),
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.white,
                        width: 2,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        "+${viewerCount - 5}",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 8,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),

          // Live Comments Section
          Positioned(
            bottom: 120,
            left: spMd,
            right: spMd,
            child: Container(
              height: 200,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: ListView.builder(
                      reverse: true,
                      itemCount: liveComments.length,
                      itemBuilder: (context, index) {
                        final comment = liveComments.reversed.toList()[index];
                        bool isPinned = comment["isPinned"] as bool;
                        
                        return Container(
                          margin: EdgeInsets.only(bottom: spXs),
                          child: Container(
                            padding: EdgeInsets.all(spSm),
                            decoration: BoxDecoration(
                              color: isPinned 
                                  ? primaryColor.withAlpha(100) 
                                  : Colors.black.withAlpha(100),
                              borderRadius: BorderRadius.circular(radiusXs),
                              border: isPinned 
                                  ? Border.all(color: primaryColor, width: 1)
                                  : null,
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CircleAvatar(
                                  radius: 10,
                                  backgroundImage: NetworkImage(
                                    "${comment["avatar"]}"
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
                                            "${comment["username"]}",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 12,
                                            ),
                                          ),
                                          SizedBox(width: spXs),
                                          Text(
                                            "${comment["time"]}",
                                            style: TextStyle(
                                              color: Colors.white.withAlpha(150),
                                              fontSize: 10,
                                            ),
                                          ),
                                          if (isPinned) ...[
                                            SizedBox(width: spXs),
                                            Icon(
                                              Icons.push_pin,
                                              color: primaryColor,
                                              size: 10,
                                            ),
                                          ],
                                        ],
                                      ),
                                      Text(
                                        "${comment["message"]}",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 13,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Live Chat Input
          Positioned(
            bottom: 40,
            left: spMd,
            right: spMd,
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: spSm),
                    decoration: BoxDecoration(
                      color: Colors.black.withAlpha(150),
                      borderRadius: BorderRadius.circular(radiusLg),
                      border: Border.all(
                        color: Colors.white.withAlpha(50),
                        width: 1,
                      ),
                    ),
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: "Cheer on the workout...",
                        hintStyle: TextStyle(
                          color: Colors.white.withAlpha(150),
                        ),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(vertical: spSm),
                      ),
                      style: TextStyle(color: Colors.white),
                      onChanged: (value) {
                        chatMessage = value;
                        setState(() {});
                      },
                    ),
                  ),
                ),
                SizedBox(width: spSm),
                
                // Quick Reactions
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        ss("💪 sent!");
                      },
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: Colors.black.withAlpha(150),
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Text(
                            "💪",
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: spXs),
                    GestureDetector(
                      onTap: () {
                        ss("🔥 sent!");
                      },
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: Colors.black.withAlpha(150),
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Text(
                            "🔥",
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                
                SizedBox(width: spSm),
                
                // Send Button
                GestureDetector(
                  onTap: chatMessage.isNotEmpty ? () {
                    setState(() {
                      liveComments.add({
                        "username": "you",
                        "avatar": "https://picsum.photos/50/50?random=99&keyword=user",
                        "message": chatMessage,
                        "time": "now",
                        "isPinned": false
                      });
                      chatMessage = "";
                    });
                    ss("Message sent!");
                  } : null,
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: chatMessage.isNotEmpty 
                          ? primaryColor 
                          : Colors.black.withAlpha(100),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.send,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
