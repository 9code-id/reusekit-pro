import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class TtaFlightSearchView extends StatefulWidget {
  const TtaFlightSearchView({super.key});

  @override
  State<TtaFlightSearchView> createState() => _TtaFlightSearchViewState();
}

class _TtaFlightSearchViewState extends State<TtaFlightSearchView> {
  String fromCity = "New York (NYC)";
  String toCity = "Paris (CDG)";
  String departureDate = "2024-06-25";
  String returnDate = "2024-07-02";
  String passengers = "1";
  String travelClass = "economy";
  bool isRoundTrip = true;
  bool isFlexibleDates = false;

  List<Map<String, dynamic>> travelClasses = [
    {"label": "Economy", "value": "economy"},
    {"label": "Premium Economy", "value": "premium"},
    {"label": "Business", "value": "business"},
    {"label": "First Class", "value": "first"},
  ];

  List<Map<String, dynamic>> recentSearches = [
    {
      "from": "New York",
      "to": "London",
      "date": "2024-06-20",
      "passengers": 2,
    },
    {
      "from": "Los Angeles",
      "to": "Tokyo",
      "date": "2024-07-15",
      "passengers": 1,
    },
    {
      "from": "Chicago",
      "to": "Frankfurt",
      "date": "2024-08-10",
      "passengers": 3,
    },
  ];

