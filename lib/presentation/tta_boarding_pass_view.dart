import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class TtaBoardingPassView extends StatefulWidget {
  const TtaBoardingPassView({super.key});

  @override
  State<TtaBoardingPassView> createState() => _TtaBoardingPassViewState();
}

class _TtaBoardingPassViewState extends State<TtaBoardingPassView> {
  Map<String, dynamic> boardingPass = {
    "confirmationNumber": "TTA7X9K2M",
    "sequenceNumber": "001",
    "checkInStatus": "checked_in",
    "checkInTime": "2024-06-20T06:30:00",
    "boardingGroup": "Group A",
    "priority": "Priority Boarding",
  };

  Map<String, dynamic> passenger = {
    "title": "Mr.",
    "firstName": "John",
    "lastName": "Smith",
    "frequentFlyer": "TT123456789",
    "tier": "Gold",
  };

  Map<String, dynamic> flight = {
    "flightNumber": "TT 4582",
    "airline": "TravelTech Airways",
    "airlineCode": "TT",
    "date": "2024-06-20",
    "departure": {
      "airport": "John F. Kennedy International Airport",
      "code": "JFK",
      "city": "New York",
      "terminal": "Terminal 4",
      "gate": "A12",
      "time": "08:30",
    },
    "arrival": {
      "airport": "Los Angeles International Airport",
      "code": "LAX",
      "city": "Los Angeles",
      "terminal": "Terminal 6",
      "gate": "B8",
      "time": "11:45",
    },
    "seat": "12A",
    "class": "Economy",
    "aircraft": "Boeing 737-800",
    "duration": "6h 15m",
  };

  Map<String, dynamic> securityInfo = {
    "tsa": "TSA PreCheck",
    "boardingTime": "07:30",
    "gateCloses": "08:15",
    "baggage": {
      "claim": "Carousel 3",
      "tags": ["TT001234567", "TT001234568"],
    },
  };

