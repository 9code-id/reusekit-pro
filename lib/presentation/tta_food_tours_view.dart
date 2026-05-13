import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class TtaFoodToursView extends StatefulWidget {
  const TtaFoodToursView({super.key});

  @override
  State<TtaFoodToursView> createState() => _TtaFoodToursViewState();
}

class _TtaFoodToursViewState extends State<TtaFoodToursView> {
  String selectedTourType = "All";
  String selectedDietary = "All";
  String searchQuery = "";

  List<Map<String, dynamic>> tourTypes = [
    {"label": "All", "value": "All", "icon": Icons.restaurant},
    {"label": "Walking Tours", "value": "Walking", "icon": Icons.directions_walk},
    {"label": "Market Tours", "value": "Market", "icon": Icons.storefront},
    {"label": "Cooking Classes", "value": "Cooking", "icon": Icons.restaurant_menu},
    {"label": "Wine Tasting", "value": "Wine", "icon": Icons.wine_bar},
    {"label": "Tapas Tours", "value": "Tapas", "icon": Icons.fastfood},
  ];

  List<Map<String, dynamic>> dietaryOptions = [
    {"label": "All", "value": "All"},
    {"label": "Vegetarian", "value": "Vegetarian"},
    {"label": "Vegan", "value": "Vegan"},
    {"label": "Gluten-Free", "value": "GlutenFree"},
    {"label": "Halal", "value": "Halal"},
  ];

