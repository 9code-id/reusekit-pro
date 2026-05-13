import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class EmaTicketView extends StatefulWidget {
  const EmaTicketView({super.key});

  @override
  State<EmaTicketView> createState() => _EmaTicketViewState();
}

class _EmaTicketViewState extends State<EmaTicketView> {
  String selectedFilter = "all";
  String searchQuery = "";
  
  List<Map<String, dynamic>> filterOptions = [
    {"label": "All Tickets", "value": "all"},
    {"label": "Upcoming", "value": "upcoming"},
    {"label": "Past Events", "value": "past"},
    {"label": "Cancelled", "value": "cancelled"},
  ];

  List<Map<String, dynamic>> tickets = [
    {
      "id": "TKT-001",
      "eventName": "Grand Concert 2025",
      "venue": "Madison Square Garden",
      "date": "2025-07-15",
      "time": "19:30",
      "section": "VIP Section A",
      "seats": ["A-R5-S12", "A-R5-S13"],
      "price": 250.0,
      "totalAmount": 500.0,
      "status": "confirmed",
      "qrCode": "https://picsum.photos/150/150?random=1",
      "eventImage": "https://picsum.photos/300/200?random=1&keyword=concert",
      "category": "Music",
      "duration": "3 hours",
      "artists": ["The Beatles Revival", "Symphony Orchestra"],
    },
    {
      "id": "TKT-002",
      "eventName": "Broadway Musical Night",
      "venue": "Broadway Theater",
      "date": "2025-06-28",
      "time": "20:00",
      "section": "Premium Section B",
      "seats": ["B-R8-S15"],
      "price": 180.0,
      "totalAmount": 180.0,
      "status": "confirmed",
      "qrCode": "https://picsum.photos/150/150?random=2",
      "eventImage": "https://picsum.photos/300/200?random=2&keyword=theater",
      "category": "Theater",
      "duration": "2.5 hours",
      "artists": ["Broadway Cast"],
    },
    {
      "id": "TKT-003",
      "eventName": "Comedy Show Live",
      "venue": "Comedy Club Central",
      "date": "2025-05-10",
      "time": "21:00",
      "section": "Regular Section C",
      "seats": ["C-R12-S8", "C-R12-S9"],
      "price": 120.0,
      "totalAmount": 240.0,
      "status": "used",
      "qrCode": "https://picsum.photos/150/150?random=3",
      "eventImage": "https://picsum.photos/300/200?random=3&keyword=comedy",
      "category": "Comedy",
      "duration": "2 hours",
      "artists": ["Stand-up Comedians"],
    },
    {
      "id": "TKT-004",
      "eventName": "Jazz Festival 2025",
      "venue": "Central Park Amphitheater",
      "date": "2025-08-22",
      "time": "18:00",
      "section": "Economy Section D",
      "seats": ["D-R20-S25"],
      "price": 80.0,
      "totalAmount": 80.0,
      "status": "confirmed",
      "qrCode": "https://picsum.photos/150/150?random=4",
      "eventImage": "https://picsum.photos/300/200?random=4&keyword=jazz",
      "category": "Music",
      "duration": "4 hours",
      "artists": ["Jazz Masters", "Local Artists"],
    },
    {
      "id": "TKT-005",
      "eventName": "Sports Championship",
      "venue": "Arena Stadium",
      "date": "2025-03-15",
      "time": "15:00",
      "section": "Premium Section A",
      "seats": ["A-R3-S5", "A-R3-S6"],
      "price": 200.0,
      "totalAmount": 400.0,
      "status": "cancelled",
      "qrCode": "https://picsum.photos/150/150?random=5",
      "eventImage": "https://picsum.photos/300/200?random=5&keyword=sports",
      "category": "Sports",
      "duration": "3 hours",
      "artists": ["Championship Teams"],
    },
  ];

