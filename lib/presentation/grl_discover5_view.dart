import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlDiscover5View extends StatefulWidget {
  @override
  State<GrlDiscover5View> createState() => _GrlDiscover5ViewState();
}

class _GrlDiscover5ViewState extends State<GrlDiscover5View> {
  int currentTab = 0;
  String searchQuery = "";
  bool showMap = false;

  List<Map<String, dynamic>> nearbyPlaces = [
    {
      "name": "Central Park",
      "type": "Park",
      "distance": 0.3,
      "rating": 4.8,
      "image": "https://picsum.photos/300/200?random=1&keyword=park",
      "address": "New York, NY 10024",
      "openStatus": "Open",
      "hours": "6:00 AM - 1:00 AM",
      "coordinates": {"lat": 40.7829, "lng": -73.9654}
    },
    {
      "name": "Times Square",
      "type": "Attraction",
      "distance": 0.8,
      "rating": 4.5,
      "image": "https://picsum.photos/300/200?random=2&keyword=city",
      "address": "Times Square, New York, NY",
      "openStatus": "Open 24/7",
      "hours": "24 hours",
      "coordinates": {"lat": 40.7580, "lng": -73.9855}
    },
    {
      "name": "Blue Bottle Coffee",
      "type": "Cafe",
      "distance": 0.2,
      "rating": 4.6,
      "image": "https://picsum.photos/300/200?random=3&keyword=coffee",
      "address": "123 Main St, New York",
      "openStatus": "Open",
      "hours": "7:00 AM - 7:00 PM",
      "coordinates": {"lat": 40.7614, "lng": -73.9776}
    },
    {
      "name": "Metropolitan Museum",
      "type": "Museum",
      "distance": 1.2,
      "rating": 4.9,
      "image": "https://picsum.photos/300/200?random=4&keyword=museum",
      "address": "1000 5th Ave, New York",
      "openStatus": "Open",
      "hours": "10:00 AM - 5:00 PM",
      "coordinates": {"lat": 40.7794, "lng": -73.9632}
    },
    {
      "name": "Brooklyn Bridge",
      "type": "Landmark",
      "distance": 2.1,
      "rating": 4.7,
      "image": "https://picsum.photos/300/200?random=5&keyword=bridge",
      "address": "Brooklyn Bridge, New York",
      "openStatus": "Open",
      "hours": "24 hours",
      "coordinates": {"lat": 40.7061, "lng": -73.9969}
    },
    {
      "name": "Joe's Pizza",
      "type": "Restaurant",
      "distance": 0.4,
      "rating": 4.4,
      "image": "https://picsum.photos/300/200?random=6&keyword=pizza",
      "address": "456 Broadway, New York",
      "openStatus": "Open",
      "hours": "11:00 AM - 11:00 PM",
      "coordinates": {"lat": 40.7505, "lng": -73.9934}
    }
  ];

  List<Map<String, dynamic>> categories = [
    {"label": "All", "value": "All", "icon": Icons.explore},
    {"label": "Food", "value": "Restaurant", "icon": Icons.restaurant},
    {"label": "Coffee", "value": "Cafe", "icon": Icons.local_cafe},
    {"label": "Attractions", "value": "Attraction", "icon": Icons.place},
    {"label": "Parks", "value": "Park", "icon": Icons.park},
    {"label": "Museums", "value": "Museum", "icon": Icons.museum}
  ];

  String selectedCategory = "All";