  List<Map<String, dynamic>> foodTours = [
    {
      "id": 1,
      "title": "Barcelona Tapas & Wine Walking Tour",
      "tourType": "Walking",
      "duration": "3.5 hours",
      "price": 89.00,
      "originalPrice": 105.00,
      "rating": 4.9,
      "reviews": 2156,
      "image": "https://picsum.photos/300/200?random=1&keyword=tapas",
      "description": "Authentic tapas experience through Barcelona's best local bars and taverns",
      "highlights": ["6 tapas stops", "Local wine pairings", "Expert food guide", "Hidden gems"],
      "includes": ["Food tastings", "Wine samples", "Local guide", "Walking tour"],
      "dietaryOptions": ["Vegetarian", "GlutenFree"],
      "groupSize": "Small group (max 12)",
      "meetingPoint": "Plaça Reial",
      "startTimes": ["11:00 AM", "5:00 PM"],
      "languages": ["English", "Spanish"],
      "difficulty": "Easy",
      "discount": 15,
      "featured": true,
      "chefRecommended": true,
    },
    {
      "id": 2,
      "title": "Boquería Market Food Adventure",
      "tourType": "Market",
      "duration": "2 hours",
      "price": 65.00,
      "originalPrice": 75.00,
      "rating": 4.8,
      "reviews": 1834,
      "image": "https://picsum.photos/300/200?random=2&keyword=market",
      "description": "Discover fresh ingredients and local delicacies at Barcelona's famous market",
      "highlights": ["Market tour", "Fresh tastings", "Local vendors", "Seasonal products"],
      "includes": ["Market guide", "Food samples", "Recipe cards", "Shopping tips"],
      "dietaryOptions": ["Vegetarian", "Vegan", "GlutenFree"],
      "groupSize": "Standard group (max 15)",
      "meetingPoint": "Market entrance",
      "startTimes": ["10:00 AM", "12:00 PM", "3:00 PM"],
      "languages": ["English", "Spanish", "Catalan"],
      "difficulty": "Easy",
      "discount": 13,
      "featured": false,
      "chefRecommended": false,
    },
    {
      "id": 3,
      "title": "Catalan Cooking Masterclass",
      "tourType": "Cooking",
      "duration": "4 hours",
      "price": 145.00,
      "originalPrice": 170.00,
      "rating": 4.9,
      "reviews": 987,
      "image": "https://picsum.photos/300/200?random=3&keyword=cooking",
      "description": "Learn traditional Catalan recipes with professional chef in modern kitchen",
      "highlights": ["Hands-on cooking", "Professional chef", "Traditional recipes", "Full meal"],
      "includes": ["Cooking class", "Ingredients", "Equipment", "3-course meal"],
      "dietaryOptions": ["Vegetarian"],
      "groupSize": "Small class (max 10)",
      "meetingPoint": "Cooking studio",
      "startTimes": ["10:00 AM", "2:00 PM"],
      "languages": ["English", "Spanish"],
      "difficulty": "Moderate",
      "discount": 15,
      "featured": true,
      "chefRecommended": true,
    },
    {
      "id": 4,
      "title": "Spanish Wine & Cheese Tasting",
      "tourType": "Wine",
      "duration": "2.5 hours",
      "price": 95.00,
      "originalPrice": 110.00,
      "rating": 4.7,
      "reviews": 1234,
      "image": "https://picsum.photos/300/200?random=4&keyword=wine",
      "description": "Premium Spanish wines paired with artisanal cheeses and charcuterie",
      "highlights": ["6 wine tastings", "Cheese selection", "Expert sommelier", "Pairing techniques"],
      "includes": ["Wine tastings", "Cheese platter", "Sommelier guide", "Tasting notes"],
      "dietaryOptions": ["Vegetarian"],
      "groupSize": "Intimate group (max 8)",
      "meetingPoint": "Wine bar",
      "startTimes": ["4:00 PM", "7:00 PM"],
      "languages": ["English", "Spanish"],
      "difficulty": "Easy",
      "discount": 14,
      "featured": false,
      "chefRecommended": true,
    },
    {
      "id": 5,
      "title": "Evening Pintxos Bar Crawl",
      "tourType": "Tapas",
      "duration": "3 hours",
      "price": 75.00,
      "originalPrice": 85.00,
      "rating": 4.6,
      "reviews": 1456,
      "image": "https://picsum.photos/300/200?random=5&keyword=pintxos",
      "description": "Experience Basque-style pintxos culture in Barcelona's best bars",
      "highlights": ["4 pintxos bars", "Local drinks", "Cultural insights", "Evening atmosphere"],
      "includes": ["Pintxos tastings", "Drinks included", "Local guide", "Bar hopping"],
      "dietaryOptions": ["Vegetarian"],
      "groupSize": "Fun group (max 16)",
      "meetingPoint": "Born district",
      "startTimes": ["7:00 PM", "8:30 PM"],
      "languages": ["English", "Spanish"],
      "difficulty": "Easy",
      "discount": 12,
      "featured": false,
      "chefRecommended": false,
    },
    {
      "id": 6,
      "title": "Michelin-Starred Chef Experience",
      "tourType": "Cooking",
      "duration": "5 hours",
      "price": 295.00,
      "originalPrice": 350.00,
      "rating": 5.0,
      "reviews": 156,
      "image": "https://picsum.photos/300/200?random=6&keyword=chef",
      "description": "Exclusive cooking session with renowned Michelin-starred chef",
      "highlights": ["Michelin chef", "Premium ingredients", "Advanced techniques", "Fine dining"],
      "includes": ["Private class", "Premium ingredients", "Chef instruction", "5-course meal"],
      "dietaryOptions": ["Vegetarian", "GlutenFree"],
      "groupSize": "Exclusive (max 6)",
      "meetingPoint": "Restaurant kitchen",
      "startTimes": ["2:00 PM"],
      "languages": ["English", "Spanish", "French"],
      "difficulty": "Advanced",
      "discount": 16,
      "featured": true,
      "chefRecommended": true,
    },
  ];

