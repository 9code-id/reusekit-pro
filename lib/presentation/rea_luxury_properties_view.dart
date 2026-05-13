import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class ReaLuxuryPropertiesView extends StatefulWidget {
  const ReaLuxuryPropertiesView({super.key});

  @override
  State<ReaLuxuryPropertiesView> createState() => _ReaLuxuryPropertiesViewState();
}

class _ReaLuxuryPropertiesViewState extends State<ReaLuxuryPropertiesView> {
  String selectedFilter = "All";
  String priceRange = "Any";
  String locationFilter = "All";
  String sortBy = "Featured";
  String searchQuery = "";
  bool loading = false;

  List<Map<String, dynamic>> filterOptions = [
    {"label": "All", "value": "All"},
    {"label": "Villa", "value": "Villa"},
    {"label": "Penthouse", "value": "Penthouse"},
    {"label": "Mansion", "value": "Mansion"},
    {"label": "Estate", "value": "Estate"},
  ];

  List<Map<String, dynamic>> priceRanges = [
    {"label": "Any", "value": "Any"},
    {"label": "\$1M - \$2M", "value": "1000000-2000000"},
    {"label": "\$2M - \$5M", "value": "2000000-5000000"},
    {"label": "\$5M - \$10M", "value": "5000000-10000000"},
    {"label": "Above \$10M", "value": "Above 10000000"},
  ];

  List<Map<String, dynamic>> locations = [
    {"label": "All", "value": "All"},
    {"label": "Beverly Hills", "value": "Beverly Hills"},
    {"label": "Malibu", "value": "Malibu"},
    {"label": "Manhattan", "value": "Manhattan"},
    {"label": "Miami Beach", "value": "Miami Beach"},
    {"label": "Hamptons", "value": "Hamptons"},
  ];

  List<Map<String, dynamic>> sortOptions = [
    {"label": "Featured", "value": "Featured"},
    {"label": "Price: High to Low", "value": "Price High"},
    {"label": "Price: Low to High", "value": "Price Low"},
    {"label": "Newest", "value": "Newest"},
    {"label": "Largest First", "value": "Size Large"},
  ];

