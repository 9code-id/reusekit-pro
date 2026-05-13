import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class TtaSeatSelectionView extends StatefulWidget {
  const TtaSeatSelectionView({super.key});

  @override
  State<TtaSeatSelectionView> createState() => _TtaSeatSelectionViewState();
}

class _TtaSeatSelectionViewState extends State<TtaSeatSelectionView> {
  List<String> selectedSeats = [];
  String flightClass = "Economy";
  int passengerCount = 2;

  final Map<String, dynamic> flightInfo = {
    "flightNumber": "GA 152",
    "departure": "Jakarta (CGK)",
    "arrival": "Bali (DPS)", 
    "date": "Dec 25, 2024",
    "time": "08:30 - 11:45",
    "aircraft": "Boeing 737-800"
  };

  final List<Map<String, dynamic>> seatPricing = [
    {"class": "Economy", "price": 0, "color": successColor},
    {"class": "Premium Economy", "price": 75, "color": warningColor},
    {"class": "Business", "price": 350, "color": infoColor},
    {"class": "First Class", "price": 850, "color": primaryColor},
  ];

  // Seat map configuration (simplified)
  final Map<String, List<String>> seatMap = {
    "1": ["1A", "1B", "", "1C", "1D", "1E", "1F"], // First Class
    "2": ["2A", "2B", "", "2C", "2D", "2E", "2F"], // First Class
    "3": ["", "", "", "", "", "", ""], // Gap
    "4": ["4A", "4B", "", "4C", "4D", "4E", "4F"], // Business
    "5": ["5A", "5B", "", "5C", "5D", "5E", "5F"], // Business
    "6": ["6A", "6B", "", "6C", "6D", "6E", "6F"], // Business
    "7": ["", "", "", "", "", "", ""], // Gap
    "8": ["8A", "8B", "", "8C", "8D", "8E", "8F"], // Premium Economy
    "9": ["9A", "9B", "", "9C", "9D", "9E", "9F"], // Premium Economy
    "10": ["", "", "", "", "", "", ""], // Gap
    "11": ["11A", "11B", "11C", "", "11D", "11E", "11F"], // Economy
    "12": ["12A", "12B", "12C", "", "12D", "12E", "12F"], // Economy
    "13": ["13A", "13B", "13C", "", "13D", "13E", "13F"], // Economy
    "14": ["14A", "14B", "14C", "", "14D", "14E", "14F"], // Economy
    "15": ["15A", "15B", "15C", "", "15D", "15E", "15F"], // Economy
    "16": ["16A", "16B", "16C", "", "16D", "16E", "16F"], // Economy
    "17": ["17A", "17B", "17C", "", "17D", "17E", "17F"], // Economy
    "18": ["18A", "18B", "18C", "", "18D", "18E", "18F"], // Economy
  };

