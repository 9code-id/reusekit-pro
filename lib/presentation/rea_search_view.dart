import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class ReaSearchView extends StatefulWidget {
  const ReaSearchView({super.key});

  @override
  State<ReaSearchView> createState() => _ReaSearchViewState();
}

class _ReaSearchViewState extends State<ReaSearchView> {
  String searchQuery = "";
  String selectedPropertyType = "All";
  String selectedLocation = "";
  String minPrice = "";
  String maxPrice = "";
  String bedrooms = "";
  String bathrooms = "";
  bool hasParking = false;
  bool hasGarden = false;
  bool hasFurnishing = false;

  final List<String> propertyTypes = [
    "All",
    "Apartment",
    "House",
    "Villa",
    "Townhouse",
    "Studio",
    "Penthouse",
    "Commercial",
  ];

  final List<Map<String, dynamic>> popularSearches = [
    {
      "query": "3 BHK Apartment in Downtown",
      "count": "245 properties",
      "icon": Icons.apartment,
    },
    {
      "query": "Luxury Villa with Pool",
      "count": "89 properties",
      "icon": Icons.villa,
    },
    {
      "query": "Studio near Metro Station",
      "count": "156 properties",
      "icon": Icons.train,
    },
    {
      "query": "Commercial Space CBD",
      "count": "78 properties",
      "icon": Icons.business,
    },
    {
      "query": "Furnished Apartment",
      "count": "312 properties",
      "icon": Icons.chair,
    },
  ];

  final List<Map<String, dynamic>> recentSearches = [
    {
      "query": "2 BHK in Westside",
      "date": "2 hours ago",
      "results": 42,
    },
    {
      "query": "House under \$500k",
      "date": "1 day ago", 
      "results": 28,
    },
    {
      "query": "Penthouse with view",
      "date": "3 days ago",
      "results": 15,
    },
  ];

