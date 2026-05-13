import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class FwaWellnessTipsView extends StatefulWidget {
  const FwaWellnessTipsView({super.key});

  @override
  State<FwaWellnessTipsView> createState() => _FwaWellnessTipsViewState();
}

class _FwaWellnessTipsViewState extends State<FwaWellnessTipsView> {
  int selectedCategory = 0;
  String searchQuery = "";
  List<String> bookmarkedTips = [];
  
  final List<Map<String, dynamic>> categories = [
    {"label": "All", "value": "all", "icon": Icons.all_inclusive},
    {"label": "Nutrition", "value": "nutrition", "icon": Icons.restaurant},
    {"label": "Exercise", "value": "exercise", "icon": Icons.fitness_center},
    {"label": "Mental Health", "value": "mental", "icon": Icons.psychology},
    {"label": "Sleep", "value": "sleep", "icon": Icons.bedtime},
    {"label": "Stress", "value": "stress", "icon": Icons.spa},
  ];

  final List<Map<String, dynamic>> tips = [
    {
      "id": 1,
      "title": "Start Your Day with Hydration",
      "category": "nutrition",
      "content": "Drink a glass of water immediately after waking up to kickstart your metabolism and help flush out toxins that accumulated overnight.",
      "benefits": ["Boosts metabolism", "Improves brain function", "Aids digestion"],
      "timeToRead": 2,
      "difficulty": "Easy",
      "author": "Dr. Sarah Johnson",
      "tags": ["hydration", "morning", "metabolism"],
      "image": "https://picsum.photos/300/200?random=1&keyword=water",
      "likes": 1245,
      "isBookmarked": false,
    },
    {
      "id": 2,
      "title": "The 20-20-20 Rule for Eye Health",
      "category": "mental",
      "content": "Every 20 minutes, look at something 20 feet away for at least 20 seconds. This simple practice reduces eye strain from screen time.",
      "benefits": ["Reduces eye strain", "Prevents dry eyes", "Improves focus"],
      "timeToRead": 1,
      "difficulty": "Easy",
      "author": "Dr. Michael Chen",
      "tags": ["eye health", "screen time", "productivity"],
      "image": "https://picsum.photos/300/200?random=2&keyword=eye",
      "likes": 892,
      "isBookmarked": true,
    },
    {
      "id": 3,
      "title": "Power of 7-Minute Workouts",
      "category": "exercise",
      "content": "High-intensity circuit training for just 7 minutes can provide benefits similar to longer workouts. Perfect for busy schedules!",
      "benefits": ["Time efficient", "Improves cardiovascular health", "Builds strength"],
      "timeToRead": 3,
      "difficulty": "Moderate",
      "author": "Fitness Coach Emma",
      "tags": ["HIIT", "quick workout", "busy schedule"],
      "image": "https://picsum.photos/300/200?random=3&keyword=workout",
      "likes": 2156,
      "isBookmarked": false,
    },
    {
      "id": 4,
      "title": "Create a Sleep Sanctuary",
      "category": "sleep",
      "content": "Keep your bedroom cool (65-68°F), dark, and quiet. Remove electronic devices and invest in comfortable bedding for optimal sleep quality.",
      "benefits": ["Better sleep quality", "Faster sleep onset", "Deeper rest"],
      "timeToRead": 4,
      "difficulty": "Easy",
      "author": "Sleep Specialist Dr. Lisa",
      "tags": ["sleep hygiene", "bedroom", "rest"],
      "image": "https://picsum.photos/300/200?random=4&keyword=bedroom",
      "likes": 1687,
      "isBookmarked": true,
    },
    {
      "id": 5,
      "title": "Mindful Eating Practice",
      "category": "nutrition",
      "content": "Eat slowly and pay attention to flavors, textures, and your body's hunger cues. This improves digestion and prevents overeating.",
      "benefits": ["Better digestion", "Weight management", "Increased satisfaction"],
      "timeToRead": 3,
      "difficulty": "Moderate",
      "author": "Nutritionist Amy",
      "tags": ["mindful eating", "digestion", "awareness"],
      "image": "https://picsum.photos/300/200?random=5&keyword=food",
      "likes": 934,
      "isBookmarked": false,
    },
    {
      "id": 6,
      "title": "Progressive Muscle Relaxation",
      "category": "stress",
      "content": "Systematically tense and release muscle groups to reduce physical tension and promote deep relaxation. Start with your toes and work upward.",
      "benefits": ["Reduces muscle tension", "Lowers stress", "Improves sleep"],
      "timeToRead": 5,
      "difficulty": "Moderate",
      "author": "Therapist Dr. Mark",
      "tags": ["relaxation", "tension", "stress relief"],
      "image": "https://picsum.photos/300/200?random=6&keyword=relaxation",
      "likes": 1423,
      "isBookmarked": false,
    },
    {
      "id": 7,
      "title": "Walking Meditation Benefits",
      "category": "mental",
      "content": "Combine gentle movement with mindfulness. Focus on each step, your breathing, and surroundings to calm your mind while staying active.",
      "benefits": ["Combines exercise and meditation", "Reduces anxiety", "Improves focus"],
      "timeToRead": 3,
      "difficulty": "Easy",
      "author": "Mindfulness Coach John",
      "tags": ["walking", "meditation", "mindfulness"],
      "image": "https://picsum.photos/300/200?random=7&keyword=walking",
      "likes": 1156,
      "isBookmarked": true,
    },
    {
      "id": 8,
      "title": "Strength Training Basics",
      "category": "exercise",
      "content": "Start with bodyweight exercises like push-ups, squats, and planks. Aim for 2-3 sessions per week to build lean muscle and bone density.",
      "benefits": ["Builds muscle", "Increases bone density", "Boosts metabolism"],
      "timeToRead": 4,
      "difficulty": "Moderate",
      "author": "Personal Trainer Mike",
      "tags": ["strength training", "bodyweight", "muscle"],
      "image": "https://picsum.photos/300/200?random=8&keyword=strength",
      "likes": 1789,
      "isBookmarked": false,
    },
  ];

