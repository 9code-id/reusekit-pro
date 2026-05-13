import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class TtaActivitiesView extends StatefulWidget {
  const TtaActivitiesView({super.key});

  @override
  State<TtaActivitiesView> createState() => _TtaActivitiesViewState();
}

class _TtaActivitiesViewState extends State<TtaActivitiesView> {
  String selectedCategory = "All";
  String selectedLocation = "Barcelona";
  String searchQuery = "";

  List<Map<String, dynamic>> categories = [
    {"label": "All", "value": "All", "icon": Icons.grid_view},
    {"label": "Adventure", "value": "Adventure", "icon": Icons.landscape},
    {"label": "Cultural", "value": "Cultural", "icon": Icons.museum},
    {"label": "Food & Drink", "value": "Food", "icon": Icons.restaurant},
    {"label": "Tours", "value": "Tours", "icon": Icons.tour},
    {"label": "Water Sports", "value": "Water", "icon": Icons.pool},
  ];

  List<Map<String, dynamic>> activities = [
    {
      "id": 1,
      "title": "Sagrada Familia Skip-the-Line Tour",
      "category": "Cultural",
      "location": "Barcelona",
      "duration": "2 hours",
      "price": 45.00,
      "originalPrice": 60.00,
      "rating": 4.8,
      "reviews": 2847,
      "image": "https://picsum.photos/300/200?random=1&keyword=sagrada",
      "description": "Discover Gaudí's masterpiece with expert guide",
      "highlights": ["Skip-the-line access", "Expert guide", "Small groups"],
      "availability": "Available today",
      "discount": 25,
    },
    {
      "id": 2,
      "title": "Barcelona Food Walking Tour",
      "category": "Food",
      "location": "Barcelona",
      "duration": "3.5 hours",
      "price": 75.00,
      "originalPrice": 85.00,
      "rating": 4.9,
      "reviews": 1923,
      "image": "https://picsum.photos/300/200?random=2&keyword=food",
      "description": "Taste authentic Catalan cuisine and local delicacies",
      "highlights": ["7 food tastings", "Local guide", "Market visit"],
      "availability": "Available today",
      "discount": 12,
    },
    {
      "id": 3,
      "title": "Costa Brava Kayaking Adventure",
      "category": "Adventure",
      "location": "Costa Brava",
      "duration": "4 hours",
      "price": 65.00,
      "originalPrice": 80.00,
      "rating": 4.7,
      "reviews": 856,
      "image": "https://picsum.photos/300/200?random=3&keyword=kayak",
      "description": "Explore hidden coves and crystal-clear waters",
      "highlights": ["Equipment included", "Snorkeling", "Professional guide"],
      "availability": "Limited spots",
      "discount": 19,
    },
    {
      "id": 4,
      "title": "Flamenco Show & Dinner",
      "category": "Cultural",
      "location": "Barcelona",
      "duration": "3 hours",
      "price": 95.00,
      "originalPrice": 120.00,
      "rating": 4.6,
      "reviews": 1247,
      "image": "https://picsum.photos/300/200?random=4&keyword=flamenco",
      "description": "Authentic flamenco performance with traditional dinner",
      "highlights": ["Live performance", "3-course dinner", "Welcome drink"],
      "availability": "Available today",
      "discount": 21,
    },
    {
      "id": 5,
      "title": "Barcelona Bike Tour",
      "category": "Tours",
      "location": "Barcelona",
      "duration": "3 hours",
      "price": 35.00,
      "originalPrice": 45.00,
      "rating": 4.5,
      "reviews": 934,
      "image": "https://picsum.photos/300/200?random=5&keyword=bike",
      "description": "Discover Barcelona's highlights on two wheels",
      "highlights": ["Bike & helmet included", "Small groups", "Multiple stops"],
      "availability": "Available today",
      "discount": 22,
    },
    {
      "id": 6,
      "title": "Sunset Sailing Experience",
      "category": "Water",
      "location": "Barcelona",
      "duration": "2.5 hours",
      "price": 55.00,
      "originalPrice": 70.00,
      "rating": 4.8,
      "reviews": 1456,
      "image": "https://picsum.photos/300/200?random=6&keyword=sailing",
      "description": "Romantic sunset cruise along Barcelona coastline",
      "highlights": ["Drinks included", "Professional crew", "Swimming stop"],
      "availability": "Available today",
      "discount": 21,
    },
  ];

