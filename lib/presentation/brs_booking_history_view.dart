import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class BrsBookingHistoryView extends StatefulWidget {
  const BrsBookingHistoryView({super.key});

  @override
  State<BrsBookingHistoryView> createState() => _BrsBookingHistoryViewState();
}

class _BrsBookingHistoryViewState extends State<BrsBookingHistoryView> {
  int currentTab = 0;
  String searchQuery = "";
  String selectedStatus = "all";
  String selectedPeriod = "all";

  final List<Map<String, dynamic>> statusOptions = [
    {"label": "All Status", "value": "all"},
    {"label": "Confirmed", "value": "confirmed"},
    {"label": "Completed", "value": "completed"},
    {"label": "Cancelled", "value": "cancelled"},
    {"label": "No Show", "value": "no_show"},
  ];

  final List<Map<String, dynamic>> periodOptions = [
    {"label": "All Time", "value": "all"},
    {"label": "This Week", "value": "week"},
    {"label": "This Month", "value": "month"},
    {"label": "Last 3 Months", "value": "quarter"},
    {"label": "This Year", "value": "year"},
  ];

  final List<Map<String, dynamic>> allBookings = [
    {
      "id": "BKG-2024-001",
      "date": "2024-06-20",
      "time": "2:30 PM",
      "barber": {
        "name": "Michael Rodriguez",
        "image": "https://picsum.photos/100/100?random=1&keyword=barber",
      },
      "services": ["Classic Haircut", "Beard Trim"],
      "totalPrice": 55.0,
      "duration": 75,
      "status": "confirmed",
      "location": "Downtown Barbershop",
      "createdAt": "2024-06-15",
    },
    {
      "id": "BKG-2024-002",
      "date": "2024-06-10",
      "time": "3:00 PM",
      "barber": {
        "name": "James Thompson",
        "image": "https://picsum.photos/100/100?random=2&keyword=hairdresser",
      },
      "services": ["Modern Style Cut"],
      "totalPrice": 40.0,
      "duration": 60,
      "status": "completed",
      "location": "Downtown Barbershop",
      "createdAt": "2024-06-08",
      "rating": 5.0,
      "review": "Excellent service! Very professional.",
    },
    {
      "id": "BKG-2024-003",
      "date": "2024-05-28",
      "time": "11:00 AM",
      "barber": {
        "name": "David Chen",
        "image": "https://picsum.photos/100/100?random=3&keyword=stylist",
      },
      "services": ["Hot Towel Shave", "Beard Styling"],
      "totalPrice": 65.0,
      "duration": 90,
      "status": "completed",
      "location": "Downtown Barbershop",
      "createdAt": "2024-05-25",
      "rating": 4.8,
      "review": "Amazing traditional shave experience!",
    },
    {
      "id": "BKG-2024-004",
      "date": "2024-05-15",
      "time": "4:30 PM",
      "barber": {
        "name": "Alex Johnson",
        "image": "https://picsum.photos/100/100?random=4&keyword=barber",
      },
      "services": ["Classic Haircut"],
      "totalPrice": 35.0,
      "duration": 45,
      "status": "cancelled",
      "location": "Downtown Barbershop",
      "createdAt": "2024-05-12",
      "cancelReason": "Personal emergency",
    },
    {
      "id": "BKG-2024-005",
      "date": "2024-04-22",
      "time": "1:15 PM",
      "barber": {
        "name": "Robert Martinez",
        "image": "https://picsum.photos/100/100?random=5&keyword=hair",
      },
      "services": ["Creative Cut", "Hair Color"],
      "totalPrice": 85.0,
      "duration": 120,
      "status": "no_show",
      "location": "Downtown Barbershop",
      "createdAt": "2024-04-20",
    },
  ];

  List<Map<String, dynamic>> get filteredBookings {
    return allBookings.where((booking) {
      // Search filter
      if (searchQuery.isNotEmpty) {
        final barberName = (booking["barber"]["name"] as String).toLowerCase();
        final services = (booking["services"] as List).join(" ").toLowerCase();
        final bookingId = (booking["id"] as String).toLowerCase();
        final query = searchQuery.toLowerCase();
        
        if (!barberName.contains(query) && 
            !services.contains(query) && 
            !bookingId.contains(query)) {
          return false;
        }
      }

      // Status filter
      if (selectedStatus != "all" && booking["status"] != selectedStatus) {
        return false;
      }

      // Period filter
      if (selectedPeriod != "all") {
        final bookingDate = DateTime.parse(booking["date"]);
        final now = DateTime.now();
        
        switch (selectedPeriod) {
          case "week":
            if (now.difference(bookingDate).inDays > 7) return false;
            break;
          case "month":
            if (bookingDate.month != now.month || bookingDate.year != now.year) return false;
            break;
          case "quarter":
            if (now.difference(bookingDate).inDays > 90) return false;
            break;
          case "year":
            if (bookingDate.year != now.year) return false;
            break;
        }
      }

      return true;
    }).toList();
  }

