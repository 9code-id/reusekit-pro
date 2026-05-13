import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class TtaDestinationSearchView extends StatefulWidget {
  const TtaDestinationSearchView({super.key});

  @override
  State<TtaDestinationSearchView> createState() => _TtaDestinationSearchViewState();
}

class _TtaDestinationSearchViewState extends State<TtaDestinationSearchView> {
  String searchQuery = "";
  String selectedLocation = "";
  String checkInDate = "";
  String checkOutDate = "";
  int travelers = 2;
  String selectedRoomType = "";
  String selectedBudget = "";
  bool showAdvancedFilters = false;

  List<Map<String, dynamic>> quickSearches = [
    {"text": "Bali Beach Resort", "icon": Icons.beach_access},
    {"text": "Tokyo City Tour", "icon": Icons.location_city},
    {"text": "Swiss Alps Adventure", "icon": Icons.terrain},
    {"text": "Paris Culture Trip", "icon": Icons.museum},
    {"text": "Maldives Luxury", "icon": Icons.hotel},
  ];

  List<Map<String, dynamic>> recentSearches = [
    {"query": "Bangkok Thailand", "date": "2 days ago"},
    {"query": "Rome Italy", "date": "1 week ago"},
    {"query": "New York USA", "date": "2 weeks ago"},
  ];

  List<Map<String, dynamic>> popularDestinations = [
    {
      "name": "Santorini, Greece",
      "image": "https://picsum.photos/120/80?random=1&keyword=santorini",
      "searches": "12.5K searches",
      "category": "Romance",
    },
    {
      "name": "Kyoto, Japan",
      "image": "https://picsum.photos/120/80?random=2&keyword=kyoto",
      "searches": "9.8K searches",
      "category": "Culture",
    },
    {
      "name": "Dubai, UAE",
      "image": "https://picsum.photos/120/80?random=3&keyword=dubai",
      "searches": "15.2K searches",
      "category": "Luxury",
    },
    {
      "name": "Costa Rica",
      "image": "https://picsum.photos/120/80?random=4&keyword=costarica",
      "searches": "7.1K searches",
      "category": "Adventure",
    },
  ];

  List<Map<String, dynamic>> locationSuggestions = [
    {"name": "Bali, Indonesia", "type": "Popular Destination"},
    {"name": "Bangkok, Thailand", "type": "City"},
    {"name": "Barcelona, Spain", "type": "City"},
    {"name": "Boston, USA", "type": "City"},
    {"name": "Brisbane, Australia", "type": "City"},
  ];

  List<Map<String, dynamic>> roomTypes = [
    {"label": "Standard Room", "value": "standard"},
    {"label": "Deluxe Room", "value": "deluxe"},
    {"label": "Suite", "value": "suite"},
    {"label": "Villa", "value": "villa"},
    {"label": "Apartment", "value": "apartment"},
  ];

  List<Map<String, dynamic>> budgetRanges = [
    {"label": "Budget (\$0 - \$100/night)", "value": "budget"},
    {"label": "Mid-range (\$100 - \$300/night)", "value": "mid_range"},
    {"label": "Luxury (\$300 - \$800/night)", "value": "luxury"},
    {"label": "Ultra Luxury (\$800+/night)", "value": "ultra_luxury"},
  ];