  List<Map<String, dynamic>> popularDestinations = [
    {
      "city": "London",
      "country": "United Kingdom",
      "code": "LHR",
      "image": "https://picsum.photos/300/200?random=1&keyword=london",
      "price": 450,
    },
    {
      "city": "Paris",
      "country": "France",
      "code": "CDG",
      "image": "https://picsum.photos/300/200?random=2&keyword=paris",
      "price": 520,
    },
    {
      "city": "Tokyo",
      "country": "Japan",
      "code": "NRT",
      "image": "https://picsum.photos/300/200?random=3&keyword=tokyo",
      "price": 890,
    },
    {
      "city": "Dubai",
      "country": "UAE",
      "code": "DXB",
      "image": "https://picsum.photos/300/200?random=4&keyword=dubai",
      "price": 680,
    },
    {
      "city": "Sydney",
      "country": "Australia",
      "code": "SYD",
      "image": "https://picsum.photos/300/200?random=5&keyword=sydney",
      "price": 1200,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Flight Search"),
        actions: [
          IconButton(
            icon: Icon(Icons.history),
            onPressed: () {
              // navigateTo(TtaSearchHistoryView())
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
            // Search Form Card
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
                  Row(
                    children: [
                      Icon(
                        Icons.flight_takeoff,
                        color: primaryColor,
                        size: 24,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "Book Your Flight",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),

                  // Trip Type Toggle
                  Row(
                    children: [
                      Expanded(
                        child: QSwitch(
                          items: [
                            {
                              "label": "Round Trip",
                              "value": true,
                              "checked": isRoundTrip,
                            }
                          ],
                          value: [
                            if (isRoundTrip)
                              {
                                "label": "Round Trip",
                                "value": true,
                                "checked": true
                              }
                          ],
                          onChanged: (values, ids) {
                            isRoundTrip = values.isNotEmpty;
                            setState(() {});
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QSwitch(
                          items: [
                            {
                              "label": "Flexible Dates",
                              "value": true,
                              "checked": isFlexibleDates,
                            }
                          ],
                          value: [
                            if (isFlexibleDates)
                              {
                                "label": "Flexible Dates",
                                "value": true,
                                "checked": true
                              }
                          ],
                          onChanged: (values, ids) {
                            isFlexibleDates = values.isNotEmpty;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),

                  // From and To Cities
                  Row(
                    children: [
                      Expanded(
                        child: QTextField(
                          label: "From",
                          value: fromCity,
                          onChanged: (value) {
                            fromCity = value;
                            setState(() {});
                          },
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: spSm),
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: primaryColor.withAlpha(10),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: GestureDetector(
                          onTap: () {
                            String temp = fromCity;
                            fromCity = toCity;
                            toCity = temp;
                            setState(() {});
                          },
                          child: Icon(
                            Icons.swap_horiz,
                            color: primaryColor,
                            size: 20,
                          ),
                        ),
                      ),
                      Expanded(
                        child: QTextField(
                          label: "To",
                          value: toCity,
                          onChanged: (value) {
                            toCity = value;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),

                  // Dates
                  Row(
                    children: [
                      Expanded(
                        child: QDatePicker(
                          label: "Departure Date",
                          value: DateTime.parse(departureDate),
                          onChanged: (value) {
                            departureDate = value.toString().split(' ')[0];
                            setState(() {});
                          },
                        ),
                      ),
                      if (isRoundTrip) ...[
                        SizedBox(width: spSm),
                        Expanded(
                          child: QDatePicker(
                            label: "Return Date",
                            value: DateTime.parse(returnDate),
                            onChanged: (value) {
                              returnDate = value.toString().split(' ')[0];
                              setState(() {});
                            },
                          ),
                        ),
                      ],
                    ],
                  ),

                  // Passengers and Class
                  Row(
                    children: [
                      Expanded(
                        child: QNumberField(
                          label: "Passengers",
                          value: passengers,
                          onChanged: (value) {
                            passengers = value;
                            setState(() {});
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QDropdownField(
                          label: "Travel Class",
                          items: travelClasses,
                          value: travelClass,
                          onChanged: (value, label) {
                            travelClass = value;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),

                  // Search Button
                  Container(
                    width: double.infinity,
                    child: QButton(
                      label: "Search Flights",
                      size: bs.md,
                      onPressed: () {
                        // navigateTo(TtaFlightResultsView())
                      },
                    ),
                  ),
                ],
              ),
            ),

            // Recent Searches
            if (recentSearches.isNotEmpty) ...[
              Text(
                "Recent Searches",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),

              Container(
                height: 120,
                child: QHorizontalScroll(
                  children: recentSearches.map((search) {
                    return Container(
                      width: 280,
                      padding: EdgeInsets.all(spMd),
                      margin: EdgeInsets.only(right: spSm),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(radiusMd),
                        boxShadow: [shadowMd],
                        border: Border.all(color: primaryColor.withAlpha(30)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                "${search["from"]}",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: primaryColor,
                                ),
                              ),
                              Icon(
                                Icons.arrow_forward,
                                color: disabledBoldColor,
                                size: 16,
                              ),
                              Text(
                                "${search["to"]}",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: primaryColor,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: spSm),
                          Text(
                            "${search["date"]} • ${search["passengers"]} passenger${(search["passengers"] as int) > 1 ? "s" : ""}",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                          Spacer(),
                          GestureDetector(
                            onTap: () {
                              fromCity = "${search["from"]}";
                              toCity = "${search["to"]}";
                              departureDate = "${search["date"]}";
                              passengers = "${search["passengers"]}";
                              setState(() {});
                            },
                            child: Text(
                              "Search Again",
                              style: TextStyle(
                                fontSize: 14,
                                color: primaryColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ),
            ],

            // Popular Destinations
            Text(
              "Popular Destinations",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),

            Container(
              height: 220,
              child: QHorizontalScroll(
                children: popularDestinations.map((destination) {
                  return Container(
                    width: 200,
                    margin: EdgeInsets.only(right: spSm),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusMd),
                      boxShadow: [shadowMd],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(radiusMd),
                            topRight: Radius.circular(radiusMd),
                          ),
                          child: Image.network(
                            "${destination["image"]}",
                            height: 120,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(spMd),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${destination["city"]}",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                              SizedBox(height: spXs),
                              Text(
                                "${destination["country"]} (${destination["code"]})",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: disabledBoldColor,
                                ),
                              ),
                              SizedBox(height: spSm),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "From \$${destination["price"]}",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: successColor,
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      toCity = "${destination["city"]} (${destination["code"]})";
                                      setState(() {});
                                    },
                                    child: Icon(
                                      Icons.arrow_forward_ios,
                                      color: primaryColor,
                                      size: 16,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),

            // Flight Tips
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: infoColor.withAlpha(10),
                borderRadius: BorderRadius.circular(radiusMd),
                border: Border.all(color: infoColor.withAlpha(30)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.info,
                        color: infoColor,
                        size: 20,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "Flight Booking Tips",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: infoColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "• Book 2-3 months in advance for best prices\n• Tuesday and Wednesday departures are often cheaper\n• Clear your browser cookies before booking\n• Consider nearby airports for better deals\n• Use flexible dates to find the lowest fares",
                    style: TextStyle(
                      fontSize: 14,
                      color: disabledBoldColor,
                      height: 1.5,
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
}
