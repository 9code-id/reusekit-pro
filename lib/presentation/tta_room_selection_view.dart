import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class TtaRoomSelectionView extends StatefulWidget {
  const TtaRoomSelectionView({super.key});

  @override
  State<TtaRoomSelectionView> createState() => _TtaRoomSelectionViewState();
}

class _TtaRoomSelectionViewState extends State<TtaRoomSelectionView> {
  String selectedRoomId = "";
  String sortBy = "Price";
  List<String> selectedFilters = [];

  final Map<String, dynamic> hotelInfo = {
    "name": "Grand Ocean Resort & Spa",
    "rating": 4.8,
    "location": "Seminyak Beach, Bali",
    "checkIn": "Dec 25, 2024",
    "checkOut": "Dec 30, 2024",
    "nights": 5,
    "guests": "2 Adults, 1 Child"
  };

  final List<String> sortOptions = [
    "Price",
    "Room Size",
    "Rating",
    "Floor Level"
  ];

  final List<String> filterOptions = [
    "Ocean View",
    "Balcony",
    "Kitchen",
    "Jacuzzi",
    "Non-Smoking",
    "Accessible"
  ];

  List<Map<String, dynamic>> rooms = [
    {
      "id": "1",
      "name": "Standard Ocean View",
      "size": "32 sqm",
      "price": 185,
      "originalPrice": 220,
      "floor": "2-5",
      "maxGuests": 2,
      "bedType": "King Bed",
      "image": "https://picsum.photos/300/200?random=1&keyword=room",
      "amenities": ["Ocean View", "Balcony", "Free WiFi", "Mini Bar", "Air Conditioning"],
      "features": ["32 sqm", "King Bed", "Ocean View", "Private Balcony"],
      "available": 8,
      "cancellation": "Free cancellation until Dec 23",
      "rating": 4.7,
      "smokingPolicy": "Non-Smoking"
    },
    {
      "id": "2",
      "name": "Deluxe Ocean Suite",
      "size": "42 sqm",
      "price": 245,
      "originalPrice": 295,
      "floor": "3-6",
      "maxGuests": 3,
      "bedType": "King Bed + Sofa Bed",
      "image": "https://picsum.photos/300/200?random=2&keyword=suite",
      "amenities": ["Ocean View", "Balcony", "Kitchen", "Free WiFi", "Mini Bar", "Air Conditioning"],
      "features": ["42 sqm", "King Bed + Sofa", "Premium Ocean View", "Large Balcony", "Kitchenette"],
      "available": 5,
      "cancellation": "Free cancellation until Dec 23",
      "rating": 4.8,
      "smokingPolicy": "Non-Smoking"
    },
    {
      "id": "3",
      "name": "Premium Ocean Suite",
      "size": "65 sqm",
      "price": 385,
      "originalPrice": 450,
      "floor": "6-8",
      "maxGuests": 4,
      "bedType": "King Bed + Living Area",
      "image": "https://picsum.photos/300/200?random=3&keyword=luxury",
      "amenities": ["Ocean View", "Balcony", "Kitchen", "Jacuzzi", "Free WiFi", "Mini Bar"],
      "features": ["65 sqm", "King Bed", "Separate Living Area", "Full Kitchen", "Private Jacuzzi"],
      "available": 3,
      "cancellation": "Free cancellation until Dec 23",
      "rating": 4.9,
      "smokingPolicy": "Non-Smoking"
    },
    {
      "id": "4",
      "name": "Garden View Standard",
      "size": "28 sqm",
      "price": 145,
      "originalPrice": 170,
      "floor": "1-3",
      "maxGuests": 2,
      "bedType": "Queen Bed",
      "image": "https://picsum.photos/300/200?random=4&keyword=garden",
      "amenities": ["Garden View", "Balcony", "Free WiFi", "Air Conditioning"],
      "features": ["28 sqm", "Queen Bed", "Garden View", "Small Balcony"],
      "available": 12,
      "cancellation": "Free cancellation until Dec 22",
      "rating": 4.5,
      "smokingPolicy": "Non-Smoking"
    },
    {
      "id": "5",
      "name": "Penthouse Suite",
      "size": "85 sqm",
      "price": 650,
      "originalPrice": 750,
      "floor": "10",
      "maxGuests": 6,
      "bedType": "2 King Beds",
      "image": "https://picsum.photos/300/200?random=5&keyword=penthouse",
      "amenities": ["Ocean View", "Balcony", "Kitchen", "Jacuzzi", "Free WiFi", "Mini Bar", "Accessible"],
      "features": ["85 sqm", "2 King Beds", "Panoramic View", "Full Kitchen", "Private Jacuzzi", "Terrace"],
      "available": 1,
      "cancellation": "Free cancellation until Dec 23",
      "rating": 5.0,
      "smokingPolicy": "Non-Smoking"
    },
    {
      "id": "6",
      "name": "Accessible Ocean View",
      "size": "38 sqm",
      "price": 195,
      "originalPrice": 230,
      "floor": "1-2",
      "maxGuests": 2,
      "bedType": "King Bed",
      "image": "https://picsum.photos/300/200?random=6&keyword=accessible",
      "amenities": ["Ocean View", "Accessible", "Free WiFi", "Air Conditioning"],
      "features": ["38 sqm", "King Bed", "Ocean View", "Wheelchair Accessible", "Roll-in Shower"],
      "available": 4,
      "cancellation": "Free cancellation until Dec 23",
      "rating": 4.6,
      "smokingPolicy": "Non-Smoking"
    },
  ];

