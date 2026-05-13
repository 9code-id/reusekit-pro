import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class TtaCulturalExperiencesView extends StatefulWidget {
  const TtaCulturalExperiencesView({super.key});

  @override
  State<TtaCulturalExperiencesView> createState() => _TtaCulturalExperiencesViewState();
}

class _TtaCulturalExperiencesViewState extends State<TtaCulturalExperiencesView> {
  String selectedCategory = "All";
  String selectedDuration = "All";
  String searchQuery = "";

  List<Map<String, dynamic>> categories = [
    {"label": "All", "value": "All", "icon": Icons.explore},
    {"label": "Museums", "value": "Museums", "icon": Icons.museum},
    {"label": "Traditional", "value": "Traditional", "icon": Icons.festival},
    {"label": "Music & Dance", "value": "Music", "icon": Icons.music_note},
    {"label": "Art & Crafts", "value": "Art", "icon": Icons.palette},
    {"label": "Religious", "value": "Religious", "icon": Icons.church},
  ];

  List<Map<String, dynamic>> experiences = [
    {
      "id": 1,
      "title": "Flamenco Tablao Experience",
      "category": "Music",
      "duration": "2.5 hours",
      "price": 89.00,
      "originalPrice": 110.00,
      "rating": 4.9,
      "reviews": 1654,
      "image": "https://picsum.photos/300/200?random=1&keyword=flamenco",
      "description": "Authentic flamenco show in traditional tablao with passion and soul",
      "highlights": ["Live flamenco show", "Traditional venue", "Welcome drink", "Cultural context"],
      "includes": ["Show ticket", "One drink", "Program", "Cultural guide"],
      "venue": "Tablao Flamenco Cordobés",
      "showTimes": ["8:30 PM", "10:30 PM"],
      "languages": ["Spanish", "English"],
      "ageRestriction": "All ages",
      "dressCode": "Smart casual",
      "discount": 19,
      "featured": true,
      "culturalSignificance": "UNESCO Intangible Cultural Heritage",
    },
    {
      "id": 2,
      "title": "Traditional Catalan Cooking Class",
      "category": "Traditional",
      "duration": "4 hours",
      "price": 125.00,
      "originalPrice": 145.00,
      "rating": 4.8,
      "reviews": 892,
      "image": "https://picsum.photos/300/200?random=2&keyword=cooking",
      "description": "Learn authentic Catalan recipes and culinary traditions from local chefs",
      "highlights": ["Hands-on cooking", "Traditional recipes", "Market visit", "Full meal"],
      "includes": ["Ingredients", "Cooking equipment", "Recipes book", "Lunch"],
      "venue": "Barcelona Cooking School",
      "showTimes": ["10:00 AM", "3:00 PM"],
      "languages": ["English", "Spanish", "Catalan"],
      "ageRestriction": "12+",
      "dressCode": "Casual",
      "discount": 14,
      "featured": false,
      "culturalSignificance": "Traditional Catalan cuisine heritage",
    },
    {
      "id": 3,
      "title": "Picasso Museum Private Tour",
      "category": "Museums",
      "duration": "2 hours",
      "price": 165.00,
      "originalPrice": 190.00,
      "rating": 4.7,
      "reviews": 1156,
      "image": "https://picsum.photos/300/200?random=3&keyword=picasso",
      "description": "Exclusive guided tour through Picasso's formative years and masterpieces",
      "highlights": ["Skip-the-line access", "Expert art guide", "Private tour", "Blue Period focus"],
      "includes": ["Museum entry", "Private guide", "Audio system", "Artwork booklet"],
      "venue": "Museu Picasso Barcelona",
      "showTimes": ["10:00 AM", "12:00 PM", "2:00 PM", "4:00 PM"],
      "languages": ["English", "Spanish", "French"],
      "ageRestriction": "All ages",
      "dressCode": "Casual",
      "discount": 13,
      "featured": true,
      "culturalSignificance": "Pablo Picasso's early artistic development",
    },
    {
      "id": 4,
      "title": "Sagrada Familia Sacred Architecture",
      "category": "Religious",
      "duration": "1.5 hours",
      "price": 75.00,
      "originalPrice": 85.00,
      "rating": 4.8,
      "reviews": 3247,
      "image": "https://picsum.photos/300/200?random=4&keyword=sagrada",
      "description": "Spiritual and architectural journey through Gaudí's divine masterpiece",
      "highlights": ["Tower access", "Audio guide", "Sacred symbolism", "Architectural details"],
      "includes": ["Skip-the-line ticket", "Tower access", "Audio guide", "Digital guide"],
      "venue": "Basílica de la Sagrada Família",
      "showTimes": ["9:00 AM", "11:00 AM", "1:00 PM", "3:00 PM", "5:00 PM"],
      "languages": ["Multiple languages", "Audio guide"],
      "ageRestriction": "All ages",
      "dressCode": "Modest dress required",
      "discount": 12,
      "featured": false,
      "culturalSignificance": "UNESCO World Heritage Site",
    },
    {
      "id": 5,
      "title": "Gothic Quarter Storytelling Walk",
      "category": "Traditional",
      "duration": "3 hours",
      "price": 45.00,
      "originalPrice": 55.00,
      "rating": 4.6,
      "reviews": 987,
      "image": "https://picsum.photos/300/200?random=5&keyword=gothic",
      "description": "Medieval legends and stories come alive in Barcelona's oldest neighborhood",
      "highlights": ["Medieval stories", "Hidden corners", "Local legends", "Historical insights"],
      "includes": ["Walking tour", "Storytelling guide", "Historical map", "Photo opportunities"],
      "venue": "Gothic Quarter",
      "showTimes": ["10:00 AM", "3:00 PM", "6:00 PM"],
      "languages": ["English", "Spanish"],
      "ageRestriction": "All ages",
      "dressCode": "Comfortable walking shoes",
      "discount": 18,
      "featured": false,
      "culturalSignificance": "Medieval Barcelona heritage",
    },
    {
      "id": 6,
      "title": "Ceramic Painting Workshop",
      "category": "Art",
      "duration": "3 hours",
      "price": 95.00,
      "originalPrice": 110.00,
      "rating": 4.7,
      "reviews": 542,
      "image": "https://picsum.photos/300/200?random=6&keyword=ceramics",
      "description": "Create your own Catalan-style ceramic piece with traditional techniques",
      "highlights": ["Hands-on workshop", "Traditional techniques", "Personal creation", "Take home piece"],
      "includes": ["Materials", "Tools", "Instruction", "Firing service"],
      "venue": "Barcelona Ceramic Studio",
      "showTimes": ["10:00 AM", "2:00 PM"],
      "languages": ["English", "Spanish"],
      "ageRestriction": "8+",
      "dressCode": "Casual (clothes may get messy)",
      "discount": 14,
      "featured": true,
      "culturalSignificance": "Traditional Catalan ceramic art",
    },
  ];