  final List<String> occupiedSeats = ["1A", "2C", "4B", "5F", "11A", "12D", "13B", "15E"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Select Seats"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => back(),
        ),
      ),
      body: Column(
        children: [
          _buildFlightInfo(),
          _buildSeatLegend(),
          Expanded(child: _buildSeatMap()),
          _buildBottomSection(),
        ],
      ),
    );
  }

  Widget _buildFlightInfo() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [shadowSm],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${flightInfo["flightNumber"]}",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "${flightInfo["departure"]} → ${flightInfo["arrival"]}",
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
                  Text(
                    "${flightInfo["date"]}",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spXs),
                  Text(
                    "${flightInfo["time"]}",
                    style: TextStyle(
                      fontSize: 14,
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: spSm),
          Container(
            padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(30),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Row(
              children: [
                Icon(Icons.flight, color: primaryColor, size: 16),
                SizedBox(width: spXs),
                Text(
                  "${flightInfo["aircraft"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: primaryColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Spacer(),
                Text(
                  "Passengers: $passengerCount",
                  style: TextStyle(
                    fontSize: 12,
                    color: primaryColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSeatLegend() {
    return Container(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Seat Classes",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          Wrap(
            spacing: spSm,
            runSpacing: spXs,
            children: seatPricing.map((pricing) {
              return Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: (pricing["color"] as Color).withAlpha(30),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 12,
                      height: 12,
                      decoration: BoxDecoration(
                        color: pricing["color"] as Color,
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                    ),
                    SizedBox(width: spXs),
                    Text(
                      "${pricing["class"]}",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: pricing["color"] as Color,
                      ),
                    ),
                    if ((pricing["price"] as int) > 0) ...[
                      SizedBox(width: spXs),
                      Text(
                        "+\$${(pricing["price"] as int)}",
                        style: TextStyle(
                          fontSize: 12,
                          color: pricing["color"] as Color,
                        ),
                      ),
                    ],
                  ],
                ),
              );
            }).toList(),
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              _buildLegendItem(Colors.grey, "Occupied"),
              SizedBox(width: spMd),
              _buildLegendItem(primaryColor, "Selected"),
              SizedBox(width: spMd),
              _buildLegendItem(Colors.white, "Available"),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildLegendItem(Color color, String label) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 16,
          height: 16,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(radiusXs),
            border: Border.all(color: disabledColor),
          ),
        ),
        SizedBox(width: spXs),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: disabledBoldColor,
          ),
        ),
      ],
    );
  }

  Widget _buildSeatMap() {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: spMd),
      child: Column(
        children: [
          // Aircraft front indicator
          Container(
            width: 60,
            height: 30,
            margin: EdgeInsets.only(bottom: spMd),
            decoration: BoxDecoration(
              color: primaryColor,
              borderRadius: BorderRadius.vertical(top: Radius.circular(radiusLg)),
            ),
            child: Center(
              child: Icon(Icons.flight, color: Colors.white, size: 20),
            ),
          ),
          // Seat rows
          Column(
            spacing: spXs,
            children: seatMap.entries.map((entry) {
              String rowNumber = entry.key;
              List<String> seats = entry.value;
              
              if (seats.every((seat) => seat.isEmpty)) {
                return SizedBox(height: spMd); // Gap between sections
              }
              
              return _buildSeatRow(rowNumber, seats);
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildSeatRow(String rowNumber, List<String> seats) {
    return Row(
      children: [
        // Row number
        Container(
          width: 30,
          alignment: Alignment.center,
          child: Text(
            rowNumber,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: disabledBoldColor,
            ),
          ),
        ),
        SizedBox(width: spSm),
        // Seats
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: seats.map((seat) {
              if (seat.isEmpty) {
                return SizedBox(width: 30); // Aisle space
              }
              return _buildSeat(seat);
            }).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildSeat(String seatNumber) {
    bool isOccupied = occupiedSeats.contains(seatNumber);
    bool isSelected = selectedSeats.contains(seatNumber);
    Color seatColor = _getSeatColor(seatNumber);
    
    return GestureDetector(
      onTap: () => _onSeatTap(seatNumber, isOccupied),
      child: Container(
        width: 30,
        height: 30,
        margin: EdgeInsets.all(2),
        decoration: BoxDecoration(
          color: isOccupied 
            ? Colors.grey 
            : isSelected 
              ? primaryColor 
              : Colors.white,
          borderRadius: BorderRadius.circular(radiusSm),
          border: Border.all(
            color: isOccupied 
              ? Colors.grey 
              : isSelected 
                ? primaryColor 
                : seatColor.withAlpha(100),
            width: 2,
          ),
        ),
        child: Center(
          child: Text(
            seatNumber.substring(seatNumber.length - 1),
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.bold,
              color: isOccupied || isSelected ? Colors.white : seatColor,
            ),
          ),
        ),
      ),
    );
  }

  Color _getSeatColor(String seatNumber) {
    int rowNum = int.parse(seatNumber.substring(0, seatNumber.length - 1));
    
    if (rowNum <= 2) return primaryColor; // First Class
    if (rowNum <= 6) return infoColor; // Business
    if (rowNum <= 9) return warningColor; // Premium Economy
    return successColor; // Economy
  }

  void _onSeatTap(String seatNumber, bool isOccupied) {
    if (isOccupied) {
      se("This seat is already occupied");
      return;
    }
    
    if (selectedSeats.contains(seatNumber)) {
      selectedSeats.remove(seatNumber);
    } else {
      if (selectedSeats.length >= passengerCount) {
        sw("You can only select $passengerCount seats");
        return;
      }
      selectedSeats.add(seatNumber);
    }
    
    setState(() {});
  }

  Widget _buildBottomSection() {
    double totalExtraPrice = _calculateExtraPrice();
    
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [shadowMd],
      ),
      child: Column(
        children: [
          if (selectedSeats.isNotEmpty) ...[
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: primaryColor.withAlpha(30),
                borderRadius: BorderRadius.circular(radiusMd),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(
                        "Selected Seats:",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Spacer(),
                      Text(
                        selectedSeats.join(", "),
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  if (totalExtraPrice > 0) ...[
                    SizedBox(height: spXs),
                    Row(
                      children: [
                        Text(
                          "Seat Upgrade Fee:",
                          style: TextStyle(
                            fontSize: 14,
                            color: primaryColor,
                          ),
                        ),
                        Spacer(),
                        Text(
                          "+\$${totalExtraPrice.toStringAsFixed(0)}",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: successColor,
                          ),
                        ),
                      ],
                    ),
                  ],
                ],
              ),
            ),
            SizedBox(height: spMd),
          ],
          Row(
            children: [
              Expanded(
                child: Column(
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
                      "\$${(599 + totalExtraPrice).toStringAsFixed(0)}",
                      style: TextStyle(
                        fontSize: fsH4,
                        fontWeight: FontWeight.bold,
                        color: successColor,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: spMd),
              QButton(
                label: selectedSeats.length == passengerCount 
                  ? "Continue to Payment" 
                  : "Select ${passengerCount - selectedSeats.length} more seat${passengerCount - selectedSeats.length > 1 ? 's' : ''}",
                size: bs.md,
                onPressed: selectedSeats.length == passengerCount 
                  ? () {
                      //navigateTo('PaymentView')
                    }
                  : null,
              ),
            ],
          ),
        ],
      ),
    );
  }

  double _calculateExtraPrice() {
    double total = 0;
    for (String seat in selectedSeats) {
      int rowNum = int.parse(seat.substring(0, seat.length - 1));
      
      if (rowNum <= 2) {
        total += 850; // First Class
      } else if (rowNum <= 6) {
        total += 350; // Business
      } else if (rowNum <= 9) {
        total += 75; // Premium Economy
      }
      // Economy seats have no extra charge
    }
    return total;
  }
}
