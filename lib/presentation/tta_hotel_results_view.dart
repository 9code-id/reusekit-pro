import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class TtaHotelResultsView extends StatefulWidget {
  const TtaHotelResultsView({super.key});

  @override
  State<TtaHotelResultsView> createState() => _TtaHotelResultsViewState();
}

class _TtaHotelResultsViewState extends State<TtaHotelResultsView> {
  String sortBy = "Recommended";
  List<String> selectedFilters = [];
  String priceRange = "All";

  final Map<String, dynamic> searchInfo = {
    "destination": "Bali, Indonesia",
    "checkIn": "Dec 25, 2024",
    "checkOut": "Dec 30, 2024",
    "guests": "2 Adults, 1 Child",
    "rooms": 1
  };

  final List<String> sortOptions = [
    "Recommended",
    "Price: Low to High",
    "Price: High to Low",
    "Rating",
    "Distance"
  ];

  final List<String> filterOptions = [
    "Free WiFi",
    "Swimming Pool",
    "Spa",
    "Gym",
    "Restaurant",
    "Free Parking",
    "Pet Friendly",
    "Business Center"
  ];

  final List<String> priceRanges = [
    "All",
    "Under \$100",
    "\$100 - \$200",
    "\$200 - \$500",
    "Above \$500"
  ];

  List<Map<String, dynamic>> hotels = [
    {
      "id": "1",
      "name": "Grand Ocean Resort & Spa",
      "rating": 4.8,
      "reviews": 2847,
      "price": 185,
      "originalPrice": 220,
      "image": "https://picsum.photos/300/200?random=1&keyword=hotel",
      "location": "Seminyak Beach",
      "distance": "0.2 km from beach",
      "amenities": ["Free WiFi", "Swimming Pool", "Spa", "Restaurant"],
      "features": ["Beach Front", "Luxury", "Couples Friendly"],
      "cancellation": "Free cancellation until Dec 23"
    },
    {
      "id": "2",
      "name": "Tropical Garden Villa",
      "rating": 4.6,
      "reviews": 1523,
      "price": 120,
      "originalPrice": 150,
      "image": "https://picsum.photos/300/200?random=2&keyword=villa",
      "location": "Ubud",
      "distance": "1.5 km from center",
      "amenities": ["Free WiFi", "Swimming Pool", "Gym", "Free Parking"],
      "features": ["Nature View", "Family Friendly", "Traditional"],
      "cancellation": "Free cancellation until Dec 20"
    },
    {
      "id": "3",
      "name": "Sunset Beach Hotel",
      "rating": 4.7,
      "reviews": 3241,
      "price": 95,
      "originalPrice": 120,
      "image": "https://picsum.photos/300/200?random=3&keyword=beach",
      "location": "Kuta Beach",
      "distance": "Beach front",
      "amenities": ["Free WiFi", "Swimming Pool", "Restaurant", "Free Parking"],
      "features": ["Beach Front", "Budget Friendly", "Surfing"],
      "cancellation": "Non-refundable"
    },
    {
      "id": "4",
      "name": "Royal Palace Suites",
      "rating": 4.9,
      "reviews": 896,
      "price": 350,
      "originalPrice": 450,
      "image": "https://picsum.photos/300/200?random=4&keyword=luxury",
      "location": "Nusa Dua",
      "distance": "Golf course view",
      "amenities": ["Free WiFi", "Swimming Pool", "Spa", "Gym", "Business Center"],
      "features": ["Luxury", "Golf", "Business Friendly"],
      "cancellation": "Free cancellation until Dec 23"
    },
    {
      "id": "5",
      "name": "Bamboo Eco Lodge",
      "rating": 4.4,
      "reviews": 567,
      "price": 75,
      "originalPrice": 95,
      "image": "https://picsum.photos/300/200?random=5&keyword=nature",
      "location": "Canggu",
      "distance": "2 km from beach",
      "amenities": ["Free WiFi", "Restaurant", "Free Parking", "Pet Friendly"],
      "features": ["Eco Friendly", "Surfing", "Yoga"],
      "cancellation": "Free cancellation until Dec 22"
    },
    {
      "id": "6",
      "name": "City Center Business Hotel",
      "rating": 4.3,
      "reviews": 1789,
      "price": 140,
      "originalPrice": 170,
      "image": "https://picsum.photos/300/200?random=6&keyword=business",
      "location": "Denpasar",
      "distance": "City center",
      "amenities": ["Free WiFi", "Gym", "Business Center", "Free Parking"],
      "features": ["Business Friendly", "Shopping", "Airport Shuttle"],
      "cancellation": "Free cancellation until Dec 24"
    },
  ];

