import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlExplore6View extends StatefulWidget {
  @override
  State<GrlExplore6View> createState() => _GrlExplore6ViewState();
}

class _GrlExplore6ViewState extends State<GrlExplore6View> {
  String searchQuery = "";
  String selectedVenue = "All Venues";
  String selectedGenre = "All Genres";
  String selectedDate = "All Dates";
  String selectedPriceRange = "All Prices";
  
  List<Map<String, dynamic>> venueOptions = [
    {"label": "All Venues", "value": "All Venues"},
    {"label": "Outdoor Venues", "value": "Outdoor"},
    {"label": "Concert Halls", "value": "Concert Hall"},
    {"label": "Clubs & Bars", "value": "Club"},
    {"label": "Theaters", "value": "Theater"},
    {"label": "Arenas", "value": "Arena"},
    {"label": "Festivals", "value": "Festival"},
  ];
  
  List<Map<String, dynamic>> genreOptions = [
    {"label": "All Genres", "value": "All Genres"},
    {"label": "Rock", "value": "Rock"},
    {"label": "Pop", "value": "Pop"},
    {"label": "Jazz", "value": "Jazz"},
    {"label": "Classical", "value": "Classical"},
    {"label": "Electronic", "value": "Electronic"},
    {"label": "Hip Hop", "value": "Hip Hop"},
    {"label": "Folk", "value": "Folk"},
  ];
  
  List<Map<String, dynamic>> dateOptions = [
    {"label": "All Dates", "value": "All Dates"},
    {"label": "This Week", "value": "This Week"},
    {"label": "This Month", "value": "This Month"},
    {"label": "Next Month", "value": "Next Month"},
    {"label": "This Weekend", "value": "This Weekend"},
  ];
  
  List<Map<String, dynamic>> priceOptions = [
    {"label": "All Prices", "value": "All Prices"},
    {"label": "Free", "value": "Free"},
    {"label": "Under \$50", "value": "Under 50"},
    {"label": "\$50 - \$100", "value": "50-100"},
    {"label": "\$100+", "value": "Over 100"},
  ];
  
  List<Map<String, dynamic>> events = [
    {
      "id": 1,
      "title": "Summer Jazz Festival",
      "artist": "Various Artists",
      "venue": "Central Park",
      "venueType": "Outdoor",
      "location": "New York, NY",
      "date": "July 15, 2025",
      "time": "6:00 PM",
      "price": 75,
      "genre": "Jazz",
      "duration": "4 hours",
      "image": "https://picsum.photos/400/250?random=1&keyword=jazz",
      "capacity": 5000,
      "ticketsLeft": 1200,
      "isPopular": true,
      "tags": ["Live Music", "Food Vendors", "Family Friendly"],
      "description": "Annual jazz festival featuring world-renowned artists",
      "ageRestriction": "All Ages",
    },
    {
      "id": 2,
      "title": "Electronic Nights",
      "artist": "DJ Spectrum",
      "venue": "Metro Club",
      "venueType": "Club",
      "location": "Los Angeles, CA",
      "date": "June 28, 2025",
      "time": "10:00 PM",
      "price": 45,
      "genre": "Electronic",
      "duration": "6 hours",
      "image": "https://picsum.photos/400/250?random=2&keyword=electronic",
      "capacity": 800,
      "ticketsLeft": 250,
      "isPopular": false,
      "tags": ["Dancing", "Late Night", "21+"],
      "description": "High-energy electronic music experience",
      "ageRestriction": "21+",
    },
    {
      "id": 3,
      "title": "Symphony Under Stars",
      "artist": "City Symphony Orchestra",
      "venue": "Outdoor Amphitheater",
      "venueType": "Outdoor",
      "location": "Chicago, IL",
      "date": "August 5, 2025",
      "time": "7:30 PM",
      "price": 95,
      "genre": "Classical",
      "duration": "3 hours",
      "image": "https://picsum.photos/400/250?random=3&keyword=orchestra",
      "capacity": 3000,
      "ticketsLeft": 890,
      "isPopular": true,
      "tags": ["Classical", "Outdoor", "Elegant"],
      "description": "Beautiful classical performance under the night sky",
      "ageRestriction": "All Ages",
    },
    {
      "id": 4,
      "title": "Rock Legends Live",
      "artist": "Thunder Road Band",
      "venue": "Madison Arena",
      "venueType": "Arena",
      "location": "Seattle, WA",
      "date": "July 22, 2025",
      "time": "8:00 PM",
      "price": 120,
      "genre": "Rock",
      "duration": "3.5 hours",
      "image": "https://picsum.photos/400/250?random=4&keyword=rock",
      "capacity": 15000,
      "ticketsLeft": 3400,
      "isPopular": true,
      "tags": ["Rock", "Arena Show", "High Energy"],
      "description": "Epic rock performance with spectacular light show",
      "ageRestriction": "All Ages",
    },
    {
      "id": 5,
      "title": "Indie Folk Acoustic",
      "artist": "Moonlight Collective",
      "venue": "The Blue Note",
      "venueType": "Club",
      "location": "Nashville, TN",
      "date": "June 30, 2025",
      "time": "8:30 PM",
      "price": 35,
      "genre": "Folk",
      "duration": "2.5 hours",
      "image": "https://picsum.photos/400/250?random=5&keyword=acoustic",
      "capacity": 200,
      "ticketsLeft": 45,
      "isPopular": false,
      "tags": ["Acoustic", "Intimate", "Singer-Songwriter"],
      "description": "Intimate acoustic performance in cozy venue",
      "ageRestriction": "18+",
    },
    {
      "id": 6,
      "title": "Hip Hop Block Party",
      "artist": "Various MCs",
      "venue": "Downtown Plaza",
      "venueType": "Festival",
      "location": "Atlanta, GA",
      "date": "July 4, 2025",
      "time": "2:00 PM",
      "price": 0,
      "genre": "Hip Hop",
      "duration": "8 hours",
      "image": "https://picsum.photos/400/250?random=6&keyword=hiphop",
      "capacity": 10000,
      "ticketsLeft": 10000,
      "isPopular": true,
      "tags": ["Free Event", "Community", "Food Trucks"],
      "description": "Free community hip hop celebration",
      "ageRestriction": "All Ages",
    },
  ];
  
