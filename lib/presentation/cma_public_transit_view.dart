import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class CmaPublicTransitView extends StatefulWidget {
  const CmaPublicTransitView({super.key});

  @override
  State<CmaPublicTransitView> createState() => _CmaPublicTransitViewState();
}

class _CmaPublicTransitViewState extends State<CmaPublicTransitView> {
  String fromStation = "";
  String toStation = "";
  String selectedRoute = "";
  DateTime selectedDate = DateTime.now();
  String selectedTime = "";
  bool buyReturn = false;
  String selectedTicketType = "Single";
  int currentTab = 0;

  List<Map<String, dynamic>> transportTypes = [
    {
      "id": "bus",
      "name": "Bus",
      "icon": Icons.directions_bus,
      "color": primaryColor,
      "description": "City and intercity buses"
    },
    {
      "id": "train",
      "name": "Train",
      "icon": Icons.train,
      "color": infoColor,
      "description": "Metro and regional trains"
    },
    {
      "id": "metro",
      "name": "Metro",
      "icon": Icons.subway,
      "color": successColor,
      "description": "Underground metro system"
    },
    {
      "id": "tram",
      "name": "Tram",
      "icon": Icons.tram,
      "color": warningColor,
      "description": "Electric tram lines"
    }
  ];

  List<Map<String, dynamic>> routes = [
    {
      "id": "route001",
      "type": "Bus",
      "number": "Route 42",
      "from": "Central Station",
      "to": "Airport Terminal",
      "duration": "45 min",
      "distance": "28 km",
      "stops": 12,
      "price": 4.50,
      "frequency": "Every 15 min",
      "nextDeparture": "14:30",
      "color": primaryColor,
      "accessibility": true
    },
    {
      "id": "route002",
      "type": "Train",
      "number": "Blue Line",
      "from": "Downtown",
      "to": "Suburbs East",
      "duration": "32 min",
      "distance": "35 km",
      "stops": 8,
      "price": 6.20,
      "frequency": "Every 12 min",
      "nextDeparture": "14:25",
      "color": infoColor,
      "accessibility": true
    },
    {
      "id": "route003",
      "type": "Metro",
      "number": "Green Line",
      "from": "City Center",
      "to": "University",
      "duration": "18 min",
      "distance": "12 km",
      "stops": 6,
      "price": 3.80,
      "frequency": "Every 8 min",
      "nextDeparture": "14:28",
      "color": successColor,
      "accessibility": false
    },
    {
      "id": "route004",
      "type": "Tram",
      "number": "Tram 7",
      "from": "Old Town",
      "to": "Business District",
      "duration": "25 min",
      "distance": "15 km",
      "stops": 10,
      "price": 3.20,
      "frequency": "Every 10 min",
      "nextDeparture": "14:35",
      "color": warningColor,
      "accessibility": true
    }
  ];

  List<Map<String, dynamic>> tickets = [
    {
      "id": "ticket001",
      "type": "Single Journey",
      "route": "Route 42",
      "from": "Central Station",
      "to": "Airport Terminal",
      "date": "2024-03-15",
      "time": "09:30",
      "price": 4.50,
      "status": "Active",
      "validUntil": "2024-03-15T12:30:00",
      "qrCode": "QR123456789"
    },
    {
      "id": "ticket002",
      "type": "Day Pass",
      "route": "All Routes",
      "from": "Any Station",
      "to": "Any Station",
      "date": "2024-03-14",
      "time": "All Day",
      "price": 12.00,
      "status": "Expired",
      "validUntil": "2024-03-14T23:59:00",
      "qrCode": "QR987654321"
    }
  ];

  List<Map<String, dynamic>> travelHistory = [
    {
      "id": "travel001",
      "route": "Blue Line",
      "from": "Downtown",
      "to": "Suburbs East",
      "date": "2024-03-13",
      "time": "08:15",
      "duration": "32 min",
      "price": 6.20,
      "type": "Train"
    },
    {
      "id": "travel002",
      "route": "Route 42",
      "from": "Central Station",
      "to": "Shopping Mall",
      "date": "2024-03-12",
      "time": "14:45",
      "duration": "28 min",
      "price": 4.50,
      "type": "Bus"
    },
    {
      "id": "travel003",
      "route": "Green Line",
      "from": "City Center",
      "to": "University",
      "date": "2024-03-11",
      "time": "09:20",
      "duration": "18 min",
      "price": 3.80,
      "type": "Metro"
    }
  ];