  List<Map<String, dynamic>> properties = [
    {
      "id": "1",
      "title": "Oceanfront Mega Mansion",
      "type": "Mansion",
      "location": "Malibu",
      "address": "1 Ocean View Drive, Malibu, CA",
      "price": 25000000,
      "images": [
        "https://picsum.photos/600/400?random=201&keyword=mansion",
        "https://picsum.photos/600/400?random=202&keyword=luxury",
        "https://picsum.photos/600/400?random=203&keyword=ocean",
      ],
      "bedrooms": 8,
      "bathrooms": 12,
      "area": 15000,
      "lot_size": 2.5,
      "year_built": 2020,
      "parking_spaces": 10,
      "features": [
        "Private Beach Access",
        "Infinity Pool",
        "Wine Cellar",
        "Home Theater",
        "Gym",
        "Guest House",
        "Tennis Court",
        "Helicopter Pad"
      ],
      "description": "Stunning oceanfront estate with panoramic Pacific views",
      "agent": {
        "name": "Luxury Properties Agent",
        "phone": "+1 310 555 0100",
        "image": "https://picsum.photos/100/100?random=301&keyword=agent",
      },
      "is_featured": true,
      "virtual_tour": true,
      "new_listing": false,
    },
    {
      "id": "2",
      "title": "Manhattan Penthouse Suite",
      "type": "Penthouse",
      "location": "Manhattan",
      "address": "432 Park Avenue, New York, NY",
      "price": 18500000,
      "images": [
        "https://picsum.photos/600/400?random=204&keyword=penthouse",
        "https://picsum.photos/600/400?random=205&keyword=manhattan",
        "https://picsum.photos/600/400?random=206&keyword=skyline",
      ],
      "bedrooms": 4,
      "bathrooms": 6,
      "area": 6800,
      "lot_size": 0,
      "year_built": 2019,
      "parking_spaces": 3,
      "features": [
        "360° City Views",
        "Private Elevator",
        "Marble Bathrooms",
        "Chef's Kitchen",
        "Library",
        "Terrace",
        "Concierge Service",
        "Spa Access"
      ],
      "description": "Exquisite penthouse with breathtaking city views",
      "agent": {
        "name": "NYC Elite Realty",
        "phone": "+1 212 555 0200",
        "image": "https://picsum.photos/100/100?random=302&keyword=agent",
      },
      "is_featured": true,
      "virtual_tour": true,
      "new_listing": true,
    },
    {
      "id": "3",
      "title": "Beverly Hills Estate",
      "type": "Estate",
      "location": "Beverly Hills",
      "address": "90210 Rodeo Drive, Beverly Hills, CA",
      "price": 32000000,
      "images": [
        "https://picsum.photos/600/400?random=207&keyword=estate",
        "https://picsum.photos/600/400?random=208&keyword=beverly",
        "https://picsum.photos/600/400?random=209&keyword=luxury",
      ],
      "bedrooms": 12,
      "bathrooms": 16,
      "area": 22000,
      "lot_size": 3.8,
      "year_built": 2018,
      "parking_spaces": 15,
      "features": [
        "Gated Community",
        "Multiple Pools",
        "Wine Cave",
        "Staff Quarters",
        "Horse Stables",
        "Movie Theater",
        "Spa & Wellness Center",
        "Art Gallery"
      ],
      "description": "Magnificent estate in the heart of Beverly Hills",
      "agent": {
        "name": "Beverly Hills Luxury",
        "phone": "+1 310 555 0300",
        "image": "https://picsum.photos/100/100?random=303&keyword=agent",
      },
      "is_featured": false,
      "virtual_tour": true,
      "new_listing": false,
    },
    {
      "id": "4",
      "title": "Miami Beach Villa",
      "type": "Villa",
      "location": "Miami Beach",
      "address": "123 Star Island Drive, Miami Beach, FL",
      "price": 12800000,
      "images": [
        "https://picsum.photos/600/400?random=210&keyword=villa",
        "https://picsum.photos/600/400?random=211&keyword=miami",
        "https://picsum.photos/600/400?random=212&keyword=beach",
      ],
      "bedrooms": 6,
      "bathrooms": 8,
      "area": 9500,
      "lot_size": 1.2,
      "year_built": 2021,
      "parking_spaces": 6,
      "features": [
        "Waterfront Location",
        "Private Dock",
        "Resort-Style Pool",
        "Outdoor Kitchen",
        "Rooftop Deck",
        "Smart Home Technology",
        "Generator",
        "Security System"
      ],
      "description": "Modern waterfront villa with yacht access",
      "agent": {
        "name": "Miami Luxury Homes",
        "phone": "+1 305 555 0400",
        "image": "https://picsum.photos/100/100?random=304&keyword=agent",
      },
      "is_featured": true,
      "virtual_tour": false,
      "new_listing": true,
    },
    {
      "id": "5",
      "title": "Hamptons Compound",
      "type": "Estate",
      "location": "Hamptons",
      "address": "456 Ocean Road, East Hampton, NY",
      "price": 28500000,
      "images": [
        "https://picsum.photos/600/400?random=213&keyword=hamptons",
        "https://picsum.photos/600/400?random=214&keyword=compound",
        "https://picsum.photos/600/400?random=215&keyword=estate",
      ],
      "bedrooms": 10,
      "bathrooms": 14,
      "area": 18500,
      "lot_size": 5.2,
      "year_built": 2017,
      "parking_spaces": 12,
      "features": [
        "Private Beach",
        "Guest Cottages",
        "Tennis Court",
        "Pool House",
        "Formal Gardens",
        "Wine Cellar",
        "Home Office",
        "Caretaker's House"
      ],
      "description": "Spectacular waterfront compound in exclusive Hamptons",
      "agent": {
        "name": "Hamptons Elite",
        "phone": "+1 631 555 0500",
        "image": "https://picsum.photos/100/100?random=305&keyword=agent",
      },
      "is_featured": false,
      "virtual_tour": true,
      "new_listing": false,
    },
  ];

