import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlBooking10View extends StatefulWidget {
  @override
  State<GrlBooking10View> createState() => _GrlBooking10ViewState();
}

class _GrlBooking10ViewState extends State<GrlBooking10View> {
  String selectedTour = "";
  String selectedDate = DateTime.now().toString();
  String selectedTime = "";
  String groupSize = "";
  String contactName = "";
  String contactEmail = "";
  String contactPhone = "";
  String specialRequests = "";
  List<String> selectedAddOns = [];

  List<Map<String, dynamic>> tours = [
    {
      "name": "Historic City Walking Tour",
      "duration": "3 hours",
      "difficulty": "Easy",
      "price": 45.0,
      "maxGroup": 15,
      "image": "https://picsum.photos/150/100?random=1&keyword=city",
      "description": "Explore historic landmarks and cultural sites",
      "highlights": ["Cathedral", "Old Town Square", "Museum District"]
    },
    {
      "name": "Mountain Hiking Adventure",
      "duration": "6 hours",
      "difficulty": "Moderate",
      "price": 85.0,
      "maxGroup": 8,
      "image": "https://picsum.photos/150/100?random=2&keyword=mountain",
      "description": "Scenic hiking trail with breathtaking mountain views",
      "highlights": ["Waterfalls", "Wildlife Spotting", "Summit Views"]
    },
    {
      "name": "Food & Culture Experience",
      "duration": "4 hours",
      "difficulty": "Easy",
      "price": 65.0,
      "maxGroup": 12,
      "image": "https://picsum.photos/150/100?random=3&keyword=food",
      "description": "Taste local cuisine and learn about culinary traditions",
      "highlights": ["Local Markets", "Street Food", "Cooking Demo"]
    },
    {
      "name": "Photography Safari",
      "duration": "8 hours",
      "difficulty": "Moderate",
      "price": 120.0,
      "maxGroup": 6,
      "image": "https://picsum.photos/150/100?random=4&keyword=safari",
      "description": "Capture stunning wildlife and landscape photography",
      "highlights": ["Wildlife Photography", "Sunset Shots", "Pro Tips"]
    },
  ];

  List<String> timeSlots = [
    "06:00", "07:00", "08:00", "09:00", "10:00", "11:00",
    "12:00", "13:00", "14:00", "15:00", "16:00"
  ];

  List<Map<String, dynamic>> groupSizes = [
    {"label": "1-2 people", "value": "1-2"},
    {"label": "3-5 people", "value": "3-5"},
    {"label": "6-10 people", "value": "6-10"},
    {"label": "11+ people", "value": "11+"},
  ];