  final List<Map<String, dynamic>> quickFilters = [
    {"label": "Under \$300K", "value": "under_300k"},
    {"label": "New Listings", "value": "new"},
    {"label": "Price Reduced", "value": "reduced"},
    {"label": "Open House", "value": "open_house"},
    {"label": "Virtual Tour", "value": "virtual_tour"},
    {"label": "Furnished", "value": "furnished"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Search Properties"),
        actions: [
          IconButton(
            icon: Icon(Icons.map),
            onPressed: _openMapSearch,
          ),
          IconButton(
            icon: Icon(Icons.tune),
            onPressed: _openAdvancedFilters,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search input
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                children: [
                  // Main search bar
                  Container(
                    padding: EdgeInsets.all(spSm),
                    child: Row(
                      children: [
                        Icon(
                          Icons.search,
                          color: disabledBoldColor,
                          size: 24,
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: QTextField(
                            label: "Search by location, property type...",
                            value: searchQuery,
                            onChanged: (value) {
                              searchQuery = value;
                              setState(() {});
                            },
                          ),
                        ),
                        SizedBox(width: spSm),
                        QButton(
                          icon: Icons.mic,
                          size: bs.sm,
                          onPressed: _voiceSearch,
                        ),
                      ],
                    ),
                  ),

                  // Quick property type selector
                  Container(
                    height: 50,
                    padding: EdgeInsets.symmetric(horizontal: spSm),
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: propertyTypes.length,
                      itemBuilder: (context, index) {
                        final type = propertyTypes[index];
                        final isSelected = type == selectedPropertyType;

                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedPropertyType = type;
                            });
                          },
                          child: Container(
                            margin: EdgeInsets.only(right: spSm),
                            padding: EdgeInsets.symmetric(
                              horizontal: spSm,
                              vertical: spXs,
                            ),
                            decoration: BoxDecoration(
                              color: isSelected ? primaryColor : Colors.transparent,
                              borderRadius: BorderRadius.circular(radiusSm),
                              border: Border.all(
                                color: isSelected ? primaryColor : disabledOutlineBorderColor,
                              ),
                            ),
                            child: Center(
                              child: Text(
                                type,
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  color: isSelected ? Colors.white : disabledBoldColor,
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),

                  // Quick filters
                  Container(
                    padding: EdgeInsets.all(spSm),
                    child: Wrap(
                      spacing: spXs,
                      runSpacing: spXs,
                      children: quickFilters.map((filter) {
                        return Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: spSm,
                            vertical: spXs,
                          ),
                          decoration: BoxDecoration(
                            color: primaryColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Text(
                            "${filter["label"]}",
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w500,
                              color: primaryColor,
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),

                  // Search button
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(spSm),
                    child: QButton(
                      label: "Search Properties",
                      onPressed: _performSearch,
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: spMd),

            // Popular searches
            Text(
              "Popular Searches",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spSm),

            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                children: popularSearches.map((search) {
                  final index = popularSearches.indexOf(search);
                  return GestureDetector(
                    onTap: () => _selectPopularSearch(search),
                    child: Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        border: index < popularSearches.length - 1
                            ? Border(
                                bottom: BorderSide(
                                  color: disabledOutlineBorderColor,
                                  width: 1,
                                ),
                              )
                            : null,
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: primaryColor.withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Icon(
                              search["icon"] as IconData,
                              color: primaryColor,
                              size: 20,
                            ),
                          ),
                          SizedBox(width: spSm),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${search["query"]}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: primaryColor,
                                  ),
                                ),
                                SizedBox(height: spXs),
                                Text(
                                  "${search["count"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Icon(
                            Icons.trending_up,
                            color: successColor,
                            size: 16,
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),

            SizedBox(height: spMd),

            // Recent searches
            if (recentSearches.isNotEmpty) ...[
              Row(
                children: [
                  Text(
                    "Recent Searches",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Spacer(),
                  GestureDetector(
                    onTap: _clearRecentSearches,
                    child: Text(
                      "Clear All",
                      style: TextStyle(
                        fontSize: 12,
                        color: dangerColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: spSm),

              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  children: recentSearches.map((search) {
                    final index = recentSearches.indexOf(search);
                    return GestureDetector(
                      onTap: () => _selectRecentSearch(search),
                      child: Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          border: index < recentSearches.length - 1
                              ? Border(
                                  bottom: BorderSide(
                                    color: disabledOutlineBorderColor,
                                    width: 1,
                                  ),
                                )
                              : null,
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.history,
                              color: disabledBoldColor,
                              size: 20,
                            ),
                            SizedBox(width: spSm),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${search["query"]}",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      color: primaryColor,
                                    ),
                                  ),
                                  SizedBox(height: spXs),
                                  Text(
                                    "${search["date"]} • ${search["results"]} results",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            GestureDetector(
                              onTap: () => _removeRecentSearch(search),
                              child: Icon(
                                Icons.close,
                                color: disabledBoldColor,
                                size: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),

              SizedBox(height: spMd),
            ],

            // Search suggestions
            Text(
              "Search Suggestions",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spSm),

            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                children: [
                  _buildSearchSuggestion(
                    "Property near schools",
                    Icons.school,
                    "Family-friendly neighborhoods",
                  ),
                  _buildSearchSuggestion(
                    "Pet-friendly properties",
                    Icons.pets,
                    "Allows pets and has outdoor space",
                  ),
                  _buildSearchSuggestion(
                    "Investment properties",
                    Icons.trending_up,
                    "High rental yield potential",
                  ),
                  _buildSearchSuggestion(
                    "Waterfront properties",
                    Icons.water,
                    "Ocean, lake or river views",
                  ),
                ],
              ),
            ),

            SizedBox(height: spMd),

            // Quick access buttons
            Row(
              children: [
                Expanded(
                  child: QButton(
                    label: "Map Search",
                    icon: Icons.map,
                    onPressed: _openMapSearch,
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QButton(
                    label: "Advanced Filters",
                    icon: Icons.tune,
                    onPressed: _openAdvancedFilters,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchSuggestion(String title, IconData icon, String description) {
    return GestureDetector(
      onTap: () => _selectSuggestion(title),
      child: Container(
        padding: EdgeInsets.all(spSm),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: disabledOutlineBorderColor,
              width: 1,
            ),
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: infoColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Icon(
                icon,
                color: infoColor,
                size: 20,
              ),
            ),
            SizedBox(width: spSm),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spXs),
                  Text(
                    description,
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
              color: disabledBoldColor,
              size: 16,
            ),
          ],
        ),
      ),
    );
  }

  void _performSearch() {
    if (searchQuery.isEmpty && selectedPropertyType == "All") {
      sw("Please enter search criteria");
      return;
    }
    ss("Searching for properties...");
  }

  void _voiceSearch() {
    ss("Voice search activated");
  }

  void _openMapSearch() {
    ss("Opening map search...");
  }

  void _openAdvancedFilters() {
    ss("Opening advanced filters...");
  }

  void _selectPopularSearch(Map<String, dynamic> search) {
    setState(() {
      searchQuery = search["query"];
    });
    ss("Selected popular search: ${search["query"]}");
  }

  void _selectRecentSearch(Map<String, dynamic> search) {
    setState(() {
      searchQuery = search["query"];
    });
    ss("Selected recent search: ${search["query"]}");
  }

  void _selectSuggestion(String suggestion) {
    setState(() {
      searchQuery = suggestion;
    });
    ss("Selected suggestion: $suggestion");
  }

  void _removeRecentSearch(Map<String, dynamic> search) {
    setState(() {
      recentSearches.remove(search);
    });
    ss("Removed from recent searches");
  }

  void _clearRecentSearches() {
    setState(() {
      recentSearches.clear();
    });
    ss("Recent searches cleared");
  }
}
