import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class TtaExcursionsView extends StatefulWidget {
  const TtaExcursionsView({super.key});

  @override
  State<TtaExcursionsView> createState() => _TtaExcursionsViewState();
}

class _TtaExcursionsViewState extends State<TtaExcursionsView> {
  String selectedCategory = "All";
  String selectedDuration = "All";
  String searchQuery = "";

  List<Map<String, dynamic>> categories = [
    {"label": "All", "value": "All"},
    {"label": "Nature", "value": "Nature"},
    {"label": "Historical", "value": "Historical"},
    {"label": "Adventure", "value": "Adventure"},
    {"label": "Cultural", "value": "Cultural"},
    {"label": "Beach", "value": "Beach"},
  ];

  List<Map<String, dynamic>> excursions = [
    {
      "id": 1,
      "title": "Montserrat Monastery Day Trip",
      "category": "Nature",
      "duration": "8 hours",
      "price": 125.00,
      "originalPrice": 150.00,
      "rating": 4.8,
      "reviews": 2156,
      "image": "https://picsum.photos/300/200?random=1&keyword=monastery",
      "description": "Sacred mountain monastery with breathtaking views and spiritual experience",
      "highlights": ["Cable car ride", "Monastery visit", "Mountain hiking", "Local lunch"],
      "includes": ["Transport", "Guide", "Cable car", "Lunch"],
      "difficulty": "Easy",
      "meetingPoint": "Plaça de Catalunya",
      "departureTime": "09:00",
      "maxGroupSize": 25,
      "languages": ["English", "Spanish"],
      "discount": 17,
      "featured": true,
    },
    {
      "id": 2,
      "title": "Costa Brava Coastal Adventure",
      "category": "Beach",
      "duration": "10 hours",
      "price": 165.00,
      "originalPrice": 190.00,
      "rating": 4.7,
      "reviews": 1834,
      "image": "https://picsum.photos/300/200?random=2&keyword=coastline",
      "description": "Stunning coastline with hidden coves, medieval towns, and crystal waters",
      "highlights": ["Tossa de Mar", "Calella de Palafrugell", "Beach time", "Scenic drive"],
      "includes": ["Transport", "Guide", "Free time", "Beach access"],
      "difficulty": "Easy",
      "meetingPoint": "Barcelona Center",
      "departureTime": "08:30",
      "maxGroupSize": 30,
      "languages": ["English", "Spanish", "French"],
      "discount": 13,
      "featured": false,
    },
    {
      "id": 3,
      "title": "Girona & Game of Thrones Tour",
      "category": "Historical",
      "duration": "9 hours",
      "price": 145.00,
      "originalPrice": 170.00,
      "rating": 4.9,
      "reviews": 987,
      "image": "https://picsum.photos/300/200?random=3&keyword=medieval",
      "description": "Medieval city and famous filming locations from the hit TV series",
      "highlights": ["Cathedral", "Jewish Quarter", "Filming locations", "Medieval walls"],
      "includes": ["Transport", "Guide", "Cathedral entry", "Walking tour"],
      "difficulty": "Moderate",
      "meetingPoint": "Arc de Triomf",
      "departureTime": "09:15",
      "maxGroupSize": 20,
      "languages": ["English"],
      "discount": 15,
      "featured": true,
    },
    {
      "id": 4,
      "title": "Pyrenees Mountains & Villages",
      "category": "Nature",
      "duration": "12 hours",
      "price": 185.00,
      "originalPrice": 220.00,
      "rating": 4.6,
      "reviews": 756,
      "image": "https://picsum.photos/300/200?random=4&keyword=mountains",
      "description": "Mountain villages, stunning landscapes, and traditional Catalan culture",
      "highlights": ["Vall de Núria", "Mountain train", "Traditional lunch", "Scenic views"],
      "includes": ["Transport", "Guide", "Train tickets", "Lunch"],
      "difficulty": "Moderate",
      "meetingPoint": "Sants Station",
      "departureTime": "08:00",
      "maxGroupSize": 18,
      "languages": ["English", "Spanish"],
      "discount": 16,
      "featured": false,
    },
    {
      "id": 5,
      "title": "Figueres & Dalí Museum Experience",
      "category": "Cultural",
      "duration": "7 hours",
      "price": 95.00,
      "originalPrice": 115.00,
      "rating": 4.7,
      "reviews": 1423,
      "image": "https://picsum.photos/300/200?random=5&keyword=museum",
      "description": "Surreal art experience in Salvador Dalí's hometown and museum",
      "highlights": ["Dalí Theatre-Museum", "Figueres town", "Art collection", "Guided tour"],
      "includes": ["Transport", "Guide", "Museum entry", "Audio guide"],
      "difficulty": "Easy",
      "meetingPoint": "Passeig de Gràcia",
      "departureTime": "09:30",
      "maxGroupSize": 22,
      "languages": ["English", "Spanish", "Catalan"],
      "discount": 17,
      "featured": false,
    },
    {
      "id": 6,
      "title": "Tarragona Roman Heritage Tour",
      "category": "Historical",
      "duration": "8 hours",
      "price": 110.00,
      "originalPrice": 130.00,
      "rating": 4.5,
      "reviews": 642,
      "image": "https://picsum.photos/300/200?random=6&keyword=roman",
      "description": "Ancient Roman ruins and UNESCO World Heritage sites",
      "highlights": ["Roman amphitheatre", "Aqueduct", "Cathedral", "Archaeological sites"],
      "includes": ["Transport", "Guide", "Site entries", "Historical tour"],
      "difficulty": "Easy",
      "meetingPoint": "Plaça d'Espanya",
      "departureTime": "09:00",
      "maxGroupSize": 25,
      "languages": ["English", "Spanish"],
      "discount": 15,
      "featured": false,
    },
  ];

