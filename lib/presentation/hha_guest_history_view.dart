import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class HhaGuestHistoryView extends StatefulWidget {
  const HhaGuestHistoryView({super.key});

  @override
  State<HhaGuestHistoryView> createState() => _HhaGuestHistoryViewState();
}

class _HhaGuestHistoryViewState extends State<HhaGuestHistoryView> {
  String selectedFilter = "all";
  String searchQuery = "";

  List<Map<String, dynamic>> filterItems = [
    {"label": "All Stays", "value": "all"},
    {"label": "Completed", "value": "completed"},
    {"label": "Upcoming", "value": "upcoming"},
    {"label": "Cancelled", "value": "cancelled"},
  ];

  List<Map<String, dynamic>> stayHistory = [
    {
      "id": "ST001",
      "hotel_name": "Grand Hotel & Spa",
      "room_number": "A-205",
      "check_in": "2024-12-20",
      "check_out": "2024-12-25",
      "status": "upcoming",
      "total_amount": 1500.00,
      "nights": 5,
      "guests": 2,
      "room_type": "Deluxe Suite",
      "booking_date": "2024-11-15",
      "services": ["Spa", "Room Service", "Airport Transfer"],
      "rating": null,
      "review": "",
      "image": "https://picsum.photos/300/200?random=1&keyword=hotel",
    },
    {
      "id": "ST002",
      "hotel_name": "Royal Palace Hotel",
      "room_number": "B-105",
      "check_in": "2024-10-10",
      "check_out": "2024-10-14",
      "status": "completed",
      "total_amount": 800.00,
      "nights": 4,
      "guests": 1,
      "room_type": "Standard Room",
      "booking_date": "2024-09-25",
      "services": ["Breakfast", "Laundry"],
      "rating": 5,
      "review": "Excellent service and beautiful rooms. Will definitely come back!",
      "image": "https://picsum.photos/300/200?random=2&keyword=hotel",
    },
    {
      "id": "ST003",
      "hotel_name": "Ocean View Resort",
      "room_number": "C-301",
      "check_in": "2024-08-15",
      "check_out": "2024-08-20",
      "status": "completed",
      "total_amount": 1200.00,
      "nights": 5,
      "guests": 3,
      "room_type": "Ocean Suite",
      "booking_date": "2024-07-20",
      "services": ["Spa", "Restaurant", "Pool Service"],
      "rating": 4,
      "review": "Great location with amazing ocean views. Food was delicious.",
      "image": "https://picsum.photos/300/200?random=3&keyword=ocean",
    },
    {
      "id": "ST004",
      "hotel_name": "City Center Hotel",
      "room_number": "D-202",
      "check_in": "2024-06-05",
      "check_out": "2024-06-08",
      "status": "cancelled",
      "total_amount": 450.00,
      "nights": 3,
      "guests": 2,
      "room_type": "Standard Room",
      "booking_date": "2024-05-20",
      "services": [],
      "rating": null,
      "review": "",
      "image": "https://picsum.photos/300/200?random=4&keyword=city",
    },
    {
      "id": "ST005",
      "hotel_name": "Mountain Lodge",
      "room_number": "E-101",
      "check_in": "2024-03-10",
      "check_out": "2024-03-15",
      "status": "completed",
      "total_amount": 750.00,
      "nights": 5,
      "guests": 2,
      "room_type": "Mountain View Room",
      "booking_date": "2024-02-15",
      "services": ["Breakfast", "Hiking Guide"],
      "rating": 5,
      "review": "Perfect getaway in the mountains. Staff was incredibly helpful.",
      "image": "https://picsum.photos/300/200?random=5&keyword=mountain",
    },
  ];