  List<Map<String, dynamic>> get filteredExperiences {
    return experiences.where((experience) {
      bool categoryMatch = selectedCategory == "All" || experience["category"] == selectedCategory;
      bool searchMatch = searchQuery.isEmpty || 
          experience["title"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
          experience["description"].toString().toLowerCase().contains(searchQuery.toLowerCase());
      return categoryMatch && searchMatch;
    }).toList();
  }

  List<Map<String, dynamic>> get featuredExperiences {
    return experiences.where((experience) => experience["featured"] == true).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cultural Experiences"),
        actions: [
          IconButton(
            icon: Icon(Icons.filter_list),
            onPressed: () {
              _showFilterBottomSheet();
            },
          ),
          IconButton(
            icon: Icon(Icons.info),
            onPressed: () {
              _showCulturalInfo();
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSearchBar(),
            SizedBox(height: spMd),
            _buildCulturalStats(),
            SizedBox(height: spMd),
            _buildCategoryTabs(),
            SizedBox(height: spMd),
            if (featuredExperiences.isNotEmpty) ...[
              _buildSectionTitle("Featured Cultural Experiences", Icons.star),
              SizedBox(height: spSm),
              _buildFeaturedExperiences(),
              SizedBox(height: spMd),
            ],
            _buildSectionTitle("All Experiences (${filteredExperiences.length})", Icons.explore),
            SizedBox(height: spSm),
            _buildExperiencesList(),
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
            label: "Search cultural experiences...",
            value: searchQuery,
            hint: "Enter experience or venue name",
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

  Widget _buildCulturalStats() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [secondaryColor, secondaryColor.withAlpha(204)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(radiusMd),
      ),
      child: Row(
        children: [
          Expanded(
            child: _buildStatItem("${experiences.length}", "Experiences", Icons.explore),
          ),
          Container(
            width: 1,
            height: 40,
            color: Colors.white.withAlpha(76),
          ),
          Expanded(
            child: _buildStatItem("Authentic", "Heritage", Icons.verified),
          ),
          Container(
            width: 1,
            height: 40,
            color: Colors.white.withAlpha(76),
          ),
          Expanded(
            child: _buildStatItem("All Ages", "Welcome", Icons.family_restroom),
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(String value, String label, IconData icon) {
    return Column(
      children: [
        Icon(
          icon,
          color: Colors.white,
          size: 24,
        ),
        SizedBox(height: spXs),
        Text(
          value,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: Colors.white.withAlpha(204),
          ),
        ),
      ],
    );
  }

  Widget _buildCategoryTabs() {
    return QHorizontalScroll(
      children: categories.map((category) {
        bool isSelected = selectedCategory == category["value"];
        return GestureDetector(
          onTap: () {
            selectedCategory = category["value"];
            setState(() {});
          },
          child: Container(
            margin: EdgeInsets.only(right: spSm),
            padding: EdgeInsets.symmetric(horizontal: spMd, vertical: spSm),
            decoration: BoxDecoration(
              color: isSelected ? primaryColor : Colors.white,
              borderRadius: BorderRadius.circular(radiusLg),
              border: Border.all(
                color: isSelected ? primaryColor : disabledOutlineBorderColor,
              ),
              boxShadow: isSelected ? [shadowSm] : [],
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  category["icon"],
                  size: 16,
                  color: isSelected ? Colors.white : disabledBoldColor,
                ),
                SizedBox(width: spXs),
                Text(
                  "${category["label"]}",
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
      }).toList(),
    );
  }

  Widget _buildSectionTitle(String title, IconData icon) {
    return Row(
      children: [
        Icon(
          icon,
          color: primaryColor,
          size: 20,
        ),
        SizedBox(width: spSm),
        Text(
          title,
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
      ],
    );
  }

  Widget _buildFeaturedExperiences() {
    return QHorizontalScroll(
      children: featuredExperiences.map((experience) => Container(
        width: 320,
        margin: EdgeInsets.only(right: spMd),
        child: _buildFeaturedExperienceCard(experience),
      )).toList(),
    );
  }

  Widget _buildFeaturedExperienceCard(Map<String, dynamic> experience) {
    return Container(
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
                  "${experience["image"]}",
                  width: double.infinity,
                  height: 160,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                top: spSm,
                left: spSm,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                  decoration: BoxDecoration(
                    color: warningColor,
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Text(
                    "FEATURED",
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              if ((experience["discount"] as int) > 0)
                Positioned(
                  top: spSm,
                  right: spSm,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                    decoration: BoxDecoration(
                      color: dangerColor,
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Text(
                      "-${experience["discount"]}%",
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
            ],
          ),
          Padding(
            padding: EdgeInsets.all(spMd),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${experience["title"]}",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: spXs),
                Text(
                  "${experience["description"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: spSm),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                  decoration: BoxDecoration(
                    color: infoColor.withAlpha(25),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Text(
                    "${experience["culturalSignificance"]}",
                    style: TextStyle(
                      fontSize: 10,
                      color: infoColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                SizedBox(height: spSm),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if ((experience["originalPrice"] as double) > (experience["price"] as double))
                            Text(
                              "\$${(experience["originalPrice"] as double).currency}",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                                decoration: TextDecoration.lineThrough,
                              ),
                            ),
                          Text(
                            "\$${(experience["price"] as double).currency}",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    QButton(
                      label: "Book",
                      size: bs.sm,
                      onPressed: () {
                        // Navigate to booking
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
  }

  Widget _buildExperiencesList() {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: filteredExperiences.length,
      itemBuilder: (context, index) {
        final experience = filteredExperiences[index];
        return _buildExperienceCard(experience);
      },
    );
  }

  Widget _buildExperienceCard(Map<String, dynamic> experience) {
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
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(radiusMd)),
                child: Image.network(
                  "${experience["image"]}",
                  width: double.infinity,
                  height: 200,
                  fit: BoxFit.cover,
                ),
              ),
              if (experience["featured"] == true)
                Positioned(
                  top: spSm,
                  left: spSm,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                    decoration: BoxDecoration(
                      color: warningColor,
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Text(
                      "FEATURED",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              if ((experience["discount"] as int) > 0)
                Positioned(
                  top: spSm,
                  right: spSm,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                    decoration: BoxDecoration(
                      color: dangerColor,
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Text(
                      "-${experience["discount"]}%",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              Positioned(
                bottom: spSm,
                left: spSm,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                  decoration: BoxDecoration(
                    color: Colors.black.withAlpha(178),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Text(
                    "${experience["venue"]}",
                    style: TextStyle(
                      fontSize: 11,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.all(spMd),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        "${experience["title"]}",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                      decoration: BoxDecoration(
                        color: primaryColor.withAlpha(25),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Text(
                        "${experience["category"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: primaryColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spXs),
                Text(
                  "${experience["description"]}",
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: spMd),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: infoColor.withAlpha(25),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Text(
                    "${experience["culturalSignificance"]}",
                    style: TextStyle(
                      fontSize: 12,
                      color: infoColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                SizedBox(height: spMd),
                Row(
                  children: [
                    Icon(
                      Icons.star,
                      size: 16,
                      color: warningColor,
                    ),
                    SizedBox(width: spXs),
                    Text(
                      "${experience["rating"]}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(width: spXs),
                    Text(
                      "(${experience["reviews"]})",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Spacer(),
                    Icon(
                      Icons.access_time,
                      size: 16,
                      color: disabledBoldColor,
                    ),
                    SizedBox(width: spXs),
                    Text(
                      "${experience["duration"]}",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spMd),
                Row(
                  children: [
                    _buildInfoChip(Icons.schedule, "Multiple times", primaryColor),
                    SizedBox(width: spSm),
                    _buildInfoChip(Icons.language, "${(experience["languages"] as List).length} languages", successColor),
                    SizedBox(width: spSm),
                    _buildInfoChip(Icons.family_restroom, "${experience["ageRestriction"]}", warningColor),
                  ],
                ),
                SizedBox(height: spMd),
                _buildHighlights(experience["highlights"]),
                SizedBox(height: spMd),
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if ((experience["originalPrice"] as double) > (experience["price"] as double))
                          Text(
                            "\$${(experience["originalPrice"] as double).currency}",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                              decoration: TextDecoration.lineThrough,
                            ),
                          ),
                        Text(
                          "\$${(experience["price"] as double).currency}",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "per person",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                    Spacer(),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                          decoration: BoxDecoration(
                            color: successColor.withAlpha(25),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Text(
                            "Available Today",
                            style: TextStyle(
                              fontSize: 12,
                              color: successColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        SizedBox(height: spSm),
                        QButton(
                          label: "Book Experience",
                          size: bs.sm,
                          onPressed: () {
                            // Navigate to booking
                          },
                        ),
                      ],
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

  Widget _buildInfoChip(IconData icon, String text, Color color) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
      decoration: BoxDecoration(
        color: color.withAlpha(25),
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 12,
            color: color,
          ),
          SizedBox(width: spXs),
          Text(
            text,
            style: TextStyle(
              fontSize: 11,
              color: color,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHighlights(List highlights) {
    return Wrap(
      spacing: spXs,
      runSpacing: spXs,
      children: highlights.take(4).map((highlight) => Container(
        padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
        decoration: BoxDecoration(
          color: secondaryColor.withAlpha(25),
          borderRadius: BorderRadius.circular(radiusSm),
        ),
        child: Text(
          highlight,
          style: TextStyle(
            fontSize: 12,
            color: secondaryColor,
            fontWeight: FontWeight.w600,
          ),
        ),
      )).toList(),
    );
  }

  void _showFilterBottomSheet() {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: EdgeInsets.all(spLg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Filter Cultural Experiences",
              style: TextStyle(
                fontSize: fsH5,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spLg),
            Text("Duration"),
            // Add duration filter
            SizedBox(height: spMd),
            Text("Price Range"),
            // Add price range slider
            SizedBox(height: spMd),
            Text("Language"),
            // Add language filter
            SizedBox(height: spMd),
            Text("Age Restrictions"),
            // Add age filter
            SizedBox(height: spLg),
            Row(
              children: [
                Expanded(
                  child: QButton(
                    label: "Clear All",
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QButton(
                    label: "Apply Filters",
                    onPressed: () {
                      Navigator.pop(context);
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

  void _showCulturalInfo() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Cultural Heritage"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Discover Barcelona's rich cultural heritage through authentic experiences:"),
            SizedBox(height: spSm),
            Text("• UNESCO World Heritage Sites"),
            Text("• Traditional Catalan culture"),
            Text("• Local artisans and craftspeople"),
            Text("• Authentic venues and locations"),
            Text("• Expert cultural guides"),
            Text("• Immersive hands-on activities"),
          ],
        ),
        actions: [
          QButton(
            label: "Explore",
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
