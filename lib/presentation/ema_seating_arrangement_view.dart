import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class EmaSeatingArrangementView extends StatefulWidget {
  const EmaSeatingArrangementView({super.key});

  @override
  State<EmaSeatingArrangementView> createState() => _EmaSeatingArrangementViewState();
}

class _EmaSeatingArrangementViewState extends State<EmaSeatingArrangementView> {
  String selectedFloor = "1";
  String selectedSection = "";
  List<String> selectedSeats = [];
  String eventName = "Grand Concert 2025";
  String venue = "Madison Square Garden";
  
  List<Map<String, dynamic>> floors = [
    {"label": "Floor 1", "value": "1"},
    {"label": "Floor 2", "value": "2"},
    {"label": "Floor 3", "value": "3"},
  ];

  List<Map<String, dynamic>> sections = [
    {
      "id": "A",
      "name": "Section A - VIP",
      "rows": 10,
      "seatsPerRow": 12,
      "price": 250.0,
      "available": 89,
      "total": 120,
    },
    {
      "id": "B", 
      "name": "Section B - Premium",
      "rows": 15,
      "seatsPerRow": 14,
      "price": 180.0,
      "available": 156,
      "total": 210,
    },
    {
      "id": "C",
      "name": "Section C - Regular",
      "rows": 20,
      "seatsPerRow": 16,
      "price": 120.0,
      "available": 245,
      "total": 320,
    },
    {
      "id": "D",
      "name": "Section D - Economy",
      "rows": 25,
      "seatsPerRow": 18,
      "price": 80.0,
      "available": 298,
      "total": 450,
    },
  ];

  List<Map<String, dynamic>> getSeatsForSection(String sectionId) {
    final section = sections.firstWhere((s) => s["id"] == sectionId);
    List<Map<String, dynamic>> seats = [];
    
    for (int row = 1; row <= (section["rows"] as int); row++) {
      for (int seat = 1; seat <= (section["seatsPerRow"] as int); seat++) {
        String seatId = "$sectionId-R$row-S$seat";
        bool isOccupied = (row * seat) % 7 == 0; // Mock occupied seats
        bool isSelected = selectedSeats.contains(seatId);
        
        seats.add({
          "id": seatId,
          "row": row,
          "seat": seat,
          "isOccupied": isOccupied,
          "isSelected": isSelected,
          "price": section["price"],
        });
      }
    }
    
    return seats;
  }

