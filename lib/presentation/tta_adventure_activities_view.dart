import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class TtaAdventureActivitiesView extends StatefulWidget {
  const TtaAdventureActivitiesView({super.key});

  @override
  State<TtaAdventureActivitiesView> createState() => _TtaAdventureActivitiesViewState();
}

class _TtaAdventureActivitiesViewState extends State<TtaAdventureActivitiesView> {
  String selectedCategory = "All";
  String selectedDifficulty = "All";
  String searchQuery = "";

  List<Map<String, dynamic>> categories = [
    {"label": "All", "value": "All", "icon": Icons.explore},
    {"label": "Water Sports", "value": "Water", "icon": Icons.pool},
    {"label": "Mountain", "value": "Mountain", "icon": Icons.landscape},
    {"label": "Cycling", "value": "Cycling", "icon": Icons.pedal_bike},
    {"label": "Extreme", "value": "Extreme", "icon": Icons.sports_motorsports},
    {"label": "Hiking", "value": "Hiking", "icon": Icons.hiking},
  ];

  List<Map<String, dynamic>> difficultyLevels = [
    {"label": "All", "value": "All"},
    {"label": "Beginner", "value": "Beginner"},
    {"label": "Intermediate", "value": "Intermediate"},
    {"label": "Advanced", "value": "Advanced"},
    {"label": "Expert", "value": "Expert"},
  ];

  List<Map<String, dynamic>> adventures = [
    {
      "id": 1,
      "title": "Paragliding Barcelona Coast",
      "category": "Extreme",
      "difficulty": "Beginner",
      "duration": "3 hours",
      "price": 195.00,
      "originalPrice": 230.00,
      "rating": 4.9,
      "reviews": 847,
      "image": "https://picsum.photos/300/200?random=1&keyword=paragliding",
      "description": "Soar above Barcelona's coastline with breathtaking Mediterranean views",
      "highlights": ["Tandem flight", "Professional instructor", "Photos included", "Certificate"],
      "includes": ["Equipment", "Instructor", "Transfer", "Insurance"],
      "minAge": 16,
      "maxParticipants": 6,
      "safetyRating": "A+",
      "location": "Castelldefels",
      "weatherDependent": true,
      "discount": 15,
      "featured": true,
      "provider": "Barcelona Adventure Co.",
    },
    {
      "id": 2,
      "title": "Costa Brava Kayaking & Snorkeling",
      "category": "Water",
      "difficulty": "Intermediate",
      "duration": "6 hours",
      "price": 125.00,
      "originalPrice": 145.00,
      "rating": 4.8,
      "reviews": 1234,
      "image": "https://picsum.photos/300/200?random=2&keyword=kayaking",
      "description": "Explore hidden coves and underwater caves along the stunning Costa Brava",
      "highlights": ["Sea kayaking", "Snorkeling gear", "Cave exploration", "Lunch included"],
      "includes": ["Kayak & gear", "Snorkel equipment", "Guide", "Lunch"],
      "minAge": 12,
      "maxParticipants": 12,
      "safetyRating": "A",
      "location": "Tossa de Mar",
      "weatherDependent": true,
      "discount": 14,
      "featured": false,
      "provider": "Costa Brava Adventures",
    },
    {
      "id": 3,
      "title": "Pyrenees Via Ferrata Adventure",
      "category": "Mountain",
      "difficulty": "Advanced",
      "duration": "8 hours",
      "price": 165.00,
      "originalPrice": 190.00,
      "rating": 4.7,
      "reviews": 523,
      "image": "https://picsum.photos/300/200?random=3&keyword=climbing",
      "description": "Challenge yourself on a secured climbing route through the Pyrenees mountains",
      "highlights": ["Via ferrata route", "Mountain views", "Professional guide", "Safety gear"],
      "includes": ["Climbing gear", "Helmet", "Harness", "Guide"],
      "minAge": 18,
      "maxParticipants": 8,
      "safetyRating": "A",
      "location": "Val d'Aran",
      "weatherDependent": true,
      "discount": 13,
      "featured": true,
      "provider": "Pyrenees Extreme",
    },
    {
      "id": 4,
      "title": "Barcelona Electric Bike Adventure",
      "category": "Cycling",
      "difficulty": "Beginner",
      "duration": "4 hours",
      "price": 85.00,
      "originalPrice": 100.00,
      "rating": 4.6,
      "reviews": 967,
      "image": "https://picsum.photos/300/200?random=4&keyword=cycling",
      "description": "Discover Barcelona's highlights and hidden gems on an electric bike tour",
      "highlights": ["E-bike included", "Multiple stops", "Local guide", "Photo opportunities"],
      "includes": ["E-bike & helmet", "Guide", "Water bottle", "Route map"],
      "minAge": 14,
      "maxParticipants": 15,
      "safetyRating": "A+",
      "location": "Barcelona Center",
      "weatherDependent": false,
      "discount": 15,
      "featured": false,
      "provider": "Barcelona Bike Tours",
    },
    {
      "id": 5,
      "title": "Montserrat Rock Climbing",
      "category": "Mountain",
      "difficulty": "Expert",
      "duration": "10 hours",
      "price": 245.00,
      "originalPrice": 280.00,
      "rating": 4.8,
      "reviews": 312,
      "image": "https://picsum.photos/300/200?random=5&keyword=rockclimbing",
      "description": "Scale the iconic conglomerate towers of Montserrat with expert instruction",
      "highlights": ["Multi-pitch climbing", "Stunning views", "Expert instruction", "Traditional routes"],
      "includes": ["Climbing gear", "Ropes", "Helmet", "Expert guide"],
      "minAge": 21,
      "maxParticipants": 4,
      "safetyRating": "A",
      "location": "Montserrat",
      "weatherDependent": true,
      "discount": 13,
      "featured": true,
      "provider": "Montserrat Climbing School",
    },
    {
      "id": 6,
      "title": "Garraf Natural Park Hiking",
      "category": "Hiking",
      "difficulty": "Intermediate",
      "duration": "5 hours",
      "price": 65.00,
      "originalPrice": 75.00,
      "rating": 4.5,
      "reviews": 754,
      "image": "https://picsum.photos/300/200?random=6&keyword=hiking",
      "description": "Explore Mediterranean landscapes and ancient caves in Garraf Natural Park",
      "highlights": ["Nature trails", "Cave visits", "Wildlife spotting", "Coastal views"],
      "includes": ["Guide", "Trail map", "Water", "First aid kit"],
      "minAge": 10,
      "maxParticipants": 20,
      "safetyRating": "A+",
      "location": "Garraf Natural Park",
      "weatherDependent": false,
      "discount": 13,
      "featured": false,
      "provider": "Barcelona Nature Guides",
    },
  ];