  List<Map<String, dynamic>> get filteredProperties {
    List<Map<String, dynamic>> result = properties;
    
    if (selectedFilter != "All") {
      result = result.where((property) => property["type"] == selectedFilter).toList();
    }
    
    if (searchQuery.isNotEmpty) {
      result = result.where((property) => 
        (property["title"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
        (property["location"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
        (property["address"] as String).toLowerCase().contains(searchQuery.toLowerCase())
      ).toList();
    }
    
    // Sort results
    switch (sortBy) {
      case "Featured":
        result.sort((a, b) => (b["is_featured"] as bool ? 1 : 0).compareTo(a["is_featured"] as bool ? 1 : 0));
        break;
      case "Price High":
        result.sort((a, b) => (b["price"] as int).compareTo(a["price"] as int));
        break;
      case "Price Low":
        result.sort((a, b) => (a["price"] as int).compareTo(b["price"] as int));
        break;
      case "Size Large":
        result.sort((a, b) => (b["area"] as int).compareTo(a["area"] as int));
        break;
    }
    
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Luxury Properties"),
        actions: [
          IconButton(
            icon: Icon(Icons.view_module),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.filter_list),
            onPressed: _showFilterSheet,
          ),
        ],
      ),
      body: loading 
        ? Center(child: CircularProgressIndicator())
        : SingleChildScrollView(
            padding: EdgeInsets.all(spMd),
            child: Column(
              spacing: spMd,
              children: [
                _buildSearchAndFilters(),
                _buildFeaturedBanner(),
                _buildPropertiesList(),
              ],
            ),
          ),
    );
  }

  Widget _buildSearchAndFilters() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        children: [
          QTextField(
            label: "Search luxury properties",
            value: searchQuery,
            hint: "Property name, location, or features",
            onChanged: (value) {
              searchQuery = value;
              setState(() {});
            },
          ),
          SizedBox(height: spMd),
          QCategoryPicker(
            items: filterOptions,
            value: selectedFilter,
            onChanged: (index, label, value, item) {
              selectedFilter = value;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  Widget _buildFeaturedBanner() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [primaryColor, primaryColor.withAlpha(180)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(radiusMd),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Exclusive Luxury Collection",
                  style: TextStyle(
                    fontSize: fsH5,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: spXs),
                Text(
                  "Curated selection of the world's finest properties",
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white.withAlpha(200),
                  ),
                ),
                SizedBox(height: spMd),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: spMd, vertical: spSm),
                  decoration: BoxDecoration(
                    color: Colors.white.withAlpha(200),
                    borderRadius: BorderRadius.circular(radiusLg),
                  ),
                  child: Text(
                    "Premium Service",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: primaryColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Icon(
            Icons.villa,
            size: 48,
            color: Colors.white.withAlpha(150),
          ),
        ],
      ),
    );
  }

