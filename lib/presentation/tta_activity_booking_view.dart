import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class TtaActivityBookingView extends StatefulWidget {
  const TtaActivityBookingView({super.key});

  @override
  State<TtaActivityBookingView> createState() => _TtaActivityBookingViewState();
}

class _TtaActivityBookingViewState extends State<TtaActivityBookingView> {
  int selectedTimeSlot = 0;
  int adults = 2;
  int children = 0;
  String selectedDate = "2024-01-15";
  String specialRequests = "";
  String contactName = "";
  String contactEmail = "";
  String contactPhone = "";
  String selectedPackage = "standard";
  bool isPrivateBooking = false;
  final formKey = GlobalKey<FormState>();

  List<Map<String, dynamic>> timeSlots = [
    {
      "time": "09:00 AM",
      "availability": "Available",
      "price": 45,
      "duration": "3 hours",
      "slots": 8
    },
    {
      "time": "01:00 PM",
      "availability": "Limited",
      "price": 45,
      "duration": "3 hours",
      "slots": 3
    },
    {
      "time": "04:00 PM",
      "availability": "Available",
      "price": 50,
      "duration": "3 hours",
      "slots": 12
    },
    {
      "time": "07:00 PM",
      "availability": "Fully Booked",
      "price": 55,
      "duration": "3 hours",
      "slots": 0
    },
  ];

  List<Map<String, dynamic>> packages = [
    {
      "id": "standard",
      "name": "Standard Package",
      "description": "Basic activity experience with essential amenities",
      "inclusions": ["Activity equipment", "Safety gear", "Basic refreshments"],
      "price": 0
    },
    {
      "id": "premium",
      "name": "Premium Package",
      "description": "Enhanced experience with premium amenities and extras",
      "inclusions": ["Activity equipment", "Safety gear", "Premium refreshments", "Professional photos", "Lunch included"],
      "price": 25
    },
    {
      "id": "vip",
      "name": "VIP Package",
      "description": "Luxury experience with exclusive perks and personalized service",
      "inclusions": ["Activity equipment", "Safety gear", "Gourmet refreshments", "Professional photos", "Lunch included", "Private guide", "Transport included"],
      "price": 50
    },
  ];

  Map<String, dynamic> activityData = {
    "name": "Snorkeling Adventure at Coral Bay",
    "location": "Coral Bay Marine Reserve",
    "image": "https://picsum.photos/400/200?random=801",
    "rating": 4.8,
    "reviews": 342,
    "duration": "3 hours",
    "difficulty": "Beginner",
    "groupSize": "Max 12 people",
    "minAge": 8,
    "basePrice": 45,
    "cancellation": "Free cancellation up to 24 hours before"
  };

  void _selectTimeSlot(int index) {
    if (timeSlots[index]["slots"] > 0) {
      setState(() {
        selectedTimeSlot = index;
      });
    }
  }

  void _incrementCounter(String type) {
    setState(() {
      if (type == "adults" && adults < 10) {
        adults++;
      } else if (type == "children" && children < 8) {
        children++;
      }
    });
  }

  void _decrementCounter(String type) {
    setState(() {
      if (type == "adults" && adults > 1) {
        adults--;
      } else if (type == "children" && children > 0) {
        children--;
      }
    });
  }

  double _calculateTotal() {
    final selectedSlot = timeSlots[selectedTimeSlot];
    final basePrice = selectedSlot["price"] as int;
    final packagePrice = packages.firstWhere((p) => p["id"] == selectedPackage)["price"] as int;
    final privateBookingFee = isPrivateBooking ? 100 : 0;
    
    return ((basePrice + packagePrice) * adults).toDouble() + 
           ((basePrice + packagePrice) * 0.7 * children).toDouble() + 
           privateBookingFee.toDouble();
  }

