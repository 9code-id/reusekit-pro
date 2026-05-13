import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlReservation8View extends StatefulWidget {
  @override
  State<GrlReservation8View> createState() => _GrlReservation8ViewState();
}

class _GrlReservation8ViewState extends State<GrlReservation8View> {
  int selectedTab = 0;
  String searchQuery = "";
  
  List<Map<String, dynamic>> bookingHistory = [
    {
      "id": "BK001",
      "serviceName": "Executive Health Checkup",
      "providerName": "City Medical Center",
      "date": "2024-03-15",
      "time": "10:00 AM",
      "status": "Completed",
      "rating": 4.8,
      "price": 250.0,
      "duration": "2 hours",
      "location": "Downtown Medical District",
      "image": "https://picsum.photos/300/200?random=1&keyword=medical",
      "feedback": "Excellent service and professional staff",
      "bookingDate": "2024-03-10"
    },
    {
      "id": "BK002", 
      "serviceName": "Wedding Photography",
      "providerName": "Perfect Moments Studio",
      "date": "2024-03-20",
      "time": "2:00 PM",
      "status": "Confirmed",
      "rating": null,
      "price": 1200.0,
      "duration": "8 hours",
      "location": "Garden Estate Venue",
      "image": "https://picsum.photos/300/200?random=2&keyword=wedding",
      "feedback": "",
      "bookingDate": "2024-02-15"
    },
    {
      "id": "BK003",
      "serviceName": "Car Repair Service",
      "providerName": "AutoCare Express",
      "date": "2024-03-08",
      "time": "9:00 AM", 
      "status": "Cancelled",
      "rating": null,
      "price": 180.0,
      "duration": "3 hours",
      "location": "Main Street Auto Center",
      "image": "https://picsum.photos/300/200?random=3&keyword=car",
      "feedback": "",
      "bookingDate": "2024-03-05"
    },
    {
      "id": "BK004",
      "serviceName": "Home Cleaning",
      "providerName": "Sparkle Clean Co.",
      "date": "2024-02-28",
      "time": "11:00 AM",
      "status": "Completed",
      "rating": 4.5,
      "price": 120.0,
      "duration": "3 hours",
      "location": "Residential Area",
      "image": "https://picsum.photos/300/200?random=4&keyword=cleaning",
      "feedback": "Very thorough cleaning, highly recommended!",
      "bookingDate": "2024-02-25"
    },
    {
      "id": "BK005",
      "serviceName": "Personal Training Session",
      "providerName": "FitLife Gym",
      "date": "2024-03-25",
      "time": "6:00 PM",
      "status": "Upcoming",
      "rating": null,
      "price": 80.0,
      "duration": "1 hour",
      "location": "Downtown Fitness Center",
      "image": "https://picsum.photos/300/200?random=5&keyword=gym",
      "feedback": "",
      "bookingDate": "2024-03-20"
    }
  ];