  List<Map<String, dynamic>> get filteredPlaces {
    return nearbyPlaces.where((place) {
      bool matchesSearch = searchQuery.isEmpty ||
          "${place["name"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
          "${place["type"]}".toLowerCase().contains(searchQuery.toLowerCase());

      bool matchesCategory = selectedCategory == "All" ||
          place["type"] == selectedCategory;

      return matchesSearch && matchesCategory;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Discover Nearby"),
        actions: [
          IconButton(
            icon: Icon(showMap ? Icons.list : Icons.map),
            onPressed: () {
              showMap = !showMap;
              setState(() {});
            },
          ),
          IconButton(
            icon: Icon(Icons.filter_list),
            onPressed: () => _showFilterOptions(),
          ),
        ],
      ),
      body: Column(
        children: [
          // Search and Filter Section
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [shadowSm],
            ),
            child: Column(
              spacing: spSm,
              children: [
                // Search Bar
                Row(
                  children: [
                    Expanded(
                      child: QTextField(
                        label: "Search places nearby...",
                        value: searchQuery,
                        onChanged: (value) {
                          searchQuery = value;
                          setState(() {});
                        },
                      ),
                    ),
                    SizedBox(width: spSm),
                    QButton(
                      icon: Icons.my_location,
                      size: bs.sm,
                      onPressed: () {
                        // Get current location
                        si("Getting your location...");
                      },
                    ),
                  ],
                ),

                // Category Tabs
                QHorizontalScroll(
                  children: categories.map((category) {
                    bool isSelected = selectedCategory == category["value"];
                    return GestureDetector(
                      onTap: () {
                        selectedCategory = category["value"];
                        setState(() {});
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                        decoration: BoxDecoration(
                          color: isSelected ? primaryColor : Colors.transparent,
                          borderRadius: BorderRadius.circular(radiusLg),
                          border: Border.all(
                            color: isSelected ? primaryColor : disabledOutlineBorderColor,
                          ),
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
                                color: isSelected ? Colors.white : disabledBoldColor,
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),

          // Results Header
          Container(
            padding: EdgeInsets.symmetric(horizontal: spMd, vertical: spSm),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "${filteredPlaces.length} places found",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                GestureDetector(
                  onTap: () => _showSortOptions(),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.sort,
                        size: 16,
                        color: disabledBoldColor,
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "Sort by distance",
                        style: TextStyle(
                          color: disabledBoldColor,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Content Area
          Expanded(
            child: showMap ? _buildMapView() : _buildListView(),
          ),
        ],
      ),
    );
  }

  Widget _buildListView() {
    return ListView.builder(
      padding: EdgeInsets.symmetric(horizontal: spMd),
      itemCount: filteredPlaces.length,
      itemBuilder: (context, index) {
        final place = filteredPlaces[index];
        return Container(
          margin: EdgeInsets.only(bottom: spSm),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(radiusLg),
            boxShadow: [shadowSm],
          ),
          child: Row(
            children: [
              // Image
              ClipRRect(
                borderRadius: BorderRadius.horizontal(left: Radius.circular(radiusLg)),
                child: Image.network(
                  "${place["image"]}",
                  width: 100,
                  height: 100,
                  fit: BoxFit.cover,
                ),
              ),

              // Content
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(spSm),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: spXs,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              "${place["name"]}",
                              style: TextStyle(
                                fontSize: fsH6,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                            decoration: BoxDecoration(
                              color: _getTypeColor("${place["type"]}").withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Text(
                              "${place["type"]}",
                              style: TextStyle(
                                color: _getTypeColor("${place["type"]}"),
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                      
                      Row(
                        children: [
                          Icon(
                            Icons.location_on,
                            size: 12,
                            color: disabledBoldColor,
                          ),
                          SizedBox(width: spXs),
                          Text(
                            "${(place["distance"] as double).toStringAsFixed(1)} km away",
                            style: TextStyle(
                              color: disabledBoldColor,
                              fontSize: 12,
                            ),
                          ),
                          SizedBox(width: spSm),
                          Icon(
                            Icons.star,
                            size: 12,
                            color: warningColor,
                          ),
                          SizedBox(width: spXs),
                          Text(
                            "${place["rating"]}",
                            style: TextStyle(
                              color: primaryColor,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),

                      Text(
                        "${place["address"]}",
                        style: TextStyle(
                          color: disabledBoldColor,
                          fontSize: 11,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),

                      Row(
                        children: [
                          Container(
                            width: 8,
                            height: 8,
                            decoration: BoxDecoration(
                              color: place["openStatus"] == "Open" || place["openStatus"] == "Open 24/7" 
                                ? successColor : dangerColor,
                              shape: BoxShape.circle,
                            ),
                          ),
                          SizedBox(width: spXs),
                          Text(
                            "${place["openStatus"]} • ${place["hours"]}",
                            style: TextStyle(
                              color: disabledBoldColor,
                              fontSize: 11,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              // Action Buttons
              Padding(
                padding: EdgeInsets.only(right: spSm),
                child: Column(
                  spacing: spXs,
                  children: [
                    QButton(
                      icon: Icons.directions,
                      size: bs.sm,
                      onPressed: () {
                        // Open directions
                        si("Opening directions...");
                      },
                    ),
                    QButton(
                      icon: Icons.info_outline,
                      size: bs.sm,
                      color: secondaryColor,
                      onPressed: () {
                        _showPlaceDetails(place);
                      },
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

  Widget _buildMapView() {
    return Container(
      color: Colors.grey[100],
      child: Stack(
        children: [
          // Map Placeholder
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.blue[100]!, Colors.blue[50]!],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.map,
                    size: 64,
                    color: primaryColor.withAlpha(100),
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "Interactive Map View",
                    style: TextStyle(
                      fontSize: fsH5,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Text(
                    "Map integration would be implemented here",
                    style: TextStyle(
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Map pins overlay (simulated)
          ...filteredPlaces.asMap().entries.map((entry) {
            int index = entry.key;
            Map<String, dynamic> place = entry.value;
            
            return Positioned(
              left: 50.0 + (index * 60.0) % 200,
              top: 100.0 + (index * 80.0) % 300,
              child: GestureDetector(
                onTap: () => _showPlaceDetails(place),
                child: Container(
                  padding: EdgeInsets.all(spXs),
                  decoration: BoxDecoration(
                    color: primaryColor,
                    borderRadius: BorderRadius.circular(radiusSm),
                    boxShadow: [shadowMd],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.place,
                        color: Colors.white,
                        size: 20,
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 1),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Text(
                          "${place["name"]}",
                          style: TextStyle(
                            fontSize: 8,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }).toList(),

          // Back to List Button
          Positioned(
            bottom: spMd,
            right: spMd,
            child: QButton(
              label: "List View",
              icon: Icons.list,
              onPressed: () {
                showMap = false;
                setState(() {});
              },
            ),
          ),
        ],
      ),
    );
  }

  Color _getTypeColor(String type) {
    switch (type) {
      case "Restaurant":
        return dangerColor;
      case "Cafe":
        return warningColor;
      case "Park":
        return successColor;
      case "Museum":
        return primaryColor;
      case "Attraction":
        return secondaryColor;
      default:
        return disabledBoldColor;
    }
  }

  void _showPlaceDetails(Map<String, dynamic> place) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.8,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(radiusLg)),
        ),
        child: Column(
          children: [
            // Header Image
            ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(radiusLg)),
              child: Stack(
                children: [
                  Image.network(
                    "${place["image"]}",
                    height: 200,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                  Positioned(
                    top: spMd,
                    right: spMd,
                    child: GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        padding: EdgeInsets.all(spXs),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          boxShadow: [shadowSm],
                        ),
                        child: Icon(
                          Icons.close,
                          color: primaryColor,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Content
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(spMd),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spMd,
                  children: [
                    // Title and Type
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            "${place["name"]}",
                            style: TextStyle(
                              fontSize: fsH4,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                          decoration: BoxDecoration(
                            color: _getTypeColor("${place["type"]}").withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Text(
                            "${place["type"]}",
                            style: TextStyle(
                              color: _getTypeColor("${place["type"]}"),
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),

                    // Rating and Distance
                    Row(
                      children: [
                        Icon(
                          Icons.star,
                          color: warningColor,
                          size: 20,
                        ),
                        SizedBox(width: spXs),
                        Text(
                          "${place["rating"]}",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        SizedBox(width: spMd),
                        Icon(
                          Icons.location_on,
                          color: disabledBoldColor,
                          size: 20,
                        ),
                        SizedBox(width: spXs),
                        Text(
                          "${(place["distance"] as double).toStringAsFixed(1)} km away",
                          style: TextStyle(
                            color: disabledBoldColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),

                    // Address
                    Row(
                      children: [
                        Icon(
                          Icons.place,
                          color: disabledBoldColor,
                          size: 16,
                        ),
                        SizedBox(width: spXs),
                        Expanded(
                          child: Text(
                            "${place["address"]}",
                            style: TextStyle(
                              color: disabledBoldColor,
                            ),
                          ),
                        ),
                      ],
                    ),

                    // Hours
                    Row(
                      children: [
                        Container(
                          width: 12,
                          height: 12,
                          decoration: BoxDecoration(
                            color: place["openStatus"] == "Open" || place["openStatus"] == "Open 24/7" 
                              ? successColor : dangerColor,
                            shape: BoxShape.circle,
                          ),
                        ),
                        SizedBox(width: spXs),
                        Text(
                          "${place["openStatus"]} • ${place["hours"]}",
                          style: TextStyle(
                            color: primaryColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),

                    Spacer(),

                    // Action Buttons
                    Row(
                      spacing: spSm,
                      children: [
                        Expanded(
                          child: QButton(
                            label: "Get Directions",
                            icon: Icons.directions,
                            onPressed: () {
                              si("Opening directions...");
                            },
                          ),
                        ),
                        Expanded(
                          child: QButton(
                            label: "Call",
                            icon: Icons.phone,
                            color: successColor,
                            onPressed: () {
                              si("Opening phone app...");
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showFilterOptions() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(radiusLg)),
        ),
        padding: EdgeInsets.all(spMd),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: spSm,
          children: [
            Text(
              "Filter Options",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.grey[50],
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.tune,
                    color: disabledBoldColor,
                  ),
                  SizedBox(width: spSm),
                  Text(
                    "More filter options coming soon",
                    style: TextStyle(
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
  }

  void _showSortOptions() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(radiusLg)),
        ),
        padding: EdgeInsets.all(spMd),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: spSm,
          children: [
            Text(
              "Sort by",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Container(
                padding: EdgeInsets.all(spSm),
                child: Row(
                  children: [
                    Icon(Icons.location_on, color: primaryColor),
                    SizedBox(width: spSm),
                    Text("Distance"),
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Container(
                padding: EdgeInsets.all(spSm),
                child: Row(
                  children: [
                    Icon(Icons.star, color: warningColor),
                    SizedBox(width: spSm),
                    Text("Rating"),
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Container(
                padding: EdgeInsets.all(spSm),
                child: Row(
                  children: [
                    Icon(Icons.trending_up, color: successColor),
                    SizedBox(width: spSm),
                    Text("Popularity"),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
