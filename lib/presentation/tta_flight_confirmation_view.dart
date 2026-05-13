import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class TtaFlightConfirmationView extends StatefulWidget {
  const TtaFlightConfirmationView({super.key});

  @override
  State<TtaFlightConfirmationView> createState() => _TtaFlightConfirmationViewState();
}

class _TtaFlightConfirmationViewState extends State<TtaFlightConfirmationView> {
  Map<String, dynamic> bookingDetails = {
    "confirmationNumber": "TTA7X9K2M",
    "bookingReference": "FLYTTA123456",
    "status": "confirmed",
    "bookingDate": "2024-06-15T14:30:00",
    "totalAmount": 1250.00,
    "currency": "USD",
    "passengerCount": 2,
    "flightType": "roundtrip",
  };

  Map<String, dynamic> outboundFlight = {
    "flightNumber": "TT 4582",
    "airline": "TravelTech Airways",
    "airlineCode": "TT",
    "departure": {
      "airport": "John F. Kennedy International Airport",
      "code": "JFK",
      "city": "New York",
      "country": "United States",
      "terminal": "Terminal 4",
      "gate": "A12",
      "dateTime": "2024-06-20T08:30:00",
    },
    "arrival": {
      "airport": "Los Angeles International Airport",
      "code": "LAX",
      "city": "Los Angeles",
      "country": "United States",
      "terminal": "Terminal 6",
      "gate": "B8",
      "dateTime": "2024-06-20T11:45:00",
    },
    "duration": "6h 15m",
    "aircraft": "Boeing 737-800",
    "class": "Economy",
    "status": "On Time",
  };

  Map<String, dynamic> returnFlight = {
    "flightNumber": "TT 4583",
    "airline": "TravelTech Airways",
    "airlineCode": "TT",
    "departure": {
      "airport": "Los Angeles International Airport",
      "code": "LAX",
      "city": "Los Angeles",
      "country": "United States",
      "terminal": "Terminal 6",
      "gate": "B12",
      "dateTime": "2024-06-27T16:20:00",
    },
    "arrival": {
      "airport": "John F. Kennedy International Airport",
      "code": "JFK",
      "city": "New York",
      "country": "United States",
      "terminal": "Terminal 4",
      "gate": "A15",
      "dateTime": "2024-06-28T00:35:00",
    },
    "duration": "5h 15m",
    "aircraft": "Boeing 737-800",
    "class": "Economy",
    "status": "Scheduled",
  };

  List<Map<String, dynamic>> passengers = [
    {
      "title": "Mr.",
      "firstName": "John",
      "lastName": "Smith",
      "type": "Adult",
      "seatNumber": "12A",
      "frequentFlyer": "TT123456789",
      "meal": "Standard",
      "baggage": "1 Checked Bag",
    },
    {
      "title": "Ms.",
      "firstName": "Sarah",
      "lastName": "Smith",
      "type": "Adult", 
      "seatNumber": "12B",
      "frequentFlyer": "TT987654321",
      "meal": "Vegetarian",
      "baggage": "1 Checked Bag",
    },
  ];

