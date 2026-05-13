import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class SpaStoreLocatorView extends StatefulWidget {
  const SpaStoreLocatorView({super.key});

  @override
  State<SpaStoreLocatorView> createState() => _SpaStoreLocatorViewState();
}

class _SpaStoreLocatorViewState extends State<SpaStoreLocatorView> {
  String searchQuery = "";
  String selectedCity = "All Cities";
  String selectedService = "All Services";
  bool showMapView = false;
  
  List<Map<String, dynamic>> spaLocations = [
    {
      "id": "spa1",
      "name": "Serenity Spa Downtown",
      "address": "123 Main Street, Downtown",
      "city": "New York",
      "phone": "+1 (555) 123-4567",
      "email": "downtown@serenityspa.com",
      "rating": 4.8,
      "reviewCount": 245,
      "distance": 0.5,
      "image": "https://picsum.photos/300/200?random=1&keyword=spa",
      "latitude": 40.7128,
      "longitude": -74.0060,
      "openingHours": {
        "monday": "9:00 AM - 8:00 PM",
        "tuesday": "9:00 AM - 8:00 PM",
        "wednesday": "9:00 AM - 8:00 PM",
        "thursday": "9:00 AM - 9:00 PM",
        "friday": "9:00 AM - 9:00 PM",
        "saturday": "8:00 AM - 9:00 PM",
        "sunday": "8:00 AM - 7:00 PM",
      },
      "services": ["Massage", "Facial", "Body Treatment", "Manicure", "Pedicure"],
      "amenities": ["Parking", "WiFi", "Sauna", "Steam Room", "Relaxation Lounge"],
      "isOpen": true,
      "nextAvailable": "Today at 2:00 PM",
    },
    {
      "id": "spa2",
      "name": "Zen Wellness Center",
      "address": "456 Oak Avenue, Midtown",
      "city": "New York",
      "phone": "+1 (555) 234-5678",
      "email": "midtown@zenwellness.com",
      "rating": 4.6,
      "reviewCount": 189,
      "distance": 1.2,
      "image": "https://picsum.photos/300/200?random=2&keyword=wellness",
      "latitude": 40.7589,
      "longitude": -73.9851,
      "openingHours": {
        "monday": "8:00 AM - 7:00 PM",
        "tuesday": "8:00 AM - 7:00 PM",
        "wednesday": "8:00 AM - 7:00 PM",
        "thursday": "8:00 AM - 8:00 PM",
        "friday": "8:00 AM - 8:00 PM",
        "saturday": "7:00 AM - 8:00 PM",
        "sunday": "7:00 AM - 6:00 PM",
      },
      "services": ["Massage", "Aromatherapy", "Reflexology", "Meditation"],
      "amenities": ["Parking", "WiFi", "Tea Bar", "Meditation Room"],
      "isOpen": true,
      "nextAvailable": "Tomorrow at 10:00 AM",
    },
    {
      "id": "spa3",
      "name": "Luxury Spa & Resort",
      "address": "789 Park Lane, Uptown",
      "city": "New York",
      "phone": "+1 (555) 345-6789",
      "email": "uptown@luxuryspa.com",
      "rating": 4.9,
      "reviewCount": 367,
      "distance": 2.8,
      "image": "https://picsum.photos/300/200?random=3&keyword=luxury",
      "latitude": 40.7831,
      "longitude": -73.9712,
      "openingHours": {
        "monday": "10:00 AM - 9:00 PM",
        "tuesday": "10:00 AM - 9:00 PM",
        "wednesday": "10:00 AM - 9:00 PM",
        "thursday": "10:00 AM - 10:00 PM",
        "friday": "10:00 AM - 10:00 PM",
        "saturday": "9:00 AM - 10:00 PM",
        "sunday": "9:00 AM - 8:00 PM",
      },
      "services": ["Massage", "Facial", "Body Treatment", "Couples Massage", "Hot Stone"],
      "amenities": ["Valet Parking", "WiFi", "Pool", "Sauna", "Steam Room", "Jacuzzi", "Restaurant"],
      "isOpen": false,
      "nextAvailable": "Today at 6:00 PM",
    },
    {
      "id": "spa4",
      "name": "Tranquil Day Spa",
      "address": "321 Elm Street, Brooklyn",
      "city": "Brooklyn",
      "phone": "+1 (555) 456-7890",
      "email": "brooklyn@tranquilspa.com",
      "rating": 4.7,
      "reviewCount": 156,
      "distance": 5.3,
      "image": "https://picsum.photos/300/200?random=4&keyword=tranquil",
      "latitude": 40.6782,
      "longitude": -73.9442,
      "openingHours": {
        "monday": "9:00 AM - 7:00 PM",
        "tuesday": "9:00 AM - 7:00 PM",
        "wednesday": "9:00 AM - 7:00 PM",
        "thursday": "9:00 AM - 8:00 PM",
        "friday": "9:00 AM - 8:00 PM",
        "saturday": "8:00 AM - 8:00 PM",
        "sunday": "8:00 AM - 6:00 PM",
      },
      "services": ["Massage", "Facial", "Waxing", "Manicure", "Pedicure"],
      "amenities": ["Parking", "WiFi", "Relaxation Area"],
      "isOpen": true,
      "nextAvailable": "Today at 3:30 PM",
    },
    {
      "id": "spa5",
      "name": "Holistic Healing Spa",
      "address": "654 Pine Road, Queens",
      "city": "Queens",
      "phone": "+1 (555) 567-8901",
      "email": "queens@holistichealing.com",
      "rating": 4.5,
      "reviewCount": 98,
      "distance": 7.1,
      "image": "https://picsum.photos/300/200?random=5&keyword=holistic",
      "latitude": 40.7282,
      "longitude": -73.7949,
      "openingHours": {
        "monday": "10:00 AM - 6:00 PM",
        "tuesday": "10:00 AM - 6:00 PM",
        "wednesday": "10:00 AM - 6:00 PM",
        "thursday": "10:00 AM - 7:00 PM",
        "friday": "10:00 AM - 7:00 PM",
        "saturday": "9:00 AM - 7:00 PM",
        "sunday": "9:00 AM - 5:00 PM",
      },
      "services": ["Massage", "Acupuncture", "Herbal Treatment", "Energy Healing"],
      "amenities": ["Parking", "WiFi", "Herbal Tea", "Meditation Garden"],
      "isOpen": true,
      "nextAvailable": "Tomorrow at 11:00 AM",
    },
    {
      "id": "spa6",
      "name": "Urban Escape Spa",
      "address": "987 Broadway, Manhattan",
      "city": "Manhattan",
      "phone": "+1 (555) 678-9012",
      "email": "manhattan@urbanescape.com",
      "rating": 4.4,
      "reviewCount": 278,
      "distance": 3.2,
      "image": "https://picsum.photos/300/200?random=6&keyword=urban",
      "latitude": 40.7505,
      "longitude": -73.9934,
      "openingHours": {
        "monday": "8:00 AM - 8:00 PM",
        "tuesday": "8:00 AM - 8:00 PM",
        "wednesday": "8:00 AM - 8:00 PM",
        "thursday": "8:00 AM - 9:00 PM",
        "friday": "8:00 AM - 9:00 PM",
        "saturday": "7:00 AM - 9:00 PM",
        "sunday": "7:00 AM - 7:00 PM",
      },
      "services": ["Massage", "Facial", "Body Scrub", "Aromatherapy", "Reflexology"],
      "amenities": ["Parking", "WiFi", "Rooftop Deck", "Juice Bar"],
      "isOpen": true,
      "nextAvailable": "Today at 4:00 PM",
    },
  ];

