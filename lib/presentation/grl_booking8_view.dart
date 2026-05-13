import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlBooking8View extends StatefulWidget {
  @override
  State<GrlBooking8View> createState() => _GrlBooking8ViewState();
}

class _GrlBooking8ViewState extends State<GrlBooking8View> {
  String selectedProperty = "";
  String checkInDate = DateTime.now().toString();
  String checkOutDate = DateTime.now().add(Duration(days: 1)).toString();
  String guestCount = "2";
  String roomType = "";
  String guestName = "";
  String guestEmail = "";
  String guestPhone = "";
  String specialRequests = "";
  List<String> selectedAddOns = [];

  List<Map<String, dynamic>> properties = [
    {
      "name": "Luxury Ocean Resort",
      "type": "Resort",
      "rating": 5.0,
      "price": 350.0,
      "location": "Maldives",
      "image": "https://picsum.photos/300/200?random=1&keyword=resort",
      "amenities": ["Pool", "Spa", "Beach Access", "Restaurant"],
      "description": "Exclusive beachfront resort with world-class amenities"
    },
    {
      "name": "Mountain View Lodge",
      "type": "Lodge",
      "rating": 4.5,
      "price": 180.0,
      "location": "Swiss Alps",
      "image": "https://picsum.photos/300/200?random=2&keyword=mountain",
      "amenities": ["Fireplace", "Hiking", "Restaurant", "WiFi"],
      "description": "Cozy mountain lodge with stunning alpine views"
    },
    {
      "name": "City Center Hotel",
      "type": "Hotel",
      "rating": 4.2,
      "price": 120.0,
      "location": "New York",
      "image": "https://picsum.photos/300/200?random=3&keyword=hotel",
      "amenities": ["Gym", "Business Center", "Room Service", "WiFi"],
      "description": "Modern hotel in the heart of the city"
    },
  ];

  List<Map<String, dynamic>> roomTypes = [
    {"label": "Standard Room", "value": "standard", "extra": 0.0},
    {"label": "Deluxe Room", "value": "deluxe", "extra": 50.0},
    {"label": "Suite", "value": "suite", "extra": 120.0},
    {"label": "Presidential Suite", "value": "presidential", "extra": 300.0},
  ];

  List<Map<String, dynamic>> guestOptions = [
    {"label": "1 Guest", "value": "1"},
    {"label": "2 Guests", "value": "2"},
    {"label": "3 Guests", "value": "3"},
    {"label": "4 Guests", "value": "4"},
    {"label": "5+ Guests", "value": "5+"},
  ];