  List<Map<String, dynamic>> get filteredAdventures {
    return adventures.where((adventure) {
      bool categoryMatch = selectedCategory == "All" || adventure["category"] == selectedCategory;
      bool difficultyMatch = selectedDifficulty == "All" || adventure["difficulty"] == selectedDifficulty;
      bool searchMatch = searchQuery.isEmpty || 
          adventure["title"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
          adventure["description"].toString().toLowerCase().contains(searchQuery.toLowerCase());
      return categoryMatch && difficultyMatch && searchMatch;
    }).toList();
  }

  List<Map<String, dynamic>> get featuredAdventures {
    return adventures.where((adventure) => adventure["featured"] == true).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Adventure Activities"),
        actions: [
          IconButton(
            icon: Icon(Icons.filter_list),
            onPressed: () {
              _showFilterBottomSheet();
            },
          ),
          IconButton(
            icon: Icon(Icons.safety_check),
            onPressed: () {
              _showSafetyInfo();
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
            _buildAdventureStats(),
            SizedBox(height: spMd),
            _buildCategoryTabs(),
            SizedBox(height: spMd),
            _buildDifficultyFilter(),
            SizedBox(height: spMd),
            if (featuredAdventures.isNotEmpty) ...[
              _buildSectionTitle("Featured Adventures", Icons.star),
              SizedBox(height: spSm),
              _buildFeaturedAdventures(),
              SizedBox(height: spMd),
            ],
            _buildSectionTitle("All Adventures (${filteredAdventures.length})", Icons.explore),
            SizedBox(height: spSm),
            _buildAdventuresList(),
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
            label: "Search adventures...",
            value: searchQuery,
            hint: "Enter activity or location",
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

  Widget _buildAdventureStats() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [warningColor, warningColor.withAlpha(204)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(radiusMd),
      ),
      child: Row(
        children: [
          Expanded(
            child: _buildStatItem("${adventures.length}", "Activities", Icons.explore),
          ),
          Container(
            width: 1,
            height: 40,
            color: Colors.white.withAlpha(76),
          ),
          Expanded(
            child: _buildStatItem("A+ Safety", "Rating", Icons.verified_user),
          ),
          Container(
            width: 1,
            height: 40,
            color: Colors.white.withAlpha(76),
          ),
          Expanded(
            child: _buildStatItem("All Levels", "Difficulty", Icons.trending_up),
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

  Widget _buildDifficultyFilter() {
    return QDropdownField(
      label: "Difficulty Level",
      items: difficultyLevels,
      value: selectedDifficulty,
      onChanged: (value, label) {
        selectedDifficulty = value;
        setState(() {});
      },
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

  Widget _buildFeaturedAdventures() {
    return QHorizontalScroll(
      children: featuredAdventures.map((adventure) => Container(
        width: 300,
        margin: EdgeInsets.only(right: spMd),
        child: _buildFeaturedAdventureCard(adventure),
      )).toList(),
    );
  }

  Widget _buildFeaturedAdventureCard(Map<String, dynamic> adventure) {
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
                  "${adventure["image"]}",
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
              if ((adventure["discount"] as int) > 0)
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
                      "-${adventure["discount"]}%",
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
                  "${adventure["title"]}",
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
                  "${adventure["description"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: spSm),
                Row(
                  children: [
                    _buildDifficultyChip(adventure["difficulty"]),
                    Spacer(),
                    Icon(
                      Icons.access_time,
                      size: 14,
                      color: disabledBoldColor,
                    ),
                    SizedBox(width: spXs),
                    Text(
                      "${adventure["duration"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spSm),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if ((adventure["originalPrice"] as double) > (adventure["price"] as double))
                            Text(
                              "\$${(adventure["originalPrice"] as double).currency}",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                                decoration: TextDecoration.lineThrough,
                              ),
                            ),
                          Text(
                            "\$${(adventure["price"] as double).currency}",
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

  Widget _buildAdventuresList() {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: filteredAdventures.length,
      itemBuilder: (context, index) {
        final adventure = filteredAdventures[index];
        return _buildAdventureCard(adventure);
      },
    );
  }

  Widget _buildAdventureCard(Map<String, dynamic> adventure) {
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
                  "${adventure["image"]}",
                  width: double.infinity,
                  height: 200,
                  fit: BoxFit.cover,
                ),
              ),
              if (adventure["featured"] == true)
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
              if ((adventure["discount"] as int) > 0)
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
                      "-${adventure["discount"]}%",
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
                  child: Row(
                    children: [
                      Icon(
                        Icons.verified_user,
                        size: 12,
                        color: Colors.white,
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "Safety ${adventure["safetyRating"]}",
                        style: TextStyle(
                          fontSize: 11,
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
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
                        "${adventure["title"]}",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ),
                    _buildDifficultyChip(adventure["difficulty"]),
                  ],
                ),
                SizedBox(height: spXs),
                Text(
                  "${adventure["description"]}",
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
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
                      "${adventure["rating"]}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(width: spXs),
                    Text(
                      "(${adventure["reviews"]})",
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
                      "${adventure["duration"]}",
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
                    _buildInfoChip(Icons.group, "Max ${adventure["maxParticipants"]}", primaryColor),
                    SizedBox(width: spSm),
                    _buildInfoChip(Icons.location_on, "${adventure["location"]}", successColor),
                    SizedBox(width: spSm),
                    if (adventure["weatherDependent"] == true)
                      _buildInfoChip(Icons.wb_sunny, "Weather dependent", warningColor),
                  ],
                ),
                SizedBox(height: spMd),
                _buildHighlights(adventure["highlights"]),
                SizedBox(height: spMd),
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if ((adventure["originalPrice"] as double) > (adventure["price"] as double))
                          Text(
                            "\$${(adventure["originalPrice"] as double).currency}",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                              decoration: TextDecoration.lineThrough,
                            ),
                          ),
                        Text(
                          "\$${(adventure["price"] as double).currency}",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "per person • Min age ${adventure["minAge"]}",
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
                        Text(
                          "by ${adventure["provider"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                        SizedBox(height: spSm),
                        QButton(
                          label: "Book Adventure",
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

  Widget _buildDifficultyChip(String difficulty) {
    Color chipColor;
    switch (difficulty) {
      case "Beginner":
        chipColor = successColor;
        break;
      case "Intermediate":
        chipColor = warningColor;
        break;
      case "Advanced":
        chipColor = dangerColor;
        break;
      case "Expert":
        chipColor = primaryColor;
        break;
      default:
        chipColor = disabledBoldColor;
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
      decoration: BoxDecoration(
        color: chipColor.withAlpha(25),
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Text(
        difficulty,
        style: TextStyle(
          fontSize: 12,
          color: chipColor,
          fontWeight: FontWeight.w600,
        ),
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
          color: infoColor.withAlpha(25),
          borderRadius: BorderRadius.circular(radiusSm),
        ),
        child: Text(
          highlight,
          style: TextStyle(
            fontSize: 12,
            color: infoColor,
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
              "Filter Adventures",
              style: TextStyle(
                fontSize: fsH5,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spLg),
            Text("Price Range"),
            // Add price range slider
            SizedBox(height: spMd),
            Text("Duration"),
            // Add duration filter
            SizedBox(height: spMd),
            Text("Group Size"),
            // Add group size filter
            SizedBox(height: spMd),
            Text("Age Requirements"),
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

  void _showSafetyInfo() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Safety Information"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("All our adventure activities follow strict safety protocols:"),
            SizedBox(height: spSm),
            Text("• Certified and experienced guides"),
            Text("• Professional safety equipment"),
            Text("• Comprehensive insurance coverage"),
            Text("• Weather-dependent activities monitored"),
            Text("• First aid trained staff"),
            Text("• Regular equipment maintenance"),
          ],
        ),
        actions: [
          QButton(
            label: "Got it",
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