  List<Map<String, dynamic>> get filteredTours {
    return foodTours.where((tour) {
      bool typeMatch = selectedTourType == "All" || tour["tourType"] == selectedTourType;
      bool dietaryMatch = selectedDietary == "All" || 
          (tour["dietaryOptions"] as List).contains(selectedDietary);
      bool searchMatch = searchQuery.isEmpty || 
          tour["title"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
          tour["description"].toString().toLowerCase().contains(searchQuery.toLowerCase());
      return typeMatch && dietaryMatch && searchMatch;
    }).toList();
  }

  List<Map<String, dynamic>> get featuredTours {
    return foodTours.where((tour) => tour["featured"] == true).toList();
  }

  List<Map<String, dynamic>> get chefRecommendedTours {
    return foodTours.where((tour) => tour["chefRecommended"] == true).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Food Tours & Experiences"),
        actions: [
          IconButton(
            icon: Icon(Icons.filter_list),
            onPressed: () {
              _showFilterBottomSheet();
            },
          ),
          IconButton(
            icon: Icon(Icons.restaurant_menu),
            onPressed: () {
              _showDietaryInfo();
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
            _buildFoodStats(),
            SizedBox(height: spMd),
            _buildTourTypeTabs(),
            SizedBox(height: spMd),
            _buildDietaryFilter(),
            SizedBox(height: spMd),
            if (featuredTours.isNotEmpty) ...[
              _buildSectionTitle("Featured Food Tours", Icons.star),
              SizedBox(height: spSm),
              _buildFeaturedTours(),
              SizedBox(height: spMd),
            ],
            if (chefRecommendedTours.isNotEmpty) ...[
              _buildSectionTitle("Chef Recommended", Icons.restaurant),
              SizedBox(height: spSm),
              _buildChefRecommended(),
              SizedBox(height: spMd),
            ],
            _buildSectionTitle("All Food Tours (${filteredTours.length})", Icons.explore),
            SizedBox(height: spSm),
            _buildToursList(),
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
            label: "Search food tours...",
            value: searchQuery,
            hint: "Enter cuisine type or location",
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

  Widget _buildFoodStats() {
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
            child: _buildStatItem("${foodTours.length}", "Food Tours", Icons.restaurant),
          ),
          Container(
            width: 1,
            height: 40,
            color: Colors.white.withAlpha(76),
          ),
          Expanded(
            child: _buildStatItem("Local", "Authentic", Icons.verified),
          ),
          Container(
            width: 1,
            height: 40,
            color: Colors.white.withAlpha(76),
          ),
          Expanded(
            child: _buildStatItem("All Diets", "Welcome", Icons.dining),
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

  Widget _buildTourTypeTabs() {
    return QHorizontalScroll(
      children: tourTypes.map((type) {
        bool isSelected = selectedTourType == type["value"];
        return GestureDetector(
          onTap: () {
            selectedTourType = type["value"];
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
                  type["icon"],
                  size: 16,
                  color: isSelected ? Colors.white : disabledBoldColor,
                ),
                SizedBox(width: spXs),
                Text(
                  "${type["label"]}",
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

  Widget _buildDietaryFilter() {
    return QDropdownField(
      label: "Dietary Requirements",
      items: dietaryOptions,
      value: selectedDietary,
      onChanged: (value, label) {
        selectedDietary = value;
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

  Widget _buildFeaturedTours() {
    return QHorizontalScroll(
      children: featuredTours.map((tour) => Container(
        width: 320,
        margin: EdgeInsets.only(right: spMd),
        child: _buildFeaturedTourCard(tour),
      )).toList(),
    );
  }

  Widget _buildFeaturedTourCard(Map<String, dynamic> tour) {
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
                  "${tour["image"]}",
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
              if ((tour["discount"] as int) > 0)
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
                      "-${tour["discount"]}%",
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              if (tour["chefRecommended"] == true)
                Positioned(
                  bottom: spSm,
                  left: spSm,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                    decoration: BoxDecoration(
                      color: successColor,
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Text(
                      "CHEF'S CHOICE",
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
                  "${tour["title"]}",
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
                  "${tour["description"]}",
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
                    Icon(
                      Icons.access_time,
                      size: 14,
                      color: disabledBoldColor,
                    ),
                    SizedBox(width: spXs),
                    Text(
                      "${tour["duration"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Spacer(),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                      decoration: BoxDecoration(
                        color: primaryColor.withAlpha(25),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Text(
                        "${tour["tourType"]}",
                        style: TextStyle(
                          fontSize: 10,
                          color: primaryColor,
                          fontWeight: FontWeight.w600,
                        ),
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
                          if ((tour["originalPrice"] as double) > (tour["price"] as double))
                            Text(
                              "\$${(tour["originalPrice"] as double).currency}",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                                decoration: TextDecoration.lineThrough,
                              ),
                            ),
                          Text(
                            "\$${(tour["price"] as double).currency}",
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

  Widget _buildChefRecommended() {
    return QHorizontalScroll(
      children: chefRecommendedTours.take(3).map((tour) => Container(
        width: 280,
        margin: EdgeInsets.only(right: spMd),
        child: _buildChefRecommendedCard(tour),
      )).toList(),
    );
  }

  Widget _buildChefRecommendedCard(Map<String, dynamic> tour) {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
        border: Border.all(color: successColor.withAlpha(76)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.restaurant,
                color: successColor,
                size: 20,
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Text(
                  "${tour["title"]}",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Text(
            "${tour["description"]}",
            style: TextStyle(
              fontSize: 12,
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
                size: 14,
                color: warningColor,
              ),
              SizedBox(width: spXs),
              Text(
                "${tour["rating"]}",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Spacer(),
              Text(
                "\$${(tour["price"] as double).currency}",
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
  }

  Widget _buildToursList() {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: filteredTours.length,
      itemBuilder: (context, index) {
        final tour = filteredTours[index];
        return _buildTourCard(tour);
      },
    );
  }

  Widget _buildTourCard(Map<String, dynamic> tour) {
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
                  "${tour["image"]}",
                  width: double.infinity,
                  height: 200,
                  fit: BoxFit.cover,
                ),
              ),
              if (tour["featured"] == true)
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
              if ((tour["discount"] as int) > 0)
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
                      "-${tour["discount"]}%",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              if (tour["chefRecommended"] == true)
                Positioned(
                  bottom: spSm,
                  left: spSm,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                    decoration: BoxDecoration(
                      color: successColor,
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Text(
                      "CHEF'S CHOICE",
                      style: TextStyle(
                        fontSize: 11,
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
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        "${tour["title"]}",
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
                        "${tour["tourType"]}",
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
                  "${tour["description"]}",
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
                      "${tour["rating"]}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(width: spXs),
                    Text(
                      "(${tour["reviews"]})",
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
                      "${tour["duration"]}",
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
                    _buildInfoChip(Icons.group, "${tour["groupSize"]}", primaryColor),
                    SizedBox(width: spSm),
                    _buildInfoChip(Icons.schedule, "Multiple times", successColor),
                    SizedBox(width: spSm),
                    _buildInfoChip(Icons.language, "${(tour["languages"] as List).length} languages", infoColor),
                  ],
                ),
                SizedBox(height: spMd),
                if ((tour["dietaryOptions"] as List).isNotEmpty)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Dietary options:",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: primaryColor,
                        ),
                      ),
                      SizedBox(height: spXs),
                      Wrap(
                        spacing: spXs,
                        runSpacing: spXs,
                        children: (tour["dietaryOptions"] as List).map((option) => Container(
                          padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                          decoration: BoxDecoration(
                            color: successColor.withAlpha(25),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Text(
                            option,
                            style: TextStyle(
                              fontSize: 11,
                              color: successColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        )).toList(),
                      ),
                      SizedBox(height: spMd),
                    ],
                  ),
                _buildHighlights(tour["highlights"]),
                SizedBox(height: spMd),
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if ((tour["originalPrice"] as double) > (tour["price"] as double))
                          Text(
                            "\$${(tour["originalPrice"] as double).currency}",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                              decoration: TextDecoration.lineThrough,
                            ),
                          ),
                        Text(
                          "\$${(tour["price"] as double).currency}",
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
                          label: "Book Food Tour",
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
          color: warningColor.withAlpha(25),
          borderRadius: BorderRadius.circular(radiusSm),
        ),
        child: Text(
          highlight,
          style: TextStyle(
            fontSize: 12,
            color: warningColor,
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
              "Filter Food Tours",
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
            Text("Difficulty Level"),
            // Add difficulty filter
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

  void _showDietaryInfo() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Dietary Information"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("We accommodate various dietary requirements:"),
            SizedBox(height: spSm),
            Text("• Vegetarian options available"),
            Text("• Vegan-friendly tours"),
            Text("• Gluten-free alternatives"),
            Text("• Halal certified options"),
            Text("• Allergy considerations"),
            Text("• Custom dietary requests"),
            SizedBox(height: spSm),
            Text("Please inform us about any special dietary needs when booking."),
          ],
        ),
        actions: [
          QButton(
            label: "Understood",
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
