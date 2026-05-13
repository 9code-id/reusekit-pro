import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlReservation5View extends StatefulWidget {
  @override
  State<GrlReservation5View> createState() => _GrlReservation5ViewState();
}

class _GrlReservation5ViewState extends State<GrlReservation5View> {
  String selectedDate = DateTime.now().toString().split(' ')[0];
  String selectedTimeSlot = "";
  String selectedLocation = "";
  String guestCount = "1";
  String specialRequests = "";
  bool isVipPackage = false;
  
  List<Map<String, dynamic>> availableSlots = [
    {"time": "11:00 AM", "available": true, "price": 120},
    {"time": "12:00 PM", "available": true, "price": 130},
    {"time": "1:00 PM", "available": false, "price": 140},
    {"time": "2:00 PM", "available": true, "price": 140},
    {"time": "6:00 PM", "available": true, "price": 160},
    {"time": "7:00 PM", "available": true, "price": 170},
    {"time": "8:00 PM", "available": false, "price": 180},
    {"time": "9:00 PM", "available": true, "price": 180}
  ];

  List<Map<String, dynamic>> locations = [
    {
      "name": "Downtown Location",
      "address": "123 Main Street, Downtown",
      "image": "https://picsum.photos/400/200?random=1&keyword=restaurant",
      "rating": 4.8,
      "features": ["Outdoor Seating", "Live Music", "Parking"]
    },
    {
      "name": "Waterfront View",
      "address": "456 Harbor Boulevard, Waterfront",
      "image": "https://picsum.photos/400/200?random=2&keyword=waterfront",
      "rating": 4.9,
      "features": ["Ocean View", "Private Dining", "Valet"]
    },
    {
      "name": "Garden Terrace",
      "address": "789 Garden Way, Uptown",
      "image": "https://picsum.photos/400/200?random=3&keyword=garden",
      "rating": 4.7,
      "features": ["Garden View", "Rooftop", "Bar"]
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Make Reservation"),
        actions: [
          IconButton(
            icon: Icon(Icons.favorite_border),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildLocationSelection(),
            SizedBox(height: spMd),
            _buildDateSelection(),
            SizedBox(height: spMd),
            _buildTimeSlotSelection(),
            SizedBox(height: spMd),
            _buildGuestDetails(),
            SizedBox(height: spMd),
            _buildVipPackage(),
            SizedBox(height: spMd),
            _buildSpecialRequests(),
            SizedBox(height: spMd),
            _buildSummaryCard(),
            SizedBox(height: spMd),
            _buildReservationButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildLocationSelection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Select Location",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        SizedBox(height: spSm),
        Container(
          height: 280,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: locations.length,
            itemBuilder: (context, index) {
              final location = locations[index];
              bool isSelected = selectedLocation == location["name"];
              
              return GestureDetector(
                onTap: () {
                  selectedLocation = location["name"];
                  setState(() {});
                },
                child: Container(
                  width: 300,
                  margin: EdgeInsets.only(right: spSm),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusLg),
                    border: Border.all(
                      color: isSelected ? primaryColor : disabledOutlineBorderColor,
                      width: isSelected ? 2 : 1,
                    ),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.vertical(top: Radius.circular(radiusLg)),
                        child: Image.network(
                          "${location["image"]}",
                          height: 140,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(spSm),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    "${location["name"]}",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: primaryColor,
                                    ),
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
                                      Icon(Icons.star, color: Colors.white, size: 12),
                                      SizedBox(width: 2),
                                      Text(
                                        "${location["rating"]}",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: spXs),
                            Text(
                              "${location["address"]}",
                              style: TextStyle(
                                fontSize: 14,
                                color: disabledBoldColor,
                              ),
                            ),
                            SizedBox(height: spXs),
                            Wrap(
                              spacing: spXs,
                              children: (location["features"] as List).map((feature) {
                                return Container(
                                  padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: primaryColor.withAlpha(20),
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                  child: Text(
                                    "$feature",
                                    style: TextStyle(
                                      fontSize: 12,
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
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildDateSelection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
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
          label: "Reservation Date",
          value: DateTime.parse(selectedDate),
          onChanged: (value) {
            selectedDate = value.toString().split(' ')[0];
            setState(() {});
          },
        ),
      ],
    );
  }

  Widget _buildTimeSlotSelection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Available Time Slots",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        SizedBox(height: spSm),
        ResponsiveGridView(
          padding: EdgeInsets.zero,
          minItemWidth: 120,
          children: availableSlots.map((slot) {
            bool isSelected = selectedTimeSlot == slot["time"];
            bool isAvailable = slot["available"];
            
            return GestureDetector(
              onTap: isAvailable ? () {
                selectedTimeSlot = slot["time"];
                setState(() {});
              } : null,
              child: Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: !isAvailable 
                      ? disabledColor.withAlpha(50)
                      : isSelected 
                          ? primaryColor 
                          : Colors.white,
                  borderRadius: BorderRadius.circular(radiusSm),
                  border: Border.all(
                    color: !isAvailable 
                        ? disabledColor
                        : isSelected 
                            ? primaryColor 
                            : disabledOutlineBorderColor,
                  ),
                ),
                child: Column(
                  children: [
                    Text(
                      "${slot["time"]}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: !isAvailable 
                            ? disabledBoldColor
                            : isSelected 
                                ? Colors.white 
                                : primaryColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "\$${slot["price"]}",
                      style: TextStyle(
                        fontSize: 14,
                        color: !isAvailable 
                            ? disabledBoldColor
                            : isSelected 
                                ? Colors.white 
                                : disabledBoldColor,
                      ),
                    ),
                    if (!isAvailable) ...[
                      SizedBox(height: spXs),
                      Text(
                        "Full",
                        style: TextStyle(
                          fontSize: 12,
                          color: dangerColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildGuestDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Party Details",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        SizedBox(height: spSm),
        QNumberField(
          label: "Number of Guests",
          value: guestCount,
          onChanged: (value) {
            guestCount = value;
            setState(() {});
          },
        ),
      ],
    );
  }

  Widget _buildVipPackage() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "VIP Experience",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        SizedBox(height: spSm),
        Container(
          padding: EdgeInsets.all(spSm),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(radiusLg),
            border: Border.all(
              color: isVipPackage ? primaryColor : disabledOutlineBorderColor,
            ),
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
                          "VIP Package",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "Premium seating, complimentary appetizer, priority service",
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "+\$50 per person",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: warningColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Transform.scale(
                    scale: 0.8,
                    child: Switch(
                      value: isVipPackage,
                      onChanged: (value) {
                        isVipPackage = value;
                        setState(() {});
                      },
                      activeColor: primaryColor,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSpecialRequests() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Special Requests",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        SizedBox(height: spSm),
        QMemoField(
          label: "Any special requests or dietary restrictions?",
          value: specialRequests,
          hint: "e.g., Birthday celebration, wheelchair accessibility, food allergies...",
          onChanged: (value) {
            specialRequests = value;
            setState(() {});
          },
        ),
      ],
    );
  }

  Widget _buildSummaryCard() {
    if (selectedLocation.isEmpty || selectedTimeSlot.isEmpty) {
      return Container();
    }

    final selectedSlot = availableSlots.firstWhere(
      (slot) => slot["time"] == selectedTimeSlot,
    );
    
    int guests = int.tryParse(guestCount) ?? 1;
    int basePrice = (selectedSlot["price"] as int) * guests;
    int vipPrice = isVipPackage ? 50 * guests : 0;
    int totalPrice = basePrice + vipPrice;

    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowMd],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Reservation Summary",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          
          _buildSummaryRow("Location", selectedLocation),
          _buildSummaryRow("Date", DateTime.parse(selectedDate).dMMMy),
          _buildSummaryRow("Time", selectedTimeSlot),
          _buildSummaryRow("Guests", "$guests ${guests == 1 ? 'person' : 'people'}"),
          
          if (isVipPackage) _buildSummaryRow("VIP Package", "Included"),
          
          Divider(height: spMd * 2),
          
          _buildSummaryRow("Base Price", "\$${basePrice.toString()}"),
          if (vipPrice > 0) _buildSummaryRow("VIP Add-on", "\$${vipPrice.toString()}"),
          
          SizedBox(height: spSm),
          
          Row(
            children: [
              Text(
                "Total Amount",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Spacer(),
              Text(
                "\$${totalPrice.toString()}",
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
    );
  }

  Widget _buildSummaryRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.only(bottom: spXs),
      child: Row(
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 14,
              color: disabledBoldColor,
            ),
          ),
          Spacer(),
          Text(
            value,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: primaryColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReservationButton() {
    bool canReserve = selectedLocation.isNotEmpty && 
                     selectedTimeSlot.isNotEmpty && 
                     guestCount.isNotEmpty;

    return Container(
      width: double.infinity,
      child: QButton(
        label: "Confirm Reservation",
        size: bs.md,
        onPressed: canReserve ? () {
          _confirmReservation();
        } : null,
      ),
    );
  }

  void _confirmReservation() {
    showLoading();
    
    // Simulate API call
    Future.delayed(Duration(seconds: 2), () {
      hideLoading();
      ss("Reservation confirmed successfully!");
      
      // Show confirmation dialog
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text("Reservation Confirmed"),
          content: Text("Your table has been reserved. You'll receive a confirmation email shortly."),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                back();
              },
              child: Text("OK"),
            ),
          ],
        ),
      );
    });
  }
}