  Map<String, dynamic> contactInfo = {
    "email": "john.smith@email.com",
    "phone": "+1 (555) 123-4567",
    "emergencyContact": {
      "name": "Michael Smith",
      "phone": "+1 (555) 987-6543",
      "relationship": "Brother",
    },
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Flight Confirmation"),
        actions: [
          IconButton(
            icon: Icon(Icons.download),
            onPressed: () {
              ss("Booking confirmation downloaded");
            },
          ),
          IconButton(
            icon: Icon(Icons.share),
            onPressed: () {
              si("Booking details shared");
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
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [primaryColor, primaryColor.withAlpha(180)],
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
                    "Booking Confirmed!",
                    style: TextStyle(
                      fontSize: fsH4,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: spXs),
                  Text(
                    "Your flight has been successfully booked",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white70,
                    ),
                  ),
                  SizedBox(height: spMd),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: spMd, vertical: spSm),
                    decoration: BoxDecoration(
                      color: Colors.white.withAlpha(40),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Column(
                      children: [
                        Text(
                          "Confirmation Number",
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.white70,
                          ),
                        ),
                        Text(
                          "${bookingDetails["confirmationNumber"]}",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            letterSpacing: 2,
                          ),
                        ),
                      ],
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
                      Icon(Icons.receipt, color: primaryColor, size: 20),
                      SizedBox(width: spSm),
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
                  
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Booking Reference",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                            Text(
                              "${bookingDetails["bookingReference"]}",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
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
                              "Booking Date",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                            Text(
                              "${DateTime.parse(bookingDetails["bookingDate"]).dMMMy}",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
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
                              "Total Amount",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                            Text(
                              "\$${(bookingDetails["totalAmount"] as double).currency}",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
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
                              "Passengers",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                            Text(
                              "${bookingDetails["passengerCount"]} Adult(s)",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
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

            _buildFlightCard("Outbound Flight", outboundFlight, true),
            
            if (bookingDetails["flightType"] == "roundtrip")
              _buildFlightCard("Return Flight", returnFlight, false),

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
                        "Passenger Details",
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
                        color: primaryColor.withAlpha(10),
                        borderRadius: BorderRadius.circular(radiusSm),
                        border: Border.all(color: primaryColor.withAlpha(30)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: spSm,
                        children: [
                          Row(
                            children: [
                              Text(
                                "Passenger ${index + 1}",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                              Spacer(),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                decoration: BoxDecoration(
                                  color: primaryColor,
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: Text(
                                  "${passenger["type"]}",
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          
                          Text(
                            "${passenger["title"]} ${passenger["firstName"]} ${passenger["lastName"]}",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Seat",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                    Text(
                                      "${passenger["seatNumber"]}",
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
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
                                      "Meal",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                    Text(
                                      "${passenger["meal"]}",
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
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
                                      "Baggage",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                    Text(
                                      "${passenger["baggage"]}",
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  }).toList(),
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
                      Icon(Icons.contact_phone, color: primaryColor, size: 20),
                      SizedBox(width: spSm),
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
                  
                  Row(
                    children: [
                      Icon(Icons.email, color: disabledBoldColor, size: 16),
                      SizedBox(width: spSm),
                      Text(
                        "${contactInfo["email"]}",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  
                  Row(
                    children: [
                      Icon(Icons.phone, color: disabledBoldColor, size: 16),
                      SizedBox(width: spSm),
                      Text(
                        "${contactInfo["phone"]}",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  
                  Divider(color: Colors.grey.withAlpha(30)),
                  
                  Text(
                    "Emergency Contact",
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: disabledBoldColor,
                    ),
                  ),
                  
                  Text(
                    "${contactInfo["emergencyContact"]["name"]} (${contactInfo["emergencyContact"]["relationship"]})",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  
                  Text(
                    "${contactInfo["emergencyContact"]["phone"]}",
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
                        "Important Information",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: infoColor,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    "• Check-in opens 24 hours before departure\n• Arrive at airport 2 hours before domestic flights\n• Valid ID required for all passengers\n• Flight times are in local time",
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
                    label: "View Boarding Pass",
                    size: bs.md,
                    icon: Icons.airplane_ticket,
                    onPressed: () {
                      //navigateTo(TtaBoardingPassView());
                    },
                  ),
                ),
                Expanded(
                  child: QButton(
                    label: "Manage Booking",
                    size: bs.md,
                    icon: Icons.edit,
                    onPressed: () {
                      si("Opening booking management");
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFlightCard(String title, Map<String, dynamic> flight, bool isOutbound) {
    final departure = flight["departure"];
    final arrival = flight["arrival"];
    
    return Container(
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
              Icon(
                isOutbound ? Icons.flight_takeoff : Icons.flight_land,
                color: primaryColor,
                size: 20,
              ),
              SizedBox(width: spSm),
              Text(
                title,
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Spacer(),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                decoration: BoxDecoration(
                  color: successColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "${flight["status"]}",
                  style: TextStyle(
                    fontSize: 10,
                    color: successColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          
          Row(
            children: [
              Text(
                "${flight["flightNumber"]}",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(width: spSm),
              Text(
                "${flight["airline"]}",
                style: TextStyle(
                  fontSize: 14,
                  color: disabledBoldColor,
                ),
              ),
              Spacer(),
              Text(
                "${flight["duration"]}",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: primaryColor,
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
                      "${DateTime.parse(departure["dateTime"]).dMMMy}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      "${TimeOfDay.fromDateTime(DateTime.parse(departure["dateTime"])).kkmm}",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "${departure["code"]} - ${departure["city"]}",
                      style: TextStyle(
                        fontSize: 13,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "${departure["terminal"]} • Gate ${departure["gate"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              
              Column(
                children: [
                  Icon(
                    Icons.arrow_forward,
                    color: primaryColor,
                    size: 20,
                  ),
                  SizedBox(height: spXs),
                  Text(
                    "${flight["aircraft"]}",
                    style: TextStyle(
                      fontSize: 10,
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ),
              
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      "Arrival",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "${DateTime.parse(arrival["dateTime"]).dMMMy}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      "${TimeOfDay.fromDateTime(DateTime.parse(arrival["dateTime"])).kkmm}",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "${arrival["code"]} - ${arrival["city"]}",
                      style: TextStyle(
                        fontSize: 13,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "${arrival["terminal"]} • Gate ${arrival["gate"]}",
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
    );
  }
}