  List<Map<String, dynamic>> get filteredActivities {
    return activities.where((activity) {
      bool categoryMatch = selectedCategory == "All" || activity["category"] == selectedCategory;
      bool searchMatch = searchQuery.isEmpty || 
          activity["title"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
          activity["description"].toString().toLowerCase().contains(searchQuery.toLowerCase());
      return categoryMatch && searchMatch;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Activities & Experiences"),
        actions: [
          IconButton(
            icon: Icon(Icons.filter_list),
            onPressed: () {
              _showFilterBottomSheet();
            },
          ),
          IconButton(
            icon: Icon(Icons.map),
            onPressed: () {
              // Navigate to map view
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
            _buildLocationSelector(),
            SizedBox(height: spMd),
            _buildCategoryTabs(),
            SizedBox(height: spMd),
            _buildResultsHeader(),
            SizedBox(height: spSm),
            _buildActivitiesList(),
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
            label: "Search activities...",
            value: searchQuery,
            hint: "Enter activity name or keyword",
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

  Widget _buildLocationSelector() {
    List<Map<String, dynamic>> locations = [
      {"label": "Barcelona", "value": "Barcelona"},
      {"label": "Madrid", "value": "Madrid"},
      {"label": "Seville", "value": "Seville"},
      {"label": "Valencia", "value": "Valencia"},
    ];

    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Row(
        children: [
          Icon(
            Icons.location_on,
            color: primaryColor,
            size: 20,
          ),
          SizedBox(width: spSm),
          Text(
            "Location:",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: primaryColor,
            ),
          ),
          SizedBox(width: spSm),
          Expanded(
            child: QDropdownField(
              items: locations,
              value: selectedLocation,
              onChanged: (value, label) {
                selectedLocation = value;
                setState(() {});
              },
            ),
          ),
        ],
      ),
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

  Widget _buildResultsHeader() {
    return Row(
      children: [
        Expanded(
          child: Text(
            "${filteredActivities.length} activities found",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            _showSortBottomSheet();
          },
          child: Row(
            children: [
              Text(
                "Sort by",
                style: TextStyle(
                  fontSize: 14,
                  color: primaryColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(width: spXs),
              Icon(
                Icons.sort,
                size: 16,
                color: primaryColor,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildActivitiesList() {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: filteredActivities.length,
      itemBuilder: (context, index) {
        final activity = filteredActivities[index];
        return _buildActivityCard(activity);
      },
    );
  }

  Widget _buildActivityCard(Map<String, dynamic> activity) {
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
                  "${activity["image"]}",
                  width: double.infinity,
                  height: 200,
                  fit: BoxFit.cover,
                ),
              ),
              if ((activity["discount"] as int) > 0)
                Positioned(
                  top: spSm,
                  left: spSm,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                    decoration: BoxDecoration(
                      color: dangerColor,
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Text(
                      "-${activity["discount"]}%",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              Positioned(
                top: spSm,
                right: spSm,
                child: Container(
                  padding: EdgeInsets.all(spXs),
                  decoration: BoxDecoration(
                    color: Colors.white.withAlpha(230),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Icon(
                    Icons.favorite_border,
                    size: 20,
                    color: primaryColor,
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
                  "${activity["title"]}",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spXs),
                Text(
                  "${activity["description"]}",
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: spSm),
                Row(
                  children: [
                    Icon(
                      Icons.star,
                      size: 16,
                      color: warningColor,
                    ),
                    SizedBox(width: spXs),
                    Text(
                      "${activity["rating"]}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(width: spXs),
                    Text(
                      "(${activity["reviews"]} reviews)",
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
                      "${activity["duration"]}",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spSm),
                Wrap(
                  spacing: spXs,
                  runSpacing: spXs,
                  children: (activity["highlights"] as List).take(3).map((highlight) => Container(
                    padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                    decoration: BoxDecoration(
                      color: primaryColor.withAlpha(25),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Text(
                      highlight,
                      style: TextStyle(
                        fontSize: 12,
                        color: primaryColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  )).toList(),
                ),
                SizedBox(height: spMd),
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if ((activity["originalPrice"] as double) > (activity["price"] as double))
                          Text(
                            "\$${(activity["originalPrice"] as double).currency}",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                              decoration: TextDecoration.lineThrough,
                            ),
                          ),
                        Text(
                          "\$${(activity["price"] as double).currency}",
                          style: TextStyle(
                            fontSize: 18,
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
                            "${activity["availability"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: successColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        SizedBox(height: spSm),
                        QButton(
                          label: "Book Now",
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
              "Filter Activities",
              style: TextStyle(
                fontSize: fsH5,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spLg),
            Text("Price Range"),
            // Add price range slider here
            SizedBox(height: spMd),
            Text("Duration"),
            // Add duration filter here
            SizedBox(height: spMd),
            Text("Rating"),
            // Add rating filter here
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

  void _showSortBottomSheet() {
    List<String> sortOptions = [
      "Popularity",
      "Price: Low to High",
      "Price: High to Low",
      "Rating",
      "Duration",
    ];

    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: EdgeInsets.all(spLg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Sort By",
              style: TextStyle(
                fontSize: fsH5,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spMd),
            ...sortOptions.map((option) => ListTile(
              title: Text(option),
              onTap: () {
                Navigator.pop(context);
                ss("Sorted by $option");
              },
            )).toList(),
          ],
        ),
      ),
    );
  }
}
