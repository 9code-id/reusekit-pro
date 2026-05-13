import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class MhaHealthTipsView extends StatefulWidget {
  const MhaHealthTipsView({super.key});

  @override
  State<MhaHealthTipsView> createState() => _MhaHealthTipsViewState();
}

class _MhaHealthTipsViewState extends State<MhaHealthTipsView> {
  List<Map<String, dynamic>> healthTips = [
    {
      "id": 1,
      "title": "Stay Hydrated Throughout the Day",
      "category": "Nutrition",
      "content": "Drink at least 8 glasses of water daily. Proper hydration helps maintain energy levels, supports digestion, and keeps your skin healthy. Carry a water bottle with you as a reminder.",
      "difficulty": "Easy",
      "timeRequired": "All day",
      "benefits": ["Better energy", "Improved skin", "Better digestion", "Temperature regulation"],
      "image": "https://picsum.photos/300/200?random=1&keyword=water",
      "isBookmarked": true,
      "views": 1250,
      "likes": 89,
      "publishedDate": "2024-12-15",
      "author": "Dr. Sarah Wilson",
      "tags": ["hydration", "daily habits", "wellness"],
    },
    {
      "id": 2,
      "title": "The 7-Minute Morning Workout",
      "category": "Fitness",
      "content": "Start your day with a quick 7-minute workout. Include jumping jacks, wall sits, push-ups, crunches, and planks. This boosts metabolism and energy for the entire day.",
      "difficulty": "Medium",
      "timeRequired": "7 minutes",
      "benefits": ["Increased energy", "Better mood", "Improved metabolism", "Strength building"],
      "image": "https://picsum.photos/300/200?random=2&keyword=exercise",
      "isBookmarked": false,
      "views": 2150,
      "likes": 156,
      "publishedDate": "2024-12-14",
      "author": "Mike Chen, Fitness Trainer",
      "tags": ["exercise", "morning routine", "quick workout"],
    },
    {
      "id": 3,
      "title": "Practice Deep Breathing for Stress Relief",
      "category": "Mental Health",
      "content": "Use the 4-7-8 breathing technique: Inhale for 4 counts, hold for 7 counts, exhale for 8 counts. Repeat 3-4 times to reduce stress and anxiety instantly.",
      "difficulty": "Easy",
      "timeRequired": "5 minutes",
      "benefits": ["Reduced stress", "Lower anxiety", "Better focus", "Improved sleep"],
      "image": "https://picsum.photos/300/200?random=3&keyword=meditation",
      "isBookmarked": true,
      "views": 980,
      "likes": 73,
      "publishedDate": "2024-12-13",
      "author": "Dr. Emily Rodriguez",
      "tags": ["breathing", "stress relief", "mindfulness"],
    },
    {
      "id": 4,
      "title": "Create a Consistent Sleep Schedule",
      "category": "Sleep",
      "content": "Go to bed and wake up at the same time every day, even on weekends. This helps regulate your circadian rhythm and improves sleep quality and duration.",
      "difficulty": "Medium",
      "timeRequired": "Ongoing",
      "benefits": ["Better sleep quality", "More energy", "Improved mood", "Better immunity"],
      "image": "https://picsum.photos/300/200?random=4&keyword=sleep",
      "isBookmarked": false,
      "views": 1890,
      "likes": 134,
      "publishedDate": "2024-12-12",
      "author": "Dr. David Park, Sleep Specialist",
      "tags": ["sleep hygiene", "routine", "circadian rhythm"],
    },
    {
      "id": 5,
      "title": "Eat More Colorful Vegetables",
      "category": "Nutrition",
      "content": "Include vegetables of different colors in every meal. Each color provides different nutrients: red (lycopene), orange (beta-carotene), green (chlorophyll), purple (anthocyanins).",
      "difficulty": "Easy",
      "timeRequired": "Each meal",
      "benefits": ["Better nutrition", "Antioxidants", "Improved immunity", "Disease prevention"],
      "image": "https://picsum.photos/300/200?random=5&keyword=vegetables",
      "isBookmarked": true,
      "views": 1456,
      "likes": 102,
      "publishedDate": "2024-12-11",
      "author": "Lisa Thompson, Nutritionist",
      "tags": ["nutrition", "vegetables", "antioxidants"],
    },
    {
      "id": 6,
      "title": "Take Walking Breaks Every Hour",
      "category": "Fitness",
      "content": "If you have a desk job, take a 2-3 minute walking break every hour. This improves circulation, reduces back pain, and helps maintain focus and productivity.",
      "difficulty": "Easy",
      "timeRequired": "2-3 minutes",
      "benefits": ["Better circulation", "Reduced back pain", "Improved focus", "Better posture"],
      "image": "https://picsum.photos/300/200?random=6&keyword=walking",
      "isBookmarked": false,
      "views": 876,
      "likes": 65,
      "publishedDate": "2024-12-10",
      "author": "Dr. Michael Johnson",
      "tags": ["movement", "desk job", "circulation"],
    },
  ];