  List<Map<String, dynamic>> get filteredTips {
    return tips.where((tip) {
      bool matchesCategory = selectedCategory == 0 || 
        tip["category"] == categories[selectedCategory]["value"];
      bool matchesSearch = searchQuery.isEmpty ||
        tip["title"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
        tip["content"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
        (tip["tags"] as List).any((tag) => tag.toString().toLowerCase().contains(searchQuery.toLowerCase()));
      return matchesCategory && matchesSearch;
    }).toList();
  }

  Color getDifficultyColor(String difficulty) {
    switch (difficulty) {
      case "Easy":
        return successColor;
      case "Moderate":
        return warningColor;
      case "Hard":
        return dangerColor;
      default:
        return primaryColor;
    }
  }

  void toggleBookmark(int tipId) {
    setState(() {
      if (bookmarkedTips.contains(tipId.toString())) {
        bookmarkedTips.remove(tipId.toString());
      } else {
        bookmarkedTips.add(tipId.toString());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Wellness Tips"),
        actions: [
          IconButton(
            icon: Icon(Icons.bookmark),
            onPressed: () {
              // Navigate to bookmarked tips
            },
          ),
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              // Refresh tips
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Welcome Header
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [primaryColor, primaryColor.withAlpha(180)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(radiusMd),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Daily Wellness Tips",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: spSm),
                        Text(
                          "Small steps lead to big changes",
                          style: TextStyle(
                            color: Colors.white.withAlpha(200),
                            fontSize: 16,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "Discover actionable tips to improve your wellness journey",
                          style: TextStyle(
                            color: Colors.white.withAlpha(180),
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Icon(
                    Icons.lightbulb,
                    color: Colors.white,
                    size: 40,
                  ),
                ],
              ),
            ),
            
            SizedBox(height: spMd),
            
            // Search Bar
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: TextField(
                decoration: InputDecoration(
                  hintText: "Search wellness tips...",
                  prefixIcon: Icon(Icons.search, color: disabledBoldColor),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(horizontal: spMd, vertical: spMd),
                ),
                onChanged: (value) {
                  searchQuery = value;
                  setState(() {});
                },
              ),
            ),
            
            SizedBox(height: spMd),
            
            // Category Filter
            Text(
              "Categories",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
              ),
            ),
            
            SizedBox(height: spSm),
            
            QHorizontalScroll(
              children: categories.asMap().entries.map((entry) {
                int index = entry.key;
                Map<String, dynamic> category = entry.value;
                bool isSelected = selectedCategory == index;
                
                return GestureDetector(
                  onTap: () {
                    selectedCategory = index;
                    setState(() {});
                  },
                  child: Container(
                    margin: EdgeInsets.only(right: spMd),
                    padding: EdgeInsets.symmetric(horizontal: spMd, vertical: spSm),
                    decoration: BoxDecoration(
                      color: isSelected ? primaryColor : Colors.white,
                      borderRadius: BorderRadius.circular(radiusLg),
                      boxShadow: [shadowSm],
                      border: isSelected 
                          ? null 
                          : Border.all(color: Colors.grey[300]!),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          category["icon"],
                          color: isSelected ? Colors.white : primaryColor,
                          size: 20,
                        ),
                        SizedBox(width: spSm),
                        Text(
                          "${category["label"]}",
                          style: TextStyle(
                            color: isSelected ? Colors.white : primaryColor,
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
            
            SizedBox(height: spMd),
            
            // Tips Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Wellness Tips (${filteredTips.length})",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    // Show sort options
                  },
                  child: Row(
                    children: [
                      Icon(Icons.sort, size: 20, color: primaryColor),
                      SizedBox(width: spXs),
                      Text(
                        "Sort",
                        style: TextStyle(
                          color: primaryColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            
            SizedBox(height: spMd),
            
            // Tips List
            ...filteredTips.map((tip) {
              bool isBookmarked = bookmarkedTips.contains(tip["id"].toString());
              
              return Container(
                margin: EdgeInsets.only(bottom: spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Tip Image
                    ClipRRect(
                      borderRadius: BorderRadius.vertical(top: Radius.circular(radiusMd)),
                      child: Stack(
                        children: [
                          Image.network(
                            "${tip["image"]}",
                            width: double.infinity,
                            height: 150,
                            fit: BoxFit.cover,
                          ),
                          Positioned(
                            top: spSm,
                            right: spSm,
                            child: GestureDetector(
                              onTap: () => toggleBookmark(tip["id"]),
                              child: Container(
                                padding: EdgeInsets.all(spSm),
                                decoration: BoxDecoration(
                                  color: Colors.black.withAlpha(150),
                                  borderRadius: BorderRadius.circular(radiusLg),
                                ),
                                child: Icon(
                                  isBookmarked ? Icons.bookmark : Icons.bookmark_border,
                                  color: Colors.white,
                                  size: 20,
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            top: spSm,
                            left: spSm,
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                              decoration: BoxDecoration(
                                color: getDifficultyColor(tip["difficulty"]),
                                borderRadius: BorderRadius.circular(radiusLg),
                              ),
                              child: Text(
                                "${tip["difficulty"]}",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    
                    // Tip Content
                    Padding(
                      padding: EdgeInsets.all(spMd),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  "${tip["title"]}",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Row(
                                children: [
                                  Icon(Icons.access_time, size: 16, color: disabledBoldColor),
                                  SizedBox(width: spXs),
                                  Text(
                                    "${tip["timeToRead"]} min read",
                                    style: TextStyle(
                                      color: disabledBoldColor,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          
                          SizedBox(height: spXs),
                          
                          Text(
                            "by ${tip["author"]}",
                            style: TextStyle(
                              color: primaryColor,
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          
                          SizedBox(height: spMd),
                          
                          Text(
                            "${tip["content"]}",
                            style: TextStyle(
                              color: disabledBoldColor,
                              fontSize: 14,
                              height: 1.5,
                            ),
                          ),
                          
                          SizedBox(height: spMd),
                          
                          // Benefits
                          if ((tip["benefits"] as List).isNotEmpty) ...[
                            Text(
                              "Benefits:",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: spSm),
                            ...(tip["benefits"] as List).map((benefit) => Padding(
                              padding: EdgeInsets.only(bottom: spXs),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(top: 6, right: spSm),
                                    width: 6,
                                    height: 6,
                                    decoration: BoxDecoration(
                                      color: successColor,
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(
                                      "$benefit",
                                      style: TextStyle(
                                        color: disabledBoldColor,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )).toList(),
                            
                            SizedBox(height: spMd),
                          ],
                          
                          // Tags
                          Wrap(
                            spacing: spXs,
                            runSpacing: spXs,
                            children: (tip["tags"] as List).map((tag) => Container(
                              padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                              decoration: BoxDecoration(
                                color: primaryColor.withAlpha(25),
                                borderRadius: BorderRadius.circular(radiusLg),
                                border: Border.all(color: primaryColor.withAlpha(50)),
                              ),
                              child: Text(
                                "#$tag",
                                style: TextStyle(
                                  color: primaryColor,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            )).toList(),
                          ),
                          
                          SizedBox(height: spMd),
                          
                          // Actions
                          Row(
                            children: [
                              Expanded(
                                child: Row(
                                  children: [
                                    Icon(Icons.favorite_border, size: 20, color: disabledBoldColor),
                                    SizedBox(width: spXs),
                                    Text(
                                      "${tip["likes"]} likes",
                                      style: TextStyle(
                                        color: disabledBoldColor,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              QButton(
                                icon: Icons.share,
                                size: bs.sm,
                                onPressed: () {
                                  // Share tip
                                },
                              ),
                              SizedBox(width: spSm),
                              QButton(
                                label: "Try It",
                                size: bs.sm,
                                onPressed: () {
                                  // Start tip implementation
                                },
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
            
            // Load More Button
            if (filteredTips.length >= 8)
              Container(
                width: double.infinity,
                child: QButton(
                  label: "Load More Tips",
                  size: bs.md,
                  onPressed: () {
                    // Load more tips
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}