  bool showQRCode = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Boarding Pass"),
        actions: [
          IconButton(
            icon: Icon(Icons.download),
            onPressed: () {
              ss("Boarding pass saved to device");
            },
          ),
          IconButton(
            icon: Icon(Icons.share),
            onPressed: () {
              si("Boarding pass shared");
            },
          ),
          IconButton(
            icon: Icon(Icons.wallet),
            onPressed: () {
              ss("Boarding pass added to Apple Wallet");
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
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowLg],
              ),
              child: Column(
                children: [
                  // Boarding Pass Header
                  Container(
                    padding: EdgeInsets.all(spMd),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [primaryColor, primaryColor.withAlpha(180)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(radiusMd),
                        topRight: Radius.circular(radiusMd),
                      ),
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              "${flight["airlineCode"]}",
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(width: spSm),
                            Text(
                              "${flight["airline"]}",
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.white70,
                              ),
                            ),
                            Spacer(),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                              decoration: BoxDecoration(
                                color: Colors.white.withAlpha(40),
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Text(
                                "${boardingPass["boardingGroup"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: spMd),
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Passenger",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.white70,
                                    ),
                                  ),
                                  Text(
                                    "${passenger["firstName"]} ${passenger["lastName"]}",
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            if (passenger["tier"] != null)
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                                decoration: BoxDecoration(
                                  color: Colors.amber.withAlpha(40),
                                  borderRadius: BorderRadius.circular(radiusSm),
                                  border: Border.all(color: Colors.amber),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(Icons.star, size: 12, color: Colors.amber),
                                    SizedBox(width: spXs),
                                    Text(
                                      "${passenger["tier"]}",
                                      style: TextStyle(
                                        fontSize: 10,
                                        color: Colors.amber,
                                        fontWeight: FontWeight.bold,
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

                  // Flight Route
                  Container(
                    padding: EdgeInsets.all(spMd),
                    child: Column(
                      spacing: spMd,
                      children: [
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
                                    "${flight["departure"]["code"]}",
                                    style: TextStyle(
                                      fontSize: 32,
                                      fontWeight: FontWeight.bold,
                                      color: primaryColor,
                                    ),
                                  ),
                                  Text(
                                    "${flight["departure"]["city"]}",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Text(
                                    "${flight["departure"]["terminal"]}",
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
                                  Icons.flight_takeoff,
                                  color: primaryColor,
                                  size: 24,
                                ),
                                SizedBox(height: spXs),
                                Container(
                                  width: 40,
                                  height: 2,
                                  color: primaryColor.withAlpha(100),
                                ),
                                SizedBox(height: spXs),
                                Text(
                                  "${flight["duration"]}",
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
                                    "To",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                  Text(
                                    "${flight["arrival"]["code"]}",
                                    style: TextStyle(
                                      fontSize: 32,
                                      fontWeight: FontWeight.bold,
                                      color: primaryColor,
                                    ),
                                  ),
                                  Text(
                                    "${flight["arrival"]["city"]}",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Text(
                                    "${flight["arrival"]["terminal"]}",
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

                        Divider(color: Colors.grey.withAlpha(30)),

                        // Flight Details
                        Row(
                          children: [
                            Expanded(
                              child: _buildInfoItem("Flight", "${flight["flightNumber"]}"),
                            ),
                            Expanded(
                              child: _buildInfoItem("Date", "${DateTime.parse(flight["date"]).dMMMy}"),
                            ),
                            Expanded(
                              child: _buildInfoItem("Seat", "${flight["seat"]}"),
                            ),
                            Expanded(
                              child: _buildInfoItem("Class", "${flight["class"]}"),
                            ),
                          ],
                        ),

                        Row(
                          children: [
                            Expanded(
                              child: _buildInfoItem("Departure", "${flight["departure"]["time"]}"),
                            ),
                            Expanded(
                              child: _buildInfoItem("Gate", "${flight["departure"]["gate"]}"),
                            ),
                            Expanded(
                              child: _buildInfoItem("Boarding", "${securityInfo["boardingTime"]}"),
                            ),
                            Expanded(
                              child: _buildInfoItem("Aircraft", "${flight["aircraft"]}"),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  // Perforated line
                  Row(
                    children: List.generate(20, (index) => Expanded(
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 2),
                        height: 1,
                        color: Colors.grey.withAlpha(50),
                      ),
                    )),
                  ),

                  // QR Code Section
                  Container(
                    padding: EdgeInsets.all(spMd),
                    child: Column(
                      spacing: spMd,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      showQRCode = !showQRCode;
                                      setState(() {});
                                    },
                                    child: Container(
                                      width: 120,
                                      height: 120,
                                      decoration: BoxDecoration(
                                        color: showQRCode ? Colors.black : primaryColor.withAlpha(20),
                                        borderRadius: BorderRadius.circular(radiusSm),
                                        border: Border.all(color: primaryColor.withAlpha(50)),
                                      ),
                                      child: showQRCode
                                          ? Icon(
                                              Icons.qr_code,
                                              size: 80,
                                              color: Colors.white,
                                            )
                                          : Icon(
                                              Icons.qr_code_scanner,
                                              size: 40,
                                              color: primaryColor,
                                            ),
                                    ),
                                  ),
                                  SizedBox(height: spSm),
                                  Text(
                                    showQRCode ? "Tap to hide" : "Tap to show QR",
                                    style: TextStyle(
                                      fontSize: 11,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            
                            Expanded(
                              flex: 2,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                spacing: spSm,
                                children: [
                                  _buildInfoItem("Confirmation", "${boardingPass["confirmationNumber"]}"),
                                  _buildInfoItem("Sequence", "${boardingPass["sequenceNumber"]}"),
                                  if (passenger["frequentFlyer"] != null)
                                    _buildInfoItem("Frequent Flyer", "${passenger["frequentFlyer"]}"),
                                  if (securityInfo["tsa"] != null)
                                    _buildInfoItem("Security", "${securityInfo["tsa"]}"),
                                ],
                              ),
                            ),
                          ],
                        ),

                        if (boardingPass["checkInStatus"] == "checked_in")
                          Container(
                            width: double.infinity,
                            padding: EdgeInsets.all(spSm),
                            decoration: BoxDecoration(
                              color: successColor.withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusSm),
                              border: Border.all(color: successColor.withAlpha(50)),
                            ),
                            child: Row(
                              children: [
                                Icon(Icons.check_circle, color: successColor, size: 16),
                                SizedBox(width: spSm),
                                Expanded(
                                  child: Text(
                                    "Checked in at ${TimeOfDay.fromDateTime(DateTime.parse(boardingPass["checkInTime"])).kkmm}",
                                    style: TextStyle(
                                      fontSize: 13,
                                      color: successColor,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
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
                      Icon(Icons.schedule, color: primaryColor, size: 20),
                      SizedBox(width: spSm),
                      Text(
                        "Timeline",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  
                  _buildTimelineItem(
                    time: "${securityInfo["boardingTime"]}",
                    title: "Boarding Begins",
                    subtitle: "${boardingPass["boardingGroup"]} • ${boardingPass["priority"]}",
                    icon: Icons.airline_seat_recline_normal,
                    isActive: true,
                  ),
                  
                  _buildTimelineItem(
                    time: "${securityInfo["gateCloses"]}",
                    title: "Gate Closes",
                    subtitle: "Final boarding call",
                    icon: Icons.door_front_door,
                    isActive: false,
                  ),
                  
                  _buildTimelineItem(
                    time: "${flight["departure"]["time"]}",
                    title: "Departure",
                    subtitle: "Gate ${flight["departure"]["gate"]}",
                    icon: Icons.flight_takeoff,
                    isActive: false,
                  ),
                  
                  _buildTimelineItem(
                    time: "${flight["arrival"]["time"]}",
                    title: "Arrival",
                    subtitle: "${flight["arrival"]["terminal"]} • Baggage ${securityInfo["baggage"]["claim"]}",
                    icon: Icons.flight_land,
                    isActive: false,
                  ),
                ],
              ),
            ),

            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: warningColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusMd),
                border: Border.all(color: warningColor.withAlpha(50)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spSm,
                children: [
                  Row(
                    children: [
                      Icon(Icons.info, color: warningColor, size: 20),
                      SizedBox(width: spSm),
                      Text(
                        "Travel Reminders",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: warningColor,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    "• Arrive at airport 2 hours before departure\n• Have valid photo ID ready\n• Check current security wait times\n• Download airline app for updates",
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
                    label: "Flight Status",
                    size: bs.md,
                    icon: Icons.flight,
                    onPressed: () {
                      //navigateTo(TtaFlightStatusView());
                    },
                  ),
                ),
                Expanded(
                  child: QButton(
                    label: "Check-in",
                    size: bs.md,
                    icon: Icons.check_circle,
                    onPressed: () {
                      //navigateTo(TtaCheckInView());
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

  Widget _buildInfoItem(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 10,
            color: disabledBoldColor,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Widget _buildTimelineItem({
    required String time,
    required String title,
    required String subtitle,
    required IconData icon,
    required bool isActive,
  }) {
    return Row(
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: isActive ? primaryColor : disabledColor,
            shape: BoxShape.circle,
          ),
          child: Icon(
            icon,
            color: Colors.white,
            size: 20,
          ),
        ),
        SizedBox(width: spSm),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    time,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: isActive ? primaryColor : disabledBoldColor,
                    ),
                  ),
                  SizedBox(width: spSm),
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: isActive ? Colors.black87 : disabledBoldColor,
                    ),
                  ),
                ],
              ),
              Text(
                subtitle,
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