  List<Map<String, dynamic>> get filteredHistory {
    List<Map<String, dynamic>> filtered = stayHistory;
    
    if (selectedFilter != "all") {
      filtered = filtered.where((stay) => stay["status"] == selectedFilter).toList();
    }
    
    if (searchQuery.isNotEmpty) {
      filtered = filtered.where((stay) {
        return stay["hotel_name"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
               stay["room_number"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
               stay["id"].toString().toLowerCase().contains(searchQuery.toLowerCase());
      }).toList();
    }
    
    return filtered;
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "completed":
        return successColor;
      case "upcoming":
        return infoColor;
      case "cancelled":
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  String _getStatusText(String status) {
    switch (status) {
      case "completed":
        return "Completed";
      case "upcoming":
        return "Upcoming";
      case "cancelled":
        return "Cancelled";
      default:
        return "Unknown";
    }
  }

  void _viewStayDetails(Map<String, dynamic> stay) {
    // Navigate to stay details
  }

  void _bookAgain(Map<String, dynamic> stay) {
    // Navigate to booking with pre-filled data
    ss("Redirecting to booking page...");
  }

  void _rateAndReview(Map<String, dynamic> stay) {
    // Navigate to rating and review page
  }

  void _cancelBooking(Map<String, dynamic> stay) async {
    bool isConfirmed = await confirm("Are you sure you want to cancel this booking?");
    if (isConfirmed) {
      // Cancel booking logic
      ss("Booking cancelled successfully");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Stay History"),
        actions: [
          IconButton(
            onPressed: () {
              // Filter or sort options
            },
            icon: Icon(Icons.filter_list),
          ),
        ],
      ),
      body: Column(
        children: [
          // Search and Filter Section
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [shadowSm],
            ),
            child: Column(
              spacing: spMd,
              children: [
                // Search Bar
                Row(
                  spacing: spSm,
                  children: [
                    Expanded(
                      child: QTextField(
                        label: "Search stays...",
                        value: searchQuery,
                        onChanged: (value) {
                          searchQuery = value;
                          setState(() {});
                        },
                      ),
                    ),
                    QButton(
                      icon: Icons.search,
                      size: bs.sm,
                      onPressed: () {
                        // Perform search
                      },
                    ),
                  ],
                ),
                
                // Filter Dropdown
                QDropdownField(
                  label: "Filter by Status",
                  items: filterItems,
                  value: selectedFilter,
                  onChanged: (value, label) {
                    selectedFilter = value;
                    setState(() {});
                  },
                ),
              ],
            ),
          ),

          // Statistics Summary
          Container(
            padding: EdgeInsets.all(spMd),
            child: Row(
              spacing: spSm,
              children: [
                Expanded(
                  child: _buildStatCard(
                    "Total Stays",
                    stayHistory.length.toString(),
                    Icons.hotel,
                    primaryColor,
                  ),
                ),
                Expanded(
                  child: _buildStatCard(
                    "Completed",
                    stayHistory.where((s) => s["status"] == "completed").length.toString(),
                    Icons.check_circle,
                    successColor,
                  ),
                ),
                Expanded(
                  child: _buildStatCard(
                    "Upcoming",
                    stayHistory.where((s) => s["status"] == "upcoming").length.toString(),
                    Icons.schedule,
                    infoColor,
                  ),
                ),
              ],
            ),
          ),

          // Stay History List
          Expanded(
            child: filteredHistory.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.history,
                          size: 64,
                          color: disabledColor,
                        ),
                        SizedBox(height: spMd),
                        Text(
                          "No stays found",
                          style: TextStyle(
                            fontSize: fsH6,
                            color: disabledBoldColor,
                          ),
                        ),
                        SizedBox(height: spSm),
                        Text(
                          searchQuery.isNotEmpty
                              ? "Try adjusting your search criteria"
                              : "You haven't made any bookings yet",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: EdgeInsets.all(spMd),
                    itemCount: filteredHistory.length,
                    itemBuilder: (context, index) {
                      final stay = filteredHistory[index];
                      return _buildStayCard(stay);
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: color.withAlpha(20),
        borderRadius: BorderRadius.circular(radiusMd),
        border: Border.all(color: color.withAlpha(40)),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 24),
          SizedBox(height: spSm),
          Text(
            value,
            style: TextStyle(
              fontSize: fsH5,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          SizedBox(height: spXs),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStayCard(Map<String, dynamic> stay) {
    return Container(
      margin: EdgeInsets.only(bottom: spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        children: [
          // Hotel Image and Basic Info
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(radiusMd),
                  bottomLeft: Radius.circular(radiusMd),
                ),
                child: Image.network(
                  "${stay["image"]}",
                  width: 100,
                  height: 120,
                  fit: BoxFit.cover,
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(spMd),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: spSm,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              "${stay["hotel_name"]}",
                              style: TextStyle(
                                fontSize: fsH6,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                            decoration: BoxDecoration(
                              color: _getStatusColor(stay["status"]).withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Text(
                              _getStatusText(stay["status"]),
                              style: TextStyle(
                                fontSize: 12,
                                color: _getStatusColor(stay["status"]),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                      
                      Text(
                        "Room ${stay["room_number"]} • ${stay["room_type"]}",
                        style: TextStyle(
                          color: disabledBoldColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      
                      Row(
                        children: [
                          Icon(Icons.calendar_today, size: 16, color: disabledBoldColor),
                          SizedBox(width: spXs),
                          Text(
                            "${(DateTime.parse(stay["check_in"])).dMMMy} - ${(DateTime.parse(stay["check_out"])).dMMMy}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                      
                      Row(
                        children: [
                          Icon(Icons.group, size: 16, color: disabledBoldColor),
                          SizedBox(width: spXs),
                          Text(
                            "${stay["guests"]} Guest${(stay["guests"] as int) > 1 ? 's' : ''} • ${stay["nights"]} Night${(stay["nights"] as int) > 1 ? 's' : ''}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                      
                      Text(
                        "\$${((stay["total_amount"] as double)).currency}",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),

          // Services Used
          if ((stay["services"] as List).isNotEmpty)
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: spMd, vertical: spSm),
              decoration: BoxDecoration(
                color: primaryColor.withAlpha(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spXs,
                children: [
                  Text(
                    "Services Used:",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: primaryColor,
                    ),
                  ),
                  Wrap(
                    spacing: spXs,
                    children: (stay["services"] as List).map((service) {
                      return Container(
                        padding: EdgeInsets.symmetric(horizontal: spSm, vertical: 2),
                        decoration: BoxDecoration(
                          color: primaryColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Text(
                          "$service",
                          style: TextStyle(
                            fontSize: 10,
                            color: primaryColor,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),

          // Rating and Review (for completed stays)
          if (stay["status"] == "completed" && stay["rating"] != null)
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: successColor.withAlpha(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spSm,
                children: [
                  Row(
                    children: [
                      Text(
                        "Your Rating:",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: successColor,
                        ),
                      ),
                      SizedBox(width: spSm),
                      Row(
                        children: List.generate(5, (index) {
                          return Icon(
                            index < (stay["rating"] as int)
                                ? Icons.star
                                : Icons.star_border,
                            size: 16,
                            color: Colors.amber,
                          );
                        }),
                      ),
                    ],
                  ),
                  if (stay["review"] != null && (stay["review"] as String).isNotEmpty)
                    Text(
                      "${stay["review"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                ],
              ),
            ),

          // Action Buttons
          Container(
            padding: EdgeInsets.all(spMd),
            child: Row(
              spacing: spSm,
              children: [
                Expanded(
                  child: QButton(
                    label: "View Details",
                    size: bs.sm,
                    onPressed: () => _viewStayDetails(stay),
                  ),
                ),
                
                if (stay["status"] == "completed")
                  Expanded(
                    child: QButton(
                      label: "Book Again",
                      size: bs.sm,
                      onPressed: () => _bookAgain(stay),
                    ),
                  ),

                if (stay["status"] == "completed" && stay["rating"] == null)
                  Expanded(
                    child: QButton(
                      label: "Rate & Review",
                      size: bs.sm,
                      onPressed: () => _rateAndReview(stay),
                    ),
                  ),

                if (stay["status"] == "upcoming")
                  Expanded(
                    child: QButton(
                      label: "Cancel",
                      size: bs.sm,
                      onPressed: () => _cancelBooking(stay),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
