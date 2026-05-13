import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class TtaFlightStatusView extends StatefulWidget {
  const TtaFlightStatusView({super.key});

  @override
  State<TtaFlightStatusView> createState() => _TtaFlightStatusViewState();
}

class _TtaFlightStatusViewState extends State<TtaFlightStatusView> {
  String searchQuery = "";
  String selectedFilter = "all";

  List<Map<String, dynamic>> filterOptions = [
    {"label": "All Flights", "value": "all"},
    {"label": "My Flights", "value": "my_flights"},
    {"label": "Delayed", "value": "delayed"},
    {"label": "On Time", "value": "on_time"},
    {"label": "Cancelled", "value": "cancelled"},
  ];

  List<Map<String, dynamic>> flights = [
    {
      "flightNumber": "TT 4582",
      "airline": "TravelTech Airways",
      "airlineCode": "TT",
      "route": {
        "from": {"code": "JFK", "city": "New York", "terminal": "Terminal 4", "gate": "A12"},
        "to": {"code": "LAX", "city": "Los Angeles", "terminal": "Terminal 6", "gate": "B8"},
      },
      "schedule": {
        "departure": "2024-06-20T08:30:00",
        "arrival": "2024-06-20T11:45:00",
        "actualDeparture": "2024-06-20T08:35:00",
        "actualArrival": null,
        "estimatedArrival": "2024-06-20T11:50:00",
      },
      "status": "in_flight",
      "delay": 5,
      "aircraft": "Boeing 737-800",
      "isMyFlight": true,
      "progress": 65,
      "altitude": "35,000 ft",
      "speed": "480 mph",
      "distance": {
        "total": "2,475 miles",
        "remaining": "865 miles",
      },
    },
    {
      "flightNumber": "TT 2156",
      "airline": "TravelTech Airways",
      "airlineCode": "TT",
      "route": {
        "from": {"code": "MIA", "city": "Miami", "terminal": "Terminal 2", "gate": "C15"},
        "to": {"code": "ORD", "city": "Chicago", "terminal": "Terminal 1", "gate": "K8"},
      },
      "schedule": {
        "departure": "2024-06-20T14:20:00",
        "arrival": "2024-06-20T17:05:00",
        "actualDeparture": null,
        "actualArrival": null,
        "estimatedArrival": "2024-06-20T17:05:00",
      },
      "status": "on_time",
      "delay": 0,
      "aircraft": "Airbus A320",
      "isMyFlight": false,
      "progress": 0,
    },
    {
      "flightNumber": "TT 8891",
      "airline": "TravelTech Airways",
      "airlineCode": "TT",
      "route": {
        "from": {"code": "SEA", "city": "Seattle", "terminal": "Terminal A", "gate": "N12"},
        "to": {"code": "DEN", "city": "Denver", "terminal": "Terminal B", "gate": "A25"},
      },
      "schedule": {
        "departure": "2024-06-20T09:15:00",
        "arrival": "2024-06-20T12:30:00",
        "actualDeparture": null,
        "actualArrival": null,
        "estimatedArrival": "2024-06-20T13:15:00",
      },
      "status": "delayed",
      "delay": 45,
      "aircraft": "Boeing 757-200",
      "isMyFlight": false,
      "progress": 0,
      "reason": "Weather conditions at departure airport",
    },
    {
      "flightNumber": "TT 3367",
      "airline": "TravelTech Airways",
      "airlineCode": "TT",
      "route": {
        "from": {"code": "ATL", "city": "Atlanta", "terminal": "Terminal N", "gate": "T15"},
        "to": {"code": "LAX", "city": "Los Angeles", "terminal": "Terminal 6", "gate": "B12"},
      },
      "schedule": {
        "departure": "2024-06-20T11:00:00",
        "arrival": "2024-06-20T13:20:00",
        "actualDeparture": "2024-06-20T11:05:00",
        "actualArrival": "2024-06-20T13:15:00",
      },
      "status": "landed",
      "delay": -5,
      "aircraft": "Boeing 777-300",
      "isMyFlight": false,
      "progress": 100,
    },
    {
      "flightNumber": "TT 9924",
      "airline": "TravelTech Airways",
      "airlineCode": "TT",
      "route": {
        "from": {"code": "BOS", "city": "Boston", "terminal": "Terminal B", "gate": "C12"},
        "to": {"code": "SFO", "city": "San Francisco", "terminal": "Terminal 3", "gate": "D8"},
      },
      "schedule": {
        "departure": "2024-06-20T07:30:00",
        "arrival": "2024-06-20T11:15:00",
        "actualDeparture": null,
        "actualArrival": null,
        "estimatedArrival": null,
      },
      "status": "cancelled",
      "delay": 0,
      "aircraft": "Airbus A321",
      "isMyFlight": false,
      "progress": 0,
      "reason": "Aircraft maintenance issue",
    },
  ];

