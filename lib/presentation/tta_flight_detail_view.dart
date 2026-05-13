import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class TtaFlightDetailView extends StatefulWidget {
  const TtaFlightDetailView({super.key});

  @override
  State<TtaFlightDetailView> createState() => _TtaFlightDetailViewState();
}

class _TtaFlightDetailViewState extends State<TtaFlightDetailView> {
  int selectedTabIndex = 0;

  Map<String, dynamic> flightDetails = {
    "id": 1,
    "airline": "Emirates",
    "flightNumber": "EK 201",
    "logo": "https://picsum.photos/120/60?random=1&keyword=emirates",
    "departureTime": "08:30",
    "arrivalTime": "14:45",
    "departureDate": "June 25, 2024",
    "arrivalDate": "June 25, 2024",
    "departureAirport": "JFK",
    "arrivalAirport": "CDG",
    "departureCity": "New York",
    "arrivalCity": "Paris",
    "departureTerminal": "Terminal 4",
    "arrivalTerminal": "Terminal 2E",
    "duration": "7h 15m",
    "distance": "3,625 miles",
    "stops": 0,
    "stopDetails": "Direct Flight",
    "class": "Economy",
    "price": 542.00,
    "originalPrice": 680.00,
    "discount": 20,
    "aircraft": "Boeing 777-300ER",
    "seatConfiguration": "3-4-3",
    "baggage": {
      "carry": "1 x 7kg carry-on",
      "checked": "2 x 23kg checked bags",
    },
    "amenities": {
      "wifi": true,
      "entertainment": true,
      "meals": true,
      "power": true,
      "blanket": true,
      "pillow": true,
    },
    "rating": 4.8,
    "reviews": 2543,
    "seatAvailability": 12,
    "cancellationPolicy": "Free cancellation up to 24 hours before departure",
    "changePolicy": "Changes allowed with \$75 fee",
  };

  List<Map<String, dynamic>> fareBreakdown = [
    {
      "description": "Base Fare",
      "amount": 420.00,
      "type": "base",
    },
    {
      "description": "Taxes & Fees",
      "amount": 122.00,
      "type": "fees",
    },
    {
      "description": "Discount (20% OFF)",
      "amount": -138.00,
      "type": "discount",
    },
  ];

  List<Map<String, dynamic>> seatMap = [
    {"row": "A", "seats": ["1A", "1B", "1C", "1D", "1E", "1F"], "type": "first"},
    {"row": "B", "seats": ["2A", "2B", "2C", "2D", "2E", "2F"], "type": "business"},
    {"row": "C", "seats": ["8A", "8B", "8C", "8D", "8E", "8F"], "type": "economy"},
    {"row": "D", "seats": ["9A", "9B", "9C", "9D", "9E", "9F"], "type": "economy"},
    {"row": "E", "seats": ["10A", "10B", "10C", "10D", "10E", "10F"], "type": "economy"},
  ];

