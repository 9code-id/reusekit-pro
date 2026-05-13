import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class ReaFavoritesView extends StatefulWidget {
  const ReaFavoritesView({super.key});

  @override
  State<ReaFavoritesView> createState() => _ReaFavoritesViewState();
}

class _ReaFavoritesViewState extends State<ReaFavoritesView> {
  String selectedTab = "Properties";
  String selectedSortBy = "Recently Added";
  bool isListView = true;

  List<String> tabs = ["Properties", "Searches", "Agents"];
  List<String> sortOptions = ["Recently Added", "Price: Low to High", "Price: High to Low", "Alphabetical"];

  List<Map<String, dynamic>> favoriteProperties = [
    {
      "id": "prop_001",
      "title": "Modern Luxury Villa",
      "address": "123 Sunset Boulevard, Beverly Hills",
      "price": 2500000,
      "type": "Villa",
      "bedrooms": 5,
      "bathrooms": 4,
      "area": 4200,
      "image": "https://picsum.photos/300/200?random=1&keyword=villa",
      "agent": "Sarah Johnson",
      "rating": 4.9,
      "status": "For Sale",
      "addedToFavorites": "2024-01-20 14:30:00",
      "yearBuilt": 2020,
      "parking": 3,
      "amenities": ["Pool", "Garden", "Gym", "Wine Cellar"],
      "priceHistory": [2600000, 2550000, 2500000],
      "views": 1250,
      "inquiries": 45,
    },
    {
      "id": "prop_002",
      "title": "Downtown Penthouse",
      "address": "456 City Center, Manhattan",
      "price": 3200000,
      "type": "Penthouse",
      "bedrooms": 3,
      "bathrooms": 3,
      "area": 2800,
      "image": "https://picsum.photos/300/200?random=2&keyword=penthouse",
      "agent": "Mike Wilson",
      "rating": 4.8,
      "status": "For Sale",
      "addedToFavorites": "2024-01-18 09:15:00",
      "yearBuilt": 2019,
      "parking": 2,
      "amenities": ["City View", "Terrace", "Concierge", "Rooftop"],
      "priceHistory": [3300000, 3250000, 3200000],
      "views": 980,
      "inquiries": 67,
    },
    {
      "id": "prop_003",
      "title": "Family Suburban Home",
      "address": "789 Oak Tree Lane, Westfield",
      "price": 850000,
      "type": "House",
      "bedrooms": 4,
      "bathrooms": 3,
      "area": 2600,
      "image": "https://picsum.photos/300/200?random=3&keyword=house",
      "agent": "Emily Davis",
      "rating": 4.7,
      "status": "For Sale",
      "addedToFavorites": "2024-01-15 16:45:00",
      "yearBuilt": 2018,
      "parking": 2,
      "amenities": ["Garden", "Garage", "Deck", "Storage"],
      "priceHistory": [890000, 870000, 850000],
      "views": 756,
      "inquiries": 32,
    },
    {
      "id": "prop_004",
      "title": "Luxury Apartment",
      "address": "321 Harbor View, Waterfront",
      "price": 1200000,
      "type": "Apartment",
      "bedrooms": 2,
      "bathrooms": 2,
      "area": 1500,
      "image": "https://picsum.photos/300/200?random=4&keyword=apartment",
      "agent": "David Brown",
      "rating": 4.6,
      "status": "For Sale",
      "addedToFavorites": "2024-01-12 11:20:00",
      "yearBuilt": 2021,
      "parking": 1,
      "amenities": ["Water View", "Balcony", "Gym", "Pool"],
      "priceHistory": [1250000, 1225000, 1200000],
      "views": 892,
      "inquiries": 28,
    },
  ];