  Widget _buildPropertiesList() {
    if (filteredProperties.isEmpty) {
      return Container(
        padding: EdgeInsets.all(spLg),
        child: Column(
          children: [
            Icon(Icons.search_off, size: 64, color: disabledColor),
            SizedBox(height: spMd),
            Text(
              "No luxury properties found",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: disabledBoldColor,
              ),
            ),
            Text(
              "Try adjusting your search or filter criteria",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: disabledBoldColor,
              ),
            ),
          ],
        ),
      );
    }

    return Column(
      children: filteredProperties.map((property) => _buildPropertyCard(property)).toList(),
    );
  }

  Widget _buildPropertyCard(Map<String, dynamic> property) {
    return Container(
      margin: EdgeInsets.only(bottom: spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowMd],
      ),
      child: Column(
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(radiusMd)),
                child: Image.network(
                  "${(property["images"] as List)[0]}",
                  width: double.infinity,
                  height: 250,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                top: spSm,
                left: spSm,
                child: Row(
                  children: [
                    if (property["is_featured"] as bool)
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                        decoration: BoxDecoration(
                          color: warningColor,
                          borderRadius: BorderRadius.circular(radiusLg),
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
                    if (property["new_listing"] as bool) ...[
                      SizedBox(width: spXs),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                        decoration: BoxDecoration(
                          color: successColor,
                          borderRadius: BorderRadius.circular(radiusLg),
                        ),
                        child: Text(
                          "NEW",
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              Positioned(
                top: spSm,
                right: spSm,
                child: Row(
                  children: [
                    if (property["virtual_tour"] as bool)
                      Container(
                        margin: EdgeInsets.only(right: spXs),
                        padding: EdgeInsets.all(spXs),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          boxShadow: [shadowSm],
                        ),
                        child: Icon(
                          Icons.view_in_ar,
                          color: primaryColor,
                          size: 20,
                        ),
                      ),
                    Container(
                      padding: EdgeInsets.all(spXs),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [shadowSm],
                      ),
                      child: Icon(
                        Icons.favorite_border,
                        color: dangerColor,
                        size: 20,
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                bottom: spSm,
                right: spSm,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                  decoration: BoxDecoration(
                    color: Colors.black.withAlpha(150),
                    borderRadius: BorderRadius.circular(radiusLg),
                  ),
                  child: Text(
                    "+${(property["images"] as List).length - 1} photos",
                    style: TextStyle(
                      fontSize: 12,
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
                        "${property["title"]}",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ),
                    Text(
                      "\$${((property["price"] as int).toDouble() / 1000000).toStringAsFixed(1)}M",
                      style: TextStyle(
                        fontSize: fsH5,
                        fontWeight: FontWeight.bold,
                        color: successColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spXs),
                Row(
                  children: [
                    Icon(Icons.location_on, size: 16, color: disabledBoldColor),
                    SizedBox(width: spXs),
                    Expanded(
                      child: Text(
                        "${property["address"]}",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spMd),
                _buildPropertySpecs(property),
                SizedBox(height: spMd),
                _buildLuxuryFeatures(property),
                SizedBox(height: spMd),
                _buildAgentInfo(property),
                SizedBox(height: spMd),
                _buildPropertyActions(property),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPropertySpecs(Map<String, dynamic> property) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Row(
        children: [
          Expanded(
            child: _buildSpecItem(
              Icons.bed,
              "${property["bedrooms"]} bed",
            ),
          ),
          Expanded(
            child: _buildSpecItem(
              Icons.bathtub,
              "${property["bathrooms"]} bath",
            ),
          ),
          Expanded(
            child: _buildSpecItem(
              Icons.square_foot,
              "${((property["area"] as int).toDouble() / 1000).toStringAsFixed(1)}K sq ft",
            ),
          ),
          if ((property["lot_size"] as num) > 0)
            Expanded(
              child: _buildSpecItem(
                Icons.landscape,
                "${(property["lot_size"] as num).toStringAsFixed(1)} acres",
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildSpecItem(IconData icon, String text) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, size: 16, color: primaryColor),
        SizedBox(width: spXs),
        Text(
          text,
          style: TextStyle(
            fontSize: 12,
            color: primaryColor,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Widget _buildLuxuryFeatures(Map<String, dynamic> property) {
    List<String> features = (property["features"] as List).cast<String>();
    List<String> displayFeatures = features.take(4).toList();
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Luxury Features",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        SizedBox(height: spSm),
        Wrap(
          spacing: spXs,
          runSpacing: spXs,
          children: displayFeatures.map((feature) => Container(
            padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusLg),
              border: Border.all(color: primaryColor.withAlpha(100)),
            ),
            child: Text(
              feature,
              style: TextStyle(
                fontSize: 12,
                color: primaryColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          )).toList(),
        ),
        if (features.length > 4)
          Padding(
            padding: EdgeInsets.only(top: spSm),
            child: Text(
              "+${features.length - 4} more features",
              style: TextStyle(
                fontSize: 12,
                color: disabledBoldColor,
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildAgentInfo(Map<String, dynamic> property) {
    Map<String, dynamic> agent = property["agent"] as Map<String, dynamic>;
    
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: infoColor.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: infoColor.withAlpha(100)),
      ),
      child: Row(
        children: [
          ClipOval(
            child: Image.network(
              "${agent["image"]}",
              width: 40,
              height: 40,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${agent["name"]}",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "Luxury Property Specialist",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
          QButton(
            icon: Icons.phone,
            size: bs.sm,
            onPressed: () => _callAgent(agent),
          ),
        ],
      ),
    );
  }

  Widget _buildPropertyActions(Map<String, dynamic> property) {
    return Row(
      children: [
        Expanded(
          child: QButton(
            label: "View Details",
            size: bs.sm,
            onPressed: () => _viewPropertyDetails(property),
          ),
        ),
        SizedBox(width: spSm),
        Expanded(
          child: QButton(
            label: "Schedule Tour",
            size: bs.sm,
            onPressed: () => _scheduleTour(property),
          ),
        ),
        SizedBox(width: spSm),
        QButton(
          icon: Icons.share,
          size: bs.sm,
          onPressed: () => _shareProperty(property),
        ),
      ],
    );
  }

  void _showFilterSheet() {
    ss("Opening advanced filters...");
  }

  void _viewPropertyDetails(Map<String, dynamic> property) {
    ss("Opening ${property["title"]} details...");
  }

  void _scheduleTour(Map<String, dynamic> property) {
    ss("Scheduling tour for ${property["title"]}...");
  }

  void _shareProperty(Map<String, dynamic> property) {
    ss("Sharing ${property["title"]}...");
  }

  void _callAgent(Map<String, dynamic> agent) {
    ss("Calling ${agent["name"]}...");
  }
}