  List<Map<String, dynamic>> get filteredExcursions {
    return excursions.where((excursion) {
      bool categoryMatch = selectedCategory == "All" || excursion["category"] == selectedCategory;
      bool searchMatch = searchQuery.isEmpty || 
          excursion["title"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
          excursion["description"].toString().toLowerCase().contains(searchQuery.toLowerCase());
      return categoryMatch && searchMatch;
    }).toList();
  }

  List<Map<String, dynamic>> get featuredExcursions {
    return excursions.where((excursion) => excursion["featured"] == true).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Day Excursions"),
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
            _buildQuickStats(),
            SizedBox(height: spMd),
            _buildCategoryFilter(),
            SizedBox(height: spMd),
            if (featuredExcursions.isNotEmpty) ...[
              _buildSectionTitle("Featured Excursions"),
              SizedBox(height: spSm),
              _buildFeaturedExcursions(),
              SizedBox(height: spMd),
            ],
            _buildSectionTitle("All Excursions (${filteredExcursions.length})"),
            SizedBox(height: spSm),
            _buildExcursionsList(),
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
            label: "Search excursions...",
            value: searchQuery,
            hint: "Enter destination or activity",
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

  Widget _buildQuickStats() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [primaryColor, primaryColor.withAlpha(204)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(radiusMd),
      ),
      child: Row(
        children: [
          Expanded(
            child: _buildStatItem("${excursions.length}", "Total Tours", Icons.tour),
          ),
          Container(
            width: 1,
            height: 40,
            color: Colors.white.withAlpha(76),
          ),
          Expanded(
            child: _buildStatItem("From 7h", "Duration", Icons.access_time),
          ),
          Container(
            width: 1,
            height: 40,
            color: Colors.white.withAlpha(76),
          ),
          Expanded(
            child: _buildStatItem("€95+", "Starting Price", Icons.euro),
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
            fontSize: 18,
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

  Widget _buildCategoryFilter() {
    return QCategoryPicker(
      label: "Category",
      items: categories,
      value: selectedCategory,
      onChanged: (index, label, value, item) {
        selectedCategory = value;
        setState(() {});
      },
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: TextStyle(
        fontSize: fsH6,
        fontWeight: FontWeight.bold,
        color: primaryColor,
      ),
    );
  }

  Widget _buildFeaturedExcursions() {
    return QHorizontalScroll(
      children: featuredExcursions.map((excursion) => Container(
        width: 280,
        margin: EdgeInsets.only(right: spMd),
        child: _buildFeaturedExcursionCard(excursion),
      )).toList(),
    );
  }

  Widget _buildFeaturedExcursionCard(Map<String, dynamic> excursion) {
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
                  "${excursion["image"]}",
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
              if ((excursion["discount"] as int) > 0)
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
                      "-${excursion["discount"]}%",
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
                  "${excursion["title"]}",
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
                  "${excursion["description"]}",
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
                      Icons.star,
                      size: 14,
                      color: warningColor,
                    ),
                    SizedBox(width: spXs),
                    Text(
                      "${excursion["rating"]}",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(width: spXs),
                    Text(
                      "(${excursion["reviews"]})",
                      style: TextStyle(
                        fontSize: 10,
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
                          if ((excursion["originalPrice"] as double) > (excursion["price"] as double))
                            Text(
                              "\$${(excursion["originalPrice"] as double).currency}",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                                decoration: TextDecoration.lineThrough,
                              ),
                            ),
                          Text(
                            "\$${(excursion["price"] as double).currency}",
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

  Widget _buildExcursionsList() {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: filteredExcursions.length,
      itemBuilder: (context, index) {
        final excursion = filteredExcursions[index];
        return _buildExcursionCard(excursion);
      },
    );
  }

  Widget _buildExcursionCard(Map<String, dynamic> excursion) {
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
                  "${excursion["image"]}",
                  width: double.infinity,
                  height: 200,
                  fit: BoxFit.cover,
                ),
              ),
              if (excursion["featured"] == true)
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
              if ((excursion["discount"] as int) > 0)
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
                      "-${excursion["discount"]}%",
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
                        "${excursion["title"]}",
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
                        "${excursion["category"]}",
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
                  "${excursion["description"]}",
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
                    _buildDetailChip(Icons.access_time, "${excursion["duration"]}", primaryColor),
                    SizedBox(width: spSm),
                    _buildDetailChip(Icons.group, "Max ${excursion["maxGroupSize"]}", successColor),
                    SizedBox(width: spSm),
                    _buildDetailChip(Icons.fitness_center, "${excursion["difficulty"]}", warningColor),
                  ],
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
                      "${excursion["rating"]}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(width: spXs),
                    Text(
                      "(${excursion["reviews"]} reviews)",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Spacer(),
                    Text(
                      "Departs: ${excursion["departureTime"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spMd),
                _buildHighlights(excursion["highlights"]),
                SizedBox(height: spMd),
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if ((excursion["originalPrice"] as double) > (excursion["price"] as double))
                          Text(
                            "\$${(excursion["originalPrice"] as double).currency}",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                              decoration: TextDecoration.lineThrough,
                            ),
                          ),
                        Text(
                          "\$${(excursion["price"] as double).currency}",
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
                          label: "Book Excursion",
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

  Widget _buildDetailChip(IconData icon, String text, Color color) {
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
              "Filter Excursions",
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
            Text("Difficulty Level"),
            // Add difficulty filter
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
}