  List<Map<String, dynamic>> get filteredSuggestions {
    if (searchQuery.isEmpty) return [];
    return locationSuggestions
        .where((location) =>
            location["name"]
                .toLowerCase()
                .contains(searchQuery.toLowerCase()))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Search Destinations"),
        actions: [
          IconButton(
            onPressed: () {
              showAdvancedFilters = !showAdvancedFilters;
              setState(() {});
            },
            icon: Icon(
              showAdvancedFilters ? Icons.filter_list_off : Icons.filter_list,
              color: primaryColor,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Main Search Section
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowMd],
                border: Border.all(color: primaryColor.withAlpha(50)),
              ),
              child: Column(
                spacing: spMd,
                children: [
                  // Destination Search
                  Stack(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                        decoration: BoxDecoration(
                          border: Border.all(color: disabledOutlineBorderColor),
                          borderRadius: BorderRadius.circular(radiusMd),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.search,
                              color: primaryColor,
                              size: 20,
                            ),
                            SizedBox(width: spSm),
                            Expanded(
                              child: TextField(
                                decoration: InputDecoration(
                                  hintText: "Where do you want to go?",
                                  hintStyle: TextStyle(
                                    color: disabledBoldColor,
                                    fontSize: 16,
                                  ),
                                  border: InputBorder.none,
                                ),
                                style: TextStyle(
                                  fontSize: 16,
                                  color: primaryColor,
                                ),
                                onChanged: (value) {
                                  searchQuery = value;
                                  setState(() {});
                                },
                              ),
                            ),
                            if (searchQuery.isNotEmpty)
                              GestureDetector(
                                onTap: () {
                                  searchQuery = "";
                                  setState(() {});
                                },
                                child: Icon(
                                  Icons.clear,
                                  color: disabledBoldColor,
                                  size: 18,
                                ),
                              ),
                          ],
                        ),
                      ),
                      // Auto-complete suggestions
                      if (filteredSuggestions.isNotEmpty)
                        Positioned(
                          top: 50,
                          left: 0,
                          right: 0,
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(radiusMd),
                              boxShadow: [shadowMd],
                              border: Border.all(color: disabledOutlineBorderColor),
                            ),
                            child: Column(
                              children: filteredSuggestions.map((suggestion) {
                                return GestureDetector(
                                  onTap: () {
                                    selectedLocation = suggestion["name"];
                                    searchQuery = suggestion["name"];
                                    setState(() {});
                                  },
                                  child: Container(
                                    padding: EdgeInsets.all(spSm),
                                    decoration: BoxDecoration(
                                      border: Border(
                                        bottom: BorderSide(
                                          color: disabledOutlineBorderColor,
                                          width: 0.5,
                                        ),
                                      ),
                                    ),
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.location_on,
                                          color: primaryColor,
                                          size: 18,
                                        ),
                                        SizedBox(width: spSm),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "${suggestion["name"]}",
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w600,
                                                  color: primaryColor,
                                                ),
                                              ),
                                              Text(
                                                "${suggestion["type"]}",
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  color: disabledBoldColor,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                    ],
                  ),

                  // Date Selection
                  Row(
                    spacing: spSm,
                    children: [
                      Expanded(
                        child: QDatePicker(
                          label: "Check-in",
                          value: checkInDate.isNotEmpty 
                            ? DateTime.parse(checkInDate) 
                            : DateTime.now(),
                          onChanged: (value) {
                            checkInDate = value.toString();
                            setState(() {});
                          },
                        ),
                      ),
                      Expanded(
                        child: QDatePicker(
                          label: "Check-out",
                          value: checkOutDate.isNotEmpty 
                            ? DateTime.parse(checkOutDate) 
                            : DateTime.now().add(Duration(days: 7)),
                          onChanged: (value) {
                            checkOutDate = value.toString();
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),

                  // Travelers
                  Row(
                    children: [
                      Icon(
                        Icons.people,
                        color: primaryColor,
                        size: 20,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "Travelers:",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: primaryColor,
                        ),
                      ),
                      Spacer(),
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              if (travelers > 1) {
                                travelers--;
                                setState(() {});
                              }
                            },
                            child: Container(
                              width: 30,
                              height: 30,
                              decoration: BoxDecoration(
                                border: Border.all(color: disabledOutlineBorderColor),
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Icon(
                                Icons.remove,
                                size: 16,
                                color: primaryColor,
                              ),
                            ),
                          ),
                          SizedBox(width: spSm),
                          Text(
                            "$travelers",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          SizedBox(width: spSm),
                          GestureDetector(
                            onTap: () {
                              travelers++;
                              setState(() {});
                            },
                            child: Container(
                              width: 30,
                              height: 30,
                              decoration: BoxDecoration(
                                border: Border.all(color: disabledOutlineBorderColor),
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Icon(
                                Icons.add,
                                size: 16,
                                color: primaryColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Advanced Filters
            if (showAdvancedFilters)
              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                  border: Border.all(color: disabledOutlineBorderColor),
                ),
                child: Column(
                  spacing: spMd,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Advanced Filters",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    QDropdownField(
                      label: "Room Type",
                      items: roomTypes,
                      value: selectedRoomType,
                      onChanged: (value, label) {
                        selectedRoomType = value;
                        setState(() {});
                      },
                    ),
                    QDropdownField(
                      label: "Budget Range",
                      items: budgetRanges,
                      value: selectedBudget,
                      onChanged: (value, label) {
                        selectedBudget = value;
                        setState(() {});
                      },
                    ),
                  ],
                ),
              ),

            // Search Button
            Container(
              width: double.infinity,
              child: QButton(
                label: "Search Destinations",
                size: bs.md,
                onPressed: () {
                  // Perform search
                  ss("Searching for destinations...");
                  // Navigate to search results
                },
              ),
            ),

            // Quick Searches
            if (searchQuery.isEmpty) ...[
              Text(
                "Quick Searches",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              QHorizontalScroll(
                children: quickSearches.map((search) {
                  return GestureDetector(
                    onTap: () {
                      searchQuery = search["text"];
                      setState(() {});
                    },
                    child: Container(
                      margin: EdgeInsets.only(right: spSm),
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(radiusMd),
                        boxShadow: [shadowSm],
                        border: Border.all(color: disabledOutlineBorderColor),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 35,
                            height: 35,
                            decoration: BoxDecoration(
                              color: primaryColor.withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Icon(
                              search["icon"] as IconData,
                              color: primaryColor,
                              size: 18,
                            ),
                          ),
                          SizedBox(width: spSm),
                          Text(
                            "${search["text"]}",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: primaryColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),

              // Recent Searches
              if (recentSearches.isNotEmpty) ...[
                Text(
                  "Recent Searches",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Column(
                  spacing: spSm,
                  children: recentSearches.map((recent) {
                    return Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(radiusMd),
                        border: Border.all(color: disabledOutlineBorderColor),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.history,
                            color: disabledBoldColor,
                            size: 18,
                          ),
                          SizedBox(width: spSm),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${recent["query"]}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: primaryColor,
                                  ),
                                ),
                                Text(
                                  "${recent["date"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Icon(
                            Icons.arrow_forward_ios,
                            size: 14,
                            color: disabledBoldColor,
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ],

              // Popular Destinations
              Text(
                "Popular Destinations",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              ResponsiveGridView(
                padding: EdgeInsets.zero,
                minItemWidth: 150,
                children: popularDestinations.map((destination) {
                  return Container(
                    margin: EdgeInsets.only(bottom: spSm),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusMd),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.vertical(top: Radius.circular(radiusMd)),
                          child: Image.network(
                            "${destination["image"]}",
                            width: double.infinity,
                            height: 100,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(spSm),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${destination["name"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                              SizedBox(height: spXs),
                              Row(
                                children: [
                                  Container(
                                    padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                    decoration: BoxDecoration(
                                      color: primaryColor.withAlpha(20),
                                      borderRadius: BorderRadius.circular(radiusXs),
                                    ),
                                    child: Text(
                                      "${destination["category"]}",
                                      style: TextStyle(
                                        fontSize: 10,
                                        color: primaryColor,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: spXs),
                              Text(
                                "${destination["searches"]}",
                                style: TextStyle(
                                  fontSize: 11,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