  Color getSeatColor(Map<String, dynamic> seat) {
    if (seat["isOccupied"]) return disabledColor;
    if (seat["isSelected"]) return primaryColor;
    return successColor;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Seating Arrangement"),
        actions: [
          if (selectedSeats.isNotEmpty)
            QButton(
              icon: Icons.shopping_cart,
              size: bs.sm,
              onPressed: () {
                //navigateTo('EmaTicketBookingView')
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
            // Event Info
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: primaryColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusMd),
                border: Border.all(color: primaryColor.withAlpha(50)),
              ),
              child: Column(
                spacing: spXs,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    eventName,
                    style: TextStyle(
                      fontSize: fsH5,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Row(
                    children: [
                      Icon(Icons.location_on, size: 16, color: disabledBoldColor),
                      SizedBox(width: spXs),
                      Text(
                        venue,
                        style: TextStyle(
                          color: disabledBoldColor,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Floor Selection
            QDropdownField(
              label: "Select Floor",
              items: floors,
              value: selectedFloor,
              onChanged: (value, label) {
                selectedFloor = value;
                selectedSection = "";
                selectedSeats.clear();
                setState(() {});
              },
            ),

            // Legend
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.grey.shade50,
                borderRadius: BorderRadius.circular(radiusSm),
                border: Border.all(color: disabledOutlineBorderColor),
              ),
              child: Column(
                spacing: spXs,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Legend",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                  ),
                  Row(
                    spacing: spMd,
                    children: [
                      Row(
                        spacing: spXs,
                        children: [
                          Container(
                            width: 16,
                            height: 16,
                            decoration: BoxDecoration(
                              color: successColor,
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                          ),
                          Text("Available", style: TextStyle(fontSize: 12)),
                        ],
                      ),
                      Row(
                        spacing: spXs,
                        children: [
                          Container(
                            width: 16,
                            height: 16,
                            decoration: BoxDecoration(
                              color: primaryColor,
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                          ),
                          Text("Selected", style: TextStyle(fontSize: 12)),
                        ],
                      ),
                      Row(
                        spacing: spXs,
                        children: [
                          Container(
                            width: 16,
                            height: 16,
                            decoration: BoxDecoration(
                              color: disabledColor,
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                          ),
                          Text("Occupied", style: TextStyle(fontSize: 12)),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Sections Grid
            Text(
              "Sections",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
              ),
            ),
            
            ResponsiveGridView(
              padding: EdgeInsets.zero,
              minItemWidth: 200,
              children: sections.map((section) {
                bool isSelected = selectedSection == section["id"];
                return GestureDetector(
                  onTap: () {
                    selectedSection = section["id"];
                    setState(() {});
                  },
                  child: Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: isSelected ? primaryColor.withAlpha(20) : Colors.white,
                      borderRadius: BorderRadius.circular(radiusSm),
                      border: Border.all(
                        color: isSelected ? primaryColor : disabledOutlineBorderColor,
                        width: isSelected ? 2 : 1,
                      ),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      spacing: spXs,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${section["name"]}",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: isSelected ? primaryColor : Colors.black87,
                          ),
                        ),
                        Text(
                          "\$${(section["price"] as double).currency}",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Row(
                          spacing: spSm,
                          children: [
                            Expanded(
                              child: Text(
                                "${section["available"]}/${section["total"]} available",
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
                );
              }).toList(),
            ),

            // Seat Map
            if (selectedSection.isNotEmpty) ...[
              Text(
                "Select Seats - ${sections.firstWhere((s) => s["id"] == selectedSection)["name"]}",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                ),
              ),
              
              // Stage
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: spSm),
                margin: EdgeInsets.only(bottom: spMd),
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Text(
                  "STAGE",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: disabledBoldColor,
                  ),
                ),
              ),

              // Seats Grid
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.grey.shade50,
                  borderRadius: BorderRadius.circular(radiusSm),
                  border: Border.all(color: disabledOutlineBorderColor),
                ),
                child: Builder(
                  builder: (context) {
                    final sectionData = sections.firstWhere((s) => s["id"] == selectedSection);
                    final seats = getSeatsForSection(selectedSection);
                    final rows = sectionData["rows"] as int;
                    final seatsPerRow = sectionData["seatsPerRow"] as int;
                    
                    return Column(
                      spacing: spXxs,
                      children: List.generate(rows, (rowIndex) {
                        int row = rowIndex + 1;
                        return Row(
                          spacing: spXxs,
                          children: [
                            // Row label
                            Container(
                              width: 30,
                              child: Text(
                                "R$row",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ),
                            // Seats
                            ...List.generate(seatsPerRow, (seatIndex) {
                              int seatNumber = seatIndex + 1;
                              final seat = seats.firstWhere((s) => 
                                s["row"] == row && s["seat"] == seatNumber);
                              
                              return GestureDetector(
                                onTap: () {
                                  if (!(seat["isOccupied"] as bool)) {
                                    String seatId = seat["id"];
                                    if (selectedSeats.contains(seatId)) {
                                      selectedSeats.remove(seatId);
                                    } else {
                                      selectedSeats.add(seatId);
                                    }
                                    setState(() {});
                                  }
                                },
                                child: Container(
                                  width: 20,
                                  height: 20,
                                  decoration: BoxDecoration(
                                    color: getSeatColor(seat),
                                    borderRadius: BorderRadius.circular(radiusXs),
                                    border: Border.all(
                                      color: (seat["isSelected"] as bool) 
                                        ? primaryColor 
                                        : Colors.transparent,
                                      width: 2,
                                    ),
                                  ),
                                  child: Center(
                                    child: Text(
                                      "$seatNumber",
                                      style: TextStyle(
                                        fontSize: 8,
                                        fontWeight: FontWeight.w600,
                                        color: (seat["isOccupied"] as bool) 
                                          ? disabledBoldColor 
                                          : Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            }),
                          ],
                        );
                      }),
                    );
                  },
                ),
              ),
            ],

            // Selected Seats Summary
            if (selectedSeats.isNotEmpty) ...[
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Selected Seats (${selectedSeats.length})",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      selectedSeats.join(", "),
                      style: TextStyle(
                        color: disabledBoldColor,
                        fontSize: 14,
                      ),
                    ),
                    Divider(color: primaryColor.withAlpha(30)),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            "Total: \$${(selectedSeats.length * (sections.firstWhere((s) => s["id"] == selectedSection)["price"] as double)).currency}",
                            style: TextStyle(
                              fontSize: fsH5,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                        ),
                        QButton(
                          label: "Book Now",
                          size: bs.sm,
                          onPressed: () {
                            //navigateTo('EmaTicketBookingView')
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