  List<Map<String, dynamic>> getFilteredTickets() {
    var filtered = tickets.where((ticket) {
      bool matchesFilter = true;
      
      if (selectedFilter != "all") {
        switch (selectedFilter) {
          case "upcoming":
            matchesFilter = ticket["status"] == "confirmed" && 
                           DateTime.parse("${ticket["date"]}").isAfter(DateTime.now());
            break;
          case "past":
            matchesFilter = ticket["status"] == "used" || 
                           (ticket["status"] == "confirmed" && 
                            DateTime.parse("${ticket["date"]}").isBefore(DateTime.now()));
            break;
          case "cancelled":
            matchesFilter = ticket["status"] == "cancelled";
            break;
        }
      }
      
      bool matchesSearch = searchQuery.isEmpty ||
          (ticket["eventName"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
          (ticket["venue"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
          (ticket["category"] as String).toLowerCase().contains(searchQuery.toLowerCase());
      
      return matchesFilter && matchesSearch;
    }).toList();
    
    // Sort by date
    filtered.sort((a, b) => DateTime.parse("${b["date"]}").compareTo(DateTime.parse("${a["date"]}")));
    
    return filtered;
  }

  Color getStatusColor(String status) {
    switch (status) {
      case "confirmed":
        return successColor;
      case "used":
        return infoColor;
      case "cancelled":
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  String getStatusText(String status) {
    switch (status) {
      case "confirmed":
        return "Confirmed";
      case "used":
        return "Used";
      case "cancelled":
        return "Cancelled";
      default:
        return "Unknown";
    }
  }

  @override
  Widget build(BuildContext context) {
    final filteredTickets = getFilteredTickets();

    return Scaffold(
      appBar: AppBar(
        title: Text("My Tickets"),
        actions: [
          QButton(
            icon: Icons.qr_code_scanner,
            size: bs.sm,
            onPressed: () {
              //navigateTo('QRScannerView')
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search
            QTextField(
              label: "Search tickets...",
              value: searchQuery,
              hint: "Search by event, venue, or category",
              onChanged: (value) {
                searchQuery = value;
                setState(() {});
              },
            ),

            // Filter
            QCategoryPicker(
              label: "Filter Tickets",
              items: filterOptions,
              value: selectedFilter,
              onChanged: (index, label, value, item) {
                selectedFilter = value;
                setState(() {});
              },
            ),

            // Summary Stats
            if (filteredTickets.isNotEmpty) ...[
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: primaryColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusMd),
                  border: Border.all(color: primaryColor.withAlpha(50)),
                ),
                child: Column(
                  spacing: spSm,
                  children: [
                    Text(
                      "Ticket Summary",
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
                        Column(
                          children: [
                            Text(
                              "${filteredTickets.length}",
                              style: TextStyle(
                                fontSize: fsH4,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              "Total Tickets",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Text(
                              "\$${filteredTickets.fold(0.0, (sum, ticket) => sum + (ticket["totalAmount"] as double)).currency}",
                              style: TextStyle(
                                fontSize: fsH4,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              "Total Value",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],

            // Tickets List
            if (filteredTickets.isEmpty) ...[
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(sp2xl),
                child: Column(
                  spacing: spMd,
                  children: [
                    Icon(
                      Icons.confirmation_number,
                      size: 64,
                      color: disabledBoldColor,
                    ),
                    Text(
                      "No tickets found",
                      style: TextStyle(
                        fontSize: fsH5,
                        fontWeight: FontWeight.w600,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "Try adjusting your search or filter criteria",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: disabledBoldColor,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ] else ...[
              Text(
                "Tickets (${filteredTickets.length})",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                ),
              ),

              ...filteredTickets.map((ticket) {
                DateTime eventDate = DateTime.parse("${ticket["date"]}");
                bool isUpcoming = eventDate.isAfter(DateTime.now()) && ticket["status"] == "confirmed";
                
                return Container(
                  margin: EdgeInsets.only(bottom: spSm),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    border: Border.all(color: disabledOutlineBorderColor),
                    boxShadow: [shadowMd],
                  ),
                  child: Column(
                    children: [
                      // Ticket Header
                      Container(
                        padding: EdgeInsets.all(spMd),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade50,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(radiusMd),
                            topRight: Radius.circular(radiusMd),
                          ),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                spacing: spXs,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${ticket["id"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                  Text(
                                    "${ticket["eventName"]}",
                                    style: TextStyle(
                                      fontSize: fsH6,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: spSm,
                                vertical: spXs,
                              ),
                              decoration: BoxDecoration(
                                color: getStatusColor(ticket["status"]),
                                borderRadius: BorderRadius.circular(radiusLg),
                              ),
                              child: Text(
                                getStatusText(ticket["status"]),
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Ticket Content
                      Padding(
                        padding: EdgeInsets.all(spMd),
                        child: Row(
                          spacing: spMd,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Event Image
                            ClipRRect(
                              borderRadius: BorderRadius.circular(radiusSm),
                              child: Image.network(
                                "${ticket["eventImage"]}",
                                width: 80,
                                height: 80,
                                fit: BoxFit.cover,
                              ),
                            ),

                            // Event Details
                            Expanded(
                              child: Column(
                                spacing: spXs,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Icon(Icons.location_on, size: 16, color: disabledBoldColor),
                                      SizedBox(width: spXs),
                                      Expanded(
                                        child: Text(
                                          "${ticket["venue"]}",
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: disabledBoldColor,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Icon(Icons.event, size: 16, color: disabledBoldColor),
                                      SizedBox(width: spXs),
                                      Text(
                                        "${DateTime.parse("${ticket["date"]}").dMMMy} at ${ticket["time"]}",
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Icon(Icons.event_seat, size: 16, color: disabledBoldColor),
                                      SizedBox(width: spXs),
                                      Expanded(
                                        child: Text(
                                          "${ticket["section"]} - ${(ticket["seats"] as List).join(", ")}",
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: disabledBoldColor,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Icon(Icons.category, size: 16, color: disabledBoldColor),
                                      SizedBox(width: spXs),
                                      Text(
                                        "${ticket["category"]} • ${ticket["duration"]}",
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    "Total: \$${(ticket["totalAmount"] as double).currency}",
                                    style: TextStyle(
                                      fontSize: fsH6,
                                      fontWeight: FontWeight.bold,
                                      color: primaryColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            // QR Code
                            if (ticket["status"] == "confirmed") ...[
                              Container(
                                width: 60,
                                height: 60,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(radiusSm),
                                  border: Border.all(color: disabledOutlineBorderColor),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(radiusSm),
                                  child: Image.network(
                                    "${ticket["qrCode"]}",
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ],
                          ],
                        ),
                      ),

                      // Actions
                      Container(
                        padding: EdgeInsets.all(spMd),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade50,
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(radiusMd),
                            bottomRight: Radius.circular(radiusMd),
                          ),
                        ),
                        child: Row(
                          spacing: spSm,
                          children: [
                            Expanded(
                              child: QButton(
                                label: "View Details",
                                size: bs.sm,
                                onPressed: () {
                                  //navigateTo('TicketDetailView')
                                },
                              ),
                            ),
                            if (isUpcoming) ...[
                              QButton(
                                icon: Icons.share,
                                size: bs.sm,
                                onPressed: () {
                                  ss("Ticket shared successfully");
                                },
                              ),
                              QButton(
                                icon: Icons.download,
                                size: bs.sm,
                                onPressed: () {
                                  ss("Ticket downloaded successfully");
                                },
                              ),
                            ],
                            if (ticket["status"] == "confirmed" && isUpcoming) ...[
                              QButton(
                                icon: Icons.cancel,
                                size: bs.sm,
                                onPressed: () async {
                                  bool isConfirmed = await confirm("Are you sure you want to cancel this ticket?");
                                  if (isConfirmed) {
                                    ticket["status"] = "cancelled";
                                    setState(() {});
                                    ss("Ticket cancelled successfully");
                                  }
                                },
                              ),
                            ],
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }),
            ],
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          //navigateTo('EventListView')
        },
        backgroundColor: primaryColor,
        child: Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