  List<Map<String, dynamic>> get filteredFlights {
    return flights.where((flight) {
      bool matchesSearch = searchQuery.isEmpty ||
          flight["flightNumber"].toLowerCase().contains(searchQuery.toLowerCase()) ||
          flight["route"]["from"]["code"].toLowerCase().contains(searchQuery.toLowerCase()) ||
          flight["route"]["to"]["code"].toLowerCase().contains(searchQuery.toLowerCase()) ||
          flight["route"]["from"]["city"].toLowerCase().contains(searchQuery.toLowerCase()) ||
          flight["route"]["to"]["city"].toLowerCase().contains(searchQuery.toLowerCase());

      bool matchesFilter = selectedFilter == "all" ||
          (selectedFilter == "my_flights" && flight["isMyFlight"]) ||
          (selectedFilter == "delayed" && flight["status"] == "delayed") ||
          (selectedFilter == "on_time" && flight["status"] == "on_time") ||
          (selectedFilter == "cancelled" && flight["status"] == "cancelled");

      return matchesSearch && matchesFilter;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Flight Status"),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              si("Flight status updated");
            },
          ),
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {
              si("Flight notifications settings");
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
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: primaryColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusMd),
                border: Border.all(color: primaryColor.withAlpha(50)),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.flight,
                    color: primaryColor,
                    size: 28,
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Live Flight Tracking",
                          style: TextStyle(
                            fontSize: fsH5,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "Real-time updates on departure, arrival, and gate information.",
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

            Row(
              children: [
                Expanded(
                  child: QTextField(
                    label: "Search flights",
                    value: searchQuery,
                    hint: "Flight number, airport code, or city...",
                    onChanged: (value) {
                      searchQuery = value;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                    color: primaryColor,
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Icon(
                    Icons.search,
                    color: Colors.white,
                    size: 24,
                  ),
                ),
              ],
            ),

            QCategoryPicker(
              label: "Filter flights",
              items: filterOptions,
              value: selectedFilter,
              onChanged: (index, label, value, item) {
                selectedFilter = value;
                setState(() {});
              },
            ),

            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: infoColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Row(
                children: [
                  Icon(Icons.info, color: infoColor, size: 16),
                  SizedBox(width: spXs),
                  Text(
                    "Found ${filteredFlights.length} flight(s) • Last updated: ${TimeOfDay.now().kkmm}",
                    style: TextStyle(
                      fontSize: 13,
                      color: disabledBoldColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),

            if (filteredFlights.isEmpty)
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(spLg),
                decoration: BoxDecoration(
                  color: Colors.grey.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusMd),
                ),
                child: Column(
                  children: [
                    Icon(
                      Icons.flight_takeoff,
                      size: 48,
                      color: disabledBoldColor,
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "No Flights Found",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "Try adjusting your search terms or filter criteria.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),

            ...filteredFlights.map((flight) {
              return _buildFlightCard(flight);
            }).toList(),
          ],
        ),
      ),
    );
  }

  Widget _buildFlightCard(Map<String, dynamic> flight) {
    final status = flight["status"] as String;
    final isMyFlight = flight["isMyFlight"] as bool;
    final delay = (flight["delay"] as int);
    final progress = (flight["progress"] as int);

    Color statusColor = primaryColor;
    IconData statusIcon = Icons.flight;
    String statusText = "Unknown";

    switch (status) {
      case "on_time":
        statusColor = successColor;
        statusIcon = Icons.schedule;
        statusText = "On Time";
        break;
      case "delayed":
        statusColor = warningColor;
        statusIcon = Icons.schedule;
        statusText = "Delayed ${delay}m";
        break;
      case "in_flight":
        statusColor = infoColor;
        statusIcon = Icons.flight;
        statusText = "In Flight";
        break;
      case "landed":
        statusColor = successColor;
        statusIcon = Icons.flight_land;
        statusText = "Landed";
        break;
      case "cancelled":
        statusColor = dangerColor;
        statusIcon = Icons.cancel;
        statusText = "Cancelled";
        break;
    }

    return Container(
      margin: EdgeInsets.only(bottom: spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
        border: isMyFlight ? Border.all(color: primaryColor.withAlpha(50), width: 2) : null,
      ),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(spMd),
            child: Column(
              spacing: spMd,
              children: [
                Row(
                  children: [
                    if (isMyFlight)
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                        decoration: BoxDecoration(
                          color: primaryColor,
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Text(
                          "MY FLIGHT",
                          style: TextStyle(
                            fontSize: 10,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    if (isMyFlight) SizedBox(width: spSm),
                    Text(
                      "${flight["flightNumber"]}",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
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
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                      decoration: BoxDecoration(
                        color: statusColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusSm),
                        border: Border.all(color: statusColor.withAlpha(50)),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(statusIcon, size: 12, color: statusColor),
                          SizedBox(width: spXs),
                          Text(
                            statusText,
                            style: TextStyle(
                              fontSize: 12,
                              color: statusColor,
                              fontWeight: FontWeight.bold,
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
                            "${flight["route"]["from"]["code"]}",
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "${flight["route"]["from"]["city"]}",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                          Text(
                            "${flight["route"]["from"]["terminal"]}",
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
                        if (status == "in_flight" && progress > 0)
                          Text(
                            "${progress}%",
                            style: TextStyle(
                              fontSize: 12,
                              color: primaryColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                      ],
                    ),
                    
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            "${flight["route"]["to"]["code"]}",
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "${flight["route"]["to"]["city"]}",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                          Text(
                            "${flight["route"]["to"]["terminal"]}",
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

                if (status == "in_flight" && progress > 0)
                  Column(
                    spacing: spSm,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: LinearProgressIndicator(
                              value: progress / 100,
                              backgroundColor: Colors.grey.withAlpha(30),
                              valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          if (flight["altitude"] != null)
                            _buildFlightInfo(Icons.height, "Altitude", "${flight["altitude"]}"),
                          if (flight["speed"] != null)
                            _buildFlightInfo(Icons.speed, "Speed", "${flight["speed"]}"),
                          if (flight["distance"] != null)
                            _buildFlightInfo(Icons.straighten, "Remaining", "${flight["distance"]["remaining"]}"),
                        ],
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
                            "${TimeOfDay.fromDateTime(DateTime.parse(flight["schedule"]["departure"])).kkmm}",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          if (flight["schedule"]["actualDeparture"] != null)
                            Text(
                              "Actual: ${TimeOfDay.fromDateTime(DateTime.parse(flight["schedule"]["actualDeparture"])).kkmm}",
                              style: TextStyle(
                                fontSize: 12,
                                color: delay > 0 ? warningColor : successColor,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          Text(
                            "Gate ${flight["route"]["from"]["gate"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
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
                            "Arrival",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          Text(
                            "${TimeOfDay.fromDateTime(DateTime.parse(flight["schedule"]["arrival"])).kkmm}",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          if (flight["schedule"]["actualArrival"] != null)
                            Text(
                              "Actual: ${TimeOfDay.fromDateTime(DateTime.parse(flight["schedule"]["actualArrival"])).kkmm}",
                              style: TextStyle(
                                fontSize: 12,
                                color: delay > 0 ? warningColor : successColor,
                                fontWeight: FontWeight.w500,
                              ),
                            )
                          else if (flight["schedule"]["estimatedArrival"] != null && status != "cancelled")
                            Text(
                              "Est: ${TimeOfDay.fromDateTime(DateTime.parse(flight["schedule"]["estimatedArrival"])).kkmm}",
                              style: TextStyle(
                                fontSize: 12,
                                color: delay > 0 ? warningColor : primaryColor,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          Text(
                            "Gate ${flight["route"]["to"]["gate"]}",
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

                if (flight["reason"] != null)
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: warningColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusSm),
                      border: Border.all(color: warningColor.withAlpha(50)),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.info, color: warningColor, size: 16),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Text(
                            "${flight["reason"]}",
                            style: TextStyle(
                              fontSize: 13,
                              color: warningColor,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),

          if (isMyFlight || status == "delayed" || status == "cancelled")
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.grey.withAlpha(10),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(radiusMd),
                  bottomRight: Radius.circular(radiusMd),
                ),
              ),
              child: Row(
                children: [
                  if (isMyFlight) ...[
                    Expanded(
                      child: QButton(
                        label: "Check-in",
                        size: bs.sm,
                        icon: Icons.check_circle,
                        onPressed: () {
                          //navigateTo(TtaCheckInView());
                        },
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: QButton(
                        label: "Boarding Pass",
                        size: bs.sm,
                        icon: Icons.airplane_ticket,
                        onPressed: () {
                          //navigateTo(TtaBoardingPassView());
                        },
                      ),
                    ),
                  ] else ...[
                    Expanded(
                      child: QButton(
                        label: "Track Flight",
                        size: bs.sm,
                        icon: Icons.track_changes,
                        onPressed: () {
                          si("Flight ${flight["flightNumber"]} added to tracking");
                        },
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: QButton(
                        label: "Set Alert",
                        size: bs.sm,
                        icon: Icons.notifications,
                        onPressed: () {
                          ss("Flight alert set for ${flight["flightNumber"]}");
                        },
                      ),
                    ),
                  ],
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildFlightInfo(IconData icon, String label, String value) {
    return Expanded(
      child: Row(
        children: [
          Icon(icon, size: 14, color: disabledBoldColor),
          SizedBox(width: spXs),
          Column(
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
          ),
        ],
      ),
    );
  }
}