  List<String> cities = ["All Cities", "New York", "Brooklyn", "Queens", "Manhattan"];
  List<String> services = ["All Services", "Massage", "Facial", "Body Treatment", "Aromatherapy", "Reflexology"];

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> filteredLocations = _getFilteredLocations();

    return Scaffold(
      appBar: AppBar(
        title: Text("Store Locator"),
        actions: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
            margin: EdgeInsets.only(right: spMd),
            decoration: BoxDecoration(
              color: primaryColor,
              borderRadius: BorderRadius.circular(radiusLg),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.location_on,
                  color: Colors.white,
                  size: 16,
                ),
                SizedBox(width: spXs),
                Text(
                  "${filteredLocations.length} Found",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          // Search and Filters
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
                        label: "Search locations...",
                        value: searchQuery,
                        hint: "Enter spa name or address",
                        onChanged: (value) {
                          searchQuery = value;
                          setState(() {});
                        },
                      ),
                    ),
                    SizedBox(width: spSm),
                    QButton(
                      icon: showMapView ? Icons.list : Icons.map,
                      size: bs.sm,
                      onPressed: () {
                        showMapView = !showMapView;
                        setState(() {});
                      },
                    ),
                  ],
                ),

                // Filter Row
                Row(
                  children: [
                    Expanded(
                      child: QDropdownField(
                        label: "City",
                        items: cities.map((city) => {"label": city, "value": city}).toList(),
                        value: selectedCity,
                        onChanged: (value, label) {
                          selectedCity = value;
                          setState(() {});
                        },
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: QDropdownField(
                        label: "Service",
                        items: services.map((service) => {"label": service, "value": service}).toList(),
                        value: selectedService,
                        onChanged: (value, label) {
                          selectedService = value;
                          setState(() {});
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // View Toggle
          Container(
            margin: EdgeInsets.symmetric(horizontal: spMd, vertical: spSm),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(radiusLg),
            ),
            child: Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      showMapView = false;
                      setState(() {});
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: spSm),
                      decoration: BoxDecoration(
                        color: !showMapView ? primaryColor : Colors.transparent,
                        borderRadius: BorderRadius.circular(radiusLg),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.list,
                            color: !showMapView ? Colors.white : disabledBoldColor,
                            size: 16,
                          ),
                          SizedBox(width: spXs),
                          Text(
                            "List View",
                            style: TextStyle(
                              color: !showMapView ? Colors.white : disabledBoldColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      showMapView = true;
                      setState(() {});
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: spSm),
                      decoration: BoxDecoration(
                        color: showMapView ? primaryColor : Colors.transparent,
                        borderRadius: BorderRadius.circular(radiusLg),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.map,
                            color: showMapView ? Colors.white : disabledBoldColor,
                            size: 16,
                          ),
                          SizedBox(width: spXs),
                          Text(
                            "Map View",
                            style: TextStyle(
                              color: showMapView ? Colors.white : disabledBoldColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Content
          Expanded(
            child: showMapView ? _buildMapView(filteredLocations) : _buildListView(filteredLocations),
          ),
        ],
      ),
    );
  }

  Widget _buildListView(List<Map<String, dynamic>> locations) {
    if (locations.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.location_off,
              size: 64,
              color: disabledColor,
            ),
            SizedBox(height: spMd),
            Text(
              "No locations found",
              style: TextStyle(
                fontSize: fsH6,
                color: disabledBoldColor,
              ),
            ),
            Text(
              "Try adjusting your search or filters",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: disabledBoldColor,
                fontSize: 14,
              ),
            ),
          ],
        ),
      );
    }

    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: spMd),
      child: Column(
        children: locations.map((location) => _buildLocationCard(location)).toList(),
      ),
    );
  }

  Widget _buildLocationCard(Map<String, dynamic> location) {
    return Container(
      margin: EdgeInsets.only(bottom: spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowMd],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image Header
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(radiusLg)),
                child: Image.network(
                  "${location["image"]}",
                  height: 160,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                top: spSm,
                left: spSm,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                  decoration: BoxDecoration(
                    color: location["isOpen"] ? successColor : dangerColor,
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Text(
                    location["isOpen"] ? "OPEN" : "CLOSED",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Positioned(
                top: spSm,
                right: spSm,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                  decoration: BoxDecoration(
                    color: Colors.black.withAlpha(150),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.location_on,
                        color: Colors.white,
                        size: 12,
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "${(location["distance"] as double).toStringAsFixed(1)} km",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),

          // Content
          Padding(
            padding: EdgeInsets.all(spMd),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spSm,
              children: [
                // Header Info
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${location["name"]}",
                            style: TextStyle(
                              fontSize: fsH6,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          Text(
                            "${location["address"]}",
                            style: TextStyle(
                              color: disabledBoldColor,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.star,
                              color: warningColor,
                              size: 16,
                            ),
                            SizedBox(width: spXs),
                            Text(
                              "${(location["rating"] as double).toStringAsFixed(1)}",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                          ],
                        ),
                        Text(
                          "${(location["reviewCount"] as int).currency} reviews",
                          style: TextStyle(
                            color: disabledBoldColor,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),

                // Services
                Wrap(
                  spacing: spXs,
                  runSpacing: spXs,
                  children: ((location["services"] as List).take(4)).map((service) {
                    return Container(
                      padding: EdgeInsets.symmetric(horizontal: spSm, vertical: 2),
                      decoration: BoxDecoration(
                        color: primaryColor.withAlpha(30),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Text(
                        "$service",
                        style: TextStyle(
                          color: primaryColor,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    );
                  }).toList(),
                ),

                // Contact Info
                Row(
                  children: [
                    Icon(
                      Icons.phone,
                      color: primaryColor,
                      size: 16,
                    ),
                    SizedBox(width: spXs),
                    Text(
                      "${location["phone"]}",
                      style: TextStyle(
                        color: primaryColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Spacer(),
                    Icon(
                      Icons.schedule,
                      color: successColor,
                      size: 16,
                    ),
                    SizedBox(width: spXs),
                    Text(
                      "${location["nextAvailable"]}",
                      style: TextStyle(
                        color: successColor,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),

                // Action Buttons
                Row(
                  children: [
                    Expanded(
                      child: QButton(
                        label: "Call Now",
                        size: bs.sm,
                        color: primaryColor,
                        onPressed: () {
                          _callLocation(location);
                        },
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: QButton(
                        label: "View Details",
                        size: bs.sm,
                        color: successColor,
                        onPressed: () {
                          _viewLocationDetails(location);
                        },
                      ),
                    ),
                    SizedBox(width: spSm),
                    QButton(
                      icon: Icons.directions,
                      size: bs.sm,
                      color: infoColor,
                      onPressed: () {
                        _getDirections(location);
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

  Widget _buildMapView(List<Map<String, dynamic>> locations) {
    return Container(
      padding: EdgeInsets.all(spMd),
      child: Column(
        children: [
          // Map Placeholder
          Expanded(
            flex: 2,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(radiusLg),
                border: Border.all(color: disabledOutlineBorderColor),
              ),
              child: Stack(
                children: [
                  // Map Background
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.map,
                          size: 64,
                          color: primaryColor,
                        ),
                        SizedBox(height: spMd),
                        Text(
                          "Interactive Map",
                          style: TextStyle(
                            fontSize: fsH5,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "Showing ${locations.length} spa locations",
                          style: TextStyle(
                            color: disabledBoldColor,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Map Markers Simulation
                  ...locations.take(3).toList().asMap().entries.map((entry) {
                    int index = entry.key;
                    Map<String, dynamic> location = entry.value;
                    
                    return Positioned(
                      left: 50.0 + (index * 60),
                      top: 60.0 + (index * 40),
                      child: GestureDetector(
                        onTap: () {
                          _showLocationPopup(location);
                        },
                        child: Container(
                          padding: EdgeInsets.all(spXs),
                          decoration: BoxDecoration(
                            color: primaryColor,
                            borderRadius: BorderRadius.circular(radiusSm),
                            boxShadow: [shadowSm],
                          ),
                          child: Icon(
                            Icons.location_on,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ],
              ),
            ),
          ),

          SizedBox(height: spMd),

          // Location Summary Cards
          Container(
            height: 120,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: locations.map((location) {
                  return Container(
                    width: 280,
                    margin: EdgeInsets.only(right: spSm),
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusLg),
                      boxShadow: [shadowSm],
                    ),
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(radiusSm),
                          child: Image.network(
                            "${location["image"]}",
                            width: 60,
                            height: 60,
                            fit: BoxFit.cover,
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${location["name"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              Text(
                                "${(location["distance"] as double).toStringAsFixed(1)} km away",
                                style: TextStyle(
                                  color: disabledBoldColor,
                                  fontSize: 12,
                                ),
                              ),
                              SizedBox(height: spXs),
                              Row(
                                children: [
                                  Icon(
                                    Icons.star,
                                    color: warningColor,
                                    size: 12,
                                  ),
                                  SizedBox(width: spXs),
                                  Text(
                                    "${(location["rating"] as double).toStringAsFixed(1)}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Spacer(),
                                  Container(
                                    padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 1),
                                    decoration: BoxDecoration(
                                      color: location["isOpen"] ? successColor : dangerColor,
                                      borderRadius: BorderRadius.circular(radiusSm),
                                    ),
                                    child: Text(
                                      location["isOpen"] ? "OPEN" : "CLOSED",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: spXs),
                              Row(
                                children: [
                                  Expanded(
                                    child: QButton(
                                      label: "Details",
                                      size: bs.sm,
                                      onPressed: () {
                                        _viewLocationDetails(location);
                                      },
                                    ),
                                  ),
                                  SizedBox(width: spXs),
                                  QButton(
                                    icon: Icons.directions,
                                    size: bs.sm,
                                    onPressed: () {
                                      _getDirections(location);
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
                }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<Map<String, dynamic>> _getFilteredLocations() {
    return spaLocations.where((location) {
      bool matchesSearch = searchQuery.isEmpty ||
          (location["name"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
          (location["address"] as String).toLowerCase().contains(searchQuery.toLowerCase());

      bool matchesCity = selectedCity == "All Cities" || location["city"] == selectedCity;

      bool matchesService = selectedService == "All Services" ||
          (location["services"] as List).contains(selectedService);

      return matchesSearch && matchesCity && matchesService;
    }).toList();
  }

  void _callLocation(Map<String, dynamic> location) {
    ss("Calling ${location["name"]}...");
  }

  void _viewLocationDetails(Map<String, dynamic> location) {
    ss("Viewing details for ${location["name"]}");
  }

  void _getDirections(Map<String, dynamic> location) {
    ss("Getting directions to ${location["name"]}...");
  }

  void _showLocationPopup(Map<String, dynamic> location) {
    ss("Selected: ${location["name"]}");
  }
}
