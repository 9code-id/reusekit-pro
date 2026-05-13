import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class TtaToursView extends StatefulWidget {
  const TtaToursView({super.key});

  @override
  State<TtaToursView> createState() => _TtaToursViewState();
}

class _TtaToursViewState extends State<TtaToursView> {
  String selectedTourType = "All";
  String selectedDuration = "All";
  String searchQuery = "";

  List<Map<String, dynamic>> tourTypes = [
    {"label": "All", "value": "All"},
    {"label": "City Tours", "value": "City"},
    {"label": "Historical", "value": "Historical"},
    {"label": "Walking Tours", "value": "Walking"},
    {"label": "Bus Tours", "value": "Bus"},
    {"label": "Private Tours", "value": "Private"},
  ];

  List<Map<String, dynamic>> tours = [
    {
      "id": 1,
      "title": "Barcelona Highlights City Tour",
      "type": "City",
      "duration": "4 hours",
      "price": 89.00,
      "originalPrice": 110.00,
      "rating": 4.7,
      "reviews": 1823,
      "image": "https://picsum.photos/300/200?random=1&keyword=barcelona",
      "description": "Discover Barcelona's most iconic landmarks and neighborhoods",
      "highlights": ["Sagrada Familia", "Park Güell", "Gothic Quarter", "Las Ramblas"],
      "groupSize": "Small group (max 15)",
      "language": "English, Spanish",
      "includes": ["Professional guide", "Transportation", "Skip-the-line tickets"],
      "meetingPoint": "Plaça de Catalunya",
      "availability": "Daily",
      "discount": 19,
      "tourGuide": {
        "name": "Maria Rodriguez",
        "experience": "8 years",
        "rating": 4.9,
        "avatar": "https://picsum.photos/100/100?random=101"
      }
    },
    {
      "id": 2,
      "title": "Gothic Quarter Walking Tour",
      "type": "Walking",
      "duration": "2.5 hours",
      "price": 35.00,
      "originalPrice": 45.00,
      "rating": 4.8,
      "reviews": 934,
      "image": "https://picsum.photos/300/200?random=2&keyword=gothic",
      "description": "Explore medieval streets and hidden stories of old Barcelona",
      "highlights": ["Cathedral", "Jewish Quarter", "Roman ruins", "Local legends"],
      "groupSize": "Small group (max 12)",
      "language": "English",
      "includes": ["Expert local guide", "Historical commentary"],
      "meetingPoint": "Barcelona Cathedral",
      "availability": "Daily except Monday",
      "discount": 22,
      "tourGuide": {
        "name": "Carlos Martín",
        "experience": "5 years",
        "rating": 4.8,
        "avatar": "https://picsum.photos/100/100?random=102"
      }
    },
    {
      "id": 3,
      "title": "Montjuïc and Olympic Sites Tour",
      "type": "Bus",
      "duration": "3 hours",
      "price": 65.00,
      "originalPrice": 80.00,
      "rating": 4.6,
      "reviews": 756,
      "image": "https://picsum.photos/300/200?random=3&keyword=montjuic",
      "description": "Panoramic views and Olympic history on Montjuïc Hill",
      "highlights": ["Magic Fountain", "Olympic Stadium", "Castle views", "Cable car"],
      "groupSize": "Standard group (max 25)",
      "language": "English, Spanish, French",
      "includes": ["Air-conditioned bus", "Guide", "Cable car ticket"],
      "meetingPoint": "Plaça d'Espanya",
      "availability": "Daily",
      "discount": 19,
      "tourGuide": {
        "name": "Anna García",
        "experience": "6 years",
        "rating": 4.7,
        "avatar": "https://picsum.photos/100/100?random=103"
      }
    },
    {
      "id": 4,
      "title": "Private Gaudí Architecture Tour",
      "type": "Private",
      "duration": "5 hours",
      "price": 299.00,
      "originalPrice": 350.00,
      "rating": 4.9,
      "reviews": 234,
      "image": "https://picsum.photos/300/200?random=4&keyword=gaudi",
      "description": "Exclusive exploration of Gaudí's architectural masterpieces",
      "highlights": ["Sagrada Familia", "Park Güell", "Casa Batlló", "Casa Milà"],
      "groupSize": "Private (up to 6 people)",
      "language": "Multiple languages available",
      "includes": ["Private guide", "Skip-the-line access", "Transportation"],
      "meetingPoint": "Hotel pickup available",
      "availability": "By appointment",
      "discount": 15,
      "tourGuide": {
        "name": "Elena Villas",
        "experience": "12 years",
        "rating": 4.9,
        "avatar": "https://picsum.photos/100/100?random=104"
      }
    },
    {
      "id": 5,
      "title": "Barcelona Food & Market Tour",
      "type": "Walking",
      "duration": "3.5 hours",
      "price": 85.00,
      "originalPrice": 95.00,
      "rating": 4.8,
      "reviews": 1456,
      "image": "https://picsum.photos/300/200?random=5&keyword=market",
      "description": "Taste local flavors and discover Barcelona's food culture",
      "highlights": ["Boquería Market", "Tapas tasting", "Local vendors", "Food history"],
      "groupSize": "Small group (max 10)",
      "language": "English",
      "includes": ["Food tastings", "Market guide", "Recipe cards"],
      "meetingPoint": "Las Ramblas entrance",
      "availability": "Tuesday to Saturday",
      "discount": 11,
      "tourGuide": {
        "name": "Pablo Hernández",
        "experience": "7 years",
        "rating": 4.8,
        "avatar": "https://picsum.photos/100/100?random=105"
      }
    },
    {
      "id": 6,
      "title": "Modernist Architecture Discovery",
      "type": "Historical",
      "duration": "4 hours",
      "price": 78.00,
      "originalPrice": 90.00,
      "rating": 4.7,
      "reviews": 678,
      "image": "https://picsum.photos/300/200?random=6&keyword=modernist",
      "description": "Journey through Barcelona's architectural evolution",
      "highlights": ["Casa Vicens", "Hospital Sant Pau", "Palau Música", "Art history"],
      "groupSize": "Standard group (max 20)",
      "language": "English, Spanish",
      "includes": ["Architecture expert", "Entry fees", "Audio system"],
      "meetingPoint": "Casa Vicens",
      "availability": "Wednesday to Sunday",
      "discount": 13,
      "tourGuide": {
        "name": "Roberto Silva",
        "experience": "9 years",
        "rating": 4.6,
        "avatar": "https://picsum.photos/100/100?random=106"
      }
    },
  ];