  List<Map<String, dynamic>> reviews = [
    {
      "name": "Sarah Johnson",
      "rating": 5,
      "date": "May 15, 2024",
      "comment": "Excellent service and comfortable seats. The entertainment system was great and the food was delicious.",
      "helpful": 24,
    },
    {
      "name": "Michael Chen",
      "rating": 4,
      "date": "May 10, 2024",
      "comment": "Good flight overall. On-time departure and arrival. Cabin crew was very professional.",
      "helpful": 18,
    },
    {
      "name": "Emma Davis",
      "rating": 5,
      "date": "May 8, 2024",
      "comment": "Amazing experience! The seat was comfortable and the service was top-notch. Highly recommended.",
      "helpful": 31,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Flight Details"),
        actions: [
          IconButton(
            icon: Icon(Icons.share),
            onPressed: () {
              ss("Flight details shared");
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Flight Header
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Image.network(
                      "${flightDetails["logo"]}",
                      width: 80,
                      height: 40,
                      fit: BoxFit.contain,
                    ),
                    SizedBox(width: spMd),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${flightDetails["airline"]}",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          Text(
                            "${flightDetails["flightNumber"]} • ${flightDetails["aircraft"]}",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        if ((flightDetails["discount"] as int) > 0) ...[
                          Text(
                            "\$${((flightDetails["originalPrice"] as double)).currency}",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                              decoration: TextDecoration.lineThrough,
                            ),
                          ),
                          SizedBox(height: spXs),
                        ],
                        Text(
                          "\$${((flightDetails["price"] as double)).currency}",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),

                SizedBox(height: spMd),

                // Flight Route
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${flightDetails["departureTime"]}",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          Text(
                            "${flightDetails["departureDate"]}",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "${flightDetails["departureAirport"]} - ${flightDetails["departureCity"]}",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: primaryColor,
                            ),
                          ),
                          Text(
                            "${flightDetails["departureTerminal"]}",
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
                        Container(
                          width: 40,
                          height: 2,
                          margin: EdgeInsets.symmetric(vertical: spXs),
                          color: primaryColor,
                        ),
                        Text(
                          "${flightDetails["duration"]}",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "${flightDetails["stopDetails"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: successColor,
                          ),
                        ),
                        Container(
                          width: 40,
                          height: 2,
                          margin: EdgeInsets.symmetric(vertical: spXs),
                          color: primaryColor,
                        ),
                        Icon(
                          Icons.flight_land,
                          color: primaryColor,
                          size: 24,
                        ),
                      ],
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            "${flightDetails["arrivalTime"]}",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          Text(
                            "${flightDetails["arrivalDate"]}",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "${flightDetails["arrivalAirport"]} - ${flightDetails["arrivalCity"]}",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: primaryColor,
                            ),
                          ),
                          Text(
                            "${flightDetails["arrivalTerminal"]}",
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

          // Tab Content
          Expanded(
            child: QTabBar(
              withoutAppBar: true,
              selectedIndex: selectedTabIndex,
              tabs: [
                Tab(text: "Details", icon: Icon(Icons.info)),
                Tab(text: "Amenities", icon: Icon(Icons.flight_class)),
                Tab(text: "Reviews", icon: Icon(Icons.star)),
              ],
              tabChildren: [
                // Details Tab
                SingleChildScrollView(
                  padding: EdgeInsets.all(spMd),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: spMd,
                    children: [
                      // Aircraft Information
                      Container(
                        padding: EdgeInsets.all(spMd),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(radiusMd),
                          boxShadow: [shadowMd],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: spSm,
                          children: [
                            Text(
                              "Aircraft Information",
                              style: TextStyle(
                                fontSize: fsH6,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Aircraft Type",
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                      Text(
                                        "${flightDetails["aircraft"]}",
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
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
                                        "Seat Configuration",
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                      Text(
                                        "${flightDetails["seatConfiguration"]}",
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                          color: primaryColor,
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
                                        "Distance",
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                      Text(
                                        "${flightDetails["distance"]}",
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
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
                                        "Seats Available",
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                      Text(
                                        "${flightDetails["seatAvailability"]} seats",
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                          color: (flightDetails["seatAvailability"] as int) <= 10
                                              ? dangerColor
                                              : successColor,
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

                      // Baggage Information
                      Container(
                        padding: EdgeInsets.all(spMd),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(radiusMd),
                          boxShadow: [shadowMd],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: spSm,
                          children: [
                            Text(
                              "Baggage Allowance",
                              style: TextStyle(
                                fontSize: fsH6,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.luggage,
                                  color: infoColor,
                                  size: 20,
                                ),
                                SizedBox(width: spSm),
                                Text(
                                  "${(flightDetails["baggage"] as Map)["carry"]}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: primaryColor,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.business_center,
                                  color: successColor,
                                  size: 20,
                                ),
                                SizedBox(width: spSm),
                                Text(
                                  "${(flightDetails["baggage"] as Map)["checked"]}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: primaryColor,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),

                      // Fare Breakdown
                      Container(
                        padding: EdgeInsets.all(spMd),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(radiusMd),
                          boxShadow: [shadowMd],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: spSm,
                          children: [
                            Text(
                              "Fare Breakdown",
                              style: TextStyle(
                                fontSize: fsH6,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            ...fareBreakdown.map((item) {
                              return Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "${item["description"]}",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: item["type"] == "discount"
                                          ? successColor
                                          : disabledBoldColor,
                                    ),
                                  ),
                                  Text(
                                    "${(item["amount"] as double) < 0 ? "-" : ""}\$${((item["amount"] as double).abs()).currency}",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: item["type"] == "discount"
                                          ? successColor
                                          : primaryColor,
                                    ),
                                  ),
                                ],
                              );
                            }),
                            Divider(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Total",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                                Text(
                                  "\$${((flightDetails["price"] as double)).currency}",
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

                      // Policies
                      Container(
                        padding: EdgeInsets.all(spMd),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(radiusMd),
                          boxShadow: [shadowMd],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: spSm,
                          children: [
                            Text(
                              "Policies",
                              style: TextStyle(
                                fontSize: fsH6,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Icon(
                                  Icons.cancel,
                                  color: dangerColor,
                                  size: 16,
                                ),
                                SizedBox(width: spSm),
                                Expanded(
                                  child: Text(
                                    "${flightDetails["cancellationPolicy"]}",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Icon(
                                  Icons.edit,
                                  color: warningColor,
                                  size: 16,
                                ),
                                SizedBox(width: spSm),
                                Expanded(
                                  child: Text(
                                    "${flightDetails["changePolicy"]}",
                                    style: TextStyle(
                                      fontSize: 14,
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

                // Amenities Tab
                SingleChildScrollView(
                  padding: EdgeInsets.all(spMd),
                  child: Column(
                    spacing: spMd,
                    children: [
                      Container(
                        padding: EdgeInsets.all(spMd),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(radiusMd),
                          boxShadow: [shadowMd],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: spMd,
                          children: [
                            Text(
                              "In-Flight Amenities",
                              style: TextStyle(
                                fontSize: fsH6,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            ResponsiveGridView(
                              padding: EdgeInsets.zero,
                              minItemWidth: 200,
                              children: [
                                _buildAmenityItem(
                                  "Wi-Fi",
                                  Icons.wifi,
                                  (flightDetails["amenities"] as Map)["wifi"] as bool,
                                ),
                                _buildAmenityItem(
                                  "Entertainment",
                                  Icons.tv,
                                  (flightDetails["amenities"] as Map)["entertainment"] as bool,
                                ),
                                _buildAmenityItem(
                                  "Meals",
                                  Icons.restaurant,
                                  (flightDetails["amenities"] as Map)["meals"] as bool,
                                ),
                                _buildAmenityItem(
                                  "Power Outlet",
                                  Icons.power,
                                  (flightDetails["amenities"] as Map)["power"] as bool,
                                ),
                                _buildAmenityItem(
                                  "Blanket",
                                  Icons.air,
                                  (flightDetails["amenities"] as Map)["blanket"] as bool,
                                ),
                                _buildAmenityItem(
                                  "Pillow",
                                  Icons.hotel,
                                  (flightDetails["amenities"] as Map)["pillow"] as bool,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                // Reviews Tab
                SingleChildScrollView(
                  padding: EdgeInsets.all(spMd),
                  child: Column(
                    spacing: spMd,
                    children: [
                      // Rating Summary
                      Container(
                        padding: EdgeInsets.all(spMd),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(radiusMd),
                          boxShadow: [shadowMd],
                        ),
                        child: Row(
                          children: [
                            Column(
                              children: [
                                Text(
                                  "${flightDetails["rating"]}",
                                  style: TextStyle(
                                    fontSize: 32,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                                Row(
                                  children: List.generate(5, (index) {
                                    return Icon(
                                      index < (flightDetails["rating"] as double).floor()
                                          ? Icons.star
                                          : Icons.star_border,
                                      color: warningColor,
                                      size: 20,
                                    );
                                  }),
                                ),
                              ],
                            ),
                            SizedBox(width: spMd),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Excellent",
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: primaryColor,
                                    ),
                                  ),
                                  Text(
                                    "Based on ${flightDetails["reviews"]} reviews",
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
                      ),

                      // Individual Reviews
                      ...reviews.map((review) {
                        return Container(
                          padding: EdgeInsets.all(spMd),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(radiusMd),
                            boxShadow: [shadowMd],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            spacing: spSm,
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      "${review["name"]}",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        color: primaryColor,
                                      ),
                                    ),
                                  ),
                                  Row(
                                    children: List.generate(5, (index) {
                                      return Icon(
                                        index < (review["rating"] as int)
                                            ? Icons.star
                                            : Icons.star_border,
                                        color: warningColor,
                                        size: 16,
                                      );
                                    }),
                                  ),
                                ],
                              ),
                              Text(
                                "${review["comment"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: disabledBoldColor,
                                  height: 1.4,
                                ),
                              ),
                              Row(
                                children: [
                                  Text(
                                    "${review["date"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                  Spacer(),
                                  Text(
                                    "${review["helpful"]} found helpful",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: successColor,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      }),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(spMd),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [shadowMd],
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
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
                    "\$${((flightDetails["price"] as double)).currency}",
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
              child: QButton(
                label: "Book Now",
                size: bs.md,
                onPressed: () {
                  // navigateTo(TtaFlightBookingView())
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAmenityItem(String title, IconData icon, bool available) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: available ? successColor.withAlpha(10) : disabledColor.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(
          color: available ? successColor.withAlpha(30) : disabledColor.withAlpha(30),
        ),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            color: available ? successColor : disabledBoldColor,
            size: 20,
          ),
          SizedBox(width: spSm),
          Text(
            title,
            style: TextStyle(
              fontSize: 14,
              color: available ? successColor : disabledBoldColor,
              fontWeight: FontWeight.w500,
            ),
          ),
          Spacer(),
          Icon(
            available ? Icons.check_circle : Icons.cancel,
            color: available ? successColor : disabledBoldColor,
            size: 16,
          ),
        ],
      ),
    );
  }
}
