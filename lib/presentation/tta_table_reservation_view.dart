import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class TtaTableReservationView extends StatefulWidget {
  const TtaTableReservationView({super.key});

  @override
  State<TtaTableReservationView> createState() => _TtaTableReservationViewState();
}

class _TtaTableReservationViewState extends State<TtaTableReservationView> {
  String selectedDate = DateTime.now().toIso8601String();
  String selectedTime = "19:00";
  int partySize = 2;
  String seatingPreference = "Indoor";
  String occasion = "Casual Dining";
  String specialRequests = "";
  
  // Customer Information
  String customerName = "";
  String customerEmail = "";
  String customerPhone = "";
  
  bool loading = false;

  List<Map<String, dynamic>> timeSlots = [
    {"time": "17:00", "available": true},
    {"time": "17:30", "available": true},
    {"time": "18:00", "available": false},
    {"time": "18:30", "available": true},
    {"time": "19:00", "available": true},
    {"time": "19:30", "available": true},
    {"time": "20:00", "available": false},
    {"time": "20:30", "available": true},
    {"time": "21:00", "available": true},
    {"time": "21:30", "available": true},
    {"time": "22:00", "available": true},
  ];

  List<Map<String, dynamic>> seatingOptions = [
    {"label": "Indoor", "value": "Indoor"},
    {"label": "Outdoor", "value": "Outdoor"},
    {"label": "Bar Area", "value": "Bar Area"},
    {"label": "Private Room", "value": "Private Room"},
  ];

  List<Map<String, dynamic>> occasionTypes = [
    {"label": "Casual Dining", "value": "Casual Dining"},
    {"label": "Birthday", "value": "Birthday"},
    {"label": "Anniversary", "value": "Anniversary"},
    {"label": "Business Meeting", "value": "Business Meeting"},
    {"label": "Date Night", "value": "Date Night"},
    {"label": "Family Gathering", "value": "Family Gathering"},
    {"label": "Special Celebration", "value": "Special Celebration"},
  ];

  Map<String, dynamic> restaurant = {
    "name": "Mama's Italian Kitchen",
    "image": "https://picsum.photos/400/200?random=1&keyword=restaurant",
    "address": "123 Main Street, Downtown",
    "phone": "+1 234-567-8901",
    "rating": 4.8,
    "cuisine": "Italian",
  };