  List<Map<String, dynamic>> get upcomingBookings {
    final now = DateTime.now();
    return filteredBookings.where((booking) {
      final bookingDate = DateTime.parse(booking["date"]);
      return bookingDate.isAfter(now) && booking["status"] == "confirmed";
    }).toList();
  }

  List<Map<String, dynamic>> get pastBookings {
    final now = DateTime.now();
    return filteredBookings.where((booking) {
      final bookingDate = DateTime.parse(booking["date"]);
      return bookingDate.isBefore(now) || booking["status"] != "confirmed";
    }).toList();
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "confirmed":
        return successColor;
      case "completed":
        return primaryColor;
      case "cancelled":
        return warningColor;
      case "no_show":
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  IconData _getStatusIcon(String status) {
    switch (status) {
      case "confirmed":
        return Icons.check_circle;
      case "completed":
        return Icons.done_all;
      case "cancelled":
        return Icons.cancel;
      case "no_show":
        return Icons.error;
      default:
        return Icons.help;
    }
  }

  Widget _buildStarRating(double rating) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (index) {
        return Icon(
          index < rating.floor() ? Icons.star : 
          index < rating ? Icons.star_half : Icons.star_border,
          color: warningColor,
          size: 12,
        );
      }),
    );
  }

  Widget _buildBookingCard(Map<String, dynamic> booking) {
    final statusColor = _getStatusColor(booking["status"]);
    final statusIcon = _getStatusIcon(booking["status"]);
    final isPast = DateTime.parse(booking["date"]).isBefore(DateTime.now());

    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
        border: Border.all(color: statusColor.withAlpha(50)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          // Header with status and ID
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "${booking["id"]}",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: spSm,
                  vertical: spXs,
                ),
                decoration: BoxDecoration(
                  color: statusColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      statusIcon,
                      color: statusColor,
                      size: 12,
                    ),
                    SizedBox(width: spXs),
                    Text(
                      "${booking["status"]}".toUpperCase(),
                      style: TextStyle(
                        color: statusColor,
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          // Date and Time
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(10),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.calendar_today,
                  color: primaryColor,
                  size: 20,
                ),
                SizedBox(width: spSm),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${DateTime.parse(booking["date"]).dMMMy}",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "${booking["time"]} (${booking["duration"]} min)",
                      style: TextStyle(
                        color: primaryColor,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Barber and Services
          Row(
            spacing: spSm,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(radiusSm),
                child: Image.network(
                  "${booking["barber"]["image"]}",
                  width: 50,
                  height: 50,
                  fit: BoxFit.cover,
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spXs,
                  children: [
                    Text(
                      "${booking["barber"]["name"]}",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      (booking["services"] as List).join(", "),
                      style: TextStyle(
                        color: disabledBoldColor,
                        fontSize: 12,
                      ),
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.location_on,
                          color: disabledBoldColor,
                          size: 12,
                        ),
                        SizedBox(width: spXs),
                        Text(
                          "${booking["location"]}",
                          style: TextStyle(
                            color: disabledBoldColor,
                            fontSize: 11,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Text(
                "\$${(booking["totalPrice"] as double).toStringAsFixed(0)}",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: successColor,
                ),
              ),
            ],
          ),

          // Rating and Review (for completed bookings)
          if (booking["status"] == "completed" && booking.containsKey("rating")) ...[
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: warningColor.withAlpha(10),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spXs,
                children: [
                  Row(
                    children: [
                      _buildStarRating(booking["rating"] as double),
                      SizedBox(width: spXs),
                      Text(
                        "${booking["rating"]}",
                        style: TextStyle(
                          color: warningColor,
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                  if (booking.containsKey("review"))
                    Text(
                      "${booking["review"]}",
                      style: TextStyle(
                        color: disabledBoldColor,
                        fontSize: 11,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                ],
              ),
            ),
          ],

          // Cancel reason (for cancelled bookings)
          if (booking["status"] == "cancelled" && booking.containsKey("cancelReason")) ...[
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: warningColor.withAlpha(10),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.info,
                    color: warningColor,
                    size: 16,
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Text(
                      "Reason: ${booking["cancelReason"]}",
                      style: TextStyle(
                        color: warningColor,
                        fontSize: 11,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],

          // Action Buttons
          Row(
            spacing: spSm,
            children: [
              if (booking["status"] == "confirmed") ...[
                Expanded(
                  child: QButton(
                    label: "Modify",
                    size: bs.sm,
                    onPressed: () {
                      si("Opening booking modification...");
                    },
                  ),
                ),
                Expanded(
                  child: QButton(
                    label: "Cancel",
                    size: bs.sm,
                    onPressed: () async {
                      bool isConfirmed = await confirm("Cancel booking ${booking["id"]}?");
                      if (isConfirmed) {
                        sw("Booking cancellation initiated");
                      }
                    },
                  ),
                ),
              ] else if (booking["status"] == "completed") ...[
                Expanded(
                  child: QButton(
                    label: "Book Again",
                    size: bs.sm,
                    onPressed: () {
                      ss("Starting new booking with same services...");
                    },
                  ),
                ),
                if (!booking.containsKey("rating"))
                  Expanded(
                    child: QButton(
                      label: "Rate & Review",
                      size: bs.sm,
                      onPressed: () {
                        si("Opening rating form...");
                      },
                    ),
                  ),
              ] else ...[
                Expanded(
                  child: QButton(
                    label: "View Details",
                    size: bs.sm,
                    onPressed: () {
                      si("Opening booking details...");
                    },
                  ),
                ),
                Expanded(
                  child: QButton(
                    label: "Book Again",
                    size: bs.sm,
                    onPressed: () {
                      ss("Starting new booking...");
                    },
                  ),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Booking History"),
        actions: [
          QButton(
            icon: Icons.filter_list,
            size: bs.sm,
            onPressed: () {
              _showFilterBottomSheet();
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Search and Quick Stats
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [shadowSm],
            ),
            child: Column(
              spacing: spSm,
              children: [
                // Search Bar
                QTextField(
                  label: "Search bookings...",
                  value: searchQuery,
                  onChanged: (value) {
                    searchQuery = value;
                    setState(() {});
                  },
                ),

                // Quick Stats
                Row(
                  children: [
                    _buildStatCard("Total", "${allBookings.length}", primaryColor),
                    SizedBox(width: spSm),
                    _buildStatCard("Upcoming", "${upcomingBookings.length}", successColor),
                    SizedBox(width: spSm),
                    _buildStatCard("Completed", "${allBookings.where((b) => b["status"] == "completed").length}", infoColor),
                  ],
                ),
              ],
            ),
          ),

          // Tab Content
          Expanded(
            child: QTabBar(
              withoutAppBar: true,
              selectedIndex: currentTab,
              tabs: [
                Tab(text: "Upcoming", icon: Icon(Icons.schedule)),
                Tab(text: "Past", icon: Icon(Icons.history)),
                Tab(text: "All", icon: Icon(Icons.list)),
              ],
              tabChildren: [
                // Upcoming Bookings
                _buildBookingsList(upcomingBookings, "No upcoming bookings"),

                // Past Bookings
                _buildBookingsList(pastBookings, "No past bookings"),

                // All Bookings
                _buildBookingsList(filteredBookings, "No bookings found"),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(String label, String value, Color color) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(spSm),
        decoration: BoxDecoration(
          color: color.withAlpha(10),
          borderRadius: BorderRadius.circular(radiusSm),
        ),
        child: Column(
          children: [
            Text(
              value,
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            Text(
              label,
              style: TextStyle(
                color: color,
                fontSize: 11,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBookingsList(List<Map<String, dynamic>> bookings, String emptyMessage) {
    if (bookings.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.calendar_today,
              size: 60,
              color: disabledColor,
            ),
            SizedBox(height: spMd),
            Text(
              emptyMessage,
              style: TextStyle(
                fontSize: fsH6,
                color: disabledBoldColor,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              "Your bookings will appear here",
              style: TextStyle(
                color: disabledBoldColor,
                fontSize: 12,
              ),
            ),
            SizedBox(height: spMd),
            QButton(
              label: "Book Now",
              size: bs.md,
              onPressed: () {
                ss("Starting new booking...");
              },
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: EdgeInsets.all(spMd),
      itemCount: bookings.length,
      itemBuilder: (context, index) => _buildBookingCard(bookings[index]),
    );
  }

  void _showFilterBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        padding: EdgeInsets.all(spMd),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(radiusMd)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: spMd,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Filter Bookings",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                QButton(
                  label: "Clear All",
                  size: bs.sm,
                  onPressed: () {
                    selectedStatus = "all";
                    selectedPeriod = "all";
                    setState(() {});
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
            QDropdownField(
              label: "Status",
              items: statusOptions,
              value: selectedStatus,
              onChanged: (value, label) {
                selectedStatus = value;
                setState(() {});
              },
            ),
            QDropdownField(
              label: "Time Period",
              items: periodOptions,
              value: selectedPeriod,
              onChanged: (value, label) {
                selectedPeriod = value;
                setState(() {});
              },
            ),
            Container(
              width: double.infinity,
              child: QButton(
                label: "Apply Filters",
                size: bs.md,
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