  List<Map<String, dynamic>> get filteredEvents {
    return events.where((event) {
      bool matchesSearch = event["title"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
                          event["artist"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
                          event["location"].toString().toLowerCase().contains(searchQuery.toLowerCase());
      bool matchesVenue = selectedVenue == "All Venues" || event["venueType"] == selectedVenue;
      bool matchesGenre = selectedGenre == "All Genres" || event["genre"] == selectedGenre;
      
      return matchesSearch && matchesVenue && matchesGenre;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Live Events"),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.calendar_today),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.location_on),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Featured Event Banner
            Container(
              width: double.infinity,
              height: 220,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(radiusLg),
                    child: Image.network(
                      "https://picsum.photos/800/220?random=10&keyword=concert",
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
                          Colors.black.withAlpha(180),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    top: spSm,
                    left: spSm,
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: spSm,
                        vertical: spXs,
                      ),
                      decoration: BoxDecoration(
                        color: warningColor,
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Text(
                        "Featured Event",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: spSm,
                    left: spSm,
                    right: spSm,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Music Festival 2025",
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
                              Icons.location_on,
                              color: Colors.white,
                              size: 16,
                            ),
                            SizedBox(width: spXs),
                            Text(
                              "Central Park, New York",
                              style: TextStyle(
                                color: Colors.white.withAlpha(220),
                                fontSize: 14,
                              ),
                            ),
                            Spacer(),
                            Text(
                              "July 20-22",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            
            SizedBox(height: spLg),
            
            // Search Bar
            QTextField(
              label: "Search events, artists, venues...",
              value: searchQuery,
              onChanged: (value) {
                searchQuery = value;
                setState(() {});
              },
            ),
            
            SizedBox(height: spLg),
            
            // Quick Filters
            Text(
              "Quick Filters",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            
            SizedBox(height: spSm),
            
            QHorizontalScroll(
              children: [
                _buildQuickFilter("Tonight", Icons.nights_stay),
                _buildQuickFilter("This Weekend", Icons.weekend),
                _buildQuickFilter("Free Events", Icons.money_off),
                _buildQuickFilter("Near Me", Icons.near_me),
                _buildQuickFilter("Popular", Icons.trending_up),
              ],
            ),
            
            SizedBox(height: spLg),
            
            // Filter Row
            Row(
              children: [
                Expanded(
                  child: QDropdownField(
                    label: "Venue",
                    items: venueOptions,
                    value: selectedVenue,
                    onChanged: (value, label) {
                      selectedVenue = value;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QDropdownField(
                    label: "Genre",
                    items: genreOptions,
                    value: selectedGenre,
                    onChanged: (value, label) {
                      selectedGenre = value;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),
            
            SizedBox(height: spLg),
            
            // Results Header
            Row(
              children: [
                Text(
                  "${filteredEvents.length} Events Found",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Spacer(),
                GestureDetector(
                  onTap: () {},
                  child: Row(
                    children: [
                      Text(
                        "Sort by Date",
                        style: TextStyle(
                          color: secondaryColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(width: spXs),
                      Icon(
                        Icons.sort,
                        color: secondaryColor,
                        size: 16,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            
            SizedBox(height: spMd),
            
            // Events List
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: filteredEvents.length,
              itemBuilder: (context, index) {
                final event = filteredEvents[index];
                return Container(
                  margin: EdgeInsets.only(bottom: spMd),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusLg),
                    boxShadow: [shadowSm],
                  ),
                  child: Row(
                    children: [
                      // Event Image
                      ClipRRect(
                        borderRadius: BorderRadius.horizontal(
                          left: Radius.circular(radiusLg),
                        ),
                        child: Stack(
                          children: [
                            Image.network(
                              "${event["image"]}",
                              width: 120,
                              height: 120,
                              fit: BoxFit.cover,
                            ),
                            if (event["isPopular"])
                              Positioned(
                                top: spXs,
                                left: spXs,
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: spXs,
                                    vertical: 2,
                                  ),
                                  decoration: BoxDecoration(
                                    color: warningColor,
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                  child: Text(
                                    "Popular",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                      
                      // Event Details
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.all(spSm),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Title and Price
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Text(
                                      "${event["title"]}",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: primaryColor,
                                      ),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  Text(
                                    event["price"] == 0 ? "FREE" : "\$${event["price"]}",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: event["price"] == 0 ? successColor : primaryColor,
                                    ),
                                  ),
                                ],
                              ),
                              
                              SizedBox(height: spXs),
                              
                              // Artist
                              Text(
                                "${event["artist"]}",
                                style: TextStyle(
                                  color: secondaryColor,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              
                              SizedBox(height: spXs),
                              
                              // Date and Time
                              Row(
                                children: [
                                  Icon(
                                    Icons.calendar_today,
                                    size: 14,
                                    color: disabledBoldColor,
                                  ),
                                  SizedBox(width: spXs),
                                  Text(
                                    "${event["date"]} • ${event["time"]}",
                                    style: TextStyle(
                                      color: disabledBoldColor,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                              
                              SizedBox(height: spXs),
                              
                              // Venue and Location
                              Row(
                                children: [
                                  Icon(
                                    Icons.location_on,
                                    size: 14,
                                    color: disabledBoldColor,
                                  ),
                                  SizedBox(width: spXs),
                                  Expanded(
                                    child: Text(
                                      "${event["venue"]}, ${event["location"]}",
                                      style: TextStyle(
                                        color: disabledBoldColor,
                                        fontSize: 12,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                              
                              SizedBox(height: spXs),
                              
                              // Availability
                              Row(
                                children: [
                                  Container(
                                    width: 8,
                                    height: 8,
                                    decoration: BoxDecoration(
                                      color: _getAvailabilityColor(event["ticketsLeft"], event["capacity"]),
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                  SizedBox(width: spXs),
                                  Text(
                                    "${event["ticketsLeft"]} tickets left",
                                    style: TextStyle(
                                      color: _getAvailabilityColor(event["ticketsLeft"], event["capacity"]),
                                      fontSize: 11,
                                      fontWeight: FontWeight.w600,
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
                );
              },
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildQuickFilter(String label, IconData icon) {
    return Container(
      margin: EdgeInsets.only(right: spSm),
      child: GestureDetector(
        onTap: () {},
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: spSm,
            vertical: spSm,
          ),
          decoration: BoxDecoration(
            color: secondaryColor.withAlpha(20),
            borderRadius: BorderRadius.circular(radiusSm),
            border: Border.all(
              color: secondaryColor.withAlpha(50),
              width: 1,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                icon,
                size: 16,
                color: secondaryColor,
              ),
              SizedBox(width: spXs),
              Text(
                label,
                style: TextStyle(
                  color: secondaryColor,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  
  Color _getAvailabilityColor(int ticketsLeft, int capacity) {
    double percentage = (ticketsLeft / capacity) * 100;
    if (percentage > 50) return successColor;
    if (percentage > 20) return warningColor;
    return dangerColor;
  }
}