  String selectedCategory = "All";
  String selectedDifficulty = "All";
  String searchQuery = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Health Tips"),
        actions: [
          IconButton(
            icon: Icon(Icons.bookmark),
            onPressed: () {
              _showBookmarkedTips();
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            _buildSearchBar(),
            _buildFilterSection(),
            _buildFeaturedTip(),
            _buildTipsList(),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchBar() {
    return Row(
      children: [
        Expanded(
          child: QTextField(
            label: "Search health tips...",
            value: searchQuery,
            hint: "Type keywords to search",
            onChanged: (value) {
              searchQuery = value;
              setState(() {});
            },
          ),
        ),
        SizedBox(width: spSm),
        QButton(
          icon: Icons.search,
          size: bs.sm,
          onPressed: () {
            // Perform search
          },
        ),
      ],
    );
  }

  Widget _buildFilterSection() {
    return Row(
      children: [
        Expanded(
          child: QDropdownField(
            label: "Category",
            items: [
              {"label": "All Categories", "value": "All"},
              {"label": "Nutrition", "value": "Nutrition"},
              {"label": "Fitness", "value": "Fitness"},
              {"label": "Mental Health", "value": "Mental Health"},
              {"label": "Sleep", "value": "Sleep"},
            ],
            value: selectedCategory,
            onChanged: (value, label) {
              selectedCategory = value;
              setState(() {});
            },
          ),
        ),
        SizedBox(width: spSm),
        Expanded(
          child: QDropdownField(
            label: "Difficulty",
            items: [
              {"label": "All Levels", "value": "All"},
              {"label": "Easy", "value": "Easy"},
              {"label": "Medium", "value": "Medium"},
              {"label": "Hard", "value": "Hard"},
            ],
            value: selectedDifficulty,
            onChanged: (value, label) {
              selectedDifficulty = value;
              setState(() {});
            },
          ),
        ),
      ],
    );
  }

  Widget _buildFeaturedTip() {
    var featuredTip = healthTips.first;
    Color categoryColor = _getCategoryColor(featuredTip["category"]);

    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowMd],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(radiusMd)),
                child: Image.network(
                  "${featuredTip["image"]}",
                  height: 180,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                top: spSm,
                left: spSm,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                  decoration: BoxDecoration(
                    color: primaryColor,
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Text(
                    "FEATURED",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Positioned(
                top: spSm,
                right: spSm,
                child: GestureDetector(
                  onTap: () {
                    featuredTip["isBookmarked"] = !featuredTip["isBookmarked"];
                    setState(() {});
                  },
                  child: Container(
                    padding: EdgeInsets.all(spXs),
                    decoration: BoxDecoration(
                      color: Colors.black.withAlpha(100),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Icon(
                      featuredTip["isBookmarked"] ? Icons.bookmark : Icons.bookmark_border,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.all(spSm),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spSm,
              children: [
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                      decoration: BoxDecoration(
                        color: categoryColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Text(
                        "${featuredTip["category"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: categoryColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    SizedBox(width: spSm),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                      decoration: BoxDecoration(
                        color: _getDifficultyColor(featuredTip["difficulty"]).withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Text(
                        "${featuredTip["difficulty"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: _getDifficultyColor(featuredTip["difficulty"]),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                Text(
                  "${featuredTip["title"]}",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "${featuredTip["content"]}",
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                  ),
                ),
                Row(
                  children: [
                    Icon(Icons.schedule, size: 16, color: disabledBoldColor),
                    SizedBox(width: spXs),
                    Text(
                      "${featuredTip["timeRequired"]}",
                      style: TextStyle(fontSize: 12, color: disabledBoldColor),
                    ),
                    SizedBox(width: spSm),
                    Icon(Icons.visibility, size: 16, color: disabledBoldColor),
                    SizedBox(width: spXs),
                    Text(
                      "${featuredTip["views"]}",
                      style: TextStyle(fontSize: 12, color: disabledBoldColor),
                    ),
                    SizedBox(width: spSm),
                    Icon(Icons.thumb_up, size: 16, color: disabledBoldColor),
                    SizedBox(width: spXs),
                    Text(
                      "${featuredTip["likes"]}",
                      style: TextStyle(fontSize: 12, color: disabledBoldColor),
                    ),
                  ],
                ),
                Container(
                  width: double.infinity,
                  child: QButton(
                    label: "Read Full Tip",
                    size: bs.sm,
                    onPressed: () {
                      _showTipDetail(featuredTip);
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTipsList() {
    var filteredTips = healthTips.skip(1).toList(); // Skip featured tip
    
    if (selectedCategory != "All") {
      filteredTips = filteredTips.where((tip) => tip["category"] == selectedCategory).toList();
    }
    
    if (selectedDifficulty != "All") {
      filteredTips = filteredTips.where((tip) => tip["difficulty"] == selectedDifficulty).toList();
    }
    
    if (searchQuery.isNotEmpty) {
      filteredTips = filteredTips.where((tip) => 
        tip["title"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
        tip["content"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
        (tip["tags"] as List).any((tag) => tag.toString().toLowerCase().contains(searchQuery.toLowerCase()))
      ).toList();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: spSm,
      children: [
        Text(
          "More Health Tips",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        ...filteredTips.map((tip) => _buildTipItem(tip)).toList(),
      ],
    );
  }

  Widget _buildTipItem(Map<String, dynamic> tip) {
    Color categoryColor = _getCategoryColor(tip["category"]);

    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
        border: Border(
          left: BorderSide(
            width: 4,
            color: categoryColor,
          ),
        ),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(radiusSm),
            child: Image.network(
              "${tip["image"]}",
              height: 80,
              width: 80,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spXs,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        "${tip["title"]}",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        tip["isBookmarked"] = !tip["isBookmarked"];
                        setState(() {});
                      },
                      child: Icon(
                        tip["isBookmarked"] ? Icons.bookmark : Icons.bookmark_border,
                        color: tip["isBookmarked"] ? primaryColor : disabledBoldColor,
                        size: 20,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                      decoration: BoxDecoration(
                        color: categoryColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Text(
                        "${tip["category"]}",
                        style: TextStyle(
                          fontSize: 10,
                          color: categoryColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    SizedBox(width: spXs),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                      decoration: BoxDecoration(
                        color: _getDifficultyColor(tip["difficulty"]).withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Text(
                        "${tip["difficulty"]}",
                        style: TextStyle(
                          fontSize: 10,
                          color: _getDifficultyColor(tip["difficulty"]),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                Text(
                  "${tip["content"]}",
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
                Row(
                  children: [
                    Icon(Icons.schedule, size: 12, color: disabledBoldColor),
                    SizedBox(width: spXs),
                    Text(
                      "${tip["timeRequired"]}",
                      style: TextStyle(fontSize: 10, color: disabledBoldColor),
                    ),
                    SizedBox(width: spSm),
                    Icon(Icons.thumb_up, size: 12, color: disabledBoldColor),
                    SizedBox(width: spXs),
                    Text(
                      "${tip["likes"]}",
                      style: TextStyle(fontSize: 10, color: disabledBoldColor),
                    ),
                    Spacer(),
                    GestureDetector(
                      onTap: () => _showTipDetail(tip),
                      child: Text(
                        "Read more",
                        style: TextStyle(
                          fontSize: 12,
                          color: primaryColor,
                          fontWeight: FontWeight.w600,
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
    );
  }

  Color _getCategoryColor(String category) {
    switch (category) {
      case "Nutrition": return successColor;
      case "Fitness": return primaryColor;
      case "Mental Health": return infoColor;
      case "Sleep": return Color(0xFF9C27B0);
      default: return primaryColor;
    }
  }

  Color _getDifficultyColor(String difficulty) {
    switch (difficulty) {
      case "Easy": return successColor;
      case "Medium": return warningColor;
      case "Hard": return dangerColor;
      default: return primaryColor;
    }
  }

  void _showTipDetail(Map<String, dynamic> tip) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.9,
        padding: EdgeInsets.all(spMd),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(radiusLg)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: spSm,
          children: [
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: disabledColor,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(radiusMd),
              child: Image.network(
                "${tip["image"]}",
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            Text(
              "${tip["title"]}",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            Row(
              children: [
                Text(
                  "By ${tip["author"]}",
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                  ),
                ),
                Spacer(),
                Text(
                  "${tip["publishedDate"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spSm,
                  children: [
                    Text(
                      "${tip["content"]}",
                      style: TextStyle(
                        fontSize: 16,
                        color: primaryColor,
                        height: 1.6,
                      ),
                    ),
                    Text(
                      "Benefits:",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    ...(tip["benefits"] as List).map((benefit) => Row(
                      children: [
                        Icon(Icons.check_circle, color: successColor, size: 16),
                        SizedBox(width: spSm),
                        Text(
                          "$benefit",
                          style: TextStyle(fontSize: 14, color: disabledBoldColor),
                        ),
                      ],
                    )).toList(),
                    Text(
                      "Tags:",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Wrap(
                      spacing: spXs,
                      children: (tip["tags"] as List).map((tag) => Container(
                        padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                        decoration: BoxDecoration(
                          color: primaryColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Text(
                          "#$tag",
                          style: TextStyle(
                            fontSize: 12,
                            color: primaryColor,
                          ),
                        ),
                      )).toList(),
                    ),
                  ],
                ),
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: QButton(
                    label: tip["isBookmarked"] ? "Remove Bookmark" : "Bookmark",
                    size: bs.sm,
                    onPressed: () {
                      tip["isBookmarked"] = !tip["isBookmarked"];
                      setState(() {});
                      ss(tip["isBookmarked"] ? "Tip bookmarked!" : "Bookmark removed");
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QButton(
                    label: "Share Tip",
                    size: bs.sm,
                    onPressed: () {
                      ss("Sharing tip...");
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showBookmarkedTips() {
    var bookmarkedTips = healthTips.where((tip) => tip["isBookmarked"] == true).toList();
    
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.8,
        padding: EdgeInsets.all(spMd),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(radiusLg)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: spSm,
          children: [
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: disabledColor,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            Text(
              "Bookmarked Tips",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            Expanded(
              child: bookmarkedTips.isEmpty
                  ? Center(
                      child: Text(
                        "No bookmarked tips yet",
                        style: TextStyle(color: disabledBoldColor),
                      ),
                    )
                  : ListView(
                      children: bookmarkedTips.map((tip) => _buildTipItem(tip)).toList(),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
