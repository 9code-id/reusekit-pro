import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class EcmSeatingArrangementView extends StatefulWidget {
  const EcmSeatingArrangementView({super.key});

  @override
  State<EcmSeatingArrangementView> createState() => _EcmSeatingArrangementViewState();
}

class _EcmSeatingArrangementViewState extends State<EcmSeatingArrangementView> {
  String selectedLayout = "Theater";
  int totalSeats = 200;
  int rows = 10;
  int seatsPerRow = 20;
  bool hasVipSection = false;
  int vipSeats = 20;
  bool hasWheelchairAccess = true;
  int wheelchairSpaces = 4;
  bool hasReservedSeating = true;
  bool allowSeatSelection = true;
  String pricingStructure = "Single Price";
  double standardPrice = 50.0;
  double vipPrice = 100.0;
  double frontRowPrice = 75.0;
  bool enableSeatMap = true;
  String selectedSeat = "";
  List<String> blockedSeats = [];
  List<String> reservedSeats = [];
  List<String> vipSeatIds = [];
  String seatNumbering = "Letters-Numbers";
  bool enableGroupBooking = true;
  int maxGroupSize = 10;
  String emergencyExits = "";
  String specialRequirements = "";
  
  List<Map<String, dynamic>> layoutItems = [
    {"label": "Theater Style", "value": "Theater"},
    {"label": "Classroom Style", "value": "Classroom"},
    {"label": "Banquet Rounds", "value": "Banquet"},
    {"label": "U-Shape", "value": "U-Shape"},
    {"label": "Boardroom", "value": "Boardroom"},
    {"label": "Conference Style", "value": "Conference"},
    {"label": "Standing Reception", "value": "Standing"},
    {"label": "Custom Layout", "value": "Custom"},
  ];

  List<Map<String, dynamic>> pricingItems = [
    {"label": "Single Price", "value": "Single Price"},
    {"label": "Zone-based Pricing", "value": "Zone-based"},
    {"label": "Distance-based Pricing", "value": "Distance-based"},
    {"label": "VIP and Standard", "value": "VIP and Standard"},
  ];

  List<Map<String, dynamic>> numberingItems = [
    {"label": "Letters-Numbers (A1, A2, B1)", "value": "Letters-Numbers"},
    {"label": "Numbers Only (1, 2, 3)", "value": "Numbers Only"},
    {"label": "Row-Seat (R1S1, R1S2)", "value": "Row-Seat"},
    {"label": "Section-Row-Seat", "value": "Section-Row-Seat"},
  ];

  // Mock seating data for visualization
  List<List<Map<String, dynamic>>> seatingData = [];

  @override
  void initState() {
    super.initState();
    _generateSeatingData();
  }

  void _generateSeatingData() {
    seatingData.clear();
    for (int row = 0; row < rows; row++) {
      List<Map<String, dynamic>> rowData = [];
      for (int seat = 0; seat < seatsPerRow; seat++) {
        String seatId = "${String.fromCharCode(65 + row)}${seat + 1}";
        rowData.add({
          "id": seatId,
          "row": row,
          "seat": seat,
          "status": "available", // available, occupied, blocked, vip, wheelchair
          "price": _getSeatPrice(row, seat),
        });
      }
      seatingData.add(rowData);
    }
    setState(() {});
  }