  List<Map<String, dynamic>> addOns = [
    {
      "name": "Airport Transfer",
      "price": 80.0,
      "description": "Round-trip airport transportation"
    },
    {
      "name": "Breakfast Package",
      "price": 35.0,
      "description": "Daily continental breakfast for all guests"
    },
    {
      "name": "Spa Package",
      "price": 150.0,
      "description": "Relaxing spa treatment package"
    },
    {
      "name": "Tour Guide",
      "price": 200.0,
      "description": "Professional local tour guide for one day"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Book Accommodation"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: spMd,
          children: [
            _buildPropertySelection(),
            _buildBookingDetails(),
            _buildRoomSelection(),
            _buildAddOnServices(),
            _buildGuestInformation(),
            _buildBookingSummary(),
            _buildBookButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildPropertySelection() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Row(
            children: [
              Icon(
                Icons.hotel,
                color: primaryColor,
                size: 24,
              ),
              SizedBox(width: spXs),
              Text(
                "Select Property",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          ...properties.map((property) {
            final isSelected = selectedProperty == property["name"];
            return GestureDetector(
              onTap: () {
                selectedProperty = property["name"];
                setState(() {});
              },
              child: Container(
                padding: EdgeInsets.all(spSm),
                margin: EdgeInsets.only(bottom: spSm),
                decoration: BoxDecoration(
                  color: isSelected ? primaryColor.withAlpha(20) : Colors.grey[50],
                  borderRadius: BorderRadius.circular(radiusSm),
                  border: Border.all(
                    color: isSelected ? primaryColor : Colors.grey[300]!,
                    width: isSelected ? 2 : 1,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spXs,
                  children: [
                    Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(radiusSm),
                          child: Image.network(
                            "${property["image"]}",
                            width: 100,
                            height: 70,
                            fit: BoxFit.cover,
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            spacing: spXs,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "${property["name"]}",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: primaryColor,
                                    ),
                                  ),
                                  if (isSelected)
                                    Icon(
                                      Icons.check_circle,
                                      color: primaryColor,
                                      size: 20,
                                    ),
                                ],
                              ),
                              Row(
                                children: [
                                  Text(
                                    "${property["type"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                  SizedBox(width: spSm),
                                  Icon(
                                    Icons.location_on,
                                    size: 12,
                                    color: disabledBoldColor,
                                  ),
                                  Text(
                                    "${property["location"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Icon(
                                    Icons.star,
                                    size: 16,
                                    color: warningColor,
                                  ),
                                  SizedBox(width: spXs),
                                  Text(
                                    "${property["rating"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      color: warningColor,
                                    ),
                                  ),
                                  Spacer(),
                                  Text(
                                    "\$${(property["price"] as double).toStringAsFixed(0)}/night",
                                    style: TextStyle(
                                      fontSize: 14,
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
                    Text(
                      "${property["description"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Wrap(
                      spacing: spXs,
                      children: (property["amenities"] as List<String>)
                          .take(4)
                          .map((amenity) => Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: spXs,
                                  vertical: 2,
                                ),
                                decoration: BoxDecoration(
                                  color: primaryColor.withAlpha(20),
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: Text(
                                  amenity,
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: primaryColor,
                                  ),
                                ),
                              ))
                          .toList(),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildBookingDetails() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Row(
            children: [
              Icon(
                Icons.calendar_today,
                color: primaryColor,
                size: 24,
              ),
              SizedBox(width: spXs),
              Text(
                "Booking Details",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: QDatePicker(
                  label: "Check-in Date",
                  value: DateTime.parse(checkInDate),
                  onChanged: (value) {
                    checkInDate = value.toString();
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QDatePicker(
                  label: "Check-out Date",
                  value: DateTime.parse(checkOutDate),
                  onChanged: (value) {
                    checkOutDate = value.toString();
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
          QDropdownField(
            label: "Number of Guests",
            items: guestOptions,
            value: guestCount,
            onChanged: (value, label) {
              guestCount = value;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  Widget _buildRoomSelection() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Row(
            children: [
              Icon(
                Icons.bed,
                color: primaryColor,
                size: 24,
              ),
              SizedBox(width: spXs),
              Text(
                "Room Selection",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          ...roomTypes.map((room) {
            final isSelected = roomType == room["value"];
            return GestureDetector(
              onTap: () {
                roomType = room["value"];
                setState(() {});
              },
              child: Container(
                padding: EdgeInsets.all(spSm),
                margin: EdgeInsets.only(bottom: spXs),
                decoration: BoxDecoration(
                  color: isSelected ? primaryColor.withAlpha(20) : Colors.grey[50],
                  borderRadius: BorderRadius.circular(radiusSm),
                  border: Border.all(
                    color: isSelected ? primaryColor : Colors.grey[300]!,
                  ),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 20,
                      height: 20,
                      decoration: BoxDecoration(
                        color: isSelected ? primaryColor : Colors.transparent,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: isSelected ? primaryColor : Colors.grey[400]!,
                        ),
                      ),
                      child: isSelected
                          ? Icon(
                              Icons.check,
                              color: Colors.white,
                              size: 14,
                            )
                          : null,
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: Text(
                        "${room["label"]}",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: primaryColor,
                        ),
                      ),
                    ),
                    if ((room["extra"] as double) > 0)
                      Text(
                        "+\$${(room["extra"] as double).toStringAsFixed(0)}/night",
                        style: TextStyle(
                          fontSize: 12,
                          color: successColor,
                        ),
                      ),
                  ],
                ),
              ),
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildAddOnServices() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Row(
            children: [
              Icon(
                Icons.add_circle_outline,
                color: primaryColor,
                size: 24,
              ),
              SizedBox(width: spXs),
              Text(
                "Additional Services",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          Text(
            "Enhance your stay with these optional services",
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),
          ...addOns.map((addOn) {
            final isSelected = selectedAddOns.contains(addOn["name"]);
            return GestureDetector(
              onTap: () {
                if (isSelected) {
                  selectedAddOns.remove(addOn["name"]);
                } else {
                  selectedAddOns.add(addOn["name"]);
                }
                setState(() {});
              },
              child: Container(
                padding: EdgeInsets.all(spSm),
                margin: EdgeInsets.only(bottom: spXs),
                decoration: BoxDecoration(
                  color: isSelected ? primaryColor.withAlpha(20) : Colors.grey[50],
                  borderRadius: BorderRadius.circular(radiusSm),
                  border: Border.all(
                    color: isSelected ? primaryColor : Colors.grey[300]!,
                  ),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 20,
                      height: 20,
                      decoration: BoxDecoration(
                        color: isSelected ? primaryColor : Colors.transparent,
                        borderRadius: BorderRadius.circular(radiusXs),
                        border: Border.all(
                          color: isSelected ? primaryColor : Colors.grey[400]!,
                        ),
                      ),
                      child: isSelected
                          ? Icon(
                              Icons.check,
                              color: Colors.white,
                              size: 14,
                            )
                          : null,
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: spXs,
                        children: [
                          Text(
                            "${addOn["name"]}",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: primaryColor,
                            ),
                          ),
                          Text(
                            "${addOn["description"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      "+\$${(addOn["price"] as double).toStringAsFixed(0)}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: successColor,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildGuestInformation() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Row(
            children: [
              Icon(
                Icons.person,
                color: primaryColor,
                size: 24,
              ),
              SizedBox(width: spXs),
              Text(
                "Guest Information",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          QTextField(
            label: "Guest Name",
            value: guestName,
            hint: "Primary guest name",
            onChanged: (value) {
              guestName = value;
              setState(() {});
            },
          ),
          QTextField(
            label: "Email Address",
            value: guestEmail,
            hint: "Email for booking confirmation",
            onChanged: (value) {
              guestEmail = value;
              setState(() {});
            },
          ),
          QTextField(
            label: "Phone Number",
            value: guestPhone,
            hint: "Contact number",
            onChanged: (value) {
              guestPhone = value;
              setState(() {});
            },
          ),
          QMemoField(
            label: "Special Requests",
            value: specialRequests,
            hint: "Any special requirements or preferences",
            onChanged: (value) {
              specialRequests = value;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  Widget _buildBookingSummary() {
    if (selectedProperty.isEmpty) return Container();
    
    final selectedPropertyData = properties.firstWhere(
      (property) => property["name"] == selectedProperty,
    );
    
    final checkIn = DateTime.parse(checkInDate);
    final checkOut = DateTime.parse(checkOutDate);
    final nights = checkOut.difference(checkIn).inDays;
    
    double basePrice = (selectedPropertyData["price"] as double) * nights;
    double roomExtra = 0.0;
    
    if (roomType.isNotEmpty) {
      final selectedRoom = roomTypes.firstWhere(
        (room) => room["value"] == roomType,
      );
      roomExtra = (selectedRoom["extra"] as double) * nights;
    }
    
    double addOnTotal = 0.0;
    for (String addOnName in selectedAddOns) {
      final addOn = addOns.firstWhere((a) => a["name"] == addOnName);
      addOnTotal += addOn["price"] as double;
    }
    
    double totalPrice = basePrice + roomExtra + addOnTotal;
    
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: primaryColor.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusLg),
        border: Border.all(color: primaryColor.withAlpha(30)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Row(
            children: [
              Icon(
                Icons.receipt_long,
                color: primaryColor,
                size: 24,
              ),
              SizedBox(width: spXs),
              Text(
                "Booking Summary",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          _buildSummaryRow("Property", selectedProperty),
          _buildSummaryRow("Check-in", checkIn.dMMMy),
          _buildSummaryRow("Check-out", checkOut.dMMMy),
          _buildSummaryRow("Nights", "$nights nights"),
          _buildSummaryRow("Guests", guestCount),
          if (roomType.isNotEmpty) 
            _buildSummaryRow("Room Type", roomTypes.firstWhere((r) => r["value"] == roomType)["label"]),
          Divider(color: primaryColor.withAlpha(50)),
          _buildPriceRow("Base Price", basePrice),
          if (roomExtra > 0)
            _buildPriceRow("Room Upgrade", roomExtra),
          if (selectedAddOns.isNotEmpty) ...[
            ...selectedAddOns.map((addOnName) {
              final addOn = addOns.firstWhere((a) => a["name"] == addOnName);
              return _buildPriceRow(addOnName, addOn["price"] as double);
            }).toList(),
          ],
          Divider(color: primaryColor.withAlpha(50)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Total Amount",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Text(
                "\$${totalPrice.toStringAsFixed(2)}",
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
    );
  }

  Widget _buildSummaryRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "$label:",
          style: TextStyle(
            fontSize: 14,
            color: disabledBoldColor,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: primaryColor,
          ),
        ),
      ],
    );
  }

  Widget _buildPriceRow(String label, double price) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: disabledBoldColor,
          ),
        ),
        Text(
          "\$${price.toStringAsFixed(2)}",
          style: TextStyle(
            fontSize: 12,
            color: successColor,
          ),
        ),
      ],
    );
  }

  Widget _buildBookButton() {
    return Container(
      width: double.infinity,
      child: QButton(
        label: "Book Accommodation",
        size: bs.md,
        onPressed: () {
          ss("Accommodation booked successfully!");
        },
      ),
    );
  }
}