  List<Map<String, dynamic>> favoriteSearches = [
    {
      "id": "search_001",
      "name": "Beverly Hills Villas",
      "criteria": {
        "location": "Beverly Hills",
        "type": "Villa",
        "priceRange": "\$2M - \$5M",
        "bedrooms": "4+",
        "amenities": ["Pool", "Garden"]
      },
      "resultsCount": 23,
      "newListings": 3,
      "savedDate": "2024-01-20 10:30:00",
      "alertsEnabled": true,
      "lastUpdated": "2024-01-21 08:00:00",
    },
    {
      "id": "search_002",
      "name": "Downtown Penthouses",
      "criteria": {
        "location": "Downtown",
        "type": "Penthouse",
        "priceRange": "\$1M - \$3M",
        "bedrooms": "2+",
        "amenities": ["City View", "Terrace"]
      },
      "resultsCount": 15,
      "newListings": 1,
      "savedDate": "2024-01-18 14:15:00",
      "alertsEnabled": true,
      "lastUpdated": "2024-01-21 06:30:00",
    },
    {
      "id": "search_003",
      "name": "Suburban Family Homes",
      "criteria": {
        "location": "Suburbs",
        "type": "House",
        "priceRange": "\$500k - \$1M",
        "bedrooms": "3+",
        "amenities": ["Garden", "Garage"]
      },
      "resultsCount": 67,
      "newListings": 8,
      "savedDate": "2024-01-15 09:45:00",
      "alertsEnabled": false,
      "lastUpdated": "2024-01-21 07:15:00",
    },
  ];