  List<Map<String, dynamic>> ticketTypes = [
    {
      "id": "single",
      "name": "Single Journey",
      "description": "One-way ticket for single trip",
      "validity": "3 hours",
      "multiplier": 1.0
    },
    {
      "id": "return",
      "name": "Return Ticket",
      "description": "Round trip ticket",
      "validity": "24 hours",
      "multiplier": 1.8
    },
    {
      "id": "day_pass",
      "name": "Day Pass",
      "description": "Unlimited rides for one day",
      "validity": "24 hours",
      "multiplier": 3.0
    },
    {
      "id": "week_pass",
      "name": "Weekly Pass",
      "description": "Unlimited rides for 7 days",
      "validity": "7 days",
      "multiplier": 18.0
    }
  ];

  List<Map<String, dynamic>> alerts = [
    {
      "id": "alert001",
      "type": "Delay",
      "severity": "medium",
      "route": "Blue Line",
      "message": "15 minute delay due to signal issues",
      "timestamp": "2024-03-15T14:20:00",
      "affected": "All stations"
    },
    {
      "id": "alert002",
      "type": "Service",
      "severity": "high",
      "route": "Route 42",
      "message": "Weekend service changes - reduced frequency",
      "timestamp": "2024-03-15T10:00:00",
      "affected": "Weekend only"
    },
    {
      "id": "alert003",
      "type": "Maintenance",
      "severity": "low",
      "route": "Green Line",
      "message": "Scheduled maintenance this Sunday 6-8 AM",
      "timestamp": "2024-03-14T16:30:00",
      "affected": "Station 3-5"
    }
  ];

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Public Transit",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Plan Trip", icon: Icon(Icons.directions)),
        Tab(text: "Tickets", icon: Icon(Icons.confirmation_number)),
        Tab(text: "Live Map", icon: Icon(Icons.map)),
        Tab(text: "History", icon: Icon(Icons.history)),
      ],
      tabChildren: [
        _buildPlanTripTab(),
        _buildTicketsTab(),
        _buildLiveMapTab(),
        _buildHistoryTab(),
      ],
    );
  }

  Widget _buildPlanTripTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Transport Type Selection
          Text(
            "Transport Types",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 150,
            children: transportTypes.map((type) {
              return Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: (type["color"] as Color).withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusLg),
                      ),
                      child: Icon(
                        type["icon"] as IconData,
                        color: type["color"] as Color,
                        size: 32,
                      ),
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "${type["name"]}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "${type["description"]}",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),

          // Journey Planning
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Plan Your Journey",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spSm),
                QTextField(
                  label: "From Station",
                  value: fromStation,
                  hint: "Enter departure station",
                  onChanged: (value) {
                    fromStation = value;
                    setState(() {});
                  },
                ),
                SizedBox(height: spSm),
                QTextField(
                  label: "To Station",
                  value: toStation,
                  hint: "Enter destination station",
                  onChanged: (value) {
                    toStation = value;
                    setState(() {});
                  },
                ),
                SizedBox(height: spSm),
                Row(
                  children: [
                    Expanded(
                      child: QDatePicker(
                        label: "Travel Date",
                        value: selectedDate,
                        onChanged: (value) {
                          selectedDate = value;
                          setState(() {});
                        },
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: QTimePicker(
                        label: "Departure Time",
                        value: selectedTime.isNotEmpty ? TimeOfDay.fromDateTime(DateTime.parse("2024-01-01 $selectedTime:00")) : TimeOfDay.now(),
                        onChanged: (value) {
                          selectedTime = value!.kkmm;
                          setState(() {});
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spSm),
                QButton(
                  label: "Search Routes",
                  size: bs.md,
                  onPressed: () {
                    ss("Routes found!");
                  },
                ),
              ],
            ),
          ),

          // Available Routes
          Text(
            "Available Routes",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          ...routes.map((route) {
            bool isSelected = selectedRoute == route["id"];
            return Container(
              margin: EdgeInsets.only(bottom: spSm),
              child: GestureDetector(
                onTap: () {
                  selectedRoute = "${route["id"]}";
                  setState(() {});
                },
                child: Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: isSelected ? primaryColor.withAlpha(20) : Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                    border: Border.all(
                      color: isSelected ? primaryColor : disabledOutlineBorderColor,
                      width: isSelected ? 2 : 1,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: EdgeInsets.all(spXs),
                            decoration: BoxDecoration(
                              color: route["color"] as Color,
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Icon(
                              route["type"] == "Bus" ? Icons.directions_bus :
                              route["type"] == "Train" ? Icons.train :
                              route["type"] == "Metro" ? Icons.subway : Icons.tram,
                              color: Colors.white,
                              size: 20,
                            ),
                          ),
                          SizedBox(width: spSm),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${route["number"]}",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: isSelected ? primaryColor : disabledBoldColor,
                                  ),
                                ),
                                Text(
                                  "${route["type"]} Line",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                "${(route["price"] as double).currency}",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: isSelected ? primaryColor : disabledBoldColor,
                                ),
                              ),
                              Text(
                                "${route["duration"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: spSm),
                      Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: Colors.grey[50],
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Icon(Icons.location_on, color: successColor, size: 16),
                                SizedBox(width: spXs),
                                Text(
                                  "${route["from"]}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: spXs),
                            Row(
                              children: [
                                Icon(Icons.flag, color: dangerColor, size: 16),
                                SizedBox(width: spXs),
                                Text(
                                  "${route["to"]}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: spSm),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Next: ${route["nextDeparture"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: primaryColor,
                                ),
                              ),
                              Text(
                                "${route["frequency"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                "${route["stops"]} stops",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                              if (route["accessibility"] == true) ...[
                                SizedBox(width: spSm),
                                Icon(
                                  Icons.accessible,
                                  color: successColor,
                                  size: 16,
                                ),
                              ],
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          }).toList(),

          // Ticket Type Selection
          if (selectedRoute.isNotEmpty) ...[
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Select Ticket Type",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spSm),
                  ...ticketTypes.map((ticket) {
                    bool isSelected = selectedTicketType == ticket["name"];
                    return Container(
                      margin: EdgeInsets.only(bottom: spXs),
                      child: GestureDetector(
                        onTap: () {
                          selectedTicketType = "${ticket["name"]}";
                          setState(() {});
                        },
                        child: Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: isSelected ? primaryColor.withAlpha(20) : Colors.grey[50],
                            borderRadius: BorderRadius.circular(radiusSm),
                            border: Border.all(
                              color: isSelected ? primaryColor : disabledOutlineBorderColor,
                              width: isSelected ? 2 : 1,
                            ),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "${ticket["name"]}",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        color: isSelected ? primaryColor : disabledBoldColor,
                                      ),
                                    ),
                                    Text(
                                      "${ticket["description"]}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                    Text(
                                      "Valid for ${ticket["validity"]}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Text(
                                "${((ticket["multiplier"] as double) * 4.50).currency}",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: isSelected ? primaryColor : disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                  SizedBox(height: spSm),
                  QButton(
                    label: "Buy Ticket",
                    size: bs.md,
                    onPressed: () {
                      ss("Ticket purchased successfully!");
                    },
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildTicketsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Active Tickets
          Text(
            "Active Tickets",
            style: TextStyle(
              fontSize: fsH5,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          ...tickets.where((ticket) => ticket["status"] == "Active").map((ticket) {
            return Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
                border: Border.all(
                  color: successColor,
                  width: 2,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                        decoration: BoxDecoration(
                          color: successColor,
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Text(
                          "${ticket["status"]}",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Spacer(),
                      Text(
                        "${(ticket["price"] as double).currency}",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "${ticket["type"]}",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Text(
                    "${ticket["route"]}",
                    style: TextStyle(
                      fontSize: 14,
                      color: disabledBoldColor,
                    ),
                  ),
                  SizedBox(height: spSm),
                  Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: Colors.grey[50],
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Icon(Icons.location_on, color: successColor, size: 16),
                            SizedBox(width: spXs),
                            Text(
                              "${ticket["from"]}",
                              style: TextStyle(
                                fontSize: 14,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: spXs),
                        Row(
                          children: [
                            Icon(Icons.flag, color: dangerColor, size: 16),
                            SizedBox(width: spXs),
                            Text(
                              "${ticket["to"]}",
                              style: TextStyle(
                                fontSize: 14,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: spSm),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Travel: ${ticket["date"]} ${ticket["time"]}",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              "Valid until: ${DateTime.parse(ticket["validUntil"].toString()).dMMMy}",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.qr_code,
                              size: 30,
                              color: disabledBoldColor,
                            ),
                            Text(
                              "QR Code",
                              style: TextStyle(
                                fontSize: 8,
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
          }).toList(),

          // Recent Tickets
          Text(
            "Recent Tickets",
            style: TextStyle(
              fontSize: fsH5,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          ...tickets.where((ticket) => ticket["status"] != "Active").map((ticket) {
            return Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                        decoration: BoxDecoration(
                          color: disabledBoldColor,
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Text(
                          "${ticket["status"]}",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Spacer(),
                      Text(
                        "${(ticket["price"] as double).currency}",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "${ticket["type"]}",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: disabledBoldColor,
                    ),
                  ),
                  Text(
                    "${ticket["route"]}",
                    style: TextStyle(
                      fontSize: 14,
                      color: disabledBoldColor,
                    ),
                  ),
                  SizedBox(height: spXs),
                  Text(
                    "Used on: ${ticket["date"]}",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildLiveMapTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Service Alerts
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Service Alerts",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spSm),
                ...alerts.map((alert) {
                  Color alertColor = alert["severity"] == "high" ? dangerColor :
                                   alert["severity"] == "medium" ? warningColor : infoColor;
                  return Container(
                    margin: EdgeInsets.only(bottom: spXs),
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: alertColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusSm),
                      border: Border.all(
                        color: alertColor,
                        width: 1,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                              decoration: BoxDecoration(
                                color: alertColor,
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Text(
                                "${alert["type"]}",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            SizedBox(width: spSm),
                            Text(
                              "${alert["route"]}",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: primaryColor,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "${alert["message"]}",
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                          ),
                        ),
                        Text(
                          "Affected: ${alert["affected"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ],
            ),
          ),

          // Live Route Status
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Live Route Status",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spSm),
                ...routes.map((route) {
                  return Container(
                    margin: EdgeInsets.only(bottom: spSm),
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: Colors.grey[50],
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(spXs),
                          decoration: BoxDecoration(
                            color: route["color"] as Color,
                            borderRadius: BorderRadius.circular(radiusLg),
                          ),
                          child: Icon(
                            route["type"] == "Bus" ? Icons.directions_bus :
                            route["type"] == "Train" ? Icons.train :
                            route["type"] == "Metro" ? Icons.subway : Icons.tram,
                            color: Colors.white,
                            size: 16,
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${route["number"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: primaryColor,
                                ),
                              ),
                              Text(
                                "${route["from"]} → ${route["to"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                              decoration: BoxDecoration(
                                color: successColor,
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Text(
                                "On Time",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Text(
                              "Next: ${route["nextDeparture"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
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

          // Map View Placeholder
          Container(
            height: 300,
            padding: EdgeInsets.all(spLg),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(radiusMd),
              border: Border.all(
                color: disabledOutlineBorderColor,
                style: BorderStyle.solid,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.map,
                  size: 64,
                  color: disabledBoldColor,
                ),
                SizedBox(height: spMd),
                Text(
                  "Live Transit Map",
                  style: TextStyle(
                    fontSize: fsH5,
                    fontWeight: FontWeight.bold,
                    color: disabledBoldColor,
                  ),
                ),
                Text(
                  "Real-time vehicle locations and route information",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHistoryTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Travel Statistics
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Travel Statistics",
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
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: primaryColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Column(
                          children: [
                            Text(
                              "${travelHistory.length}",
                              style: TextStyle(
                                fontSize: fsH4,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              "Total Trips",
                              style: TextStyle(
                                fontSize: 12,
                                color: primaryColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: successColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Column(
                          children: [
                            Text(
                              "${((travelHistory.fold(0.0, (sum, trip) => sum + (trip["price"] as double)))).currency}",
                              style: TextStyle(
                                fontSize: fsH4,
                                fontWeight: FontWeight.bold,
                                color: successColor,
                              ),
                            ),
                            Text(
                              "Total Spent",
                              style: TextStyle(
                                fontSize: 12,
                                color: successColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Recent Trips
          Text(
            "Recent Trips",
            style: TextStyle(
              fontSize: fsH5,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          ...travelHistory.map((trip) {
            return Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(spXs),
                        decoration: BoxDecoration(
                          color: trip["type"] == "Bus" ? primaryColor :
                                trip["type"] == "Train" ? infoColor :
                                trip["type"] == "Metro" ? successColor : warningColor,
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Icon(
                          trip["type"] == "Bus" ? Icons.directions_bus :
                          trip["type"] == "Train" ? Icons.train :
                          trip["type"] == "Metro" ? Icons.subway : Icons.tram,
                          color: Colors.white,
                          size: 16,
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${trip["route"]}",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              "${trip["type"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        "${(trip["price"] as double).currency}",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: Colors.grey[50],
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Icon(Icons.location_on, color: successColor, size: 16),
                            SizedBox(width: spXs),
                            Text(
                              "${trip["from"]}",
                              style: TextStyle(
                                fontSize: 14,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: spXs),
                        Row(
                          children: [
                            Icon(Icons.flag, color: dangerColor, size: 16),
                            SizedBox(width: spXs),
                            Text(
                              "${trip["to"]}",
                              style: TextStyle(
                                fontSize: 14,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: spSm),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "${trip["date"]} ${trip["time"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                      Text(
                        "Duration: ${trip["duration"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
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
    );
  }
}
