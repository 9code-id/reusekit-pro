import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class TtaCheckInView extends StatefulWidget {
  const TtaCheckInView({super.key});

  @override
  State<TtaCheckInView> createState() => _TtaCheckInViewState();
}

class _TtaCheckInViewState extends State<TtaCheckInView> {
  String confirmationNumber = "";
  String lastName = "";
  bool isCheckedIn = false;
  int currentStep = 0;
  
  Map<String, dynamic> bookingDetails = {
    "confirmationNumber": "TTA7X9K2M",
    "flightNumber": "TT 4582",
    "airline": "TravelTech Airways",
    "route": {
      "from": {"code": "JFK", "city": "New York", "terminal": "Terminal 4"},
      "to": {"code": "LAX", "city": "Los Angeles", "terminal": "Terminal 6"},
    },
    "departure": "2024-06-20T08:30:00",
    "arrival": "2024-06-20T11:45:00",
    "aircraft": "Boeing 737-800",
    "class": "Economy",
  };

  List<Map<String, dynamic>> passengers = [
    {
      "title": "Mr.",
      "firstName": "John",
      "lastName": "Smith",
      "type": "Adult",
      "checkedIn": false,
      "seatNumber": "12A",
      "seatPreference": "window",
      "frequentFlyer": "TT123456789",
      "meal": "Standard",
      "specialRequests": [],
      "baggage": {
        "checkedBags": 1,
        "carryOn": 1,
        "personalItem": 1,
      },
    },
    {
      "title": "Ms.",
      "firstName": "Sarah",
      "lastName": "Smith",
      "type": "Adult",
      "checkedIn": false,
      "seatNumber": "12B",
      "seatPreference": "aisle",
      "frequentFlyer": "TT987654321",
      "meal": "Vegetarian",
      "specialRequests": ["Wheelchair assistance"],
      "baggage": {
        "checkedBags": 1,
        "carryOn": 1,
        "personalItem": 1,
      },
    },
  ];