  List<Map<String, dynamic>> favoriteAgents = [
    {
      "id": "agent_001",
      "name": "Sarah Johnson",
      "agency": "Premium Real Estate",
      "specialization": "Luxury Properties",
      "rating": 4.9,
      "reviews": 156,
      "experience": "8 years",
      "image": "https://picsum.photos/100/100?random=1&keyword=person",
      "contact": "+1 (555) 123-4567",
      "email": "sarah@premiumre.com",
      "languages": ["English", "Spanish"],
      "areas": ["Beverly Hills", "Manhattan", "Downtown"],
      "propertiesSold": 89,
      "addedToFavorites": "2024-01-19 15:30:00",
      "status": "Active",
    },
    {
      "id": "agent_002",
      "name": "Mike Wilson",
      "agency": "City Properties Inc",
      "specialization": "Commercial & Residential",
      "rating": 4.8,
      "reviews": 203,
      "experience": "12 years",
      "image": "https://picsum.photos/100/100?random=2&keyword=person",
      "contact": "+1 (555) 987-6543",
      "email": "mike@cityproperties.com",
      "languages": ["English", "French"],
      "areas": ["Downtown", "Midtown", "Financial District"],
      "propertiesSold": 145,
      "addedToFavorites": "2024-01-17 12:20:00",
      "status": "Active",
    },
    {
      "id": "agent_003",
      "name": "Emily Davis",
      "agency": "Suburban Realty",
      "specialization": "Family Homes",
      "rating": 4.7,
      "reviews": 98,
      "experience": "6 years",
      "image": "https://picsum.photos/100/100?random=3&keyword=person",
      "contact": "+1 (555) 456-7890",
      "email": "emily@suburbanrealty.com",
      "languages": ["English"],
      "areas": ["Westfield", "Suburbs", "Residential Areas"],
      "propertiesSold": 72,
      "addedToFavorites": "2024-01-14 10:45:00",
      "status": "Active",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Favorites"),
        actions: [
          IconButton(
            icon: Icon(isListView ? Icons.grid_view : Icons.list),
            onPressed: () {
              isListView = !isListView;
              setState(() {});
            },
          ),
          IconButton(
            icon: Icon(Icons.sort),
            onPressed: _showSortOptions,
          ),
        ],
      ),
      body: Column(
        children: [
          // Tab Bar
          Container(
            height: 60,
            padding: EdgeInsets.symmetric(horizontal: spMd, vertical: spSm),
            child: Row(
              children: tabs.map((tab) {
                bool isSelected = selectedTab == tab;
                return Expanded(
                  child: GestureDetector(
                    onTap: () {
                      selectedTab = tab;
                      setState(() {});
                    },
                    child: Container(
                      margin: EdgeInsets.only(right: tab != tabs.last ? spSm : 0),
                      padding: EdgeInsets.symmetric(vertical: spSm),
                      decoration: BoxDecoration(
                        color: isSelected ? primaryColor : Colors.transparent,
                        borderRadius: BorderRadius.circular(radiusSm),
                        border: Border.all(
                          color: isSelected ? primaryColor : disabledOutlineBorderColor,
                        ),
                      ),
                      child: Center(
                        child: Text(
                          tab,
                          style: TextStyle(
                            color: isSelected ? Colors.white : disabledBoldColor,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
          
          // Content
          Expanded(
            child: _buildTabContent(),
          ),
        ],
      ),
    );
  }

  Widget _buildTabContent() {
    switch (selectedTab) {
      case "Properties":
        return _buildPropertiesTab();
      case "Searches":
        return _buildSearchesTab();
      case "Agents":
        return _buildAgentsTab();
      default:
        return _buildPropertiesTab();
    }
  }

  Widget _buildPropertiesTab() {
    if (favoriteProperties.isEmpty) {
      return _buildEmptyState(
        "No Favorite Properties",
        "Properties you like will appear here",
        Icons.home,
      );
    }

    return isListView ? _buildPropertiesListView() : _buildPropertiesGridView();
  }

  Widget _buildPropertiesListView() {
    return ListView.builder(
      padding: EdgeInsets.all(spMd),
      itemCount: favoriteProperties.length,
      itemBuilder: (context, index) {
        final property = favoriteProperties[index];
        
        return Container(
          margin: EdgeInsets.only(bottom: spMd),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(radiusMd),
            boxShadow: [shadowSm],
          ),
          child: Column(
            children: [
              // Property Image
              Container(
                height: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(radiusMd),
                    topRight: Radius.circular(radiusMd),
                  ),
                  image: DecorationImage(
                    image: NetworkImage("${property["image"]}"),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Stack(
                  children: [
                    Positioned(
                      top: spSm,
                      right: spSm,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.red,
                          shape: BoxShape.circle,
                        ),
                        child: IconButton(
                          icon: Icon(Icons.favorite, color: Colors.white),
                          onPressed: () {
                            _removeFromFavorites(property);
                          },
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: spSm,
                      left: spSm,
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                        decoration: BoxDecoration(
                          color: Colors.black.withAlpha(127),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Text(
                          "${property["type"]}",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              
              // Property Details
              Padding(
                padding: EdgeInsets.all(spMd),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${property["title"]}",
                                style: TextStyle(
                                  fontSize: fsH6,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: spXs),
                              Text(
                                "${property["address"]}",
                                style: TextStyle(
                                  color: disabledBoldColor,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Text(
                          "\$${((property["price"] as int) / 1000000).toStringAsFixed(1)}M",
                          style: TextStyle(
                            color: primaryColor,
                            fontSize: fsH5,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spSm),
                    
                    // Property Features
                    Row(
                      children: [
                        _buildFeature(Icons.bed, "${property["bedrooms"]} Beds"),
                        SizedBox(width: spMd),
                        _buildFeature(Icons.bathtub, "${property["bathrooms"]} Baths"),
                        SizedBox(width: spMd),
                        _buildFeature(Icons.square_foot, "${property["area"]} sqft"),
                        Spacer(),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.star, color: warningColor, size: 16),
                            SizedBox(width: spXs),
                            Text(
                              "${property["rating"]}",
                              style: TextStyle(
                                color: disabledBoldColor,
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: spSm),
                    
                    // Price History
                    Text(
                      "Price History:",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Row(
                      children: [
                        ...((property["priceHistory"] as List).asMap().entries.map<Widget>((entry) {
                          int index = entry.key;
                          int price = entry.value;
                          bool isLast = index == (property["priceHistory"] as List).length - 1;
                          
                          return Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                "\$${(price / 1000000).toStringAsFixed(1)}M",
                                style: TextStyle(
                                  color: isLast ? primaryColor : disabledBoldColor,
                                  fontSize: 12,
                                  fontWeight: isLast ? FontWeight.bold : FontWeight.normal,
                                ),
                              ),
                              if (!isLast) ...[
                                SizedBox(width: spXs),
                                Icon(Icons.arrow_forward, size: 12, color: disabledBoldColor),
                                SizedBox(width: spXs),
                              ],
                            ],
                          );
                        })).toList(),
                        Spacer(),
                        Text(
                          "Added ${property["addedToFavorites"]}".split(' ')[0],
                          style: TextStyle(
                            color: disabledBoldColor,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spSm),
                    
                    // Action Buttons
                    Row(
                      children: [
                        Expanded(
                          child: QButton(
                            label: "View Details",
                            size: bs.sm,
                            onPressed: () {
                              // navigateTo('PropertyDetailView');
                            },
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: QButton(
                            label: "Contact Agent",
                            size: bs.sm,
                            onPressed: () {
                              // navigateTo('ContactAgentView');
                            },
                          ),
                        ),
                        SizedBox(width: spSm),
                        QButton(
                          icon: Icons.share,
                          size: bs.sm,
                          onPressed: () {
                            ss("Property shared successfully");
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
      },
    );
  }

  Widget _buildPropertiesGridView() {
    return GridView.builder(
      padding: EdgeInsets.all(spMd),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: spMd,
        mainAxisSpacing: spMd,
        childAspectRatio: 0.75,
      ),
      itemCount: favoriteProperties.length,
      itemBuilder: (context, index) {
        final property = favoriteProperties[index];
        
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(radiusMd),
            boxShadow: [shadowSm],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(radiusMd),
                      topRight: Radius.circular(radiusMd),
                    ),
                    image: DecorationImage(
                      image: NetworkImage("${property["image"]}"),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Stack(
                    children: [
                      Positioned(
                        top: spSm,
                        right: spSm,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.red,
                            shape: BoxShape.circle,
                          ),
                          child: IconButton(
                            icon: Icon(Icons.favorite, color: Colors.white, size: 16),
                            onPressed: () {
                              _removeFromFavorites(property);
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(spSm),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${property["title"]}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "\$${((property["price"] as int) / 1000000).toStringAsFixed(1)}M",
                      style: TextStyle(
                        color: primaryColor,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Row(
                      children: [
                        Icon(Icons.bed, color: disabledBoldColor, size: 14),
                        SizedBox(width: spXs),
                        Text(
                          "${property["bedrooms"]}",
                          style: TextStyle(
                            color: disabledBoldColor,
                            fontSize: 12,
                          ),
                        ),
                        SizedBox(width: spSm),
                        Icon(Icons.bathtub, color: disabledBoldColor, size: 14),
                        SizedBox(width: spXs),
                        Text(
                          "${property["bathrooms"]}",
                          style: TextStyle(
                            color: disabledBoldColor,
                            fontSize: 12,
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
      },
    );
  }

  Widget _buildSearchesTab() {
    if (favoriteSearches.isEmpty) {
      return _buildEmptyState(
        "No Saved Searches",
        "Searches you save will appear here",
        Icons.search,
      );
    }

    return ListView.builder(
      padding: EdgeInsets.all(spMd),
      itemCount: favoriteSearches.length,
      itemBuilder: (context, index) {
        final search = favoriteSearches[index];
        
        return Container(
          margin: EdgeInsets.only(bottom: spMd),
          padding: EdgeInsets.all(spMd),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(radiusMd),
            boxShadow: [shadowSm],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      "${search["name"]}",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Switch(
                    value: search["alertsEnabled"],
                    onChanged: (value) {
                      search["alertsEnabled"] = value;
                      setState(() {});
                      ss(value ? "Alerts enabled" : "Alerts disabled");
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.delete, color: dangerColor),
                    onPressed: () {
                      _removeSearch(search);
                    },
                  ),
                ],
              ),
              SizedBox(height: spSm),
              
              // Search Criteria
              Wrap(
                spacing: spSm,
                runSpacing: spXs,
                children: (search["criteria"] as Map<String, dynamic>).entries.map<Widget>((entry) {
                  return Container(
                    padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Text(
                      "${entry.key}: ${entry.value}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  );
                }).toList(),
              ),
              SizedBox(height: spSm),
              
              // Search Statistics
              Row(
                children: [
                  _buildSearchStat("Results", "${search["resultsCount"]}"),
                  SizedBox(width: spMd),
                  _buildSearchStat("New", "${search["newListings"]}"),
                  Spacer(),
                  Text(
                    "Updated ${search["lastUpdated"]}".split(' ')[0],
                    style: TextStyle(
                      color: disabledBoldColor,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
              SizedBox(height: spSm),
              
              // Action Buttons
              Row(
                children: [
                  Expanded(
                    child: QButton(
                      label: "View Results",
                      size: bs.sm,
                      onPressed: () {
                        // navigateTo('SearchResultsView');
                      },
                    ),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: QButton(
                      label: "Edit Search",
                      size: bs.sm,
                      onPressed: () {
                        // navigateTo('EditSearchView');
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildAgentsTab() {
    if (favoriteAgents.isEmpty) {
      return _buildEmptyState(
        "No Favorite Agents",
        "Agents you like will appear here",
        Icons.person,
      );
    }

    return ListView.builder(
      padding: EdgeInsets.all(spMd),
      itemCount: favoriteAgents.length,
      itemBuilder: (context, index) {
        final agent = favoriteAgents[index];
        
        return Container(
          margin: EdgeInsets.only(bottom: spMd),
          padding: EdgeInsets.all(spMd),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(radiusMd),
            boxShadow: [shadowSm],
          ),
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: NetworkImage("${agent["image"]}"),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(width: spMd),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${agent["name"]}",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "${agent["agency"]}",
                          style: TextStyle(
                            color: primaryColor,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Row(
                          children: [
                            Icon(Icons.star, color: warningColor, size: 16),
                            SizedBox(width: spXs),
                            Text(
                              "${agent["rating"]} (${agent["reviews"]} reviews)",
                              style: TextStyle(
                                color: disabledBoldColor,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.favorite, color: Colors.red),
                    onPressed: () {
                      _removeAgent(agent);
                    },
                  ),
                ],
              ),
              SizedBox(height: spMd),
              
              // Agent Details
              Row(
                children: [
                  _buildAgentDetail("Experience", "${agent["experience"]}"),
                  SizedBox(width: spMd),
                  _buildAgentDetail("Properties Sold", "${agent["propertiesSold"]}"),
                  Spacer(),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                    decoration: BoxDecoration(
                      color: successColor.withAlpha(51),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Text(
                      "${agent["status"]}",
                      style: TextStyle(
                        color: successColor,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: spSm),
              
              // Specialization and Areas
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Specialization:",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          "${agent["specialization"]}",
                          style: TextStyle(
                            color: disabledBoldColor,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Areas:",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          (agent["areas"] as List).join(", "),
                          style: TextStyle(
                            color: disabledBoldColor,
                            fontSize: 12,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: spMd),
              
              // Action Buttons
              Row(
                children: [
                  Expanded(
                    child: QButton(
                      label: "View Profile",
                      size: bs.sm,
                      onPressed: () {
                        // navigateTo('AgentProfileView');
                      },
                    ),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: QButton(
                      label: "Contact",
                      size: bs.sm,
                      onPressed: () {
                        // navigateTo('ContactAgentView');
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildEmptyState(String title, String subtitle, IconData icon) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(spLg),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 64,
              color: disabledBoldColor,
            ),
            SizedBox(height: spMd),
            Text(
              title,
              style: TextStyle(
                fontSize: fsH5,
                fontWeight: FontWeight.bold,
                color: disabledBoldColor,
              ),
            ),
            SizedBox(height: spSm),
            Text(
              subtitle,
              style: TextStyle(
                color: disabledBoldColor,
                fontSize: 16,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: spLg),
            QButton(
              label: "Explore Properties",
              size: bs.md,
              onPressed: () {
                // navigateTo('ExploreView');
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeature(IconData icon, String text) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: disabledBoldColor, size: 16),
        SizedBox(width: spXs),
        Text(
          text,
          style: TextStyle(
            color: disabledBoldColor,
            fontSize: 12,
          ),
        ),
      ],
    );
  }

  Widget _buildSearchStat(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: disabledBoldColor,
          ),
        ),
      ],
    );
  }

  Widget _buildAgentDetail(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: disabledBoldColor,
          ),
        ),
      ],
    );
  }

  void _removeFromFavorites(Map<String, dynamic> property) async {
    bool isConfirmed = await confirm("Remove this property from favorites?");
    if (isConfirmed) {
      favoriteProperties.remove(property);
      setState(() {});
      ss("Removed from favorites");
    }
  }

  void _removeSearch(Map<String, dynamic> search) async {
    bool isConfirmed = await confirm("Delete this saved search?");
    if (isConfirmed) {
      favoriteSearches.remove(search);
      setState(() {});
      ss("Search deleted");
    }
  }

  void _removeAgent(Map<String, dynamic> agent) async {
    bool isConfirmed = await confirm("Remove this agent from favorites?");
    if (isConfirmed) {
      favoriteAgents.remove(agent);
      setState(() {});
      ss("Agent removed from favorites");
    }
  }

  void _showSortOptions() {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: EdgeInsets.all(spMd),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Sort By",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: spMd),
            ...sortOptions.map((option) {
              bool isSelected = selectedSortBy == option;
              return ListTile(
                leading: Icon(
                  isSelected ? Icons.radio_button_checked : Icons.radio_button_off,
                  color: isSelected ? primaryColor : disabledBoldColor,
                ),
                title: Text(option),
                onTap: () {
                  selectedSortBy = option;
                  Navigator.pop(context);
                  setState(() {});
                },
              );
            }).toList(),
          ],
        ),
      ),
    );
  }
}
