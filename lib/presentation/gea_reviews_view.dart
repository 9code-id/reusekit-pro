import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GeaReviewsView extends StatefulWidget {
  const GeaReviewsView({super.key});

  @override
  State<GeaReviewsView> createState() => _GeaReviewsViewState();
}

class _GeaReviewsViewState extends State<GeaReviewsView> {
  String selectedFilter = "All Reviews";
  String selectedSort = "Most Helpful";
  bool showWriteReview = false;
  int userRating = 5;
  String userReviewTitle = "";
  String userReviewContent = "";

  List<String> filterOptions = [
    "All Reviews",
    "5 Stars",
    "4 Stars", 
    "3 Stars",
    "2 Stars",
    "1 Star",
    "Verified Purchase",
    "With Images",
    "Recent"
  ];

  List<String> sortOptions = [
    "Most Helpful",
    "Newest First",
    "Oldest First",
    "Highest Rating",
    "Lowest Rating"
  ];

  Map<String, dynamic> gameRatings = {
    "overallRating": 4.6,
    "totalReviews": 15847,
    "ratingBreakdown": {
      "5": 8240,
      "4": 4210,
      "3": 2156,
      "2": 890,
      "1": 351,
    },
    "verifiedPurchases": 12340,
    "averagePlaytime": "47 hours",
  };

  List<Map<String, dynamic>> reviews = [
    {
      "id": 1,
      "username": "CyberGamer2024",
      "userAvatar": "https://picsum.photos/50/50?random=1&keyword=avatar",
      "rating": 5,
      "title": "Absolutely Mind-Blowing Experience!",
      "content": "This game exceeded every single one of my expectations. The world-building is incredible, the story is emotionally engaging, and the graphics are simply stunning. I've been playing for over 80 hours and I'm still discovering new content, hidden areas, and side quests that feel meaningful to the overall narrative. The character customization is deep and the combat system feels fluid and satisfying. This is what next-gen gaming should be!",
      "date": "2024-05-20",
      "helpful": 2847,
      "notHelpful": 23,
      "verified": true,
      "playtime": "82 hours",
      "platform": "PC",
      "hasImages": true,
      "images": [
        "https://picsum.photos/300/200?random=11&keyword=screenshot",
        "https://picsum.photos/300/200?random=12&keyword=gameplay"
      ],
      "pros": ["Amazing Graphics", "Great Story", "Excellent World Building"],
      "cons": ["Minor Loading Times"],
    },
    {
      "id": 2,
      "username": "RPGMaster",
      "userAvatar": "https://picsum.photos/50/50?random=2&keyword=user",
      "rating": 4,
      "title": "Great Game with Small Issues",
      "content": "Overall this is a fantastic RPG experience. The character progression system is well thought out and the multiple storylines give great replay value. Combat feels responsive and the weapon variety keeps things interesting. I did encounter a few minor bugs early on, but recent patches have addressed most of them. The side quests are actually engaging unlike many other games where they feel like filler.",
      "date": "2024-05-18",
      "helpful": 1923,
      "notHelpful": 67,
      "verified": true,
      "playtime": "56 hours",
      "platform": "PlayStation 5",
      "hasImages": false,
      "images": [],
      "pros": ["Engaging Side Quests", "Good Combat", "Multiple Storylines"],
      "cons": ["Some Bugs", "Steep Learning Curve"],
    },
    {
      "id": 3,
      "username": "TechReviewer99",
      "userAvatar": "https://picsum.photos/50/50?random=3&keyword=profile",
      "rating": 5,
      "title": "Technical Masterpiece",
      "content": "From a technical standpoint, this game is absolutely incredible. The ray tracing implementation is the best I've seen in any game to date. The lighting effects, reflections, and shadows create an immersive atmosphere that pulls you into the world. Performance is solid on my RTX 4080 at 4K with DLSS enabled. The attention to detail in the environmental design is phenomenal.",
      "date": "2024-05-15",
      "helpful": 1456,
      "notHelpful": 12,
      "verified": true,
      "playtime": "34 hours",
      "platform": "PC",
      "hasImages": true,
      "images": [
        "https://picsum.photos/300/200?random=13&keyword=graphics",
        "https://picsum.photos/300/200?random=14&keyword=raytracing"
      ],
      "pros": ["Outstanding Graphics", "Ray Tracing", "Great Performance"],
      "cons": ["High System Requirements"],
    },
    {
      "id": 4,
      "username": "StoryLover",
      "userAvatar": "https://picsum.photos/50/50?random=4&keyword=gamer",
      "rating": 5,
      "title": "Narrative Excellence",
      "content": "The storytelling in this game is absolutely top-tier. Every character feels real and has depth, the dialogue is well-written and never feels forced. The way choices impact the story is meaningful and I found myself genuinely caring about the outcomes. The voice acting is superb across the board. This is how you craft a compelling narrative in an interactive medium.",
      "date": "2024-05-12",
      "helpful": 1789,
      "notHelpful": 34,
      "verified": true,
      "playtime": "67 hours",
      "platform": "Xbox Series X",
      "hasImages": false,
      "images": [],
      "pros": ["Excellent Story", "Great Voice Acting", "Meaningful Choices"],
      "cons": ["Can Be Emotionally Heavy"],
    },
    {
      "id": 5,
      "username": "ActionFan",
      "userAvatar": "https://picsum.photos/50/50?random=5&keyword=player",
      "rating": 4,
      "title": "Solid Action RPG",
      "content": "The combat system is really well designed with a good mix of ranged and melee options. The skill trees are deep and allow for different playstyles. I especially enjoy the stealth mechanics which feel smooth and rewarding. The open world is packed with activities and exploration is satisfying. My only complaint is that some areas can feel a bit repetitive after extended play sessions.",
      "date": "2024-05-10",
      "helpful": 1234,
      "notHelpful": 89,
      "verified": false,
      "playtime": "45 hours",
      "platform": "PC",
      "hasImages": true,
      "images": [
        "https://picsum.photos/300/200?random=15&keyword=combat"
      ],
      "pros": ["Great Combat", "Deep Skill Trees", "Good Stealth"],
      "cons": ["Some Repetitive Areas"],
    },
    {
      "id": 6,
      "username": "CasualPlayer",
      "userAvatar": "https://picsum.photos/50/50?random=6&keyword=casual",
      "rating": 3,
      "title": "Good But Not Perfect",
      "content": "This is a decent game but it didn't quite live up to the massive hype for me. The world is beautiful and there's plenty to do, but I found the learning curve quite steep as someone new to this type of RPG. The tutorial could be better and some systems aren't explained well. That said, once I got the hang of it, I did enjoy my time with it.",
      "date": "2024-05-08",
      "helpful": 892,
      "notHelpful": 156,
      "verified": true,
      "playtime": "23 hours",
      "platform": "PlayStation 5",
      "hasImages": false,
      "images": [],
      "pros": ["Beautiful World", "Lots of Content"],
      "cons": ["Steep Learning Curve", "Poor Tutorial"],
    },
  ];