  void _proceedToPayment() {
    if (formKey.currentState!.validate()) {
      // Navigate to confirmation
      ss("Booking details saved successfully!");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Book Activity"),
        actions: [
          IconButton(
            icon: Icon(Icons.help_outline),
            onPressed: () {
              // Show help dialog
            },
          ),
        ],
      ),
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Activity Info Card
              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(radiusSm),
                      child: Image.network(
                        "${activityData["image"]}",
                        height: 120,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "${activityData["name"]}",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Row(
                      children: [
                        Icon(Icons.location_on, size: 16, color: disabledBoldColor),
                        SizedBox(width: spXs),
                        Expanded(
                          child: Text(
                            "${activityData["location"]}",
                            style: TextStyle(
                              color: disabledBoldColor,
                              fontSize: 14,
                            ),
                          ),
                        ),
                        Icon(Icons.star, size: 16, color: warningColor),
                        SizedBox(width: spXs),
                        Text(
                          "${activityData["rating"]} (${activityData["reviews"]})",
                          style: TextStyle(
                            color: disabledBoldColor,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              SizedBox(height: spLg),

              // Date Selection
              Text(
                "Select Date",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              SizedBox(height: spSm),
              QDatePicker(
                label: "Activity Date",
                value: DateTime.parse(selectedDate),
                onChanged: (value) {
                  selectedDate = value.toString().split(' ')[0];
                  setState(() {});
                },
              ),

              SizedBox(height: spLg),

              // Time Slot Selection
              Text(
                "Select Time Slot",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              SizedBox(height: spSm),
              Column(
                children: List.generate(timeSlots.length, (index) {
                  final slot = timeSlots[index];
                  final isAvailable = (slot["slots"] as int) > 0;
                  final isSelected = selectedTimeSlot == index;

                  return Container(
                    margin: EdgeInsets.only(bottom: spSm),
                    child: GestureDetector(
                      onTap: () => _selectTimeSlot(index),
                      child: Container(
                        padding: EdgeInsets.all(spMd),
                        decoration: BoxDecoration(
                          color: isSelected ? primaryColor.withAlpha(20) : Colors.white,
                          borderRadius: BorderRadius.circular(radiusSm),
                          border: Border.all(
                            color: isSelected ? primaryColor : 
                                   isAvailable ? disabledOutlineBorderColor : disabledColor,
                            width: isSelected ? 2 : 1,
                          ),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        "${slot["time"]}",
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                          color: isAvailable ? primaryColor : disabledColor,
                                        ),
                                      ),
                                      SizedBox(width: spSm),
                                      Container(
                                        padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                                        decoration: BoxDecoration(
                                          color: isAvailable ? 
                                                 (slot["availability"] == "Limited" ? warningColor : successColor) : 
                                                 disabledColor,
                                          borderRadius: BorderRadius.circular(radiusXs),
                                        ),
                                        child: Text(
                                          "${slot["availability"]}",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: spXs),
                                  Text(
                                    "Duration: ${slot["duration"]} • ${slot["slots"]} slots left",
                                    style: TextStyle(
                                      color: disabledBoldColor,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Text(
                              "\$${slot["price"]}",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: isAvailable ? primaryColor : disabledColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }),
              ),

              SizedBox(height: spLg),

              // Guest Selection
              Text(
                "Number of Guests",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              SizedBox(height: spSm),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(spMd),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(radiusSm),
                        border: Border.all(color: disabledOutlineBorderColor),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Adults",
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: primaryColor,
                                ),
                              ),
                              Text(
                                "Age 12+",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              GestureDetector(
                                onTap: () => _decrementCounter("adults"),
                                child: Container(
                                  width: 32,
                                  height: 32,
                                  decoration: BoxDecoration(
                                    color: adults > 1 ? primaryColor : disabledColor,
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                  child: Icon(
                                    Icons.remove,
                                    color: Colors.white,
                                    size: 18,
                                  ),
                                ),
                              ),
                              Container(
                                width: 40,
                                alignment: Alignment.center,
                                child: Text(
                                  "$adults",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: primaryColor,
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () => _incrementCounter("adults"),
                                child: Container(
                                  width: 32,
                                  height: 32,
                                  decoration: BoxDecoration(
                                    color: adults < 10 ? primaryColor : disabledColor,
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                  child: Icon(
                                    Icons.add,
                                    color: Colors.white,
                                    size: 18,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(spMd),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(radiusSm),
                        border: Border.all(color: disabledOutlineBorderColor),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Children",
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: primaryColor,
                                ),
                              ),
                              Text(
                                "Age 2-11",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              GestureDetector(
                                onTap: () => _decrementCounter("children"),
                                child: Container(
                                  width: 32,
                                  height: 32,
                                  decoration: BoxDecoration(
                                    color: children > 0 ? primaryColor : disabledColor,
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                  child: Icon(
                                    Icons.remove,
                                    color: Colors.white,
                                    size: 18,
                                  ),
                                ),
                              ),
                              Container(
                                width: 40,
                                alignment: Alignment.center,
                                child: Text(
                                  "$children",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: primaryColor,
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () => _incrementCounter("children"),
                                child: Container(
                                  width: 32,
                                  height: 32,
                                  decoration: BoxDecoration(
                                    color: children < 8 ? primaryColor : disabledColor,
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                  child: Icon(
                                    Icons.add,
                                    color: Colors.white,
                                    size: 18,
                                  ),
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

              SizedBox(height: spLg),

              // Package Selection
              Text(
                "Choose Package",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              SizedBox(height: spSm),
              Column(
                children: List.generate(packages.length, (index) {
                  final package = packages[index];
                  final isSelected = selectedPackage == package["id"];

                  return Container(
                    margin: EdgeInsets.only(bottom: spSm),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedPackage = package["id"];
                        });
                      },
                      child: Container(
                        padding: EdgeInsets.all(spMd),
                        decoration: BoxDecoration(
                          color: isSelected ? primaryColor.withAlpha(20) : Colors.white,
                          borderRadius: BorderRadius.circular(radiusSm),
                          border: Border.all(
                            color: isSelected ? primaryColor : disabledOutlineBorderColor,
                            width: isSelected ? 2 : 1,
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "${package["name"]}",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                                Text(
                                  package["price"] == 0 ? "Included" : "+\$${package["price"]}",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: package["price"] == 0 ? successColor : primaryColor,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: spXs),
                            Text(
                              "${package["description"]}",
                              style: TextStyle(
                                color: disabledBoldColor,
                                fontSize: 14,
                              ),
                            ),
                            SizedBox(height: spSm),
                            Wrap(
                              spacing: spXs,
                              runSpacing: spXs,
                              children: (package["inclusions"] as List).map((inclusion) {
                                return Container(
                                  padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                                  decoration: BoxDecoration(
                                    color: successColor.withAlpha(20),
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                  child: Text(
                                    "✓ $inclusion",
                                    style: TextStyle(
                                      color: successColor,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }),
              ),

              SizedBox(height: spLg),

              // Private Booking Option
              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusSm),
                  border: Border.all(color: disabledOutlineBorderColor),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: QSwitch(
                        items: [
                          {
                            "label": "Private Booking (+\$100)",
                            "value": true,
                            "checked": isPrivateBooking,
                          }
                        ],
                        value: [
                          if (isPrivateBooking)
                            {
                              "label": "Private Booking (+\$100)",
                              "value": true,
                              "checked": true
                            }
                        ],
                        onChanged: (values, ids) {
                          setState(() {
                            isPrivateBooking = values.isNotEmpty;
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: spLg),

              // Contact Information
              Text(
                "Contact Information",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              SizedBox(height: spSm),
              QTextField(
                label: "Full Name",
                value: contactName,
                validator: Validator.required,
                onChanged: (value) {
                  contactName = value;
                  setState(() {});
                },
              ),
              SizedBox(height: spSm),
              QTextField(
                label: "Email Address",
                value: contactEmail,
                validator: Validator.email,
                onChanged: (value) {
                  contactEmail = value;
                  setState(() {});
                },
              ),
              SizedBox(height: spSm),
              QTextField(
                label: "Phone Number",
                value: contactPhone,
                validator: Validator.required,
                onChanged: (value) {
                  contactPhone = value;
                  setState(() {});
                },
              ),

              SizedBox(height: spLg),

              // Special Requests
              Text(
                "Special Requests (Optional)",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              SizedBox(height: spSm),
              QMemoField(
                label: "Special Requests",
                value: specialRequests,
                hint: "Any dietary restrictions, accessibility needs, or special occasions...",
                onChanged: (value) {
                  specialRequests = value;
                  setState(() {});
                },
              ),

              SizedBox(height: spLg),

              // Pricing Summary
              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: primaryColor.withAlpha(10),
                  borderRadius: BorderRadius.circular(radiusSm),
                  border: Border.all(color: primaryColor.withAlpha(30)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Booking Summary",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spSm),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Adults × $adults"),
                        Text("\$${((timeSlots[selectedTimeSlot]["price"] as int) + (packages.firstWhere((p) => p["id"] == selectedPackage)["price"] as int)) * adults}"),
                      ],
                    ),
                    if (children > 0) ...[
                      SizedBox(height: spXs),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Children × $children"),
                          Text("\$${(((timeSlots[selectedTimeSlot]["price"] as int) + (packages.firstWhere((p) => p["id"] == selectedPackage)["price"] as int)) * 0.7 * children).toInt()}"),
                        ],
                      ),
                    ],
                    if (isPrivateBooking) ...[
                      SizedBox(height: spXs),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Private Booking Fee"),
                          Text("\$100"),
                        ],
                      ),
                    ],
                    SizedBox(height: spSm),
                    Divider(),
                    SizedBox(height: spSm),
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
                          "\$${_calculateTotal().toInt()}",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              SizedBox(height: spXl),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(spMd),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [shadowSm],
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Total Amount",
                    style: TextStyle(
                      color: disabledBoldColor,
                      fontSize: 12,
                    ),
                  ),
                  Text(
                    "\$${_calculateTotal().toInt()}",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: spMd),
            Expanded(
              flex: 2,
              child: QButton(
                label: "Proceed to Payment",
                size: bs.md,
                onPressed: _proceedToPayment,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