  List<Map<String, dynamic>> availableSeats = [
    {"number": "11A", "type": "window", "available": true, "premium": false},
    {"number": "11B", "type": "middle", "available": true, "premium": false},
    {"number": "11C", "type": "aisle", "available": true, "premium": false},
    {"number": "12A", "type": "window", "available": false, "premium": false, "assigned": true},
    {"number": "12B", "type": "middle", "available": false, "premium": false, "assigned": true},
    {"number": "12C", "type": "aisle", "available": true, "premium": false},
    {"number": "13A", "type": "window", "available": true, "premium": true},
    {"number": "13B", "type": "middle", "available": true, "premium": true},
    {"number": "13C", "type": "aisle", "available": true, "premium": true},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Online Check-In"),
        actions: [
          IconButton(
            icon: Icon(Icons.help_outline),
            onPressed: () {
              si("Check-in help and FAQs");
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: spMd,
          children: [
            if (!isCheckedIn) ...[
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: primaryColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusMd),
                  border: Border.all(color: primaryColor.withAlpha(50)),
                ),
                child: Column(
                  children: [
                    Icon(
                      Icons.check_circle_outline,
                      size: 48,
                      color: primaryColor,
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "Online Check-In",
                      style: TextStyle(
                        fontSize: fsH4,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "Check in online and get your boarding pass on your mobile device",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),

              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spMd,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.search, color: primaryColor, size: 20),
                        SizedBox(width: spSm),
                        Text(
                          "Find Your Booking",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                    
                    QTextField(
                      label: "Confirmation Number",
                      value: confirmationNumber,
                      hint: "Enter your 6-character confirmation code",
                      onChanged: (value) {
                        confirmationNumber = value.toUpperCase();
                        setState(() {});
                      },
                    ),
                    
                    QTextField(
                      label: "Passenger Last Name",
                      value: lastName,
                      hint: "Enter passenger's last name",
                      onChanged: (value) {
                        lastName = value;
                        setState(() {});
                      },
                    ),
                    
                    Container(
                      width: double.infinity,
                      child: QButton(
                        label: "Find Booking",
                        size: bs.md,
                        icon: Icons.search,
                        onPressed: confirmationNumber.length >= 6 && lastName.isNotEmpty
                            ? () {
                                // Simulate finding booking
                                if (confirmationNumber == "TTA7X9K2M" && lastName.toLowerCase() == "smith") {
                                  isCheckedIn = false;
                                  currentStep = 1;
                                  setState(() {});
                                  ss("Booking found! Proceeding to check-in.");
                                } else {
                                  se("Booking not found. Please check your details.");
                                }
                              }
                            : null,
                      ),
                    ),
                  ],
                ),
              ),
            ],

            if (isCheckedIn || currentStep > 0) ...[
              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spMd,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.flight, color: primaryColor, size: 20),
                        SizedBox(width: spSm),
                        Text(
                          "Flight Details",
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
                        Text(
                          "${bookingDetails["flightNumber"]}",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(width: spSm),
                        Text(
                          "${bookingDetails["airline"]}",
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                    
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "From",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Text(
                                "${bookingDetails["route"]["from"]["code"]}",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                "${bookingDetails["route"]["from"]["city"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        
                        Icon(Icons.arrow_forward, color: primaryColor),
                        
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                "To",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Text(
                                "${bookingDetails["route"]["to"]["code"]}",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                "${bookingDetails["route"]["to"]["city"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Departure",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Text(
                                "${DateTime.parse(bookingDetails["departure"]).dMMMy}",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                "${TimeOfDay.fromDateTime(DateTime.parse(bookingDetails["departure"])).kkmm}",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                "Class",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Text(
                                "${bookingDetails["class"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                "${bookingDetails["aircraft"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              if (!isCheckedIn) ...[
                Container(
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: spMd,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.people, color: primaryColor, size: 20),
                          SizedBox(width: spSm),
                          Text(
                            "Passenger Check-In",
                            style: TextStyle(
                              fontSize: fsH6,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                        ],
                      ),
                      
                      ...passengers.asMap().entries.map((entry) {
                        int index = entry.key;
                        Map<String, dynamic> passenger = entry.value;
                        
                        return Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: passenger["checkedIn"] 
                                ? successColor.withAlpha(20) 
                                : primaryColor.withAlpha(10),
                            borderRadius: BorderRadius.circular(radiusSm),
                            border: Border.all(
                              color: passenger["checkedIn"] 
                                  ? successColor.withAlpha(50) 
                                  : primaryColor.withAlpha(30)
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            spacing: spSm,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    passenger["checkedIn"] ? Icons.check_circle : Icons.person,
                                    color: passenger["checkedIn"] ? successColor : primaryColor,
                                    size: 20,
                                  ),
                                  SizedBox(width: spSm),
                                  Expanded(
                                    child: Text(
                                      "${passenger["title"]} ${passenger["firstName"]} ${passenger["lastName"]}",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                  if (passenger["checkedIn"])
                                    Container(
                                      padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                      decoration: BoxDecoration(
                                        color: successColor,
                                        borderRadius: BorderRadius.circular(radiusXs),
                                      ),
                                      child: Text(
                                        "CHECKED IN",
                                        style: TextStyle(
                                          fontSize: 10,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                              
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      "Seat: ${passenger["seatNumber"]}",
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(
                                      "Meal: ${passenger["meal"]}",
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              
                              if (!passenger["checkedIn"])
                                Row(
                                  spacing: spSm,
                                  children: [
                                    Expanded(
                                      child: QButton(
                                        label: "Change Seat",
                                        size: bs.sm,
                                        icon: Icons.airline_seat_recline_normal,
                                        onPressed: () {
                                          _showSeatSelection(index);
                                        },
                                      ),
                                    ),
                                    Expanded(
                                      child: QButton(
                                        label: "Check In",
                                        size: bs.sm,
                                        icon: Icons.check_circle,
                                        onPressed: () {
                                          passenger["checkedIn"] = true;
                                          setState(() {});
                                          ss("${passenger["firstName"]} checked in successfully!");
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                            ],
                          ),
                        );
                      }).toList(),
                      
                      if (passengers.every((p) => p["checkedIn"]))
                        Container(
                          width: double.infinity,
                          child: QButton(
                            label: "Complete Check-In",
                            size: bs.md,
                            icon: Icons.done_all,
                            onPressed: () {
                              isCheckedIn = true;
                              setState(() {});
                              ss("Check-in completed! Boarding passes are ready.");
                            },
                          ),
                        ),
                    ],
                  ),
                ),
              ],

              if (isCheckedIn) ...[
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [successColor, successColor.withAlpha(180)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowMd],
                  ),
                  child: Column(
                    children: [
                      Icon(
                        Icons.check_circle,
                        size: 48,
                        color: Colors.white,
                      ),
                      SizedBox(height: spSm),
                      Text(
                        "Check-In Complete!",
                        style: TextStyle(
                          fontSize: fsH4,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "All passengers have been checked in successfully",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white70,
                        ),
                      ),
                    ],
                  ),
                ),

                Container(
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: infoColor.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusMd),
                    border: Border.all(color: infoColor.withAlpha(50)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: spSm,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.info, color: infoColor, size: 20),
                          SizedBox(width: spSm),
                          Text(
                            "Important Reminders",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: infoColor,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        "• Arrive at airport 2 hours before departure\n• Bring valid photo ID for all passengers\n• Check baggage drop-off requirements\n• Gate may change - check flight status",
                        style: TextStyle(
                          fontSize: 13,
                          color: disabledBoldColor,
                          height: 1.4,
                        ),
                      ),
                    ],
                  ),
                ),

                Row(
                  spacing: spSm,
                  children: [
                    Expanded(
                      child: QButton(
                        label: "Get Boarding Pass",
                        size: bs.md,
                        icon: Icons.airplane_ticket,
                        onPressed: () {
                          //navigateTo(TtaBoardingPassView());
                        },
                      ),
                    ),
                    Expanded(
                      child: QButton(
                        label: "Send to Email",
                        size: bs.md,
                        icon: Icons.email,
                        onPressed: () {
                          ss("Boarding passes sent to your email");
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ],
          ],
        ),
      ),
    );
  }

  void _showSeatSelection(int passengerIndex) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.8,
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey.withAlpha(50),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            Text(
              "Select Seat for ${passengers[passengerIndex]["firstName"]}",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              "Current seat: ${passengers[passengerIndex]["seatNumber"]}",
              style: TextStyle(
                fontSize: 14,
                color: disabledBoldColor,
              ),
            ),
            
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 1,
                  crossAxisSpacing: spSm,
                  mainAxisSpacing: spSm,
                ),
                itemCount: availableSeats.length,
                itemBuilder: (context, index) {
                  final seat = availableSeats[index];
                  final isAssigned = seat["assigned"] == true;
                  final isAvailable = seat["available"] == true;
                  final isPremium = seat["premium"] == true;
                  
                  Color seatColor = Colors.grey.withAlpha(30);
                  if (isAssigned) {
                    seatColor = primaryColor;
                  } else if (!isAvailable) {
                    seatColor = dangerColor.withAlpha(30);
                  } else if (isPremium) {
                    seatColor = warningColor.withAlpha(30);
                  } else if (isAvailable) {
                    seatColor = successColor.withAlpha(30);
                  }
                  
                  return GestureDetector(
                    onTap: isAvailable && !isAssigned ? () {
                      passengers[passengerIndex]["seatNumber"] = seat["number"];
                      setState(() {});
                      back();
                      ss("Seat ${seat["number"]} selected for ${passengers[passengerIndex]["firstName"]}");
                    } : null,
                    child: Container(
                      decoration: BoxDecoration(
                        color: seatColor,
                        borderRadius: BorderRadius.circular(radiusSm),
                        border: isAssigned ? Border.all(color: primaryColor, width: 2) : null,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.airline_seat_recline_normal,
                            color: isAssigned ? Colors.white : 
                                   !isAvailable ? dangerColor :
                                   isPremium ? warningColor : successColor,
                            size: 24,
                          ),
                          Text(
                            "${seat["number"]}",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: isAssigned ? Colors.white : Colors.black87,
                            ),
                          ),
                          Text(
                            "${seat["type"]}",
                            style: TextStyle(
                              fontSize: 10,
                              color: isAssigned ? Colors.white70 : disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            
            Row(
              children: [
                _buildSeatLegend(Colors.grey.withAlpha(30), "Unavailable"),
                SizedBox(width: spSm),
                _buildSeatLegend(successColor.withAlpha(30), "Available"),
                SizedBox(width: spSm),
                _buildSeatLegend(warningColor.withAlpha(30), "Premium"),
                SizedBox(width: spSm),
                _buildSeatLegend(primaryColor, "Your Seat"),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSeatLegend(Color color, String label) {
    return Expanded(
      child: Row(
        children: [
          Container(
            width: 12,
            height: 12,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          SizedBox(width: spXs),
          Expanded(
            child: Text(
              label,
              style: TextStyle(
                fontSize: 10,
                color: disabledBoldColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
