import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class EmaSearchView extends StatefulWidget {
  const EmaSearchView({super.key});

  @override
  State<EmaSearchView> createState() => _EmaSearchViewState();
}

class _EmaSearchViewState extends State<EmaSearchView> {
  String searchQuery = "";
  String selectedCategory = "All";
  String selectedLocation = "All";
  String selectedDateRange = "All";
  String selectedPriceRange = "All";
  String sortBy = "relevance";
  bool showFilters = false;
  
  List<String> recentSearches = [
    "Tech conferences",
    "Business workshops",
    "Food festivals",
    "Art exhibitions",
    "Fitness classes"
  ];
  
  List<String> popularSearches = [
    "JavaScript workshop",
    "Digital marketing",
    "Photography course",
    "Startup meetup",
    "Cooking class",
    "Yoga retreat",
    "Music concert",
    "Book club"
  ];
  
  List<Map<String, dynamic>> searchResults = [
    {
      "id": 1,
      "title": "Advanced JavaScript Workshop",
      "category": "Technology",
      "date": "2024-02-20",
      "time": "10:00",
      "location": "Tech Hub Downtown",
      "price": 149.0,
      "image": "https://picsum.photos/400/300?random=301&keyword=javascript",
      "organizer": "Code Academy",
      "rating": 4.8,
      "attendees": 450,
      "isVerified": true,
      "isFeatured": true,
      "tags": ["JavaScript", "Programming", "Web Development"],
      "description": "Master advanced JavaScript concepts and modern frameworks",
      "relevanceScore": 98
    },
    {
      "id": 2,
      "title": "Digital Marketing Bootcamp",
      "category": "Business",
      "date": "2024-02-25",
      "time": "09:00",
      "location": "Business Center",
      "price": 299.0,
      "image": "https://picsum.photos/400/300?random=302&keyword=marketing",
      "organizer": "Marketing Pro",
      "rating": 4.7,
      "attendees": 320,
      "isVerified": true,
      "isFeatured": false,
      "tags": ["Marketing", "Digital", "Strategy"],
      "description": "Comprehensive digital marketing strategies for modern businesses",
      "relevanceScore": 95
    },
    {
      "id": 3,
      "title": "Photography Masterclass",
      "category": "Arts & Culture",
      "date": "2024-03-01",
      "time": "14:00",
      "location": "Creative Studio",
      "price": 199.0,
      "image": "https://picsum.photos/400/300?random=303&keyword=photography",
      "organizer": "Visual Arts Academy",
      "rating": 4.9,
      "attendees": 85,
      "isVerified": true,
      "isFeatured": false,
      "tags": ["Photography", "Art", "Creative"],
      "description": "Learn professional photography techniques from industry experts",
      "relevanceScore": 92
    },
    {
      "id": 4,
      "title": "Startup Pitch Competition",
      "category": "Business",
      "date": "2024-03-05",
      "time": "18:00",
      "location": "Innovation Hub",
      "price": 0.0,
      "image": "https://picsum.photos/400/300?random=304&keyword=startup",
      "organizer": "Entrepreneur Network",
      "rating": 4.6,
      "attendees": 200,
      "isVerified": true,
      "isFeatured": true,
      "tags": ["Startup", "Entrepreneurship", "Networking"],
      "description": "Pitch your startup idea to investors and industry experts",
      "relevanceScore": 88
    },
    {
      "id": 5,
      "title": "Gourmet Cooking Class",
      "category": "Food & Drink",
      "date": "2024-03-08",
      "time": "16:00",
      "location": "Culinary Institute",
      "price": 125.0,
      "image": "https://picsum.photos/400/300?random=305&keyword=cooking",
      "organizer": "Chef's Academy",
      "rating": 4.8,
      "attendees": 60,
      "isVerified": false,
      "isFeatured": false,
      "tags": ["Cooking", "Culinary", "Gourmet"],
      "description": "Learn to cook restaurant-quality dishes with professional chefs",
      "relevanceScore": 85
    },
    {
      "id": 6,
      "title": "Yoga & Mindfulness Retreat",
      "category": "Health & Wellness",
      "date": "2024-03-12",
      "time": "08:00",
      "location": "Wellness Center",
      "price": 89.0,
      "image": "https://picsum.photos/400/300?random=306&keyword=yoga",
      "organizer": "Mindful Living",
      "rating": 4.9,
      "attendees": 120,
      "isVerified": true,
      "isFeatured": false,
      "tags": ["Yoga", "Meditation", "Wellness"],
      "description": "Rejuvenate your mind and body with yoga and meditation practices",
      "relevanceScore": 82
    }
  ];
  
