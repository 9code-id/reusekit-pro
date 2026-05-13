import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class EcmVenueDetailsView extends StatefulWidget {
  const EcmVenueDetailsView({super.key});

  @override
  State<EcmVenueDetailsView> createState() => _EcmVenueDetailsViewState();
}

class _EcmVenueDetailsViewState extends State<EcmVenueDetailsView> {
  int selectedImageIndex = 0;
  bool isFavorite = false;
  bool showContactDetails = false;
  int selectedRoomIndex = 0;
  
  Map<String, dynamic> venue = {
    "id": "1",
    "name": "Grand Conference Center",
    "type": "Conference Center",
    "city": "New York",
    "address": "123 Business Ave, New York, NY 10001",
    "phone": "+1 (555) 123-4567",
    "email": "bookings@grandconference.com",
    "website": "www.grandconference.com",
    "capacity": 500,
    "dailyRate": 2500,
    "rating": 4.8,
    "reviews": 156,
    "description": "Modern conference center with state-of-the-art facilities, located in the heart of Manhattan's business district. Perfect for corporate events, conferences, and seminars.",
    "images": [
      "https://picsum.photos/400/300?random=11&keyword=conference",
      "https://picsum.photos/400/300?random=12&keyword=auditorium",
      "https://picsum.photos/400/300?random=13&keyword=lobby",
      "https://picsum.photos/400/300?random=14&keyword=meeting",
      "https://picsum.photos/400/300?random=15&keyword=catering",
    ],
    "amenities": [
      {"name": "Free Parking", "icon": Icons.local_parking, "included": true},
      {"name": "High-Speed WiFi", "icon": Icons.wifi, "included": true},
      {"name": "A/V Equipment", "icon": Icons.tv, "included": true},
      {"name": "Accessibility", "icon": Icons.accessible, "included": true},
      {"name": "Catering Kitchen", "icon": Icons.restaurant, "included": true},
      {"name": "Security System", "icon": Icons.security, "included": true},
      {"name": "Air Conditioning", "icon": Icons.ac_unit, "included": true},
      {"name": "Backup Power", "icon": Icons.power, "included": false},
    ],
    "rooms": [
      {
        "name": "Main Auditorium",
        "capacity": 500,
        "size": "5,000 sq ft",
        "hourlyRate": 150,
        "features": ["Theater seating", "Stage", "Projection screen", "Sound system"],
      },
      {
        "name": "Conference Room A",
        "capacity": 50,
        "size": "800 sq ft",
        "hourlyRate": 75,
        "features": ["Boardroom table", "Whiteboard", "Video conferencing", "Natural lighting"],
      },
      {
        "name": "Conference Room B",
        "capacity": 30,
        "size": "600 sq ft",
        "hourlyRate": 60,
        "features": ["U-shape seating", "Flipchart", "Projector", "Private entrance"],
      },
      {
        "name": "Breakout Space",
        "capacity": 20,
        "size": "400 sq ft",
        "hourlyRate": 40,
        "features": ["Casual seating", "Coffee station", "Whiteboards", "Natural lighting"],
      },
    ],
    "policies": [
      "24-hour advance booking required",
      "Full payment due upon confirmation",
      "Cancellation allowed up to 48 hours in advance",
      "Security deposit may be required for some events",
      "Outside catering allowed with approval",
      "Setup and cleanup time included in booking",
    ],
    "reviews": [
      {
        "name": "Sarah Johnson",
        "rating": 5,
        "date": "2024-01-15",
        "comment": "Excellent venue with professional staff. The A/V equipment was top-notch and the space was perfect for our corporate conference.",
      },
      {
        "name": "Mike Chen",
        "rating": 4,
        "date": "2024-01-10",
        "comment": "Great location and facilities. Parking was convenient. Only minor issue was the air conditioning in one of the breakout rooms.",
      },
      {
        "name": "Lisa Rodriguez",
        "rating": 5,
        "date": "2024-01-08",
        "comment": "Outstanding service and beautiful venue. The catering options were excellent and the staff was very accommodating.",
      },
    ],
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Venue Details"),
        actions: [
          GestureDetector(
            onTap: () {
              isFavorite = !isFavorite;
              setState(() {});
            },
            child: Icon(
              isFavorite ? Icons.favorite : Icons.favorite_border,
              color: isFavorite ? dangerColor : null,
            ),
          ),
          SizedBox(width: spSm),
          QButton(
            label: "Book Now",
            size: bs.sm,
            onPressed: () => _bookVenue(),
          ),
          SizedBox(width: spSm),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildImageGallery(),
            _buildVenueHeader(),
            _buildAmenitiesSection(),
            _buildRoomsSection(),
            _buildPoliciesSection(),
            _buildReviewsSection(),
            _buildContactSection(),
            SizedBox(height: spMd),
          ],
        ),
      ),
    );
  }

  Widget _buildImageGallery() {
    return Container(
      height: 250,
      child: Column(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () => _showImageGallery(),
              child: Stack(
                children: [
                  Container(
                    width: double.infinity,
                    child: Image.network(
                      "${(venue["images"] as List)[selectedImageIndex]}",
                      fit: BoxFit.cover,
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
                      child: Text(
                        "${selectedImageIndex + 1}/${(venue["images"] as List).length}",
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
          ),
          Container(
            height: 80,
            padding: EdgeInsets.symmetric(vertical: spSm),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.symmetric(horizontal: spSm),
              itemCount: (venue["images"] as List).length,
              itemBuilder: (context, index) {
                final isSelected = selectedImageIndex == index;
                return GestureDetector(
                  onTap: () {
                    selectedImageIndex = index;
                    setState(() {});
                  },
                  child: Container(
                    width: 80,
                    height: 60,
                    margin: EdgeInsets.only(right: spSm),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(radiusSm),
                      border: Border.all(
                        color: isSelected ? primaryColor : Colors.transparent,
                        width: 2,
                      ),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(radiusSm),
                      child: Image.network(
                        "${(venue["images"] as List)[index]}",
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVenueHeader() {
    return Container(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${venue["name"]}",
                      style: TextStyle(
                        fontSize: fsH5,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "${venue["type"]} • ${venue["city"]}",
                      style: TextStyle(
                        color: disabledBoldColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    "\$${((venue["dailyRate"] as int).toDouble()).currency}",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Text(
                    "per day",
                    style: TextStyle(
                      color: disabledBoldColor,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Row(
            children: [
              Icon(
                Icons.star,
                color: warningColor,
                size: 18,
              ),
              SizedBox(width: spXs),
              Text(
                "${venue["rating"]}",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: disabledBoldColor,
                ),
              ),
              Text(
                " (${venue["reviews"]} reviews)",
                style: TextStyle(
                  fontSize: 14,
                  color: disabledBoldColor,
                ),
              ),
              SizedBox(width: spSm),
              Icon(
                Icons.people,
                color: primaryColor,
                size: 18,
              ),
              SizedBox(width: spXs),
              Text(
                "Up to ${venue["capacity"]} people",
                style: TextStyle(
                  fontSize: 14,
                  color: primaryColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Icon(
                Icons.location_on,
                color: primaryColor,
                size: 16,
              ),
              SizedBox(width: spXs),
              Expanded(
                child: Text(
                  "${venue["address"]}",
                  style: TextStyle(
                    color: disabledBoldColor,
                    fontSize: 13,
                  ),
                ),
              ),
            ],
          ),
          Text(
            "${venue["description"]}",
            style: TextStyle(
              color: disabledBoldColor,
              fontSize: 14,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAmenitiesSection() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Text(
            "Amenities & Features",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: (venue["amenities"] as List).map((amenity) {
              final isIncluded = amenity["included"] as bool;
              return Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: isIncluded ? successColor.withAlpha(10) : Colors.grey[50],
                  borderRadius: BorderRadius.circular(radiusSm),
                  border: Border.all(
                    color: isIncluded ? successColor.withAlpha(30) : Colors.grey.withAlpha(30),
                  ),
                ),
                child: Row(
                  children: [
                    Icon(
                      amenity["icon"] as IconData,
                      color: isIncluded ? successColor : disabledBoldColor,
                      size: 20,
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${amenity["name"]}",
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: isIncluded ? successColor : disabledBoldColor,
                            ),
                          ),
                          Text(
                            isIncluded ? "Included" : "Not available",
                            style: TextStyle(
                              fontSize: 11,
                              color: isIncluded ? successColor : disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (isIncluded)
                      Icon(
                        Icons.check_circle,
                        color: successColor,
                        size: 16,
                      ),
                  ],
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildRoomsSection() {
    return Container(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Text(
            "Available Rooms",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Column(
            spacing: spSm,
            children: (venue["rooms"] as List).asMap().entries.map((entry) {
              final index = entry.key;
              final room = entry.value;
              final isSelected = selectedRoomIndex == index;
              
              return GestureDetector(
                onTap: () {
                  selectedRoomIndex = index;
                  setState(() {});
                },
                child: Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: isSelected ? primaryColor.withAlpha(10) : Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    border: Border.all(
                      color: isSelected ? primaryColor : disabledOutlineBorderColor,
                      width: isSelected ? 2 : 1,
                    ),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: spSm,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${room["name"]}",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: isSelected ? primaryColor : Colors.black,
                                  ),
                                ),
                                SizedBox(height: spXs),
                                Text(
                                  "${room["size"]} • Up to ${room["capacity"]} people",
                                  style: TextStyle(
                                    color: disabledBoldColor,
                                    fontSize: 13,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                "\$${((room["hourlyRate"] as int).toDouble()).currency}",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                              Text(
                                "per hour",
                                style: TextStyle(
                                  color: disabledBoldColor,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                          if (isSelected) ...[
                            SizedBox(width: spSm),
                            Icon(
                              Icons.check_circle,
                              color: successColor,
                              size: 20,
                            ),
                          ],
                        ],
                      ),
                      Wrap(
                        spacing: spXs,
                        runSpacing: spXs,
                        children: (room["features"] as List<String>).map((feature) {
                          return Container(
                            padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                            decoration: BoxDecoration(
                              color: primaryColor.withAlpha(10),
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Text(
                              feature,
                              style: TextStyle(
                                fontSize: 11,
                                color: primaryColor,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildPoliciesSection() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Text(
            "Venue Policies",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spSm,
              children: (venue["policies"] as List<String>).map((policy) {
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 6),
                      width: 4,
                      height: 4,
                      decoration: BoxDecoration(
                        color: primaryColor,
                        shape: BoxShape.circle,
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: Text(
                        policy,
                        style: TextStyle(
                          color: disabledBoldColor,
                          fontSize: 13,
                          height: 1.4,
                        ),
                      ),
                    ),
                  ],
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReviewsSection() {
    return Container(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Row(
            children: [
              Text(
                "Reviews",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Spacer(),
              GestureDetector(
                onTap: () => _showAllReviews(),
                child: Text(
                  "View All",
                  style: TextStyle(
                    color: primaryColor,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          Column(
            spacing: spSm,
            children: (venue["reviews"] as List).take(2).map((review) {
              return Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spXs,
                  children: [
                    Row(
                      children: [
                        Text(
                          "${review["name"]}",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: primaryColor,
                            fontSize: 14,
                          ),
                        ),
                        Spacer(),
                        Row(
                          children: List.generate(5, (index) {
                            return Icon(
                              index < (review["rating"] as int) ? Icons.star : Icons.star_border,
                              color: warningColor,
                              size: 14,
                            );
                          }),
                        ),
                        SizedBox(width: spSm),
                        Text(
                          "${DateTime.parse(review["date"]).dMMMy}",
                          style: TextStyle(
                            color: disabledBoldColor,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      "${review["comment"]}",
                      style: TextStyle(
                        color: disabledBoldColor,
                        fontSize: 13,
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildContactSection() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Row(
            children: [
              Text(
                "Contact Information",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Spacer(),
              GestureDetector(
                onTap: () {
                  showContactDetails = !showContactDetails;
                  setState(() {});
                },
                child: Icon(
                  showContactDetails ? Icons.expand_less : Icons.expand_more,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          if (showContactDetails)
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                spacing: spSm,
                children: [
                  _buildContactRow(Icons.phone, "Phone", "${venue["phone"]}"),
                  _buildContactRow(Icons.email, "Email", "${venue["email"]}"),
                  _buildContactRow(Icons.language, "Website", "${venue["website"]}"),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildContactRow(IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(
          icon,
          color: primaryColor,
          size: 18,
        ),
        SizedBox(width: spSm),
        Text(
          "$label:",
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: disabledBoldColor,
            fontSize: 13,
          ),
        ),
        SizedBox(width: spSm),
        Expanded(
          child: Text(
            value,
            style: TextStyle(
              color: primaryColor,
              fontSize: 13,
            ),
          ),
        ),
      ],
    );
  }

  void _showImageGallery() {
    // Implementation for showing image gallery
    si("Opening image gallery");
  }

  void _showAllReviews() {
    // Implementation for showing all reviews
    si("Opening all reviews");
  }

  void _bookVenue() {
    final selectedRoom = (venue["rooms"] as List)[selectedRoomIndex];
    ss("Booking ${selectedRoom["name"]} at ${venue["name"]}");
  }
}
