import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class BrsFavoriteBarbersView extends StatefulWidget {
  const BrsFavoriteBarbersView({super.key});

  @override
  State<BrsFavoriteBarbersView> createState() => _BrsFavoriteBarbersViewState();
}

class _BrsFavoriteBarbersViewState extends State<BrsFavoriteBarbersView> {
  bool loading = false;
  String searchQuery = "";

  List<Map<String, dynamic>> favoriteBarbers = [
    {
      "id": "1",
      "name": "Mike Johnson",
      "shop": "Elite Barber Shop",
      "image": "https://picsum.photos/120/120?random=101&keyword=barber",
      "rating": 4.8,
      "reviews": 156,
      "specialties": ["Classic Cut", "Beard Trim", "Fade"],
      "price_range": "\$25-45",
      "distance": "0.8 miles",
      "experience": "8 years",
      "next_available": "Today 3:00 PM",
      "is_available": true,
      "total_bookings": 12,
    },
    {
      "id": "2",
      "name": "Alex Brown",
      "shop": "The Gentleman's Cut",
      "image": "https://picsum.photos/120/120?random=102&keyword=barber",
      "rating": 4.9,
      "reviews": 203,
      "specialties": ["Modern Styling", "Hot Towel", "Shave"],
      "price_range": "\$30-50",
      "distance": "1.2 miles",
      "experience": "12 years",
      "next_available": "Tomorrow 10:00 AM",
      "is_available": false,
      "total_bookings": 8,
    },
    {
      "id": "3",
      "name": "David Wilson",
      "shop": "Urban Cuts",
      "image": "https://picsum.photos/120/120?random=103&keyword=barber",
      "rating": 4.7,
      "reviews": 89,
      "specialties": ["Trendy Cuts", "Color", "Styling"],
      "price_range": "\$35-60",
      "distance": "2.1 miles",
      "experience": "6 years",
      "next_available": "Dec 16, 2:30 PM",
      "is_available": true,
      "total_bookings": 15,
    },
    {
      "id": "4",
      "name": "Chris Taylor",
      "shop": "Classic Barber Co.",
      "image": "https://picsum.photos/120/120?random=104&keyword=barber",
      "rating": 4.6,
      "reviews": 124,
      "specialties": ["Traditional Cut", "Mustache", "Beard"],
      "price_range": "\$20-40",
      "distance": "0.5 miles",
      "experience": "10 years",
      "next_available": "Today 5:00 PM",
      "is_available": true,
      "total_bookings": 9,
    },
    {
      "id": "5",
      "name": "Ryan Martinez",
      "shop": "Precision Cuts",
      "image": "https://picsum.photos/120/120?random=105&keyword=barber",
      "rating": 4.8,
      "reviews": 167,
      "specialties": ["Precision Cut", "Fade", "Line Up"],
      "price_range": "\$28-48",
      "distance": "1.8 miles",
      "experience": "7 years",
      "next_available": "Tomorrow 1:00 PM",
      "is_available": true,
      "total_bookings": 6,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Favorite Barbers"),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () => si("Search functionality"),
          ),
        ],
      ),
      body: loading 
        ? Center(child: CircularProgressIndicator())
        : favoriteBarbers.isEmpty 
          ? _buildEmptyState()
          : Column(
              children: [
                _buildSearchBar(),
                _buildStatsHeader(),
                Expanded(
                  child: _buildBarbersList(),
                ),
              ],
            ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      padding: EdgeInsets.all(spMd),
      child: Row(
        spacing: spSm,
        children: [
          Expanded(
            child: QTextField(
              label: "Search favorite barbers...",
              value: searchQuery,
              onChanged: (value) {
                searchQuery = value;
                setState(() {});
              },
            ),
          ),
          QButton(
            icon: Icons.filter_list,
            size: bs.sm,
            onPressed: () => si("Filter options"),
          ),
        ],
      ),
    );
  }

  Widget _buildStatsHeader() {
    List<Map<String, dynamic>> filteredBarbers = _getFilteredBarbers();
    
    return Container(
      padding: EdgeInsets.symmetric(horizontal: spMd, vertical: spSm),
      child: Row(
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: primaryColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.favorite,
                    color: primaryColor,
                    size: 16,
                  ),
                  SizedBox(width: spXs),
                  Text(
                    "${filteredBarbers.length} Favorites",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: primaryColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: successColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.access_time,
                    color: successColor,
                    size: 16,
                  ),
                  SizedBox(width: spXs),
                  Text(
                    "${filteredBarbers.where((b) => b["is_available"] as bool).length} Available",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: successColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBarbersList() {
    List<Map<String, dynamic>> filteredBarbers = _getFilteredBarbers();
    
    return ListView.builder(
      padding: EdgeInsets.symmetric(horizontal: spMd),
      itemCount: filteredBarbers.length,
      itemBuilder: (context, index) {
        Map<String, dynamic> barber = filteredBarbers[index];
        return _buildBarberCard(barber);
      },
    );
  }

  Widget _buildBarberCard(Map<String, dynamic> barber) {
    bool isAvailable = barber["is_available"] as bool;
    
    return Container(
      margin: EdgeInsets.only(bottom: spMd),
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        children: [
          Row(
            children: [
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(radiusSm),
                    child: Image.network(
                      "${barber["image"]}",
                      width: 70,
                      height: 70,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    top: spXs,
                    right: spXs,
                    child: GestureDetector(
                      onTap: () => _removeFromFavorites(barber["id"]),
                      child: Container(
                        width: 24,
                        height: 24,
                        decoration: BoxDecoration(
                          color: dangerColor,
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Icon(
                          Icons.favorite,
                          color: Colors.white,
                          size: 14,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(width: spMd),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spXs,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            "${barber["name"]}",
                            style: TextStyle(
                              fontSize: fsH6,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: spXs,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: isAvailable ? successColor : dangerColor,
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            isAvailable ? "Available" : "Busy",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Text(
                      "${barber["shop"]}",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.star,
                          color: Colors.amber,
                          size: 16,
                        ),
                        SizedBox(width: spXs),
                        Text(
                          "${barber["rating"]}",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          " (${barber["reviews"]} reviews)",
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                          ),
                        ),
                        Spacer(),
                        Text(
                          "${barber["distance"]}",
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(10),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Column(
              spacing: spXs,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.content_cut,
                      color: primaryColor,
                      size: 16,
                    ),
                    SizedBox(width: spXs),
                    Expanded(
                      child: Text(
                        "Specialties: ${(barber["specialties"] as List).join(", ")}",
                        style: TextStyle(
                          fontSize: 14,
                          color: primaryColor,
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Icon(
                      Icons.schedule,
                      color: disabledBoldColor,
                      size: 16,
                    ),
                    SizedBox(width: spXs),
                    Text(
                      "Next available: ${barber["next_available"]}",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                    Spacer(),
                    Text(
                      "${barber["price_range"]}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Row(
            spacing: spSm,
            children: [
              Expanded(
                child: QButton(
                  label: "View Profile",
                  size: bs.sm,
                  color: disabledBoldColor,
                  onPressed: () => si("View barber profile"),
                ),
              ),
              Expanded(
                child: QButton(
                  label: isAvailable ? "Book Now" : "Schedule",
                  size: bs.sm,
                  onPressed: () => si("Book appointment"),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        spacing: spMd,
        children: [
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              color: disabledColor,
              borderRadius: BorderRadius.circular(radiusLg),
            ),
            child: Icon(
              Icons.favorite_border,
              color: disabledBoldColor,
              size: 50,
            ),
          ),
          Text(
            "No Favorite Barbers Yet",
            style: TextStyle(
              fontSize: fsH5,
              fontWeight: FontWeight.bold,
              color: disabledBoldColor,
            ),
          ),
          Text(
            "Start adding barbers to your favorites\nfor quick booking access",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              color: disabledBoldColor,
            ),
          ),
          SizedBox(height: spMd),
          QButton(
            label: "Discover Barbers",
            size: bs.md,
            onPressed: () => si("Navigate to barber list"),
          ),
        ],
      ),
    );
  }

  List<Map<String, dynamic>> _getFilteredBarbers() {
    if (searchQuery.isEmpty) {
      return favoriteBarbers;
    }
    
    return favoriteBarbers.where((barber) {
      String name = (barber["name"] as String).toLowerCase();
      String shop = (barber["shop"] as String).toLowerCase();
      String query = searchQuery.toLowerCase();
      
      return name.contains(query) || shop.contains(query);
    }).toList();
  }

  void _removeFromFavorites(String barberId) async {
    bool isConfirmed = await confirm("Remove this barber from favorites?");
    if (!isConfirmed) return;

    setState(() {
      favoriteBarbers.removeWhere((barber) => barber["id"] == barberId);
    });

    ss("Barber removed from favorites");
  }
}