  List<Map<String, dynamic>> get filteredHotels {
    List<Map<String, dynamic>> filtered = List.from(hotels);
    
    // Apply price filter
    if (priceRange != "All") {
      filtered = filtered.where((hotel) {
        int price = hotel["price"] as int;
        switch (priceRange) {
          case "Under \$100":
            return price < 100;
          case "\$100 - \$200":
            return price >= 100 && price <= 200;
          case "\$200 - \$500":
            return price >= 200 && price <= 500;
          case "Above \$500":
            return price > 500;
          default:
            return true;
        }
      }).toList();
    }
    
    // Apply amenity filters
    if (selectedFilters.isNotEmpty) {
      filtered = filtered.where((hotel) {
        List<String> amenities = List<String>.from(hotel["amenities"]);
        return selectedFilters.every((filter) => amenities.contains(filter));
      }).toList();
    }
    
    // Apply sorting
    switch (sortBy) {
      case "Price: Low to High":
        filtered.sort((a, b) => (a["price"] as int).compareTo(b["price"] as int));
        break;
      case "Price: High to Low":
        filtered.sort((a, b) => (b["price"] as int).compareTo(a["price"] as int));
        break;
      case "Rating":
        filtered.sort((a, b) => (b["rating"] as double).compareTo(a["rating"] as double));
        break;
    }
    
    return filtered;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Hotels in Bali"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => back(),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.map),
            onPressed: () {
              //navigateTo('MapView')
            },
          ),
        ],
      ),
      body: Column(
        children: [
          _buildSearchInfo(),
          _buildFilterRow(),
          Expanded(child: _buildHotelList()),
        ],
      ),
    );
  }

  Widget _buildSearchInfo() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [shadowSm],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${searchInfo["destination"]}",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "${searchInfo["checkIn"]} - ${searchInfo["checkOut"]}",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    "${searchInfo["guests"]}",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spXs),
                  Text(
                    "${searchInfo["rooms"]} Room",
                    style: TextStyle(
                      fontSize: 14,
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: spSm),
          Container(
            padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
            decoration: BoxDecoration(
              color: successColor.withAlpha(30),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Row(
              children: [
                Icon(Icons.check_circle, color: successColor, size: 16),
                SizedBox(width: spXs),
                Text(
                  "Found ${filteredHotels.length} hotels available",
                  style: TextStyle(
                    fontSize: 12,
                    color: successColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterRow() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: spMd, vertical: spSm),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () => _showSortOptions(),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  border: Border.all(color: disabledColor),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Row(
                  children: [
                    Icon(Icons.sort, size: 16, color: primaryColor),
                    SizedBox(width: spXs),
                    Expanded(
                      child: Text(
                        sortBy,
                        style: TextStyle(
                          fontSize: 14,
                          color: primaryColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Icon(Icons.keyboard_arrow_down, size: 16, color: primaryColor),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(width: spSm),
          GestureDetector(
            onTap: () => _showFilters(),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
              decoration: BoxDecoration(
                color: selectedFilters.isNotEmpty ? primaryColor : Colors.white,
                border: Border.all(color: primaryColor),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.filter_list,
                    size: 16,
                    color: selectedFilters.isNotEmpty ? Colors.white : primaryColor,
                  ),
                  SizedBox(width: spXs),
                  Text(
                    "Filter",
                    style: TextStyle(
                      fontSize: 14,
                      color: selectedFilters.isNotEmpty ? Colors.white : primaryColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  if (selectedFilters.isNotEmpty) ...[
                    SizedBox(width: spXs),
                    Container(
                      padding: EdgeInsets.all(2),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Text(
                        "${selectedFilters.length}",
                        style: TextStyle(
                          fontSize: 10,
                          color: primaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHotelList() {
    return ListView.builder(
      padding: EdgeInsets.all(spMd),
      itemCount: filteredHotels.length,
      itemBuilder: (context, index) {
        final hotel = filteredHotels[index];
        return _buildHotelCard(hotel);
      },
    );
  }

  Widget _buildHotelCard(Map<String, dynamic> hotel) {
    return Container(
      margin: EdgeInsets.only(bottom: spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.horizontal(left: Radius.circular(radiusMd)),
                child: Image.network(
                  "${hotel["image"]}",
                  width: 120,
                  height: 140,
                  fit: BoxFit.cover,
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(spSm),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              "${hotel["name"]}",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                            decoration: BoxDecoration(
                              color: successColor,
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  "${(hotel["rating"] as double)}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                SizedBox(width: 2),
                                Icon(Icons.star, color: Colors.white, size: 10),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spXs),
                      Row(
                        children: [
                          Icon(Icons.location_on, size: 14, color: disabledBoldColor),
                          SizedBox(width: spXs),
                          Expanded(
                            child: Text(
                              "${hotel["location"]} • ${hotel["distance"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "${(hotel["reviews"] as int)} reviews",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                      SizedBox(height: spSm),
                      Wrap(
                        spacing: spXs,
                        runSpacing: spXs,
                        children: (hotel["amenities"] as List<String>).take(3).map((amenity) {
                          return Container(
                            padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                            decoration: BoxDecoration(
                              color: primaryColor.withAlpha(30),
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Text(
                              amenity,
                              style: TextStyle(
                                fontSize: 10,
                                color: primaryColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                      SizedBox(height: spSm),
                      Row(
                        children: [
                          if ((hotel["originalPrice"] as int) > (hotel["price"] as int)) ...[
                            Text(
                              "\$${(hotel["originalPrice"] as int)}",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                                decoration: TextDecoration.lineThrough,
                              ),
                            ),
                            SizedBox(width: spXs),
                          ],
                          Text(
                            "\$${(hotel["price"] as int)}",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: successColor,
                            ),
                          ),
                          Text(
                            "/night",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
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
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.grey.withAlpha(20),
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(radiusMd)),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    "${hotel["cancellation"]}",
                    style: TextStyle(
                      fontSize: 12,
                      color: (hotel["cancellation"] as String).contains("Free") 
                        ? successColor 
                        : warningColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                QButton(
                  label: "View Details",
                  size: bs.sm,
                  onPressed: () {
                    //navigateTo('HotelDetailView')
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
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
                color: primaryColor,
              ),
            ),
            SizedBox(height: spMd),
            ...sortOptions.map((option) {
              bool isSelected = option == sortBy;
              return GestureDetector(
                onTap: () {
                  sortBy = option;
                  setState(() {});
                  back();
                },
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: spSm),
                  child: Row(
                    children: [
                      Text(
                        option,
                        style: TextStyle(
                          fontSize: 16,
                          color: isSelected ? primaryColor : disabledBoldColor,
                          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                        ),
                      ),
                      Spacer(),
                      if (isSelected)
                        Icon(Icons.check, color: primaryColor),
                    ],
                  ),
                ),
              );
            }).toList(),
          ],
        ),
      ),
    );
  }

  void _showFilters() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => StatefulBuilder(
        builder: (context, setModalState) => Container(
          height: 600,
          padding: EdgeInsets.all(spMd),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    "Filters",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Spacer(),
                  GestureDetector(
                    onTap: () {
                      selectedFilters.clear();
                      priceRange = "All";
                      setModalState(() {});
                    },
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
              SizedBox(height: spMd),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Price Range",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      SizedBox(height: spSm),
                      Wrap(
                        spacing: spSm,
                        runSpacing: spXs,
                        children: priceRanges.map((range) {
                          bool isSelected = range == priceRange;
                          return GestureDetector(
                            onTap: () {
                              priceRange = range;
                              setModalState(() {});
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                              decoration: BoxDecoration(
                                color: isSelected ? primaryColor : Colors.white,
                                border: Border.all(color: primaryColor),
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Text(
                                range,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: isSelected ? Colors.white : primaryColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                      SizedBox(height: spMd),
                      Text(
                        "Amenities",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      SizedBox(height: spSm),
                      Wrap(
                        spacing: spSm,
                        runSpacing: spXs,
                        children: filterOptions.map((filter) {
                          bool isSelected = selectedFilters.contains(filter);
                          return GestureDetector(
                            onTap: () {
                              if (isSelected) {
                                selectedFilters.remove(filter);
                              } else {
                                selectedFilters.add(filter);
                              }
                              setModalState(() {});
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                              decoration: BoxDecoration(
                                color: isSelected ? primaryColor : Colors.white,
                                border: Border.all(color: primaryColor),
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Text(
                                filter,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: isSelected ? Colors.white : primaryColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ),
              ),
              QButton(
                label: "Apply Filters",
                size: bs.md,
                onPressed: () {
                  setState(() {});
                  back();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