  List<Map<String, dynamic>> get filteredTours {
    return tours.where((tour) {
      bool typeMatch = selectedTourType == "All" || tour["type"] == selectedTourType;
      bool searchMatch = searchQuery.isEmpty || 
          tour["title"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
          tour["description"].toString().toLowerCase().contains(searchQuery.toLowerCase());
      return typeMatch && searchMatch;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tours & Experiences"),
        actions: [
          IconButton(
            icon: Icon(Icons.filter_list),
            onPressed: () {
              _showFilterBottomSheet();
            },
          ),
          IconButton(
            icon: Icon(Icons.favorite_border),
            onPressed: () {
              // Navigate to favorites
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
            _buildTourTypeSelector(),
            SizedBox(height: spMd),
            _buildFeaturedTour(),
            SizedBox(height: spMd),
            _buildResultsHeader(),
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
            label: "Search tours...",
            value: searchQuery,
            hint: "Enter tour name or attraction",
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

  Widget _buildTourTypeSelector() {
    return QCategoryPicker(
      label: "Tour Type",
      items: tourTypes,
      value: selectedTourType,
      onChanged: (index, label, value, item) {
        selectedTourType = value;
        setState(() {});
      },
    );
  }

  Widget _buildFeaturedTour() {
    final featuredTour = tours.first;
    
    return Container(
      margin: EdgeInsets.only(bottom: spMd),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowMd],
      ),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(radiusLg),
            child: Image.network(
              "${featuredTour["image"]}",
              width: double.infinity,
              height: 220,
              fit: BoxFit.cover,
            ),
          ),
          Container(
            width: double.infinity,
            height: 220,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(radiusLg),
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.transparent,
                  Colors.black.withAlpha(178),
                ],
              ),
            ),
          ),
          Positioned(
            top: spMd,
            left: spMd,
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
          Positioned(
            top: spMd,
            right: spMd,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
              decoration: BoxDecoration(
                color: dangerColor,
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Text(
                "-${featuredTour["discount"]}%",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          Positioned(
            bottom: spMd,
            left: spMd,
            right: spMd,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${featuredTour["title"]}",
                  style: TextStyle(
                    fontSize: fsH5,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: spXs),
                Row(
                  children: [
                    Icon(
                      Icons.star,
                      size: 16,
                      color: warningColor,
                    ),
                    SizedBox(width: spXs),
                    Text(
                      "${featuredTour["rating"]} (${featuredTour["reviews"]} reviews)",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white,
                      ),
                    ),
                    Spacer(),
                    Text(
                      "\$${(featuredTour["price"] as double).currency}",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
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

  Widget _buildResultsHeader() {
    return Row(
      children: [
        Expanded(
          child: Text(
            "${filteredTours.length} tours available",
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
                  height: 180,
                  fit: BoxFit.cover,
                ),
              ),
              if ((tour["discount"] as int) > 0)
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
                      "-${tour["discount"]}%",
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
                        "${tour["type"]}",
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
                SizedBox(height: spSm),
                _buildTourGuideInfo(tour["tourGuide"]),
                SizedBox(height: spSm),
                Wrap(
                  spacing: spXs,
                  runSpacing: spXs,
                  children: (tour["highlights"] as List).take(3).map((highlight) => Container(
                    padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                    decoration: BoxDecoration(
                      color: successColor.withAlpha(25),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Text(
                      highlight,
                      style: TextStyle(
                        fontSize: 12,
                        color: successColor,
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
                        Text(
                          "${tour["groupSize"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                        SizedBox(height: spSm),
                        QButton(
                          label: "Book Tour",
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

  Widget _buildTourGuideInfo(Map<String, dynamic> guide) {
    return Row(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(radiusSm),
          child: Image.network(
            "${guide["avatar"]}",
            width: 32,
            height: 32,
            fit: BoxFit.cover,
          ),
        ),
        SizedBox(width: spSm),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "${guide["name"]}",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: primaryColor,
                ),
              ),
              Text(
                "${guide["experience"]} experience",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
        ),
        Row(
          children: [
            Icon(
              Icons.star,
              size: 14,
              color: warningColor,
            ),
            SizedBox(width: spXs),
            Text(
              "${guide["rating"]}",
              style: TextStyle(
                fontSize: 12,
                color: primaryColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ],
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
              "Filter Tours",
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
            Text("Group Size"),
            // Add group size filter
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
      "Most Popular",
      "Price: Low to High",
      "Price: High to Low",
      "Highest Rated",
      "Duration: Short to Long",
      "Duration: Long to Short",
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
              "Sort Tours",
              style: TextStyle(
                fontSize: fsH5,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spMd),
            ...sortOptions.map((option) => Container(
              width: double.infinity,
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                  ss("Sorted by $option");
                },
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: spMd),
                  child: Text(
                    option,
                    style: TextStyle(
                      fontSize: 16,
                      color: primaryColor,
                    ),
                  ),
                ),
              ),
            )).toList(),
          ],
        ),
      ),
    );
  }
}