  List<Map<String, dynamic>> addOns = [
    {
      "name": "Professional Photography",
      "price": 50.0,
      "description": "Professional photographer to capture your memories"
    },
    {
      "name": "Lunch Package",
      "price": 25.0,
      "description": "Traditional local lunch at authentic restaurant"
    },
    {
      "name": "Transportation",
      "price": 35.0,
      "description": "Round-trip transportation from hotel"
    },
    {
      "name": "Souvenir Package",
      "price": 20.0,
      "description": "Collection of local handicrafts and souvenirs"
    },
    {
      "name": "Audio Guide",
      "price": 15.0,
      "description": "Multi-language audio guide device"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Book Tour & Travel"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: spMd,
          children: [
            _buildTourSelection(),
            _buildTourDetails(),
            _buildContactInformation(),
            _buildAddOnServices(),
            _buildBookingSummary(),
            _buildBookButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildTourSelection() {
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
                Icons.landscape,
                color: primaryColor,
                size: 24,
              ),
              SizedBox(width: spXs),
              Text(
                "Select Tour Package",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          ...tours.map((tour) {
            final isSelected = selectedTour == tour["name"];
            return GestureDetector(
              onTap: () {
                selectedTour = tour["name"];
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
                            "${tour["image"]}",
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
                                  Expanded(
                                    child: Text(
                                      "${tour["name"]}",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: primaryColor,
                                      ),
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
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: spXs,
                                      vertical: 2,
                                    ),
                                    decoration: BoxDecoration(
                                      color: _getDifficultyColor(tour["difficulty"]).withAlpha(20),
                                      borderRadius: BorderRadius.circular(radiusXs),
                                    ),
                                    child: Text(
                                      "${tour["difficulty"]}",
                                      style: TextStyle(
                                        fontSize: 10,
                                        color: _getDifficultyColor(tour["difficulty"]),
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: spXs),
                                  Text(
                                    "${tour["duration"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                  Spacer(),
                                  Text(
                                    "\$${(tour["price"] as double).toStringAsFixed(0)}",
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
                      "${tour["description"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "Highlights:",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                    Wrap(
                      spacing: spXs,
                      children: (tour["highlights"] as List<String>)
                          .map((highlight) => Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: spXs,
                                  vertical: 2,
                                ),
                                decoration: BoxDecoration(
                                  color: infoColor.withAlpha(20),
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: Text(
                                  highlight,
                                  style: TextStyle(
                                    fontSize: 9,
                                    color: infoColor,
                                  ),
                                ),
                              ))
                          .toList(),
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.group,
                          size: 14,
                          color: disabledBoldColor,
                        ),
                        SizedBox(width: spXs),
                        Text(
                          "Max ${tour["maxGroup"]} people",
                          style: TextStyle(
                            fontSize: 11,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
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

  Color _getDifficultyColor(String difficulty) {
    switch (difficulty.toLowerCase()) {
      case 'easy':
        return successColor;
      case 'moderate':
        return warningColor;
      case 'hard':
        return dangerColor;
      default:
        return primaryColor;
    }
  }

  Widget _buildTourDetails() {
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
                "Tour Details",
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
                  label: "Tour Date",
                  value: DateTime.parse(selectedDate),
                  onChanged: (value) {
                    selectedDate = value.toString();
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QDropdownField(
                  label: "Start Time",
                  items: timeSlots.map((time) => {
                    "label": time,
                    "value": time,
                  }).toList(),
                  value: selectedTime,
                  onChanged: (value, label) {
                    selectedTime = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
          QDropdownField(
            label: "Group Size",
            items: groupSizes,
            value: groupSize,
            onChanged: (value, label) {
              groupSize = value;
              setState(() {});
            },
          ),
          QMemoField(
            label: "Special Requests",
            value: specialRequests,
            hint: "Any special requirements, dietary restrictions, or preferences",
            onChanged: (value) {
              specialRequests = value;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  Widget _buildContactInformation() {
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
                "Contact Information",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          QTextField(
            label: "Lead Traveler Name",
            value: contactName,
            hint: "Primary contact for this booking",
            onChanged: (value) {
              contactName = value;
              setState(() {});
            },
          ),
          QTextField(
            label: "Email Address",
            value: contactEmail,
            hint: "Email for booking confirmation and updates",
            onChanged: (value) {
              contactEmail = value;
              setState(() {});
            },
          ),
          QTextField(
            label: "Phone Number",
            value: contactPhone,
            hint: "Contact number for emergencies",
            onChanged: (value) {
              contactPhone = value;
              setState(() {});
            },
          ),
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
            "Enhance your tour experience with these optional services",
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

  Widget _buildBookingSummary() {
    if (selectedTour.isEmpty) return Container();
    
    final selectedTourData = tours.firstWhere(
      (tour) => tour["name"] == selectedTour,
    );
    
    double totalPrice = selectedTourData["price"] as double;
    
    for (String addOnName in selectedAddOns) {
      final addOn = addOns.firstWhere(
        (a) => a["name"] == addOnName,
      );
      totalPrice += addOn["price"] as double;
    }
    
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
          _buildSummaryRow("Tour Package", selectedTour),
          _buildSummaryRow("Date", DateTime.parse(selectedDate).dMMMy),
          _buildSummaryRow("Start Time", selectedTime),
          _buildSummaryRow("Duration", "${selectedTourData["duration"]}"),
          _buildSummaryRow("Group Size", groupSize),
          if (selectedAddOns.isNotEmpty) ...[
            SizedBox(height: spXs),
            Text(
              "Additional Services:",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: primaryColor,
              ),
            ),
            ...selectedAddOns.map((addOnName) {
              final addOn = addOns.firstWhere(
                (a) => a["name"] == addOnName,
              );
              return Padding(
                padding: EdgeInsets.only(left: spSm),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "• $addOnName",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "+\$${(addOn["price"] as double).toStringAsFixed(0)}",
                      style: TextStyle(
                        fontSize: 12,
                        color: successColor,
                      ),
                    ),
                  ],
                ),
              );
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
          SizedBox(height: spXs),
          Container(
            padding: EdgeInsets.all(spXs),
            decoration: BoxDecoration(
              color: infoColor.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusSm),
              border: Border.all(color: infoColor.withAlpha(50)),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.info_outline,
                  color: infoColor,
                  size: 16,
                ),
                SizedBox(width: spXs),
                Expanded(
                  child: Text(
                    "Confirmation details and meeting instructions will be sent via email",
                    style: TextStyle(
                      fontSize: 11,
                      color: infoColor,
                    ),
                  ),
                ),
              ],
            ),
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

  Widget _buildBookButton() {
    return Container(
      width: double.infinity,
      child: QButton(
        label: "Book Tour",
        size: bs.md,
        onPressed: () {
          ss("Tour booked successfully!");
        },
      ),
    );
  }
}
