import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlStory7View extends StatefulWidget {
  @override
  State<GrlStory7View> createState() => _GrlStory7ViewState();
}

class _GrlStory7ViewState extends State<GrlStory7View> {
  String questionText = "";
  bool isSubmitted = false;
  int responseCount = 0;

  List<Map<String, dynamic>> questionResponses = [
    {
      "username": "creative_mind",
      "avatar": "https://picsum.photos/50/50?random=40&keyword=artist",
      "response": "Always start with a mood board! It helps me visualize the concept before diving into the actual work 🎨",
      "time": "2m ago",
      "likes": 12
    },
    {
      "username": "design_guru",
      "avatar": "https://picsum.photos/50/50?random=41&keyword=designer",
      "response": "I like to sketch everything on paper first. There's something magical about the pen-to-paper process ✏️",
      "time": "5m ago",
      "likes": 8
    },
    {
      "username": "art_enthusiast",
      "avatar": "https://picsum.photos/50/50?random=42&keyword=painter",
      "response": "Music is my biggest inspiration! I create different playlists for different types of projects 🎵",
      "time": "8m ago",
      "likes": 15
    },
  ];

  List<Map<String, dynamic>> suggestedQuestions = [
    {"text": "What's your favorite creative tool?"},
    {"text": "How do you overcome creative blocks?"},
    {"text": "What inspires you the most?"},
    {"text": "Any tips for beginners?"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // Background Image with Overlay
          Container(
            width: double.infinity,
            height: double.infinity,
            child: Image.network(
              "https://picsum.photos/400/800?random=200&keyword=art",
              fit: BoxFit.cover,
            ),
          ),

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
                    "https://picsum.photos/80/80?random=8&keyword=creator"
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "creative_studio",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.help_outline,
                            color: primaryColor,
                            size: 12,
                          ),
                          SizedBox(width: 4),
                          Text(
                            "Ask Me Anything",
                            style: TextStyle(
                              color: primaryColor,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
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

          // Question Sticker/Card
          Positioned(
            top: 150,
            left: spMd,
            right: spMd,
            child: Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusSm),
                boxShadow: [shadowMd],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.quiz,
                        color: primaryColor,
                        size: 24,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "Ask me about my creative process!",
                        style: TextStyle(
                          color: primaryColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "I'm here to answer your questions about art, design, and creativity. What would you like to know?",
                    style: TextStyle(
                      color: disabledBoldColor,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Recent Responses
          Positioned(
            top: 280,
            left: spMd,
            right: spMd,
            bottom: 200,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Recent Questions",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: spSm),
                Expanded(
                  child: ListView.builder(
                    itemCount: questionResponses.length,
                    itemBuilder: (context, index) {
                      final response = questionResponses[index];
                      return Container(
                        margin: EdgeInsets.only(bottom: spSm),
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: Colors.black.withAlpha(150),
                          borderRadius: BorderRadius.circular(radiusXs),
                          border: Border.all(
                            color: Colors.white.withAlpha(30),
                            width: 1,
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                CircleAvatar(
                                  radius: 12,
                                  backgroundImage: NetworkImage(
                                    "${response["avatar"]}"
                                  ),
                                ),
                                SizedBox(width: spSm),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "${response["username"]}",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12,
                                        ),
                                      ),
                                      Text(
                                        "${response["time"]}",
                                        style: TextStyle(
                                          color: Colors.white.withAlpha(150),
                                          fontSize: 10,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.favorite_border,
                                      color: Colors.white.withAlpha(150),
                                      size: 14,
                                    ),
                                    SizedBox(width: 4),
                                    Text(
                                      "${response["likes"]}",
                                      style: TextStyle(
                                        color: Colors.white.withAlpha(150),
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(height: spXs),
                            Text(
                              "${response["response"]}",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),

          // Question Input Section
          Positioned(
            bottom: 40,
            left: spMd,
            right: spMd,
            child: Column(
              children: [
                // Suggested Questions
                if (!isSubmitted) ...[
                  Container(
                    height: 40,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: suggestedQuestions.length,
                      itemBuilder: (context, index) {
                        final question = suggestedQuestions[index];
                        return Container(
                          margin: EdgeInsets.only(right: spSm),
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                questionText = "${question["text"]}";
                              });
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: spSm,
                                vertical: spXs,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white.withAlpha(20),
                                borderRadius: BorderRadius.circular(radiusLg),
                                border: Border.all(
                                  color: Colors.white.withAlpha(50),
                                  width: 1,
                                ),
                              ),
                              child: Text(
                                "${question["text"]}",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(height: spSm),
                ],
                
                // Question Input
                Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.black.withAlpha(150),
                    borderRadius: BorderRadius.circular(radiusSm),
                    border: Border.all(
                      color: Colors.white.withAlpha(50),
                      width: 1,
                    ),
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: TextField(
                              decoration: InputDecoration(
                                hintText: "Ask me anything about creativity...",
                                hintStyle: TextStyle(
                                  color: Colors.white.withAlpha(150),
                                ),
                                border: InputBorder.none,
                              ),
                              style: TextStyle(color: Colors.white),
                              maxLines: 3,
                              minLines: 1,
                              onChanged: (value) {
                                questionText = value;
                                setState(() {});
                              },
                            ),
                          ),
                          SizedBox(width: spSm),
                          GestureDetector(
                            onTap: questionText.isNotEmpty ? () {
                              setState(() {
                                isSubmitted = true;
                                responseCount++;
                              });
                              ss("Question submitted! You'll get an answer soon.");
                              questionText = "";
                            } : null,
                            child: Container(
                              padding: EdgeInsets.all(spXs),
                              decoration: BoxDecoration(
                                color: questionText.isNotEmpty 
                                    ? primaryColor 
                                    : Colors.white.withAlpha(50),
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
                      
                      if (isSubmitted) ...[
                        SizedBox(height: spSm),
                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: primaryColor.withAlpha(100),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.check_circle,
                                color: Colors.white,
                                size: 16,
                              ),
                              SizedBox(width: spSm),
                              Expanded(
                                child: Text(
                                  "Your question has been submitted! I'll answer it in my next story.",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
                
                SizedBox(height: spSm),
                
                // Question Stats
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.people,
                      color: Colors.white.withAlpha(150),
                      size: 16,
                    ),
                    SizedBox(width: 4),
                    Text(
                      "${responseCount + 47} questions asked",
                      style: TextStyle(
                        color: Colors.white.withAlpha(150),
                        fontSize: 12,
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
}
