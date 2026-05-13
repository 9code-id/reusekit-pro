import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class TtaBookingHistoryView extends StatefulWidget {
  const TtaBookingHistoryView({super.key});

  @override
  State<TtaBookingHistoryView> createState() => _TtaBookingHistoryViewState();
}

class _TtaBookingHistoryViewState extends State<TtaBookingHistoryView> {
  String selectedFilter = "All";
  String selectedDateRange = "Last 30 days";

  List<Map<String, dynamic>> filterOptions = [
    {"label": "All", "value": "All"},
    {"label": "Flights", "value": "Flight"},
    {"label": "Hotels", "value": "Hotel"},
    {"label": "Car Rentals", "value": "Car Rental"},
    {"label": "Activities", "value": "Activity"},
  ];

  List<Map<String, dynamic>> dateRangeOptions = [
    {"label": "Last 30 days", "value": "Last 30 days"},
    {"label": "Last 3 months", "value": "Last 3 months"},
    {"label": "Last 6 months", "value": "Last 6 months"},
    {"label": "This year", "value": "This year"},
    {"label": "All time", "value": "All time"},
  ];

  List<Map<String, dynamic>> bookingHistory = [
    {
      "id": "TRV001",
      "type": "Flight",
      "title": "New York to Paris",
      "subtitle": "Air France • AF007",
      "date": "2024-05-15",
      "status": "Completed",
      "price": 920.00,
      "image": "https://picsum.photos/60/60?random=1&keyword=airplane",
      "rating": 4.5,
      "hasReview": true,
      "refundable": false,
      "details": {
        "departure": "JFK Airport",
        "arrival": "CDG Airport",
        "duration": "8h 15m",
        "seat": "12A"
      }
    },
    {
      "id": "HTL002",
      "type": "Hotel",
      "title": "Hotel Plaza Athénée",
      "subtitle": "Paris, France",
      "date": "2024-05-10",
      "status": "Completed",
      "price": 2100.00,
      "image": "https://picsum.photos/60/60?random=2&keyword=hotel",
      "rating": 4.8,
      "hasReview": true,
      "refundable": false,
      "details": {
        "checkIn": "2024-05-10",
        "checkOut": "2024-05-15",
        "nights": 5,
        "room": "Deluxe Suite"
      }
    },
    {
      "id": "CAR003",
      "type": "Car Rental",
      "title": "BMW X3 Rental",
      "subtitle": "Hertz • Paris Location",
      "date": "2024-05-10",
      "status": "Completed",
      "price": 450.00,
      "image": "https://picsum.photos/60/60?random=3&keyword=car",
      "rating": 4.2,
      "hasReview": false,
      "refundable": false,
      "details": {
        "pickUp": "CDG Airport",
        "dropOff": "CDG Airport",
        "duration": "5 days"
      }
    },
    {
      "id": "ACT004",
      "type": "Activity",
      "title": "Eiffel Tower Skip-the-Line",
      "subtitle": "GetYourGuide",
      "date": "2024-05-12",
      "status": "Completed",
      "price": 85.00,
      "image": "https://picsum.photos/60/60?random=4&keyword=eiffel",
      "rating": 4.9,
      "hasReview": true,
      "refundable": false,
      "details": {
        "time": "10:00 AM",
        "duration": "2 hours",
        "tickets": 2
      }
    },
    {
      "id": "TRV005",
      "type": "Flight",
      "title": "Los Angeles to Tokyo",
      "subtitle": "Japan Airlines • JL012",
      "date": "2024-04-20",
      "status": "Completed",
      "price": 1150.00,
      "image": "https://picsum.photos/60/60?random=5&keyword=airplane",
      "rating": 4.3,
      "hasReview": true,
      "refundable": false,
      "details": {
        "departure": "LAX Airport",
        "arrival": "NRT Airport",
        "duration": "11h 30m",
        "seat": "15C"
      }
    },
    {
      "id": "HTL006",
      "type": "Hotel",
      "title": "Sunset Resort Cancun",
      "subtitle": "Cancun, Mexico",
      "date": "2024-03-15",
      "status": "Cancelled",
      "price": 1680.00,
      "image": "https://picsum.photos/60/60?random=6&keyword=resort",
      "rating": 0,
      "hasReview": false,
      "refundable": true,
      "refundAmount": 1512.00,
      "refundStatus": "Processed",
      "details": {
        "checkIn": "2024-03-15",
        "checkOut": "2024-03-22",
        "nights": 7,
        "room": "Ocean View Suite"
      }
    },
    {
      "id": "TRV007",
      "type": "Flight",
      "title": "London to Dubai",
      "subtitle": "Emirates • EK001",
      "date": "2024-02-28",
      "status": "Completed",
      "price": 890.00,
      "image": "https://picsum.photos/60/60?random=7&keyword=airplane",
      "rating": 4.7,
      "hasReview": true,
      "refundable": false,
      "details": {
        "departure": "LHR Airport",
        "arrival": "DXB Airport",
        "duration": "7h 45m",
        "seat": "8A"
      }
    },
    {
      "id": "ACT008",
      "type": "Activity",
      "title": "Desert Safari Dubai",
      "subtitle": "Arabian Adventures",
      "date": "2024-03-02",
      "status": "Completed",
      "price": 120.00,
      "image": "https://picsum.photos/60/60?random=8&keyword=desert",
      "rating": 4.6,
      "hasReview": true,
      "refundable": false,
      "details": {
        "time": "3:00 PM",
        "duration": "6 hours",
        "tickets": 2
      }
    },
  ];

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> filteredHistory = selectedFilter == "All" 
        ? bookingHistory 
        : bookingHistory.where((booking) => booking["type"] == selectedFilter).toList();