  double _getSeatPrice(int row, int seat) {
    if (pricingStructure == "Single Price") return standardPrice;
    if (pricingStructure == "VIP and Standard") {
      if (row < 3) return vipPrice; // First 3 rows are VIP
      return standardPrice;
    }
    if (pricingStructure == "Distance-based") {
      if (row < 3) return frontRowPrice;
      return standardPrice;
    }
    return standardPrice;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Seating Arrangement"),
        actions: [
          QButton(
            label: "Save",
            size: bs.sm,
            onPressed: () => _saveSeatingArrangement(),
          ),
          SizedBox(width: spSm),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            _buildLayoutSection(),
            _buildCapacitySection(),
            _buildAccessibilitySection(),
            _buildPricingSection(),
            _buildSeatingMapSection(),
            _buildBookingSection(),
            _buildAdditionalSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildLayoutSection() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Row(
            children: [
              Icon(
                Icons.event_seat,
                color: primaryColor,
                size: 20,
              ),
              SizedBox(width: spSm),
              Text(
                "Layout Configuration",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          QDropdownField(
            label: "Seating Layout Style",
            items: layoutItems,
            value: selectedLayout,
            onChanged: (value, label) {
              selectedLayout = value;
              _generateSeatingData();
            },
          ),
          if (selectedLayout == "Theater" || selectedLayout == "Classroom") ...[
            Row(
              spacing: spSm,
              children: [
                Expanded(
                  child: QNumberField(
                    label: "Number of Rows",
                    value: rows.toString(),
                    validator: Validator.required,
                    onChanged: (value) {
                      rows = int.tryParse("$value") ?? 10;
                      totalSeats = rows * seatsPerRow;
                      _generateSeatingData();
                    },
                  ),
                ),
                Expanded(
                  child: QNumberField(
                    label: "Seats per Row",
                    value: seatsPerRow.toString(),
                    validator: Validator.required,
                    onChanged: (value) {
                      seatsPerRow = int.tryParse("$value") ?? 20;
                      totalSeats = rows * seatsPerRow;
                      _generateSeatingData();
                    },
                  ),
                ),
              ],
            ),
          ],
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(10),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.info_outline,
                  color: primaryColor,
                  size: 16,
                ),
                SizedBox(width: spSm),
                Text(
                  "Total Capacity: $totalSeats seats",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCapacitySection() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Row(
            children: [
              Icon(
                Icons.groups,
                color: primaryColor,
                size: 20,
              ),
              SizedBox(width: spSm),
              Text(
                "Seating Sections",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          QSwitch(
            items: [
              {
                "label": "Include VIP Section",
                "value": true,
                "checked": hasVipSection,
              }
            ],
            value: [if (hasVipSection) {"label": "Include VIP Section", "value": true, "checked": true}],
            onChanged: (values, ids) {
              setState(() {
                hasVipSection = values.isNotEmpty;
              });
            },
          ),
          if (hasVipSection)
            QNumberField(
              label: "VIP Seats Count",
              value: vipSeats.toString(),
              onChanged: (value) {
                vipSeats = int.tryParse("$value") ?? 20;
                setState(() {});
              },
            ),
          QDropdownField(
            label: "Seat Numbering System",
            items: numberingItems,
            value: seatNumbering,
            onChanged: (value, label) {
              seatNumbering = value;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  Widget _buildAccessibilitySection() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Row(
            children: [
              Icon(
                Icons.accessible,
                color: primaryColor,
                size: 20,
              ),
              SizedBox(width: spSm),
              Text(
                "Accessibility & Safety",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          QSwitch(
            items: [
              {
                "label": "Wheelchair Accessible Seating",
                "value": true,
                "checked": hasWheelchairAccess,
              }
            ],
            value: [if (hasWheelchairAccess) {"label": "Wheelchair Accessible Seating", "value": true, "checked": true}],
            onChanged: (values, ids) {
              setState(() {
                hasWheelchairAccess = values.isNotEmpty;
              });
            },
          ),
          if (hasWheelchairAccess)
            QNumberField(
              label: "Wheelchair Spaces",
              value: wheelchairSpaces.toString(),
              onChanged: (value) {
                wheelchairSpaces = int.tryParse("$value") ?? 4;
                setState(() {});
              },
            ),
          QMemoField(
            label: "Emergency Exit Information",
            value: emergencyExits,
            hint: "Describe emergency exit locations and accessibility",
            onChanged: (value) {
              emergencyExits = value;
              setState(() {});
            },
          ),
          QMemoField(
            label: "Special Requirements",
            value: specialRequirements,
            hint: "Any special seating requirements or accommodations",
            onChanged: (value) {
              specialRequirements = value;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  Widget _buildPricingSection() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Row(
            children: [
              Icon(
                Icons.attach_money,
                color: primaryColor,
                size: 20,
              ),
              SizedBox(width: spSm),
              Text(
                "Seat Pricing",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          QDropdownField(
            label: "Pricing Structure",
            items: pricingItems,
            value: pricingStructure,
            onChanged: (value, label) {
              pricingStructure = value;
              _generateSeatingData();
            },
          ),
          if (pricingStructure == "Single Price")
            QNumberField(
              label: "Standard Price (\$)",
              value: standardPrice.toString(),
              validator: Validator.required,
              onChanged: (value) {
                standardPrice = double.tryParse("$value") ?? 50.0;
                _generateSeatingData();
              },
            ),
          if (pricingStructure == "VIP and Standard") ...[
            Row(
              spacing: spSm,
              children: [
                Expanded(
                  child: QNumberField(
                    label: "Standard Price (\$)",
                    value: standardPrice.toString(),
                    onChanged: (value) {
                      standardPrice = double.tryParse("$value") ?? 50.0;
                      _generateSeatingData();
                    },
                  ),
                ),
                Expanded(
                  child: QNumberField(
                    label: "VIP Price (\$)",
                    value: vipPrice.toString(),
                    onChanged: (value) {
                      vipPrice = double.tryParse("$value") ?? 100.0;
                      _generateSeatingData();
                    },
                  ),
                ),
              ],
            ),
          ],
          if (pricingStructure == "Distance-based") ...[
            Row(
              spacing: spSm,
              children: [
                Expanded(
                  child: QNumberField(
                    label: "Front Row Price (\$)",
                    value: frontRowPrice.toString(),
                    onChanged: (value) {
                      frontRowPrice = double.tryParse("$value") ?? 75.0;
                      _generateSeatingData();
                    },
                  ),
                ),
                Expanded(
                  child: QNumberField(
                    label: "Standard Price (\$)",
                    value: standardPrice.toString(),
                    onChanged: (value) {
                      standardPrice = double.tryParse("$value") ?? 50.0;
                      _generateSeatingData();
                    },
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildSeatingMapSection() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Row(
            children: [
              Icon(
                Icons.map,
                color: primaryColor,
                size: 20,
              ),
              SizedBox(width: spSm),
              Text(
                "Interactive Seating Map",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          QSwitch(
            items: [
              {
                "label": "Enable Interactive Seat Map",
                "value": true,
                "checked": enableSeatMap,
              }
            ],
            value: [if (enableSeatMap) {"label": "Enable Interactive Seat Map", "value": true, "checked": true}],
            onChanged: (values, ids) {
              setState(() {
                enableSeatMap = values.isNotEmpty;
              });
            },
          ),
          if (enableSeatMap) ...[
            Container(
              height: 300,
              decoration: BoxDecoration(
                border: Border.all(color: disabledOutlineBorderColor),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Column(
                children: [
                  // Stage indicator
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: primaryColor.withAlpha(20),
                      borderRadius: BorderRadius.vertical(top: Radius.circular(radiusSm)),
                    ),
                    child: Text(
                      "STAGE",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                        fontSize: 12,
                      ),
                    ),
                  ),
                  // Seating area
                  Expanded(
                    child: SingleChildScrollView(
                      padding: EdgeInsets.all(spSm),
                      child: Column(
                        spacing: spXs,
                        children: seatingData.map((row) {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            spacing: spXs,
                            children: row.map((seat) {
                              return _buildSeatWidget(seat);
                            }).toList(),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Legend
            Wrap(
              spacing: spSm,
              runSpacing: spXs,
              children: [
                _buildLegendItem("Available", Colors.green),
                _buildLegendItem("Selected", primaryColor),
                _buildLegendItem("Occupied", Colors.red),
                _buildLegendItem("VIP", Colors.purple),
                _buildLegendItem("Wheelchair", Colors.blue),
              ],
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildSeatWidget(Map<String, dynamic> seat) {
    Color seatColor;
    switch (seat["status"]) {
      case "available":
        seatColor = Colors.green;
        break;
      case "occupied":
        seatColor = Colors.red;
        break;
      case "blocked":
        seatColor = Colors.grey;
        break;
      case "vip":
        seatColor = Colors.purple;
        break;
      case "wheelchair":
        seatColor = Colors.blue;
        break;
      default:
        seatColor = Colors.green;
    }

    bool isSelected = selectedSeat == seat["id"];

    return GestureDetector(
      onTap: () {
        if (seat["status"] == "available") {
          selectedSeat = isSelected ? "" : seat["id"];
          setState(() {});
        }
      },
      child: Container(
        width: 20,
        height: 20,
        decoration: BoxDecoration(
          color: isSelected ? primaryColor : seatColor,
          borderRadius: BorderRadius.circular(radiusXs),
          border: Border.all(
            color: isSelected ? primaryColor : seatColor.withAlpha(100),
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Center(
          child: Text(
            "${seat["id"]}",
            style: TextStyle(
              fontSize: 8,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLegendItem(String label, Color color) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(radiusXs),
          ),
        ),
        SizedBox(width: spXs),
        Text(
          label,
          style: TextStyle(
            fontSize: 11,
            color: disabledBoldColor,
          ),
        ),
      ],
    );
  }

  Widget _buildBookingSection() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Row(
            children: [
              Icon(
                Icons.book_online,
                color: primaryColor,
                size: 20,
              ),
              SizedBox(width: spSm),
              Text(
                "Booking Configuration",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          QSwitch(
            items: [
              {
                "label": "Allow Seat Selection",
                "value": true,
                "checked": allowSeatSelection,
              }
            ],
            value: [if (allowSeatSelection) {"label": "Allow Seat Selection", "value": true, "checked": true}],
            onChanged: (values, ids) {
              setState(() {
                allowSeatSelection = values.isNotEmpty;
              });
            },
          ),
          QSwitch(
            items: [
              {
                "label": "Enable Reserved Seating",
                "value": true,
                "checked": hasReservedSeating,
              }
            ],
            value: [if (hasReservedSeating) {"label": "Enable Reserved Seating", "value": true, "checked": true}],
            onChanged: (values, ids) {
              setState(() {
                hasReservedSeating = values.isNotEmpty;
              });
            },
          ),
          QSwitch(
            items: [
              {
                "label": "Enable Group Booking",
                "value": true,
                "checked": enableGroupBooking,
              }
            ],
            value: [if (enableGroupBooking) {"label": "Enable Group Booking", "value": true, "checked": true}],
            onChanged: (values, ids) {
              setState(() {
                enableGroupBooking = values.isNotEmpty;
              });
            },
          ),
          if (enableGroupBooking)
            QNumberField(
              label: "Maximum Group Size",
              value: maxGroupSize.toString(),
              onChanged: (value) {
                maxGroupSize = int.tryParse("$value") ?? 10;
                setState(() {});
              },
            ),
        ],
      ),
    );
  }

  Widget _buildAdditionalSection() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Row(
            children: [
              Icon(
                Icons.settings,
                color: primaryColor,
                size: 20,
              ),
              SizedBox(width: spSm),
              Text(
                "Additional Settings",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          Row(
            spacing: spSm,
            children: [
              Expanded(
                child: QButton(
                  label: "Block Seats",
                  size: bs.sm,
                  onPressed: () => _blockSeats(),
                ),
              ),
              Expanded(
                child: QButton(
                  label: "Reserve Seats",
                  size: bs.sm,
                  onPressed: () => _reserveSeats(),
                ),
              ),
            ],
          ),
          Row(
            spacing: spSm,
            children: [
              Expanded(
                child: QButton(
                  label: "Export Layout",
                  size: bs.sm,
                  onPressed: () => _exportLayout(),
                ),
              ),
              Expanded(
                child: QButton(
                  label: "Preview Venue",
                  size: bs.sm,
                  onPressed: () => _previewVenue(),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _blockSeats() {
    if (selectedSeat.isNotEmpty) {
      blockedSeats.add(selectedSeat);
      selectedSeat = "";
      setState(() {});
      ss("Seat blocked successfully");
    } else {
      sw("Please select a seat to block");
    }
  }

  void _reserveSeats() {
    if (selectedSeat.isNotEmpty) {
      reservedSeats.add(selectedSeat);
      selectedSeat = "";
      setState(() {});
      ss("Seat reserved successfully");
    } else {
      sw("Please select a seat to reserve");
    }
  }

  void _exportLayout() {
    si("Exporting seating layout");
  }

  void _previewVenue() {
    si("Opening venue preview");
  }

  void _saveSeatingArrangement() {
    ss("Seating arrangement saved successfully");
  }
}
