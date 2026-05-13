import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class TtaMapView extends StatefulWidget {
  const TtaMapView({super.key});

  @override
  State<TtaMapView> createState() => _TtaMapViewState();
}

class _TtaMapViewState extends State<TtaMapView> {
  String selectedCategory = "All";
  bool showSatellite = false;
  double currentZoom = 1.0;

  final List<Map<String, dynamic>> categories = [
    {"label": "All", "value": "All", "icon": Icons.map},
    {"label": "Hotels", "value": "Hotels", "icon": Icons.hotel},
    {"label": "Restaurants", "value": "Restaurants", "icon": Icons.restaurant},
    {"label": "Attractions", "value": "Attractions", "icon": Icons.place},
    {"label": "Transport", "value": "Transport", "icon": Icons.directions_bus},
  ];

  final List<Map<String, dynamic>> mapPins = [
    {
      "id": "1",
      "name": "Grand Hotel Bali",
      "type": "Hotels",
      "rating": 4.8,
      "price": 120,
      "latitude": 37.7749,
      "longitude": -122.4194,
      "image": "https://picsum.photos/100/80?random=1&keyword=hotel"
    },
    {
      "id": "2", 
      "name": "Sea View Restaurant",
      "type": "Restaurants",
      "rating": 4.6,
      "price": 45,
      "latitude": 37.7849,
      "longitude": -122.4094,
      "image": "https://picsum.photos/100/80?random=2&keyword=restaurant"
    },
    {
      "id": "3",
      "name": "Temple Heritage",
      "type": "Attractions", 
      "rating": 4.9,
      "price": 25,
      "latitude": 37.7649,
      "longitude": -122.4294,
      "image": "https://picsum.photos/100/80?random=3&keyword=temple"
    },
    {
      "id": "4",
      "name": "Sunset Beach Resort",
      "type": "Hotels",
      "rating": 4.7,
      "price": 180,
      "latitude": 37.7549,
      "longitude": -122.4394,
      "image": "https://picsum.photos/100/80?random=4&keyword=beach"
    },
    {
      "id": "5",
      "name": "Local Food Market",
      "type": "Restaurants",
      "rating": 4.5,
      "price": 15,
      "latitude": 37.7949,
      "longitude": -122.3994,
      "image": "https://picsum.photos/100/80?random=5&keyword=market"
    },
    {
      "id": "6",
      "name": "Bus Terminal",
      "type": "Transport",
      "rating": 4.2,
      "price": 5,
      "latitude": 37.7449,
      "longitude": -122.4494,
      "image": "https://picsum.photos/100/80?random=6&keyword=bus"
    },
  ];