  List<Map<String, dynamic>> get filteredRooms {
    List<Map<String, dynamic>> filtered = List.from(rooms);
    
    // Apply filters
    if (selectedFilters.isNotEmpty) {
      filtered = filtered.where((room) {
        List<String> amenities = List<String>.from(room["amenities"]);
        return selectedFilters.every((filter) => amenities.contains(filter));
      }).toList();
    }
    
    // Apply sorting
    switch (sortBy) {
      case "Price":
        filtered.sort((a, b) => (a["price"] as int).compareTo(b["price"] as int));
        break;
      case "Room Size":
        filtered.sort((a, b) {
          int sizeA = int.parse((a["size"] as String).replaceAll(RegExp(r'[^0-9]'), ''));
          int sizeB = int.parse((b["size"] as String).replaceAll(RegExp(r'[^0-9]'), ''));
          return sizeB.compareTo(sizeA);
        });
        break;
      case "Rating":
        filtered.sort((a, b) => (b["rating"] as double).compareTo(a["rating"] as double));
        break;
      case "Floor Level":
        filtered.sort((a, b) => (a["floor"] as String).compareTo(b["floor"] as String));
        break;
    }
    
    return filtered;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Select Room"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => back(),
        ),
      ),
      body: Column(
        children: [
          _buildHotelInfo(),
          _buildFilterRow(),
          Expanded(child: _buildRoomsList()),
          if (selectedRoomId.isNotEmpty) _buildBottomSection(),
        ],
      ),
    );
  }

  Widget _buildHotelInfo() {
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
                      "${hotelInfo["name"]}",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Row(
                      children: [
                        Icon(Icons.star, color: warningColor, size: 16),
                        SizedBox(width: spXs),
                        Text(
                          "${(hotelInfo["rating"] as double)}",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        SizedBox(width: spSm),
                        Text(
                          "${hotelInfo["location"]}",
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
          SizedBox(height: spSm),
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(30),
              borderRadius: BorderRadius.circular(radiusMd),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Check-in",
                        style: TextStyle(
                          fontSize: 12,
                          color: primaryColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        "${hotelInfo["checkIn"]}",
                        style: TextStyle(
                          fontSize: 14,
                          color: primaryColor,
                          fontWeight: FontWeight.bold,
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
                        "Check-out",
                        style: TextStyle(
                          fontSize: 12,
                          color: primaryColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        "${hotelInfo["checkOut"]}",
                        style: TextStyle(
                          fontSize: 14,
                          color: primaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      "${hotelInfo["nights"]} nights",
                      style: TextStyle(
                        fontSize: 12,
                        color: primaryColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      "${hotelInfo["guests"]}",
                      style: TextStyle(
                        fontSize: 14,
                        color: primaryColor,
                        fontWeight: FontWeight.bold,
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
                        "Sort by $sortBy",
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

  Widget _buildRoomsList() {
    return ListView.builder(
      padding: EdgeInsets.all(spMd),
      itemCount: filteredRooms.length,
      itemBuilder: (context, index) {
        final room = filteredRooms[index];
        return _buildRoomCard(room);
      },
    );
  }

  Widget _buildRoomCard(Map<String, dynamic> room) {
    bool isSelected = room["id"] == selectedRoomId;
    int availableRooms = room["available"] as int;
    
    return GestureDetector(
      onTap: () {
        selectedRoomId = room["id"];
        setState(() {});
      },
      child: Container(
        margin: EdgeInsets.only(bottom: spMd),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(radiusMd),
          border: Border.all(
            color: isSelected ? primaryColor : disabledColor,
            width: isSelected ? 2 : 1,
          ),
          boxShadow: isSelected ? [shadowMd] : [shadowSm],
        ),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.horizontal(left: Radius.circular(radiusMd)),
                  child: Image.network(
                    "${room["image"]}",
                    width: 120,
                    height: 160,
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
                                "${room["name"]}",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                            ),
                            if (isSelected)
                              Icon(Icons.check_circle, color: primaryColor, size: 20),
                          ],
                        ),
                        SizedBox(height: spXs),
                        Row(
                          children: [
                            Icon(Icons.aspect_ratio, size: 14, color: disabledBoldColor),
                            SizedBox(width: spXs),
                            Text(
                              "${room["size"]} • Floor ${room["floor"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: spXs),
                        Row(
                          children: [
                            Icon(Icons.people, size: 14, color: disabledBoldColor),
                            SizedBox(width: spXs),
                            Text(
                              "Max ${(room["maxGuests"] as int)} guests • ${room["bedType"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: spXs),
                        Row(
                          children: [
                            Icon(Icons.star, color: warningColor, size: 14),
                            SizedBox(width: spXs),
                            Text(
                              "${(room["rating"] as double)}",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            SizedBox(width: spSm),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                              decoration: BoxDecoration(
                                color: availableRooms <= 3 ? warningColor.withAlpha(30) : successColor.withAlpha(30),
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Text(
                                "$availableRooms rooms left",
                                style: TextStyle(
                                  fontSize: 10,
                                  color: availableRooms <= 3 ? warningColor : successColor,
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
                          children: (room["features"] as List<String>).take(3).map((feature) {
                            return Container(
                              padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                              decoration: BoxDecoration(
                                color: primaryColor.withAlpha(30),
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Text(
                                feature,
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
                            if ((room["originalPrice"] as int) > (room["price"] as int)) ...[
                              Text(
                                "\$${(room["originalPrice"] as int)}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                  decoration: TextDecoration.lineThrough,
                                ),
                              ),
                              SizedBox(width: spXs),
                            ],
                            Text(
                              "\$${(room["price"] as int)}",
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
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          "${room["cancellation"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: successColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () => _showRoomDetails(room),
                        child: Text(
                          "View Details",
                          style: TextStyle(
                            fontSize: 12,
                            color: primaryColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spXs),
                  Row(
                    children: [
                      Icon(Icons.smoke_free, size: 12, color: successColor),
                      SizedBox(width: spXs),
                      Text(
                        "${room["smokingPolicy"]}",
                        style: TextStyle(
                          fontSize: 10,
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
      ),
    );
  }

  Widget _buildBottomSection() {
    Map<String, dynamic> selectedRoom = rooms.firstWhere((room) => room["id"] == selectedRoomId);
    int totalNights = hotelInfo["nights"] as int;
    int totalPrice = (selectedRoom["price"] as int) * totalNights;
    
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [shadowMd],
      ),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(30),
              borderRadius: BorderRadius.circular(radiusMd),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Selected Room",
                        style: TextStyle(
                          fontSize: 12,
                          color: primaryColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        "${selectedRoom["name"]}",
                        style: TextStyle(
                          fontSize: 14,
                          color: primaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      "\$${(selectedRoom["price"] as int)} x $totalNights nights",
                      style: TextStyle(
                        fontSize: 12,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "\$${totalPrice}",
                      style: TextStyle(
                        fontSize: 16,
                        color: primaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: spMd),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Total Price",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "\$${totalPrice}",
                      style: TextStyle(
                        fontSize: fsH4,
                        fontWeight: FontWeight.bold,
                        color: successColor,
                      ),
                    ),
                    Text(
                      "for $totalNights nights",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: spMd),
              QButton(
                label: "Continue to Booking",
                size: bs.md,
                onPressed: () {
                  //navigateTo('BookingView')
                },
              ),
            ],
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
          height: 500,
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
                        "Room Features",
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

  void _showRoomDetails(Map<String, dynamic> room) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: 600,
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
            ClipRRect(
              borderRadius: BorderRadius.circular(radiusMd),
              child: Image.network(
                "${room["image"]}",
                width: double.infinity,
                height: 200,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: spMd),
            Text(
              "${room["name"]}",
              style: TextStyle(
                fontSize: fsH5,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spSm),
            Text(
              "Room Features",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spSm),
            Expanded(
              child: SingleChildScrollView(
                child: Wrap(
                  spacing: spSm,
                  runSpacing: spSm,
                  children: (room["amenities"] as List<String>).map((amenity) {
                    return Container(
                      padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                      decoration: BoxDecoration(
                        color: primaryColor.withAlpha(30),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Text(
                        amenity,
                        style: TextStyle(
                          fontSize: 14,
                          color: primaryColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "\$${(room["price"] as int)}",
                        style: TextStyle(
                          fontSize: fsH4,
                          fontWeight: FontWeight.bold,
                          color: successColor,
                        ),
                      ),
                      Text(
                        "per night",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ),
                QButton(
                  label: "Select Room",
                  size: bs.md,
                  onPressed: () {
                    selectedRoomId = room["id"];
                    setState(() {});
                    back();
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