  List<Map<String, dynamic>> get filteredReviews {
    List<Map<String, dynamic>> result = reviews;

    // Apply filter
    switch (selectedFilter) {
      case "5 Stars":
        result = result.where((review) => review["rating"] == 5).toList();
        break;
      case "4 Stars":
        result = result.where((review) => review["rating"] == 4).toList();
        break;
      case "3 Stars":
        result = result.where((review) => review["rating"] == 3).toList();
        break;
      case "2 Stars":
        result = result.where((review) => review["rating"] == 2).toList();
        break;
      case "1 Star":
        result = result.where((review) => review["rating"] == 1).toList();
        break;
      case "Verified Purchase":
        result = result.where((review) => review["verified"] == true).toList();
        break;
      case "With Images":
        result = result.where((review) => review["hasImages"] == true).toList();
        break;
      case "Recent":
        result = result.where((review) => 
            DateTime.parse(review["date"]).isAfter(DateTime.now().subtract(Duration(days: 7)))).toList();
        break;
    }

    // Apply sorting
    switch (selectedSort) {
      case "Newest First":
        result.sort((a, b) => DateTime.parse(b["date"]).compareTo(DateTime.parse(a["date"])));
        break;
      case "Oldest First":
        result.sort((a, b) => DateTime.parse(a["date"]).compareTo(DateTime.parse(b["date"])));
        break;
      case "Highest Rating":
        result.sort((a, b) => (b["rating"] as int).compareTo(a["rating"] as int));
        break;
      case "Lowest Rating":
        result.sort((a, b) => (a["rating"] as int).compareTo(b["rating"] as int));
        break;
      case "Most Helpful":
      default:
        result.sort((a, b) => (b["helpful"] as int).compareTo(a["helpful"] as int));
        break;
    }

    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Game Reviews"),
        actions: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {
              showWriteReview = true;
              setState(() {});
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            // Overall Rating Summary
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                spacing: spMd,
                children: [
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${gameRatings["overallRating"]}",
                            style: TextStyle(
                              fontSize: 48,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          Row(
                            children: List.generate(5, (index) {
                              return Icon(
                                index < gameRatings["overallRating"] 
                                    ? Icons.star 
                                    : Icons.star_border,
                                color: warningColor,
                                size: 20,
                              );
                            }),
                          ),
                          Text(
                            "${((gameRatings["totalReviews"] as int) / 1000).toStringAsFixed(1)}K reviews",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(width: spLg),
                      Expanded(
                        child: Column(
                          children: [5, 4, 3, 2, 1].map((rating) {
                            final count = gameRatings["ratingBreakdown"]["$rating"] as int;
                            final percentage = (count / (gameRatings["totalReviews"] as int)) * 100;
                            
                            return Padding(
                              padding: EdgeInsets.only(bottom: spXs),
                              child: Row(
                                children: [
                                  Text(
                                    "$rating",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                  SizedBox(width: spXs),
                                  Icon(
                                    Icons.star,
                                    color: warningColor,
                                    size: 12,
                                  ),
                                  SizedBox(width: spSm),
                                  Expanded(
                                    child: Container(
                                      height: 8,
                                      decoration: BoxDecoration(
                                        color: disabledColor,
                                        borderRadius: BorderRadius.circular(radiusSm),
                                      ),
                                      child: FractionallySizedBox(
                                        alignment: Alignment.centerLeft,
                                        widthFactor: percentage / 100,
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: warningColor,
                                            borderRadius: BorderRadius.circular(radiusSm),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: spSm),
                                  Text(
                                    "${percentage.toStringAsFixed(0)}%",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ],
                  ),
                  
                  // Additional Stats
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            Icon(
                              Icons.verified,
                              color: successColor,
                              size: 20,
                            ),
                            SizedBox(height: spXs),
                            Text(
                              "${((gameRatings["verifiedPurchases"] as int) / 1000).toStringAsFixed(1)}K",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: successColor,
                              ),
                            ),
                            Text(
                              "Verified Purchases",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            Icon(
                              Icons.schedule,
                              color: infoColor,
                              size: 20,
                            ),
                            SizedBox(height: spXs),
                            Text(
                              "${gameRatings["averagePlaytime"]}",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: infoColor,
                              ),
                            ),
                            Text(
                              "Average Playtime",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Write Review Section
            if (showWriteReview) ...[
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spSm,
                  children: [
                    Row(
                      children: [
                        Text(
                          "Write Your Review",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Spacer(),
                        GestureDetector(
                          onTap: () {
                            showWriteReview = false;
                            setState(() {});
                          },
                          child: Icon(
                            Icons.close,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                    
                    // Rating Selection
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Your Rating",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: primaryColor,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Row(
                          children: List.generate(5, (index) {
                            return GestureDetector(
                              onTap: () {
                                userRating = index + 1;
                                setState(() {});
                              },
                              child: Icon(
                                index < userRating ? Icons.star : Icons.star_border,
                                color: warningColor,
                                size: 32,
                              ),
                            );
                          }),
                        ),
                      ],
                    ),

                    QTextField(
                      label: "Review Title",
                      value: userReviewTitle,
                      hint: "Sum up your experience in a few words",
                      onChanged: (value) {
                        userReviewTitle = value;
                        setState(() {});
                      },
                    ),

                    QMemoField(
                      label: "Your Review",
                      value: userReviewContent,
                      hint: "Tell others about your experience with this game",
                      onChanged: (value) {
                        userReviewContent = value;
                        setState(() {});
                      },
                    ),

                    Row(
                      children: [
                        Expanded(
                          child: QButton(
                            label: "Cancel",
                            size: bs.sm,
                            onPressed: () {
                              showWriteReview = false;
                              setState(() {});
                            },
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: QButton(
                            label: "Submit Review",
                            size: bs.sm,
                            onPressed: () {
                              if (userReviewTitle.isNotEmpty && userReviewContent.isNotEmpty) {
                                ss("Review submitted successfully!");
                                showWriteReview = false;
                                userReviewTitle = "";
                                userReviewContent = "";
                                setState(() {});
                              } else {
                                se("Please fill in all fields");
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],

            // Filter and Sort
            Row(
              children: [
                Expanded(
                  child: QDropdownField(
                    label: "Filter",
                    items: filterOptions.map((option) => {
                      "label": option,
                      "value": option,
                    }).toList(),
                    value: selectedFilter,
                    onChanged: (value, label) {
                      selectedFilter = value;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QDropdownField(
                    label: "Sort By",
                    items: sortOptions.map((option) => {
                      "label": option,
                      "value": option,
                    }).toList(),
                    value: selectedSort,
                    onChanged: (value, label) {
                      selectedSort = value;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),

            // Reviews List
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "User Reviews (${filteredReviews.length})",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spSm),
                ...filteredReviews.map((review) {
                  return Container(
                    margin: EdgeInsets.only(bottom: spMd),
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusMd),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: spSm,
                      children: [
                        // User Info and Rating
                        Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(radiusLg),
                              child: Image.network(
                                "${review["userAvatar"]}",
                                width: 50,
                                height: 50,
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
                                      Text(
                                        "${review["username"]}",
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: primaryColor,
                                        ),
                                      ),
                                      if (review["verified"] == true) ...[
                                        SizedBox(width: spXs),
                                        Icon(
                                          Icons.verified,
                                          color: successColor,
                                          size: 16,
                                        ),
                                      ],
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      ...List.generate(5, (index) {
                                        return Icon(
                                          index < (review["rating"] as int) 
                                              ? Icons.star 
                                              : Icons.star_border,
                                          color: warningColor,
                                          size: 16,
                                        );
                                      }),
                                      SizedBox(width: spSm),
                                      Text(
                                        "${review["date"]} • ${review["platform"]}",
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
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  "${review["playtime"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: primaryColor,
                                  ),
                                ),
                                Text(
                                  "playtime",
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),

                        // Review Title
                        Text(
                          "${review["title"]}",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),

                        // Review Content
                        Text(
                          "${review["content"]}",
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                            height: 1.5,
                          ),
                        ),

                        // Pros and Cons
                        if ((review["pros"] as List).isNotEmpty || (review["cons"] as List).isNotEmpty) ...[
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if ((review["pros"] as List).isNotEmpty)
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Pros:",
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          color: successColor,
                                        ),
                                      ),
                                      ...(review["pros"] as List<String>).map((pro) {
                                        return Padding(
                                          padding: EdgeInsets.only(left: spSm),
                                          child: Text(
                                            "• $pro",
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: successColor,
                                            ),
                                          ),
                                        );
                                      }),
                                    ],
                                  ),
                                ),
                              if ((review["cons"] as List).isNotEmpty) ...[
                                SizedBox(width: spMd),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Cons:",
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          color: dangerColor,
                                        ),
                                      ),
                                      ...(review["cons"] as List<String>).map((con) {
                                        return Padding(
                                          padding: EdgeInsets.only(left: spSm),
                                          child: Text(
                                            "• $con",
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: dangerColor,
                                            ),
                                          ),
                                        );
                                      }),
                                    ],
                                  ),
                                ),
                              ],
                            ],
                          ),
                        ],

                        // Review Images
                        if (review["hasImages"] == true && (review["images"] as List).isNotEmpty) ...[
                          QHorizontalScroll(
                            children: (review["images"] as List<String>).map((imageUrl) {
                              return Container(
                                width: 150,
                                height: 100,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(radiusSm),
                                  boxShadow: [shadowSm],
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(radiusSm),
                                  child: Image.network(
                                    imageUrl,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        ],

                        // Helpful Actions
                        Row(
                          children: [
                            Text(
                              "Was this helpful?",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                            SizedBox(width: spSm),
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: spSm,
                                vertical: spXs,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(radiusSm),
                                border: Border.all(
                                  color: disabledOutlineBorderColor,
                                  width: 1,
                                ),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    Icons.thumb_up,
                                    size: 16,
                                    color: disabledBoldColor,
                                  ),
                                  SizedBox(width: spXs),
                                  Text(
                                    "${review["helpful"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(width: spSm),
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: spSm,
                                vertical: spXs,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(radiusSm),
                                border: Border.all(
                                  color: disabledOutlineBorderColor,
                                  width: 1,
                                ),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    Icons.thumb_down,
                                    size: 16,
                                    color: disabledBoldColor,
                                  ),
                                  SizedBox(width: spXs),
                                  Text(
                                    "${review["notHelpful"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Spacer(),
                            GestureDetector(
                              onTap: () {
                                si("Review reported");
                              },
                              child: Text(
                                "Report",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: dangerColor,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                }),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