  List<Map<String, dynamic>> get filteredPins {
    if (selectedCategory == "All") return mapPins;
    return mapPins.where((pin) => pin["type"] == selectedCategory).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _buildMapContainer(),
          _buildTopControls(),
          _buildCategoryFilter(),
          _buildZoomControls(),
          _buildLocationButton(),
          _buildBottomSheet(),
        ],
      ),
    );
  }

  Widget _buildMapContainer() {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        color: showSatellite ? Colors.brown.withAlpha(50) : Colors.blue.withAlpha(30),
      ),
      child: Stack(
        children: [
          // Map background simulation
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: showSatellite 
                  ? [Colors.brown.withAlpha(100), Colors.green.withAlpha(100)]
                  : [Colors.blue.withAlpha(50), Colors.white],
              ),
            ),
          ),
          // Street lines simulation
          if (!showSatellite) ...[
            Positioned(
              top: 200,
              left: 0,
              right: 0,
              child: Container(height: 2, color: Colors.grey.withAlpha(150)),
            ),
            Positioned(
              top: 350,
              left: 0,
              right: 0,
              child: Container(height: 2, color: Colors.grey.withAlpha(150)),
            ),
            Positioned(
              top: 0,
              bottom: 0,
              left: 150,
              child: Container(width: 2, color: Colors.grey.withAlpha(150)),
            ),
            Positioned(
              top: 0,
              bottom: 0,
              left: 250,
              child: Container(width: 2, color: Colors.grey.withAlpha(150)),
            ),
          ],
          // Map pins
          ...filteredPins.map((pin) => _buildMapPin(pin)).toList(),
        ],
      ),
    );
  }

  Widget _buildMapPin(Map<String, dynamic> pin) {
    Color pinColor = _getPinColor(pin["type"]);
    
    return Positioned(
      left: ((pin["longitude"] as double) + 122.4194) * 1000,
      top: (37.7749 - (pin["latitude"] as double)) * 2000 + 200,
      child: GestureDetector(
        onTap: () => _showPinDetails(pin),
        child: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: pinColor,
            borderRadius: BorderRadius.circular(radiusLg),
            border: Border.all(color: Colors.white, width: 3),
            boxShadow: [shadowSm],
          ),
          child: Icon(
            _getPinIcon(pin["type"]),
            color: Colors.white,
            size: 20,
          ),
        ),
      ),
    );
  }

  Widget _buildTopControls() {
    return Positioned(
      top: 50,
      left: spMd,
      right: spMd,
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusLg),
              boxShadow: [shadowSm],
            ),
            child: IconButton(
              icon: Icon(Icons.arrow_back, color: primaryColor),
              onPressed: () => back(),
            ),
          ),
          Spacer(),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusLg),
              boxShadow: [shadowSm],
            ),
            child: IconButton(
              icon: Icon(Icons.search, color: primaryColor),
              onPressed: () {
                //navigateTo('SearchView')
              },
            ),
          ),
          SizedBox(width: spSm),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusLg),
              boxShadow: [shadowSm],
            ),
            child: IconButton(
              icon: Icon(
                showSatellite ? Icons.map : Icons.satellite,
                color: primaryColor,
              ),
              onPressed: () {
                showSatellite = !showSatellite;
                setState(() {});
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryFilter() {
    return Positioned(
      top: 120,
      left: 0,
      right: 0,
      child: Container(
        height: 60,
        child: QHorizontalScroll(
          children: categories.map((category) {
            bool isSelected = category["value"] == selectedCategory;
            return GestureDetector(
              onTap: () {
                selectedCategory = category["value"];
                setState(() {});
              },
              child: Container(
                margin: EdgeInsets.only(left: spMd),
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: isSelected ? primaryColor : Colors.white,
                  borderRadius: BorderRadius.circular(radiusLg),
                  boxShadow: [shadowSm],
                ),
                child: Row(
                  children: [
                    Icon(
                      category["icon"] as IconData,
                      color: isSelected ? Colors.white : primaryColor,
                      size: 20,
                    ),
                    SizedBox(width: spXs),
                    Text(
                      "${category["label"]}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: isSelected ? Colors.white : primaryColor,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildZoomControls() {
    return Positioned(
      right: spMd,
      top: 200,
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              children: [
                IconButton(
                  icon: Icon(Icons.add, color: primaryColor),
                  onPressed: () {
                    if (currentZoom < 3.0) {
                      currentZoom += 0.5;
                      setState(() {});
                    }
                  },
                ),
                Container(
                  width: 1,
                  height: 20,
                  color: disabledColor,
                ),
                IconButton(
                  icon: Icon(Icons.remove, color: primaryColor),
                  onPressed: () {
                    if (currentZoom > 0.5) {
                      currentZoom -= 0.5;
                      setState(() {});
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLocationButton() {
    return Positioned(
      right: spMd,
      bottom: 200,
      child: Container(
        decoration: BoxDecoration(
          color: primaryColor,
          borderRadius: BorderRadius.circular(radiusLg),
          boxShadow: [shadowSm],
        ),
        child: IconButton(
          icon: Icon(Icons.my_location, color: Colors.white),
          onPressed: () {
            ss("Centering to your location");
          },
        ),
      ),
    );
  }

  Widget _buildBottomSheet() {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        height: 120,
        padding: EdgeInsets.all(spMd),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(radiusLg)),
          boxShadow: [shadowMd],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  "Found ${filteredPins.length} places",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Spacer(),
                GestureDetector(
                  onTap: () {
                    //navigateTo('ListView')
                  },
                  child: Row(
                    children: [
                      Text(
                        "List View",
                        style: TextStyle(
                          fontSize: 14,
                          color: primaryColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(width: spXs),
                      Icon(Icons.list, color: primaryColor, size: 18),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: spSm),
            QHorizontalScroll(
              children: filteredPins.map((pin) {
                return Container(
                  width: 200,
                  margin: EdgeInsets.only(right: spSm),
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    border: Border.all(color: disabledColor),
                  ),
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(radiusSm),
                        child: Image.network(
                          "${pin["image"]}",
                          width: 50,
                          height: 50,
                          fit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${pin["name"]}",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(height: spXs),
                            Row(
                              children: [
                                Icon(Icons.star, color: warningColor, size: 14),
                                SizedBox(width: spXs),
                                Text(
                                  "${(pin["rating"] as double)}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                Spacer(),
                                Text(
                                  "\$${(pin["price"] as int)}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: successColor,
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
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  Color _getPinColor(String type) {
    switch (type) {
      case "Hotels":
        return primaryColor;
      case "Restaurants":
        return warningColor;
      case "Attractions":
        return successColor;
      case "Transport":
        return infoColor;
      default:
        return dangerColor;
    }
  }

  IconData _getPinIcon(String type) {
    switch (type) {
      case "Hotels":
        return Icons.hotel;
      case "Restaurants":
        return Icons.restaurant;
      case "Attractions":
        return Icons.place;
      case "Transport":
        return Icons.directions_bus;
      default:
        return Icons.location_on;
    }
  }

  void _showPinDetails(Map<String, dynamic> pin) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: 300,
        padding: EdgeInsets.all(spMd),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(radiusLg)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: disabledColor,
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
              ),
            ),
            SizedBox(height: spMd),
            Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(radiusMd),
                  child: Image.network(
                    "${pin["image"]}",
                    width: 80,
                    height: 80,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(width: spMd),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${pin["name"]}",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "${pin["type"]}",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),
                      SizedBox(height: spXs),
                      Row(
                        children: [
                          Icon(Icons.star, color: warningColor, size: 16),
                          SizedBox(width: spXs),
                          Text(
                            "${(pin["rating"] as double)}",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          Spacer(),
                          Text(
                            "\$${(pin["price"] as int)}",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: successColor,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: spMd),
            Text(
              "Description",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spSm),
            Text(
              "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
              style: TextStyle(
                fontSize: 14,
                color: disabledBoldColor,
                height: 1.4,
              ),
            ),
            Spacer(),
            Row(
              children: [
                Expanded(
                  child: QButton(
                    label: "Directions",
                    size: bs.sm,
                    onPressed: () {
                      back();
                      ss("Opening directions to ${pin["name"]}");
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QButton(
                    label: "View Details",
                    size: bs.sm,
                    onPressed: () {
                      back();
                      //navigateTo('DetailsView')
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