  List<String> categories = [
    "All", "Technology", "Business", "Arts & Culture", 
    "Food & Drink", "Health & Wellness", "Sports", "Education"
  ];
  
  List<String> locations = [
    "All", "Downtown", "Uptown", "East Side", "West Side", "Online"
  ];

  List<Map<String, dynamic>> get filteredResults {
    List<Map<String, dynamic>> filtered = searchResults.where((event) {
      bool matchesQuery = searchQuery.isEmpty || 
          event["title"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
          event["description"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
          (event["tags"] as List).any((tag) => tag.toString().toLowerCase().contains(searchQuery.toLowerCase()));
      
      bool matchesCategory = selectedCategory == "All" || event["category"] == selectedCategory;
      
      return matchesQuery && matchesCategory;
    }).toList();

    // Sort results
    switch (sortBy) {
      case "relevance":
        filtered.sort((a, b) => (b["relevanceScore"] as int).compareTo(a["relevanceScore"] as int));
        break;
      case "date":
        filtered.sort((a, b) => a["date"].compareTo(b["date"]));
        break;
      case "price_low":
        filtered.sort((a, b) => (a["price"] as double).compareTo(b["price"] as double));
        break;
      case "price_high":
        filtered.sort((a, b) => (b["price"] as double).compareTo(a["price"] as double));
        break;
      case "rating":
        filtered.sort((a, b) => (b["rating"] as double).compareTo(a["rating"] as double));
        break;
      case "popular":
        filtered.sort((a, b) => (b["attendees"] as int).compareTo(a["attendees"] as int));
        break;
    }

    return filtered;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Search Events"),
        actions: [
          IconButton(
            icon: Icon(showFilters ? Icons.filter_list_off : Icons.filter_list),
            onPressed: () {
              showFilters = !showFilters;
              setState(() {});
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search Bar
            Row(
              children: [
                Expanded(
                  child: QTextField(
                    label: "Search events, organizers, or keywords...",
                    value: searchQuery,
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
                  onPressed: () => _performSearch(),
                ),
              ],
            ),
            
            // Quick Category Filter
            if (!showFilters)
              Container(
                margin: EdgeInsets.symmetric(vertical: spSm),
                child: QCategoryPicker(
                  items: categories.map((category) => {
                    "label": category,
                    "value": category,
                  }).toList(),
                  value: selectedCategory,
                  onChanged: (index, label, value, item) {
                    selectedCategory = value;
                    setState(() {});
                  },
                ),
              ),
            
            // Advanced Filters
            if (showFilters)
              Container(
                margin: EdgeInsets.symmetric(vertical: spSm),
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.grey.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                  border: Border.all(color: disabledOutlineBorderColor),
                ),
                child: Column(
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
                    SizedBox(height: spSm),
                    
                    Row(
                      children: [
                        Expanded(
                          child: QDropdownField(
                            label: "Category",
                            items: categories.map((category) => {
                              "label": category,
                              "value": category,
                            }).toList(),
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
                            label: "Location",
                            items: locations.map((location) => {
                              "label": location,
                              "value": location,
                            }).toList(),
                            value: selectedLocation,
                            onChanged: (value, label) {
                              selectedLocation = value;
                              setState(() {});
                            },
                          ),
                        ),
                      ],
                    ),
                    
                    SizedBox(height: spSm),
                    
                    Row(
                      children: [
                        Expanded(
                          child: QDropdownField(
                            label: "Date Range",
                            items: [
                              {"label": "All", "value": "All"},
                              {"label": "Today", "value": "today"},
                              {"label": "This Week", "value": "week"},
                              {"label": "This Month", "value": "month"},
                              {"label": "Next 3 Months", "value": "quarter"},
                            ],
                            value: selectedDateRange,
                            onChanged: (value, label) {
                              selectedDateRange = value;
                              setState(() {});
                            },
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: QDropdownField(
                            label: "Price Range",
                            items: [
                              {"label": "All", "value": "All"},
                              {"label": "Free", "value": "free"},
                              {"label": "Under \$50", "value": "under_50"},
                              {"label": "\$50 - \$200", "value": "50_200"},
                              {"label": "Over \$200", "value": "over_200"},
                            ],
                            value: selectedPriceRange,
                            onChanged: (value, label) {
                              selectedPriceRange = value;
                              setState(() {});
                            },
                          ),
                        ),
                      ],
                    ),
                    
                    SizedBox(height: spSm),
                    
                    Row(
                      children: [
                        Expanded(
                          child: QButton(
                            label: "Apply Filters",
                            size: bs.sm,
                            onPressed: () => _applyFilters(),
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: QButton(
                            label: "Clear All",
                            size: bs.sm,
                            onPressed: () => _clearFilters(),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            
            // Sort Options
            if (searchQuery.isNotEmpty || selectedCategory != "All")
              Row(
                children: [
                  Text(
                    "Sort by:",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: QDropdownField(
                      label: "Sort",
                      items: [
                        {"label": "Relevance", "value": "relevance"},
                        {"label": "Date", "value": "date"},
                        {"label": "Price: Low to High", "value": "price_low"},
                        {"label": "Price: High to Low", "value": "price_high"},
                        {"label": "Rating", "value": "rating"},
                        {"label": "Most Popular", "value": "popular"},
                      ],
                      value: sortBy,
                      onChanged: (value, label) {
                        sortBy = value;
                        setState(() {});
                      },
                    ),
                  ),
                ],
              ),
            
            // Search Results or Default Content
            if (searchQuery.isNotEmpty || selectedCategory != "All")
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: spMd),
                  
                  // Results Header
                  Row(
                    children: [
                      Text(
                        "Search Results (${filteredResults.length})",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Spacer(),
                      if (searchQuery.isNotEmpty)
                        GestureDetector(
                          onTap: () => _saveSearch(),
                          child: Text(
                            "Save Search",
                            style: TextStyle(
                              fontSize: 14,
                              color: secondaryColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                    ],
                  ),
                  
                  SizedBox(height: spSm),
                  
                  // Search Results
                  ...filteredResults.map((event) => Container(
                    margin: EdgeInsets.only(bottom: spSm),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusSm),
                      boxShadow: [shadowSm],
                      border: Border.all(color: disabledOutlineBorderColor),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Event Image
                        Stack(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(radiusSm),
                                topRight: Radius.circular(radiusSm),
                              ),
                              child: Image.network(
                                "${event["image"]}",
                                height: 160,
                                width: double.infinity,
                                fit: BoxFit.cover,
                              ),
                            ),
                            
                            // Featured Badge
                            if (event["isFeatured"] == true)
                              Positioned(
                                top: spSm,
                                left: spSm,
                                child: Container(
                                  padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 4),
                                  decoration: BoxDecoration(
                                    color: warningColor,
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                  child: Text(
                                    "FEATURED",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            
                            // Verified Badge
                            if (event["isVerified"] == true)
                              Positioned(
                                top: spSm,
                                right: spSm,
                                child: Container(
                                  padding: EdgeInsets.all(4),
                                  decoration: BoxDecoration(
                                    color: successColor,
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                  child: Icon(
                                    Icons.verified,
                                    color: Colors.white,
                                    size: 16,
                                  ),
                                ),
                              ),
                            
                            // Price Badge
                            Positioned(
                              bottom: spSm,
                              right: spSm,
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 4),
                                decoration: BoxDecoration(
                                  color: event["price"] == 0 ? successColor : primaryColor,
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: Text(
                                  event["price"] == 0 ? "FREE" : "\$${((event["price"] as double)).currency}",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        
                        // Event Details
                        Padding(
                          padding: EdgeInsets.all(spSm),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Title and Category
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      "${event["title"]}",
                                      style: TextStyle(
                                        fontSize: fsH6,
                                        fontWeight: FontWeight.bold,
                                        color: primaryColor,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                    decoration: BoxDecoration(
                                      color: infoColor.withAlpha(20),
                                      borderRadius: BorderRadius.circular(radiusXs),
                                      border: Border.all(color: infoColor.withAlpha(100)),
                                    ),
                                    child: Text(
                                      "${event["category"]}",
                                      style: TextStyle(
                                        fontSize: 10,
                                        color: infoColor,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              
                              SizedBox(height: spXs),
                              
                              // Description
                              Text(
                                "${event["description"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              
                              SizedBox(height: spXs),
                              
                              // Date and Location
                              Row(
                                children: [
                                  Icon(
                                    Icons.calendar_today,
                                    size: 14,
                                    color: disabledBoldColor,
                                  ),
                                  SizedBox(width: 4),
                                  Text(
                                    "${DateTime.parse(event["date"]).dMMMy} at ${event["time"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                ],
                              ),
                              
                              SizedBox(height: 4),
                              
                              Row(
                                children: [
                                  Icon(
                                    Icons.location_on,
                                    size: 14,
                                    color: disabledBoldColor,
                                  ),
                                  SizedBox(width: 4),
                                  Expanded(
                                    child: Text(
                                      "${event["location"]}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              
                              SizedBox(height: spXs),
                              
                              // Rating and Attendees
                              Row(
                                children: [
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.star,
                                        size: 16,
                                        color: warningColor,
                                      ),
                                      SizedBox(width: 4),
                                      Text(
                                        "${event["rating"]}",
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                          color: primaryColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(width: spSm),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.people,
                                        size: 16,
                                        color: disabledBoldColor,
                                      ),
                                      SizedBox(width: 4),
                                      Text(
                                        "${event["attendees"]} attending",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Spacer(),
                                  Text(
                                    "by ${event["organizer"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                      fontStyle: FontStyle.italic,
                                    ),
                                  ),
                                ],
                              ),
                              
                              // Tags
                              if (event["tags"] != null && (event["tags"] as List).isNotEmpty)
                                Container(
                                  margin: EdgeInsets.only(top: spXs),
                                  child: Wrap(
                                    spacing: spXs,
                                    runSpacing: 4,
                                    children: (event["tags"] as List).take(3).map((tag) => Container(
                                      padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                      decoration: BoxDecoration(
                                        color: secondaryColor.withAlpha(20),
                                        borderRadius: BorderRadius.circular(radiusXs),
                                        border: Border.all(color: secondaryColor.withAlpha(100)),
                                      ),
                                      child: Text(
                                        "${tag}",
                                        style: TextStyle(
                                          fontSize: 10,
                                          color: secondaryColor,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    )).toList(),
                                  ),
                                ),
                              
                              SizedBox(height: spSm),
                              
                              // Action Buttons
                              Row(
                                children: [
                                  Expanded(
                                    child: QButton(
                                      label: "View Details",
                                      size: bs.sm,
                                      onPressed: () => _viewEventDetails(event),
                                    ),
                                  ),
                                  SizedBox(width: spSm),
                                  QButton(
                                    icon: Icons.bookmark_border,
                                    size: bs.sm,
                                    onPressed: () => _saveEvent(event),
                                  ),
                                  SizedBox(width: spXs),
                                  QButton(
                                    icon: Icons.share,
                                    size: bs.sm,
                                    onPressed: () => _shareEvent(event),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )).toList(),
                  
                  // No Results
                  if (filteredResults.isEmpty)
                    Container(
                      padding: EdgeInsets.all(spLg),
                      child: Column(
                        children: [
                          Icon(
                            Icons.search_off,
                            size: 64,
                            color: disabledColor,
                          ),
                          SizedBox(height: spSm),
                          Text(
                            "No events found",
                            style: TextStyle(
                              fontSize: fsH6,
                              fontWeight: FontWeight.bold,
                              color: disabledBoldColor,
                            ),
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "Try adjusting your search terms or filters",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              )
            else
              // Default Search Content
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: spMd),
                  
                  // Recent Searches
                  if (recentSearches.isNotEmpty)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
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
                              onTap: () => _clearRecentSearches(),
                              child: Text(
                                "Clear All",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: dangerColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: spSm),
                        Wrap(
                          spacing: spXs,
                          runSpacing: spXs,
                          children: recentSearches.map((search) => GestureDetector(
                            onTap: () => _selectSearch(search),
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                              decoration: BoxDecoration(
                                color: primaryColor.withAlpha(10),
                                borderRadius: BorderRadius.circular(radiusSm),
                                border: Border.all(color: primaryColor.withAlpha(50)),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    Icons.history,
                                    size: 16,
                                    color: primaryColor,
                                  ),
                                  SizedBox(width: 4),
                                  Text(
                                    search,
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: primaryColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )).toList(),
                        ),
                        SizedBox(height: spMd),
                      ],
                    ),
                  
                  // Popular Searches
                  Text(
                    "Popular Searches",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spSm),
                  Wrap(
                    spacing: spXs,
                    runSpacing: spXs,
                    children: popularSearches.map((search) => GestureDetector(
                      onTap: () => _selectSearch(search),
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                        decoration: BoxDecoration(
                          color: secondaryColor.withAlpha(10),
                          borderRadius: BorderRadius.circular(radiusSm),
                          border: Border.all(color: secondaryColor.withAlpha(50)),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.trending_up,
                              size: 16,
                              color: secondaryColor,
                            ),
                            SizedBox(width: 4),
                            Text(
                              search,
                              style: TextStyle(
                                fontSize: 14,
                                color: secondaryColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    )).toList(),
                  ),
                  
                  SizedBox(height: spMd),
                  
                  // Search Tips
                  Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: infoColor.withAlpha(10),
                      borderRadius: BorderRadius.circular(radiusSm),
                      border: Border.all(color: infoColor.withAlpha(50)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.lightbulb_outline,
                              size: 20,
                              color: infoColor,
                            ),
                            SizedBox(width: spXs),
                            Text(
                              "Search Tips",
                              style: TextStyle(
                                fontSize: fsH6,
                                fontWeight: FontWeight.bold,
                                color: infoColor,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "• Search by event name, organizer, or keywords\n• Use quotes for exact phrases\n• Try different category filters\n• Check spelling and try synonyms",
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }

  void _performSearch() {
    if (searchQuery.trim().isNotEmpty && !recentSearches.contains(searchQuery.trim())) {
      recentSearches.insert(0, searchQuery.trim());
      if (recentSearches.length > 5) {
        recentSearches.removeLast();
      }
      setState(() {});
    }
  }

  void _selectSearch(String search) {
    searchQuery = search;
    setState(() {});
    _performSearch();
  }

  void _applyFilters() {
    // Apply advanced filters
    setState(() {});
  }

  void _clearFilters() {
    selectedCategory = "All";
    selectedLocation = "All";
    selectedDateRange = "All";
    selectedPriceRange = "All";
    setState(() {});
  }

  void _clearRecentSearches() {
    recentSearches.clear();
    setState(() {});
  }

  void _saveSearch() {
    ss("Search saved successfully!");
  }

  void _viewEventDetails(Map<String, dynamic> event) {
    // Navigate to event details
  }

  void _saveEvent(Map<String, dynamic> event) {
    ss("Event saved to your bookmarks!");
  }

  void _shareEvent(Map<String, dynamic> event) {
    ss("Event shared successfully!");
  }
}