  List<String> statusTabs = ["All", "Upcoming", "Completed", "Cancelled"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Booking History"),
        actions: [
          IconButton(
            icon: Icon(Icons.calendar_month),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.receipt_long),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          _buildSearchSection(),
          _buildStatusTabs(),
          _buildStatsSection(),
          Expanded(
            child: _buildBookingsList(),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchSection() {
    return Container(
      padding: EdgeInsets.all(spMd),
      color: Colors.white,
      child: Row(
        children: [
          Expanded(
            child: QTextField(
              label: "Search bookings...",
              value: searchQuery,
              onChanged: (value) {
                searchQuery = value;
                setState(() {});
              },
            ),
          ),
          SizedBox(width: spSm),
          QButton(
            icon: Icons.search,
            size: bs.sm,
            onPressed: () {
              // Perform search
            },
          ),
        ],
      ),
    );
  }

  Widget _buildStatusTabs() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: spMd),
      color: Colors.white,
      child: Row(
        children: statusTabs.asMap().entries.map((entry) {
          int index = entry.key;
          String status = entry.value;
          bool isSelected = selectedTab == index;
          
          return Expanded(
            child: GestureDetector(
              onTap: () {
                selectedTab = index;
                setState(() {});
              },
              child: Container(
                padding: EdgeInsets.symmetric(vertical: spSm),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: isSelected ? primaryColor : Colors.transparent,
                      width: 2,
                    ),
                  ),
                ),
                child: Text(
                  status,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                    color: isSelected ? primaryColor : disabledBoldColor,
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildStatsSection() {
    List<Map<String, dynamic>> filteredBookings = _getFilteredBookings();
    int totalBookings = filteredBookings.length;
    double totalSpent = filteredBookings
        .where((booking) => booking["status"] == "Completed")
        .fold(0.0, (sum, booking) => sum + (booking["price"] as double));
    double avgRating = _calculateAverageRating(filteredBookings);

    return Container(
      padding: EdgeInsets.all(spMd),
      margin: EdgeInsets.symmetric(horizontal: spMd, vertical: spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Row(
        children: [
          _buildStatItem(
            "Total Bookings",
            totalBookings.toString(),
            Icons.event_note,
            primaryColor,
          ),
          Container(
            width: 1,
            height: 40,
            color: disabledOutlineBorderColor,
            margin: EdgeInsets.symmetric(horizontal: spSm),
          ),
          _buildStatItem(
            "Total Spent",
            "\$${totalSpent.toStringAsFixed(0)}",
            Icons.attach_money,
            successColor,
          ),
          Container(
            width: 1,
            height: 40,
            color: disabledOutlineBorderColor,
            margin: EdgeInsets.symmetric(horizontal: spSm),
          ),
          _buildStatItem(
            "Avg Rating",
            avgRating > 0 ? avgRating.toStringAsFixed(1) : "N/A",
            Icons.star,
            warningColor,
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(String label, String value, IconData icon, Color color) {
    return Expanded(
      child: Column(
        children: [
          Icon(icon, color: color, size: 24),
          SizedBox(height: spXs),
          Text(
            value,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBookingsList() {
    List<Map<String, dynamic>> filteredBookings = _getFilteredBookings();

    if (filteredBookings.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.event_busy,
              size: 64,
              color: disabledColor,
            ),
            SizedBox(height: spMd),
            Text(
              "No bookings found",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: disabledBoldColor,
              ),
            ),
            SizedBox(height: spSm),
            Text(
              "Try adjusting your filters or search terms",
              style: TextStyle(
                fontSize: 14,
                color: disabledBoldColor,
              ),
            ),
          ],
        ),
      );
    }

    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        children: filteredBookings.map((booking) {
          return Container(
            margin: EdgeInsets.only(bottom: spMd),
            child: _buildBookingCard(booking),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildBookingCard(Map<String, dynamic> booking) {
    Color statusColor = _getStatusColor(booking["status"]);
    IconData statusIcon = _getStatusIcon(booking["status"]);
    bool canRate = booking["status"] == "Completed" && booking["rating"] == null;
    bool canCancel = booking["status"] == "Confirmed" || booking["status"] == "Upcoming";

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        children: [
          // Header section
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: statusColor.withAlpha(20),
              borderRadius: BorderRadius.vertical(top: Radius.circular(radiusLg)),
            ),
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 4),
                  decoration: BoxDecoration(
                    color: statusColor,
                    borderRadius: BorderRadius.circular(radiusXs),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(statusIcon, color: Colors.white, size: 12),
                      SizedBox(width: 4),
                      Text(
                        "${booking["status"]}",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                Spacer(),
                Text(
                  "ID: ${booking["id"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),

          // Main content
          Padding(
            padding: EdgeInsets.all(spSm),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(radiusSm),
                      child: Image.network(
                        "${booking["image"]}",
                        width: 80,
                        height: 80,
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${booking["serviceName"]}",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "${booking["providerName"]}",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(height: spXs),
                          Row(
                            children: [
                              Icon(Icons.location_on, size: 14, color: disabledBoldColor),
                              SizedBox(width: 4),
                              Expanded(
                                child: Text(
                                  "${booking["location"]}",
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
                    Text(
                      "\$${(booking["price"] as double).toStringAsFixed(0)}",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),

                SizedBox(height: spSm),

                // Booking details
                Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: primaryColor.withAlpha(10),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          _buildDetailItem(Icons.calendar_today, "Date", DateTime.parse(booking["date"]).dMMMy),
                          SizedBox(width: spMd),
                          _buildDetailItem(Icons.access_time, "Time", "${booking["time"]}"),
                        ],
                      ),
                      SizedBox(height: spXs),
                      Row(
                        children: [
                          _buildDetailItem(Icons.schedule, "Duration", "${booking["duration"]}"),
                          SizedBox(width: spMd),
                          _buildDetailItem(Icons.event_note, "Booked", DateTime.parse(booking["bookingDate"]).dMMMy),
                        ],
                      ),
                    ],
                  ),
                ),

                // Rating section (if completed and rated)
                if (booking["rating"] != null) ...[
                  SizedBox(height: spSm),
                  Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: successColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              "Your Rating:",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: successColor,
                              ),
                            ),
                            SizedBox(width: spSm),
                            Row(
                              children: List.generate(5, (index) {
                                return Icon(
                                  index < (booking["rating"] as double).floor() ? Icons.star : Icons.star_border,
                                  color: warningColor,
                                  size: 16,
                                );
                              }),
                            ),
                            Spacer(),
                            Text(
                              "${booking["rating"]}",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: successColor,
                              ),
                            ),
                          ],
                        ),
                        if (booking["feedback"].isNotEmpty) ...[
                          SizedBox(height: spXs),
                          Text(
                            "${booking["feedback"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                ],

                SizedBox(height: spSm),

                // Action buttons
                Row(
                  children: [
                    Expanded(
                      child: QButton(
                        label: "View Details",
                        size: bs.sm,
                        color: disabledBoldColor,
                        onPressed: () {
                          _viewBookingDetails(booking);
                        },
                      ),
                    ),
                    SizedBox(width: spSm),
                    if (canRate) ...[
                      Expanded(
                        child: QButton(
                          label: "Rate Service",
                          size: bs.sm,
                          onPressed: () {
                            _rateService(booking);
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                    ],
                    if (canCancel) ...[
                      Expanded(
                        child: QButton(
                          label: "Cancel",
                          size: bs.sm,
                          color: dangerColor,
                          onPressed: () {
                            _cancelBooking(booking);
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                    ],
                    if (booking["status"] == "Completed") ...[
                      QButton(
                        icon: Icons.refresh,
                        size: bs.sm,
                        onPressed: () {
                          _rebookService(booking);
                        },
                      ),
                    ],
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailItem(IconData icon, String label, String value) {
    return Expanded(
      child: Row(
        children: [
          Icon(icon, size: 16, color: disabledBoldColor),
          SizedBox(width: spXs),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  List<Map<String, dynamic>> _getFilteredBookings() {
    List<Map<String, dynamic>> filtered = bookingHistory;

    // Filter by search query
    if (searchQuery.isNotEmpty) {
      filtered = filtered.where((booking) {
        return booking["serviceName"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
               booking["providerName"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
               booking["id"].toString().toLowerCase().contains(searchQuery.toLowerCase());
      }).toList();
    }

    // Filter by status
    if (selectedTab > 0) {
      String statusFilter = statusTabs[selectedTab];
      if (statusFilter == "Upcoming") {
        filtered = filtered.where((booking) => 
            booking["status"] == "Confirmed" || booking["status"] == "Upcoming").toList();
      } else {
        filtered = filtered.where((booking) => booking["status"] == statusFilter).toList();
      }
    }

    // Sort by date (newest first)
    filtered.sort((a, b) => DateTime.parse(b["date"]).compareTo(DateTime.parse(a["date"])));

    return filtered;
  }

  double _calculateAverageRating(List<Map<String, dynamic>> bookings) {
    var ratedBookings = bookings.where((booking) => booking["rating"] != null).toList();
    if (ratedBookings.isEmpty) return 0.0;
    
    double totalRating = ratedBookings.fold(0.0, (sum, booking) => sum + (booking["rating"] as double));
    return totalRating / ratedBookings.length;
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "Completed":
        return successColor;
      case "Confirmed":
      case "Upcoming":
        return primaryColor;
      case "Cancelled":
        return dangerColor;
      default:
        return disabledColor;
    }
  }

  IconData _getStatusIcon(String status) {
    switch (status) {
      case "Completed":
        return Icons.check_circle;
      case "Confirmed":
      case "Upcoming":
        return Icons.schedule;
      case "Cancelled":
        return Icons.cancel;
      default:
        return Icons.help;
    }
  }

  void _viewBookingDetails(Map<String, dynamic> booking) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("${booking["serviceName"]}"),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Booking ID: ${booking["id"]}"),
              SizedBox(height: spSm),
              Text("Provider: ${booking["providerName"]}"),
              Text("Date: ${DateTime.parse(booking["date"]).dMMMy}"),
              Text("Time: ${booking["time"]}"),
              Text("Duration: ${booking["duration"]}"),
              Text("Location: ${booking["location"]}"),
              Text("Price: \$${(booking["price"] as double).toStringAsFixed(2)}"),
              Text("Status: ${booking["status"]}"),
              if (booking["rating"] != null)
                Text("Rating: ${booking["rating"]}/5.0"),
              if (booking["feedback"].isNotEmpty) ...[
                SizedBox(height: spSm),
                Text("Feedback:"),
                Text("${booking["feedback"]}", style: TextStyle(fontStyle: FontStyle.italic)),
              ],
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Close"),
          ),
        ],
      ),
    );
  }

  void _rateService(Map<String, dynamic> booking) {
    double rating = 5.0;
    String feedback = "";

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Rate Service"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("How was your experience with ${booking["serviceName"]}?"),
            SizedBox(height: spMd),
            
            // Rating stars
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(5, (index) {
                return GestureDetector(
                  onTap: () {
                    rating = index + 1.0;
                    setState(() {});
                  },
                  child: Icon(
                    index < rating ? Icons.star : Icons.star_border,
                    color: warningColor,
                    size: 32,
                  ),
                );
              }),
            ),
            
            SizedBox(height: spMd),
            
            QMemoField(
              label: "Share your feedback (optional)",
              value: feedback,
              onChanged: (value) {
                feedback = value;
              },
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              // Update booking with rating
              booking["rating"] = rating;
              booking["feedback"] = feedback;
              setState(() {});
              Navigator.pop(context);
              ss("Thank you for your feedback!");
            },
            child: Text("Submit"),
          ),
        ],
      ),
    );
  }

  void _cancelBooking(Map<String, dynamic> booking) async {
    bool isConfirmed = await confirm("Are you sure you want to cancel this booking?");
    if (isConfirmed) {
      showLoading();
      
      Future.delayed(Duration(seconds: 1), () {
        hideLoading();
        
        // Update booking status
        booking["status"] = "Cancelled";
        setState(() {});
        
        ss("Booking cancelled successfully");
      });
    }
  }

  void _rebookService(Map<String, dynamic> booking) {
    ss("Redirecting to book ${booking["serviceName"]} again");
  }
}