    // Calculate statistics
    int totalBookings = filteredHistory.length;
    double totalSpent = filteredHistory.fold(0.0, (sum, booking) => 
        sum + (booking["price"] as double));
    int completedBookings = filteredHistory.where((booking) => 
        booking["status"] == "Completed").length;
    double avgRating = filteredHistory.where((booking) => 
        booking["rating"] > 0).fold(0.0, (sum, booking) => 
        sum + (booking["rating"] as double)) / 
        filteredHistory.where((booking) => booking["rating"] > 0).length;

    return Scaffold(
      appBar: AppBar(
        title: Text("Booking History"),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.filter_list),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Statistics Overview
            Container(
              margin: EdgeInsets.all(spMd),
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: primaryColor.withAlpha(10),
                borderRadius: BorderRadius.circular(radiusMd),
                border: Border.all(
                  color: primaryColor.withAlpha(30),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Travel Summary",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: spSm),
                  Row(
                    children: [
                      Expanded(
                        child: _buildStatCard(
                          "Total Bookings",
                          "$totalBookings",
                          Icons.confirmation_number,
                          primaryColor,
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: _buildStatCard(
                          "Total Spent",
                          "\$${totalSpent.currency}",
                          Icons.attach_money,
                          successColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  Row(
                    children: [
                      Expanded(
                        child: _buildStatCard(
                          "Completed",
                          "$completedBookings",
                          Icons.check_circle,
                          infoColor,
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: _buildStatCard(
                          "Avg Rating",
                          avgRating.isNaN ? "N/A" : "${avgRating.toStringAsFixed(1)}★",
                          Icons.star,
                          warningColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Filters Section
            Padding(
              padding: EdgeInsets.symmetric(horizontal: spMd),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Filter by Type",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: spSm),
                  QCategoryPicker(
                    items: filterOptions,
                    value: selectedFilter,
                    onChanged: (index, label, value, item) {
                      selectedFilter = value;
                      setState(() {});
                    },
                  ),
                  SizedBox(height: spSm),
                  Row(
                    children: [
                      Text(
                        "Date Range:",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QDropdownField(
                          label: "",
                          items: dateRangeOptions,
                          value: selectedDateRange,
                          onChanged: (value, label) {
                            selectedDateRange = value;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            SizedBox(height: spLg),

            // Booking History List
            Padding(
              padding: EdgeInsets.symmetric(horizontal: spMd),
              child: Text(
                "Booking History (${filteredHistory.length})",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            SizedBox(height: spSm),

            Column(
              children: filteredHistory.map((booking) {
                return Container(
                  margin: EdgeInsets.symmetric(
                    horizontal: spMd,
                    vertical: spSm,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                    border: booking["status"] == "Cancelled" 
                        ? Border.all(color: dangerColor.withAlpha(30))
                        : null,
                  ),
                  child: Column(
                    children: [
                      // Booking Header
                      Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: _getStatusColor(booking["status"] as String).withAlpha(20),
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(radiusMd),
                          ),
                        ),
                        child: Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(radiusSm),
                              child: Image.network(
                                "${booking["image"]}",
                                width: 50,
                                height: 50,
                                fit: BoxFit.cover,
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
                                        "${booking["type"]} • ${booking["id"]}",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: disabledBoldColor,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      Spacer(),
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: spSm,
                                          vertical: spXs,
                                        ),
                                        decoration: BoxDecoration(
                                          color: _getStatusColor(booking["status"] as String),
                                          borderRadius: BorderRadius.circular(radiusSm),
                                        ),
                                        child: Text(
                                          "${booking["status"]}".toUpperCase(),
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
                                    "${booking["title"]}",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    "${booking["subtitle"]}",
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

                      // Booking Details
                      Padding(
                        padding: EdgeInsets.all(spSm),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.calendar_today,
                                  size: 16,
                                  color: disabledBoldColor,
                                ),
                                SizedBox(width: spXs),
                                Text(
                                  "${DateTime.parse(booking["date"] as String).dMMMy}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                Spacer(),
                                Text(
                                  "\$${(booking["price"] as double).currency}",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: booking["status"] == "Cancelled" 
                                        ? disabledBoldColor 
                                        : primaryColor,
                                  ),
                                ),
                              ],
                            ),

                            SizedBox(height: spSm),

                            // Rating Section
                            if (booking["rating"] > 0) ...[
                              Row(
                                children: [
                                  Text(
                                    "Your Rating:",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  SizedBox(width: spSm),
                                  ...List.generate(5, (index) {
                                    return Icon(
                                      Icons.star,
                                      size: 16,
                                      color: index < (booking["rating"] as double).floor()
                                          ? Colors.amber
                                          : disabledColor,
                                    );
                                  }),
                                  SizedBox(width: spXs),
                                  Text(
                                    "${booking["rating"]}",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: spSm),
                            ],

                            // Refund Information for Cancelled Bookings
                            if (booking["status"] == "Cancelled") ...[
                              Container(
                                padding: EdgeInsets.all(spSm),
                                decoration: BoxDecoration(
                                  color: dangerColor.withAlpha(10),
                                  borderRadius: BorderRadius.circular(radiusSm),
                                  border: Border.all(
                                    color: dangerColor.withAlpha(30),
                                  ),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Refund Information",
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(height: spXs),
                                    Row(
                                      children: [
                                        Text(
                                          "Refund Amount:",
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: disabledBoldColor,
                                          ),
                                        ),
                                        Spacer(),
                                        Text(
                                          "\$${(booking["refundAmount"] as double).currency}",
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                            color: successColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          "Status:",
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: disabledBoldColor,
                                          ),
                                        ),
                                        Spacer(),
                                        Text(
                                          "${booking["refundStatus"]}",
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                            color: successColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: spSm),
                            ],

                            // Action Buttons
                            Row(
                              children: [
                                QButton(
                                  label: "View Details",
                                  size: bs.sm,
                                  color: infoColor,
                                  onPressed: () {},
                                ),
                                SizedBox(width: spSm),
                                if (booking["status"] == "Completed" && !(booking["hasReview"] as bool)) ...[
                                  QButton(
                                    label: "Write Review",
                                    size: bs.sm,
                                    onPressed: () {},
                                  ),
                                ] else if (booking["status"] == "Completed") ...[
                                  QButton(
                                    label: "Book Again",
                                    size: bs.sm,
                                    onPressed: () {},
                                  ),
                                ],
                                Spacer(),
                                IconButton(
                                  icon: Icon(Icons.share),
                                  onPressed: () {},
                                ),
                                IconButton(
                                  icon: Icon(Icons.download),
                                  onPressed: () {},
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

            SizedBox(height: spLg),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(String label, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusSm),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                icon,
                size: 20,
                color: color,
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
          ),
          SizedBox(height: spXs),
          Text(
            value,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "Completed":
        return successColor;
      case "Cancelled":
        return dangerColor;
      case "Confirmed":
        return primaryColor;
      case "Pending":
        return warningColor;
      default:
        return disabledBoldColor;
    }
  }
}