  void _makeReservation() async {
    if (customerName.isEmpty || customerEmail.isEmpty || customerPhone.isEmpty) {
      se("Please fill in all required fields");
      return;
    }

    loading = true;
    setState(() {});

    // Simulate API call
    await Future.delayed(Duration(seconds: 2));

    loading = false;
    setState(() {});

    ss("Reservation confirmed successfully!");
    
    // Show confirmation dialog
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Reservation Confirmed"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Your table has been reserved!"),
            SizedBox(height: spSm),
            Text("Confirmation #: RSV${DateTime.now().millisecondsSinceEpoch}"),
            Text("Date: ${DateTime.parse(selectedDate).dMMMy}"),
            Text("Time: $selectedTime"),
            Text("Party Size: $partySize guests"),
            Text("Seating: $seatingPreference"),
          ],
        ),
        actions: [
          QButton(
            label: "OK",
            size: bs.sm,
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Reserve Table"),
      ),
      body: loading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: EdgeInsets.all(spMd),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Restaurant Header
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusSm),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.vertical(top: Radius.circular(radiusSm)),
                          child: Image.network(
                            "${restaurant["image"]}",
                            height: 120,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(spSm),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${restaurant["name"]}",
                                style: TextStyle(
                                  fontSize: fsH6,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                              SizedBox(height: spXs),
                              Row(
                                children: [
                                  Icon(
                                    Icons.star,
                                    size: 16,
                                    color: warningColor,
                                  ),
                                  SizedBox(width: spXs),
                                  Text(
                                    "${restaurant["rating"]} • ${restaurant["cuisine"]}",
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
                                  Icon(
                                    Icons.location_on,
                                    size: 16,
                                    color: disabledBoldColor,
                                  ),
                                  SizedBox(width: spXs),
                                  Expanded(
                                    child: Text(
                                      "${restaurant["address"]}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: disabledBoldColor,
                                      ),
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

                  SizedBox(height: spMd),

                  // Reservation Details
                  Text(
                    "Reservation Details",
                    style: TextStyle(
                      fontSize: fsH5,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),

                  SizedBox(height: spMd),

                  // Date Selection
                  QDatePicker(
                    label: "Select Date",
                    value: DateTime.parse(selectedDate),
                    onChanged: (value) {
                      selectedDate = value.toIso8601String();
                      setState(() {});
                    },
                  ),

                  SizedBox(height: spSm),

                  // Time Selection
                  Text(
                    "Available Times",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spSm),
                  
                  QHorizontalScroll(
                    children: timeSlots.map((slot) {
                      bool isSelected = selectedTime == slot["time"];
                      bool isAvailable = slot["available"] as bool;
                      
                      return GestureDetector(
                        onTap: isAvailable ? () {
                          selectedTime = slot["time"];
                          setState(() {});
                        } : null,
                        child: Container(
                          margin: EdgeInsets.only(right: spSm),
                          padding: EdgeInsets.symmetric(horizontal: spMd, vertical: spSm),
                          decoration: BoxDecoration(
                            color: !isAvailable 
                                ? disabledColor
                                : isSelected 
                                    ? primaryColor 
                                    : Colors.white,
                            borderRadius: BorderRadius.circular(radiusSm),
                            border: Border.all(
                              color: !isAvailable 
                                  ? disabledOutlineBorderColor
                                  : isSelected 
                                      ? primaryColor 
                                      : disabledOutlineBorderColor,
                            ),
                          ),
                          child: Text(
                            "${slot["time"]}",
                            style: TextStyle(
                              color: !isAvailable 
                                  ? disabledBoldColor
                                  : isSelected 
                                      ? Colors.white 
                                      : primaryColor,
                              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),

                  SizedBox(height: spMd),

                  // Party Size
                  Text(
                    "Party Size",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spSm),
                  
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusSm),
                      border: Border.all(color: disabledOutlineBorderColor),
                    ),
                    child: Row(
                      children: [
                        IconButton(
                          icon: Icon(Icons.remove),
                          onPressed: partySize > 1 ? () {
                            partySize--;
                            setState(() {});
                          } : null,
                        ),
                        Expanded(
                          child: Text(
                            "$partySize guests",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: fsH6,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                        ),
                        IconButton(
                          icon: Icon(Icons.add),
                          onPressed: partySize < 12 ? () {
                            partySize++;
                            setState(() {});
                          } : null,
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: spSm),

                  // Seating Preference
                  QDropdownField(
                    label: "Seating Preference",
                    items: seatingOptions,
                    value: seatingPreference,
                    onChanged: (value, label) {
                      seatingPreference = value;
                      setState(() {});
                    },
                  ),

                  SizedBox(height: spSm),

                  // Occasion
                  QDropdownField(
                    label: "Occasion",
                    items: occasionTypes,
                    value: occasion,
                    onChanged: (value, label) {
                      occasion = value;
                      setState(() {});
                    },
                  ),

                  SizedBox(height: spSm),

                  // Special Requests
                  QMemoField(
                    label: "Special Requests",
                    value: specialRequests,
                    hint: "Any dietary restrictions, allergies, or special occasions?",
                    onChanged: (value) {
                      specialRequests = value;
                      setState(() {});
                    },
                  ),

                  SizedBox(height: spMd),

                  // Customer Information
                  Text(
                    "Contact Information",
                    style: TextStyle(
                      fontSize: fsH5,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),

                  SizedBox(height: spMd),

                  QTextField(
                    label: "Full Name *",
                    value: customerName,
                    hint: "Enter your full name",
                    validator: Validator.required,
                    onChanged: (value) {
                      customerName = value;
                      setState(() {});
                    },
                  ),

                  SizedBox(height: spSm),

                  QTextField(
                    label: "Email Address *",
                    value: customerEmail,
                    hint: "Enter your email address",
                    validator: Validator.email,
                    onChanged: (value) {
                      customerEmail = value;
                      setState(() {});
                    },
                  ),

                  SizedBox(height: spSm),

                  QTextField(
                    label: "Phone Number *",
                    value: customerPhone,
                    hint: "Enter your phone number",
                    validator: Validator.required,
                    onChanged: (value) {
                      customerPhone = value;
                      setState(() {});
                    },
                  ),

                  SizedBox(height: spMd),

                  // Reservation Summary
                  Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: Colors.grey[50],
                      borderRadius: BorderRadius.circular(radiusSm),
                      border: Border.all(color: disabledOutlineBorderColor),
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
                        _buildSummaryRow("Restaurant", "${restaurant["name"]}"),
                        _buildSummaryRow("Date", DateTime.parse(selectedDate).dMMMy),
                        _buildSummaryRow("Time", selectedTime),
                        _buildSummaryRow("Party Size", "$partySize guests"),
                        _buildSummaryRow("Seating", seatingPreference),
                        _buildSummaryRow("Occasion", occasion),
                        if (specialRequests.isNotEmpty)
                          _buildSummaryRow("Special Requests", specialRequests),
                      ],
                    ),
                  ),

                  SizedBox(height: spMd),

                  // Terms and Conditions
                  Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: warningColor.withAlpha(25),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.info_outline,
                              size: 16,
                              color: warningColor,
                            ),
                            SizedBox(width: spXs),
                            Text(
                              "Reservation Policy",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: warningColor,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "• Please arrive within 15 minutes of your reservation time\n"
                          "• Reservations are held for 15 minutes past the booking time\n"
                          "• Cancellations must be made at least 2 hours in advance\n"
                          "• Large parties (8+) may require a deposit",
                          style: TextStyle(
                            fontSize: 12,
                            color: warningColor,
                            height: 1.4,
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: spMd),

                  // Confirm Button
                  Container(
                    width: double.infinity,
                    child: QButton(
                      label: "Confirm Reservation",
                      size: bs.md,
                      onPressed: _makeReservation,
                    ),
                  ),

                  SizedBox(height: spMd),

                  // Contact Restaurant
                  Center(
                    child: Column(
                      children: [
                        Text(
                          "Need help with your reservation?",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                        SizedBox(height: spXs),
                        GestureDetector(
                          onTap: () {},
                          child: Text(
                            "Call ${restaurant["phone"]}",
                            style: TextStyle(
                              fontSize: 14,
                              color: primaryColor,
                              fontWeight: FontWeight.w600,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  Widget _buildSummaryRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: spXs),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 100,
            child: Text(
              label,
              style: TextStyle(
                fontSize: 12,
                color: disabledBoldColor,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                fontSize: 12,
                color: primaryColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
